Return-Path: <stable+bounces-27-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DEC7F5BA7
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 10:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45BECB20F71
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 09:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB42B22326;
	Thu, 23 Nov 2023 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSQDGinf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9564822303;
	Thu, 23 Nov 2023 09:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E2DC433C8;
	Thu, 23 Nov 2023 09:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700732904;
	bh=7h/OjemTqWiGjvlLQ2Q4DPbNg34lkEWYu0P40v5ltJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSQDGinf7W7+Ko2okkgxKhrW84M3Se1kcjwB5H+600QcKJdCesFEaWucBHPwJHMye
	 xQzbl5OO3dWoYPuspyLDCjD0LzCRoMciFwrWFb1urpFctgC6I8ilAzVolMV2X0lVyN
	 B9NbIfoZj7CvNU0P3K6ru2L2n8y6uONQPThWAdUXfet4IRQt/dMqklWa9Bymx+fVLH
	 Bt6suHoEsEd2CBfgMOb1yb0nJpcbzz95RHXX6aJnTH7B5D3ShAStPfUdBTWVE7b8FL
	 Orh8XsP78XVlucZA4mEYhSL67q/HWTsBANNMSsM3eWu58RMpOONSZruSML17R3RIph
	 44CEoaxU5eyKw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1r66K9-0005KQ-2E;
	Thu, 23 Nov 2023 10:48:41 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH stable-6.6 1/2] ASoC: soc-dai: add flag to mute and unmute stream during trigger
Date: Thu, 23 Nov 2023 10:47:48 +0100
Message-ID: <20231123094749.20462-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123094749.20462-1-johan+linaro@kernel.org>
References: <20231123094749.20462-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

commit f0220575e65abe09c09cd17826a3cdea76e8d58f upstream.

In some setups like Speaker amps which are very sensitive, ex: keeping them
unmute without actual data stream for very short duration results in a
static charge and results in pop and clicks. To minimize this, provide a way
to mute and unmute such codecs during trigger callbacks.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231027105747.32450-2-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
[ johan: backport to v6.6.2 ]
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 include/sound/soc-dai.h |  1 +
 sound/soc/soc-dai.c     |  7 +++++++
 sound/soc/soc-pcm.c     | 12 ++++++++----
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 5fcfba47d98c..adcd8719d343 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -370,6 +370,7 @@ struct snd_soc_dai_ops {
 
 	/* bit field */
 	unsigned int no_capture_mute:1;
+	unsigned int mute_unmute_on_trigger:1;
 };
 
 struct snd_soc_cdai_ops {
diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index 3f33f0630ad8..9a828e55c4f9 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -658,6 +658,10 @@ int snd_soc_pcm_dai_trigger(struct snd_pcm_substream *substream,
 			ret = soc_dai_trigger(dai, substream, cmd);
 			if (ret < 0)
 				break;
+
+			if (dai->driver->ops && dai->driver->ops->mute_unmute_on_trigger)
+				snd_soc_dai_digital_mute(dai, 0, substream->stream);
+
 			soc_dai_mark_push(dai, substream, trigger);
 		}
 		break;
@@ -668,6 +672,9 @@ int snd_soc_pcm_dai_trigger(struct snd_pcm_substream *substream,
 			if (rollback && !soc_dai_mark_match(dai, substream, trigger))
 				continue;
 
+			if (dai->driver->ops && dai->driver->ops->mute_unmute_on_trigger)
+				snd_soc_dai_digital_mute(dai, 1, substream->stream);
+
 			r = soc_dai_trigger(dai, substream, cmd);
 			if (r < 0)
 				ret = r; /* use last ret */
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 0a20122b3e55..511446a30c05 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -896,8 +896,10 @@ static int __soc_pcm_prepare(struct snd_soc_pcm_runtime *rtd,
 	snd_soc_dapm_stream_event(rtd, substream->stream,
 			SND_SOC_DAPM_STREAM_START);
 
-	for_each_rtd_dais(rtd, i, dai)
-		snd_soc_dai_digital_mute(dai, 0, substream->stream);
+	for_each_rtd_dais(rtd, i, dai) {
+		if (dai->driver->ops && !dai->driver->ops->mute_unmute_on_trigger)
+			snd_soc_dai_digital_mute(dai, 0, substream->stream);
+	}
 
 out:
 	return soc_pcm_ret(rtd, ret);
@@ -939,8 +941,10 @@ static int soc_pcm_hw_clean(struct snd_soc_pcm_runtime *rtd,
 		if (snd_soc_dai_active(dai) == 1)
 			soc_pcm_set_dai_params(dai, NULL);
 
-		if (snd_soc_dai_stream_active(dai, substream->stream) == 1)
-			snd_soc_dai_digital_mute(dai, 1, substream->stream);
+		if (snd_soc_dai_stream_active(dai, substream->stream) == 1) {
+			if (dai->driver->ops && !dai->driver->ops->mute_unmute_on_trigger)
+				snd_soc_dai_digital_mute(dai, 1, substream->stream);
+		}
 	}
 
 	/* run the stream event */
-- 
2.41.0


