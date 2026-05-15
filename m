Return-Path: <stable+bounces-247379-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJhFAGCwBmrImgIAu9opvQ
	(envelope-from <stable+bounces-247379-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:34:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEE95499A1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8237304410C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355213093BB;
	Fri, 15 May 2026 05:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SCEHC0M5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9F43F4132
	for <stable@vger.kernel.org>; Fri, 15 May 2026 05:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823189; cv=none; b=D0u/61gs6JpAJJZblFGd8jEQLWMZGj2KeObk5kh1sXObosaDw/PgaBB9bwkBFD+LxowvNQN5NFMM0HIDjWs6Ua7ANFdl3nU4AIUtrn2TsJDQqOOHRooYyvDXEv1bA5IVnmqC1im5w/1CZZ42jQXCDBHIG3BRYZXXV1anPFN1k/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823189; c=relaxed/simple;
	bh=QJjWgZimY6sHEEyWNjrAzM1RX1vKJZVK5ucDejFmyUs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eZz7+4YzlmpNTS0WV2TWpXDt0f+7Qn6y16cPKy7QIgnugNVzRyZnJt5mywnrUk59rvMIApq0+g6ZyTlDkIp7ltMOdIFrKsQ4UT1o+wvQYRecFYiahmmY4URY5kHJ7z+bWwR/MorChhQ2eY4PTZRn2I3ZFYqI73GcdHnC5SPrsrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SCEHC0M5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824DEC2BCB0;
	Fri, 15 May 2026 05:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778823188;
	bh=QJjWgZimY6sHEEyWNjrAzM1RX1vKJZVK5ucDejFmyUs=;
	h=Subject:To:Cc:From:Date:From;
	b=SCEHC0M5mVBTtOvo5qg7FJNqzmJ1wbSBybullhz3ISS0ylHCdjp9C0duy0XHv04Cf
	 kupu0BWA5/v+uwZBN2WLMGUsPDywCufBlw2HaWHauELR84ECZpZSCF1Z3vAUyhpY0v
	 Ey5lYi+oP7DZ5OMSYzrLtA34edPVF/dmnSsLSpl4=
Subject: FAILED: patch "[PATCH] spi: aspeed-smc: fix controller deregistration" failed to apply to 5.15-stable tree
To: johan@kernel.org,broonie@kernel.org,clg@kaod.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 07:33:05 +0200
Message-ID: <2026051505-padlock-overbuilt-a6db@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4EEE95499A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247379-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kaod.org:email,msgid.link:url,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1044e5a4ccd57bf5a64f90100a321b498e0267a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051505-padlock-overbuilt-a6db@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1044e5a4ccd57bf5a64f90100a321b498e0267a2 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 9 Apr 2026 14:04:01 +0200
Subject: [PATCH] spi: aspeed-smc: fix controller deregistration
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make sure to deregister the controller before disabling it to allow
SPI device drivers to do I/O during deregistration.

Fixes: e3228ed92893 ("spi: spi-mem: Convert Aspeed SMC driver to spi-mem")
Cc: stable@vger.kernel.org	# 5.19
Cc: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-3-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 9c286e534bf0..c21323e07d3c 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -972,7 +972,7 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	aspi = spi_controller_get_devdata(ctlr);
-	platform_set_drvdata(pdev, aspi);
+	platform_set_drvdata(pdev, ctlr);
 	aspi->data = data;
 	aspi->dev = dev;
 
@@ -1021,7 +1021,7 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_spi_register_controller(dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret)
 		dev_err(&pdev->dev, "spi_register_controller failed\n");
 
@@ -1030,7 +1030,10 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 
 static void aspeed_spi_remove(struct platform_device *pdev)
 {
-	struct aspeed_spi *aspi = platform_get_drvdata(pdev);
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct aspeed_spi *aspi = spi_controller_get_devdata(ctlr);
+
+	spi_unregister_controller(ctlr);
 
 	aspeed_spi_enable(aspi, false);
 }


