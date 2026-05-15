Return-Path: <stable+bounces-247378-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK03KlqwBmrImgIAu9opvQ
	(envelope-from <stable+bounces-247378-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:34:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B8B54999A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBBD33041785
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F9F3093BB;
	Fri, 15 May 2026 05:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XUoTW7tD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0D63F4132
	for <stable@vger.kernel.org>; Fri, 15 May 2026 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823180; cv=none; b=UFGkDEjXrMrgjz18VaSJlywJTSMWYhe+xeq1I9D3tNqiEOe2IovLO0Nl9+KkaBMxNHwNJiSNWXjdBjoHh1iafaHq4J66kRCXwBvaroLEh5Sk6jRgKj+nRYbn2+HzbmyTsvxpqL6wN0Bz6Tx4TA6B2zEtfRtyBhxswqWwpBis2+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823180; c=relaxed/simple;
	bh=2+tCtjsn+gLUoL2BpgZDrI2Rr/dKL5nyU2DNFNgg+nM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tQfjqWFqtu6JEfCAaSJpBJe0uyukGjjtUDD3yuOF6VPLTOwdIPDfZH2qSS7NtZWpmrCq+ynyMZE2VfT/5HnVCpxuRVQ2Bpfpu/mj/JyHBXtq46+4WGKC6FC+eeI7U88f1gkkH4PRqajyo8pZVxkGAcFqqWlSqQM+zrdXmvDHP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XUoTW7tD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39821C2BCB0;
	Fri, 15 May 2026 05:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778823180;
	bh=2+tCtjsn+gLUoL2BpgZDrI2Rr/dKL5nyU2DNFNgg+nM=;
	h=Subject:To:Cc:From:Date:From;
	b=XUoTW7tD8MvAVEDFa4RhrZ+l9k5OMgajz6WSkbnuAL6jq/yt1a0IXQoK4m5NPGfT8
	 yWpJBaCAoL5JRVPcjFOBkara6r3nm0izxZr1R104emEtk2YlKqhNz1UPBS549dxXfU
	 BilPDaICXLfCf2mN0nBMMK2uum1KK3wEtD5mflAw=
Subject: FAILED: patch "[PATCH] spi: aspeed-smc: fix controller deregistration" failed to apply to 6.6-stable tree
To: johan@kernel.org,broonie@kernel.org,clg@kaod.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 07:33:04 +0200
Message-ID: <2026051504-colony-heap-88cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 03B8B54999A
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
	TAGGED_FROM(0.00)[bounces-247378-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,gregkh:email,kaod.org:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1044e5a4ccd57bf5a64f90100a321b498e0267a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051504-colony-heap-88cf@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


