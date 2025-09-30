Return-Path: <stable+bounces-182080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C498BAD43D
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 16:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2CAD1941784
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCB930504B;
	Tue, 30 Sep 2025 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h0wYfmEv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0257D30497C;
	Tue, 30 Sep 2025 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243765; cv=none; b=Xc5ykZliOMXyWSmNdzD3pvmAvNTdX09SevXllo/qYHwiabqQpyizkalS2ZkaF0KYjhnGB2WcOvTMZyQmPGIyipW/mQr/aCc2YpYlLh83EtJDGD4bNvUiKsfD4/c3uW49D2NhID0ahKBnGTE8DCk3qhbwJFKX7QUR2A0IR2RJLZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243765; c=relaxed/simple;
	bh=V5ODh1lbQodAepUfNKHWKEbIR23UkGz7eDzhFBxLbiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPqXDRnt/tsjshOUu4zLa6OjFgkJssbi5gVMuWDIzBWglN3zPKH6mYSLUMenfeRTL4ZPwv2n7pHBt2iTk0eJUVOLWItnt6wmAsA4ip4NZ4DTWUO6BsyDbgxjO40kuUwq7U4SQhgqTbgziiLYaP+mluYvz9pLaGs6qY7BPqL6T3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h0wYfmEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EFEC4CEF0;
	Tue, 30 Sep 2025 14:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759243764;
	bh=V5ODh1lbQodAepUfNKHWKEbIR23UkGz7eDzhFBxLbiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h0wYfmEv7Z62OGSO3gT1KOSXnMolqKa3ASj1+qn4R+WqKbHBTc5MDNkaMrhu4GXSS
	 hzv9TwddlwZbNblu+MtLeucu5vySlRKnCIy3uquZSsG/gPBltFOnolTAi85+GLFikz
	 qlLOIZjrUHrdGWs4SKQlIPn4d2tpzhzQYJYZvnwE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe Kerello <christophe.kerello@foss.st.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 11/81] mtd: rawnand: stm32_fmc2: avoid overlapping mappings on ECC buffer
Date: Tue, 30 Sep 2025 16:46:13 +0200
Message-ID: <20250930143820.138517086@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143819.654157320@linuxfoundation.org>
References: <20250930143819.654157320@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c |   27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -266,6 +266,7 @@ struct stm32_fmc2_nfc {
 	struct sg_table dma_data_sg;
 	struct sg_table dma_ecc_sg;
 	u8 *ecc_buf;
+	dma_addr_t dma_ecc_addr;
 	int dma_ecc_len;
 
 	struct completion complete;
@@ -942,24 +943,19 @@ static int stm32_fmc2_xfer(struct nand_c
 
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
@@ -967,7 +963,7 @@ static int stm32_fmc2_xfer(struct nand_c
 		desc_ecc->callback_param = &fmc2->dma_ecc_complete;
 		ret = dma_submit_error(dmaengine_submit(desc_ecc));
 		if (ret)
-			goto err_unmap_ecc;
+			goto err_unmap_data;
 
 		dma_async_issue_pending(fmc2->dma_ecc_ch);
 	}
@@ -988,7 +984,7 @@ static int stm32_fmc2_xfer(struct nand_c
 		if (!write_data && !raw)
 			dmaengine_terminate_all(fmc2->dma_ecc_ch);
 		ret = -ETIMEDOUT;
-		goto err_unmap_ecc;
+		goto err_unmap_data;
 	}
 
 	/* Wait DMA data transfer completion */
@@ -1009,11 +1005,6 @@ static int stm32_fmc2_xfer(struct nand_c
 		}
 	}
 
-err_unmap_ecc:
-	if (!write_data && !raw)
-		dma_unmap_sg(fmc2->dev, fmc2->dma_ecc_sg.sgl,
-			     eccsteps, dma_data_dir);
-
 err_unmap_data:
 	dma_unmap_sg(fmc2->dev, fmc2->dma_data_sg.sgl, eccsteps, dma_data_dir);
 
@@ -1637,8 +1628,8 @@ static int stm32_fmc2_dma_setup(struct s
 		return ret;
 
 	/* Allocate a buffer to store ECC status registers */
-	fmc2->ecc_buf = devm_kzalloc(fmc2->dev, FMC2_MAX_ECC_BUF_LEN,
-				     GFP_KERNEL);
+	fmc2->ecc_buf = dmam_alloc_coherent(fmc2->dev, FMC2_MAX_ECC_BUF_LEN,
+					   &fmc2->dma_ecc_addr, GFP_KERNEL);
 	if (!fmc2->ecc_buf)
 		return -ENOMEM;
 



