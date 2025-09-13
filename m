Return-Path: <stable+bounces-179498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB06AB561BD
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 17:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22181BC2867
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0231347C7;
	Sat, 13 Sep 2025 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAuqK9jE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DAD2EBB98
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757776377; cv=none; b=eDJm4uYKAiIBaV7dBhrwPG3sdixPkiHZ7jmphTJidQc9ucwE2Zkfk+jxvGjEWmKJ5hxVuJpPYqCysuUOHtQp67TzIwwdhVn4Kxy7fFz09SKTUVp1g4N3QIE8K61P9zX8G95jP+kxPxoSp6vpPP01+M05NahWw0CQoaWjH+Khs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757776377; c=relaxed/simple;
	bh=JI+I78vD+l37O9obdpd8UwgwgrK9vk51UgmAWOKl9uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWYb81bhxDy0z6M1DGlrMb0TGa6FbNnJ4ZTIkiraEOVdqFK0kFuSqhilXGqssRV3JQgizryXQiUEY04RmoBjWEs0Axksk1C8Pd02I5mrd78vaAWitYmHA9dqvuxvSf2R80kCftTydNnF88YnSdM5uqOOqXsuDEbkjvnZVMr582Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAuqK9jE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FABEC4CEF5;
	Sat, 13 Sep 2025 15:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757776377;
	bh=JI+I78vD+l37O9obdpd8UwgwgrK9vk51UgmAWOKl9uQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YAuqK9jEv33lyhlVtQx3QO6FNR9BHlDlwRlZYlD2gOYl0IaBLa+LGMVyVm5+Ot5KM
	 rzpTGEXnQwb8veLQCUCK+Jr/K5/Onl9Gw0PDDhyv3MajjjSyHLXmOKCEzoZBVy1s3H
	 xCweYFq+hO/WQTH4k+/tPPILp7Dcg8/tPvDeJopCiB9sIZ5pkwiCrNR3roaLtVFTtz
	 UNUXYR2c6n96yKB+cSZIDl5m8v1AGi82sKfqpcA2BWP8pQh89hYIl9hKksEbvldeYi
	 OIlOyTeTmGarVDMKSu9v6tjArGCMe7IyO2+OW882Jr9mUr3VKdRo1g4hwEX0vz5CRS
	 vTGRsJxhOyPvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Alexander Dahl <ada@thorsis.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] mtd: nand: raw: atmel: Respect tAR, tCLR in read setup timing
Date: Sat, 13 Sep 2025 11:12:51 -0400
Message-ID: <20250913151251.1410237-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913151251.1410237-1-sashal@kernel.org>
References: <2025091346-coral-alphabet-9d67@gregkh>
 <20250913151251.1410237-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

[ Upstream commit fd779eac2d659668be4d3dbdac0710afd5d6db12 ]

Having setup time 0 violates tAR, tCLR of some chips, for instance
TOSHIBA TC58NVG2S3ETAI0 cannot be detected successfully (first ID byte
being read duplicated, i.e. 98 98 dc 90 15 76 14 03 instead of
98 dc 90 15 76 ...).

Atmel Application Notes postulated 1 cycle NRD_SETUP without explanation
[1], but it looks more appropriate to just calculate setup time properly.

[1] Link: https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ApplicationNotes/ApplicationNotes/doc6255.pdf

Cc: stable@vger.kernel.org
Fixes: f9ce2eddf176 ("mtd: nand: atmel: Add ->setup_data_interface() hooks")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Tested-by: Alexander Dahl <ada@thorsis.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 48d6194efeb7d..81f834547c60f 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1377,14 +1377,24 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
 	if (ret)
 		return ret;
 
+	/*
+	 * Read setup timing depends on the operation done on the NAND:
+	 *
+	 * NRD_SETUP = max(tAR, tCLR)
+	 */
+	timeps = max(conf->timings.sdr.tAR_min, conf->timings.sdr.tCLR_min);
+	ncycles = DIV_ROUND_UP(timeps, mckperiodps);
+	totalcycles += ncycles;
+	ret = atmel_smc_cs_conf_set_setup(smcconf, ATMEL_SMC_NRD_SHIFT, ncycles);
+	if (ret)
+		return ret;
+
 	/*
 	 * The read cycle timing is directly matching tRC, but is also
 	 * dependent on the setup and hold timings we calculated earlier,
 	 * which gives:
 	 *
-	 * NRD_CYCLE = max(tRC, NRD_PULSE + NRD_HOLD)
-	 *
-	 * NRD_SETUP is always 0.
+	 * NRD_CYCLE = max(tRC, NRD_SETUP + NRD_PULSE + NRD_HOLD)
 	 */
 	ncycles = DIV_ROUND_UP(conf->timings.sdr.tRC_min, mckperiodps);
 	ncycles = max(totalcycles, ncycles);
-- 
2.51.0


