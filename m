Return-Path: <stable+bounces-226089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0UJFEu1suWmNEwIAu9opvQ
	(envelope-from <stable+bounces-226089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:02:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 191E02AC9A9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6437B315AE29
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FD93E8C6D;
	Tue, 17 Mar 2026 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="djp6xTNq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C343E8C6C
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759010; cv=none; b=QnJkPUMOqlBYj+PHETfgfjyAHWari+Spq5zItlzAc8iXMELn/VSDFO8TwsRc9e2bmpMroP2sIdO0lu+rzbhxzTWn21GwXGWRyBioYo3GNRZCThJOlGyuvfEjWxr7CPTJyLhsNng79MgBF3w9FY8PgZWM9RacbD1vvl+o3PA4L0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759010; c=relaxed/simple;
	bh=BWvF1yMaeEXMbAYCH8Hy3euR3QbsgH37pLd/DzcdzQ8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YExDRCB8haKGBwmm5lawUSISlaefTNgKrTXFBwyqDEg0VixKWaHpzKK8hUHgZizLh3DRCLchiscy41WnZvaxwfgnQtR88vOLQwtoJc6NRiJlNiGcBl3HtIMpx4o1QhuaaUQoLJ1sDs9xit+UbADTlXJZeLs6qQBKNb0gjO/Lkkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=djp6xTNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619A9C4CEF7;
	Tue, 17 Mar 2026 14:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773759010;
	bh=BWvF1yMaeEXMbAYCH8Hy3euR3QbsgH37pLd/DzcdzQ8=;
	h=Subject:To:Cc:From:Date:From;
	b=djp6xTNqU7SZRLTQaGCl+rPiMCFyRO/bcOCuBQ8uUWXJPFeERe4lXfa2PR7iFGsIO
	 aKARged6yhFdnLmKRPv/O6vnxtj6ACR0hEHwZiDpAx2PSxl5Ccw6UUbHurmauKhmno
	 8p60huwex6f/y0gjPhG9V+cO4t7rvY2lBhPuMhzQ=
Subject: FAILED: patch "[PATCH] i3c: mipi-i3c-hci: Fix handling of shared IRQs during early" failed to apply to 6.19-stable tree
To: adrian.hunter@intel.com,Frank.Li@nxp.com,alexandre.belloni@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 15:48:52 +0100
Message-ID: <2026031752-asleep-lustiness-4387@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226089-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,nxp.com:email,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,gregkh:email,msgid.link:url]
X-Rspamd-Queue-Id: 191E02AC9A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.19.y
git checkout FETCH_HEAD
git cherry-pick -x c6396b835a5e599c4df656112140f065bb544a24
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031752-asleep-lustiness-4387@gregkh' --subject-prefix 'PATCH 6.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c6396b835a5e599c4df656112140f065bb544a24 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 6 Mar 2026 09:24:50 +0200
Subject: [PATCH] i3c: mipi-i3c-hci: Fix handling of shared IRQs during early
 initialization

Shared interrupts may fire unexpectedly, including during periods when the
controller is not yet fully initialized. Commit b9a15012a1452
("i3c: mipi-i3c-hci: Add optional Runtime PM support") addressed this issue
for the runtime-suspended state, but the same problem can also occur before
the bus is enabled for the first time.

Ensure the IRQ handler ignores interrupts until initialization is complete
by making consistent use of the existing irq_inactive flag.  The flag is
now set to false immediately before enabling the bus.

To guarantee correct ordering with respect to the IRQ handler, protect
all transitions of irq_inactive with the same spinlock used inside the
handler.

Fixes: b8460480f62e1 ("i3c: mipi-i3c-hci: Allow for Multi-Bus Instances")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260306072451.11131-14-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index b98952d12d7c..d5e91af7d569 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -152,6 +152,9 @@ static int i3c_hci_bus_init(struct i3c_master_controller *m)
 	if (hci->quirks & HCI_QUIRK_RESP_BUF_THLD)
 		amd_set_resp_buf_thld(hci);
 
+	scoped_guard(spinlock_irqsave, &hci->lock)
+		hci->irq_inactive = false;
+
 	/* Enable bus with Hot-Join disabled */
 	reg_set(HC_CONTROL, HC_CONTROL_BUS_ENABLE | HC_CONTROL_HOT_JOIN_CTRL);
 	dev_dbg(&hci->master.dev, "HC_CONTROL = %#x", reg_read(HC_CONTROL));
@@ -184,8 +187,9 @@ void i3c_hci_sync_irq_inactive(struct i3c_hci *hci)
 	int irq = platform_get_irq(pdev, 0);
 
 	reg_write(INTR_SIGNAL_ENABLE, 0x0);
-	hci->irq_inactive = true;
 	synchronize_irq(irq);
+	scoped_guard(spinlock_irqsave, &hci->lock)
+		hci->irq_inactive = true;
 }
 
 static void i3c_hci_bus_cleanup(struct i3c_master_controller *m)
@@ -781,10 +785,11 @@ static int i3c_hci_runtime_resume(struct device *dev)
 
 	mipi_i3c_hci_dat_v1.restore(hci);
 
-	hci->irq_inactive = false;
-
 	hci->io->resume(hci);
 
+	scoped_guard(spinlock_irqsave, &hci->lock)
+		hci->irq_inactive = false;
+
 	/* Enable bus with Hot-Join disabled */
 	reg_set(HC_CONTROL, HC_CONTROL_BUS_ENABLE | HC_CONTROL_HOT_JOIN_CTRL);
 
@@ -975,6 +980,8 @@ static int i3c_hci_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	hci->irq_inactive = true;
+
 	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(&pdev->dev, irq, i3c_hci_irq_handler,
 			       IRQF_SHARED, NULL, hci);


