Return-Path: <stable+bounces-147080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ED7AC5605
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2EE27B0254
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0EB27E7C1;
	Tue, 27 May 2025 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="grX14GJ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE87182D7;
	Tue, 27 May 2025 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366223; cv=none; b=i3PWal+czER1lCSsf5Letkh9egMeQbKwliIFV43v3Zgg99Rqnv44u35UR0GffQFCAaUHVEE3c92PE8gW35JaWHKsR5J98Ajed4e5QwSBI47yNH51wDxlQwEb6dZUDLqHZcHUDdtjgQ6zaSD2sNtCxgU2JtUsYy9joeAqu99knJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366223; c=relaxed/simple;
	bh=GCGR2c5BMOqr8MmWDAIF5G2vgMFvxjAuOxla8syNvag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cF7mkifmqv+c238f1TOZfT/NlJhKdwgrmrMrGVIAmUlJrWwDHzxZbPMUppvhCNEz3oavFFbNsp5XRO+mm0XQWBtK2Q9CxenGn7wYvkttXQ2UTxJkGyMG+I1zq7CVdXw2VBlVra7HMjve9agDygxbNExmhxytx3tiuAbzQSkTHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=grX14GJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4F6C4CEE9;
	Tue, 27 May 2025 17:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748366223;
	bh=GCGR2c5BMOqr8MmWDAIF5G2vgMFvxjAuOxla8syNvag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=grX14GJ9Sh5/BNLOcnxPwvx0Gg9llislUI2ENmHM6FEj2PbWUUW0y4bH2xbbtAyzo
	 CDeDS5rXI8VvFq9Hlrizas9EG1ZTWWf7QBuTbYd10ee84Rm//eQbRSO2XXUX1fh3/m
	 r16ZJa9/2GmgqzeYQiqe1YFiLyOJ3AsLyOpCoE3Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xulin Sun <xulin.sun@windriver.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	James Clark <james.clark@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 610/626] spi: spi-fsl-dspi: restrict register range for regmap access
Date: Tue, 27 May 2025 18:28:23 +0200
Message-ID: <20250527162509.786922962@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Larisa Grigore <larisa.grigore@nxp.com>

[ Upstream commit 283ae0c65e9c592f4a1ba4f31917f5e766da7f31 ]

DSPI registers are NOT continuous, some registers are reserved and
accessing them from userspace will trigger external abort, add regmap
register access table to avoid below abort.

  For example on S32G:

  # cat /sys/kernel/debug/regmap/401d8000.spi/registers

  Internal error: synchronous external abort: 96000210 1 PREEMPT SMP
  ...
  Call trace:
  regmap_mmio_read32le+0x24/0x48
  regmap_mmio_read+0x48/0x70
  _regmap_bus_reg_read+0x38/0x48
  _regmap_read+0x68/0x1b0
  regmap_read+0x50/0x78
  regmap_read_debugfs+0x120/0x338

Fixes: 1acbdeb92c87 ("spi/fsl-dspi: Convert to use regmap and add big-endian support")
Co-developed-by: Xulin Sun <xulin.sun@windriver.com>
Signed-off-by: Xulin Sun <xulin.sun@windriver.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
Link: https://patch.msgid.link/20250522-james-nxp-spi-v2-1-bea884630cfb@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 3fa990fb59c78..b8e7e6dbe0030 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 //
 // Copyright 2013 Freescale Semiconductor, Inc.
-// Copyright 2020 NXP
+// Copyright 2020-2025 NXP
 //
 // Freescale DSPI driver
 // This file contains a driver for the Freescale DSPI
@@ -1167,6 +1167,20 @@ static int dspi_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(dspi_pm, dspi_suspend, dspi_resume);
 
+static const struct regmap_range dspi_yes_ranges[] = {
+	regmap_reg_range(SPI_MCR, SPI_MCR),
+	regmap_reg_range(SPI_TCR, SPI_CTAR(3)),
+	regmap_reg_range(SPI_SR, SPI_TXFR3),
+	regmap_reg_range(SPI_RXFR0, SPI_RXFR3),
+	regmap_reg_range(SPI_CTARE(0), SPI_CTARE(3)),
+	regmap_reg_range(SPI_SREX, SPI_SREX),
+};
+
+static const struct regmap_access_table dspi_access_table = {
+	.yes_ranges	= dspi_yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(dspi_yes_ranges),
+};
+
 static const struct regmap_range dspi_volatile_ranges[] = {
 	regmap_reg_range(SPI_MCR, SPI_TCR),
 	regmap_reg_range(SPI_SR, SPI_SR),
@@ -1184,6 +1198,8 @@ static const struct regmap_config dspi_regmap_config = {
 	.reg_stride	= 4,
 	.max_register	= 0x88,
 	.volatile_table	= &dspi_volatile_table,
+	.rd_table	= &dspi_access_table,
+	.wr_table	= &dspi_access_table,
 };
 
 static const struct regmap_range dspi_xspi_volatile_ranges[] = {
@@ -1205,6 +1221,8 @@ static const struct regmap_config dspi_xspi_regmap_config[] = {
 		.reg_stride	= 4,
 		.max_register	= 0x13c,
 		.volatile_table	= &dspi_xspi_volatile_table,
+		.rd_table	= &dspi_access_table,
+		.wr_table	= &dspi_access_table,
 	},
 	{
 		.name		= "pushr",
-- 
2.39.5




