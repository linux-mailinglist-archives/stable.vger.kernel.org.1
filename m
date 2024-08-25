Return-Path: <stable+bounces-70116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED6695E4AA
	for <lists+stable@lfdr.de>; Sun, 25 Aug 2024 20:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A05A1F213B1
	for <lists+stable@lfdr.de>; Sun, 25 Aug 2024 18:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A180172BA6;
	Sun, 25 Aug 2024 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L5IkOULt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6771714A9
	for <stable@vger.kernel.org>; Sun, 25 Aug 2024 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724609158; cv=none; b=jKzZ0fG1V++ElsI2nLWW9t2jmKXaosdyb8na8dBl0RKcEAZZ7FiFW2c/EV008Ly75/n+y1MOaQoR/huuP4wyGi9yMyPVcA1STJFgdOz+niNTAPDLf7M9/cS+06+FKdqpK/bP9b2ye9/wob1NzU/srYUbbZCduILBqbNK5TLaXCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724609158; c=relaxed/simple;
	bh=djfTpzgwI9VayrirIxvL2d17DNLj3Y9kYYllCM4F/9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BqHnyy1J58SUhhH3KQnWiBWVcuUE/jwq2/NidPgeRX64W3WEqr+vClBH6T/UdKNsSXGEvf6V9oeJtgq0yWYTUcc1DVkE+oKF2Agv9au9D0niswazbJhLUAoDV8YeZylvgEXWAV2Gaoyynb+xPYpHaFYFRkttlDBZIPaOX/b1iXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L5IkOULt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4281da2cdaeso5557085e9.2
        for <stable@vger.kernel.org>; Sun, 25 Aug 2024 11:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724609155; x=1725213955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raI+n19QFN29zfHeug6+Nnj8oFJHmaYrdY3f2jmORFs=;
        b=L5IkOULtkUe6b+FYxYJ9BGFp1zpuCB48l7f6CsYL4ScPUotwg9grT6N+rQV0qOnCcW
         q1veIaZRIdW6XzwOC9doCBoFvNqavnFwXxqqdzMR1Pdepn/+3b6FOzn4ADa/f3ANBBte
         T1KdAWn0hx96DKDRt0CaspgyLbvBxlh+PyKpudJnMDKmqOFjF8JEvvMu1h4OZD/6uzNv
         LG/ulX2loufdgMNBNyV6dxZzpWUnwvDD0Sl5XzpdtjSK8YNiDIrDt/EjzUeo/GoTmWKa
         J7T6pMLKUnhQwQDWNL+nF/Syi30Jphc0AkDb/cDSshyeEH2Ord2adghhEoIux5kXm4h2
         iwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724609155; x=1725213955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raI+n19QFN29zfHeug6+Nnj8oFJHmaYrdY3f2jmORFs=;
        b=eaJlydXINv6EuTi5hnWODNKXWz4IVe3eYF5yLtJE3mwr5LyDWicw4lg6DuAlE9oPhx
         fB6A2zJiSPf4IYwzWHNZYi2bOW8aEsMGkLPvN7xpAU4CacGq2gQ3R7QrZv3zjOH33Wl2
         yFcIXYT9Yu8460/Ab78L/sxvHtk5VFtQKiUfQyjc2b9ZAxTYk6QqHTV2XQkrJplcKoy4
         /M59TeINfjQKYchevZIR85g7cTBnXMMVHYiS9+VBxJwB39XQRnP5XVCoPS3umS5pvDvp
         00jpWnFBe9vMmkohg5euhHpx3R1a55SYAl6pJzz3PYiS273lMQvpnZazPJT+OvScYHcR
         7a0A==
X-Forwarded-Encrypted: i=1; AJvYcCViyQyU1faCRLvq6bWS+dwcmAU1j4kxPDd3OLDW3euPYljindTDKoX9IB6Cp5jHT4nHDJ5ESVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfnYtfYRHuwFsjQO2NktZLS0yVvYtF6HpOmXnu64wS+LcntqDf
	stU/dHTdzC4RdxhJKrBqA5BXLwDjF6ogpXPpa/Pyw+AAcf8JyPSZ5C6/uvFOIvk=
X-Google-Smtp-Source: AGHT+IHovd9hBkcFA5+INtvXNRkDasxTeWwT194C24emqMwQsIKUln2/CHtoq+dBH9VjU22j1a5wgA==
X-Received: by 2002:a05:6000:18a4:b0:367:811f:814c with SMTP id ffacd0b85a97d-37311852228mr2891104f8f.4.1724609154471;
        Sun, 25 Aug 2024 11:05:54 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37311dca113sm6438736f8f.16.2024.08.25.11.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 11:05:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 25 Aug 2024 20:05:24 +0200
Subject: [PATCH 3/4] soc: versatile: realview: fix soc_dev leak during
 device remove
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240825-soc-dev-fixes-v1-3-ff4b35abed83@linaro.org>
References: <20240825-soc-dev-fixes-v1-0-ff4b35abed83@linaro.org>
In-Reply-To: <20240825-soc-dev-fixes-v1-0-ff4b35abed83@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1464;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=djfTpzgwI9VayrirIxvL2d17DNLj3Y9kYYllCM4F/9I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmy3J5hVAjigtLPRzXJclE2hY3l9wqGiPuN90+6
 VH3b32MKzKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZstyeQAKCRDBN2bmhouD
 1z6YD/4gu3mtH9IEh3ZQSvcoj0sIV5F5wo+z0K9BmcsSZ8OvhLEiUikWAeTcuLAhbgrn5gzoTq6
 UNEzpe0Yo0SWsrpyYm5izi/pKTuvMt+RZtGft0HXS+P8EP0L1A4kFAQ4OJcyUPiN9wqkMqsCYKH
 LdyWHVivtTiQc/iirLNAAqEi6hlPgzGfxveGpcqqGnN+Wb6jk1OMB14UTc19pUbRO//gV8zlRaB
 9HUtRYAB9LySEgj/dgH+Iip/I3nUyn8wW15yC9ZWFBl+KnENa1k/5jHLRqslK5TdSxHeLZmrrzW
 Zw/fgTZUKKt3Uq1hwZGbpqIT1RHsojTQ1uYH72sJXC+v62+B/1kaUrNrO7Ckhi6KCtSvY/u7QfL
 6cn8UtXArp0XU/uHpfKCsFov/Gm6pKy5vQOT3KrOcY/K+LtrKxjbT6SQf8J4oYBSRuTJNIKfw4k
 v3XkaOxOhKZd0auFGwodSa6Dm/GCoV3Tr6Yx7+mqEiHduB3dTeJ30fsHjWllbBI1gdFEs/Fu6cj
 enC33MxBkGrsuD298hQViVZbeMOnK5huRM/M62eW3PuYAs+cE+MAZcztvReOZ7WWhsYST95kg4k
 O2Bk0sCgt26/4NpMbpPjYsc4KN6d8lm8NOhbMOxYoEvJF1q4RhmPsfAQ9qsSpH6YI3zEwBsXKHO
 6FLUwK897TPmYQA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

If device is unbound, the soc_dev should be unregistered to prevent
memory leak.

Fixes: a2974c9c1f83 ("soc: add driver for the ARM RealView")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/versatile/soc-realview.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/soc/versatile/soc-realview.c b/drivers/soc/versatile/soc-realview.c
index d304ee69287a..cf91abe07d38 100644
--- a/drivers/soc/versatile/soc-realview.c
+++ b/drivers/soc/versatile/soc-realview.c
@@ -4,6 +4,7 @@
  *
  * Author: Linus Walleij <linus.walleij@linaro.org>
  */
+#include <linux/device.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -81,6 +82,13 @@ static struct attribute *realview_attrs[] = {
 
 ATTRIBUTE_GROUPS(realview);
 
+static void realview_soc_socdev_release(void *data)
+{
+	struct soc_device *soc_dev = data;
+
+	soc_device_unregister(soc_dev);
+}
+
 static int realview_soc_probe(struct platform_device *pdev)
 {
 	struct regmap *syscon_regmap;
@@ -109,6 +117,11 @@ static int realview_soc_probe(struct platform_device *pdev)
 	if (IS_ERR(soc_dev))
 		return -ENODEV;
 
+	ret = devm_add_action_or_reset(&pdev->dev, realview_soc_socdev_release,
+				       soc_dev);
+	if (ret)
+		return ret;
+
 	ret = regmap_read(syscon_regmap, REALVIEW_SYS_ID_OFFSET,
 			  &realview_coreid);
 	if (ret)

-- 
2.43.0


