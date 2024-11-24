Return-Path: <stable+bounces-95293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D55A59D74F9
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F66C1653A3
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8847E1B6D0B;
	Sun, 24 Nov 2024 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVIW4yZF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2DB1FECD9;
	Sun, 24 Nov 2024 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456606; cv=none; b=P3Zw3DTRA1ZIymXwr53Ca8HZKNIiCs1gdRnvrYi6pJ57XvvcVh9Rt9XZKSVPcNuSsY7z+ARoWUD8cTxSSNr4eoKbtkTW1nZVmgn3amSVsNeIrSlC2jOSVtdCAYbPoUGesbjs3DPuF92q4GJ+pBOed9oDyzq+3/awO1eIYJLMc3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456606; c=relaxed/simple;
	bh=6PZDqgX5u9z+M5g/tgSxHNGB9bOKQZmNjmoZ2mymlTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+Gu+mwAE4fMSDbR/kAhE/vIQjsGQYW+N2wF3oGiFQFT4C6rbwgFD7+Xu3HlABsbarAgJ8zakKqD2HiJY23bsJp2t7EfasVrIFN5jK0L0CDDPSO8meTaKVCGh6+YXSMtuwiXs9mv3MAIjjtsjRyTQ7ydQO3Oomapr5ZhKzh3QXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVIW4yZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA19C4CED3;
	Sun, 24 Nov 2024 13:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456606;
	bh=6PZDqgX5u9z+M5g/tgSxHNGB9bOKQZmNjmoZ2mymlTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVIW4yZFqC0ZcQei5msbNSjNbtW3j1DF70nWEaQUCECforLWmIUNJHcELhwJkE2DL
	 6GqQ2z257yRMxuj3sqc3wjSHdub8Ou56OLJGiS7joX4XE2jZOvoC1nAkrmQ9iy671k
	 704LQfW7yhl/MZCqINBMfaeRWSlNfNTpbgBZnw+0jIMIO2rVUWZbjTTjmcFgY374zy
	 JUVAlx7jluAFvnyWlKBa2f7jOd0Z0Q2Hi4BnO/SFULp7NhMMN6hRY0LhxG2cTwB+bd
	 OpiGSO6Sl5KoXhXNwwlIy7Ojk52/1CC0pADusm8XnR/YeR+w5Bax+wpYmEr9HMztea
	 lEnJ0GJCYuK2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonas Karlman <jonas@kwiboo.se>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	krzysztof.kozlowski@linaro.org,
	jbrunet@baylibre.com,
	herve.codina@bootlin.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 25/28] ASoC: hdmi-codec: reorder channel allocation list
Date: Sun, 24 Nov 2024 08:55:25 -0500
Message-ID: <20241124135549.3350700-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
Content-Transfer-Encoding: 8bit

From: Jonas Karlman <jonas@kwiboo.se>

[ Upstream commit 82ff5abc2edcfba0c0f1a1be807795e2876f46e9 ]

The ordering in hdmi_codec_get_ch_alloc_table_idx() results in
wrong channel allocation for a number of cases, e.g. when ELD
reports FL|FR|LFE|FC|RL|RR or FL|FR|LFE|FC|RL|RR|RC|RLC|RRC:

ca_id 0x01 with speaker mask FL|FR|LFE is selected instead of
ca_id 0x03 with speaker mask FL|FR|LFE|FC for 4 channels

and

ca_id 0x04 with speaker mask FL|FR|RC gets selected instead of
ca_id 0x0b with speaker mask FL|FR|LFE|FC|RL|RR for 6 channels

Fix this by reordering the channel allocation list with most
specific speaker masks at the top.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Link: https://patch.msgid.link/20241115044344.3510979-1-christianshewitt@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 140 +++++++++++++++++++---------------
 1 file changed, 77 insertions(+), 63 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index f8b5b960e5970..cc6ae76e2132f 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -189,84 +189,97 @@ static const struct snd_pcm_chmap_elem hdmi_codec_8ch_chmaps[] = {
 /*
  * hdmi_codec_channel_alloc: speaker configuration available for CEA
  *
- * This is an ordered list that must match with hdmi_codec_8ch_chmaps struct
+ * This is an ordered list where ca_id must exist in hdmi_codec_8ch_chmaps
  * The preceding ones have better chances to be selected by
  * hdmi_codec_get_ch_alloc_table_idx().
  */
 static const struct hdmi_codec_cea_spk_alloc hdmi_codec_channel_alloc[] = {
 	{ .ca_id = 0x00, .n_ch = 2,
-	  .mask = FL | FR},
-	/* 2.1 */
-	{ .ca_id = 0x01, .n_ch = 4,
-	  .mask = FL | FR | LFE},
-	/* Dolby Surround */
+	  .mask = FL | FR },
+	{ .ca_id = 0x03, .n_ch = 4,
+	  .mask = FL | FR | LFE | FC },
 	{ .ca_id = 0x02, .n_ch = 4,
 	  .mask = FL | FR | FC },
-	/* surround51 */
+	{ .ca_id = 0x01, .n_ch = 4,
+	  .mask = FL | FR | LFE },
 	{ .ca_id = 0x0b, .n_ch = 6,
-	  .mask = FL | FR | LFE | FC | RL | RR},
-	/* surround40 */
-	{ .ca_id = 0x08, .n_ch = 6,
-	  .mask = FL | FR | RL | RR },
-	/* surround41 */
-	{ .ca_id = 0x09, .n_ch = 6,
-	  .mask = FL | FR | LFE | RL | RR },
-	/* surround50 */
+	  .mask = FL | FR | LFE | FC | RL | RR },
 	{ .ca_id = 0x0a, .n_ch = 6,
 	  .mask = FL | FR | FC | RL | RR },
-	/* 6.1 */
-	{ .ca_id = 0x0f, .n_ch = 8,
-	  .mask = FL | FR | LFE | FC | RL | RR | RC },
-	/* surround71 */
+	{ .ca_id = 0x09, .n_ch = 6,
+	  .mask = FL | FR | LFE | RL | RR },
+	{ .ca_id = 0x08, .n_ch = 6,
+	  .mask = FL | FR | RL | RR },
+	{ .ca_id = 0x07, .n_ch = 6,
+	  .mask = FL | FR | LFE | FC | RC },
+	{ .ca_id = 0x06, .n_ch = 6,
+	  .mask = FL | FR | FC | RC },
+	{ .ca_id = 0x05, .n_ch = 6,
+	  .mask = FL | FR | LFE | RC },
+	{ .ca_id = 0x04, .n_ch = 6,
+	  .mask = FL | FR | RC },
 	{ .ca_id = 0x13, .n_ch = 8,
 	  .mask = FL | FR | LFE | FC | RL | RR | RLC | RRC },
-	/* others */
-	{ .ca_id = 0x03, .n_ch = 8,
-	  .mask = FL | FR | LFE | FC },
-	{ .ca_id = 0x04, .n_ch = 8,
-	  .mask = FL | FR | RC},
-	{ .ca_id = 0x05, .n_ch = 8,
-	  .mask = FL | FR | LFE | RC },
-	{ .ca_id = 0x06, .n_ch = 8,
-	  .mask = FL | FR | FC | RC },
-	{ .ca_id = 0x07, .n_ch = 8,
-	  .mask = FL | FR | LFE | FC | RC },
-	{ .ca_id = 0x0c, .n_ch = 8,
-	  .mask = FL | FR | RC | RL | RR },
-	{ .ca_id = 0x0d, .n_ch = 8,
-	  .mask = FL | FR | LFE | RL | RR | RC },
-	{ .ca_id = 0x0e, .n_ch = 8,
-	  .mask = FL | FR | FC | RL | RR | RC },
-	{ .ca_id = 0x10, .n_ch = 8,
-	  .mask = FL | FR | RL | RR | RLC | RRC },
-	{ .ca_id = 0x11, .n_ch = 8,
-	  .mask = FL | FR | LFE | RL | RR | RLC | RRC },
+	{ .ca_id = 0x1f, .n_ch = 8,
+	  .mask = FL | FR | LFE | FC | RL | RR | FLC | FRC },
 	{ .ca_id = 0x12, .n_ch = 8,
 	  .mask = FL | FR | FC | RL | RR | RLC | RRC },
-	{ .ca_id = 0x14, .n_ch = 8,
-	  .mask = FL | FR | FLC | FRC },
-	{ .ca_id = 0x15, .n_ch = 8,
-	  .mask = FL | FR | LFE | FLC | FRC },
-	{ .ca_id = 0x16, .n_ch = 8,
-	  .mask = FL | FR | FC | FLC | FRC },
-	{ .ca_id = 0x17, .n_ch = 8,
-	  .mask = FL | FR | LFE | FC | FLC | FRC },
-	{ .ca_id = 0x18, .n_ch = 8,
-	  .mask = FL | FR | RC | FLC | FRC },
-	{ .ca_id = 0x19, .n_ch = 8,
-	  .mask = FL | FR | LFE | RC | FLC | FRC },
-	{ .ca_id = 0x1a, .n_ch = 8,
-	  .mask = FL | FR | RC | FC | FLC | FRC },
-	{ .ca_id = 0x1b, .n_ch = 8,
-	  .mask = FL | FR | LFE | RC | FC | FLC | FRC },
-	{ .ca_id = 0x1c, .n_ch = 8,
-	  .mask = FL | FR | RL | RR | FLC | FRC },
-	{ .ca_id = 0x1d, .n_ch = 8,
-	  .mask = FL | FR | LFE | RL | RR | FLC | FRC },
 	{ .ca_id = 0x1e, .n_ch = 8,
 	  .mask = FL | FR | FC | RL | RR | FLC | FRC },
-	{ .ca_id = 0x1f, .n_ch = 8,
-	  .mask = FL | FR | LFE | FC | RL | RR | FLC | FRC },
+	{ .ca_id = 0x11, .n_ch = 8,
+	  .mask = FL | FR | LFE | RL | RR | RLC | RRC },
+	{ .ca_id = 0x1d, .n_ch = 8,
+	  .mask = FL | FR | LFE | RL | RR | FLC | FRC },
+	{ .ca_id = 0x10, .n_ch = 8,
+	  .mask = FL | FR | RL | RR | RLC | RRC },
+	{ .ca_id = 0x1c, .n_ch = 8,
+	  .mask = FL | FR | RL | RR | FLC | FRC },
+	{ .ca_id = 0x0f, .n_ch = 8,
+	  .mask = FL | FR | LFE | FC | RL | RR | RC },
+	{ .ca_id = 0x1b, .n_ch = 8,
+	  .mask = FL | FR | LFE | RC | FC | FLC | FRC },
+	{ .ca_id = 0x0e, .n_ch = 8,
+	  .mask = FL | FR | FC | RL | RR | RC },
+	{ .ca_id = 0x1a, .n_ch = 8,
+	  .mask = FL | FR | RC | FC | FLC | FRC },
+	{ .ca_id = 0x0d, .n_ch = 8,
+	  .mask = FL | FR | LFE | RL | RR | RC },
+	{ .ca_id = 0x19, .n_ch = 8,
+	  .mask = FL | FR | LFE | RC | FLC | FRC },
+	{ .ca_id = 0x0c, .n_ch = 8,
+	  .mask = FL | FR | RC | RL | RR },
+	{ .ca_id = 0x18, .n_ch = 8,
+	  .mask = FL | FR | RC | FLC | FRC },
+	{ .ca_id = 0x17, .n_ch = 8,
+	  .mask = FL | FR | LFE | FC | FLC | FRC },
+	{ .ca_id = 0x16, .n_ch = 8,
+	  .mask = FL | FR | FC | FLC | FRC },
+	{ .ca_id = 0x15, .n_ch = 8,
+	  .mask = FL | FR | LFE | FLC | FRC },
+	{ .ca_id = 0x14, .n_ch = 8,
+	  .mask = FL | FR | FLC | FRC },
+	{ .ca_id = 0x0b, .n_ch = 8,
+	  .mask = FL | FR | LFE | FC | RL | RR },
+	{ .ca_id = 0x0a, .n_ch = 8,
+	  .mask = FL | FR | FC | RL | RR },
+	{ .ca_id = 0x09, .n_ch = 8,
+	  .mask = FL | FR | LFE | RL | RR },
+	{ .ca_id = 0x08, .n_ch = 8,
+	  .mask = FL | FR | RL | RR },
+	{ .ca_id = 0x07, .n_ch = 8,
+	  .mask = FL | FR | LFE | FC | RC },
+	{ .ca_id = 0x06, .n_ch = 8,
+	  .mask = FL | FR | FC | RC },
+	{ .ca_id = 0x05, .n_ch = 8,
+	  .mask = FL | FR | LFE | RC },
+	{ .ca_id = 0x04, .n_ch = 8,
+	  .mask = FL | FR | RC },
+	{ .ca_id = 0x03, .n_ch = 8,
+	  .mask = FL | FR | LFE | FC },
+	{ .ca_id = 0x02, .n_ch = 8,
+	  .mask = FL | FR | FC },
+	{ .ca_id = 0x01, .n_ch = 8,
+	  .mask = FL | FR | LFE },
 };
 
 struct hdmi_codec_priv {
@@ -372,7 +385,8 @@ static int hdmi_codec_chmap_ctl_get(struct snd_kcontrol *kcontrol,
 	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
 	struct hdmi_codec_priv *hcp = info->private_data;
 
-	map = info->chmap[hcp->chmap_idx].map;
+	if (hcp->chmap_idx != HDMI_CODEC_CHMAP_IDX_UNKNOWN)
+		map = info->chmap[hcp->chmap_idx].map;
 
 	for (i = 0; i < info->max_channels; i++) {
 		if (hcp->chmap_idx == HDMI_CODEC_CHMAP_IDX_UNKNOWN)
-- 
2.43.0


