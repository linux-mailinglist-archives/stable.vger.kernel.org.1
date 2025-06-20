Return-Path: <stable+bounces-155063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15C5AE1770
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5384A68A2
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB705281362;
	Fri, 20 Jun 2025 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xEQBjcgh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B094280CD9
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750411445; cv=none; b=J+IUUJ/38CzpHxIa7R9cHH98qoH/Z0ddfakkIjWLZ7TA01OSS+FxEo9ycpdR5uvhaXh+MTT2CLLAMF31uXOktokbwdtDslCqyo9lB07kc8afTSwjKH8FRd31kjEbSdnAlYIVQa3KEYT7XuHX5+y2sBEuOVGFqxU+HI2NDHcGvDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750411445; c=relaxed/simple;
	bh=8GAL5gZRsmDTC2X6eWG0C3rbAvg26UJ7Oh6mUpAoEhg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Gvj2eLIio0oNnX8mwKWTgZ+9y45rl9YUR/S8ZVu/PW84WVGFBIhk0DLppdEb2JrRNahO1HQoe+0XY+rRH91/7LoknmDVPJ6b82DRHFWtEgflRKR60VmX++GlWO20vhFOyReedmCieDjyrf4aZNFAYF7rjmuOZeezmY+FCFlo+3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xEQBjcgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1D1C4CEE3;
	Fri, 20 Jun 2025 09:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750411445;
	bh=8GAL5gZRsmDTC2X6eWG0C3rbAvg26UJ7Oh6mUpAoEhg=;
	h=Subject:To:Cc:From:Date:From;
	b=xEQBjcghCFb1KYHWUlly2ttHIacZgv7m4rSxpzlT6WffGBuZtkY9/xn0VHqGq4Kqh
	 mLKMSWODLDR3l2aFP/ZDnbztoqUmieg17JVFi6D2yFgl6C0M+qGWRjaBKtni9lmK86
	 f5S3RDb/0TFV1xAo2RcYJi7Pu9wl7QYG+3XJTOMI=
Subject: FAILED: patch "[PATCH] mtd: rawnand: qcom: Fix last codeword read in" failed to apply to 6.12-stable tree
To: quic_mdalam@quicinc.com,manivannan.sadhasivam@linaro.org,miquel.raynal@bootlin.com,quic_laksd@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:24:02 +0200
Message-ID: <2025062002-disperser-removing-78fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 47bddabbf69da50999ec68be92b58356c687e1d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062002-disperser-removing-78fc@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47bddabbf69da50999ec68be92b58356c687e1d6 Mon Sep 17 00:00:00 2001
From: Md Sadre Alam <quic_mdalam@quicinc.com>
Date: Thu, 10 Apr 2025 15:30:18 +0530
Subject: [PATCH] mtd: rawnand: qcom: Fix last codeword read in
 qcom_param_page_type_exec()

For QPIC V2 onwards there is a separate register to read
last code word "QPIC_NAND_READ_LOCATION_LAST_CW_n".

qcom_param_page_type_exec() is used to read only one code word
If it configures the number of code words to 1 in QPIC_NAND_DEV0_CFG0
register then QPIC controller thinks its reading the last code word,
since we are having separate register to read the last code word,
we have to configure "QPIC_NAND_READ_LOCATION_LAST_CW_n" register
to fetch data from QPIC buffer to system memory.

Without this change page read was failing with timeout error

/ # hexdump -C /dev/mtd1
[  129.206113] qcom-nandc 1cc8000.nand-controller: failure to read page/oob
hexdump: /dev/mtd1: Connection timed out

This issue only seen on SDX targets since SDX target used QPICv2. But
same working on IPQ targets since IPQ used QPICv1.

Cc: stable@vger.kernel.org
Fixes: 89550beb098e ("mtd: rawnand: qcom: Implement exec_op()")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Lakshmi Sowjanya D <quic_laksd@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index ef2dd158ca34..a73bb154353f 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1863,7 +1863,12 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	const struct nand_op_instr *instr = NULL;
 	unsigned int op_id = 0;
 	unsigned int len = 0;
-	int ret;
+	int ret, reg_base;
+
+	reg_base = NAND_READ_LOCATION_0;
+
+	if (nandc->props->qpic_version2)
+		reg_base = NAND_READ_LOCATION_LAST_CW_0;
 
 	ret = qcom_parse_instructions(chip, subop, &q_op);
 	if (ret)
@@ -1915,7 +1920,10 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	op_id = q_op.data_instr_idx;
 	len = nand_subop_get_data_len(subop, op_id);
 
-	nandc_set_read_loc(chip, 0, 0, 0, len, 1);
+	if (nandc->props->qpic_version2)
+		nandc_set_read_loc_last(chip, reg_base, 0, len, 1);
+	else
+		nandc_set_read_loc_first(chip, reg_base, 0, len, 1);
 
 	if (!nandc->props->qpic_version2) {
 		qcom_write_reg_dma(nandc, &nandc->regs->vld, NAND_DEV_CMD_VLD, 1, 0);


