Return-Path: <stable+bounces-179485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE077B56158
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 16:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67EAA584A6B
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EAD2EFDB9;
	Sat, 13 Sep 2025 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbbyMugD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716831E515
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757772621; cv=none; b=s44ubrtgD69yyRxSMYKkkwpatUhraYyFzDR6E+MRm3j+cmwweSQVgBsRr8TvyAWI6RihnrSkv+erGOS2Rfs6ItWb5wHta178Upv2W6O3B3uaChJqsh3lYWmn7h7SCXdZLk8X9hSpps0lbBtAkZAITh27vkIgVM8B1T8kEaF6fNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757772621; c=relaxed/simple;
	bh=hu7IZppgnjMfQWi40Dg44wKmiy+SGW9k+fHdqMCNIiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccjUiIPHiKQv9QyTsPla2eLCuyunQrfFd4FmrxoRCmnWdyD58OcwSNtpLFqmGPm99WmxV/9wUKXBsdvNPe5wmvD4ewaw/ktNGZqmShUmLEDJbMnIYWFXTf5uG/AttpZYmseuA7m3AGal/QS10Hl8vwxzVsk/skUTlZAg9eh+34M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbbyMugD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E979C4CEF4;
	Sat, 13 Sep 2025 14:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757772621;
	bh=hu7IZppgnjMfQWi40Dg44wKmiy+SGW9k+fHdqMCNIiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UbbyMugDslJk6Bul6E0OmO7j8ezP5tVRM/BCmS8PQDSx8CU6/ZcX5CkTIlK4a4yuh
	 iY71t5+oqDND4ROuAXCm0r1p5Fa6tOJjU+xuMHQD22lQ1GYGFNnQnxkSHmjIhimxH8
	 ULK1pGnmUQlPliDdGM9eyXmO1jZVDKlDZ1GgI0kzck7mCRMHtfn2rcXHa9ymvH0meX
	 UddTOQwIOQFOzh09QfQB0fCwZkBkcDruoHpeHKlJ3EGblnzivBUpfXsLge9gPnfEhq
	 LB5x+LSMutTCcLXUOvmPTcRS0Hkc1D0jZT9gPmLjuW4xGoGNbuWAYymcH+RSnKic9M
	 S3Cl0ObLUxhiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Alexander Dahl <ada@thorsis.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] mtd: nand: raw: atmel: Respect tAR, tCLR in read setup timing
Date: Sat, 13 Sep 2025 10:10:17 -0400
Message-ID: <20250913141017.1361840-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913141017.1361840-1-sashal@kernel.org>
References: <2025091345-disinfect-afterlife-38dd@gregkh>
 <20250913141017.1361840-1-sashal@kernel.org>
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
index 6e4a0c6c7cb4d..c5aff27ec4a89 100644
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


