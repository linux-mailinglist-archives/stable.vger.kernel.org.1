Return-Path: <stable+bounces-141535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4413AAB448
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B42188A0C2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE347475A54;
	Tue,  6 May 2025 00:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLMhrAdr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3C02EC2B5;
	Mon,  5 May 2025 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486631; cv=none; b=MMLLCcbIN71kIJXMaq65HVp4YjaZZY1vZk/naMLMokoAfi9USbhYpdMWfu5EAgisWMB8+LKwj/d6rt9GP0Uz6QpYI2xJGmarbUVMF1OiPQ+b3agirXFq7AhnEUAGJY99SLxZtNBykUxeQU3EhZNKVaGSId770p8ZtHGpd4GWZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486631; c=relaxed/simple;
	bh=HKp18/hW1rSCsk+SbJZKYVsy/m629XbiP3MNjEMcVcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DF696jd7zC7YTAsRtYsDlm+ZnNLKtPuO0SPmrsfbwFgmZvl2sk0JDa6VTVdicy0GqDrYbN0sKVsuB1l6V+oXDAAKcrZ0K3kyVpZ8ykXczYve+sszFMivxZKNBNkJpedGHMifmkN6o+oep3TK4xH5n2wH7PDNpZdX96x8kuMiOfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLMhrAdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8FFC4CEE4;
	Mon,  5 May 2025 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486631;
	bh=HKp18/hW1rSCsk+SbJZKYVsy/m629XbiP3MNjEMcVcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CLMhrAdrMZzBCJVRaCpFM7eH93EkUyw26GmB/dHyMV/jL6uqeHsLxU2vUwBtn9pZB
	 feSvvm72i6wsOUZJq5DD9tnkU4CL9J55tVBG1ZwZ6kJ7IeuFBnBlkMy2P6epp27uKU
	 K/hsKtMwtWsi5pQsFM/vlH4ll7GBLVC9JB/F/1JPkUFyfRW0PZNaWGmwQeYez1Kern
	 b/w/wUJhh7uypPsHHGDJMtMgknsSPBpckE9Mfkg8geN0UgoGFJQbd/ucTsPtlK7C5Y
	 aAkVWt5/NK8NDKYQEgy+rR0I5Q0hh3mBEQJ/MwC6mTEEZJc3kU7fSZsM182g/sdYOb
	 pu9rA3wYkFCRg==
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
	brgerst@gmail.com,
	pbonzini@redhat.com,
	peterz@infradead.org
Subject: [PATCH AUTOSEL 6.1 125/212] x86/nmi: Add an emergency handler in nmi_desc & use it in nmi_shootdown_cpus()
Date: Mon,  5 May 2025 19:04:57 -0400
Message-Id: <20250505230624.2692522-125-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 5c5f1e56c4048..6f3d145670a95 100644
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
index ed6cce6c39504..b9a128546970f 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -38,8 +38,12 @@
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
 
@@ -121,9 +125,22 @@ static void nmi_check_duration(struct nmiaction *action, u64 duration)
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
@@ -213,6 +230,31 @@ void unregister_nmi_handler(unsigned int type, const char *name)
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
index 299b970e5f829..d9dbcd1cf75f8 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -896,15 +896,11 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
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


