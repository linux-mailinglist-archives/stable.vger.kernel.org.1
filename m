Return-Path: <stable+bounces-4318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97738046FC
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE881C20D7E
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62E68BF1;
	Tue,  5 Dec 2023 03:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pz4l4h9N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943D66FB1;
	Tue,  5 Dec 2023 03:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA6DC433C8;
	Tue,  5 Dec 2023 03:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747220;
	bh=7aZqJopJDDcroIyECQnZxjtunXP4pM4M8I7q4ujqswI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pz4l4h9N7RtebcQysibMCdipk/A/a5SxbVS6vOhTysJ4yeuO6DSpk8Zk9iTL2NnkU
	 79ZLPsHoiNB/tISr0IbPiz5chYn77u6AH3nLgQASdELqgm+PSfhBsnwRN2ZCViYZRK
	 IUYuceDvNfUHAImdgVg6q93TUmfPOTVCAzBiuunQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Woodhouse <dwmw@amazon.co.uk>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 104/107] xen: Allow platform PCI interrupt to be shared
Date: Tue,  5 Dec 2023 12:17:19 +0900
Message-ID: <20231205031538.283030123@linuxfoundation.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

[ Upstream commit 3e8cd711c3da6c3d724076048038cd666bdbb2b5 ]

When we don't use the per-CPU vector callback, we ask Xen to deliver event
channel interrupts as INTx on the PCI platform device. As such, it can be
shared with INTx on other PCI devices.

Set IRQF_SHARED, and make it return IRQ_HANDLED or IRQ_NONE according to
whether the evtchn_upcall_pending flag was actually set. Now I can share
the interrupt:

 11:         82          0   IO-APIC  11-fasteoi   xen-platform-pci, ens4

Drop the IRQF_TRIGGER_RISING. It has no effect when the IRQ is shared,
and besides, the only effect it was having even beforehand was to trigger
a debug message in both I/OAPIC and legacy PIC cases:

[    0.915441] genirq: No set_type function for IRQ 11 (IO-APIC)
[    0.951939] genirq: No set_type function for IRQ 11 (XT-PIC)

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/f9a29a68d05668a3636dd09acd94d970269eaec6.camel@infradead.org
Signed-off-by: Juergen Gross <jgross@suse.com>
Stable-dep-of: db2832309a82 ("x86/xen: fix percpu vcpu_info allocation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/events/events_base.c | 9 ++++++---
 drivers/xen/platform-pci.c       | 5 ++---
 include/xen/events.h             | 2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index af9115d648092..014a83d016f59 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1710,9 +1710,10 @@ void handle_irq_for_port(evtchn_port_t port, struct evtchn_loop_ctrl *ctrl)
 	generic_handle_irq(irq);
 }
 
-static void __xen_evtchn_do_upcall(void)
+static int __xen_evtchn_do_upcall(void)
 {
 	struct vcpu_info *vcpu_info = __this_cpu_read(xen_vcpu);
+	int ret = vcpu_info->evtchn_upcall_pending ? IRQ_HANDLED : IRQ_NONE;
 	int cpu = smp_processor_id();
 	struct evtchn_loop_ctrl ctrl = { 0 };
 
@@ -1744,6 +1745,8 @@ static void __xen_evtchn_do_upcall(void)
 	 * above.
 	 */
 	__this_cpu_inc(irq_epoch);
+
+	return ret;
 }
 
 void xen_evtchn_do_upcall(struct pt_regs *regs)
@@ -1758,9 +1761,9 @@ void xen_evtchn_do_upcall(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
-void xen_hvm_evtchn_do_upcall(void)
+int xen_hvm_evtchn_do_upcall(void)
 {
-	__xen_evtchn_do_upcall();
+	return __xen_evtchn_do_upcall();
 }
 EXPORT_SYMBOL_GPL(xen_hvm_evtchn_do_upcall);
 
diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
index cd07e3fed0faf..fcc8191315723 100644
--- a/drivers/xen/platform-pci.c
+++ b/drivers/xen/platform-pci.c
@@ -64,14 +64,13 @@ static uint64_t get_callback_via(struct pci_dev *pdev)
 
 static irqreturn_t do_hvm_evtchn_intr(int irq, void *dev_id)
 {
-	xen_hvm_evtchn_do_upcall();
-	return IRQ_HANDLED;
+	return xen_hvm_evtchn_do_upcall();
 }
 
 static int xen_allocate_irq(struct pci_dev *pdev)
 {
 	return request_irq(pdev->irq, do_hvm_evtchn_intr,
-			IRQF_NOBALANCING | IRQF_TRIGGER_RISING,
+			IRQF_NOBALANCING | IRQF_SHARED,
 			"xen-platform-pci", pdev);
 }
 
diff --git a/include/xen/events.h b/include/xen/events.h
index 344081e71584b..44c2855c76d1f 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -107,7 +107,7 @@ evtchn_port_t evtchn_from_irq(unsigned irq);
 
 int xen_set_callback_via(uint64_t via);
 void xen_evtchn_do_upcall(struct pt_regs *regs);
-void xen_hvm_evtchn_do_upcall(void);
+int xen_hvm_evtchn_do_upcall(void);
 
 /* Bind a pirq for a physical interrupt to an irq. */
 int xen_bind_pirq_gsi_to_irq(unsigned gsi,
-- 
2.42.0




