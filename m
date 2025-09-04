Return-Path: <stable+bounces-177714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B30B2B43890
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 12:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C545560ABE
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 10:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9E72FDC30;
	Thu,  4 Sep 2025 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XApCXX6N"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D372FC03D
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981137; cv=none; b=X0lCAyG6pqlSfMoIAtmW/O9qraACbHVaR6/Sxf6G1+7vR2drMvUXSbBQA/p+Pr8G275CszH++uUoayrMkkwGqEeCq1W0Ln6Njslp68rqqh4e0D7rHgBc6eNkQ+zJDAPc3YgH+6vFQmzg2duzOUl9B1Mkp7hM6MbroHZYM2J7KFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981137; c=relaxed/simple;
	bh=0z4DvdjsLX6ePogBY1auCiBA6lQ5eI1Z0Og0lwAREbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j2gNad/GhmnYMSYCeyZ971INJA37CIqfLByjkqNo2nA3+Yv2fmRVhrKfZIPQ8DHKxtLBzn2zxe7IpaQPrbvfF8C0v1IINVxxxXQgrLcij8Qvq6sR7UmVAUKy1kzyQ+XM0d+gl1LKYObEYWT/wf6DQf6nISUmMKJj09jHtU7GO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XApCXX6N; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61a54560c1fso199486a12.0
        for <stable@vger.kernel.org>; Thu, 04 Sep 2025 03:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756981134; x=1757585934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=788DvyHs5EODeIANR32XpfigfVcSqxiFxI3EsfOqEDI=;
        b=XApCXX6NeNhNAvhmv8CVw75krY9UpYhjvZTYa59GqJjJPe/TOI8//VN5zgPEHK1BJI
         QSs7lI7/izZE87KcZxBE/eR6DcLe8vuE7ipf1VZpcZCURX2sjonDp3yXj4cqZu+0nreR
         0colCHAEN4emV5MzJ/TLPjVYH/fQf0ECbzthOIAjTtcCwQutEArATKMTtZfpYVD9f3z1
         EwYofra9Qx/hmCKqnHcAI0wICaH6bNAjVW6gkKgKjcsl2BU8RYvo6LPFOwC+I1ZSm77k
         KWwNFEa4KWsL3Uq0bOHmPfJvXwx+g9Q5MwY7K7MKfcdz7xFlabxX5uNJK0tVZQ/n/DP8
         /zwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756981134; x=1757585934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=788DvyHs5EODeIANR32XpfigfVcSqxiFxI3EsfOqEDI=;
        b=VWbwSygjLYATiVev5ANmwHbzz9y2LdqS7I+y5pJOKx6zIsfjopRGKNJK6suS8cTwit
         +mkGVxPQd41Mprw2bQ/PTpy0Ll3l4gZ94z6cJN4pC+N+1VzD+UzNBKaTGCvtkZyeOlBn
         5yVcWSJHhn/1zPhEAz8wrDSSspyJF6ysu2XuqzPTRK3GGFu9CvW41TuINOsYxGgBWwm3
         SgajI4RLGqlnsVRxW/zkAKctE739TA5nyh/KPEwFewGucEMuFFA9F4X0PqxIJSsMQKlQ
         EYTznzsRTO4km3b7a7orC3Jp53/N6N5u8J8zZM3JlBJyyxsvjyiVQgmU/bIRuE33+Pyf
         xugw==
X-Forwarded-Encrypted: i=1; AJvYcCWF8YMa1Xs7iYkKznVm3lFmcc1EJEKX00kNZT9uzWIudvMRuhJyJ6pncU5Gr2Q44I+HNHVSYws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNz1JbUV8fy/6cn5YVK47yOLikoOeVOmUTtyYrVgOarbFe56PA
	RwrJs4lKFbnA208GbMqzOGuhIBbgkYDulG0+w6W5Ppn/yVTU3jDViliLK1F+a1n7nSk=
X-Gm-Gg: ASbGncuWn8w6FIAqp0HzxGlE9f/OSZx7KhVpDxOVoKCSwiUZm2npuyOL77SRmG1PAMT
	wFYbmrET3HedaEV2W+R6WJDtG9DUNDg88Q62+fT1KrmsA7Q0DEPdf4EiYBtJN87I8PUi3/yAhOF
	kXhCwMqIfw2AeJCEoUjW3TTf3RsVMPjqoc4cuFc3qFjkrfHjTm2XU3QX7aO/Ue6D3dGwm321wF4
	qpeIBKnotWso/7YX/5l2s5OZru3rkexk8zcHtE1GorkW/zD5Y7060lzrQKMrP80IQN5hgnqK3HR
	4FXmIHAS1sHFnNp0l8oRLK+qlOnTALZ4PGLKhxAQl9trClC1Fpewize0+u2RakeaOv0gcMjdcuM
	7UBm8KLJT9pS7QBbg+KMAMyYIy10U0Ape/gUYpH7rWH+l
X-Google-Smtp-Source: AGHT+IHWntgtcODAj/7kFve1sXTz2DdTGamGtUT21D8b3aznENuQ1mZPsX7EylSYmJeT9xBCC+l8AA==
X-Received: by 2002:a17:907:25c3:b0:afe:b131:1820 with SMTP id a640c23a62f3a-aff0f01e9fcmr1044118066b.6.1756981133581;
        Thu, 04 Sep 2025 03:18:53 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b041f6fb232sm1103667166b.87.2025.09.04.03.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 03:18:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] ASoC: qcom: q6apm-lpass-dais: Fix NULL pointer dereference if source graph failed
Date: Thu,  4 Sep 2025 12:18:50 +0200
Message-ID: <20250904101849.121503-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2051; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=0z4DvdjsLX6ePogBY1auCiBA6lQ5eI1Z0Og0lwAREbU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBouWeJllIVY+hQGdNqHZvj/tioDr963JGTfjhCS
 P6pL6DYWlOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLlniQAKCRDBN2bmhouD
 1xJfEACRVcFni8dKH4V2yPLhU+lrF63RMHnlRzgHV9jmPHmN+MvF6Q2Kz+dfrN9qSOaI3EQjmUq
 qtnY7eUeCe7aPA3eUdRBbqaoumyMc56M7YQW6HWWVHBkpHQz5xipIT7lJyIUSJ7WGlr0xFJfnLa
 TBi/sKAZKgvvjhfKe6eXwSxpl2/L1/hQ6BnWrURJH1bwxDyJl6j+wm7BNxOo6QJgHQc/J9U42u4
 axXFpApSpaZ71EZIyaiyo/PdYPX2EULNm8C+gOFIrsggipVxt7oYTzEQhogJtblISh3H/rtBEQ+
 vqNNlphoEEpCnwfrKdGYIKiOU2S3xp/QLm3AQCxFKSSIbg4q7PHl8mCsiIaXVRQAtVoBuDguZ3/
 CwlY4Hl+zI9wsNdWh09G8+C95WOGbSQul5LWEzq+eNlopX/2r/50m3Yu3kmFNqEARid/PtgtcrC
 OJTMRJW4Ohhsi8HGf0GFyv1LAl2P8xu4RUwVL/4SP2MzMg7iazAlZbbXc05O9BCvfP6s0JI2Yu+
 KNh0uP7oXCAKQ7Jt5J4zGI0376RuS4fEgVofTdSYnHZi+9OQES9Ww3Kps13xIS96+9zrNe/j5Kl
 CiC85g6WdbLDFSEg0I4eZ7bpdN4Rgj8GFOVVUYgLJqFXdb6q0LLrAJqodNUAVjtAeSAgitAbAhj ywZWoUCPOGTRV5A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Use approach suggested by Srini (you gave me some code, so shall I
   add Co-developed-by?)
---
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index a0d90462fd6a..20974f10406b 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -213,8 +213,10 @@ static int q6apm_lpass_dai_prepare(struct snd_pcm_substream *substream, struct s
 
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
2.48.1


