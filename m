Return-Path: <stable+bounces-43170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5049F8BDF49
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 12:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A35E8B21489
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 10:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AAD14E2CD;
	Tue,  7 May 2024 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+9WF2m6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6DA13BAC3
	for <stable@vger.kernel.org>; Tue,  7 May 2024 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715076136; cv=none; b=ObsJnyDOFUCShiP6BDHNIS8+ayIwKcn0hoSVccC3A8HUzCmdBv/I67xyvJqs/CFHYUXSFUsEVhmi+1SImEKHHrcGvptPn9YgKfRHlIDUKFNjGMO63i76xFS3j09OIbsa88/JI6PYsHM4Y7s9zwfpzd19KLvGVlXI6PIbM/yB7uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715076136; c=relaxed/simple;
	bh=jxrbP51ApwB+nB6k7droxBtoZKEplqH7fzVFkVtvoqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lplcdfc+4uIlVR8pz7js5CW1TdVVJIKAO6H5W92jtkehPNr3hT/t4+1+ldBEnRmU+PhFVq5LbHfiu8KHIB4rDbp/2iYeWquuSXCI9YtSkgGUUjspiC2RdzatUglcco0+K8mV6Fdagk3TuzrE8dcsoXG3Xbu6xNN22xKMtq3mk0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P+9WF2m6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59a934ad50so648098366b.1
        for <stable@vger.kernel.org>; Tue, 07 May 2024 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715076133; x=1715680933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xh7EFY8Q7bV9bAL/jh9gBCI67O6P18pHtiY/L20Df14=;
        b=P+9WF2m6Emwn3JDxXyLaM8QqaHtR/Q3qWaG9wtr8+XBpY6F2Nyf/vFAZra2GRg9zwN
         j381UFzEGFY/E6nqKVEMm55v6rBH6s6BM2TK9R2LT5TtbdE38jVonK4sAUtscUnlHcQx
         xANP19lb8T8eIduQv6PS56zyuSyPJXMGwmhJEQaHq9aLFECScs3UYPUnAeep+pkFTJO/
         TPN3A92qIwS7ChNl1QWciW3H4JwTmzpGfKBMUIZYUttQJbv0kcgV9v/K3DFTG8bk6T2A
         5HJuqxJQxahHcfLg2awFxMwjoCZ9gmpy4Ysic9c/tvRbsYUNmmYbu/ZeY1mV9jtbf63S
         rI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715076133; x=1715680933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xh7EFY8Q7bV9bAL/jh9gBCI67O6P18pHtiY/L20Df14=;
        b=VCnT3vsntD7MNFMdpscurqM3o77tbAokA3opXE2/6RyCFprSXHeArVtJIgp80kS4dI
         hEnXaaNVenDuSBN2Be9Vk/e1RoSwaMmRQq2xVTWLy4gL8N3zDXnY8xH4akcwTFHZgR25
         POjVWJMW61c7Led0ymJwyezNtrDlx0JjWIFHGT9zLjkCEDQY+65oREvbKtUNW7F4i1We
         VLDmG/xzB0YnrBGOUmxMau4eCVX6GCqbYl1H30njweCWEKpaSOkqhO4ECyoc2pr15MQD
         arFjAMfsrqB8F5RPdl9r+k3p2vAPgAHX4MHM9I+M+aw7A0YZrRKge2FV7TAcO8TAcUDW
         sxfw==
X-Gm-Message-State: AOJu0Yy0/5DXBqkawoY+OpzI4uDLSov+vDqQcx/A3x50YVaiURu32C9G
	VRZ6Ez2Et3dF+gJvcSDSAWjFkfyGN87twagBlbsjFfb3lFRsuih6mlXaPK8Wo0A=
X-Google-Smtp-Source: AGHT+IGdTeYrrvQuiHJ267AFGQGOr/InjQ1hSYK78u1GMZuzU7Nd8dK+zAN8gjqU0ku58bn2t42Wow==
X-Received: by 2002:a17:907:1b06:b0:a59:9a68:7283 with SMTP id mp6-20020a1709071b0600b00a599a687283mr9092604ejc.12.1715076133185;
        Tue, 07 May 2024 03:02:13 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id qy29-20020a170907689d00b00a59adb12790sm3792651ejc.27.2024.05.07.03.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 03:02:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] ASoC: qcom: audioreach: Correct mapping of back speakers
Date: Tue,  7 May 2024 12:02:09 +0200
Message-ID: <20240507100209.610436-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qualcomm DSP, according to downstream sources, expects back speakers to
be mapped as "back", not "surround".  The surround is used only for 8+
speakers configuration.

Reported-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Fixes: 3c5fcb20e07e ("ASoC: qcom: audioreach: Add 4 channel support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 5291deac0a0b..c655f0213723 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -277,8 +277,8 @@ static void audioreach_set_channel_mapping(u8 *ch_map, int num_channels)
 	} else if (num_channels == 4) {
 		ch_map[0] =  PCM_CHANNEL_FL;
 		ch_map[1] =  PCM_CHANNEL_FR;
-		ch_map[2] =  PCM_CHANNEL_LS;
-		ch_map[3] =  PCM_CHANNEL_RS;
+		ch_map[2] =  PCM_CHANNEL_LB;
+		ch_map[3] =  PCM_CHANNEL_RB;
 	}
 }
 
@@ -851,8 +851,8 @@ static int audioreach_mfc_set_media_format(struct q6apm_graph *graph,
 	} else if (num_channels == 4) {
 		media_format->channel_mapping[0] = PCM_CHANNEL_FL;
 		media_format->channel_mapping[1] = PCM_CHANNEL_FR;
-		media_format->channel_mapping[2] = PCM_CHANNEL_LS;
-		media_format->channel_mapping[3] = PCM_CHANNEL_RS;
+		media_format->channel_mapping[2] = PCM_CHANNEL_LB;
+		media_format->channel_mapping[3] = PCM_CHANNEL_RB;
 	}
 
 	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
-- 
2.43.0


