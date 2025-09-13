Return-Path: <stable+bounces-179508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7DFB5622F
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 18:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700585803EA
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 16:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57EB2C21F0;
	Sat, 13 Sep 2025 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQvXE677"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43851DD0D4
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757780033; cv=none; b=XryYBHzIIEFSMHKw9yo8tC49bXRfhk4zeaIcywYCwDElhTHldWzyzJVb5Rn3MlQXnDMygvS7A8pydCWHl20Gn3fe7jpQEcmhHmy5MQQQTow7BoiIM6a1toDIG0KhfnFeA7aECaBQ85ol1FDQfi76SnzilZXLPsLmJ+ztKWlTWJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757780033; c=relaxed/simple;
	bh=Q0FAkzExqDIsBM2ycy+Jn3dXdVKSI1xAAd5JwKYjQ0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wao1NnmsrxaHKpkFtJ2xApYhBaIe9jXM1RhgJBXx2+enbZk3ErojfjXB8T+I+51VBfox02mHas2D4qAUPKEH15oh6ypZGLTTQdiDxjasN9bNqA1D1fgsJKAxS9769/KwTtR+e9WvFnGpxKWfWbZmFjWnnxRJnk46Eb4/zfHqiEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQvXE677; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF824C4CEEB;
	Sat, 13 Sep 2025 16:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757780033;
	bh=Q0FAkzExqDIsBM2ycy+Jn3dXdVKSI1xAAd5JwKYjQ0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQvXE677SAzI5FClbOlbyyvv5Sj2M7MAv5/KxsVzYTXlqTEh2zsW6jn4yLh3D4HBF
	 Hi+EQEMYOujZKaQp1OkHZOeARH8+WL/NN8P1/Eo1x75ICMn+WyQTQ4z0Sk9/d9rZuo
	 d4UyuVLpEnepY2OWVFu4OD7UQozPkrg2Bu3ZCZvFr2XCkcvIex6odidHxpCbqSvPa5
	 nOm4Q3zntD948K0EG3XDo5QbR/cZLCSUwX1Me6BWMvtEp61YJgIiC1D7QJ03VE4wwH
	 9nXitXCL2bKMdndZlw0UXxCz56BYhA8UaR7qcONwoegNg/31EKnDxWmrkcUfrAKQya
	 mexKPvAFFQOkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe Kerello <christophe.kerello@foss.st.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] mtd: rawnand: stm32_fmc2: avoid overlapping mappings on ECC buffer
Date: Sat, 13 Sep 2025 12:13:49 -0400
Message-ID: <20250913161349.1443080-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091309-impeach-gauntlet-7646@gregkh>
References: <2025091309-impeach-gauntlet-7646@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe Kerello <christophe.kerello@foss.st.com>

[ Upstream commit 513c40e59d5a414ab763a9c84797534b5e8c208d ]

Avoid below overlapping mappings by using a contiguous
non-cacheable buffer.

[    4.077708] DMA-API: stm32_fmc2_nfc 48810000.nand-controller: cacheline tracking EEXIST,
overlapping mappings aren't supported
[    4.089103] WARNING: CPU: 1 PID: 44 at kernel/dma/debug.c:568 add_dma_entry+0x23c/0x300
[    4.097071] Modules linked in:
[    4.100101] CPU: 1 PID: 44 Comm: kworker/u4:2 Not tainted 6.1.82 #1
[    4.106346] Hardware name: STMicroelectronics STM32MP257F VALID1 SNOR / MB1704 (LPDDR4 Power discrete) + MB1703 + MB1708 (SNOR MB1730) (DT)
[    4.118824] Workqueue: events_unbound deferred_probe_work_func
[    4.124674] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    4.131624] pc : add_dma_entry+0x23c/0x300
[    4.135658] lr : add_dma_entry+0x23c/0x300
[    4.139792] sp : ffff800009dbb490
[    4.143016] x29: ffff800009dbb4a0 x28: 0000000004008022 x27: ffff8000098a6000
[    4.150174] x26: 0000000000000000 x25: ffff8000099e7000 x24: ffff8000099e7de8
[    4.157231] x23: 00000000ffffffff x22: 0000000000000000 x21: ffff8000098a6a20
[    4.164388] x20: ffff000080964180 x19: ffff800009819ba0 x18: 0000000000000006
[    4.171545] x17: 6361727420656e69 x16: 6c6568636163203a x15: 72656c6c6f72746e
[    4.178602] x14: 6f632d646e616e2e x13: ffff800009832f58 x12: 00000000000004ec
[    4.185759] x11: 00000000000001a4 x10: ffff80000988af58 x9 : ffff800009832f58
[    4.192916] x8 : 00000000ffffefff x7 : ffff80000988af58 x6 : 80000000fffff000
[    4.199972] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
[    4.207128] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000812d2c40
[    4.214185] Call trace:
[    4.216605]  add_dma_entry+0x23c/0x300
[    4.220338]  debug_dma_map_sg+0x198/0x350
[    4.224373]  __dma_map_sg_attrs+0xa0/0x110
[    4.228411]  dma_map_sg_attrs+0x10/0x2c
[    4.232247]  stm32_fmc2_nfc_xfer.isra.0+0x1c8/0x3fc
[    4.237088]  stm32_fmc2_nfc_seq_read_page+0xc8/0x174
[    4.242127]  nand_read_oob+0x1d4/0x8e0
[    4.245861]  mtd_read_oob_std+0x58/0x84
[    4.249596]  mtd_read_oob+0x90/0x150
[    4.253231]  mtd_read+0x68/0xac

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
Cc: stable@vger.kernel.org
Fixes: 2cd457f328c1 ("mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND flash controller driver")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
[ adapted variable name from nfc to fmc2 throughout the patch ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 27 +++++++++-----------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index ad4d944ada0c1..9a375fcbec13b 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -266,6 +266,7 @@ struct stm32_fmc2_nfc {
 	struct sg_table dma_data_sg;
 	struct sg_table dma_ecc_sg;
 	u8 *ecc_buf;
+	dma_addr_t dma_ecc_addr;
 	int dma_ecc_len;
 
 	struct completion complete;
@@ -942,24 +943,19 @@ static int stm32_fmc2_xfer(struct nand_chip *chip, const u8 *buf,
 
 	if (!write_data && !raw) {
 		/* Configure DMA ECC status */
-		p = fmc2->ecc_buf;
 		for_each_sg(fmc2->dma_ecc_sg.sgl, sg, eccsteps, s) {
-			sg_set_buf(sg, p, fmc2->dma_ecc_len);
-			p += fmc2->dma_ecc_len;
+			sg_dma_address(sg) = fmc2->dma_ecc_addr +
+					     s * fmc2->dma_ecc_len;
+			sg_dma_len(sg) = fmc2->dma_ecc_len;
 		}
 
-		ret = dma_map_sg(fmc2->dev, fmc2->dma_ecc_sg.sgl,
-				 eccsteps, dma_data_dir);
-		if (ret < 0)
-			goto err_unmap_data;
-
 		desc_ecc = dmaengine_prep_slave_sg(fmc2->dma_ecc_ch,
 						   fmc2->dma_ecc_sg.sgl,
 						   eccsteps, dma_transfer_dir,
 						   DMA_PREP_INTERRUPT);
 		if (!desc_ecc) {
 			ret = -ENOMEM;
-			goto err_unmap_ecc;
+			goto err_unmap_data;
 		}
 
 		reinit_completion(&fmc2->dma_ecc_complete);
@@ -967,7 +963,7 @@ static int stm32_fmc2_xfer(struct nand_chip *chip, const u8 *buf,
 		desc_ecc->callback_param = &fmc2->dma_ecc_complete;
 		ret = dma_submit_error(dmaengine_submit(desc_ecc));
 		if (ret)
-			goto err_unmap_ecc;
+			goto err_unmap_data;
 
 		dma_async_issue_pending(fmc2->dma_ecc_ch);
 	}
@@ -988,7 +984,7 @@ static int stm32_fmc2_xfer(struct nand_chip *chip, const u8 *buf,
 		if (!write_data && !raw)
 			dmaengine_terminate_all(fmc2->dma_ecc_ch);
 		ret = -ETIMEDOUT;
-		goto err_unmap_ecc;
+		goto err_unmap_data;
 	}
 
 	/* Wait DMA data transfer completion */
@@ -1009,11 +1005,6 @@ static int stm32_fmc2_xfer(struct nand_chip *chip, const u8 *buf,
 		}
 	}
 
-err_unmap_ecc:
-	if (!write_data && !raw)
-		dma_unmap_sg(fmc2->dev, fmc2->dma_ecc_sg.sgl,
-			     eccsteps, dma_data_dir);
-
 err_unmap_data:
 	dma_unmap_sg(fmc2->dev, fmc2->dma_data_sg.sgl, eccsteps, dma_data_dir);
 
@@ -1625,8 +1616,8 @@ static int stm32_fmc2_dma_setup(struct stm32_fmc2_nfc *fmc2)
 		return ret;
 
 	/* Allocate a buffer to store ECC status registers */
-	fmc2->ecc_buf = devm_kzalloc(fmc2->dev, FMC2_MAX_ECC_BUF_LEN,
-				     GFP_KERNEL);
+	fmc2->ecc_buf = dmam_alloc_coherent(fmc2->dev, FMC2_MAX_ECC_BUF_LEN,
+					   &fmc2->dma_ecc_addr, GFP_KERNEL);
 	if (!fmc2->ecc_buf)
 		return -ENOMEM;
 
-- 
2.51.0


