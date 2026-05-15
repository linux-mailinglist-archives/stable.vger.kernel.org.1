Return-Path: <stable+bounces-247458-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFB9MDXOBmpjoAIAu9opvQ
	(envelope-from <stable+bounces-247458-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:41:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE74254ABED
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 125493010506
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AC43D332C;
	Fri, 15 May 2026 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XonEY1gF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145A73E025B
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830811; cv=none; b=FelpIGyj3ch2dtdZsII9RrOQLZhPw6I9UNjlqsEqQpKMvHXP73W++bhEcz4sgAi7Oz0lhZUDaF8SDp7CYONczvdL4C+eAE87b9F8+DQLKNqKgW+HCAYKtiRYRKwNIHPPz5F02UzmdGyiHiI9www8xczguTrYKw8SVKEm6kaNdXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830811; c=relaxed/simple;
	bh=eSeQ5flEItqpKEJ2/fLchUL9fHZ8sTMT72b1aFf8qCY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wq9CYbgoeGpDJDml+kGegMCiE1sBq6xnrEiKivvc1Iruajc7hPx3qAf6eOVQ2q69S4aGPTqq7QY3rD8a8/hWGiGzrOnLG0/mps6zfZCrqxhGrRnzm03bZ499rzkimefYsUv/d5VB/tN7wmeAxj0k0xh35TPSrzAQRpPHCJz6ci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XonEY1gF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49381C2BCB0;
	Fri, 15 May 2026 07:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778830810;
	bh=eSeQ5flEItqpKEJ2/fLchUL9fHZ8sTMT72b1aFf8qCY=;
	h=Subject:To:Cc:From:Date:From;
	b=XonEY1gFONWVuNAjLljuQHNpohqq7+xxLa3xgbw5WLMyQDioUNjFMmIMxv7q3rMQ/
	 mbcqJdEepKci6bVGjPoGfVCw3hbPcGYoz2JWVqKAge/3RABcGrTb5v/yShnSzg90A6
	 5ixuBgkY+obkqj8EpiqrRX0Kn6y/vrKhfh5b6sTM=
Subject: FAILED: patch "[PATCH] spi: ep93xx: fix controller deregistration" failed to apply to 6.12-stable tree
To: johan@kernel.org,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 09:40:06 +0200
Message-ID: <2026051506-abacus-trembling-8a5b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BE74254ABED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247458-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f4838934b695a58eda0833583cb8028e73a19529
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051506-abacus-trembling-8a5b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f4838934b695a58eda0833583cb8028e73a19529 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 9 Apr 2026 14:04:11 +0200
Subject: [PATCH] spi: ep93xx: fix controller deregistration

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: 011f23a3c2f2 ("spi/ep93xx: implemented driver for Cirrus EP93xx SPI controller")
Cc: stable@vger.kernel.org	# 2.6.35
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-13-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 90d5f3ea6508..db50018050e5 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -689,7 +689,7 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	/* make sure that the hardware is disabled */
 	writel(0, espi->mmio + SSPCR1);
 
-	error = devm_spi_register_controller(&pdev->dev, host);
+	error = spi_register_controller(host);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register SPI host\n");
 		goto fail_free_dma;
@@ -713,7 +713,13 @@ static void ep93xx_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct ep93xx_spi *espi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	ep93xx_spi_release_dma(espi);
+
+	spi_controller_put(host);
 }
 
 static const struct of_device_id ep93xx_spi_of_ids[] = {


