Return-Path: <stable+bounces-167106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7679B21F80
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 09:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBE4502694
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 07:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5F52DE6F7;
	Tue, 12 Aug 2025 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="vVekZk5b"
X-Original-To: stable@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D022D97AB;
	Tue, 12 Aug 2025 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983803; cv=none; b=bue+IXP/O3m0NtBg3NnIBfSRF1txJY+tL44/u72bSyQw8DywciVlraNQErSl3vbhjgx5cXNFEQufPYQ4xQIQ3BrKSucLim50urWVwh24tyDis+wBCnkDAdPD6jEMnFcO3Wl34p5O7Qw7w2tt5uP+pyUnh6zJ8cpC4ENEBG/oNnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983803; c=relaxed/simple;
	bh=H/1SbOyexPBj9Bv/6npMpKQzxX7AGDhdqrw0e036Orw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=ssE2nn/uRXT6LNJm5zF04pT/V9Brqm0cL85nLVtrqB4hBqmG8U3Xw6IH6gVUraQ+/UMSD55t9ga69HS3osez8w+0+1P0ZtsrENBv6cfm+agd847yh0+krCS6YD0RHnrIW/GMkvRttIMQFgk7pngZVCtJ9qQZQDJI1boQ0JzOiAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=vVekZk5b; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C77Ixb008709;
	Tue, 12 Aug 2025 09:29:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=Cp7r1Pmui13ce0yd2WoGg4
	CTlzmUVA1zRtsH2JGzcI0=; b=vVekZk5bOMRlZvE26VjQ2Yr++ES4xrg3cBO55c
	weKa/WiS4g349kfQYgl1EmoqTc6QMmYm1kDT6euQc/B3Y3luTQGi1r7EHUOgEXMC
	5iWP1ApFKHtagHbuO3KmdwE2VW/oR6THRrJoDv6QTxHLudTtvk5ld/p6hkY3d/tp
	rIHqjOjBZQVCSWURTBcSkm/SETr3uNlPDH25QF8H59ZnQ0aPS/TZM1L8hiMWGUe9
	ssBbaiig5E61wyruSFojEo/cCvYTXXgzdnvDOKqc9YsA1y38Umk8ddDLRWWCke+W
	JIFQNgUCoSwwh5SbdsCjVDqNJb4FMlCS/7uupAbuM3ePHHzA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48eh9n6urr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 09:29:21 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DC28940044;
	Tue, 12 Aug 2025 09:28:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3BFC7747A63;
	Tue, 12 Aug 2025 09:27:24 +0200 (CEST)
Received: from localhost (10.48.87.65) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 09:27:23 +0200
From: Christophe Kerello <christophe.kerello@foss.st.com>
Date: Tue, 12 Aug 2025 09:26:58 +0200
Subject: [PATCH] mtd: rawnand: stm32_fmc2: avoid overlapping mappings on
 ECC buffer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250812-fix-dma-overlapping-v1-1-c3bf81d79de7@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAMHsmmgC/x2MQQqAIBAAvxJ7bsENIusr0cFytYUyUYgg/HvSc
 WBmXsichDNMzQuJb8lyhQrUNrDtJnhGsZWhU12vNBE6edCeBq+b02FilOCRNu1WMzjb0wi1jIm
 r9l/npZQPMcSg1WUAAAA=
X-Change-ID: 20250811-fix-dma-overlapping-1c8fba7fd519
To: Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger
	<richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Christophe Kerello
	<christophe.kerello@st.com>
CC: <linux-mtd@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        <stable@vger.kernel.org>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01

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
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index a960403081f11091837b73b8610231fe421d0c05..222c3c3b684841879a55835e802dcf9983860c28 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -272,6 +272,7 @@ struct stm32_fmc2_nfc {
 	struct sg_table dma_data_sg;
 	struct sg_table dma_ecc_sg;
 	u8 *ecc_buf;
+	dma_addr_t dma_ecc_addr;
 	int dma_ecc_len;
 	u32 tx_dma_max_burst;
 	u32 rx_dma_max_burst;
@@ -902,17 +903,10 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 
 	if (!write_data && !raw) {
 		/* Configure DMA ECC status */
-		p = nfc->ecc_buf;
 		for_each_sg(nfc->dma_ecc_sg.sgl, sg, eccsteps, s) {
-			sg_set_buf(sg, p, nfc->dma_ecc_len);
-			p += nfc->dma_ecc_len;
-		}
-
-		ret = dma_map_sg(nfc->dev, nfc->dma_ecc_sg.sgl,
-				 eccsteps, dma_data_dir);
-		if (!ret) {
-			ret = -EIO;
-			goto err_unmap_data;
+			sg_dma_address(sg) = nfc->dma_ecc_addr +
+					     s * nfc->dma_ecc_len;
+			sg_dma_len(sg) = nfc->dma_ecc_len;
 		}
 
 		desc_ecc = dmaengine_prep_slave_sg(nfc->dma_ecc_ch,
@@ -921,7 +915,7 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 						   DMA_PREP_INTERRUPT);
 		if (!desc_ecc) {
 			ret = -ENOMEM;
-			goto err_unmap_ecc;
+			goto err_unmap_data;
 		}
 
 		reinit_completion(&nfc->dma_ecc_complete);
@@ -929,7 +923,7 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 		desc_ecc->callback_param = &nfc->dma_ecc_complete;
 		ret = dma_submit_error(dmaengine_submit(desc_ecc));
 		if (ret)
-			goto err_unmap_ecc;
+			goto err_unmap_data;
 
 		dma_async_issue_pending(nfc->dma_ecc_ch);
 	}
@@ -949,7 +943,7 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 		if (!write_data && !raw)
 			dmaengine_terminate_all(nfc->dma_ecc_ch);
 		ret = -ETIMEDOUT;
-		goto err_unmap_ecc;
+		goto err_unmap_data;
 	}
 
 	/* Wait DMA data transfer completion */
@@ -969,11 +963,6 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 		}
 	}
 
-err_unmap_ecc:
-	if (!write_data && !raw)
-		dma_unmap_sg(nfc->dev, nfc->dma_ecc_sg.sgl,
-			     eccsteps, dma_data_dir);
-
 err_unmap_data:
 	dma_unmap_sg(nfc->dev, nfc->dma_data_sg.sgl, eccsteps, dma_data_dir);
 
@@ -1610,7 +1599,8 @@ static int stm32_fmc2_nfc_dma_setup(struct stm32_fmc2_nfc *nfc)
 		return ret;
 
 	/* Allocate a buffer to store ECC status registers */
-	nfc->ecc_buf = devm_kzalloc(nfc->dev, FMC2_MAX_ECC_BUF_LEN, GFP_KERNEL);
+	nfc->ecc_buf = dmam_alloc_coherent(nfc->dev, FMC2_MAX_ECC_BUF_LEN,
+					   &nfc->dma_ecc_addr, GFP_KERNEL);
 	if (!nfc->ecc_buf)
 		return -ENOMEM;
 

---
base-commit: fb2fae70e7e985c4acb1ad96110d8b98bb64a87c
change-id: 20250811-fix-dma-overlapping-1c8fba7fd519

Best regards,
-- 
Christophe Kerello <christophe.kerello@foss.st.com>


