Return-Path: <stable+bounces-4319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 905908046FD
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F981C20DE0
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D67079F2;
	Tue,  5 Dec 2023 03:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iKiCPbst"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB06FB1;
	Tue,  5 Dec 2023 03:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA82C433C8;
	Tue,  5 Dec 2023 03:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747223;
	bh=CGxAxDc2vmSdGknE4eP7eyk5HJBGEf9Ml4Z3cCgqZHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iKiCPbstTHiyRvQOfpG8y8PKiVwZerVT3UJTJdgGTDRXbtmV10Jby5cjStB5fO7g5
	 GUzPZ6Z+fa3RsxD4L5Ti+Ff58M8ZXOkvaW9xCpQxTR3GScs31iJcU7W0T9d2yEtPoY
	 3Lieo3GRZr1JIb7FXTXns5bCzHsEJHO4nmzdX728=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 105/107] xen: simplify evtchn_do_upcall() call maze
Date: Tue,  5 Dec 2023 12:17:20 +0900
Message-ID: <20231205031538.357144849@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031531.426872356@linuxfoundation.org>
References: <20231205031531.426872356@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

[ Upstream commit 37510dd566bdbff31a769cde2fa6654bccdb8b24 ]

There are several functions involved for performing the functionality
of evtchn_do_upcall():

- __xen_evtchn_do_upcall() doing the real work
- xen_hvm_evtchn_do_upcall() just being a wrapper for
  __xen_evtchn_do_upcall(), exposed for external callers
- xen_evtchn_do_upcall() calling __xen_evtchn_do_upcall(), too, but
  without any user

Simplify this maze by:

- removing the unused xen_evtchn_do_upcall()
- removing xen_hvm_evtchn_do_upcall() as the only left caller of
  __xen_evtchn_do_upcall(), while renaming __xen_evtchn_do_upcall() to
  xen_evtchn_do_upcall()

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Juergen Gross <jgross@suse.com>
Stable-dep-of: db2832309a82 ("x86/xen: fix percpu vcpu_info allocation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/xen/enlighten.c         |  2 +-
 arch/x86/entry/common.c          |  2 +-
 arch/x86/xen/enlighten.c         |  2 +-
 arch/x86/xen/enlighten_hvm.c     |  2 +-
 drivers/xen/events/events_base.c | 21 ++-------------------
 drivers/xen/platform-pci.c       |  2 +-
 include/xen/events.h             |  3 +--
 7 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index d12fdb9c05a89..eace3607fef41 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -204,7 +204,7 @@ static void xen_power_off(void)
 
 static irqreturn_t xen_arm_callback(int irq, void *arg)
 {
-	xen_hvm_evtchn_do_upcall();
+	xen_evtchn_do_upcall();
 	return IRQ_HANDLED;
 }
 
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6c2826417b337..93c60c0c9d4a7 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -294,7 +294,7 @@ static void __xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 
 	inc_irq_stat(irq_hv_callback_count);
 
-	xen_hvm_evtchn_do_upcall();
+	xen_evtchn_do_upcall();
 
 	set_irq_regs(old_regs);
 }
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index b8db2148c07d5..0337392a31214 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -32,7 +32,7 @@ EXPORT_SYMBOL_GPL(hypercall_page);
  * &HYPERVISOR_shared_info->vcpu_info[cpu]. See xen_hvm_init_shared_info
  * and xen_vcpu_setup for details. By default it points to share_info->vcpu_info
  * but during boot it is switched to point to xen_vcpu_info.
- * The pointer is used in __xen_evtchn_do_upcall to acknowledge pending events.
+ * The pointer is used in xen_evtchn_do_upcall to acknowledge pending events.
  */
 DEFINE_PER_CPU(struct vcpu_info *, xen_vcpu);
 DEFINE_PER_CPU(struct vcpu_info, xen_vcpu_info);
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index c1cd28e915a3a..c66807dd02703 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -136,7 +136,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_xen_hvm_callback)
 
 	inc_irq_stat(irq_hv_callback_count);
 
-	xen_hvm_evtchn_do_upcall();
+	xen_evtchn_do_upcall();
 
 	set_irq_regs(old_regs);
 }
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 014a83d016f59..00f8e349921d4 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1710,7 +1710,7 @@ void handle_irq_for_port(evtchn_port_t port, struct evtchn_loop_ctrl *ctrl)
 	generic_handle_irq(irq);
 }
 
-static int __xen_evtchn_do_upcall(void)
+int xen_evtchn_do_upcall(void)
 {
 	struct vcpu_info *vcpu_info = __this_cpu_read(xen_vcpu);
 	int ret = vcpu_info->evtchn_upcall_pending ? IRQ_HANDLED : IRQ_NONE;
@@ -1748,24 +1748,7 @@ static int __xen_evtchn_do_upcall(void)
 
 	return ret;
 }
-
-void xen_evtchn_do_upcall(struct pt_regs *regs)
-{
-	struct pt_regs *old_regs = set_irq_regs(regs);
-
-	irq_enter();
-
-	__xen_evtchn_do_upcall();
-
-	irq_exit();
-	set_irq_regs(old_regs);
-}
-
-int xen_hvm_evtchn_do_upcall(void)
-{
-	return __xen_evtchn_do_upcall();
-}
-EXPORT_SYMBOL_GPL(xen_hvm_evtchn_do_upcall);
+EXPORT_SYMBOL_GPL(xen_evtchn_do_upcall);
 
 /* Rebind a new event channel to an existing irq. */
 void rebind_evtchn_irq(evtchn_port_t evtchn, int irq)
diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
index fcc8191315723..544d3f9010b92 100644
--- a/drivers/xen/platform-pci.c
+++ b/drivers/xen/platform-pci.c
@@ -64,7 +64,7 @@ static uint64_t get_callback_via(struct pci_dev *pdev)
 
 static irqreturn_t do_hvm_evtchn_intr(int irq, void *dev_id)
 {
-	return xen_hvm_evtchn_do_upcall();
+	return xen_evtchn_do_upcall();
 }
 
 static int xen_allocate_irq(struct pci_dev *pdev)
diff --git a/include/xen/events.h b/include/xen/events.h
index 44c2855c76d1f..b303bd24e2a6c 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -106,8 +106,7 @@ int irq_from_virq(unsigned int cpu, unsigned int virq);
 evtchn_port_t evtchn_from_irq(unsigned irq);
 
 int xen_set_callback_via(uint64_t via);
-void xen_evtchn_do_upcall(struct pt_regs *regs);
-int xen_hvm_evtchn_do_upcall(void);
+int xen_evtchn_do_upcall(void);
 
 /* Bind a pirq for a physical interrupt to an irq. */
 int xen_bind_pirq_gsi_to_irq(unsigned gsi,
-- 
2.42.0




