Return-Path: <stable+bounces-120152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F40F2A4C84E
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101513B1C47
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DB8266B5E;
	Mon,  3 Mar 2025 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ji3G5mF0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CF9266B4F;
	Mon,  3 Mar 2025 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019515; cv=none; b=e+Yjfl9b/pBu+KkyOq60sqtqd7PdX/WYMrB0YBR3y3NRWkqp4LXvr1HRENHgldVyg8AJ5sv5zrrr9AUB7blHerZpBwOMDcc72iYfXEdfBEy71cYeXpfC+PKM1F5qjDf0VD5qPeGJGOwvctqoTrZPxcUbYkYrAmfX3p5+sJowjXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019515; c=relaxed/simple;
	bh=ZOqR732/EghsR+Vn+YV1hqLM46B06Dh+wOSaMBwm8Gs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GZYbKPOKmwV2opDJl194JxegA24YClKx8FdkyL5RJvYH2RS0Cv6kb/6q6/tUh79fStzelzIbG0it1ueVvxFO4bc0ycQocypZYx7CtmvFIo+wg64iHntvQD1CtKOc6XXLV+U5wQmNY2DWznw229zZ5am5yupOTjtnoO8ySZ0ddMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ji3G5mF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E485BC4CEEC;
	Mon,  3 Mar 2025 16:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019515;
	bh=ZOqR732/EghsR+Vn+YV1hqLM46B06Dh+wOSaMBwm8Gs=;
	h=From:To:Cc:Subject:Date:From;
	b=Ji3G5mF0k9LmdX/1M7uW0KyRsnMkA3P0fDhcRLqVWg9OqaygcCXzusVsTkIXaGM6u
	 kiC/vVvVnnzBPoiQ83spA4h5Z8T5U1b5Vb+rh26N61eqSQovZPv0RG8VIfGSM7qeWF
	 Gs6s40+G8xheYtzHuQkhEhpWg7Ebo1K3doXynFG/SxMXoiq1cByK6SuJGf50Grwgat
	 GSbYIFtwFPyWDEDsYpmek73RcUmr1qSChMic6400FrAyZReOxXuohmU5X1/I2l4Hzr
	 6r8QqjyFh/AcKqjxN/fxvEcJbNMHfSgPK6PyJYaP0rwxHtS1Krh/L0Q2GOS9VDm05t
	 Zn1VklDMw7Kbw==
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
Subject: [PATCH AUTOSEL 5.15 1/9] ASoC: tas2770: Fix volume scale
Date: Mon,  3 Mar 2025 11:31:44 -0500
Message-Id: <20250303163152.3764156-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
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
index ec0df3b1ef615..4e71dc1cf588f 100644
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


