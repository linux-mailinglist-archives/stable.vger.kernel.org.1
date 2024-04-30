Return-Path: <stable+bounces-42088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A69E48B7156
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E4C1C223EE
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D5012C550;
	Tue, 30 Apr 2024 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JpAES3kE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D3D12C462;
	Tue, 30 Apr 2024 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474526; cv=none; b=Z7jDpbAzX4tnq1LrdhbiWNa5M4k2uuHgQIX5jY7XKhoLCTh92a8aNRbpuIwtXw0nNBZu5xgHcQkiqRhqiZl45C7QuVt86CsQyDG/eS0rQfiISWXxPcEDKFn8pO0EWsyn9FPWsO9ipUqgar2i3EJNm/gjmBTpwuTwpQjOFKiaUeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474526; c=relaxed/simple;
	bh=ccxykEZmSWeVMumi4I37R+0OcieXeser6G/C2bpKr4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THbtWwErqU/0T84iKhF6yV2jtvuo2JuJvO2cDYzdx9IorSPA2/xq0QDyWjNBl+Yzh8ec5jZF72FBBi0GN3LwrFzrmPJm4LX9lkUzc1aZPCWnwoQ3D02Xu9owQL5dyFx+Bu39eqC2IXSsmiCJLTAqXtjBaqfZV1SPmJuRdpSS480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JpAES3kE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FF7C2BBFC;
	Tue, 30 Apr 2024 10:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474526;
	bh=ccxykEZmSWeVMumi4I37R+0OcieXeser6G/C2bpKr4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JpAES3kEUxiACXWxSSsaXJU2mpBz/2fPgx+r3GCQN9c0qGGerHJtyI3Cn/5Ir/Yld
	 wIfaht8v5sMMGaovVtCisI982ZUHnKufWu621RbM9AkbS/Ez4rtSjOSSu1Mc7MuERN
	 Frodoyek3TmSIlHyPaaO20i3o6NcmZbz9SMl0hjI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.8 146/228] mtd: rawnand: qcom: Fix broken OP_RESET_DEVICE command in qcom_misc_cmd_type_exec()
Date: Tue, 30 Apr 2024 12:38:44 +0200
Message-ID: <20240430103108.021601111@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Marangi <ansuelsmth@gmail.com>

commit b61bb5bc2c1cd00bb53db42f705735db6e8700f0 upstream.

While migrating to exec_ops in commit a82990c8a409 ("mtd: rawnand: qcom:
Add read/read_start ops in exec_op path"), OP_RESET_DEVICE command handling
got broken unintentionally. Right now for the OP_RESET_DEVICE command,
qcom_misc_cmd_type_exec() will simply return 0 without handling it. Even,
if that gets fixed, an unnecessary FLASH_STATUS read descriptor command is
being added in the middle and that seems to be causing the command to fail
on IPQ806x devices.

So let's fix the above two issues to make OP_RESET_DEVICE command working
again.

Fixes: a82990c8a409 ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path")
Cc: stable@vger.kernel.org
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240404083157.940-1-ansuelsmth@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2815,7 +2815,7 @@ static int qcom_misc_cmd_type_exec(struc
 			      host->cfg0_raw & ~(7 << CW_PER_PAGE));
 		nandc_set_reg(chip, NAND_DEV0_CFG1, host->cfg1_raw);
 		instrs = 3;
-	} else {
+	} else if (q_op.cmd_reg != OP_RESET_DEVICE) {
 		return 0;
 	}
 
@@ -2830,9 +2830,8 @@ static int qcom_misc_cmd_type_exec(struc
 	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
 
 	write_reg_dma(nandc, NAND_FLASH_CMD, instrs, NAND_BAM_NEXT_SGL);
-	(q_op.cmd_reg == OP_BLOCK_ERASE) ? write_reg_dma(nandc, NAND_DEV0_CFG0,
-	2, NAND_BAM_NEXT_SGL) : read_reg_dma(nandc,
-	NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
+	if (q_op.cmd_reg == OP_BLOCK_ERASE)
+		write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);
 
 	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
 	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);



