Return-Path: <stable+bounces-120161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4730CA4C876
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFACE3AB5CC
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC6120E32A;
	Mon,  3 Mar 2025 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OH/OZcpZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A7022F39C;
	Mon,  3 Mar 2025 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019535; cv=none; b=YJjvK3wNLdfgnhds1MNth/zAXeuCmcTMEJHxtt2pan5Tq8GsrED22wFRnku4jChfP2/0mTZO2+U9g6OXylIT/2p3oqOvcLPyVZco7qhE+gkN93KJuApqiAnAl0QUmmkfLwSOjxLCXDwmpUGYRZPaLGDCUAIlByeKBq4b74JdeZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019535; c=relaxed/simple;
	bh=OrVlZo9pvd3tNjmzU0jqNp5N6UHd0Nx5356OwLfizdU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DSPk8QkfbveoECLEGU6g4+QmGJyR+wNm51niyaFr3D9AU7N04iekfJvquajpCMRmjM3ane5EOk+MtxqnCGm5fpdrls7jdeDzli22cUUibkJg21Aiq8kNCSumhF2cksJOKT3OzIUsLsY6URPsrYIxfLNiNGmDe0r66TLmxo1z9e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OH/OZcpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE1DC4CEE4;
	Mon,  3 Mar 2025 16:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019534;
	bh=OrVlZo9pvd3tNjmzU0jqNp5N6UHd0Nx5356OwLfizdU=;
	h=From:To:Cc:Subject:Date:From;
	b=OH/OZcpZtGmOGnFarr0t6mlSJRI0Jz2BsmP0czoCx5vqaU8Oj1ZzvEKefXUzFPJ4U
	 PUOwiGlPXCoes+hHLU1eElRmZoMfPPgWo9SFPMqRbMKp20O9o+nowhkz8yXaX2FtuN
	 NyMoNK4prA5tvZUX9fORNK8wvWa/kpwZ9yyNK6cQThUmx4Uy4q+vQIU3Cj/u44SRDM
	 CHcS7eU/bTn98tVIjaQUJ4Aka8P/uKS5oUaMHIcYjmkxWaYkXp2Oou+6BM+tAxDdxS
	 d/pB7QMjGfczg49t7TtqFVjcP9Iof15M+VWLG5buFvpTqUiFFYpwkOsPEWug9LV9QF
	 kJo+2aH2cMfhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hector Martin <marcan@marcan.st>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/8] ASoC: tas2770: Fix volume scale
Date: Mon,  3 Mar 2025 11:32:04 -0500
Message-Id: <20250303163211.3764282-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

[ Upstream commit 579cd64b9df8a60284ec3422be919c362de40e41 ]

The scale starts at -100dB, not -128dB.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20250208-asoc-tas2770-v1-1-cf50ff1d59a3@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2770.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index c213c8096142b..1928c1616a52d 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -508,7 +508,7 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 }
 
 static DECLARE_TLV_DB_SCALE(tas2770_digital_tlv, 1100, 50, 0);
-static DECLARE_TLV_DB_SCALE(tas2770_playback_volume, -12750, 50, 0);
+static DECLARE_TLV_DB_SCALE(tas2770_playback_volume, -10050, 50, 0);
 
 static const struct snd_kcontrol_new tas2770_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Playback Volume", TAS2770_PLAY_CFG_REG2,
-- 
2.39.5


