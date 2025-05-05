Return-Path: <stable+bounces-141730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E19AAB608
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC3F3ADBBD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9C04AEA17;
	Tue,  6 May 2025 00:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQmZuTNR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363CE383E02;
	Mon,  5 May 2025 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487395; cv=none; b=AE86Ni8ViLZ11xbVQ2PsWvMKZ8nS5/WkwC915eMCsUWlIy1hWKtnluxUbiJ66Qdktkn8JsAzZArHv9N6Xo2OfLMD3gXz/Ftskj3QG4fWo5v9mC/dAezuBf0/S9ppmv5v/mOmY6l9LPNQfSnk32v+qNHt0lE+QQaQ63uO2HDatXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487395; c=relaxed/simple;
	bh=Vwyd7F4qJb3eY2kEEHniDIKr4zcGMId8rpyl8rytwE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hib+RxlXxGhsS1mg2Nh0+7HyYK0Zvt17gIrf4g/1KwpC5EM0BVPfqCMQfvBUoImkJfNBKpkFz8z01Y5BXqAaf5mlQ92l5+cD6Is4BD3MUAqZV1wVeTV0xKZ72xpKr9D51R58rthJv+PmYwaAyqmndjYELfDMU1L9RCOOmHkhPEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQmZuTNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC3FC4CEE4;
	Mon,  5 May 2025 23:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487394;
	bh=Vwyd7F4qJb3eY2kEEHniDIKr4zcGMId8rpyl8rytwE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CQmZuTNREqAczfFZzoIhl5KrJGsecTgKfO2XTNqqL84YqqimHEnU38rf0T7Pyimwt
	 4kYkCUsxt2pEV5wnzNEsb8eIUXM+mZQLcVyK7XdpGS8+d1MqkthhpKBDyifmOavQ2M
	 BTir8vkqSdeRO8LYD180RcQe06xeQmQDebuOPFcgsOaNWrvB18MrYDutcCiOpnY51x
	 TZmSpPLINU5Pt9lMIRiYci9MAaofWzbbr5Gaa3aEzT5uzv5NS/LMZ8kUL3/XelHb48
	 Ei98fhDh997Gt0L3hbIBi35evZ/QhiKR1Svxy4x4u/Khq5bkydxGuRIZjD384f6fN9
	 vYVonbtoRGCig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	kirill.shutemov@linux.intel.com,
	kai.huang@intel.com,
	pbonzini@redhat.com,
	peterz@infradead.org,
	brgerst@gmail.com
Subject: [PATCH AUTOSEL 5.4 45/79] x86/nmi: Add an emergency handler in nmi_desc & use it in nmi_shootdown_cpus()
Date: Mon,  5 May 2025 19:21:17 -0400
Message-Id: <20250505232151.2698893-45-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Waiman Long <longman@redhat.com>

[ Upstream commit fe37c699ae3eed6e02ee55fbf5cb9ceb7fcfd76c ]

Depending on the type of panics, it was found that the
__register_nmi_handler() function can be called in NMI context from
nmi_shootdown_cpus() leading to a lockdep splat:

  WARNING: inconsistent lock state
  inconsistent {INITIAL USE} -> {IN-NMI} usage.

   lock(&nmi_desc[0].lock);
   <Interrupt>
     lock(&nmi_desc[0].lock);

  Call Trace:
    _raw_spin_lock_irqsave
    __register_nmi_handler
    nmi_shootdown_cpus
    kdump_nmi_shootdown_cpus
    native_machine_crash_shutdown
    __crash_kexec

In this particular case, the following panic message was printed before:

  Kernel panic - not syncing: Fatal hardware error!

This message seemed to be given out from __ghes_panic() running in
NMI context.

The __register_nmi_handler() function which takes the nmi_desc lock
with irq disabled shouldn't be called from NMI context as this can
lead to deadlock.

The nmi_shootdown_cpus() function can only be invoked once. After the
first invocation, all other CPUs should be stuck in the newly added
crash_nmi_callback() and cannot respond to a second NMI.

Fix it by adding a new emergency NMI handler to the nmi_desc
structure and provide a new set_emergency_nmi_handler() helper to set
crash_nmi_callback() in any context. The new emergency handler will
preempt other handlers in the linked list. That will eliminate the need
to take any lock and serve the panic in NMI use case.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20250206191844.131700-1-longman@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/nmi.h |  2 ++
 arch/x86/kernel/nmi.c      | 42 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/reboot.c   | 10 +++------
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 9d5d949e662e1..dfb483c8c98b6 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -59,6 +59,8 @@ int __register_nmi_handler(unsigned int, struct nmiaction *);
 
 void unregister_nmi_handler(unsigned int, const char *);
 
+void set_emergency_nmi_handler(unsigned int type, nmi_handler_t handler);
+
 void stop_nmi(void);
 void restart_nmi(void);
 void local_touch_nmi(void);
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 5bb001c0c771a..d5c572bca8b1b 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -41,8 +41,12 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/nmi.h>
 
+/*
+ * An emergency handler can be set in any context including NMI
+ */
 struct nmi_desc {
 	raw_spinlock_t lock;
+	nmi_handler_t emerg_handler;
 	struct list_head head;
 };
 
@@ -124,9 +128,22 @@ static void nmi_check_duration(struct nmiaction *action, u64 duration)
 static int nmi_handle(unsigned int type, struct pt_regs *regs)
 {
 	struct nmi_desc *desc = nmi_to_desc(type);
+	nmi_handler_t ehandler;
 	struct nmiaction *a;
 	int handled=0;
 
+	/*
+	 * Call the emergency handler, if set
+	 *
+	 * In the case of crash_nmi_callback() emergency handler, it will
+	 * return in the case of the crashing CPU to enable it to complete
+	 * other necessary crashing actions ASAP. Other handlers in the
+	 * linked list won't need to be run.
+	 */
+	ehandler = desc->emerg_handler;
+	if (ehandler)
+		return ehandler(type, regs);
+
 	rcu_read_lock();
 
 	/*
@@ -212,6 +229,31 @@ void unregister_nmi_handler(unsigned int type, const char *name)
 }
 EXPORT_SYMBOL_GPL(unregister_nmi_handler);
 
+/**
+ * set_emergency_nmi_handler - Set emergency handler
+ * @type:    NMI type
+ * @handler: the emergency handler to be stored
+ *
+ * Set an emergency NMI handler which, if set, will preempt all the other
+ * handlers in the linked list. If a NULL handler is passed in, it will clear
+ * it. It is expected that concurrent calls to this function will not happen
+ * or the system is screwed beyond repair.
+ */
+void set_emergency_nmi_handler(unsigned int type, nmi_handler_t handler)
+{
+	struct nmi_desc *desc = nmi_to_desc(type);
+
+	if (WARN_ON_ONCE(desc->emerg_handler == handler))
+		return;
+	desc->emerg_handler = handler;
+
+	/*
+	 * Ensure the emergency handler is visible to other CPUs before
+	 * function return
+	 */
+	smp_wmb();
+}
+
 static void
 pci_serr_error(unsigned char reason, struct pt_regs *regs)
 {
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 6fede2f001042..17e378db513d2 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -875,15 +875,11 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 	shootdown_callback = callback;
 
 	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-	/* Would it be better to replace the trap vector here? */
-	if (register_nmi_handler(NMI_LOCAL, crash_nmi_callback,
-				 NMI_FLAG_FIRST, "crash"))
-		return;		/* Return what? */
+
 	/*
-	 * Ensure the new callback function is set before sending
-	 * out the NMI
+	 * Set emergency handler to preempt other handlers.
 	 */
-	wmb();
+	set_emergency_nmi_handler(NMI_LOCAL, crash_nmi_callback);
 
 	apic_send_IPI_allbutself(NMI_VECTOR);
 
-- 
2.39.5


