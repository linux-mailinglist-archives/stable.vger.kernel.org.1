Return-Path: <stable+bounces-180848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B93B8E970
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 01:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DE0E7AB005
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 23:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87F824E4AF;
	Sun, 21 Sep 2025 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaFvjo1w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82DC1EC018
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758496575; cv=none; b=smjDXb3WCHqH7kpOULSlMtPSg8Bcf+SGCZY8eS3iFwzfTzEqc1fyfIpaBVIAQi/gEn8VpWX2zmWQilrwF89/wreveD13SiBsZ/4EIXmoRlb6YmtXS4HSaAjVl1wHogdYlyyTro7vEBzUDo/5HRJiwRCOPC7tn85Y4yk+kuaEKj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758496575; c=relaxed/simple;
	bh=tmsdMto3syFtjMtzf36dRiX93I+0VO1F3JaNn2ab8zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eAAaPxAsHqB9TXIPdNN/JaNQsZYWIf7lhGjCyv2sEzjkVu9ks2eAxNJxLh8X3E7TMmZVJ4tT/0I8nlnR08240Xc6s77aoFBfaW8IQ8g/geD7psSwHafGu69hgn4/ax9IK/M8beYjbVd319KPDBO/TtHIM7hfTUfGssnW3nz+fTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaFvjo1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B631AC4CEE7;
	Sun, 21 Sep 2025 23:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758496575;
	bh=tmsdMto3syFtjMtzf36dRiX93I+0VO1F3JaNn2ab8zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UaFvjo1wBZZUd6ov/PaS7CK+b/kkgAj5kQ1PghtOHcW6Gvrd1cqb5MwLXAHcdt5aq
	 kA2cjbNcOkR33E66pNl+HzqJr2FaZocyeApA1aIlOFDrlbj55BReLDD1K5divSDy3u
	 lRwtEigzNBFF7R4YmkyHMDGOBsq8rzx5maMr2M3AZDJbiCq3b0gY4o1HEPUcqcgvR+
	 ccBnY6N9SnjZPrPXfQX7ONi08/LBkgbVcD/RadWJrU8Xgr0/vhYErfpt0a3HRQkRIc
	 vjAycvjvaVLDy6UO0UoQnIaDEikz4FLHiikGEBTcsuE1lMigxKX4MK3URttpJyIAJd
	 +gIFoXKZ2s0Uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] ASoC: qcom: q6apm-lpass-dais: Fix NULL pointer dereference if source graph failed
Date: Sun, 21 Sep 2025 19:16:11 -0400
Message-ID: <20250921231611.3032852-3-sashal@kernel.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 68f27f7c7708183e7873c585ded2f1b057ac5b97 ]

If earlier opening of source graph fails (e.g. ADSP rejects due to
incorrect audioreach topology), the graph is closed and
"dai_data->graph[dai->id]" is assigned NULL.  Preparing the DAI for sink
graph continues though and next call to q6apm_lpass_dai_prepare()
receives dai_data->graph[dai->id]=NULL leading to NULL pointer
exception:

  qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
  qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
  q6apm-lpass-dais 30000000.remoteproc:glink-edge:gpr:service@1:bedais: fail to start APM port 78
  q6apm-lpass-dais 30000000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC: error at snd_soc_pcm_dai_prepare on TX_CODEC_DMA_TX_3: -22
  Unable to handle kernel NULL pointer dereference at virtual address 00000000000000a8
  ...
  Call trace:
   q6apm_graph_media_format_pcm+0x48/0x120 (P)
   q6apm_lpass_dai_prepare+0x110/0x1b4
   snd_soc_pcm_dai_prepare+0x74/0x108
   __soc_pcm_prepare+0x44/0x160
   dpcm_be_dai_prepare+0x124/0x1c0

Fixes: 30ad723b93ad ("ASoC: qdsp6: audioreach: add q6apm lpass dai support")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Message-ID: <20250904101849.121503-2-krzysztof.kozlowski@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index f4e18f4a6ee61..b99a763e51090 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -176,8 +176,10 @@ static int q6apm_lpass_dai_prepare(struct snd_pcm_substream *substream, struct s
 
 	return 0;
 err:
-	q6apm_graph_close(dai_data->graph[dai->id]);
-	dai_data->graph[dai->id] = NULL;
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		q6apm_graph_close(dai_data->graph[dai->id]);
+		dai_data->graph[dai->id] = NULL;
+	}
 	return rc;
 }
 
-- 
2.51.0


