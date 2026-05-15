Return-Path: <stable+bounces-247504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Bp4MjLaBmrsoQIAu9opvQ
	(envelope-from <stable+bounces-247504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:32:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F0754B581
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80444308E622
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998753E51E1;
	Fri, 15 May 2026 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vvcF6s29"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3B53FCB09
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833794; cv=none; b=nOdLbjWS3LVdxh0xzGRRU6e/jGJviK/aMRLdw7OBp90yT73HJnKvs/KThA5+ZURg1l7wsg3KzmeDRCtwlKSldAbXJJ1lr27Er/dUABeO6863njg/SCKSuYra+jAC084eCSkSsH5J1FS5tp3f0AJBg6uVIRGJVDR/mpgF4wtDQzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833794; c=relaxed/simple;
	bh=01O5EyagEi26akilXT1KbCpu8qRmmQ+qDhawc4vm6NI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jGcfsvHUwOIgTQiCngwhtfwIEDHmlveMd0kJJ5lIznzc43bhC7gyu2yjAN42xICnG3QCxBhjt938a4Eyg+ekx9dSx2bB6HK7vMC29wDta1K708Yfc+pkJBNO3Pzvyd/Pj1gCCYaDPwrI8KNAFEXCtVpk8Leoo3PlgElbF2DGmYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vvcF6s29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE734C2BCB0;
	Fri, 15 May 2026 08:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833794;
	bh=01O5EyagEi26akilXT1KbCpu8qRmmQ+qDhawc4vm6NI=;
	h=Subject:To:Cc:From:Date:From;
	b=vvcF6s29bnCeg/x7erhzFzFsNaDHLJnOWL9tJcP/hkF6sQpuQz5Xl2nSIHgEkPkB1
	 qUbmInbGHuSUAns7PGcF/J4LOrGb+sJWK8er8aT5N3ZS19GyZ6yaeWtjAuTdtwkMQz
	 kOJvPCWvys0SXCLP0OO26S2w3SqWjcESl7MiUlMU=
Subject: FAILED: patch "[PATCH] spi: pic32-sqi: fix controller deregistration" failed to apply to 6.6-stable tree
To: johan@kernel.org,broonie@kernel.org,purna.mandal@microchip.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:29:22 +0200
Message-ID: <2026051521-skeletal-gory-0045@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 69F0754B581
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
	TAGGED_FROM(0.00)[bounces-247504-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 420df79d1a618951eb0eb4331df95c9f4f763b8b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051521-skeletal-gory-0045@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 420df79d1a618951eb0eb4331df95c9f4f763b8b Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:37 +0200
Subject: [PATCH] spi: pic32-sqi: fix controller deregistration

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: 3270ac230f66 ("spi: pic32-sqi: add SPI driver for PIC32 SQI controller.")
Cc: stable@vger.kernel.org	# 4.7
Cc: Purna Chandra Mandal <purna.mandal@microchip.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-8-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 051590038895..41662992dbe5 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -642,7 +642,7 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	host->prepare_transfer_hardware	= pic32_sqi_prepare_hardware;
 	host->unprepare_transfer_hardware	= pic32_sqi_unprepare_hardware;
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&host->dev, "failed registering spi host\n");
 		free_irq(sqi->irq, sqi);
@@ -665,9 +665,15 @@ static void pic32_sqi_remove(struct platform_device *pdev)
 {
 	struct pic32_sqi *sqi = platform_get_drvdata(pdev);
 
+	spi_controller_get(sqi->host);
+
+	spi_unregister_controller(sqi->host);
+
 	/* release resources */
 	free_irq(sqi->irq, sqi);
 	ring_desc_ring_free(sqi);
+
+	spi_controller_put(sqi->host);
 }
 
 static const struct of_device_id pic32_sqi_of_ids[] = {


