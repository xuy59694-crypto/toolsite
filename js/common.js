// 免费在线工具箱 - 共享工具函数

function copyToClipboard(text) {
    if (navigator.clipboard) {
        navigator.clipboard.writeText(text).then(function() {
            showToast("已复制到剪贴板！");
        });
    } else {
        var ta = document.createElement("textarea");
        ta.value = text;
        ta.style.position = "fixed";
        ta.style.left = "-9999px";
        document.body.appendChild(ta);
        ta.select();
        document.execCommand("copy");
        document.body.removeChild(ta);
        showToast("已复制到剪贴板！");
    }
}

function showToast(msg) {
    var t = document.createElement("div");
    t.className = "toast";
    t.textContent = msg;
    t.style.cssText = "position:fixed;bottom:24px;left:50%;transform:translateX(-50%);background:#1e293b;color:#fff;padding:10px 24px;border-radius:8px;font-size:0.9rem;z-index:9999;animation:fadeInUp 0.3s ease;";
    document.body.appendChild(t);
    setTimeout(function() {
        t.style.opacity = "0";
        t.style.transition = "opacity 0.3s";
        setTimeout(function() { document.body.removeChild(t); }, 300);
    }, 2000);
}

function downloadFile(content, filename, mimeType) {
    var blob = new Blob([content], { type: mimeType || "text/plain" });
    var url = URL.createObjectURL(blob);
    var a = document.createElement("a");
    a.href = url;
    a.download = filename;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
}

// Add fadeInUp animation
var styleEl = document.createElement("style");
styleEl.textContent = "@keyframes fadeInUp{from{opacity:0;transform:translate(-50%,10px)}to{opacity:1;transform:translate(-50%,0)}}";
document.head.appendChild(styleEl);
