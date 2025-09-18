Return-Path: <stable+bounces-166265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DFEB198A8
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F2A164EE1
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9C91DE3C3;
	Mon,  4 Aug 2025 00:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5Lmr7vQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94D038D;
	Mon,  4 Aug 2025 00:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267801; cv=none; b=ssQ7AORva0MhiyiJ2wRhrTwqx7/0WXWtmhXkPqsjnSVkpQuRM+l8PriAr/jcPKOQYkAt0Zjbn6gLHXfbEXE6K8BB3dpE6HTCvjWvezNH0/IO2uU2F410lnDb1HJhnN0ip3w1P4D4XktjglSv8l6BcB7m38DkSzjygH+TMJLLr74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267801; c=relaxed/simple;
	bh=7aOpEpMk6gX74mbh3uC/4H+xB6yscOGZrOkoaql2YZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8/212l8JqHmOy7ETGoOFyRxSaonjp73l0x2C56noAXmk4dno8Vucx1zqKiRK4sbMcqYBf3DvY3IqIn8jJLLWj82HnTUSdYEkdhC+AEvNpu2i6Rb6LMyGo8Fur9TWfqR9ClYBun9VwM9RPjE5rRLpe+6hCqrbF43hE9Slv+jHls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5Lmr7vQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE933C4CEEB;
	Mon,  4 Aug 2025 00:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267801;
	bh=7aOpEpMk6gX74mbh3uC/4H+xB6yscOGZrOkoaql2YZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a5Lmr7vQewI29xxGh7X1w8c2T1AwmzvHKddpmhS0J9wTaR4f/b9FjYlEv3sJ9KvdP
	 9j6QzvvcYw2+/runZQc9fVqU18REfUk5HK45ZfcxJcoOyQoLKo9yU9XH5RKbjP2z8H
	 juo7UyHSvghGACRQTzTLZ3gLCnr8ZK0Mm0dE8V5pmlEYWoliwXOZM8YzrAMGR82vlV
	 6eIs+KDL1FL0J1uGvMDv/06lSL2ijE/HGiEsEr97p1D2flPfpE4aT2QbRX1sI1vsT0
	 z8d0y8BJjwuVHyu364DRVA9VP/LZFiVgbvijBeiYvs7G3D0Zvgtn0XBpjka/o4JWOD
	 chN7O9TqaoEJg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Srinivas Kandagatla <srini@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 59/59] ASoC: qcom: use drvdata instead of component to keep id
Date: Sun,  3 Aug 2025 20:34:13 -0400
Message-Id: <20250804003413.3622950-59-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003413.3622950-1-sashal@kernel.org>
References: <20250804003413.3622950-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.101
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srini@kernel.org>

[ Upstream commit 8167f4f42572818fa8153be2b03e4c2120846603 ]

Qcom lpass is using component->id to keep DAI ID (A).

(S)	static int lpass_platform_pcmops_open(
				sruct snd_soc_component *component,
				struct snd_pcm_substream *substream)
	{			                          ^^^^^^^^^(B0)
		...
(B1)		struct snd_soc_pcm_runtime *soc_runtime = snd_soc_substream_to_rtd(substream);
(B2)		struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(soc_runtime, 0);
		...
(B3)		unsigned int dai_id = cpu_dai->driver->id;

(A)		component->id = dai_id;
		...
	}

This driver can get dai_id from substream (B0 - B3).
In this driver, below functions get dai_id from component->id (A).

(X)	lpass_platform_pcmops_suspend()
(Y)	lpass_platform_pcmops_resume()
(Z)	lpass_platform_copy()

Here, (Z) can get it from substream (B0 - B3), don't need to use
component->id (A). On suspend/resume (X)(Y), dai_id can only be obtained
from component->id (A), because there is no substream (B0) in function
parameter.

But, component->id (A) itself should not be used for such purpose.
It is intilialized at snd_soc_component_initialize(), and parsed its ID
(= component->id) from device name (a).

	int snd_soc_component_initialize(...)
	{
		...
		if (!component->name) {
(a)			component->name = fmt_single_name(dev, &component->id);
			...                                     ^^^^^^^^^^^^^
		}
		...
	}

Unfortunately, current code is broken to start with.

There are many regmaps that the driver cares about, however its only
managing one (either dp or i2s) in component suspend/resume path.

I2S regmap is mandatory however other regmaps are setup based on flags
like "hdmi_port_enable" and "codec_dma_enable".

Correct thing for suspend/resume path to handle is by checking these
flags, instead of using component->id.

Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Suggested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://patch.msgid.link/87a56ouuob.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**YES**

This commit should be backported to stable kernel trees for the
following reasons:

**1. Fixes a Real Bug with User Impact:**
- The driver was misusing `component->id` to store DAI ID information,
  overwriting the ASoC framework's intended use of this field
- This caused incomplete suspend/resume handling - only one regmap
  (either HDMI or I2S) was being handled instead of both when needed
- Users would experience audio failures after suspend/resume cycles,
  especially on systems with both HDMI and I2S audio interfaces

**2. Clear Architectural Violation Being Fixed:**
The commit message and code analysis show that `component->id` is
initialized by the ASoC framework during
`snd_soc_component_initialize()` based on device name parsing. The
driver was incorrectly overwriting this value with DAI ID, breaking the
abstraction layer between driver and framework.

**3. Limited Scope and Low Risk:**
- Changes are confined to 3 functions in a single file (`lpass-
  platform.c`)
- The fix replaces the problematic `component->id` usage with proper
  flag checking (`drvdata->hdmi_port_enable`)
- No API changes or new features added
- The author (Srinivas Kandagatla) is an experienced ASoC maintainer

**4. Improves Suspend/Resume Reliability:**
The fix ensures both HDMI and I2S regmaps are properly handled during
suspend/resume based on actual driver capabilities rather than an
incorrectly stored ID. This makes power management more robust and
predictable.

**5. Long-Standing Issue:**
The problematic code has existed since late 2020 (commits b1824968221c
and 8d1bfc04c974), affecting multiple kernel versions and potentially
many Qualcomm-based devices in the field.

**Backport Recommendation:**
Should be backported to all stable kernels from 5.10 onwards that
contain the original problematic commits. This is a medium-high priority
fix that improves audio subsystem reliability without introducing new
risks.

 sound/soc/qcom/lpass-platform.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index f918d9e16dc0..f342bc4b3a14 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -201,7 +201,6 @@ static int lpass_platform_pcmops_open(struct snd_soc_component *component,
 	struct regmap *map;
 	unsigned int dai_id = cpu_dai->driver->id;
 
-	component->id = dai_id;
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -1189,13 +1188,14 @@ static int lpass_platform_pcmops_suspend(struct snd_soc_component *component)
 {
 	struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
 	struct regmap *map;
-	unsigned int dai_id = component->id;
 
-	if (dai_id == LPASS_DP_RX)
+	if (drvdata->hdmi_port_enable) {
 		map = drvdata->hdmiif_map;
-	else
-		map = drvdata->lpaif_map;
+		regcache_cache_only(map, true);
+		regcache_mark_dirty(map);
+	}
 
+	map = drvdata->lpaif_map;
 	regcache_cache_only(map, true);
 	regcache_mark_dirty(map);
 
@@ -1206,14 +1206,19 @@ static int lpass_platform_pcmops_resume(struct snd_soc_component *component)
 {
 	struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
 	struct regmap *map;
-	unsigned int dai_id = component->id;
+	int ret;
 
-	if (dai_id == LPASS_DP_RX)
+	if (drvdata->hdmi_port_enable) {
 		map = drvdata->hdmiif_map;
-	else
-		map = drvdata->lpaif_map;
+		regcache_cache_only(map, false);
+		ret = regcache_sync(map);
+		if (ret)
+			return ret;
+	}
 
+	map = drvdata->lpaif_map;
 	regcache_cache_only(map, false);
+
 	return regcache_sync(map);
 }
 
@@ -1223,7 +1228,9 @@ static int lpass_platform_copy(struct snd_soc_component *component,
 			       unsigned long bytes)
 {
 	struct snd_pcm_runtime *rt = substream->runtime;
-	unsigned int dai_id = component->id;
+	struct snd_soc_pcm_runtime *soc_runtime = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(soc_runtime, 0);
+	unsigned int dai_id = cpu_dai->driver->id;
 	int ret = 0;
 
 	void __iomem *dma_buf = (void __iomem *) (rt->dma_area + pos +
-- 
2.39.5


