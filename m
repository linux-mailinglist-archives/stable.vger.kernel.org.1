Return-Path: <stable+bounces-221950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ey5L5Cbo2l4IAUAu9opvQ
	(envelope-from <stable+bounces-221950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:51:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AD41CC069
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C31B3031F2F
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD122F3C19;
	Sun,  1 Mar 2026 01:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyhij3y4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F275A2820A9;
	Sun,  1 Mar 2026 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329536; cv=none; b=pQSxrmfzV34JmP4teuyDgY4/WHBQOWBpdd4t2H6ivssM4joRuohcN/Ly9Iygd9Zt4SR3aqS7y9tEuB7eLsVI5AVQ552tZC9vI8Y8Ni6eFRQKDeaTk0b7X3p0R1CxhV3GAMsFHtHJSMDHu0kb59hYrg762ffC3NxcHteyfT9+qzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329536; c=relaxed/simple;
	bh=lrE/g+c59BFKYoq7uC03dOsCIgAQOCcNtClDQV162+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HmF5lzbYcnXwYv524Md+q6Tuf2tfFWcYRU4K5bHxD4GcwQDjXU57UuJHyy/JJb+bR1h8oP0VQzrJAmqPjhXOxCTB7wX24q4IDERvZTRKRVyNsF2fk+jQnZrjaUDUwa7Q1pbgKAND6UWAc83FTHqMlsSP5tDrLQvuGLIriCUa9lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyhij3y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38239C19421;
	Sun,  1 Mar 2026 01:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329535;
	bh=lrE/g+c59BFKYoq7uC03dOsCIgAQOCcNtClDQV162+c=;
	h=From:To:Cc:Subject:Date:From;
	b=hyhij3y4XzWeibBb/V/p2LYOQKv0aPpBkhM8GBMfrMzBx9VPwCgc1nNdEXf4pGyvg
	 ruZXX2kHWkc5eT4CSGKLSY6LBxr1lfnzNzCTheP+xNb937FMsiBj1T4yIuvX374r5x
	 5hP3Icwm+q1Q9oO5S56Ej2QPs46fmx/hg+hgIQ4Pp4kw52uffOqRYKhxeakWwHXLpp
	 anYp70Aq9KDL5pRP/iclV3jOjPGeQ6Z+wG8o+Jp+w0zIsQnupS9TMNUpEGBHjUplbx
	 +NkdYhF27nJuLldurcpDdcQ/xAXZfSccT1alVDHGfqUP6npRGu2a7J+Cbu9AizaIo2
	 KlnhIlUE2EelA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	haokexin@gmail.com
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-omap@vger.kernel.org,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net: cpsw_new: Fix unnecessary netdev unregistration in cpsw_probe() error path" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:45:33 -0500
Message-ID: <20260301014534.1708199-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-221950-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75AD41CC069
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 62db84b7efa63b78aed9fdbdae90f198771be94c Mon Sep 17 00:00:00 2001
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 5 Feb 2026 10:47:02 +0800
Subject: [PATCH] net: cpsw_new: Fix unnecessary netdev unregistration in
 cpsw_probe() error path

The current error handling in cpsw_probe() has two issues:
- cpsw_unregister_ports() may be called before cpsw_register_ports() has
  been executed.

- cpsw_unregister_ports() is already invoked within cpsw_register_ports()
  in case of a register_netdev() failure, but the error path would call
  it again.

Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Link: https://patch.msgid.link/20260205-cpsw-error-path-v1-1-6e58bae6b299@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/ti/cpsw_new.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 21af0a10626aa..b9fc31eb06134 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -2003,7 +2003,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	/* setup netdevs */
 	ret = cpsw_create_ports(cpsw);
 	if (ret)
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 
 	/* Grab RX and TX IRQs. Note that we also have RX_THRESHOLD and
 	 * MISC IRQs which are always kept disabled with this driver so
@@ -2017,14 +2017,14 @@ static int cpsw_probe(struct platform_device *pdev)
 			       0, dev_name(dev), cpsw);
 	if (ret < 0) {
 		dev_err(dev, "error attaching irq (%d)\n", ret);
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 	}
 
 	ret = devm_request_irq(dev, cpsw->irqs_table[1], cpsw_tx_interrupt,
 			       0, dev_name(dev), cpsw);
 	if (ret < 0) {
 		dev_err(dev, "error attaching irq (%d)\n", ret);
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 	}
 
 	if (!cpsw->cpts)
@@ -2034,7 +2034,7 @@ static int cpsw_probe(struct platform_device *pdev)
 			       0, dev_name(&pdev->dev), cpsw);
 	if (ret < 0) {
 		dev_err(dev, "error attaching misc irq (%d)\n", ret);
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 	}
 
 	/* Enable misc CPTS evnt_pend IRQ */
@@ -2043,7 +2043,7 @@ static int cpsw_probe(struct platform_device *pdev)
 skip_cpts:
 	ret = cpsw_register_notifiers(cpsw);
 	if (ret)
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 
 	ret = cpsw_register_devlink(cpsw);
 	if (ret)
@@ -2065,8 +2065,6 @@ static int cpsw_probe(struct platform_device *pdev)
 
 clean_unregister_notifiers:
 	cpsw_unregister_notifiers(cpsw);
-clean_unregister_netdev:
-	cpsw_unregister_ports(cpsw);
 clean_cpts:
 	cpts_release(cpsw->cpts);
 	cpdma_ctlr_destroy(cpsw->dma);
-- 
2.51.0





