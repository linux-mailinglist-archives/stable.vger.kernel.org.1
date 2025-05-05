Return-Path: <stable+bounces-140637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F08ABAAAA3B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A81B1698F9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFE9373192;
	Mon,  5 May 2025 23:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jnws1f8C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D672D81B1;
	Mon,  5 May 2025 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485770; cv=none; b=Ht61T5RxpKyiMysjHC4SpWZt38pjXKcFAN8ecHqFIpZrGh2M1mRL2Hjax+3WdrD1Pdrp+xsHBUHnqw+CZT91kX7k1tRM5qCFPyz4ZucYRqbxP6Hlr7Eb8oY5aqfCkGX81CktFuKL5AD+PPJyfV6h91Hs19oSkJjbebtGjTC8ago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485770; c=relaxed/simple;
	bh=93cAwYNrBhIobUYALRIN+aixfXZiY+QQPC4xzf6ndok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dDBa+V9GHAlcLnYFRLga6HUh+pPfqO67MVIR34Q6N+wlni1XXKE9/kG7n77t2NIzRAvZKwMEKGTPlnddY87wiu2KTLeZ8RQta5lLa3PSqwFCLsAMKi9QQ8BurDSDPCFTWkW52Z0bTXtJB2Cxik3I07oBdm11yi9+Ck9+zAU438M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jnws1f8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640CAC4CEE4;
	Mon,  5 May 2025 22:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485769;
	bh=93cAwYNrBhIobUYALRIN+aixfXZiY+QQPC4xzf6ndok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jnws1f8CMaZttwaxTVaO8jNKesS2K2YEybgz5E/bg15xyxe//lcrFtqrgR/1NqsOj
	 gNNw4/H+niiWPQ4gW41y2tbO/oU0CkbyNsTqZCF7llSBEHfMHjVQoVwNOUrUdjBxyD
	 uwoL9eZ7WhwzEKmMPxmCtGDMzpZPnhDor3zxUOSK4XAmhUTu6AtSc6udqrrUv481pW
	 9/xkebR2C8slpcZSW86+nlxYKgjtweJGQ1NQEgx2cEseNpAVRVeOpHdU+ICswvEpZW
	 Wdtu2UMX1DH1oOoZf3GH7+OSpVkaXVHXFXiFENhVKrgzAO8KzCE7BRk8f3P/Yz5KDo
	 /2aoJdXwxnVsQ==
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
Subject: [PATCH AUTOSEL 6.12 474/486] drm: bridge: adv7511: fill stream capabilities
Date: Mon,  5 May 2025 18:39:10 -0400
Message-Id: <20250505223922.2682012-474-sashal@kernel.org>
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


