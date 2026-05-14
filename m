Return-Path: <stable+bounces-247279-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULXjIA8aBmrGegIAu9opvQ
	(envelope-from <stable+bounces-247279-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 20:53:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF71E546120
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 20:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 741AD30861EE
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDC6391508;
	Thu, 14 May 2026 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDNlu1Ui"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E9A38F249
	for <stable@vger.kernel.org>; Thu, 14 May 2026 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784618; cv=none; b=QgEDLyQXXNQdWaFwWx0zu3ZTZCdyBNLeRCZikzj6cKPIewBKbVtWsPLJbTLRJpGTwUp+be0hlf1qgbBzp+LyGYUgl/VtKr3rzUwX8zNl5dYQBmTZN+GBEHYRvdl+e6YY9toewg18cHptyuHZY94M8VvX70+/cjiX7qDKyOIs5A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784618; c=relaxed/simple;
	bh=/GMNYDHXvhOnRud+C7bnHWFdX6n7IuqdEQE9Xx84cLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMnNZrNZEBBsf/I14FgBKtN6ZE1w8yPoK2OLC5iewKT704sbTbCPpB8p4P/I7ncu1UpBW7Z9W2t+Dh9Ql/ShqObNS7u0vfmQahTkV73q5eqWQmdmZ79q+RzKiDuRmTgZuQ0P2PFNVKAZvgpIlbBXAkuUD+/pmGPdjZnvIVUHI7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDNlu1Ui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3892AC2BCB7;
	Thu, 14 May 2026 18:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778784617;
	bh=/GMNYDHXvhOnRud+C7bnHWFdX6n7IuqdEQE9Xx84cLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDNlu1UiShqIVEPbXeyki7MyqfEUMpm/a4Dgfrd8ZvO9VXqSGC6VMJ9eotYFHn1Rd
	 SXcf4b4cjnEAUmjOf62nU17ydiHV2KCPzRORqCGeZ5ECEE8GxfMaAEUlOmixjPM7Xr
	 jPw+YW4ciYobHns7htadETiypW4Eev/kt5FNHXWcQU2Nwg9Bf34Ren1gnXW5wlNrZf
	 fND9x4UIoub20N502RwsgktF2Z0I1Qray37TmD33VAT2zeuqzrT6knSowkbRZgS2zO
	 jXc9pcBGZ08CLvdYDG+MTrHh3CQSAEatOGBHMSlJW70z98Qcx4J7VFZcTp+HBkUYd6
	 HxzOsjsIm4ISA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Zetao <lizetao1@huawei.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] spi: microchip-core-qspi: Use helper function devm_clk_get_enabled()
Date: Thu, 14 May 2026 14:50:13 -0400
Message-ID: <20260514185014.948789-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514185014.948789-1-sashal@kernel.org>
References: <2026051251-distaste-stardom-583e@gregkh>
 <20260514185014.948789-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF71E546120
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247279-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Action: no action

From: Li Zetao <lizetao1@huawei.com>

[ Upstream commit e922f3fff21445117e9196bd8e940ad8e15ca8c7 ]

Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
replaced by devm_clk_get_enabled() when driver enables (and possibly
prepares) the clocks for the whole lifetime of the device. Moreover, it is
no longer necessary to unprepare and disable the clocks explicitly.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Li Zetao <lizetao1@huawei.com>
Link: https://lore.kernel.org/r/20230823133938.1359106-18-lizetao1@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: e6464140d439 ("spi: microchip-core-qspi: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-microchip-core-qspi.c | 29 +++++++--------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index 32a0fa4ba50f7..0e44683d5ab5e 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -519,30 +519,23 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(qspi->regs),
 				     "failed to map registers\n");
 
-	qspi->clk = devm_clk_get(&pdev->dev, NULL);
+	qspi->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(qspi->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(qspi->clk),
 				     "could not get clock\n");
 
-	ret = clk_prepare_enable(qspi->clk);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "failed to enable clock\n");
-
 	init_completion(&qspi->data_completion);
 	mutex_init(&qspi->op_lock);
 
 	qspi->irq = platform_get_irq(pdev, 0);
-	if (qspi->irq < 0) {
-		ret = qspi->irq;
-		goto out;
-	}
+	if (qspi->irq < 0)
+		return qspi->irq;
 
 	ret = devm_request_irq(&pdev->dev, qspi->irq, mchp_coreqspi_isr,
 			       IRQF_SHARED, pdev->name, qspi);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq failed %d\n", ret);
-		goto out;
+		return ret;
 	}
 
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
@@ -553,18 +546,11 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 	ctlr->dev.of_node = np;
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
-	if (ret) {
-		dev_err_probe(&pdev->dev, ret,
-			      "spi_register_controller failed\n");
-		goto out;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "spi_register_controller failed\n");
 
 	return 0;
-
-out:
-	clk_disable_unprepare(qspi->clk);
-
-	return ret;
 }
 
 static void mchp_coreqspi_remove(struct platform_device *pdev)
@@ -575,7 +561,6 @@ static void mchp_coreqspi_remove(struct platform_device *pdev)
 	mchp_coreqspi_disable_ints(qspi);
 	control &= ~CONTROL_ENABLE;
 	writel_relaxed(control, qspi->regs + REG_CONTROL);
-	clk_disable_unprepare(qspi->clk);
 }
 
 static const struct of_device_id mchp_coreqspi_of_match[] = {
-- 
2.53.0


