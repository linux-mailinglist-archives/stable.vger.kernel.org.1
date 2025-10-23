Return-Path: <stable+bounces-189083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A480CC0012F
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 11:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5996B3A4CA5
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 09:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131872FB96A;
	Thu, 23 Oct 2025 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TbbCE/yT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9432FB988
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210185; cv=none; b=ljG79XQLvZd1W7nyco1NjmL0WkTSGltxEcHn++04tRC6vPsAYXlQ4iLxoemnnHfMGaP5ganywhJ1ZDIpv1hPsXZ0Ul6Ugy6DOq4u9DrYZreTBZ5UJFtuXlz3z2iXAeFQsw9rDlA+bSdomOgmUHlsnPZ6QT/IJkR9zfJRDc5pxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210185; c=relaxed/simple;
	bh=RvB0QfII4NieHlSWxal5DHWC4pQUcZHC+PzTz/++OqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fnfQOMirUg08CDXAlWbneZK403zR3TcmzTtVeuLZcRp7HH9UpP86khT8lMrsgwsRhSdFrNj4KkBkKRKz8N1F/yG6wkj9fjKjUBOFMgYokZxJWwkjEB0t/PsJWMQ6q0ndO2G74RcI5TUpPNok8Yrpr/N6j7ghAJUnBf4xWrOaItc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TbbCE/yT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47103531eeeso149975e9.1
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 02:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761210182; x=1761814982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0lmo2gSK6dC5/iKwrS24Z1fB1vhkVWE57DPvqhuyE4=;
        b=TbbCE/yTNL1Fyu0hWMxzS+f5RoV8ls2DrB4pC0p2xW75nNF4HUfRVDJWSOYePU9Ysm
         6C5YqRso6lG6ZTJDZN51R6VnbJzPEe5Enthe9ZYK1v5fyD7dBLGPKDeUaZpVV0WTeB7Q
         dgzqzdhCCTCseNMaETuVxidt6pcCIM3uu+j6XxpG3hZep9yryhPjzAPFjfYHbODoXQQl
         S7gtIV1DQKDH3/e3iBjnifwFHI3A8t+2HXyuh+CXjPGScDuuWfRke1NU+x02OPtUN3Hg
         2lANTJizQmy2YEHOg2Nu/C2NxnDqtZSI+BEMJWq/W4pmKSml4uBdGUeLGBtcmOraeP3U
         P88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761210182; x=1761814982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0lmo2gSK6dC5/iKwrS24Z1fB1vhkVWE57DPvqhuyE4=;
        b=FqThy+DDkopJo6kTdnz9gK0vKdUV4X44pmIzHTQG8nn+HNuXxsPDevl2KUyv6WrV5c
         ykQo964UIDeFLLYB9F41Xtwd7CMvxesLa546A+p96XujSee4sa97jh28gV+VMO1FcO4C
         2DV0ftxyEJfpKmm3ePl8tRkj1A1KEcrjyls2NpUnerNERKs+CMpR0dW11U8tYZXvigZC
         yNXax11VDpG6UMJGuLBerKeJnOv5CPcBraGJUBjg0Uww2fa5B8jTIn0IukX746xV5PMh
         9bZ46ZgqDFspcoVOEo/QD4ZLxn1h/uVW8AGgYT2Fj140UYIez6C64D31goIbgUSMqgQ/
         Lrkg==
X-Forwarded-Encrypted: i=1; AJvYcCXSpmVELlkTgOjBhtf5BO0kD0zDNADcphMacqZhMf7IvdwsN+qVv4jK1mBYxTgslIp5kKs61lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBpmh0BLSn/IWjldej3aEnaGR2P2/xnn9mnwuIcvFhjJTDOjVs
	3QJYN6hZnlSSpUGmJPGZln0cctQn4/yxrZl3x/MeFLPGA1642tOj3Ew4DjH/9NC1FVk=
X-Gm-Gg: ASbGncsk++QQxVk+4xISNPWQJJD6ZZWgmPaewQgvwK4sehijHg3G8Uz8E7T/uHeBTy+
	SkunVzV0ko+iQnTscCIoDXpA1zFq4t30C0uhPP/c4CtHI2UPMZzvOAMxZhrmRAJONd13HE6kfJc
	Ef9R3sVDsd+fXVWPy2kpq01q4OMW7e6i+YobSrvL8+7Z1hFWdPYJcmC6BVHGjbdDIqGFDzy2+eV
	I9hq7RL45anYuWMKlvFSfSQ3A4TRWU7i+kdE/InGFYAayJrnjiMn7XkK+h+GjhLgNyhU8HwHp5a
	0HGB5JgI4WxxRGRjFsGDJzNB5PfxlKI2fSqM3wQ2oh7N3ca3xYky2QYyY73Y+BQeufjOYOsTGAS
	mMMESMpBOyKdB6GkXZUb4b1F7KJWVYRKC+mgI2O7emfMU2WTWk/nFhGa+pk45Hh6oGJHQHlEa1i
	HYB4Wu3Ck7Z6bNV5piB0Abb5BiH/0=
X-Google-Smtp-Source: AGHT+IED6vyXHphp1/qY9Tno4NQeRDekE0RdTtSCtP7Dt4LSJrXcGljAhWwqEXuSADOQSeczj7tsKg==
X-Received: by 2002:a05:600c:3b02:b0:471:161b:4244 with SMTP id 5b1f17b1804b1-4749439ec9cmr42438295e9.5.1761210181644;
        Thu, 23 Oct 2025 02:03:01 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-474949e0a3csm57557415e9.0.2025.10.23.02.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 02:03:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 23 Oct 2025 11:02:51 +0200
Subject: [PATCH RFC 2/2] ASoC: codecs: pm4125: Remove irq_chip on component
 unbind
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-asoc-regmap-irq-chip-v1-2-17ad32680913@linaro.org>
References: <20251023-asoc-regmap-irq-chip-v1-0-17ad32680913@linaro.org>
In-Reply-To: <20251023-asoc-regmap-irq-chip-v1-0-17ad32680913@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Alexey Klimov <alexey.klimov@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=RvB0QfII4NieHlSWxal5DHWC4pQUcZHC+PzTz/++OqI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBo+e8/GYFUijdJAKhixCgluMcrMSqaCUzWEFwMT
 hCKiKSlid6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaPnvPwAKCRDBN2bmhouD
 1zXxD/9SorjfLptnntRhhKS9ae8uP8iYdmgGaYBh++xUoDagGf60z/a0/ECNV7RHSNIp/ievlC8
 UH7q7SGN0HS9OkjQiD0atioUjpLpDfMIg2MoY4Q8BxDzG7MKFB2pC/vXDJW/tgL24rZmKjWevR2
 asW1KbgrTl2iuR56NbyDcfoT1cQ3HQUHk+gcgHtyi4MKElbcS2uyCbhe/4cevCpyeGPxOh8pKvz
 IkX3RwocFPza8PSe7egItdTLKsnKy5XBBFJaSox9kc0ErH0+ee13/vQHr7zLuAZnnymRJN/P3Dl
 WieCTZebuLgIHT6Plh6inXm7mk1j7WGhzdpSYoo5Etl9Tb+SWxBi5wYlGqTIY28TTm+tMCj1Vut
 n9M6aBnaodiyw5NHhY28HYmvBLonxHQMyu9aq1G7dIE3IotfR608K8hWGCsQa6ao0STrqzpOWUE
 ANsBjjBeSdNcShYtHxNl76GFqINCCDlfG9qjH5G7Kax4a4B7I2Q9bzmC5AuWurL9MwRbL/457OT
 4aP+fZp2oZbi9xpQt5tb2BJHxtqJLhdhQ+Sw0DzsKgEkcq0Kr/MfnCSyGMB3L268D4T1QZ4LYzP
 uA7mrxWuk+iPgtz/5Cb7pru2gYoCJ2QxhsMYAT4HvxhrjL13/LosFZ5eTFQcZWmN7LG1HvelzpP
 Z7zVyu6HaBmXmLw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Component bind uses devm_regmap_add_irq_chip() to add IRQ chip, so it
will be removed only during driver unbind, not component unbind.
A component unbind-bind cycle for the same Linux device lifetime would
result in two chips added.  Fix this by manually removing the IRQ chip
during component unbind.

Fixes: 8ad529484937 ("ASoC: codecs: add new pm4125 audio codec driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/pm4125.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/pm4125.c b/sound/soc/codecs/pm4125.c
index 410b2fa5246e..c5ac2e6bb44d 100644
--- a/sound/soc/codecs/pm4125.c
+++ b/sound/soc/codecs/pm4125.c
@@ -1658,6 +1658,8 @@ static void pm4125_unbind(struct device *dev)
 	struct pm4125_priv *pm4125 = dev_get_drvdata(dev);
 
 	snd_soc_unregister_component(dev);
+	devm_regmap_del_irq_chip(dev, irq_find_mapping(pm4125->virq, 0),
+				 pm4125->irq_chip);
 	device_link_remove(dev, pm4125->txdev);
 	device_link_remove(dev, pm4125->rxdev);
 	device_link_remove(pm4125->rxdev, pm4125->txdev);

-- 
2.48.1


