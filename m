Return-Path: <stable+bounces-133015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E8DA919B0
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0623BE0F6
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0264232377;
	Thu, 17 Apr 2025 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KJbWHJNF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811AE232360
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886891; cv=none; b=XS56mwO+qhFMMiNScypCVOXSLEhFt/TT4Zt0AvTzJEWmJcjcL5ZJlxI7LXljXrEgN4tvdkWCtZTtDIjnHoakTBeI6xn6+btslEepY2NON8UsnXIdZqHNdYSI3uOgR7heS8iBlPS7Ge8rabF1vMPRkfhhcZ9Xfv6UiPsjXm88V8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886891; c=relaxed/simple;
	bh=3IgkpsqPM8pLgIa6xTjd33pqpFF72Zy/UfJIWyk4qj8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C6HLSHCHuwnuUBFQN9xLmn6vOzaR7YVu9fbslBebGxWcfUbDGwqUv+nTHzCpWuP23eVdFcf0fv3yn2R6BFT2TDztu58488jEqhNS2qAmb8332nFiPKVBMwJSOmiJMAG34HKQbj+C2fWCz0YLiJaA386wp04zOP6TH76V+TYNaCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KJbWHJNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA900C4CEE4;
	Thu, 17 Apr 2025 10:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744886891;
	bh=3IgkpsqPM8pLgIa6xTjd33pqpFF72Zy/UfJIWyk4qj8=;
	h=Subject:To:Cc:From:Date:From;
	b=KJbWHJNFqRmkdTP5U7MPSOOrFbSR2zOtLyOtnaWG41BaqVzyWVk7m/e1uLBqWIJ8K
	 S0kYhuupmRGB39qYeBMk8STvWQ+DQV3wr2FAHBS0dy7pnlYi9PD29wUj+HwWNAc7Ds
	 zc1H6zIY+7pqBpudnoYc7zWZZgH7wrXkutY0VfPM=
Subject: FAILED: patch "[PATCH] ASoC: q6apm-dai: schedule all available frames to avoid dsp" failed to apply to 6.6-stable tree
To: srinivas.kandagatla@linaro.org,broonie@kernel.org,johan+linaro@kernel.org,krzysztof.kozlowski@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:48:08 +0200
Message-ID: <2025041708-circus-pesky-fec9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3d4a4411aa8bbc3653ff22a1ff0432eb93d22ae0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041708-circus-pesky-fec9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3d4a4411aa8bbc3653ff22a1ff0432eb93d22ae0 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 14 Mar 2025 17:47:56 +0000
Subject: [PATCH] ASoC: q6apm-dai: schedule all available frames to avoid dsp
 under-runs

With the existing code, we are only setting up one period at a time, in a
ping-pong buffer style. This triggers lot of underruns in the dsp
leading to jitter noise during audio playback.

Fix this by scheduling all available periods, this will ensure that the dsp
has enough buffer feed and ultimatley fixing the underruns and audio
distortion.

Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
Cc: stable@vger.kernel.org
Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://patch.msgid.link/20250314174800.10142-2-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index c9404b5934c7..9d8e8e37c6de 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -70,6 +70,7 @@ struct q6apm_dai_rtd {
 	unsigned int bytes_received;
 	unsigned int copied_total;
 	uint16_t bits_per_sample;
+	snd_pcm_uframes_t queue_ptr;
 	bool next_track;
 	enum stream_state state;
 	struct q6apm_graph *graph;
@@ -134,8 +135,6 @@ static void event_handler(uint32_t opcode, uint32_t token, void *payload, void *
 		prtd->pos += prtd->pcm_count;
 		spin_unlock_irqrestore(&prtd->lock, flags);
 		snd_pcm_period_elapsed(substream);
-		if (prtd->state == Q6APM_STREAM_RUNNING)
-			q6apm_write_async(prtd->graph, prtd->pcm_count, 0, 0, 0);
 
 		break;
 	case APM_CLIENT_EVENT_DATA_READ_DONE:
@@ -294,6 +293,27 @@ static int q6apm_dai_prepare(struct snd_soc_component *component,
 	return 0;
 }
 
+static int q6apm_dai_ack(struct snd_soc_component *component, struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct q6apm_dai_rtd *prtd = runtime->private_data;
+	int i, ret = 0, avail_periods;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		avail_periods = (runtime->control->appl_ptr - prtd->queue_ptr)/runtime->period_size;
+		for (i = 0; i < avail_periods; i++) {
+			ret = q6apm_write_async(prtd->graph, prtd->pcm_count, 0, 0, NO_TIMESTAMP);
+			if (ret < 0) {
+				dev_err(component->dev, "Error queuing playback buffer %d\n", ret);
+				return ret;
+			}
+			prtd->queue_ptr += runtime->period_size;
+		}
+	}
+
+	return ret;
+}
+
 static int q6apm_dai_trigger(struct snd_soc_component *component,
 			     struct snd_pcm_substream *substream, int cmd)
 {
@@ -305,9 +325,6 @@ static int q6apm_dai_trigger(struct snd_soc_component *component,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		 /* start writing buffers for playback only as we already queued capture buffers */
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			ret = q6apm_write_async(prtd->graph, prtd->pcm_count, 0, 0, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		/* TODO support be handled via SoftPause Module */
@@ -836,6 +853,7 @@ static const struct snd_soc_component_driver q6apm_fe_dai_component = {
 	.hw_params	= q6apm_dai_hw_params,
 	.pointer	= q6apm_dai_pointer,
 	.trigger	= q6apm_dai_trigger,
+	.ack		= q6apm_dai_ack,
 	.compress_ops	= &q6apm_dai_compress_ops,
 	.use_dai_pcm_id = true,
 };


