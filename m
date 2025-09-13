Return-Path: <stable+bounces-179500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11263B561C1
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 17:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88FE567272
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 15:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E962C2EFD8F;
	Sat, 13 Sep 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9aqj5eb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E102DC76D
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757776757; cv=none; b=b4XHeNTucuI2WyzuwVL5/PyJgEvxs/0CuBMH53eZegv9gXeDBmjyB0KZwue0eKuCfgkjviKR6LkBrt0dovsS56MPG9fc9kVFzCy2XtWerRN8vh5Shu6QIL+bdK/9c0she3HdycwIA2M2oHwc2yaeDJ2XUOmBb1qQpysGyNwrMeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757776757; c=relaxed/simple;
	bh=trwGbtfBdkIArghEwN/wTbSWyQSbzzjK3z6pz4SI34c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNHr9MFj7ipBf8XY59l7KKAbFSjg1IJOaFGlmg6dTQ/vQ93TowIC7CsD5DwcXbSNIZJk5cNT+51eY3sDgx0ewMfyHZNW1CfzfbYtvsgUAJQmxChE8T8FQr2BCU397G+8CYavBnEKijuVOaqQzMlAJalznIiHmP+ErQgb04bhqlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9aqj5eb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3204C4CEF5;
	Sat, 13 Sep 2025 15:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757776755;
	bh=trwGbtfBdkIArghEwN/wTbSWyQSbzzjK3z6pz4SI34c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i9aqj5ebcM1CtinDHhaeKzS2wyxXI7sNFsnYL/MR3ynlqq0UhayCeZFyMeZ26UAUx
	 nr4u8ps0g1vP272ObZqxDfICPzbvn2A3/rrg3SUj7JkKW3SqgNQ9ccNaQNunehuwJt
	 IYKPRVOIA778m52B+dguMY+zJ/j593MdNPkmXYMQSvXeAfRTpN8JvcxZsRMl1ZZ9wq
	 hB2+FVDOX4DJbOEWW1SNEivp5YpW1MWgn5tPGMtC60g3VAjYVLtyaBeWOKnKA5jw1l
	 /rjAcIIx/1KSwWpU67gkvw7f+4MetkXlmVxZ8zjgDiWefH9cHeV3RzDVjIIU/EszKf
	 TCn0CmHcnU+lA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Alexander Dahl <ada@thorsis.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] mtd: nand: raw: atmel: Respect tAR, tCLR in read setup timing
Date: Sat, 13 Sep 2025 11:19:09 -0400
Message-ID: <20250913151909.1412861-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913151909.1412861-1-sashal@kernel.org>
References: <2025091346-museum-immunity-ab3d@gregkh>
 <20250913151909.1412861-1-sashal@kernel.org>
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
index b2cc7ff9ed1c6..179696ea6f573 100644
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


