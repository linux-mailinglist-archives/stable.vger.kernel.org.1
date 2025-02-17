Return-Path: <stable+bounces-116541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 199E3A37E3C
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 10:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBBCC7A2062
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 09:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4099B1FDE27;
	Mon, 17 Feb 2025 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remarkable.no header.i=@remarkable.no header.b="fUkNMear"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDC11FDA9D
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783824; cv=none; b=XcA8hSuUQSMEYgXra9mxQWYI0L4jmYgP6iBqZROTjrNumXxgk4F/zAMOxgvcrZUV8+8SilqB+qhKSs2Lq1/Wd3ZLh2rHHBk3aj+47LTsCr0J+IOnrCxfUlXYIFGzx+rhvZ6wbCb6ZAFl/Im4r39Cyz7z4tBleemP/4+SN6aK77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783824; c=relaxed/simple;
	bh=w6Xek6gc0q+4P9UzPF8VfQsNZL0XbyhVwrY7dVOdb04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LIrjcrRoU0yuoVzQUVZiPZMLxjcxnlroGR7s9HvBvaLtQTmrEJlpIj8RmYyiAUw+rqO1SOc2SVNOBjg9VO9+ZsWFceg0QXR7H7CSO2Us76GC4jpvp5VoHuTuZaBCE3xxHT//rxfmxpXilBHcYEQK7S78zsFVjzYcFzeAr/15opE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=remarkable.no; spf=pass smtp.mailfrom=remarkable.no; dkim=pass (2048-bit key) header.d=remarkable.no header.i=@remarkable.no header.b=fUkNMear; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=remarkable.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remarkable.no
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5453153782aso1620435e87.2
        for <stable@vger.kernel.org>; Mon, 17 Feb 2025 01:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remarkable.no; s=google; t=1739783820; x=1740388620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xGyYdH1pDSfyQz+Thi0FH/5o/u/GeZTZnMnZcTSpLdQ=;
        b=fUkNMearvmqB84wtwjii/Ls4O9Msn3yedlN/n2O9V0GsHlCOnb79ZLXaqanBTL7oRa
         khbINwl8jUGtOj8SspsVGMWQ679g7bpZxsdigpd+vvtALF4FgDf57C6fGxOTjKpfJXON
         urk9q51EgipElZlyCfbH15Uhs760hOvWeAQcYEiZuIEBEbsvjayRTIFUwkInqkM0k2u1
         QL+uu8Y3EMsXt0CVpevMUVIZbEKAlZMSH/l/R1E7BAIlyMBrXMFJCvpjdqPJNxrpkZHY
         mAm3qHZ8fX1Zm4yAv/KYyBOCwkKujZFeWj2t+ueqvRebmZX9VTBsRMkZN+sv8amyRkui
         KyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739783820; x=1740388620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGyYdH1pDSfyQz+Thi0FH/5o/u/GeZTZnMnZcTSpLdQ=;
        b=XrfHkh2kBQlYHGPccmj5hc9cc0jj495Nv1itqTjKNzlgbyqrJUtRA9SF3aBc1wQN2y
         eSShbNz1edr5osj6pZGzoNv47T7U/GlX/4mHtKhwy+ms1kiXTO+keOKcn2hkg9Qet7cI
         Bwr2XJ7KVfhmnMTEfkZdk6+Xy6b0NJ8j5w7BlMl9uiO4Kz0HC9O0msiibYjhc/75qTEr
         edlDOAIzk9PA677IOICwg5r4jx7TJjYw6W0MV9NeCJ90w2aXcA+vHVQe/ZRccv16OHl0
         29hhrQf90UOkZ9cXtZ7jaUKvm9i2Z8la4ap2RouM9JRn6P5KLTPdJ3e+GlndzDPydg64
         je5g==
X-Forwarded-Encrypted: i=1; AJvYcCXMb7y4nwRJ3KnFqlgb2goNIxCuNhkqlcczy2kMUCiJDxTh56Imsa1HlYhQhgBlKpOHDCBX0Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YymBRJ+RwKxEpZqqKpepUa1xwJthZhkyPYIkkr1Lq5CS2CS73O6
	Yfv8juaeixRTFVBxNeui8WerK6rcR4kxFozDipLrbn+3egvBz4RM+QPgZp4Y+39fGOJnWHJlTl0
	=
X-Gm-Gg: ASbGncvjjpF3FCPZXiiPS3+EW9Q3gJ41rs88jNllJK7wHqe8gfXVw7kkFcnbiTMc1Jc
	xX1vhsKALr0BR7SL1TIeLlR/12SvvKYeFsVY2AqiQxlwkD4pBsyuxUcTzL6115jrhzbLMfSDtKq
	jd+pewZLqoZPj+DGXsoHM5zWHc33WP5eCVhc3L8h7AMOj1+WLs3ep9ydI76UmQOedvqRu25zVlu
	zeEs9GCXeg2FPr79eN3TmWgoGmA/L9/sqSMVIJxVhKKxdx+eeN8pJ/Gqm37Ig9vzd3R7JlRjH9X
	oTflVhT5hyT0oX4Tp+62BwfOGr/hmeIkxuGLG1z1LUMnZ3GO3GC/D+vy21pQvI/3T5NxVk5baeb
	pDtqIGSeyFwojJgpz5OkuqF+speUBwfL/Y+jutEyS
X-Google-Smtp-Source: AGHT+IHr5LJSgDlSbDQgsKhQvtHHkAjw3oQCRwTlQBsKrWf9bI7/1oERlhBLt0NwZu0j1L/wlFMhiQ==
X-Received: by 2002:a05:6512:3b90:b0:545:2fa9:9704 with SMTP id 2adb3069b0e04-5452fe503abmr2927294e87.19.1739783819866;
        Mon, 17 Feb 2025 01:16:59 -0800 (PST)
Received: from yocto-build-johan.c.remarkable-codex-builds.internal (64.199.88.34.bc.googleusercontent.com. [34.88.199.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545e939224esm701585e87.135.2025.02.17.01.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 01:16:59 -0800 (PST)
From: Johan Korsnes <johan.korsnes@remarkable.no>
To: linux-gpio@vger.kernel.org
Cc: Johan Korsnes <johan.korsnes@remarkable.no>,
	Linus Walleij <linus.walleij@linaro.org>,
	Haibo Chen <haibo.chen@nxp.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	stable@vger.kernel.org
Subject: [PATCH v3] gpio: vf610: add locking to gpio direction functions
Date: Mon, 17 Feb 2025 10:16:43 +0100
Message-ID: <20250217091643.679644-1-johan.korsnes@remarkable.no>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add locking to `vf610_gpio_direction_input|output()` functions. Without
this locking, a race condition exists between concurrent calls to these
functions, potentially leading to incorrect GPIO direction settings.

To verify the correctness of this fix, a `trylock` patch was applied,
where after a couple of reboots the race was confirmed. I.e., one user
had to wait before acquiring the lock. With this patch the race has not
been encountered. It's worth mentioning that any type of debugging
(printing, tracing, etc.) would "resolve"/hide the issue.

Fixes: 659d8a62311f ("gpio: vf610: add imx7ulp support")
Signed-off-by: Johan Korsnes <johan.korsnes@remarkable.no>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: stable@vger.kernel.org

---

v3
 - Use guards from cleanup.h for spinlock
 - Added linux-stable to cc
 - Added Fixes: tags

v2
 - Added description on correcctness to commit text
 - Added Reviewed-by from Walleij and Haibo
---
 drivers/gpio/gpio-vf610.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index c4f34a347cb6..c36a9dbccd4d 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -36,6 +36,7 @@ struct vf610_gpio_port {
 	struct clk *clk_port;
 	struct clk *clk_gpio;
 	int irq;
+	spinlock_t lock; /* protect gpio direction registers */
 };
 
 #define GPIO_PDOR		0x00
@@ -124,6 +125,7 @@ static int vf610_gpio_direction_input(struct gpio_chip *chip, unsigned int gpio)
 	u32 val;
 
 	if (port->sdata->have_paddr) {
+		guard(spinlock_irqsave)(&port->lock);
 		val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
 		val &= ~mask;
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
@@ -142,6 +144,7 @@ static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio
 	vf610_gpio_set(chip, gpio, value);
 
 	if (port->sdata->have_paddr) {
+		guard(spinlock_irqsave)(&port->lock);
 		val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
 		val |= mask;
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
@@ -297,6 +300,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	port->sdata = device_get_match_data(dev);
+	spin_lock_init(&port->lock);
 
 	dual_base = port->sdata->have_dual_base;
 
-- 
2.43.0


