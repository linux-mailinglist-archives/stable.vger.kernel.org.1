Return-Path: <stable+bounces-245523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFSFJugkA2oF1AEAu9opvQ
	(envelope-from <stable+bounces-245523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:02:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC605209D3
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0730930AB726
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9710138889E;
	Tue, 12 May 2026 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="liixLDLE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AD13B810F
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590063; cv=none; b=SxgdZOiWx0w0VQQGgdZVRIr7bAGVtsETOEzjHyHYf/OyX4vmbEEd16ytVo8hPuHPkC1LBpJBrXT0XfyEWNVspI0VxTGylUNr+T4iKeaaL/01rroe4Hyh0C2xXg1+Z2fbRrLqW10ev1Q4yTF5n+7cgFhaamqO6MDMQqKMw5D4ONA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590063; c=relaxed/simple;
	bh=4g5CdjuWdGZNavWARciB/aEAZl50GoVhhDz9egei1D4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AaGn9dpPkklDn1rACIZhFtvxzOnGC4uLDshkIzuNvuJfyUiNDNtl3UfYqjIslfDl0rmhIvDJq34Zw6ttyVnYDnjfRigeqERpBSy8efg/JMJZMR/C1mkCGKJt6OySuWrj7OJHIoMesYVaFwa83Dd59BMi5uMAdS1sUJvaq+4MEko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=liixLDLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41995C2BCB0;
	Tue, 12 May 2026 12:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778590062;
	bh=4g5CdjuWdGZNavWARciB/aEAZl50GoVhhDz9egei1D4=;
	h=Subject:To:Cc:From:Date:From;
	b=liixLDLEb1UCNp7lX52ddUUxTrtnKVuGcDpwih/I6/JNnMdtFVWZRZkjoLO+4zHaP
	 K9zrXGt3tv1k4BLFRxPr/gm8LODxzdt2Bo3qBQX5ml260qjzdEOLRMYboHaxkYDG8c
	 2tNppZNiY17rCf+0O7+oMAalfS2AMZ+hbXq59rLg=
Subject: FAILED: patch "[PATCH] spi: ti-qspi: fix controller deregistration" failed to apply to 6.1-stable tree
To: johan@kernel.org,bigeasy@linutronix.de,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 14:46:15 +0200
Message-ID: <2026051215-exclusion-jargon-8c4e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EAC605209D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245523-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,msgid.link:url,gregkh:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0c18a1bacbb1d8b8aa34d3d004a2cb8226c8b1ea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051215-exclusion-jargon-8c4e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0c18a1bacbb1d8b8aa34d3d004a2cb8226c8b1ea Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:53 +0200
Subject: [PATCH] spi: ti-qspi: fix controller deregistration

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Note that the controller is suspended before disabling and releasing
resources since commit 3ac066e2227c ("spi: spi-ti-qspi: Suspend the
queue before removing the device") which avoids issues like unclocked
accesses but prevents SPI device drivers from doing I/O during
deregistration.

Fixes: 3b3a80019ff1 ("spi: ti-qspi: one only one interrupt handler")
Cc: stable@vger.kernel.org	# 3.13
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-24-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index d1d880a8ed7d..1fbd710d616f 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -888,7 +888,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	qspi->mmap_enabled = false;
 	qspi->current_cs = -1;
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (!ret)
 		return 0;
 
@@ -903,19 +903,17 @@ static int ti_qspi_probe(struct platform_device *pdev)
 static void ti_qspi_remove(struct platform_device *pdev)
 {
 	struct ti_qspi *qspi = platform_get_drvdata(pdev);
-	int rc;
 
-	rc = spi_controller_suspend(qspi->host);
-	if (rc) {
-		dev_alert(&pdev->dev, "spi_controller_suspend() failed (%pe)\n",
-			  ERR_PTR(rc));
-		return;
-	}
+	spi_controller_get(qspi->host);
+
+	spi_unregister_controller(qspi->host);
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	ti_qspi_dma_cleanup(qspi);
+
+	spi_controller_put(qspi->host);
 }
 
 static const struct dev_pm_ops ti_qspi_pm_ops = {


