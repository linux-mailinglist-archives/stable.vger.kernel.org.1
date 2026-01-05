Return-Path: <stable+bounces-204827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E89DCF4555
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 16:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17447308C384
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 15:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6003093B8;
	Mon,  5 Jan 2026 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdWIbhTQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17042417C3
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625811; cv=none; b=dCEs+5mYixrvP6qmz4Beb8vGljzFpsZYO3ys8gEnFIFcXBOlba0saaJeeRipf+UrC3E23DnAGOifm3cfKq1WsJHifbK4YHxkQjkucxh8OTL5+5C1WpalgcIQ0N9k+wvuXgSx0T7VQmjnlnMVTIbVSybg79TJPn+Ff0tFiUqO7tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625811; c=relaxed/simple;
	bh=tzpaLnJ1V9l/zFLbB80WDgqjNtMDbghnu5Mg41uBoAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIABrlRT7LQL93Tt19DcmubCQfCadYRQ+b1RI2KMPTt6RWRjXwEccN3lI+CK6cSf2hzyOBrPQt6yHQb0yj648F2fCrEQMcpO9oi+I5St9pTG4s62hAS4b3//5HuB477UsdRhXvtuUeYtLqBAlNU14lrZL1ZjPiQste/VGb31OZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdWIbhTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B257C116D0;
	Mon,  5 Jan 2026 15:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767625811;
	bh=tzpaLnJ1V9l/zFLbB80WDgqjNtMDbghnu5Mg41uBoAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EdWIbhTQ6fzFYdFoxrs2cuJ5pAl4FJmO1l/ZbDzHdWHrQX2QmY4sLKmRGMMvg+4f/
	 hvNlQOdEs0I6+LTG+aqbCMrsA/wOq8aB5za2Ix1nMmxKohVCM7u1X44mJICb1Ja5Q+
	 QB5O9BjiuC8d+lE5UOwAIceT7yB4nLOyNACszOzHL5PyPCAbkSS0TtWg/TehXOa0rH
	 h9OLbOxP7WWj21Md7iKOX4SilEdAynKV+L9DOYrw845usv5lDdWaqmSkGtMdTVHcG4
	 1G0bqLM3CFUBi933TlrleuEbnJond1KvENXXC+XrA5Hg/1PFiKXPjELPhl1eesoajW
	 M5FyrQ2JC4N1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	shumingf@realtek.com,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] soundwire: stream: extend sdw_alloc_stream() to take 'type' parameter
Date: Mon,  5 Jan 2026 10:10:07 -0500
Message-ID: <20260105151008.2624877-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010528-thesaurus-stoop-f4af@gregkh>
References: <2026010528-thesaurus-stoop-f4af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>

[ Upstream commit dc90bbefa792031d89fe2af9ad4a6febd6be96a9 ]

In the existing definition of sdw_stream_runtime, the 'type' member is
never set and defaults to PCM. To prepare for the BPT/BRA support, we
need to special-case streams and make use of the 'type'.

No functional change for now, the implicit PCM type is now explicit.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Tested-by: shumingf@realtek.com
Link: https://lore.kernel.org/r/20250227140615.8147-5-yung-chuan.liao@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: bcba17279327 ("ASoC: qcom: sdw: fix memory leak for sdw_stream_runtime")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/driver-api/soundwire/stream.rst | 2 +-
 drivers/soundwire/stream.c                    | 6 ++++--
 include/linux/soundwire/sdw.h                 | 2 +-
 sound/soc/qcom/sdw.c                          | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/soundwire/stream.rst b/Documentation/driver-api/soundwire/stream.rst
index 2a794484f62c..d66201299633 100644
--- a/Documentation/driver-api/soundwire/stream.rst
+++ b/Documentation/driver-api/soundwire/stream.rst
@@ -291,7 +291,7 @@ per stream. From ASoC DPCM framework, this stream state maybe linked to
 
 .. code-block:: c
 
-  int sdw_alloc_stream(char * stream_name);
+  int sdw_alloc_stream(char * stream_name, enum sdw_stream_type type);
 
 The SoundWire core provides a sdw_startup_stream() helper function,
 typically called during a dailink .startup() callback, which performs
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 6c1e3aed8162..9764da386921 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1744,12 +1744,13 @@ static int set_stream(struct snd_pcm_substream *substream,
  * sdw_alloc_stream() - Allocate and return stream runtime
  *
  * @stream_name: SoundWire stream name
+ * @type: stream type (could be PCM ,PDM or BPT)
  *
  * Allocates a SoundWire stream runtime instance.
  * sdw_alloc_stream should be called only once per stream. Typically
  * invoked from ALSA/ASoC machine/platform driver.
  */
-struct sdw_stream_runtime *sdw_alloc_stream(const char *stream_name)
+struct sdw_stream_runtime *sdw_alloc_stream(const char *stream_name, enum sdw_stream_type type)
 {
 	struct sdw_stream_runtime *stream;
 
@@ -1761,6 +1762,7 @@ struct sdw_stream_runtime *sdw_alloc_stream(const char *stream_name)
 	INIT_LIST_HEAD(&stream->master_list);
 	stream->state = SDW_STREAM_ALLOCATED;
 	stream->m_rt_count = 0;
+	stream->type = type;
 
 	return stream;
 }
@@ -1789,7 +1791,7 @@ int sdw_startup_stream(void *sdw_substream)
 	if (!name)
 		return -ENOMEM;
 
-	sdw_stream = sdw_alloc_stream(name);
+	sdw_stream = sdw_alloc_stream(name, SDW_STREAM_PCM);
 	if (!sdw_stream) {
 		dev_err(rtd->dev, "alloc stream failed for substream DAI %s\n", substream->name);
 		ret = -ENOMEM;
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 5e0dd47a0412..cfb89989b369 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -1024,7 +1024,7 @@ struct sdw_stream_runtime {
 	int m_rt_count;
 };
 
-struct sdw_stream_runtime *sdw_alloc_stream(const char *stream_name);
+struct sdw_stream_runtime *sdw_alloc_stream(const char *stream_name, enum sdw_stream_type type);
 void sdw_release_stream(struct sdw_stream_runtime *stream);
 
 int sdw_compute_params(struct sdw_bus *bus);
diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
index f2eda2ff46c0..875da4adb1d7 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -27,7 +27,7 @@ int qcom_snd_sdw_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_dai *codec_dai;
 	int ret, i;
 
-	sruntime = sdw_alloc_stream(cpu_dai->name);
+	sruntime = sdw_alloc_stream(cpu_dai->name, SDW_STREAM_PCM);
 	if (!sruntime)
 		return -ENOMEM;
 
-- 
2.51.0


