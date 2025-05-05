Return-Path: <stable+bounces-140639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E1EAAAA6C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCEB5A169E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A75838AC5E;
	Mon,  5 May 2025 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRS/JuCf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5912D81AF;
	Mon,  5 May 2025 22:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485767; cv=none; b=TndNzjItBsvdwws/Tpo3hFQsBcqDEKpwy+9BfisDU5I4SWZis0VSLAyO9ilupflV2nVxloJEVsMNzhIflQDcAcw14oDTYrtcv9l2qcNutrVX9qIiSnbgF6cpO8x6sRp8edEqsT5lVpLk86Qz+qb2u0UfyEndO+erZKX418MQfiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485767; c=relaxed/simple;
	bh=exINYAVBeI8oiIvNu7w93uO+6/hrDZFff9ESeVyYoT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o7NpRQ+KX0vEmMTuDR8ZQ5A5rgU/K2ppxUTQdMBLh2zoboLW8bykQtIpdK5FYi5M9ENE/6ue8VEXCSievxXIV4WjIveYHQIiYK/spXfDBOQpuplHYOnZSTFQY0qzIux9X8A4sT/gelTxAgOHkP1jH+oG7hnqQXPhpZuCcT/aKrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRS/JuCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67E0C4CEED;
	Mon,  5 May 2025 22:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485766;
	bh=exINYAVBeI8oiIvNu7w93uO+6/hrDZFff9ESeVyYoT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRS/JuCf0zYpT4Q0odol96KuxzQrnAZf/Jsh0rFcKUKKU9sxac8jVcHnG3iTqu+CU
	 p7Z+oFFjYHQrXfCMiI4JPGqI8sWGsqzbcVsyr6ku6Luh+nKH2OVwXYb7YlFJrdAvTR
	 B2jmbdmKJ9ypZvgU5PpCA6cOUSkTf9PVYQBxPCE+qmNoaX5i/uIBrFMd94XOk6rj5R
	 y7SF89kxBDw7b8xz5LcIYdran9ftaVoj1qFq/KvM82z2CXexg6OC2JFMHj9JKnW+N6
	 r15gMpZ+mTeByllNtdf/YzY2YT5huM+BqsekqNDmuL1h9K6Yf2t7tPjkIEgpHpcX6q
	 wRr0YowTL/H1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Olivier Moysan <olivier.moysan@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	lumag@kernel.org,
	jonas@kwiboo.se,
	kuninori.morimoto.gx@renesas.com,
	herve.codina@bootlin.com,
	krzysztof.kozlowski@linaro.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 473/486] ASoC: hdmi-codec: allow to refine formats actually supported
Date: Mon,  5 May 2025 18:39:09 -0400
Message-Id: <20250505223922.2682012-473-sashal@kernel.org>
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

[ Upstream commit 038f79638e0676359e44c5db458d52994f9b5ac1 ]

Currently the hdmi-codec driver registers all the formats that are
allowed on the I2S bus. Add i2s_formats field to codec data, to allow
the hdmi codec client to refine the list of the audio I2S formats
actually supported.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20250108170356.413063-3-olivier.moysan@foss.st.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/hdmi-codec.h    | 1 +
 sound/soc/codecs/hdmi-codec.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
index 5e1a9eafd10f5..a65da989dab16 100644
--- a/include/sound/hdmi-codec.h
+++ b/include/sound/hdmi-codec.h
@@ -122,6 +122,7 @@ struct hdmi_codec_ops {
 /* HDMI codec initalization data */
 struct hdmi_codec_pdata {
 	const struct hdmi_codec_ops *ops;
+	u64 i2s_formats;
 	uint i2s:1;
 	uint no_i2s_playback:1;
 	uint no_i2s_capture:1;
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index d9df29a26f4f2..3f9dfdbc693e0 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -1077,6 +1077,10 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 	if (hcd->i2s) {
 		daidrv[i] = hdmi_i2s_dai;
 		daidrv[i].playback.channels_max = hcd->max_i2s_channels;
+		if (hcd->i2s_formats) {
+			daidrv[i].playback.formats = hcd->i2s_formats;
+			daidrv[i].capture.formats = hcd->i2s_formats;
+		}
 		if (hcd->no_i2s_playback)
 			memset(&daidrv[i].playback, 0,
 			       sizeof(daidrv[i].playback));
-- 
2.39.5


