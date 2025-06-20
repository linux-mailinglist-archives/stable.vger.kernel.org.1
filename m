Return-Path: <stable+bounces-155035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E835AE171C
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213A85A1A8C
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AAD27FD73;
	Fri, 20 Jun 2025 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N5FgZ3yx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281BA27FB1C
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410455; cv=none; b=nu7lkPgtrCo6+9DQ8DvGexvIQG1jSNQl0JPlvkiFAA2k4qptyvMwgjeaK+Ytp3onqNt5D4feiP+pEuXz9saj8uswyKvG6oTZWVo3QYeh6LABv5Mt4srfcBMQiD4ONGlkllYMlZGsXGJfUuC+wr0DC3VduyOFBJHe4Zmn7yYVTec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410455; c=relaxed/simple;
	bh=2I/qXKUQXaOLU6DFJhO2WfAN8cmin3DwNsf9VW8mv1U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V1W2opMIidx16EjWiXfnC30ZdHCTB0yYmDqW16MEt4tFdD93SNEq7Xs9KHWHRPPbV0P9taqiRLVH65iSdHFExKwgIM9v0XmHtPei9wvtca+LwLBoxm7E5JGDUDiDQ5+i2z9LpYzDTjp4qcfp1uNxzudR7VkLnF7GEaJIxoPAuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N5FgZ3yx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40039C4CEE3;
	Fri, 20 Jun 2025 09:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750410454;
	bh=2I/qXKUQXaOLU6DFJhO2WfAN8cmin3DwNsf9VW8mv1U=;
	h=Subject:To:Cc:From:Date:From;
	b=N5FgZ3yxADzKGUBErHzPIkwN+a7oPl7AVW3jJywHNH08kW9UbzYA9Lqe4f9YG+Tg3
	 l/HFXEG+Z4pKHalclFV6thb9D2Jg2CoBLIvBnZaYmbNX32zsxDr2KqU0ya5z9fTnGi
	 l4ZVdYvSv1kyZP0GIDzej7mt7QU/DmDRg2+j6RJ0=
Subject: FAILED: patch "[PATCH] mtd: rawnand: qcom: Pass 18 bit offset from NANDc base to BAM" failed to apply to 5.10-stable tree
To: quic_mdalam@quicinc.com,broonie@kernel.org,j4g8y7@gmail.com,manivannan.sadhasivam@linaro.org,miquel.raynal@bootlin.com,quic_laksd@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:07:24 +0200
Message-ID: <2025062024-tinfoil-glove-76a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ee000969f28bf579d3772bf7c0ae8aff86586e20
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062024-tinfoil-glove-76a8@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ee000969f28bf579d3772bf7c0ae8aff86586e20 Mon Sep 17 00:00:00 2001
From: Md Sadre Alam <quic_mdalam@quicinc.com>
Date: Thu, 10 Apr 2025 15:30:17 +0530
Subject: [PATCH] mtd: rawnand: qcom: Pass 18 bit offset from NANDc base to BAM
 base

The BAM command descriptor provides only 18 bits to specify the BAM
register offset. Additionally, in the BAM command descriptor, the BAM
register offset is supposed to be specified as "(NANDc base - BAM base)
+ reg_off". Since, the BAM controller expecting the value in the form of
"NANDc base - BAM base", so that added a new field 'bam_offset' in the NAND
properties structure and use it while preparing the command descriptor.

Previously, the driver was specifying the NANDc base address in the BAM
command descriptor.

Cc: stable@vger.kernel.org
Fixes: 8d6b6d7e135e ("mtd: nand: qcom: support for command descriptor formation")
Tested-by: Lakshmi Sowjanya D <quic_laksd@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Acked-by: Mark Brown <broonie@kernel.org>
Tested-by: Gabor Juhos <j4g8y7@gmail.com> # on IPQ9574
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_common.c
index e0ed25b5afea..4dc4d65e7d32 100644
--- a/drivers/mtd/nand/qpic_common.c
+++ b/drivers/mtd/nand/qpic_common.c
@@ -236,21 +236,21 @@ int qcom_prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
 	int i, ret;
 	struct bam_cmd_element *bam_ce_buffer;
 	struct bam_transaction *bam_txn = nandc->bam_txn;
+	u32 offset;
 
 	bam_ce_buffer = &bam_txn->bam_ce[bam_txn->bam_ce_pos];
 
 	/* fill the command desc */
 	for (i = 0; i < size; i++) {
+		offset = nandc->props->bam_offset + reg_off + 4 * i;
 		if (read)
 			bam_prep_ce(&bam_ce_buffer[i],
-				    nandc_reg_phys(nandc, reg_off + 4 * i),
-				    BAM_READ_COMMAND,
+				    offset, BAM_READ_COMMAND,
 				    reg_buf_dma_addr(nandc,
 						     (__le32 *)vaddr + i));
 		else
 			bam_prep_ce_le32(&bam_ce_buffer[i],
-					 nandc_reg_phys(nandc, reg_off + 4 * i),
-					 BAM_WRITE_COMMAND,
+					 offset, BAM_WRITE_COMMAND,
 					 *((__le32 *)vaddr + i));
 	}
 
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 5eaa0be367cd..ef2dd158ca34 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2360,6 +2360,7 @@ static const struct qcom_nandc_props ipq806x_nandc_props = {
 	.supports_bam = false,
 	.use_codeword_fixup = true,
 	.dev_cmd_reg_start = 0x0,
+	.bam_offset = 0x30000,
 };
 
 static const struct qcom_nandc_props ipq4019_nandc_props = {
@@ -2367,6 +2368,7 @@ static const struct qcom_nandc_props ipq4019_nandc_props = {
 	.supports_bam = true,
 	.nandc_part_of_qpic = true,
 	.dev_cmd_reg_start = 0x0,
+	.bam_offset = 0x30000,
 };
 
 static const struct qcom_nandc_props ipq8074_nandc_props = {
@@ -2374,6 +2376,7 @@ static const struct qcom_nandc_props ipq8074_nandc_props = {
 	.supports_bam = true,
 	.nandc_part_of_qpic = true,
 	.dev_cmd_reg_start = 0x7000,
+	.bam_offset = 0x30000,
 };
 
 static const struct qcom_nandc_props sdx55_nandc_props = {
@@ -2382,6 +2385,7 @@ static const struct qcom_nandc_props sdx55_nandc_props = {
 	.nandc_part_of_qpic = true,
 	.qpic_version2 = true,
 	.dev_cmd_reg_start = 0x7000,
+	.bam_offset = 0x30000,
 };
 
 /*
diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 17eb67e19132..d9fb602160c7 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1605,6 +1605,7 @@ static void qcom_spi_remove(struct platform_device *pdev)
 
 static const struct qcom_nandc_props ipq9574_snandc_props = {
 	.dev_cmd_reg_start = 0x7000,
+	.bam_offset = 0x30000,
 	.supports_bam = true,
 };
 
diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nand-qpic-common.h
index cd7172e6c1bb..e8462deda6db 100644
--- a/include/linux/mtd/nand-qpic-common.h
+++ b/include/linux/mtd/nand-qpic-common.h
@@ -199,9 +199,6 @@
  */
 #define dev_cmd_reg_addr(nandc, reg) ((nandc)->props->dev_cmd_reg_start + (reg))
 
-/* Returns the NAND register physical address */
-#define nandc_reg_phys(chip, offset) ((chip)->base_phys + (offset))
-
 /* Returns the dma address for reg read buffer */
 #define reg_buf_dma_addr(chip, vaddr) \
 	((chip)->reg_read_dma + \
@@ -454,6 +451,7 @@ struct qcom_nand_controller {
 struct qcom_nandc_props {
 	u32 ecc_modes;
 	u32 dev_cmd_reg_start;
+	u32 bam_offset;
 	bool supports_bam;
 	bool nandc_part_of_qpic;
 	bool qpic_version2;


