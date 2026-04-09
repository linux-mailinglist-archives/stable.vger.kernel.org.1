Return-Path: <stable+bounces-235385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P3uEGyW12lNQAgAu9opvQ
	(envelope-from <stable+bounces-235385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:07:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C88D43CA1B9
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E7EC3049977
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 12:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F2B3BED1A;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pt8ZJ95q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826773921C9;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736326; cv=none; b=ZaebFLJ72bUxAVAk71U31AeGxMl9raIzxm24Aba5jdoJA6ThETRAav11kIii2sUsZ7w8OQCx5uOvh1WaSSsS2L/OtxNsw6B+Lb+z9Ikyak3+kXwIjfBYXnFG1HdY/FogLGaX45+YRidUNdbS5kISrXCHvzlIvT+PrqrKpqcAJGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736326; c=relaxed/simple;
	bh=FWI3aj2nBi83Z6I2499LKZlL2TKzZRfUYxr46TX+xA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrL+NoLAuSBcsXkp0pxmK8N8M1DIsNFhpJErqr84jjrBE1lAvBMwPifFq7Qvy7JmQcQ21S0/iaaviE+Q8hLeGHJjNyI6SOGFN3PzkyB2mBDDiGMikPn35atJSRT14rIMG4dAv0Mq/Es9Wx2HSuiEvZzNyZh5W/WBUL4uoRqo7eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pt8ZJ95q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48876C2BC87;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736326;
	bh=FWI3aj2nBi83Z6I2499LKZlL2TKzZRfUYxr46TX+xA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pt8ZJ95qvaGK1LGIs8QpqZ3rnUkxXI9cFR4ob3ttam0zlLk/WmY1eIaqqataEerXt
	 TJLKzgKHi9giEuYcFtaU+6bR2Tn6S7gEO5zYT2aQvT37kVYQWabRJlwR3eS3KslmJN
	 DVz2sKDVMpsUTCYMtzqxdKyp6+f9nrZIfI7qw2pnMYGuaQbULb2NJRZiTEBHvN0Bgh
	 dfb+PzUhRxaZuKnzuYynkCm9I29t5Y8pEDen/RXRcPz6HHROfm5tEa0cI8Se8ftC/1
	 hSTjnjNu8lD4rFuqoOt2rg6a6Kfg3SCUsG16OnbXXJiUbB5rLWkmG0Y2wXTHVdIyDA
	 1tldECda1saeA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAo8S-00000001d6p-00zQ;
	Thu, 09 Apr 2026 14:05:24 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 05/20] spi: bcm63xx: fix controller deregistration
Date: Thu,  9 Apr 2026 14:04:04 +0200
Message-ID: <20260409120419.388546-6-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409120419.388546-1-johan@kernel.org>
References: <20260409120419.388546-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amlogic.com,aspeedtech.com,kaod.org,upb.ro,broadcom.com,gmail.com,vger.kernel.org,kernel.org,openwrt.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235385-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C88D43CA1B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: b42dfed83d95 ("spi: add Broadcom BCM63xx SPI controller driver")
Cc: stable@vger.kernel.org	# 3.4
Cc: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-bcm63xx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 47266bb23a33..40cd7efc4b54 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -602,7 +602,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 
 	/* register and we are done */
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(dev, "spi register failed\n");
 		goto out_clk_disable;
@@ -625,11 +625,17 @@ static void bcm63xx_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct bcm63xx_spi *bs = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	/* reset spi block */
 	bcm_spi_writeb(bs, 0, SPI_INT_MASK);
 
 	/* HW shutdown */
 	clk_disable_unprepare(bs->clk);
+
+	spi_controller_put(host);
 }
 
 static int bcm63xx_spi_suspend(struct device *dev)
-- 
2.52.0


