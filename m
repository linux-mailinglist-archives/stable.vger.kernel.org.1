Return-Path: <stable+bounces-188398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F51BF8094
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 20:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C57AB4E3D5A
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 18:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609053451DF;
	Tue, 21 Oct 2025 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="labh2VPw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA8134B67E
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071009; cv=none; b=ZsqR9lwUdS3rXq+TyXYKjxnW0cmEvOhqHmm98gbXmlp17x21XBcFDdXTSdeLHmrh0br64QjRsNGyCLBRaUZaVB3wsCzSPUPJldkpL8/jO4J66hWQ0RGNcPxdXpxs0G9SzcInMVUgWk8rSiM//1BmY/InimNVPuXmY2yA088jrd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071009; c=relaxed/simple;
	bh=iBBeO90pyUjcHVO1/U2Dkr6pMcIeBsKh5D3QJp8mX3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgnH6IQ1odFtDMDL1aqTdTJhzkw+IOKLA1ZYpZy8oCm7PDTbJkQQOlb/aNxMjSKdmUXN4kV/lUHnDiN3fB6RRKKZicMmrc9cRZNfAYxy8pH8f3N2xV/ik6QG/ZOYW9uy3RzW2F5AApUU6OthjYqZoTbsg8huPQERvGluBoh8Xxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=labh2VPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF7CC4CEF1;
	Tue, 21 Oct 2025 18:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761071008;
	bh=iBBeO90pyUjcHVO1/U2Dkr6pMcIeBsKh5D3QJp8mX3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=labh2VPwYhJHkJXc80tkol3tVOv/XV3KGjV/1CXn0hwN/s3JCQmaK0gPtmepN4X05
	 ndLwu1kKOZeG/qzKALOSUu0xo0IgPRfArTG8Igh1xlUPxzNbNCdp6L8i7TIi08C7tu
	 OQhBPyuK48VS9+hhI4QPTq/uDoa/w4CGSN+AXIdClb6HOCwmDz+SD5j/fbHiLL7O+h
	 UQHX1e2kPVEea+65pOTs2dCXACfjKdN0ihngdkzKGs+lzCEsqrbRJRUEylu4NB36ge
	 TPs/ifOcNokjR53EHqzc3oQ7wTbAYaF8QdMDDepLKPgl2yu2DiBeADngU0oyw2fONL
	 mB+gM7WevZxxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Santhosh Kumar K <s-k6@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] spi: cadence-quadspi: Flush posted register writes before INDAC access
Date: Tue, 21 Oct 2025 14:23:26 -0400
Message-ID: <20251021182326.2505523-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101621-blah-dyslexic-116b@gregkh>
References: <2025101621-blah-dyslexic-116b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Yadav <pratyush@kernel.org>

[ Upstream commit 29e0b471ccbd674d20d4bbddea1a51e7105212c5 ]

cqspi_indirect_read_execute() and cqspi_indirect_write_execute() first
set the enable bit on APB region and then start reading/writing to the
AHB region. On TI K3 SoCs these regions lie on different endpoints. This
means that the order of the two operations is not guaranteed, and they
might be reordered at the interconnect level.

It is possible for the AHB write to be executed before the APB write to
enable the indirect controller, causing the transaction to be invalid
and the write erroring out. Read back the APB region write before
accessing the AHB region to make sure the write got flushed and the race
condition is eliminated.

Fixes: 140623410536 ("mtd: spi-nor: Add driver for Cadence Quad SPI Flash Controller")
CC: stable@vger.kernel.org
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
Message-ID: <20250905185958.3575037-2-s-k6@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
[ applied changes to drivers/mtd/spi-nor/cadence-quadspi.c instead of drivers/spi/spi-cadence-quadspi.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/cadence-quadspi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 7bdc558d85601..2d6f008adb073 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -523,6 +523,7 @@ static int cqspi_indirect_read_execute(struct spi_nor *nor, u8 *rxbuf,
 	reinit_completion(&cqspi->transfer_complete);
 	writel(CQSPI_REG_INDIRECTRD_START_MASK,
 	       reg_base + CQSPI_REG_INDIRECTRD);
+	readl(reg_base + CQSPI_REG_INDIRECTRD); /* Flush posted write. */
 
 	while (remaining > 0) {
 		if (!wait_for_completion_timeout(&cqspi->transfer_complete,
@@ -633,6 +634,8 @@ static int cqspi_indirect_write_execute(struct spi_nor *nor, loff_t to_addr,
 	reinit_completion(&cqspi->transfer_complete);
 	writel(CQSPI_REG_INDIRECTWR_START_MASK,
 	       reg_base + CQSPI_REG_INDIRECTWR);
+	readl(reg_base + CQSPI_REG_INDIRECTWR); /* Flush posted write. */
+
 	/*
 	 * As per 66AK2G02 TRM SPRUHY8F section 11.15.5.3 Indirect Access
 	 * Controller programming sequence, couple of cycles of
-- 
2.51.0


