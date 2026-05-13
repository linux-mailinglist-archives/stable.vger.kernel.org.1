Return-Path: <stable+bounces-247003-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PXLNMDCBGqiNgIAu9opvQ
	(envelope-from <stable+bounces-247003-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:28:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D831D538F29
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7213F307E7A3
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6153A426D;
	Wed, 13 May 2026 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7f2ma0M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719233321B1
	for <stable@vger.kernel.org>; Wed, 13 May 2026 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696420; cv=none; b=AIvq+6xBpwGGjrLvfXwaZ5k/eNFADOHpD4s11AR/FLrkfUwiEw0CyofsX4LOxxNFhohBr036rdQZQMVmdHHNcTNK0q9cqAhyVQe697yzGjKI64i0v9GfsyCP6yWOSTEqCNRZAa4W0NJBpLHoyfad4I76oVOUaXiHkdE6DY93ocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696420; c=relaxed/simple;
	bh=k+A3XGe4DD1TDW1raDZPq7f2VPyM7ZguS497eAmGGhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJ0ArN1hPK/nBFd7gD3n3SidltQcBiE1vg6PhS/7254iz1pvGwrloyBqPHv8/Sp6lYsmmteFIqGsSZHbAzWj48g9czy5WOMr+AZs58gyWGfCwywjsndZGRx5hsHiZk/H7xoRAZQzlppXaeE2+YHRqSXVvLob+p7mLBYBZvK50tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7f2ma0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E82DC2BCB7;
	Wed, 13 May 2026 18:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778696420;
	bh=k+A3XGe4DD1TDW1raDZPq7f2VPyM7ZguS497eAmGGhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7f2ma0MwTxDskdwV9/2xCEKyqlL0su3ZOyb0AcuvgkKloeIfD0ZhocLntP+MJeO8
	 leJyfApK9xVMzLe132EXRVdrEaAkw3otGZ8qIU7UsNVOfDy3hAxTFwFNZOm2pEzS6I
	 Kw3q9SMHuKIbr0j/J9xyXF2eAl+SGdDW8VmSqb5bT/FRJDOST/M4DpaN4+SfUFpQo3
	 rD+DI9SoIDaTXoSzh6H3QGamYp98jbmXdr44l/+oPKUg+U7TIycCLj7NOkaQlqBzSa
	 s5GayhlJz3xpARIgMYUuB9OFPWtbQetNi9w34yWv8rG3ddesfGITAMPF+5YZBDTFD0
	 bkpBP5crwSO7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] spi: Convert to SPI_CONTROLLER_HALF_DUPLEX
Date: Wed, 13 May 2026 14:20:14 -0400
Message-ID: <20260513182017.3918352-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051215-exclusion-jargon-8c4e@gregkh>
References: <2026051215-exclusion-jargon-8c4e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D831D538F29
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247003-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 7a2b552c8e0e5bb280558f6c120140f5f06323bc ]

Convert the users under SPI subsystem to SPI_CONTROLLER_HALF_DUPLEX.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230710154932.68377-15-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 0c18a1bacbb1 ("spi: ti-qspi: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-amd.c             | 2 +-
 drivers/spi/spi-cavium-thunderx.c | 2 +-
 drivers/spi/spi-falcon.c          | 2 +-
 drivers/spi/spi-lp8841-rtc.c      | 2 +-
 drivers/spi/spi-mxs.c             | 2 +-
 drivers/spi/spi-omap-uwire.c      | 2 +-
 drivers/spi/spi-pic32-sqi.c       | 2 +-
 drivers/spi/spi-qcom-qspi.c       | 2 +-
 drivers/spi/spi-rockchip-sfc.c    | 2 +-
 drivers/spi/spi-sprd-adi.c        | 2 +-
 drivers/spi/spi-ti-qspi.c         | 2 +-
 drivers/spi/spi-xcomm.c           | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index bfc3ab5f39eaa..357d46651f609 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -404,7 +404,7 @@ static int amd_spi_probe(struct platform_device *pdev)
 	master->bus_num = 0;
 	master->num_chipselect = 4;
 	master->mode_bits = 0;
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->max_speed_hz = AMD_SPI_MAX_HZ;
 	master->min_speed_hz = AMD_SPI_MIN_HZ;
 	master->setup = amd_spi_master_setup;
diff --git a/drivers/spi/spi-cavium-thunderx.c b/drivers/spi/spi-cavium-thunderx.c
index 60c0d69346540..535f7eb9fa69f 100644
--- a/drivers/spi/spi-cavium-thunderx.c
+++ b/drivers/spi/spi-cavium-thunderx.c
@@ -64,7 +64,7 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 		p->sys_freq = SYS_FREQ_DEFAULT;
 	dev_info(dev, "Set system clock to %u\n", p->sys_freq);
 
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->num_chipselect = 4;
 	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH |
 			    SPI_LSB_FIRST | SPI_3WIRE;
diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index a7d4dffac66b2..d4b78fbe03ba2 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -401,7 +401,7 @@ static int falcon_sflash_probe(struct platform_device *pdev)
 	priv->master = master;
 
 	master->mode_bits = SPI_MODE_3;
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->setup = falcon_sflash_setup;
 	master->transfer_one_message = falcon_sflash_xfer_one;
 	master->dev.of_node = pdev->dev.of_node;
diff --git a/drivers/spi/spi-lp8841-rtc.c b/drivers/spi/spi-lp8841-rtc.c
index 2d436541d6c2a..0a879bb5af20b 100644
--- a/drivers/spi/spi-lp8841-rtc.c
+++ b/drivers/spi/spi-lp8841-rtc.c
@@ -191,7 +191,7 @@ spi_lp8841_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, master);
 
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->mode_bits = SPI_CS_HIGH | SPI_3WIRE | SPI_LSB_FIRST;
 
 	master->bus_num = pdev->id;
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index b951bd5efdcd1..f474f62b61258 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -573,7 +573,7 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA;
 	master->num_chipselect = 3;
 	master->dev.of_node = np;
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->auto_runtime_pm = true;
 
 	spi = spi_master_get_devdata(master);
diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 29198e6815b23..f8f41f01680fc 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -491,7 +491,7 @@ static int uwire_probe(struct platform_device *pdev)
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 
 	master->bus_num = 2;	/* "official" */
 	master->num_chipselect = 4;
diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 86ad17597f5fd..5035b82d528c4 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -648,7 +648,7 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	master->dev.of_node	= pdev->dev.of_node;
 	master->mode_bits	= SPI_MODE_3 | SPI_MODE_0 | SPI_TX_DUAL |
 				  SPI_RX_DUAL | SPI_TX_QUAD | SPI_RX_QUAD;
-	master->flags		= SPI_MASTER_HALF_DUPLEX;
+	master->flags		= SPI_CONTROLLER_HALF_DUPLEX;
 	master->can_dma		= pic32_sqi_can_dma;
 	master->bits_per_word_mask	= SPI_BPW_RANGE_MASK(8, 32);
 	master->transfer_one_message	= pic32_sqi_one_message;
diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index c334dfec4117a..a6d5f287eddca 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -523,7 +523,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_MODE_0 |
 			    SPI_TX_DUAL | SPI_RX_DUAL |
 			    SPI_TX_QUAD | SPI_RX_QUAD;
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->prepare_message = qcom_qspi_prepare_message;
 	master->transfer_one = qcom_qspi_transfer_one;
 	master->handle_err = qcom_qspi_handle_err;
diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 69347b6bf60cd..f176b8a528b3d 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -566,7 +566,7 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->mem_ops = &rockchip_sfc_mem_ops;
 	master->dev.of_node = pdev->dev.of_node;
 	master->mode_bits = SPI_TX_QUAD | SPI_TX_DUAL | SPI_RX_QUAD | SPI_RX_DUAL;
diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 3e546cd87157b..3ea7615c064d2 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -570,7 +570,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->bus_num = pdev->id;
 	ctlr->num_chipselect = num_chipselect;
-	ctlr->flags = SPI_MASTER_HALF_DUPLEX;
+	ctlr->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	ctlr->bits_per_word_mask = 0;
 	ctlr->transfer_one = sprd_adi_transfer_one;
 
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 60086869bcae4..4c17b6ae5c967 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -770,7 +770,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD;
 
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->setup = ti_qspi_setup;
 	master->auto_runtime_pm = true;
 	master->transfer_one_message = ti_qspi_start_transfer_one;
diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index 1d9b3f03d986e..d0ebf4e7d46ec 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -219,7 +219,7 @@ static int spi_xcomm_probe(struct i2c_client *i2c,
 	master->num_chipselect = 16;
 	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_3WIRE;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->transfer_one_message = spi_xcomm_transfer_one;
 	master->dev.of_node = i2c->dev.of_node;
 	i2c_set_clientdata(i2c, master);
-- 
2.53.0


