Return-Path: <stable+bounces-247869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ8lNeFBB2oCvAIAu9opvQ
	(envelope-from <stable+bounces-247869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:55:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC9555279B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F262C303D372
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7884517C220;
	Fri, 15 May 2026 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K74Xw0vX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350B13FF1DE;
	Fri, 15 May 2026 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860281; cv=none; b=RElZ9M8ci4NLMiiN93kl/PUr0xfrXtzS6Nhr5tFxa2lpa8pROyUN7RauMym0DprK8P7vj+B8Obd5lsekh3VgNo8ZVIY5NtGkqFLj8bkVjd4e/25rsEBbAWbChHqpHhBGXNH8DgP9LqCNxqeXyEdAB8Z9TikMjGEF51qXw6AJpHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860281; c=relaxed/simple;
	bh=WjafgHJW0zut6JgazDykr9ewT6VKrROIq5Nc0MSY4Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jm8cAbYHUaYUlJ7dllE8486FUXiXoxIoaKl6YeKjV8b4VF0wESSLpXyOii88vQlMk/+Dy5+1qY5mUAi3N7kwPpjDeW3lsqqizIqZH+0mf9l4t8CR8PZztr1CE95uLCQ2TPjUQmgbK1rZ1c2fUa0bc+bpU0y4XUcMb149xE1Hqqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K74Xw0vX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3B1C2BCB0;
	Fri, 15 May 2026 15:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860281;
	bh=WjafgHJW0zut6JgazDykr9ewT6VKrROIq5Nc0MSY4Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K74Xw0vXwubCUhgq8vLe3B7js2J1qC8U59030GhQlGQf+wk8dMNzHJtndQbU7qbn1
	 W0EM1N1JGZQA07MWJyuYsoJ0p5k/IKjrJ/IDeFenXIltsM0W3Z/qv5/7MPf4P/F8o2
	 WLp/g2Fy1y3/ElDwCMxJGS+EGfZLJyIq8FnZUeJI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 029/144] spi: aspeed-smc: fix controller deregistration
Date: Fri, 15 May 2026 17:47:35 +0200
Message-ID: <20260515154654.184157578@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154653.469907118@linuxfoundation.org>
References: <20260515154653.469907118@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6EC9555279B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247869-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 1044e5a4ccd57bf5a64f90100a321b498e0267a2 upstream.

Make sure to deregister the controller before disabling it to allow
SPI device drivers to do I/O during deregistration.

Fixes: e3228ed92893 ("spi: spi-mem: Convert Aspeed SMC driver to spi-mem")
Cc: stable@vger.kernel.org	# 5.19
Cc: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-3-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-aspeed-smc.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -733,7 +733,7 @@ static int aspeed_spi_probe(struct platf
 		return -ENOMEM;
 
 	aspi = spi_controller_get_devdata(ctlr);
-	platform_set_drvdata(pdev, aspi);
+	platform_set_drvdata(pdev, ctlr);
 	aspi->data = data;
 	aspi->dev = dev;
 
@@ -772,7 +772,7 @@ static int aspeed_spi_probe(struct platf
 	ctlr->num_chipselect = data->max_cs;
 	ctlr->dev.of_node = dev->of_node;
 
-	ret = devm_spi_register_controller(dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret)
 		dev_err(&pdev->dev, "spi_register_controller failed\n");
 
@@ -781,7 +781,10 @@ static int aspeed_spi_probe(struct platf
 
 static void aspeed_spi_remove(struct platform_device *pdev)
 {
-	struct aspeed_spi *aspi = platform_get_drvdata(pdev);
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct aspeed_spi *aspi = spi_controller_get_devdata(ctlr);
+
+	spi_unregister_controller(ctlr);
 
 	aspeed_spi_enable(aspi, false);
 }



