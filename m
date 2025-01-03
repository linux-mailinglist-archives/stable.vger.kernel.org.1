Return-Path: <stable+bounces-106724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148C4A00CB0
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 18:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1D73A449C
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 17:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8081FCFF3;
	Fri,  3 Jan 2025 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YliL4jvs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B971FC7C3;
	Fri,  3 Jan 2025 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735924695; cv=none; b=qMxQTC5o0YCcfvLkkW8TFxWCyjMDfwZd4XTV1TZ8iap7S6Vvajkx9rBmj6idLRWfkP4W56ifzXtZO1SzE+KrxJSnjPy38wy09J5UZVhdzR0LUPHBdEiLvWg3UhmhDcWak+YREnzrAuYsKDrYFqvPOy3pHPuxrKmWQhzxeQMBEkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735924695; c=relaxed/simple;
	bh=mw44W+PYGrqjZ0HN6yoFwgQwsPYabuNnIEX0ZTqK9F8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fJdhmx0lqpICJYTI3O2sLI1KgiUrUshj+iHTdXBmVZJny5qyS64hmvuouWyfAtM8yRAMlIk+ZC8+Bm6NKec/c8gRuhaYxEbVgro3am5dfSbwtcjfyHRRe6HnaSI164crcoasugUSAAtNUiVRpdWaI92KAWIupaEtbuXsRz8Miuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YliL4jvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F036BC4CED7;
	Fri,  3 Jan 2025 17:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735924694;
	bh=mw44W+PYGrqjZ0HN6yoFwgQwsPYabuNnIEX0ZTqK9F8=;
	h=From:To:Cc:Subject:Date:From;
	b=YliL4jvs1yhh1hLPmdtDI9rgAeT+maoFCCtyYihEJ55dJ3lZfaVpHHoIYsYwyunEt
	 wQdMSKYYaofVdQZbpmOFkQgE0QQ0Pm+yEbL3/hWx8rTXX9vjpZ+VL39VCAPHRhnimJ
	 zJ/9jcvVYSVWee8VyGgEG/6pF1ikoRHe9zC4Wako7BICh0UzIRGfqEUeHF4kvbeW2L
	 7UF+fnawLzcy0QoSwzCuP0acxcH+iklUa3j8DmLwjdIKVIoxtEGwHZ1GzRNRvlVM4B
	 HYprhOaVRTV3wfaY1MGkglGLCRxgsVXOs4XeivvLYwIGq0aXMHJtT8A5i63oRfj/Ji
	 YzUf3T0cjhqWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	amergnat@baylibre.com,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15] ASoC: mediatek: disable buffer pre-allocation
Date: Fri,  3 Jan 2025 12:18:10 -0500
Message-Id: <20250103171811.492271-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.175
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit 32c9c06adb5b157ef259233775a063a43746d699 ]

On Chromebooks based on Mediatek MT8195 or MT8188, the audio frontend
(AFE) is limited to accessing a very small window (1 MiB) of memory,
which is described as a reserved memory region in the device tree.

On these two platforms, the maximum buffer size is given as 512 KiB.
The MediaTek common code uses the same value for preallocations. This
means that only the first two PCM substreams get preallocations, and
then the whole space is exhausted, barring any other substreams from
working. Since the substreams used are not always the first two, this
means audio won't work correctly.

This is observed on the MT8188 Geralt Chromebooks, on which the
"mediatek,dai-link" property was dropped when it was upstreamed. That
property causes the driver to only register the PCM substreams listed
in the property, and in the order given.

Instead of trying to compute an optimal value and figuring out which
streams are used, simply disable preallocation. The PCM buffers are
managed by the core and are allocated and released on the fly. There
should be no impact to any of the other MediaTek platforms.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patch.msgid.link/20241219105303.548437-1-wenst@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/mediatek/common/mtk-afe-platform-driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
index 01501d5747a7..52495c930ca3 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
@@ -120,8 +120,8 @@ int mtk_afe_pcm_new(struct snd_soc_component *component,
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
 
 	size = afe->mtk_afe_hardware->buffer_bytes_max;
-	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
-				       afe->dev, size, size);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV, afe->dev, 0, size);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mtk_afe_pcm_new);
-- 
2.39.5


