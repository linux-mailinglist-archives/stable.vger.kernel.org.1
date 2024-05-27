Return-Path: <stable+bounces-46313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C228D015E
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569A3280BEC
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 13:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD1515F319;
	Mon, 27 May 2024 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VO3FTXkQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3566C15F30B;
	Mon, 27 May 2024 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816308; cv=none; b=GKno8AQA2Cxz8lk6ux5L/qo9D63ugs9wueu1XGmQz0xy7Ziu+zljaEUG24TaGFBPyev+mBoa0gEhhZxfVe6Xy9C+xFSDRxGv1VlXJLvKgFj6K3j/YXCxGsVlsqGfGRwDFXZ8VFEu2dFPqMHWUNpTUkjTLkfI+ghnGaIB5WlOIO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816308; c=relaxed/simple;
	bh=EIaUMYWuRe8562D/Mf8UlCvMzsjv6hJ90LrIKb7TGmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/VMTwWZ3qJIoWkvMx/KRYGbgU/PWiHlhQJ1mKcAO2MLmy2LcgXO3Bsz6tIgbNUzSsl/sTL93sIY9w+oMozZQwVWPl0+iagbHobzBHChmVINd/42XUDhMoXNDmjGRW8zQFAcgKrspydOJwnp1tfoHfBXp3QAY/pn7gKunkCjOTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VO3FTXkQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716816307; x=1748352307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EIaUMYWuRe8562D/Mf8UlCvMzsjv6hJ90LrIKb7TGmY=;
  b=VO3FTXkQVPOCIxPpXlb6q0iHwEESzU+twtoTRMRVSKiVy7mAX4FHIZm+
   zuQu2mmiefMDdZaVs8dsKnsqk2VeneipapGTcskWyOBeeJdj1Zm/byWJg
   l5J6hQ7yBMvjXDblRbqHF69BUGwXQsWakdMAGb3Aa+miEU4aa/Ro9jzXs
   psu++altdXaPZoNh/K1Cx0bIegHPLKcn7BXNZm7TMR1k0C+ngJ7Uy5Cr+
   Oti3O0WPZbTXQKoJiQ+/k5LAinjfTkZCbQDAT6JbmZTnkNOQeYoNEUWZw
   zu/jsypfbXYOYy2V5grHSCUazwRbWZenVcA3YKNOio6Xq4ot1MCT0EMk6
   g==;
X-CSE-ConnectionGUID: g/gb+7PjT1C1JV1jFLDPCQ==
X-CSE-MsgGUID: LhZBoK91QyamNqlN6P1McA==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="16969419"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="16969419"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:25:07 -0700
X-CSE-ConnectionGUID: qazZSeGERtqEaOe0w5u2sw==
X-CSE-MsgGUID: nUvmhy5MRBekUUvy1hkmhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="34670162"
Received: from unknown (HELO localhost) ([10.245.247.140])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:25:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Chevron Li <chevron.li@bayhubtech.com>,
	Dinghao Liu <dinghao.liu@zju.edu.cn>,
	Adam Lee <adam.lee@canonical.com>,
	Chris Ball <chris@printf.net>,
	Peter Guo <peter.guo@bayhubtech.com>,
	Jennifer Li <Jennifer.li@o2micro.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] mmc: sdhci-pci-o2micro: Convert PCIBIOS_* return codes to errnos
Date: Mon, 27 May 2024 16:24:42 +0300
Message-Id: <20240527132443.14038-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240527132443.14038-1-ilpo.jarvinen@linux.intel.com>
References: <20240527132443.14038-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sdhci_pci_o2_probe() uses pci_read_config_{byte,dword}() that return
PCIBIOS_* codes. The return code is then returned as is but as
sdhci_pci_o2_probe() is probe function chain, it should return normal
errnos.

Convert PCIBIOS_* returns code using pcibios_err_to_errno() into normal
errno before returning them. Add a label for read failure so that the
conversion can be done in one place rather than on all of the return
statements.

Fixes: 3d757ddbd68c ("mmc: sdhci-pci-o2micro: add Bayhub new chip GG8 support for UHS-I")
Fixes: d599005afde8 ("mmc: sdhci-pci-o2micro: Add missing checks in sdhci_pci_o2_probe")
Fixes: 706adf6bc31c ("mmc: sdhci-pci-o2micro: Add SeaBird SeaEagle SD3 support")
Fixes: 01acf6917aed ("mmc: sdhci-pci: add support of O2Micro/BayHubTech SD hosts")
Fixes: 26daa1ed40c6 ("mmc: sdhci: Disable ADMA on some O2Micro SD/MMC parts.")
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 41 +++++++++++++++-------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index d4a02184784a..058bef1c7e41 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -823,7 +823,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		ret = pci_read_config_byte(chip->pdev,
 				O2_SD_LOCK_WP, &scratch);
 		if (ret)
-			return ret;
+			goto read_fail;
 		scratch &= 0x7f;
 		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
 
@@ -834,7 +834,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		ret = pci_read_config_byte(chip->pdev,
 				O2_SD_CLKREQ, &scratch);
 		if (ret)
-			return ret;
+			goto read_fail;
 		scratch |= 0x20;
 		pci_write_config_byte(chip->pdev, O2_SD_CLKREQ, scratch);
 
@@ -843,7 +843,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		 */
 		ret = pci_read_config_byte(chip->pdev, O2_SD_CAPS, &scratch);
 		if (ret)
-			return ret;
+			goto read_fail;
 		scratch |= 0x01;
 		pci_write_config_byte(chip->pdev, O2_SD_CAPS, scratch);
 		pci_write_config_byte(chip->pdev, O2_SD_CAPS, 0x73);
@@ -856,7 +856,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		ret = pci_read_config_byte(chip->pdev,
 				O2_SD_INF_MOD, &scratch);
 		if (ret)
-			return ret;
+			goto read_fail;
 		scratch |= 0x08;
 		pci_write_config_byte(chip->pdev, O2_SD_INF_MOD, scratch);
 
@@ -864,7 +864,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		ret = pci_read_config_byte(chip->pdev,
 				O2_SD_LOCK_WP, &scratch);
 		if (ret)
-			return ret;
+			goto read_fail;
 		scratch |= 0x80;
 		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
 		break;
@@ -875,7 +875,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		ret = pci_read_config_byte(chip->pdev,
 				O2_SD_LOCK_WP, &scratch);
 		if (ret)
-			return ret;
+			goto read_fail;
 
 		scratch &= 0x7f;
 		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
@@ -886,7 +886,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 						    O2_SD_FUNC_REG0,
 						    &scratch_32);
 			if (ret)
-				return ret;
+				goto read_fail;
 			scratch_32 = ((scratch_32 & 0xFF000000) >> 24);
 
 			/* Check Whether subId is 0x11 or 0x12 */
@@ -898,7 +898,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 							    O2_SD_FUNC_REG4,
 							    &scratch_32);
 				if (ret)
-					return ret;
+					goto read_fail;
 
 				/* Enable Base Clk setting change */
 				scratch_32 |= O2_SD_FREG4_ENABLE_CLK_SET;
@@ -921,7 +921,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		ret = pci_read_config_dword(chip->pdev,
 					    O2_SD_CLK_SETTING, &scratch_32);
 		if (ret)
-			return ret;
+			goto read_fail;
 
 		scratch_32 &= ~(0xFF00);
 		scratch_32 |= 0x07E0C800;
@@ -931,14 +931,14 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		ret = pci_read_config_dword(chip->pdev,
 					    O2_SD_CLKREQ, &scratch_32);
 		if (ret)
-			return ret;
+			goto read_fail;
 		scratch_32 |= 0x3;
 		pci_write_config_dword(chip->pdev, O2_SD_CLKREQ, scratch_32);
 
 		ret = pci_read_config_dword(chip->pdev,
 					    O2_SD_PLL_SETTING, &scratch_32);
 		if (ret)
-			return ret;
+			goto read_fail;
 
 		scratch_32 &= ~(0x1F3F070E);
 		scratch_32 |= 0x18270106;
@@ -949,7 +949,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		ret = pci_read_config_dword(chip->pdev,
 					    O2_SD_CAP_REG2, &scratch_32);
 		if (ret)
-			return ret;
+			goto read_fail;
 		scratch_32 &= ~(0xE0);
 		pci_write_config_dword(chip->pdev,
 				       O2_SD_CAP_REG2, scratch_32);
@@ -961,7 +961,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		ret = pci_read_config_byte(chip->pdev,
 					   O2_SD_LOCK_WP, &scratch);
 		if (ret)
-			return ret;
+			goto read_fail;
 		scratch |= 0x80;
 		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
 		break;
@@ -971,7 +971,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		ret = pci_read_config_byte(chip->pdev,
 				O2_SD_LOCK_WP, &scratch);
 		if (ret)
-			return ret;
+			goto read_fail;
 
 		scratch &= 0x7f;
 		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
@@ -979,7 +979,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		ret = pci_read_config_dword(chip->pdev,
 					    O2_SD_PLL_SETTING, &scratch_32);
 		if (ret)
-			return ret;
+			goto read_fail;
 
 		if ((scratch_32 & 0xff000000) == 0x01000000) {
 			scratch_32 &= 0x0000FFFF;
@@ -998,7 +998,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 						    O2_SD_FUNC_REG4,
 						    &scratch_32);
 			if (ret)
-				return ret;
+				goto read_fail;
 			scratch_32 |= (1 << 22);
 			pci_write_config_dword(chip->pdev,
 					       O2_SD_FUNC_REG4, scratch_32);
@@ -1017,7 +1017,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		ret = pci_read_config_byte(chip->pdev,
 					   O2_SD_LOCK_WP, &scratch);
 		if (ret)
-			return ret;
+			goto read_fail;
 		scratch |= 0x80;
 		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
 		break;
@@ -1028,7 +1028,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		/* UnLock WP */
 		ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
 		if (ret)
-			return ret;
+			goto read_fail;
 		scratch &= 0x7f;
 		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
 
@@ -1057,13 +1057,16 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		/* Lock WP */
 		ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
 		if (ret)
-			return ret;
+			goto read_fail;
 		scratch |= 0x80;
 		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
 		break;
 	}
 
 	return 0;
+
+read_fail:
+	return pcibios_err_to_errno(ret);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.39.2


