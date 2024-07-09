Return-Path: <stable+bounces-58767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEA592BF9B
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF442896A5
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED8B19EED7;
	Tue,  9 Jul 2024 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IL91PUne"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF5F19DFA7;
	Tue,  9 Jul 2024 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542020; cv=none; b=sUnEmIuJlsMuF5HiBLJmEeCXO22Yy7bCPNu0LPpl+Zl1KbUM8bnvhsk8HFEh6xyq19GGcxdIkEWtuRwVf2zFu4LgBb4ghMRyT/sEC+ny7MhKYhNJKb/WpsLHENAQKy7oOgTkKYwPrwzrMMDmMbeDxfI9AmF9hAOM7aJXU64URPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542020; c=relaxed/simple;
	bh=GAdJyg/t38Jh7c8PeQLFqjacbfI4U5ivP6tbZgai9yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnbNEE1Cs3r80y5DVJO5Jm8GWHUNvxJLOQwlRzbLAeqJQt8aRsmAwjiLJXcyL2yIeXKcbPvqBUrCop92SyNcS5K0jpZpfQ3IAupkcCnz4iowmIxf9fTKBR1ZOMTeYiAcmxeKfVk1Ey49Ar+BxbpibAXHdBuhzW4YUlwhQ6fDXQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IL91PUne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93625C4AF0D;
	Tue,  9 Jul 2024 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542019;
	bh=GAdJyg/t38Jh7c8PeQLFqjacbfI4U5ivP6tbZgai9yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IL91PUneSwcUOnrAVW/by6/fGociTvjh2W05olndFAb+56NymdVITb6H5J6NhwvoO
	 1vnapbpTue6Q0cwYNGIl4Y8QWh7ad7HS9RI3Ws7geDf4IozozArHljKIeS6D0D8Rbn
	 M9uvlLzl0UWgkAot6AKGrMGmE7p4U6YueT+EUUexwyfl9oZ7cICzd8vfpGIZsBbSej
	 sa5Ttgmp37aq4VFnLMDc9kTK1oG3Gsm0cUUBnbaPDOjlQAUmhSNITGyDsRjvvcUPQN
	 N8IJgHM29V3ceJwhnQvZ6A4CXFmNiRAzowDFzE3KqxEKWdZuMbnRHVmn6h5zp55tKT
	 rR4D0xCwzWFlg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <zhangyi@everest-semi.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	zhuning0077@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 05/40] ASoC: codecs: ES8326: Solve headphone detection issue
Date: Tue,  9 Jul 2024 12:18:45 -0400
Message-ID: <20240709162007.30160-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
References: <20240709162007.30160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.8
Content-Transfer-Encoding: 8bit

From: Zhang Yi <zhangyi@everest-semi.com>

[ Upstream commit b7c40988808f8d7426dee1e4d96a4e204de4a8bc ]

When switching between OMTP and CTIA headset, we can hear pop noise.
To solve this issue, We modified the configuration for headphone detection

Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
Link: https://msgid.link/r/20240604021946.2911-1-zhangyi@everest-semi.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/es8326.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
index 17bd6b5160772..8b2328d5d0c74 100644
--- a/sound/soc/codecs/es8326.c
+++ b/sound/soc/codecs/es8326.c
@@ -865,12 +865,16 @@ static void es8326_jack_detect_handler(struct work_struct *work)
 			 * set auto-check mode, then restart jack_detect_work after 400ms.
 			 * Don't report jack status.
 			 */
-			regmap_write(es8326->regmap, ES8326_INT_SOURCE,
-					(ES8326_INT_SRC_PIN9 | ES8326_INT_SRC_BUTTON));
+			regmap_write(es8326->regmap, ES8326_INT_SOURCE, 0x00);
 			regmap_update_bits(es8326->regmap, ES8326_HPDET_TYPE, 0x03, 0x01);
+			regmap_update_bits(es8326->regmap, ES8326_HPDET_TYPE, 0x10, 0x00);
 			es8326_enable_micbias(es8326->component);
 			usleep_range(50000, 70000);
 			regmap_update_bits(es8326->regmap, ES8326_HPDET_TYPE, 0x03, 0x00);
+			regmap_update_bits(es8326->regmap, ES8326_HPDET_TYPE, 0x10, 0x10);
+			usleep_range(50000, 70000);
+			regmap_write(es8326->regmap, ES8326_INT_SOURCE,
+					(ES8326_INT_SRC_PIN9 | ES8326_INT_SRC_BUTTON));
 			regmap_write(es8326->regmap, ES8326_SYS_BIAS, 0x1f);
 			regmap_update_bits(es8326->regmap, ES8326_HP_DRIVER_REF, 0x0f, 0x08);
 			queue_delayed_work(system_wq, &es8326->jack_detect_work,
-- 
2.43.0


