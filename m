Return-Path: <stable+bounces-250018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMM6G7fbDWpN4QUAu9opvQ
	(envelope-from <stable+bounces-250018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:05:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B89355916E7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4437E324268C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD483F0767;
	Wed, 20 May 2026 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USDuTsSk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C143F20E3
	for <stable@vger.kernel.org>; Wed, 20 May 2026 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290652; cv=none; b=oduPZPpXOk3Ur5yLt3YGVL3wtexh/L/ac+yacITsk1RzxJoUqUg09L/pm4stixyOuO2RCxKSFI3fbztMtUffefVM728WmfeRqCPoRMirpOVWh1m8jp6GPJh9y8X3QOF23Cj9l7s0Jho+Ps5tcuvpbNwBHg8WQfeP9Ef+kbKaCtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290652; c=relaxed/simple;
	bh=Tssskg72px5KsiFIuozQi7gkY6qm94ehHHujFtp+OC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIwRUUBWxVy87bPcx7nedSTkmkQzdzOpBjou7iQw4xdi7n5HrlFipSL2O31OqgP7kjX76Z+csaeU45qpEYaNplNnrSSWo3hAE+tfY39EFH5BdymW9FPW+D21YGQQya04H2CEvM+6JEDPDOz4QtZgfHMVAfM7+qFS8PfLO8wmmqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USDuTsSk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40411F000E9;
	Wed, 20 May 2026 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779290651;
	bh=7w+/K7orD263fNV3KBNmTTwV0N8Ytj/lefA+p1Qqpyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=USDuTsSkTqg1dkh9XSSaza9NbUHqCC4SH2RlkMYuob58Cd9bL6TE+xrEcQq57vCVj
	 du05VU4jph04jcN1HkYJPBYcMINmN4p5kkfpp34lveHnofOdyo0neo3aYQ7fvGyzhj
	 WJCzBo1Hr26r6OpapiA5uOroYiGcpSwZKdnF3uobNFh01okh/S6boecNCTBWeemvqc
	 N+J5cGtUF3Czva52fK2AX//T3Qcln5WBCbfVi16Z8fvRl5myZu0Byp9xVCF9WIb8pf
	 v55MY0FTFQf2qHoaHuU4wjM8XgvldzlqwTdUDiPIQunb+Tz1xHVcN0Ag2JICkmBiVE
	 Fp4pHLNbbK8Gg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] spi: lantiq-ssc: fix controller deregistration
Date: Wed, 20 May 2026 11:24:08 -0400
Message-ID: <20260520152408.3943826-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051543-footprint-reveler-3f33@gregkh>
References: <2026051543-footprint-reveler-3f33@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250018-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B89355916E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johan Hovold <johan@kernel.org>

[ Upstream commit b99206710d032c16b7f8b75e4bc18414d8e4b9f4 ]

Make sure to deregister the controller before releasing underlying
resources like clocks during driver unbind.

Fixes: 17f84b793c01 ("spi: lantiq-ssc: add support for Lantiq SSC SPI controller")
Cc: stable@vger.kernel.org	# 4.11
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-17-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
[ adapted spi_controller/host naming to spi_master/master and preserved the int-returning remove() with trailing return 0 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-lantiq-ssc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index bcb52601804a9..e09e54b02dc0f 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -1003,7 +1003,7 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 		"Lantiq SSC SPI controller (Rev %i, TXFS %u, RXFS %u, DMA %u)\n",
 		revision, spi->tx_fifo_size, spi->rx_fifo_size, supports_dma);
 
-	err = devm_spi_register_master(dev, master);
+	err = spi_register_master(master);
 	if (err) {
 		dev_err(dev, "failed to register spi_master\n");
 		goto err_wq_destroy;
@@ -1027,6 +1027,10 @@ static int lantiq_ssc_remove(struct platform_device *pdev)
 {
 	struct lantiq_ssc_spi *spi = platform_get_drvdata(pdev);
 
+	spi_master_get(spi->master);
+
+	spi_unregister_master(spi->master);
+
 	lantiq_ssc_writel(spi, 0, LTQ_SPI_IRNEN);
 	lantiq_ssc_writel(spi, 0, LTQ_SPI_CLC);
 	rx_fifo_flush(spi);
@@ -1037,6 +1041,8 @@ static int lantiq_ssc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(spi->spi_clk);
 	clk_put(spi->fpi_clk);
 
+	spi_master_put(spi->master);
+
 	return 0;
 }
 
-- 
2.53.0


