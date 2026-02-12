document.addEventListener('DOMContentLoaded', () => {
    const openGameBtn = document.getElementById('open-game');
    const switches = document.querySelectorAll('input[type="checkbox"]');

    // Manejar el botón de abrir Bloodstrike
    openGameBtn.addEventListener('click', () => {
        // Intentar abrir por esquema de URL (común en apps móviles)
        // Bloodstrike suele usar esquemas específicos, aquí intentamos el más probable
        window.location.href = "bloodstrike://";
        
        // Feedback visual
        openGameBtn.textContent = "ABRIENDO...";
        setTimeout(() => {
            openGameBtn.textContent = "ABRIR BLOODSTRIKE";
        }, 3000);
    });

    // Guardar estado de los switches (opcional, para persistencia local)
    switches.forEach(sw => {
        sw.addEventListener('change', (e) => {
            const id = e.target.id;
            const isChecked = e.target.checked;
            console.log(`${id} está ahora: ${isChecked ? 'Activado' : 'Desactivado'}`);
            
            // Aquí podrías añadir lógica para CORS o peticiones externas si fuera necesario
        });
    });
});
