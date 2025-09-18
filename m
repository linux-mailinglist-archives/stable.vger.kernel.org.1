Return-Path: <stable+bounces-165352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41486B15CD3
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69080563E61
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408912949F2;
	Wed, 30 Jul 2025 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="idy344C8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2041293C74;
	Wed, 30 Jul 2025 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868795; cv=none; b=q0btwKWaoFpqh+Kx8c08fE+HP4SMi/srYBZcJUr7a3R9IKk+D4AWNO1m5iGa2KCUA5IxnW/n8g902Pu2E9JDG9qb4an4g1oO/hCpAakkkOIg3h06SzggGuVZJBlQVZ6BnxzFCz++4Kkbxr9w4mRP2ZBlMoL/cd84R1q3+UMLb4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868795; c=relaxed/simple;
	bh=rO/huANhTbc24ltXyAZAN0n2OGlyIu6AHI9RhIrtHOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGVaW07cycKgbC9h+ufwX7FL2IRS+t7W3b33aBdCZkzwt4MBbqSXCbXodETv7+qGFBeOD21/21KXh7TdUzBP0GYJdv7CklgVaHaozl17224HVsKY7Lu3mydIO6bL2SkFnnxfdVtw6tFwj75ppvDPsMiWOH4cnAMoEZMf++phwpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=idy344C8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF2EC4CEF5;
	Wed, 30 Jul 2025 09:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753868793;
	bh=rO/huANhTbc24ltXyAZAN0n2OGlyIu6AHI9RhIrtHOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=idy344C8X9C1Gl6mOOMDComCOedx7JPa9yjunTFwbKOfsEzERAlqgu0gBKsDVt2x4
	 gURQ/jhBStRh4qHqSTJtc3J55CrZI03J/V0P/ynFsjou/u6wCOuuK+WqKOTutrcqVm
	 Q5n3oCwggs8i/Sw8tsjijpW8iPvJz0gS8yt2Sd+M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lakshmi Sowjanya D <quic_laksd@quicinc.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 077/117] mtd: rawnand: qcom: Fix last codeword read in qcom_param_page_type_exec()
Date: Wed, 30 Jul 2025 11:35:46 +0200
Message-ID: <20250730093236.538138049@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093233.592541778@linuxfoundation.org>
References: <20250730093233.592541778@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2858,7 +2858,12 @@ static int qcom_param_page_type_exec(str
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
@@ -2910,7 +2915,10 @@ static int qcom_param_page_type_exec(str
 	op_id = q_op.data_instr_idx;
 	len = nand_subop_get_data_len(subop, op_id);
 
-	nandc_set_read_loc(chip, 0, 0, 0, len, 1);
+	if (nandc->props->qpic_v2)
+		nandc_set_read_loc_last(chip, reg_base, 0, len, 1);
+	else
+		nandc_set_read_loc_first(chip, reg_base, 0, len, 1);
 
 	if (!nandc->props->qpic_v2) {
 		write_reg_dma(nandc, NAND_DEV_CMD_VLD, 1, 0);



