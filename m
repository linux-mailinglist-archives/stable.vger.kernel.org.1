Return-Path: <stable+bounces-139901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961C0AAA1DF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4B5461C66
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FCE2D3A65;
	Mon,  5 May 2025 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7OXpQu/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FD42D3229;
	Mon,  5 May 2025 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483641; cv=none; b=ZVmjdLdW5mW/F3acKTIHcBUoeYY2TwxnfiGYdApokWJ72OkmrzZG/WuhvZzNCrnbXwEG//GEWR2AKV81XMFsvLVBAUmmiTtlsY9GOCGj2I14D/WHH/9790T/F3FgRSMXNofXeTX9XJHkvfsmcXVtrO9isUQ0Tf/tMuJR8ofMy7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483641; c=relaxed/simple;
	bh=i8k4kAuOA12gAeUKPjXuKQ3wEZQVKFo+gD7Ede6jyUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lxcyxrLzLFw4jK4Q36iBWG4uSs9L1FUYefj4M0cLwWuT+wFi1WBf9Xb/UdABBiKs775sN7OjDFrX3jv+pGLUnNBsMQOXMlIyNIMhmr4HLvC9ECBjl2piBaBYYqf988H8hlxih6qXx9Q+N2z+8cPe/V5/H4kEz+tpoo1K0Lu3RbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7OXpQu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13E1C4CEF2;
	Mon,  5 May 2025 22:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483640;
	bh=i8k4kAuOA12gAeUKPjXuKQ3wEZQVKFo+gD7Ede6jyUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e7OXpQu/mxri18axqEyS8ARu47K1cUkWysOY8d1oLUG/99Z4HGzplDHaBCSNVj12L
	 ikEfQfDPobeI3ZqDOm3mopMTk4JofZwcSxlsrbzYMr7LAR1O2V64GBr3NqesOvAXiR
	 0FsxyuxkN1AWUIpFnQBunmeaP0lLJ/GtrkRIKxbyogc7AUksXaOa3CsDg8h5CxH0+D
	 3DrkCvhn33D4Ma2MA4tchk38tEWeea8/5PSpg/KONIXmncWOFIYgqyA8T/qbDowYNa
	 tZHUg3nVOwgLQau6FrmAx5wfYPYfRnVWmE9iXmv/iTKYejcTCgrrdG41Glxnd/6dv4
	 IDrNB1WiSJ67g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ryan Walklin <ryan@testtoast.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Philippe Simons <simons.philippe@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	csokas.bence@prolan.hu,
	andre.przywara@arm.com,
	mesihkilinc@gmail.com,
	codekipper@gmail.com,
	jbrunet@baylibre.com,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 154/642] ASoC: sun4i-codec: correct dapm widgets and controls for h616
Date: Mon,  5 May 2025 18:06:10 -0400
Message-Id: <20250505221419.2672473-154-sashal@kernel.org>
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

From: Ryan Walklin <ryan@testtoast.com>

[ Upstream commit ae5f76d4044d1580849316c49290678605e0889d ]

The previous H616 support patch added a single LINEOUT DAPM pin switch
to the card controls. As the codec in this SoC only has a single route,
this seemed reasonable at the time, however is redundant given the
existing DAPM codec widget definitions controlling the digital and
analog sides of the codec.

It is also insufficient to describe the scenario where separate
components (muxes, jack detection etc) are used to modify the audio
route external to the SoC. For example the Anbernic RG(##)XX series of
devices uses a headphone jack detection switch, GPIO-controlled speaker
amplifier and a passive external mux chip to route audio.

Remove the redundant LINEOUT card control, and add a Speaker pin switch
control and Headphone DAPM widget to allow control of the above
hardware.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Ryan Walklin <ryan@testtoast.com>
Tested-by: Philippe Simons <simons.philippe@gmail.com>
Link: https://patch.msgid.link/20250214220247.10810-3-ryan@testtoast.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 06e85b34fdf68..3701f56c72756 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1962,10 +1962,11 @@ static const struct snd_soc_component_driver sun50i_h616_codec_codec = {
 };
 
 static const struct snd_kcontrol_new sun50i_h616_card_controls[] = {
-	SOC_DAPM_PIN_SWITCH("LINEOUT"),
+	SOC_DAPM_PIN_SWITCH("Speaker"),
 };
 
 static const struct snd_soc_dapm_widget sun50i_h616_codec_card_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_LINE("Line Out", NULL),
 	SND_SOC_DAPM_SPK("Speaker", sun4i_codec_spk_event),
 };
-- 
2.39.5


