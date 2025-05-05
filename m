Return-Path: <stable+bounces-140597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33404AAAA1B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF593B215B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD6A2DA82D;
	Mon,  5 May 2025 22:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fu8nn1IX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538BA29C341;
	Mon,  5 May 2025 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485235; cv=none; b=knU8D9OLspUQzI+6FmE9sqJ0Q17lN31eB1mRO59R6YDB6IlfJ+weuUkS6RslULZtoSpFR6F+WG+N90R+E42jsd5ejseq974aLZ44G//iBQGYdIGNPVC5jyrkSwIHSvu07L+1r2UkHLHyaJlU21M3ddwYbwggmOxnlCbuAt7xYOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485235; c=relaxed/simple;
	bh=hcwdfhhGaHajzSEOCx6SVqIs1/onTusH1hNuhmcLL/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=He/4uykB+mdYmBeMfzcymKdIwlJ1zq8Iu5lgueCpis8zq/5q1TsAquenRXhOofEwkLxq64CpottC0XWwLNVe0mMz2OXIiN/fLPy1OMb3nR9vF6IkyaUyIH4Vp4uRcKDcGThYDyJdR3Tedd1DZTinYCizunWmpHotqw6XTc5pgzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fu8nn1IX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91147C4CEEF;
	Mon,  5 May 2025 22:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485233;
	bh=hcwdfhhGaHajzSEOCx6SVqIs1/onTusH1hNuhmcLL/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fu8nn1IXzr2gPculoSWFYksyMZRzsQdFfYFEq6hMMLz9uLfrefvvnASJIeZc/o2bq
	 0zXS+SHwOmRvwTSX/rXFaIP75ymwTL+NVypk2rIE8BDQkv35NBrWjqmvWg/yXACNEJ
	 YF3Y2t2p9RvVjCQ6tvdi5dCINVE6c+VTg46/+rzrgod43a5r25CHH9E6VKeqdknXmT
	 lrAbpyqJoMMkhHNQam30JryKKhlbPt9o8MyC7fF2rczajQeeu7KqSq9vOliuZPUz6l
	 SlOTsFSFe7b9EDiEZd+DIH0FN5upV+ka2VrtWI9wPE4zdD9/DjkUz5Vl4lJZPvFOBh
	 N1gcF/P6UHMbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Bin <bin.li@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Ryan Wanner <Ryan.Wanner@microchip.com>,
	Durai Manickam KR <durai.manickamkr@microchip.com>,
	Andrei Simion <andrei.simion@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	alexandre.belloni@bootlin.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 225/486] ARM: at91: pm: fix at91_suspend_finish for ZQ calibration
Date: Mon,  5 May 2025 18:35:01 -0400
Message-Id: <20250505223922.2682012-225-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Li Bin <bin.li@microchip.com>

[ Upstream commit bc4722c3598d0e2c2dbf9609a3d3198993093e2b ]

For sama7g5 and sama7d65 backup mode, we encountered a "ZQ calibrate error"
during recalibrating the impedance in BootStrap.
We found that the impedance value saved in at91_suspend_finish() before
the DDR entered self-refresh mode did not match the resistor values. The
ZDATA field in the DDR3PHY_ZQ0CR0 register uses a modified gray code to
select the different impedance setting.
But these gray code are incorrect, a workaournd from design team fixed the
bug in the calibration logic. The ZDATA contains four independent impedance
elements, but the algorithm combined the four elements into one. The elements
were fixed using properly shifted offsets.

Signed-off-by: Li Bin <bin.li@microchip.com>
[nicolas.ferre@microchip.com: fix indentation and combine 2 patches]
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Tested-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Tested-by: Durai Manickam KR <durai.manickamkr@microchip.com>
Tested-by: Andrei Simion <andrei.simion@microchip.com>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Link: https://lore.kernel.org/r/28b33f9bcd0ca60ceba032969fe054d38f2b9577.1740671156.git.Ryan.Wanner@microchip.com
Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-at91/pm.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 05a1547642b60..6c3e6aa22606f 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -545,11 +545,12 @@ extern u32 at91_pm_suspend_in_sram_sz;
 
 static int at91_suspend_finish(unsigned long val)
 {
-	unsigned char modified_gray_code[] = {
-		0x00, 0x01, 0x02, 0x03, 0x06, 0x07, 0x04, 0x05, 0x0c, 0x0d,
-		0x0e, 0x0f, 0x0a, 0x0b, 0x08, 0x09, 0x18, 0x19, 0x1a, 0x1b,
-		0x1e, 0x1f, 0x1c, 0x1d, 0x14, 0x15, 0x16, 0x17, 0x12, 0x13,
-		0x10, 0x11,
+	/* SYNOPSYS workaround to fix a bug in the calibration logic */
+	unsigned char modified_fix_code[] = {
+		0x00, 0x01, 0x01, 0x06, 0x07, 0x0c, 0x06, 0x07, 0x0b, 0x18,
+		0x0a, 0x0b, 0x0c, 0x0d, 0x0d, 0x0a, 0x13, 0x13, 0x12, 0x13,
+		0x14, 0x15, 0x15, 0x12, 0x18, 0x19, 0x19, 0x1e, 0x1f, 0x14,
+		0x1e, 0x1f,
 	};
 	unsigned int tmp, index;
 	int i;
@@ -560,25 +561,25 @@ static int at91_suspend_finish(unsigned long val)
 		 * restore the ZQ0SR0 with the value saved here. But the
 		 * calibration is buggy and restoring some values from ZQ0SR0
 		 * is forbidden and risky thus we need to provide processed
-		 * values for these (modified gray code values).
+		 * values for these.
 		 */
 		tmp = readl(soc_pm.data.ramc_phy + DDR3PHY_ZQ0SR0);
 
 		/* Store pull-down output impedance select. */
 		index = (tmp >> DDR3PHY_ZQ0SR0_PDO_OFF) & 0x1f;
-		soc_pm.bu->ddr_phy_calibration[0] = modified_gray_code[index];
+		soc_pm.bu->ddr_phy_calibration[0] = modified_fix_code[index] << DDR3PHY_ZQ0SR0_PDO_OFF;
 
 		/* Store pull-up output impedance select. */
 		index = (tmp >> DDR3PHY_ZQ0SR0_PUO_OFF) & 0x1f;
-		soc_pm.bu->ddr_phy_calibration[0] |= modified_gray_code[index];
+		soc_pm.bu->ddr_phy_calibration[0] |= modified_fix_code[index] << DDR3PHY_ZQ0SR0_PUO_OFF;
 
 		/* Store pull-down on-die termination impedance select. */
 		index = (tmp >> DDR3PHY_ZQ0SR0_PDODT_OFF) & 0x1f;
-		soc_pm.bu->ddr_phy_calibration[0] |= modified_gray_code[index];
+		soc_pm.bu->ddr_phy_calibration[0] |= modified_fix_code[index] << DDR3PHY_ZQ0SR0_PDODT_OFF;
 
 		/* Store pull-up on-die termination impedance select. */
 		index = (tmp >> DDR3PHY_ZQ0SRO_PUODT_OFF) & 0x1f;
-		soc_pm.bu->ddr_phy_calibration[0] |= modified_gray_code[index];
+		soc_pm.bu->ddr_phy_calibration[0] |= modified_fix_code[index] << DDR3PHY_ZQ0SRO_PUODT_OFF;
 
 		/*
 		 * The 1st 8 words of memory might get corrupted in the process
-- 
2.39.5


