Return-Path: <stable+bounces-67586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FE395121E
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 04:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D633B2500F
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 02:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D5D149C63;
	Wed, 14 Aug 2024 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btpIqX/Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962F3381BD;
	Wed, 14 Aug 2024 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601730; cv=none; b=DjvQMYyuWtL76cPeIvJYfoq7kW/dNr/qZlO8bMIzrVLzSGNigM9Aqyg/A4OiVDeUWSgsQ0c8yOB40+lVVUkOjz5OguezHyMD8i69FDG5pjI7zvhwxU83QL5JQzToNKC+y32L486DsdlIPZEYyaiizpi5uWOiHhbKw8doN+FieUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601730; c=relaxed/simple;
	bh=5nYG8EmlvDYbolX1lQx1tB4e/9ihH0FaDNsaZWWdBHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVfqJ31eoHJBI8iBEOdIIM5lE5q2q4qevXzf8cspmbfVrtX3CEfZki5VLsdiX4zwbtvxxzYl8k5oaMoxIrdQLKaFQSBLII6WuVQmlgY1aCu5zod9xMPbD1SbrYtot75lUqs82LKkkIicCYWhEPN6aRdxbpxmIj1Uv07yvu5bFt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btpIqX/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC00C4AF09;
	Wed, 14 Aug 2024 02:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723601730;
	bh=5nYG8EmlvDYbolX1lQx1tB4e/9ihH0FaDNsaZWWdBHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=btpIqX/YcQfVEgV1SJpIKkwtYH8yooYWyo2XZPeaEDgktSED/qjUDfelWi9CwlfbT
	 gtBfpqIXGy8Qgxwm+kkX1aQXs0FqU5Bdrf3Pyiw+Cq3QWwJ089ptfPaAhOVhcw/gyb
	 416iZFWEj2Mft5AS5z5pNa4+2iPeXeJhsUl3B2MnkcLcivfILP7xl2GoSOVAASb474
	 2kQXjoYfRaCNoDz8aCrKsMojGrhBFLyLKv0NfqHykPRmgtrdmWDxiVFJte5UfI22EY
	 XH6iPJ8QA+OhbG2qxnq104CIe2jQwWMaBOrBsJTveMrpY/WScFeSlQuwG7kpkdW6G5
	 kUkoaI6iWzXFg==
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
Subject: [PATCH AUTOSEL 6.6 7/7] ASoC: codecs: ES8326: button detect issue
Date: Tue, 13 Aug 2024 22:15:13 -0400
Message-ID: <20240814021517.4130238-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814021517.4130238-1-sashal@kernel.org>
References: <20240814021517.4130238-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.45
Content-Transfer-Encoding: 8bit

From: Zhang Yi <zhangyi@everest-semi.com>

[ Upstream commit 4684a2df9c5b3fc914377127faf2515aa9049093 ]

We find that we need to set snd_jack_types to 0. If not,
there will be a probability of button detection errors

Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
Link: https://patch.msgid.link/20240807025356.24904-2-zhangyi@everest-semi.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/es8326.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
index 6c263086c44d2..32a9b26ee2c89 100644
--- a/sound/soc/codecs/es8326.c
+++ b/sound/soc/codecs/es8326.c
@@ -617,6 +617,8 @@ static void es8326_jack_detect_handler(struct work_struct *work)
 		es8326_disable_micbias(es8326->component);
 		if (es8326->jack->status & SND_JACK_HEADPHONE) {
 			dev_dbg(comp->dev, "Report hp remove event\n");
+			snd_soc_jack_report(es8326->jack, 0,
+				    SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2);
 			snd_soc_jack_report(es8326->jack, 0, SND_JACK_HEADSET);
 			/* mute adc when mic path switch */
 			regmap_write(es8326->regmap, ES8326_ADC_SCALE, 0x33);
-- 
2.43.0


