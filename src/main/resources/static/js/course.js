document.addEventListener("DOMContentLoaded", () => {
    const tbody = document.getElementById("course");
    if (!tbody) return;

    const rows = tbody.querySelectorAll("tr");
    const fetches = [];

    rows.forEach(row => {
        const courseId = row.dataset.courseId;
        const statusTd = row.querySelector(".status");
        if (!courseId || !statusTd) return;

        const p = fetch(`/course/take/${courseId}`)
            .then(res => {
                if (!res.ok) throw new Error("Network error");
                return res.json();
            })
            .then(data => {
                if (data && data.taken) {
                    statusTd.innerHTML = '<span class="badge badge-green">Enrolled</span>';
                } else {
                    renderTakeButton(statusTd, courseId);
                }
            })
            .catch(() => {
                statusTd.innerHTML = '<span class="badge badge-gray">Error</span>';
            });

        fetches.push(p);
    });

    Promise.all(fetches).then(() => {
        tbody.style.display = "";
    });
});

function renderTakeButton(container, courseId) {
    const btn = document.createElement("button");
    btn.textContent = "Enroll";
    btn.className = "btn btn-primary btn-sm";
    btn.onclick = () => takeCourse(courseId, container);
    container.innerHTML = "";
    container.appendChild(btn);
}

function takeCourse(courseId, statusTd) {
    const btn = statusTd.querySelector("button");
    if (btn) { btn.disabled = true; btn.textContent = "..."; }

    fetch(`/course/take/${courseId}`, { method: "POST" })
        .then(res => {
            if (res.ok || res.status === 200) {
                statusTd.innerHTML = '<span class="badge badge-green">Enrolled</span>';
            } else if (res.status === 401) {
                alert("Please log in first.");
                window.location.href = "/login";
            } else {
                throw new Error("Failed");
            }
        })
        .catch(() => {
            statusTd.innerHTML = "";
            renderTakeButton(statusTd, courseId);
        });
}
