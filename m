Return-Path: <stable+bounces-169715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7135AB27F63
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 13:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C74A7BA82B
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 11:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96AD3009DD;
	Fri, 15 Aug 2025 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/IDUZvo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757DB3009D2
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257966; cv=none; b=Mlg0FzTyiyFcx8cxsTTQh1nmNncb7Ax7UoVKaLvLmr6oJwrK3Rr378dFA67VcwqI7/tCmS/UHHzOcfKJNi/5dhi+dxwOzLpoZ8HWZAi9mJ98aLjD1LFYHjOpWZHM/JD0SblYoa/iKsUjeo80O8oiukGytXBYrXZvl11NCmYmEvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257966; c=relaxed/simple;
	bh=TOUVdqm7mQx3pyxgpuavzmM5bjtretRp24F0LUMdPps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iu2NwUJ8RbOCGOOZmQ4EAHfkaHM/5amaWHiqgBl/8OWY3Dv5rfH4aopWdoZ/gTNri3Ll2hRXY3ttWTAxkJNVZ8nhhlBEAewqf/vWmbSS+iYnHAFWyKP9vvfLAfAWG/TbbMIaN9P+p0socmUZlR48noEJDfUI+X7ZzwGl29k/3/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I/IDUZvo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7a01426so29686866b.2
        for <stable@vger.kernel.org>; Fri, 15 Aug 2025 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755257963; x=1755862763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x2PuPJpMglgU/pqE3sPu/yNVHdTRzSvgqfdxSlclOhI=;
        b=I/IDUZvocmiCnc/AsQ5R5ES12XEogwqBahE75ZQlvObEuJYcnvZyE9cu93Bw/kgW3U
         ZUBraPjDhx60jJXkWxfYhsw5VUEXL4rAl+jwB+7X/9w9IOC+r6akbdBsD2HB7J101VpZ
         cfC7GNGDf0PQVvB70u2sssK6r6HFQErAd5jk+k7GLs3aXxrovHlr7BZZecpNIgDQ3JD0
         vIzLd+CPkdVcX/iqIqFSXFBNHkz3BjsXCUNbYgb5gNhi2GQwcDZFKGoLUk/DKS09OPuV
         YodXZSVaZQ0hw5iabZrMoQhSs1ELYBFEKn2Lw4S0gMR/3DkvyxCGMce6hyRr9OpmA9Oy
         yoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755257963; x=1755862763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2PuPJpMglgU/pqE3sPu/yNVHdTRzSvgqfdxSlclOhI=;
        b=hA753TuR0tBGi/Q3IZ6s1tvQkj3URNzx/sFmupR50YxTfT/2jUXmnsRvzlS5o2TYUO
         OwvcXqy5hQiNiDzhqc1G9s47KWH0XkZBLxYAS/W9GGcn/7X0zGz0WZiXQRfU2FU2lteP
         B27aXf4OBRAeH1HvlLeG8j5yW2pxXt06lnMizXba2I7CmtCfQ93O1Z21ISTE9Qip4cph
         RrH/vozN62Z2pv9ksE5MeB6+9dZq11XuZyEVCD9EHSP7Pxx+jEinbaoS+k2yIzDxNTWz
         LAVplGiZTxPdqbOsMZHv781Q1B6tfQfes/OLoebeoKZ3/WOnglIS+8FRy7NSdjEXhTpY
         fDEw==
X-Forwarded-Encrypted: i=1; AJvYcCW4p7I1Y3J1gmcoCWPEJcmzkQbrbSoA/UW6JaVJsHBA8L/eAXX3V3HRQ1c7flxHjCrHGrMDhIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx3MfKbiGOQ8wQSZgktuCX93bfrC+teq6O0XsFxCgTz6bCvpxD
	IaU+PFWiqJTNex1QcE3+ytBbi/rAA3F3GAnIsyOn+i2twiRU5Jw/B7b0Qgww5jdabng=
X-Gm-Gg: ASbGnctqR0ySSqKFIZNmtwaUj4rkY9e/sdpLuA9rqYtSfNyF+E0EZmc+xXBb3MNYpHs
	5JNRT2ENjoZEL8/gdJkDSpergLZ7Nn+NpWCOJPQYWn9K7o8ATgjUE8mxKJrqOuZc3zg6xk6FRPV
	fG1Yxw71GBh+lWCBrsyk+46w10qp16z3Chu3sq/fw+BHhpEATJqKV35qm0ChDV4eWyVr5R2ZYMg
	koZBuTMRMdTHyBxABjsx0eya8/OoIf3OZrmuoHE9ykbQj0q3IA12jp/DhWBiWSVSwoSTSYJny5+
	AmBHSgQIKhbZbKICV/pSl0HuaP12nu3RC0KhQC4muwqgUKI7Nu7PPHNwLLOxHsPjpXGH7NCOmO7
	ZFa+u5TlhmqoFFKIXfcYhZ/E5uJlF/TGA1A==
X-Google-Smtp-Source: AGHT+IG3is9XPNoMvbvLw+fw8hEwF+57P+gasZWIKWJ8zpvGPShYlYN+17VhXnG/gz0Yg6JMVLiT5Q==
X-Received: by 2002:a17:907:3c8e:b0:adb:5985:5b58 with SMTP id a640c23a62f3a-afcdc062423mr65771566b.1.1755257962753;
        Fri, 15 Aug 2025 04:39:22 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd050b32sm125285366b.112.2025.08.15.04.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 04:39:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
Subject: [PATCH] ASoC: qcom: q6apm-lpass-dais: Fix NULL pointer dereference if source graph failed
Date: Fri, 15 Aug 2025 13:39:16 +0200
Message-ID: <20250815113915.168009-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1908; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=TOUVdqm7mQx3pyxgpuavzmM5bjtretRp24F0LUMdPps=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBonxxjFL3sVlJ7mhEF9BvOAVoVIk0y3Oq7cCtUT
 GlCjUpnV2mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaJ8cYwAKCRDBN2bmhouD
 1/MmD/0cOIalRyUB+JR//1Cs3p5cLxSOEBSxH9CJO113MV4+gBkBuStuw2DEdoQnq7fr8vyL+IK
 QuNwPkWybfb18XiuVZg9q9+BuoTenfqK+/e9sx8sPPHkNS7iB/IEHFvgtxiK1AchY3AUjqA3U69
 yCNR+L+u1UefH/sDLj2MzsRWvAeFdy+m7KCGTrKXFOcge4uAIEafMI4C1zUyv9XXWbfL92hQRXP
 HcE0CsotyBiAH6aSJxTxh+V1IgkCQBrerCkA9Uu5ibAXQDJ49G8P9LHYj7YPHzuA/1Gu0+STM6g
 m/bbvqUaYCCg4unlJ4KYLa336VdTxPe/PSEwfAlCH/BioY9G9g9wNjZsUIdATaqHpH7lTXDcjui
 AkqF/WHsI7GwuamJV34jmqj5sZCRBdBr4dGfAX3vpipABnOagkNPuhXeeLmknSzLIuxdK6tqK5e
 AD0ZOLv6IHsWwFMq6nW7JiNjnRpsFRPnckz1/yynbV39YCZGnrjj21bg1hEtSgu2wruxHkPMby/
 YHdnyLf4gW3XNXb9tedwnl6Tw0xnFb8GwVp/bFTedQVSZcf7Jm9guIKatde/XJZL2u0C1tfI5vh
 914u+fedhGhaPo5GwCrHjIRVVbtloWI0EescCBnQLt7S8G07XK1sW+DswoHJq7DhIA5/cwFqoTm uJFOc2R2JX3xSvA==
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
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index f90628d9b90e..7520e6f024c3 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -191,6 +191,12 @@ static int q6apm_lpass_dai_prepare(struct snd_pcm_substream *substream, struct s
 			return rc;
 		}
 		dai_data->graph[graph_id] = graph;
+	} else if (!dai_data->graph[dai->id]) {
+		/*
+		 * Loading source graph failed before, so abort loading the sink
+		 * as well.
+		 */
+		return -EINVAL;
 	}
 
 	cfg->direction = substream->stream;
-- 
2.48.1


