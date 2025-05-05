Return-Path: <stable+bounces-140125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C827AAA540
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B701677D7
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7872C30EEB1;
	Mon,  5 May 2025 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEyURcEV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3395030EEAD;
	Mon,  5 May 2025 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484153; cv=none; b=cfRvx7IkE2NIlnR2VucFT581yOKzr05D5QODGAWkixv9WSHtVCLcrI+NEWphII0Ixo4Ze3V5sEFmkNVdsCrvfkbD38aniaSlifjhc3h+ykboBGc5VSs1QVs0JcSx7lrvokqDTmy+/zpxY4iRWItrD+np0XfdEm0AUR0XTiai94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484153; c=relaxed/simple;
	bh=D5/l00GmKi7aEsZT1yBQmH6/GnA+gS/ZeQQNwJRFrIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SZpdeKLuhcQx54q9K7W+SIUQZhZPWYLh1QLIkJJF9mvhK37MeXENboI1M1iCSsEADnMeqV5/HpULTW8xM2Y2+I0HRnPkSCFcLmdgNMQoLJTGBe77iUPEbskddV54Nqwl/jumpzgPqsj/yXCiKhu+4IQcuXdOeE26P/jP1F6sVAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEyURcEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1E7C4CEEE;
	Mon,  5 May 2025 22:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484153;
	bh=D5/l00GmKi7aEsZT1yBQmH6/GnA+gS/ZeQQNwJRFrIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IEyURcEVy3YI4f7XaspbilCjVvrJ8w9MvoPIyvtXSdmKx7Rr0uBEFUo0fEqoQbRt3
	 IfOjDhVEihwEjM0rACuSsDzvAQ4dX+IYvN9BBtSY12T+IPXA6JOvbTAiB1HJ2QuFrO
	 c3zgCAW3Y0eYVp7PPYvjDrJEE3eAViThrMmhfjW3yQzwnCX+hQ37JajEtl4ZDp2Ifs
	 SBQyu7+Q/yK4SvyBlcxbE9eavbh+685vG15nDri4mEZ511CrLOrJQI3/F1cwojo5fv
	 rsUZUbsCA5QdLUTLRR+dkBQ2ZUgtUg/ew9pi8L0yww1exREzN16goT6o8sDLeHLtGa
	 hkWLCbicJD4bA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chris Morgan <macromorgan@hotmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	wens@csie.org
Subject: [PATCH AUTOSEL 6.14 378/642] mfd: axp20x: AXP717: Add AXP717_TS_PIN_CFG to writeable regs
Date: Mon,  5 May 2025 18:09:54 -0400
Message-Id: <20250505221419.2672473-378-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

[ Upstream commit bfad07fe298bfba0c7ddab87c5b5325970203a1e ]

Add AXP717_TS_PIN_CFG (register 0x50) to the table of writeable
registers so that the temperature sensor can be configured by the
battery driver.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Link: https://lore.kernel.org/r/20250204155835.161973-3-macroalpha82@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/axp20x.c       | 1 +
 include/linux/mfd/axp20x.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index cff56deba24f0..e9914e8a29a33 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -224,6 +224,7 @@ static const struct regmap_range axp717_writeable_ranges[] = {
 	regmap_reg_range(AXP717_VSYS_V_POWEROFF, AXP717_VSYS_V_POWEROFF),
 	regmap_reg_range(AXP717_IRQ0_EN, AXP717_IRQ4_EN),
 	regmap_reg_range(AXP717_IRQ0_STATE, AXP717_IRQ4_STATE),
+	regmap_reg_range(AXP717_TS_PIN_CFG, AXP717_TS_PIN_CFG),
 	regmap_reg_range(AXP717_ICC_CHG_SET, AXP717_CV_CHG_SET),
 	regmap_reg_range(AXP717_DCDC_OUTPUT_CONTROL, AXP717_CPUSLDO_CONTROL),
 	regmap_reg_range(AXP717_ADC_CH_EN_CONTROL, AXP717_ADC_CH_EN_CONTROL),
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index c3df0e615fbf4..3c5aecf1d4b5b 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -137,6 +137,7 @@ enum axp20x_variants {
 #define AXP717_IRQ2_STATE		0x4a
 #define AXP717_IRQ3_STATE		0x4b
 #define AXP717_IRQ4_STATE		0x4c
+#define AXP717_TS_PIN_CFG		0x50
 #define AXP717_ICC_CHG_SET		0x62
 #define AXP717_ITERM_CHG_SET		0x63
 #define AXP717_CV_CHG_SET		0x64
-- 
2.39.5


