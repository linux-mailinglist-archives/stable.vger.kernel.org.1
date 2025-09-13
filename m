Return-Path: <stable+bounces-179504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA92B561CA
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 17:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6846D584FC4
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 15:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588122F28EE;
	Sat, 13 Sep 2025 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfIrpqCK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CEC6FC5
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757776993; cv=none; b=Wx1J8VM0m2NeQr1lVocsikV7GnkdaQoNxxAajuLx3dwh+emaT1WLmnXd6c5y3VwYpG/AZUTs1SSp4hSLgPDDGO/t9Unw/YDBLovYUHLNqLYWAf7qHKfsEZ653achkOcgN5eu2iQ1m3j+bSMvQaiim4G/7QLY8X7dNtVKhao1www=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757776993; c=relaxed/simple;
	bh=GD63cAKORPVbcmOiA3JkBR7vH8sJzSawf+AiF50E+iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dg/hPO32FNlfQn+NX9/J8YRsNrqQ09Y0+98aGQSlBz1vEpwL2SRCzglh7Vrg+tDEuz5D4q+uMdQy0l+l4IhebjNRieR/LZijT4/dGTaqWtYwBMjktUNFrCtSWlX/KhA3+gkAzXyciSX5BJtt4IfwT0f3iJCBRwR3iuGWn1Fhq4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfIrpqCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E248C4CEF9;
	Sat, 13 Sep 2025 15:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757776993;
	bh=GD63cAKORPVbcmOiA3JkBR7vH8sJzSawf+AiF50E+iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XfIrpqCKuOtSrJx8UiRvVX7nhyJCgm2JQOIfqBrXT43u7ytHxK6z47XSrDchCEyfv
	 5nyzuyEUrqK17zglr8Drth8yvOEBascl6Gpa+j3M+zTelXCgiTyuz7fftzq0hQiczr
	 QGw+xSZwVRpItBHvy21rl7KBRJ8w/98ojwR159AJaikfmHwMvMJZvxMXKhbpsZLVqK
	 j5oGM1baP3c17Dkm4+XZ474TueMtqHbipaihF31YN6iz+kc/Y59nZsu5UfXOZ72fGX
	 x2FZJ9fXeAQ3QPMcFxvaEelV93IbLOuyPLNFHnQe/BIthYQZ4AkFV1hYk+P/pMHcGI
	 x33oy3TbsD24w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Alexander Dahl <ada@thorsis.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 2/2] mtd: nand: raw: atmel: Respect tAR, tCLR in read setup timing
Date: Sat, 13 Sep 2025 11:23:07 -0400
Message-ID: <20250913152307.1415556-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913152307.1415556-1-sashal@kernel.org>
References: <2025091346-runaround-croon-39cc@gregkh>
 <20250913152307.1415556-1-sashal@kernel.org>
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
index 2610460cd288c..21fa4f95082cd 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1311,14 +1311,24 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
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


