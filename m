Return-Path: <stable+bounces-179445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5B4B560B2
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FCB65656B2
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF7A2E8DE6;
	Sat, 13 Sep 2025 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JyhZlLil"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303D526057A
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766235; cv=none; b=Avt2NmIGfOIkg5LbyQV6LaleyFGvI9ezBxie5r6q5UJH8LSrmHQRuVmsxlHIzkeHUd6MDJPtYthM07euUVnuNTsrX9bqqAXqpmvqVe7z/z6xv1OF0Tqz1QvIJPkQZSbiDhRJvNBLjSTqjpCgXTJXQhp0JV/KauYiCL/7qKW1E20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766235; c=relaxed/simple;
	bh=px9J579pbnJEdMwxGmXwWRGxRh/bKuS+l8agMluIWl0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fgzpjqFon7KXBAJcU6Tna8C5+9kLx/lmGBt8h7AgXoeEXw7Hu2T4XTS6V00hzq7au6xEEnUoZ49ZeOrpW3nTx5bZzJ/8bkf5kpzsES+zRNylysE+Xo1+N1G+XBm/KwinX2VqR8IT2+k233qabmTp3Gjwfg2015ZLr99T5QsNwy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JyhZlLil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAE9C4CEEB;
	Sat, 13 Sep 2025 12:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757766234;
	bh=px9J579pbnJEdMwxGmXwWRGxRh/bKuS+l8agMluIWl0=;
	h=Subject:To:Cc:From:Date:From;
	b=JyhZlLil82nvlgdpoRrsgoKRSqhTFVr9tAzVincXybvKk8Ovd7CDJu4dd+ScGc1n7
	 MPBxbqZ2E/s/bp+c260eNOdkOkybnX15WC++wDN1cmKu/t1RxXxfnEYNKf/tRHVqDW
	 +2HAmy1D5dt6O53QDXKqqFaYBGdXonVliZDIk2js=
Subject: FAILED: patch "[PATCH] mtd: spinand: winbond: Fix oob_layout for W25N01JW" failed to apply to 6.12-stable tree
To: s-k6@ti.com,miquel.raynal@bootlin.com,quic_sridsn@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:23:43 +0200
Message-ID: <2025091343-refund-bullseye-601a@gregkh>
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
git cherry-pick -x 4550d33e18112a11a740424c4eec063cd58e918c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091343-refund-bullseye-601a@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4550d33e18112a11a740424c4eec063cd58e918c Mon Sep 17 00:00:00 2001
From: Santhosh Kumar K <s-k6@ti.com>
Date: Thu, 4 Sep 2025 18:47:41 +0530
Subject: [PATCH] mtd: spinand: winbond: Fix oob_layout for W25N01JW

Fix the W25N01JW's oob_layout according to the datasheet [1]

[1] https://www.winbond.com/hq/product/code-storage-flash-memory/qspinand-flash/?__locale=en&partNo=W25N01JW

Fixes: 6a804fb72de5 ("mtd: spinand: winbond: add support for serial NAND flash")
Cc: Sridharan S N <quic_sridsn@quicinc.com>
Cc: stable@vger.kernel.org
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 87053389a1fc..4870b2d5edb2 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -176,6 +176,36 @@ static const struct mtd_ooblayout_ops w25n02kv_ooblayout = {
 	.free = w25n02kv_ooblayout_free,
 };
 
+static int w25n01jw_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = (16 * section) + 12;
+	region->length = 4;
+
+	return 0;
+}
+
+static int w25n01jw_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = (16 * section);
+	region->length = 12;
+
+	/* Extract BBM */
+	if (!section) {
+		region->offset += 2;
+		region->length -= 2;
+	}
+
+	return 0;
+}
+
 static int w35n01jw_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
 {
@@ -206,6 +236,11 @@ static int w35n01jw_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
+static const struct mtd_ooblayout_ops w25n01jw_ooblayout = {
+	.ecc = w25n01jw_ooblayout_ecc,
+	.free = w25n01jw_ooblayout_free,
+};
+
 static const struct mtd_ooblayout_ops w35n01jw_ooblayout = {
 	.ecc = w35n01jw_ooblayout_ecc,
 	.free = w35n01jw_ooblayout_free,
@@ -394,7 +429,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
+		     SPINAND_ECCINFO(&w25n01jw_ooblayout, NULL),
 		     SPINAND_CONFIGURE_CHIP(w25n0xjw_hs_cfg)),
 	SPINAND_INFO("W25N01KV", /* 3.3V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xae, 0x21),


