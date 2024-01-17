Return-Path: <stable+bounces-11853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2A583095A
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 16:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613181C2194C
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 15:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C45522F00;
	Wed, 17 Jan 2024 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IrakBhjW"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853E4225AA
	for <stable@vger.kernel.org>; Wed, 17 Jan 2024 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504342; cv=none; b=KgYp3ZgOPpEDzUv3edK+urNF5h+e4ZAmbpUiZS2SzPnAgMUyykuOlFSEoo9GHOLCeghxjGP8XgkmCETfEWioeoUXshSQ8NTLEguMxe6+wydYM8hREDrVKaCTWuhvBbq55NJ1pr9NjpM4JnxuZogTohzyykUhugYB0nyol90qn3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504342; c=relaxed/simple;
	bh=zTLF4pKwDUhmIJpTw+ifYX48G8Y/tLdkZCXLW1dsOdg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=ndoiD6DeWZt1qvB1Iq5URx8SmAHEtV8E7xUq5sOxTZLoUc3rB6x4D0ShmYUpiC7iKwLggtnsy+dUs2cmKKoMaDy64Ps8hER4WzIMroTVrHfzzMZ9ZBeEQHVPwxv8wm+sYdxPoJ8OxuC993n9YXXV0QckFZ6ChOS0MtR6xRmivW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IrakBhjW; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7831c604a84so818333985a.1
        for <stable@vger.kernel.org>; Wed, 17 Jan 2024 07:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705504338; x=1706109138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aZ5dWg/o67onmhTzNFtXrOTvUPTxoBK6DGUcni7z13M=;
        b=IrakBhjWYcTx281uJkfflWwa2NOYOeI1bCsGnxGVZrm6IjaBFUx7p0duk6zyKECBmQ
         dY/7X03ylYyCkWz59EehpkTbs8mKqgtBHJSZ/QWQeK9fDPI283k0wJ5UmQqtlYKrPGvm
         OWbP23UZMsfMSm6B5xliduX7ujbSXRKph1AgCZgFWgKSMVdp1T9fLtX8ov9Ec9aeYYom
         baa9xku1mtGfyq662seh7VQELl01Wg64sLh8kFd8W0DgONwth41KNlNEvdhFNdGIab1q
         MyE30R3wPb+HvgHbmC1dHoBz3oqYYXHlpjMqxwL0GJYb5nPqsbQk+O9wFMXudX9GodPm
         tceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705504338; x=1706109138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZ5dWg/o67onmhTzNFtXrOTvUPTxoBK6DGUcni7z13M=;
        b=IJDn6a9SBk9Gri1GiRxQCI39R17Ml63up0YtpnLzGcpiVZ+Ezs2OXTS2Rz7Ejqa6jF
         OwFtl7JdS7G/6w+u8+6ukQTQMFW+KtFWNHNjd2mkS33bFXqNtI+rInSJhn2vzK/5Zj3p
         bX68H8oZNa+JPGWMN3hqZfKXc2w1KxqJtHZtK7oGtMRU19DBLoP94x2izT1M/UR1vL4b
         D05jzqjuI8yL2p5JVgtP5/+iN2Xx0SjEFst+RuoNAodMs//iwz5NauKXR2jwmjbEk60X
         A0NH3CyzWLL0eiT3eEiAbqbFizOWrRgLlp72eC3MTPV28DZaD1PbBH2RFGrTqd/Y9zCA
         q4yQ==
X-Gm-Message-State: AOJu0YwPCp96Lr2AiGW7rKW3j2aDhIQfp4MlHzzJBFnGpvVjWqkwaFuu
	5Br8XI8+DQy7eYeBYCpE0lIuQbXO83cpMQ==
X-Google-Smtp-Source: AGHT+IFuzN2ZXkdL1furtqKyL/+PADgDDPC7U/QwREJrS3KVsloHm7pc6AYqgLOErGBf8DiUCfrogw==
X-Received: by 2002:a05:620a:55b0:b0:783:54a1:136f with SMTP id vr16-20020a05620a55b000b0078354a1136fmr5882267qkn.58.1705504338226;
        Wed, 17 Jan 2024 07:12:18 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id m7-20020a05620a24c700b007816cf21f7asm4519337qkn.76.2024.01.17.07.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 07:12:17 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] ASoC: codecs: wcd938x: handle deferred probe
Date: Wed, 17 Jan 2024 16:12:06 +0100
Message-Id: <20240117151208.1219755-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WCD938x sound codec driver ignores return status of getting regulators
and returns EINVAL instead of EPROBE_DEFER.  If regulator provider
probes after the codec, system is left without probed audio:

  wcd938x_codec audio-codec: wcd938x_probe: Fail to obtain platform data
  wcd938x_codec: probe of audio-codec failed with error -22

Fixes: 16572522aece ("ASoC: codecs: wcd938x-sdw: add SoundWire driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index faf8d3f9b3c5..0aaf494844aa 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3589,7 +3589,7 @@ static int wcd938x_probe(struct platform_device *pdev)
 	ret = wcd938x_populate_dt_data(wcd938x, dev);
 	if (ret) {
 		dev_err(dev, "%s: Fail to obtain platform data\n", __func__);
-		return -EINVAL;
+		return ret;
 	}
 
 	ret = wcd938x_add_slave_components(wcd938x, dev, &match);
-- 
2.34.1


