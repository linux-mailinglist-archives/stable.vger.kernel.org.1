Return-Path: <stable+bounces-120099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9139A4C739
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0ECD1884BA5
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D772153DA;
	Mon,  3 Mar 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDyeuGs/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F3F215193;
	Mon,  3 Mar 2025 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019397; cv=none; b=spiArnfIjOAkICTxr++MZI7p+fuC5GkE/YkgpZ3tXl22YmETnBgRMDND4m/3kuVYLwm2KfJaK/YLKgxXoacVeMQwYzI9V6F4BRFuJQz6XkxB3JPv7P1NFH5hDcXQwH0jwcpdZcXFeepSYhl8PRdT3lUWI6wReoxgD/aKRQv6qLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019397; c=relaxed/simple;
	bh=4M7qw2BCNap/yj1lp7E2M6gYvaxv2EvIQCTCMGBcr1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kHOCPMsj4LX1DggPh3MmvEJYRgBLMWy+iOWe7yYoKH5559iJN6BjhreVxN2woOFM0RBaEQz0SqP3bBDD1H0L/gna0RL3uLs2EUTuI7qwJtHCYaIbaghxXhZ3wg5If+76zoJsE9/8xqZOjLHOuc0FuXPD5ERPXCrGuorUFpax/Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDyeuGs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6163C4CEE4;
	Mon,  3 Mar 2025 16:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019396;
	bh=4M7qw2BCNap/yj1lp7E2M6gYvaxv2EvIQCTCMGBcr1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDyeuGs/lYdy9CEYKCM/ru1OX9ND1XpgOwioW8WGgWWi8arNr8kamubWshaSLhRI7
	 Wa8N0nuKMAvSiwzYzfZBdJN6BOoi9YYIsG3eIknET8wOdeLCO6i2caFkiZwExTgvBB
	 2fZbORAnQN2ChgWBmy2ZKKfxPb4PKPogBV7Wchst6pg4J9q4KSlsDcn2iOxS6ylUE0
	 QxQ/O+SPOcqVjj/SeoE4OwiCqUDkpM21R8dtPKKpTYt+pqq7KhEkxra2r7pPjYKZ6Z
	 lvASnPNtrCq11vA5K8sLl3y7Ko1gRa5tPmE573cRL2SwxxTuotQXsC7/sgLAv7SgvI
	 k6kQhApGHPHEA==
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
Subject: [PATCH AUTOSEL 6.13 02/17] ASoC: tas2770: Fix volume scale
Date: Mon,  3 Mar 2025 11:29:34 -0500
Message-Id: <20250303162951.3763346-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303162951.3763346-1-sashal@kernel.org>
References: <20250303162951.3763346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.5
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
index 9f93b230652a5..863c3f672ba98 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -506,7 +506,7 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 }
 
 static DECLARE_TLV_DB_SCALE(tas2770_digital_tlv, 1100, 50, 0);
-static DECLARE_TLV_DB_SCALE(tas2770_playback_volume, -12750, 50, 0);
+static DECLARE_TLV_DB_SCALE(tas2770_playback_volume, -10050, 50, 0);
 
 static const struct snd_kcontrol_new tas2770_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Playback Volume", TAS2770_PLAY_CFG_REG2,
-- 
2.39.5


