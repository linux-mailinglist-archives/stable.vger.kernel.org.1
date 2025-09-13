Return-Path: <stable+bounces-179501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4DAB561C3
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 17:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20692567273
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 15:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297912F0C62;
	Sat, 13 Sep 2025 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvhQNiLr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95B02DC76D;
	Sat, 13 Sep 2025 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757776759; cv=none; b=DvVC17AzHtEy8bOEQ6v8HaGrH57CDVCreEq1Z6Vqsd0LkYX3wYHOWJjsH+gGHJkTx5CWonCsTHCBHvlPy78ZxuArk3aIri6RxIas0YX3YCXmLQMKYdynw8a2RlbJSRqY58jyLrnQklcEzWBNgYHTeI9pQrEw4tjfHetmebQcE78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757776759; c=relaxed/simple;
	bh=3l1oTIkNxjy5OX16l6qHW4FBN6o/HIdlJKsNx/PnB8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlHgWaKEWYKAbdN5+a/9cFMrSEZ304fneyzVx8dszgWarzN/zsC0X2hTBC1JZEg8gOA99ljNzEuRNQqhKQxANU89ip79esYHz3dow5S/u36m/vr3/uGTa6JtuxH1UZ7xmjJGgQC+ZeFN7uS8/XiWyeASOQf3yOr8zVFS6QFKWq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvhQNiLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BF1C4CEEB;
	Sat, 13 Sep 2025 15:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757776759;
	bh=3l1oTIkNxjy5OX16l6qHW4FBN6o/HIdlJKsNx/PnB8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvhQNiLrokdSbX0zoE8wOEAUlZEhtvHh5Ejbk+iAGs3xhPdbMoHvRPoeT62QVW1+R
	 Ryq2MGV6Q1XhS5caliz+jZPSOOf9UJfofiFlMENHninWsoaLA/M+WCUsGKs5tlRUkX
	 Spx5L9f/WBNJXRe3q91dKnTkBEs4iDJdBqvx5IJOcz+ppe4UOwUPHasbRYVcmPEU5J
	 BEomchFqI8hUZOpncDK03NySvToKtUm2uqhq40jNDC/MGOkR8h3tX0GSVN5EioEXeC
	 Q5Jl2Zjmr06eRoG5MYMaaUWL78Syjaj1upYMboBkjcYXHIdCnwIxQ7WWC2fsHI4yn0
	 8NpFtDs5Jhliw==
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
Subject: [PATCH 5.10.y 1/2] mtd: rawnand: stm32_fmc2: Fix dma_map_sg error check
Date: Sat, 13 Sep 2025 11:19:11 -0400
Message-ID: <20250913151912.1412912-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091309-quote-graves-e875@gregkh>
References: <2025091309-quote-graves-e875@gregkh>
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
index c0c47f31c100d..9e535405e8b20 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -858,8 +858,8 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 
 	ret = dma_map_sg(nfc->dev, nfc->dma_data_sg.sgl,
 			 eccsteps, dma_data_dir);
-	if (ret < 0)
-		return ret;
+	if (!ret)
+		return -EIO;
 
 	desc_data = dmaengine_prep_slave_sg(dma_ch, nfc->dma_data_sg.sgl,
 					    eccsteps, dma_transfer_dir,
@@ -889,8 +889,10 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 
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


