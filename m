Return-Path: <stable+bounces-179495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3CFB561B4
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 17:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4501B2768F
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 15:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7122C2EF64C;
	Sat, 13 Sep 2025 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpZ4Xk/0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AD42DC775;
	Sat, 13 Sep 2025 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757776165; cv=none; b=RIb6ooBt2I9Ox1ehMeB8+oPeIGhTxF6UkSxeyWPYeN16veW62RFYH661FUZTaJmkIM4snL3L7QkvMBNKUfJXl7kuAVnauQ0R44ISpVIDnsRaglnGS5tFzWk6LSAgPKQpyfRvrDiuZAE4Z8usSP2C9OsrRhezcWpZTTZbQoHqr6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757776165; c=relaxed/simple;
	bh=k3JGm7bgPzqa31QJZlMPgghHEp9L20SNijx437wsPug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwiC2yrp1US2ExMsbmhJXHY5ldtCVUBNryF98Qqa2wJuaPj8JEEKFCaTKkbjAvA7/qkvtx8ljA9x9By8/uyKJS7iP0Fnn2XUyOfrIlgPAYmIY3Un5jfa0QZ5eWHSbEkIIDjS99nDUrQdZwhlMwk6jXQSSSvIif6GLKPtCM+NRpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpZ4Xk/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBA7C4CEEB;
	Sat, 13 Sep 2025 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757776164;
	bh=k3JGm7bgPzqa31QJZlMPgghHEp9L20SNijx437wsPug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qpZ4Xk/0h6acPs74zvOc1NFJ5Jxq3AutOs0wqXl+ci/YlJMKz2qsZ7wQfDFyBvrJR
	 lC9m1DO0QpsyefA0jSIkWLuo+iQ23zEINuTRDSaA1wtEGdp6toKAFNpCnyx76DKAhD
	 8f473nFSEKygwdbTVRQ0yekLJhvrj8dr+zl3mSM/vCPVo8VKdCw6DL3fxtRtA0Ft0O
	 3o7r2ZJ6ajL9TTnimHNSCKl+54t5yx7wumR8QHAEnrT7lZ+4gP4THT1Lemj0kp4sYs
	 VpZOpFhwL/9ivY///QFf3eH7S3btU6e6wo+/NHtYm2A6W/cokalzFhnWNbMK1RbWrt
	 hCobJgwcrm+kQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jack Wang <jinpu.wang@ionos.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christophe Kerello <christophe.kerello@foss.st.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	linux-mtd@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] mtd: rawnand: stm32_fmc2: Fix dma_map_sg error check
Date: Sat, 13 Sep 2025 11:09:16 -0400
Message-ID: <20250913150917.1408380-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091308-trio-unedited-6b17@gregkh>
References: <2025091308-trio-unedited-6b17@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wang <jinpu.wang@ionos.com>

[ Upstream commit 43b81c2a3e6e07915151045aa13a6e8a9bd64419 ]

dma_map_sg return 0 on error, in case of error return -EIO.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Christophe Kerello <christophe.kerello@foss.st.com>
Cc: Cai Huoqing <cai.huoqing@linux.dev>
Cc: linux-mtd@lists.infradead.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Christophe Kerello <christophe.kerello@foss.st.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20220819060801.10443-5-jinpu.wang@ionos.com
Stable-dep-of: 513c40e59d5a ("mtd: rawnand: stm32_fmc2: avoid overlapping mappings on ECC buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 1ac8c4887ce03..a65ee2d3c1b3a 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -860,8 +860,8 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 
 	ret = dma_map_sg(nfc->dev, nfc->dma_data_sg.sgl,
 			 eccsteps, dma_data_dir);
-	if (ret < 0)
-		return ret;
+	if (!ret)
+		return -EIO;
 
 	desc_data = dmaengine_prep_slave_sg(dma_ch, nfc->dma_data_sg.sgl,
 					    eccsteps, dma_transfer_dir,
@@ -891,8 +891,10 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 
 		ret = dma_map_sg(nfc->dev, nfc->dma_ecc_sg.sgl,
 				 eccsteps, dma_data_dir);
-		if (ret < 0)
+		if (!ret) {
+			ret = -EIO;
 			goto err_unmap_data;
+		}
 
 		desc_ecc = dmaengine_prep_slave_sg(nfc->dma_ecc_ch,
 						   nfc->dma_ecc_sg.sgl,
-- 
2.51.0


