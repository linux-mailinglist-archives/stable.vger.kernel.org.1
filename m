Return-Path: <stable+bounces-178945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1DAB4978A
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 19:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5C244063F
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 17:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1493310655;
	Mon,  8 Sep 2025 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3UdVaCF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECE330ACF0
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353733; cv=none; b=U+xKcVKe6+2NZQdvtkBUcNwdJN0KPrZ+qFJdxMNA2Ok4+SIx4fypva+1cA5Xgci1xJPO+YMqtAkKqCJ5CBKdN9mK2s8SyTMH2C+kioXigZEP01vpGa21jDqWAFOaOpoCNMpXk7kt07L025jDOcGxJP8mNm+715SJ9CWvq0hS/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353733; c=relaxed/simple;
	bh=oIIOfGMn3QCVUl2lk4vFkSwrp5ePce8/W9PTkXGKQyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltcR/mTQsT4vb3mY9m3U/mpePFXbN6OzRIdW7ajkzSe5FiP49TJPb9L7pEzLHGje/Qy6IfiFPL7Tcy0gEl7WrRwZU2xHmd7Omdznhz7MyT/PkAItaT7NqCLKSIJlTM5ZjUEzX1Qxh54FrLaqONyZZlOjY+WzT/2JNoIywDCgQ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3UdVaCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203C7C4CEF1;
	Mon,  8 Sep 2025 17:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757353731;
	bh=oIIOfGMn3QCVUl2lk4vFkSwrp5ePce8/W9PTkXGKQyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j3UdVaCFzOA1eGx7AHzDcAPTFzMzyFp73ZDODolcMo7fClcWsICXOBAdAIx9cJJBU
	 NMKUcIv8t4bF/jQIn6VAxaUOMC1bw1IIQ+5ja8ynusjoOdjNd2Y427+2aL/oqlHJMJ
	 S6sDZ224k5fSgl8NbS5hZL9hrdD9+plwTBHA2UyG+u3yIWhfdTWaInmkG+E1hre7BE
	 m3zKvMLjrf6VSbgOrgqRG+C2Ft0u7pNvJL3jlhzoNELCSdLIE8Q0NLc/AIEv8DTcOS
	 QdO79K35DihHyGMQxPZ6S/+OPiEv0gEFyf5BcZSWdlVpdEtR6l+THgYUHp75CiJQbP
	 2MiXEVDWFp3Pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ASoC: q6apm-dai: schedule all available frames to avoid dsp under-runs
Date: Mon,  8 Sep 2025 13:48:48 -0400
Message-ID: <20250908174848.1327623-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025041708-persevere-tripod-4354@gregkh>
References: <2025041708-persevere-tripod-4354@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 3d4a4411aa8bbc3653ff22a1ff0432eb93d22ae0 ]

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
[ Changed NO_TIMESTAMP constant to literal 0 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index de99c6920df87..8501e8404b922 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -52,6 +52,7 @@ struct q6apm_dai_rtd {
 	uint16_t bits_per_sample;
 	uint16_t source; /* Encoding source bit mask */
 	uint16_t session_id;
+	snd_pcm_uframes_t queue_ptr;
 	enum stream_state state;
 	struct q6apm_graph *graph;
 	spinlock_t lock;
@@ -114,8 +115,6 @@ static void event_handler(uint32_t opcode, uint32_t token, uint32_t *payload, vo
 		prtd->pos += prtd->pcm_count;
 		spin_unlock_irqrestore(&prtd->lock, flags);
 		snd_pcm_period_elapsed(substream);
-		if (prtd->state == Q6APM_STREAM_RUNNING)
-			q6apm_write_async(prtd->graph, prtd->pcm_count, 0, 0, 0);
 
 		break;
 	case APM_CLIENT_EVENT_DATA_READ_DONE:
@@ -209,6 +208,27 @@ static int q6apm_dai_prepare(struct snd_soc_component *component,
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
+			ret = q6apm_write_async(prtd->graph, prtd->pcm_count, 0, 0, 0);
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
@@ -220,9 +240,6 @@ static int q6apm_dai_trigger(struct snd_soc_component *component,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		 /* start writing buffers for playback only as we already queued capture buffers */
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			ret = q6apm_write_async(prtd->graph, prtd->pcm_count, 0, 0, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		/* TODO support be handled via SoftPause Module */
@@ -396,6 +413,7 @@ static const struct snd_soc_component_driver q6apm_fe_dai_component = {
 	.hw_params	= q6apm_dai_hw_params,
 	.pointer	= q6apm_dai_pointer,
 	.trigger	= q6apm_dai_trigger,
+	.ack		= q6apm_dai_ack,
 };
 
 static int q6apm_dai_probe(struct platform_device *pdev)
-- 
2.51.0


