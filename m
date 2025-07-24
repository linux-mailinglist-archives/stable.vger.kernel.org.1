Return-Path: <stable+bounces-164531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 094A7B0FECB
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 04:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD4496438F
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C348C165F13;
	Thu, 24 Jul 2025 02:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcVywxYm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6B013A41F
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 02:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753324443; cv=none; b=TU+0CLZ9cKUHBQAd/TPFlvL8NQND8TKALwSVcxiDJL/mvBMZPRbIXDgIWimfY4p8qM0WvpGxkotpX9lqBDBR0pZZdaPYZ7G2zY9iJL5YbR+h8G2zubaT+OfbovSZlm4MSYXbXCfr7CJVL0/Y6ngDBk47AnP4bRTBQdeJ/L/J9Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753324443; c=relaxed/simple;
	bh=9FdP2FdmGwSu8KSQyWxCnN91gYqJ+8+kQiV+9HRZPr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bCOgLiKvZJl877ZyrF/5JzoypVkpztw3YD1RL1wy6GhzaaxcxxWr8K3UmmJhTcsRAtqSH//33PAIjAWKf7uvrmYhUZKxJBEZfYm6DqVezEbQDjFHncgJyVB4F8rr3wHKSLkhGXOAYK8tks7vTJnTD93i2VLCAU09oGQrBF/oyf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcVywxYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB3EC4CEE7;
	Thu, 24 Jul 2025 02:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753324443;
	bh=9FdP2FdmGwSu8KSQyWxCnN91gYqJ+8+kQiV+9HRZPr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YcVywxYm9NaDKR2DHbosJScks7UCrqOnPl46pThZ50i1IAzAWU7jho/5Drbc4t2j6
	 7/Yk2XsL39YExRuDQvo7FLkNqwJ3Cc6c3uYCMgze22b7wuDKPPdI7JKzAevEMwj578
	 qnzbGsyo8DaPPSqfKcLSWKjtyDVRGuE8V3GpdIiUa8PqXA/Mt11UTleVacHDpo9pj7
	 7/4suX8GrGbLrFX2dOFwmV0Jo2C57QChuI/clhWypWzUEoivxiLMelu41PHp10M3uw
	 vjtKQZ/FDs8iFN6p9syS+8R/KQeXohLm58amnLTdTnWVq/7WHxU1QindvIKHTyvTG/
	 tAa1c7VNSFWyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lakshmi Sowjanya D <quic_laksd@quicinc.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mtd: rawnand: qcom: Fix last codeword read in qcom_param_page_type_exec()
Date: Wed, 23 Jul 2025 22:33:58 -0400
Message-Id: <20250724023358.1268700-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025062002-disperser-removing-78fc@gregkh>
References: <2025062002-disperser-removing-78fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Md Sadre Alam <quic_mdalam@quicinc.com>

[ Upstream commit 47bddabbf69da50999ec68be92b58356c687e1d6 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index beafca6ba0df4..275d34119acdc 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2858,7 +2858,12 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	const struct nand_op_instr *instr = NULL;
 	unsigned int op_id = 0;
 	unsigned int len = 0;
-	int ret;
+	int ret, reg_base;
+
+	reg_base = NAND_READ_LOCATION_0;
+
+	if (nandc->props->qpic_v2)
+		reg_base = NAND_READ_LOCATION_LAST_CW_0;
 
 	ret = qcom_parse_instructions(chip, subop, &q_op);
 	if (ret)
@@ -2910,7 +2915,10 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	op_id = q_op.data_instr_idx;
 	len = nand_subop_get_data_len(subop, op_id);
 
-	nandc_set_read_loc(chip, 0, 0, 0, len, 1);
+	if (nandc->props->qpic_v2)
+		nandc_set_read_loc_last(chip, reg_base, 0, len, 1);
+	else
+		nandc_set_read_loc_first(chip, reg_base, 0, len, 1);
 
 	if (!nandc->props->qpic_v2) {
 		write_reg_dma(nandc, NAND_DEV_CMD_VLD, 1, 0);
-- 
2.39.5


