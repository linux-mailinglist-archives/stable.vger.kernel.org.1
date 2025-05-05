Return-Path: <stable+bounces-141465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 329F5AAB71E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71F21C22213
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4DB33A368;
	Tue,  6 May 2025 00:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USPDACyU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624C13754E0;
	Mon,  5 May 2025 23:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486374; cv=none; b=RFzwZaMyh8kheIY6GicsoWI4wMw+BgRCQUtoCYu9UpJT8OyzEj/MUuztPv5EyxlFdCrSq0XbgMTImt2OKByh9V4H/zzcE5Tk0niUAHwsasd+5HgHYnzHkobD9GhFsFC5RjAzNc9O7bEOmsGxjpyhNvaNm9yykw2r1psRpJnoVLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486374; c=relaxed/simple;
	bh=jxtLKYnH02viIBpG8ekxsfEbbnFs92hl0gasfFs9L74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A7YPC+esH4RcXv8Oyyg+ZxV4vjRaTXvkwe8uQbrWsZJfKjiOTLYvGVNXcTywSRzbR8+E94GDt3Z/50DC11Eb5z8PN/cm4+XxPnnX11BzpLMA28dcISxH8nk+qtHke7n6zRrCOe+IcPKH3kM5vcWkN7VY2WNEqZU07IFgAaK4GtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USPDACyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E0DC4CEE4;
	Mon,  5 May 2025 23:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486374;
	bh=jxtLKYnH02viIBpG8ekxsfEbbnFs92hl0gasfFs9L74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=USPDACyUjQscVbZqh8uOwR2bVhJKiF0fzOtg0vQqlPdZwxLifgUAvSxGqvg8xkuoF
	 YbZ4cUOPqY477yq9hs3f1HKJqpZ6GwrOVS7vNbFdVjPS/DB7qg3WaZzLBZwezU86JY
	 jENcYBvL8/rwYIYGz1p3J3oyQGLDB7K8iUTJut5SbfwItU/KhIOFgaDKFOlAr7bxUm
	 HN3GFaqGC48fHmDRFFVYV8m5t4fVVNz0ZAcPBVc5+X6L5iEz7jQ0MWGKQRqdSYWiet
	 +7IQq4sSBtDGORkm3Vil4JTvd5xNQhDW3EJgrENYi2uOkZCuR6Hp8/6+rAg6IK875K
	 PFDqOYRp7m1Iw==
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
	christianshewitt@gmail.com,
	jonas@kwiboo.se,
	krzysztof.kozlowski@linaro.org,
	kuninori.morimoto.gx@renesas.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 290/294] ASoC: hdmi-codec: allow to refine formats actually supported
Date: Mon,  5 May 2025 18:56:30 -0400
Message-Id: <20250505225634.2688578-290-sashal@kernel.org>
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
index 9b162ac1e08e0..498d21dfd8790 100644
--- a/include/sound/hdmi-codec.h
+++ b/include/sound/hdmi-codec.h
@@ -123,6 +123,7 @@ struct hdmi_codec_ops {
 /* HDMI codec initalization data */
 struct hdmi_codec_pdata {
 	const struct hdmi_codec_ops *ops;
+	u64 i2s_formats;
 	uint i2s:1;
 	uint no_i2s_playback:1;
 	uint no_i2s_capture:1;
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 03290d3ae59cc..915baa7016eab 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -1076,6 +1076,10 @@ static int hdmi_codec_probe(struct platform_device *pdev)
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


