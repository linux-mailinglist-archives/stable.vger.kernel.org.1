Return-Path: <stable+bounces-65480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4D1948E16
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 13:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A091C233E6
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 11:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51BB1C37B6;
	Tue,  6 Aug 2024 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHJhtWiB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1622A1CF
	for <stable@vger.kernel.org>; Tue,  6 Aug 2024 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944960; cv=none; b=UvKZDmZmQ9sGlGEuJQQ9F0XzCExASiQr4tNzkRxv0mFH+Cdj/OGYA/FStkaM8AfuUzCMmh5eI+HrjR0U1lwhJQpDF1vSVzZhOvdROmzpOPVUKAtzhxkBk7cASQXvw0UTtelhyf5WaPQ/1VRi9/MlJ/OzmW0YXA7HtKfdL7GQk1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944960; c=relaxed/simple;
	bh=HK69OtcF/Vf94b5GhLN5TCYnV2gFptY6A3zc3NCas5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UJ8FJcoK+ZjL7VaEEpD0/NlbQOGGALrgphbUQN5gJHUlNy3EIs00TLiVCnPSXf9VuOGF7mM9dddTbKo8Gb4plALLiGhVKYGK1FskNeHPTbKg0NUmEfIgEY7/Jij3KpBC2D59R2cUZE8biLEwADBWSSmhXLVe4dG4ipzB/7dOXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YHJhtWiB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso3843135e9.1
        for <stable@vger.kernel.org>; Tue, 06 Aug 2024 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722944957; x=1723549757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PXVpYau+0lr9R+A94wXB50FKZnvpt0eTOY5VusN/TE0=;
        b=YHJhtWiBMuEBA1sx9mWsKQSG8KgA2U8hzYVTChGZa1GE9v84iSM1j2kLcwJQuHI7KX
         TAbWpKfeTntfrlzjT7IiOoq02UIP8eWJn33ZsWwhhyREqqnqCCgoQiLvzMeaMvDVMotP
         K9qycpyFYPSwaKwidIG1JyqoFk69OuK7efFEqqQuKLHWyzq4/r+Le8FqqBq1+lmCy4zL
         9yLRXV4AI40aqXBZSbelqzjruqTu9I2SIWD2eDMi27BNJNMRpNDTvicj0beZtOiuHcHq
         +ehXASoKwdSRf3xjvyZX/0yxb7fMVM7xYZb/8P7SDhM8LRk+yogFnfVdBouPIQpOGY4e
         jGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944957; x=1723549757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXVpYau+0lr9R+A94wXB50FKZnvpt0eTOY5VusN/TE0=;
        b=DUSJPm4IaCQHkIuS2mqVyZsntbZXOO7Hywqa0bGABFiIfeNY7pA3MRfPHPEQUuJdBZ
         MTDtxVDvEhJXTZk6dRlMUPArDkK+9vk0s1ZDC3ZWy9ucb9FbptFbduQr6DlhI9CVRrsS
         DtbMRFvvQgkVPCm/Bln9JMSaBhwWpIThP1uJfmJAO9+JzVgBxWuWzefa+BhoY+m7HIEY
         tf6d8C/CsstamBAvuBzCX2eSZjjXA9nCAVsNOePz1PjoWa40aPIGVo4RhYz7ChaSLi4l
         JP5D9jhEGA5mM3yOawpOwRPtSak5OgPuYmVpiSvUCZfB/yjLdEy1uPWgq28QnA7FNlV0
         mYBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA6p0oMivdFD/wbyy9yrxq+ryey5eX953ZwZNsOW5Hzmo3sMsksgX0rFV0lwE2IkALStgTyX0GBI6rtvEGdB9keeDwGDPW
X-Gm-Message-State: AOJu0YyT0aT4vpwgWQU1H9IB6FYoWe6y4riVx/5r1u3SKKoRILQqx859
	TACmexS5zBTnah/b25isgfJP1SoWN8GEOKx7sn/KJGF9sn6e6gdB+I9l7+tKH4I=
X-Google-Smtp-Source: AGHT+IE57sgPG7MXWgWPSR/NBtN6707/MUX7FS0F0l/Q4cnzEb2aq3Uun92NAyWQJVWdu2uJJE8AgQ==
X-Received: by 2002:a5d:51c1:0:b0:367:89fd:1e06 with SMTP id ffacd0b85a97d-36bbc1312c6mr10073817f8f.36.1722944957105;
        Tue, 06 Aug 2024 04:49:17 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e9d887sm177773605e9.43.2024.08.06.04.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:49:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
	Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org,
	Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH] ASoC: codecs: wcd937x: Fix missing de-assert of reset GPIO
Date: Tue,  6 Aug 2024 13:49:13 +0200
Message-ID: <20240806114913.40022-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device never comes online from a reset/shutdown state, because the
driver de-asserts reset GPIO when requesting it but then, at the end of
probe() through wcd937x_reset(), leaves it asserted.

Cc: <stable@vger.kernel.org>
Fixes: 9be3ec196da4 ("ASoC: codecs: wcd937x: add wcd937x codec driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/codecs/wcd937x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 13926f4b0d9f..af296b77a723 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -242,10 +242,9 @@ static const struct regmap_irq_chip wcd937x_regmap_irq_chip = {
 
 static void wcd937x_reset(struct wcd937x_priv *wcd937x)
 {
-	usleep_range(20, 30);
-
 	gpiod_set_value(wcd937x->reset_gpio, 1);
-
+	usleep_range(20, 30);
+	gpiod_set_value(wcd937x->reset_gpio, 0);
 	usleep_range(20, 30);
 }
 
-- 
2.43.0


