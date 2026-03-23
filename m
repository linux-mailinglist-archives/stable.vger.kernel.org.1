Return-Path: <stable+bounces-228406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L5iDLtSwWkPSQQAu9opvQ
	(envelope-from <stable+bounces-228406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:48:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4572F5381
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5137B31ABC7F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721193AC0C2;
	Mon, 23 Mar 2026 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aE7VGmSE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351B438C41E;
	Mon, 23 Mar 2026 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275029; cv=none; b=trKtTj8MpKTwBTdq89wEHiN8k7QaiWjhehuXPEIozZnz3JMghO/h/ds8vhvix59Z/9q/nAJ+hWHQkBpYpJv+qDXQsmg1Ny9DIZRIgc5BipR+15c9Gl2YffuhgsdXK6kt1tK6BogbWX8pjhFyKgOiWdoVdi99cBp8ZPXUgvHPiGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275029; c=relaxed/simple;
	bh=TNgZMf4ZCTNRKCnTUwJSc3DQ1nebD+m65kYayOq1wKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CG2uxwU82hRoHGbrv+QO84638lKexuaDYiF4TtMycBYuFl7LM/z+v7il+57g4EEPfh8GRgGt5tCDlkdsF5IuJbE+PcjyFfwz/Wu7u8wwHd4e+73SfpggHbXFCK5O0Y3M4Hlnya0YIqOY+Z9/+zxhbGWT75vLGfRi5ZXvi2sMKck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aE7VGmSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCAFC4CEF7;
	Mon, 23 Mar 2026 14:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275029;
	bh=TNgZMf4ZCTNRKCnTUwJSc3DQ1nebD+m65kYayOq1wKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aE7VGmSETxVvpCOzHPij+4zwvw/xO+gX3G055fqO/JvLIgOD3/bgj9+9dW/ofQBeb
	 1bwAXO7uYfkvpqZSbjto2/azDKPANLslNiR6Hh21sWf+V8zS4/RaGVDfAETgg4X/49
	 XyU+HY0kGJFfIzwvPjZmNSJLkyt6ki/ty0fy6Znw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 198/212] spi: amlogic: spifc-a4: Remove redundant clock cleanup
Date: Mon, 23 Mar 2026 14:46:59 +0100
Message-ID: <20260323134510.048600851@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228406-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8F4572F5381
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit a00da54d06f435dbbeacb84f9121dbbe6d6eda74 ]

The driver uses devm_clk_get_enabled() which enables the clock and
registers a callback to automatically disable it when the device
is unbound.

Remove the redundant aml_sfc_disable_clk() call in the error paths
and remove callback.

Fixes: 4670db6f32e9 ("spi: amlogic: add driver for Amlogic SPI Flash Controller")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Link: https://patch.msgid.link/20260308-spifc-a4-1-v1-1-77e286c26832@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-amlogic-spifc-a4.c | 46 +++++-------------------------
 1 file changed, 7 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a4.c b/drivers/spi/spi-amlogic-spifc-a4.c
index f324aa39a8976..b2589fe2425cc 100644
--- a/drivers/spi/spi-amlogic-spifc-a4.c
+++ b/drivers/spi/spi-amlogic-spifc-a4.c
@@ -1083,14 +1083,6 @@ static int aml_sfc_clk_init(struct aml_sfc *sfc)
 	return clk_set_rate(sfc->core_clk, SFC_BUS_DEFAULT_CLK);
 }
 
-static int aml_sfc_disable_clk(struct aml_sfc *sfc)
-{
-	clk_disable_unprepare(sfc->core_clk);
-	clk_disable_unprepare(sfc->gate_clk);
-
-	return 0;
-}
-
 static int aml_sfc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1141,16 +1133,12 @@ static int aml_sfc_probe(struct platform_device *pdev)
 
 	/* Enable Amlogic flash controller spi mode */
 	ret = regmap_write(sfc->regmap_base, SFC_SPI_CFG, SPI_MODE_EN);
-	if (ret) {
-		dev_err(dev, "failed to enable SPI mode\n");
-		goto err_out;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable SPI mode\n");
 
 	ret = dma_set_mask(sfc->dev, DMA_BIT_MASK(32));
-	if (ret) {
-		dev_err(sfc->dev, "failed to set dma mask\n");
-		goto err_out;
-	}
+	if (ret)
+		return dev_err_probe(sfc->dev, ret, "failed to set dma mask\n");
 
 	sfc->ecc_eng.dev = &pdev->dev;
 	sfc->ecc_eng.integration = NAND_ECC_ENGINE_INTEGRATION_PIPELINED;
@@ -1158,10 +1146,8 @@ static int aml_sfc_probe(struct platform_device *pdev)
 	sfc->ecc_eng.priv = sfc;
 
 	ret = nand_ecc_register_on_host_hw_engine(&sfc->ecc_eng);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register Aml host ecc engine.\n");
-		goto err_out;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to register Aml host ecc engine.\n");
 
 	ret = of_property_read_u32(np, "amlogic,rx-adj", &val);
 	if (!ret)
@@ -1177,24 +1163,7 @@ static int aml_sfc_probe(struct platform_device *pdev)
 	ctrl->min_speed_hz = SFC_MIN_FREQUENCY;
 	ctrl->num_chipselect = SFC_MAX_CS_NUM;
 
-	ret = devm_spi_register_controller(dev, ctrl);
-	if (ret)
-		goto err_out;
-
-	return 0;
-
-err_out:
-	aml_sfc_disable_clk(sfc);
-
-	return ret;
-}
-
-static void aml_sfc_remove(struct platform_device *pdev)
-{
-	struct spi_controller *ctlr = platform_get_drvdata(pdev);
-	struct aml_sfc *sfc = spi_controller_get_devdata(ctlr);
-
-	aml_sfc_disable_clk(sfc);
+	return devm_spi_register_controller(dev, ctrl);
 }
 
 static const struct of_device_id aml_sfc_of_match[] = {
@@ -1212,7 +1181,6 @@ static struct platform_driver aml_sfc_driver = {
 		.of_match_table = aml_sfc_of_match,
 	},
 	.probe = aml_sfc_probe,
-	.remove = aml_sfc_remove,
 };
 module_platform_driver(aml_sfc_driver);
 
-- 
2.51.0




