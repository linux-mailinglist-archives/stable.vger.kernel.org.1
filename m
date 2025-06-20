Return-Path: <stable+bounces-155061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 153B4AE176B
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03511BC0F8D
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5873B280CD9;
	Fri, 20 Jun 2025 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pA2emvSa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1890728134F
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750411381; cv=none; b=dpZ94n9QGx8dm/rPPUvqqwiY/pMGRwc0I79d4dX3zzch++wx48tqcheP4wt/anUXgL2117XBnICefaHvSUoCJq4d1Uqy0M9vmEln75oDam+/A2LB/UMku4TMkt8N6iGnK8IMNlN/AmubpGWI5L9bEQQW7pnWA4RiqHF9bowxdb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750411381; c=relaxed/simple;
	bh=IcKGz9FxWZnikIXZDWo75Faqb+WlSMxWOQkrIVIVuH0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NsET6nPMgJdI/pt1ZRPRoz1X3cBRORNAMgqpszdStdtTu2FTfSnkSJcwA3r7bHK5OXSYPbmzpoxnCiCUi2lnQh97ithIpF91fIOjZvCi5RAo1OZdl3gCJPqBL4+EXbTu5yZ2ZbdZOk/MUZSqxweEH4D7P3bnUEE9V0v7Kn15C7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pA2emvSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6EBC4CEEF;
	Fri, 20 Jun 2025 09:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750411381;
	bh=IcKGz9FxWZnikIXZDWo75Faqb+WlSMxWOQkrIVIVuH0=;
	h=Subject:To:Cc:From:Date:From;
	b=pA2emvSauN96xSYyXwko4fPDbL+KyjN7WfbW6PpOaDYrRVFjWi+ClZU1730b0ZOO5
	 oO7HEtn5mzfHFIwmN8uFm97UlRPhpst6vqnjHkodPJdKuZMEJHLbQdurveMllpxScg
	 OUwOl0JzByS3UpEsw7aFJ6fYykncsIdPPPK8BDOg=
Subject: FAILED: patch "[PATCH] mtd: rawnand: qcom: Fix last codeword read in" failed to apply to 6.6-stable tree
To: quic_mdalam@quicinc.com,manivannan.sadhasivam@linaro.org,miquel.raynal@bootlin.com,quic_laksd@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:22:00 +0200
Message-ID: <2025062000-manhunt-treachery-4c42@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 47bddabbf69da50999ec68be92b58356c687e1d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062000-manhunt-treachery-4c42@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


