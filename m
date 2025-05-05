Return-Path: <stable+bounces-141463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A332AAB395
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0D816CC9C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C17733A371;
	Tue,  6 May 2025 00:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kraXVoNO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B40C2820A1;
	Mon,  5 May 2025 23:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486378; cv=none; b=BHVeoKQBuBFB4mx9DTSv9g8x4ZL35pkERMIOTgPIlVeTovYZyMyGzY9hadquc/odfG01xA6YBQkAe0zP1+6dYIyMuS0wytw5Tj7558YwSga+f7WHqHcSCCrhqmAwrbcyf8ErXtlzXTa7Mbc7pqhQ7V5O9zgrog8VuLKzNIa25vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486378; c=relaxed/simple;
	bh=93cAwYNrBhIobUYALRIN+aixfXZiY+QQPC4xzf6ndok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zul1/9jX7gszwmmEsYftj+8ZC2KQLWYKRfQ+I7WOtLbUYGE1KgTDp5cYYQuUkIvcYq5mEHINqTtblK5uRt2s1bB8p389g4xNekTT0qqhniZZAVcXxM1QW837G5Qs1tQE7867RboKC9cdm3lle5V4RRJTrukabb90YUa3v6N+f3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kraXVoNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBDFC4CEE4;
	Mon,  5 May 2025 23:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486377;
	bh=93cAwYNrBhIobUYALRIN+aixfXZiY+QQPC4xzf6ndok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kraXVoNOISee1WRfrr0ckycZjpfuecQUfUUUlr0IBKrMEBs44mJ1GFsqXZy2rWfR9
	 t8BINZVWTnBCMgmOgpjgdyPdGGvN6hRb281xuKqyiHDK0CGcDqlfrS8D83svUKNbZx
	 Fz51KO41woR+vjXgiWFjtBurmUsL/YCCl6vohzrAtCQc6ADnAHXZ+74Iq5widznAFz
	 ZCuSJXn8TqnG8xkAnTlfnaR9BgZ5wEmyTN0kdqlJCwiYX+sqXBcYOzkLVK1oTFb5wO
	 ySHmBvrVPnq9KKRJCKaBKn3h4j6uaOoc9y4EJ6Ygk6K3zYZBoW7dSJ/VYg50dIXtbj
	 DAOvu9kLG72XA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Olivier Moysan <olivier.moysan@foss.st.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	lumag@kernel.org,
	broonie@kernel.org,
	stefan.ekenberg@axis.com,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 291/294] drm: bridge: adv7511: fill stream capabilities
Date: Mon,  5 May 2025 18:56:31 -0400
Message-Id: <20250505225634.2688578-291-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Olivier Moysan <olivier.moysan@foss.st.com>

[ Upstream commit c852646f12d4cd5b4f19eeec2976c5d98c0382f8 ]

Set no_i2s_capture and no_spdif_capture flags in hdmi_codec_pdata structure
to report that the ADV7511 HDMI bridge does not support i2s or spdif audio
capture.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20250108170356.413063-2-olivier.moysan@foss.st.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
index 8f786592143b6..24e1e11acf697 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
@@ -244,7 +244,9 @@ static const struct hdmi_codec_pdata codec_data = {
 	.ops = &adv7511_codec_ops,
 	.max_i2s_channels = 2,
 	.i2s = 1,
+	.no_i2s_capture = 1,
 	.spdif = 1,
+	.no_spdif_capture = 1,
 };
 
 int adv7511_audio_init(struct device *dev, struct adv7511 *adv7511)
-- 
2.39.5


