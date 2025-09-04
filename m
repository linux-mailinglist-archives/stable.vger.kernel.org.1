Return-Path: <stable+bounces-177727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556CBB43CE5
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 15:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA407B6F2B
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 13:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4A7272E51;
	Thu,  4 Sep 2025 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eYmrfori"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457A81B21BD;
	Thu,  4 Sep 2025 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991889; cv=none; b=IYg4p+D8C333ndpw01e/Apc/abE+xHpUq1TWL3nt0N4wGPtvI6NMTtUph1wLsTAlBX5nWccoktHMU3WB4L71NLf21fy1UHTOMe+WHDxtoGCCyiWvfmg869kxOD2tytWe9aM1fPIjN40d6T5R6+7LoEw5zzM5vRyEEcXWTfP7UcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991889; c=relaxed/simple;
	bh=yznnBoXwsc/vB4GgOEn9ieqh2kvUOUfe5kKbuGB6wQQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FAaEhisWrMtKj4INsB9eiPpU/YiYztUlO5cNjOvRyTpCvMASblRl0cpFAIsuLO8sKWB11uJAWGZITgeVJokDUD38FiMV6PLiGfTYrWcl6SfyBWYhJ3y480Y3atkkHa6DQamdCoGkYAX5q0XOrWHIANJQurvKqXY4w793kfCsSf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eYmrfori; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584DHlhF3018458;
	Thu, 4 Sep 2025 08:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756991867;
	bh=mdOFbaogOROzaCgM5bfoC+kPxgFcXiCDwpNSxKIRLaE=;
	h=From:To:CC:Subject:Date;
	b=eYmrforixj5MTd7cg2K7z/VTaxm5NLT5nBc4Y7pY31L3JVTACsfhk8u3OBRSDNk6e
	 0LM5Apg5yJ8HkJ7tvKt2tw3VqyyYhV4EPsZTmDSckHe3XojgKDdobP8T9x7OCtPD+R
	 mwXi4wriJI7V3wfuZY4QvLuejX9CP7Xtmi+APl5E=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584DHlCw892847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 08:17:47 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 08:17:46 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 08:17:46 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584DHgnX3308904;
	Thu, 4 Sep 2025 08:17:43 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <quic_mdalam@quicinc.com>, <quic_sridsn@quicinc.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <s-k6@ti.com>, <praneeth@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>, <stable@vger.kernel.org>
Subject: [PATCH v3] mtd: spinand: winbond: Fix oob_layout for W25N01JW
Date: Thu, 4 Sep 2025 18:47:41 +0530
Message-ID: <20250904131741.3097897-1-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Fix the W25N01JW's oob_layout according to the datasheet [1]

[1] https://www.winbond.com/hq/product/code-storage-flash-memory/qspinand-flash/?__locale=en&partNo=W25N01JW

Fixes: 6a804fb72de5 ("mtd: spinand: winbond: add support for serial NAND flash")
Cc: Sridharan S N <quic_sridsn@quicinc.com>
Cc: stable@vger.kernel.org
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---

Changes in v3:
 - Fix regions' offset and length aligned for Bad Block Management
   only for section 0
 - Rebase on next
 - Link to v2: https://lore.kernel.org/linux-mtd/20250213060018.2664518-1-s-k6@ti.com/

Changes in v2:
 - Detach patch 3/3 from v1
 - Rebase on next
 - Link to v1: https://lore.kernel.org/linux-mtd/20250102115110.1402440-1-s-k6@ti.com/

---
 drivers/mtd/nand/spi/winbond.c | 37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

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
-- 
2.34.1


