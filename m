Return-Path: <stable+bounces-106723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA2EA00CAC
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 18:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF86D3A49C4
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 17:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF7F1FC111;
	Fri,  3 Jan 2025 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+2YJRtA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149D1FC10C;
	Fri,  3 Jan 2025 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735924690; cv=none; b=mdVcKVrXE4GdOFRlYLtqjlCxFriDSBA8jsIQEmzSnx5+gxyXRMTg96qXnQ7jLNRTWPGhGS1IAPPwnOk5XPXOku6pG+nh47v/eliIuVJuKntEfozG+A0ocytD3JaTr5FCN9n/7CXu8P9McOlLoHHeKJIFbP5U1M1h2ibHLHNpVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735924690; c=relaxed/simple;
	bh=mw44W+PYGrqjZ0HN6yoFwgQwsPYabuNnIEX0ZTqK9F8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pGcwm5lK6lo55AtWXm3v03QkM9wX8YkasVIuOAANk+t3/ae9WsNdPL9srPD1t1242dljUzn9khHbPjF5j70l62xIaEgEttityGaitt8PiqaTiNIJXPPI0b4Z/NDKHLLIbM3AVnDtv10zRs88rqc2TB4uCdvl5ipvjjZjJmUeyAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+2YJRtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424FCC4CECE;
	Fri,  3 Jan 2025 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735924689;
	bh=mw44W+PYGrqjZ0HN6yoFwgQwsPYabuNnIEX0ZTqK9F8=;
	h=From:To:Cc:Subject:Date:From;
	b=Y+2YJRtAgjCliyhxsoniBlj8f5qHkyGvVyJ7f3ycoZ2sKv3ZX83o7rFB3Q1P/BGjV
	 Hwn3mAw9irPOtNU4WLez2Q86ZcfnyZ0Nsa6vo721AQu4+mNpr20pajfZjj98bczgyD
	 Wu2z//73e136IgtQ05dhVha7q7KICG2jgdUVpErhCVmok5vY+ECHJBGlECFwVqdFG/
	 sEjaLPaz08uzS7u2An8NQAl36BtHt1oYDg38Tw8aN+HeW3P3sDUaPFyrObv8CvKYM/
	 tVlAzjyK3bMZPGGLLqFlHU28V9MWov+QkC993EizayXGNqHD4X+fA1j4MALpMd550o
	 B+bzq9ifB5DDw==
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
Subject: [PATCH AUTOSEL 6.1] ASoC: mediatek: disable buffer pre-allocation
Date: Fri,  3 Jan 2025 12:18:05 -0500
Message-Id: <20250103171806.492243-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.123
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


