Return-Path: <stable+bounces-180847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DACB8E96A
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 01:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6F53BC626
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 23:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4111C21254D;
	Sun, 21 Sep 2025 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fECR5k+8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18F81EC018
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 23:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758496575; cv=none; b=KD2qzH0V6rlTyKCqiIhZN1mTcj4xBSPtBZlQwYg+OOzuVkzuZ1sHsgJo0/W78doFLSybmi8uLL8Lqaj+17FfirKwMhCgeTxWDW8qXcxqj8eehJJjJwNkZPDoUWUz0gd8Z/K4QRYWYKIjAYLenvOm+yTdhJTlSID/7ruhQ3H4+gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758496575; c=relaxed/simple;
	bh=HRSBi4wF1AAqNdwgDQpBiUdx5DSsRX1kxCBXK/cAUug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+mPhSnqnyEHvFe2v0QF70QO/I67SoQNkprJlcNcRoNDwpO7TbUf2dtuo/h5ey5vyy8pE5HET0KXkuajolZOAtK8dHW0DbDFqU7l159SY4a29GvVGH8jiUEsa8obBta+OUglzFvj4OMCsbcjMTWNy9bZgxsyX3wnk2MCY9FNyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fECR5k+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE522C116B1;
	Sun, 21 Sep 2025 23:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758496574;
	bh=HRSBi4wF1AAqNdwgDQpBiUdx5DSsRX1kxCBXK/cAUug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fECR5k+82uSYRiPzpoDpdMdJBr6oFaa5hluBKd/xECpNQlMmUU2UBwdzfbBR/x2iJ
	 F8lj3R1CUWkJA9Nm1/0IBxWVoyrVnGgcun3XosBOnAM6NO2rpI4+uXpSLG2JFPtpy9
	 Ve6LrOkGO5qCoPdkd3TYyjwwJ4VEYwLNFi7bvhlsAUOPk6ITpID/yjJ6udRqHdpqUY
	 hpuzI4NFluIzBM8RQiOwGzxSyZrnfiOg6mcbeFSUU886DIwpd3oUBZhdtYY8B0VZOO
	 zDoyNMCnLS541K+cbDLpgNXzAR91OeD+3GZFEsG2I4zXFj8SfR5mYVE6oFXHoG5fuq
	 Qj1nEKPUmUu+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] ASoC: q6apm-lpass-dai: close graph on prepare errors
Date: Sun, 21 Sep 2025 19:16:10 -0400
Message-ID: <20250921231611.3032852-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921231611.3032852-1-sashal@kernel.org>
References: <2025092104-booting-overstate-c9cf@gregkh>
 <20250921231611.3032852-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit be1fae62cf253a5b67526cee9fbc07689b97c125 ]

There is an issue around with error handling and graph management with
the exising code, none of the error paths close the graph, which result in
leaving the loaded graph in dsp, however the driver thinks otherwise.

This can have a nasty side effect specially when we try to load the same
graph to dsp, dsp returns error which leaves the board with no sound and
requires restart.

Fix this by properly closing the graph when we hit errors between
open and close.

Fixes: 30ad723b93ad ("ASoC: qdsp6: audioreach: add q6apm lpass dai support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # X13s
Link: https://lore.kernel.org/r/20240613-q6apm-fixes-v1-1-d88953675ab3@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 68f27f7c7708 ("ASoC: qcom: q6apm-lpass-dais: Fix NULL pointer dereference if source graph failed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 32 +++++++++++++++----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index 420e8aa11f421..f4e18f4a6ee61 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -109,14 +109,17 @@ static void q6apm_lpass_dai_shutdown(struct snd_pcm_substream *substream, struct
 	struct q6apm_lpass_dai_data *dai_data = dev_get_drvdata(dai->dev);
 	int rc;
 
-	if (!dai_data->is_port_started[dai->id])
-		return;
-	rc = q6apm_graph_stop(dai_data->graph[dai->id]);
-	if (rc < 0)
-		dev_err(dai->dev, "fail to close APM port (%d)\n", rc);
+	if (dai_data->is_port_started[dai->id]) {
+		rc = q6apm_graph_stop(dai_data->graph[dai->id]);
+		dai_data->is_port_started[dai->id] = false;
+		if (rc < 0)
+			dev_err(dai->dev, "fail to close APM port (%d)\n", rc);
+	}
 
-	q6apm_graph_close(dai_data->graph[dai->id]);
-	dai_data->is_port_started[dai->id] = false;
+	if (dai_data->graph[dai->id]) {
+		q6apm_graph_close(dai_data->graph[dai->id]);
+		dai_data->graph[dai->id] = NULL;
+	}
 }
 
 static int q6apm_lpass_dai_prepare(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
@@ -131,8 +134,10 @@ static int q6apm_lpass_dai_prepare(struct snd_pcm_substream *substream, struct s
 		q6apm_graph_stop(dai_data->graph[dai->id]);
 		dai_data->is_port_started[dai->id] = false;
 
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			q6apm_graph_close(dai_data->graph[dai->id]);
+			dai_data->graph[dai->id] = NULL;
+		}
 	}
 
 	/**
@@ -151,26 +156,29 @@ static int q6apm_lpass_dai_prepare(struct snd_pcm_substream *substream, struct s
 
 	cfg->direction = substream->stream;
 	rc = q6apm_graph_media_format_pcm(dai_data->graph[dai->id], cfg);
-
 	if (rc) {
 		dev_err(dai->dev, "Failed to set media format %d\n", rc);
-		return rc;
+		goto err;
 	}
 
 	rc = q6apm_graph_prepare(dai_data->graph[dai->id]);
 	if (rc) {
 		dev_err(dai->dev, "Failed to prepare Graph %d\n", rc);
-		return rc;
+		goto err;
 	}
 
 	rc = q6apm_graph_start(dai_data->graph[dai->id]);
 	if (rc < 0) {
 		dev_err(dai->dev, "fail to start APM port %x\n", dai->id);
-		return rc;
+		goto err;
 	}
 	dai_data->is_port_started[dai->id] = true;
 
 	return 0;
+err:
+	q6apm_graph_close(dai_data->graph[dai->id]);
+	dai_data->graph[dai->id] = NULL;
+	return rc;
 }
 
 static int q6apm_lpass_dai_startup(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
-- 
2.51.0


