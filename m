Return-Path: <stable+bounces-226088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIIgENdruWl6EgIAu9opvQ
	(envelope-from <stable+bounces-226088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:57:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C7B2AC810
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86872314BD1F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF413E5ED6;
	Tue, 17 Mar 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FcHzD5iP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E194F3E3D81
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759006; cv=none; b=q+VZEu4BCp2CrlZZ2ORQUfPcn97/6RLsEZSiCgTeJO2DG9UMr+/S4RUsHMhaQQID2qAkrzkM7WcrtajbSaOOb/36+1aNYckkLCRMZoFrBOwuLfHnUTH1FzID9zqV3gSbqVOSFfuTgFtCuU9MUGIPk4lH+slj4Ivfxj36a/l/Prs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759006; c=relaxed/simple;
	bh=N938jC9wHKnx8YZXNHFa2rSs+lJE7rzd+61e0Cr1PYw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PVbu0cxTQwEoPIoedRT2yRwn+vf8UEqp0VresQONHPNCmP49pKFrCzutw6qP0+yhjnhgUBooO2cCiJo6aFrwtMpmfUwnHjVjwUcbglD31HDsYRcXJ2OEgHXLq0PaziEfFtXWQ6eeGKnZLiV7nuIe4b2QvPZbs90mbZsBZ+HeFfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FcHzD5iP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A172C4CEF7;
	Tue, 17 Mar 2026 14:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773759005;
	bh=N938jC9wHKnx8YZXNHFa2rSs+lJE7rzd+61e0Cr1PYw=;
	h=Subject:To:Cc:From:Date:From;
	b=FcHzD5iPl4JRC6j9scncL0O5/Cjppoi8XcTXp+b3TRyJyC0ipZFs4u1PWpxC64spB
	 b61OBUwLj/kXNCUawgNwpvmdfCgB6awD6wJ3WMAIeaPCmAE7IDsnvC2l1Zy2+45zjF
	 JoVTjH+DdQVFLIaYd45ZYAYAbE6Zpz+LP9G+KOug=
Subject: FAILED: patch "[PATCH] i3c: mipi-i3c-hci: Fallback to software reset when bus" failed to apply to 5.15-stable tree
To: adrian.hunter@intel.com,Frank.Li@nxp.com,alexandre.belloni@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 15:48:50 +0100
Message-ID: <2026031750-zodiac-shush-192a@gregkh>
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
	TAGGED_FROM(0.00)[bounces-226088-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.958];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,nxp.com:email,bootlin.com:email]
X-Rspamd-Queue-Id: A9C7B2AC810
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9a258d1336f7ff3add8b92d566d3a421f03bf4d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031750-zodiac-shush-192a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9a258d1336f7ff3add8b92d566d3a421f03bf4d2 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 6 Mar 2026 09:24:51 +0200
Subject: [PATCH] i3c: mipi-i3c-hci: Fallback to software reset when bus
 disable fails

Disruption of the MIPI I3C HCI controller's internal state can cause
i3c_hci_bus_disable() to fail when attempting to shut down the bus.

In the code paths where bus disable is invoked - bus clean-up and runtime
suspend - the controller does not need to remain operational afterward, so
a full controller reset is a safe recovery mechanism.

Add a fallback to issue a software reset when disabling the bus fails.
This ensures the bus is reliably halted even if the controller's state
machine is stuck or unresponsive.

The fallback is used both during bus clean-up and in the runtime suspend
path.  In the latter case, ensure interrupts are quiesced after reset.

Fixes: 9ad9a52cce282 ("i3c/master: introduce the mipi-i3c-hci driver")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260306072451.11131-15-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index d5e91af7d569..284f3ed7af8c 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -181,6 +181,34 @@ static int i3c_hci_bus_disable(struct i3c_hci *hci)
 	return ret;
 }
 
+static int i3c_hci_software_reset(struct i3c_hci *hci)
+{
+	u32 regval;
+	int ret;
+
+	/*
+	 * SOFT_RST must be clear before we write to it.
+	 * Then we must wait until it clears again.
+	 */
+	ret = readx_poll_timeout(reg_read, RESET_CONTROL, regval,
+				 !(regval & SOFT_RST), 0, 10 * USEC_PER_MSEC);
+	if (ret) {
+		dev_err(&hci->master.dev, "%s: Software reset stuck\n", __func__);
+		return ret;
+	}
+
+	reg_write(RESET_CONTROL, SOFT_RST);
+
+	ret = readx_poll_timeout(reg_read, RESET_CONTROL, regval,
+				 !(regval & SOFT_RST), 0, 10 * USEC_PER_MSEC);
+	if (ret) {
+		dev_err(&hci->master.dev, "%s: Software reset failed\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+
 void i3c_hci_sync_irq_inactive(struct i3c_hci *hci)
 {
 	struct platform_device *pdev = to_platform_device(hci->master.dev.parent);
@@ -196,7 +224,8 @@ static void i3c_hci_bus_cleanup(struct i3c_master_controller *m)
 {
 	struct i3c_hci *hci = to_i3c_hci(m);
 
-	i3c_hci_bus_disable(hci);
+	if (i3c_hci_bus_disable(hci))
+		i3c_hci_software_reset(hci);
 	hci->io->cleanup(hci);
 }
 
@@ -626,34 +655,6 @@ static irqreturn_t i3c_hci_irq_handler(int irq, void *dev_id)
 	return result;
 }
 
-static int i3c_hci_software_reset(struct i3c_hci *hci)
-{
-	u32 regval;
-	int ret;
-
-	/*
-	 * SOFT_RST must be clear before we write to it.
-	 * Then we must wait until it clears again.
-	 */
-	ret = readx_poll_timeout(reg_read, RESET_CONTROL, regval,
-				 !(regval & SOFT_RST), 0, 10 * USEC_PER_MSEC);
-	if (ret) {
-		dev_err(&hci->master.dev, "%s: Software reset stuck\n", __func__);
-		return ret;
-	}
-
-	reg_write(RESET_CONTROL, SOFT_RST);
-
-	ret = readx_poll_timeout(reg_read, RESET_CONTROL, regval,
-				 !(regval & SOFT_RST), 0, 10 * USEC_PER_MSEC);
-	if (ret) {
-		dev_err(&hci->master.dev, "%s: Software reset failed\n", __func__);
-		return ret;
-	}
-
-	return 0;
-}
-
 static inline bool is_version_1_1_or_newer(struct i3c_hci *hci)
 {
 	return hci->version_major > 1 || (hci->version_major == 1 && hci->version_minor > 0);
@@ -764,8 +765,12 @@ static int i3c_hci_runtime_suspend(struct device *dev)
 	int ret;
 
 	ret = i3c_hci_bus_disable(hci);
-	if (ret)
+	if (ret) {
+		/* Fall back to software reset to disable the bus */
+		ret = i3c_hci_software_reset(hci);
+		i3c_hci_sync_irq_inactive(hci);
 		return ret;
+	}
 
 	hci->io->suspend(hci);
 


