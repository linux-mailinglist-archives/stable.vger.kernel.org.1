Return-Path: <stable+bounces-144592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5EAAB9A55
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 12:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576011BC18D4
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 10:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FD022FF35;
	Fri, 16 May 2025 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sGl/Y0g3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45891233128
	for <stable@vger.kernel.org>; Fri, 16 May 2025 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747392033; cv=none; b=K+pMUJrp3G3QRILnuwUkGjg/5jdoNq9IN2OnrDgEvZv5mTVsZu9yIlkB3h26cNSH2btIRvxcEGG8zB0DHek9IQ0Q5OSE8egOBZCqv0CXx7bnMNZUf2LfNhrxrPMn46cCHQA/pkyNtE8DkjUUjV3YboQOXuCN/hYn7yqAJBF2JhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747392033; c=relaxed/simple;
	bh=fAilwiO7dEF17O9fXmgvqXjSp0ceiL5RFE6YjkH+XWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=exmvDJRvAzsBMTIWH6qM9FXgVAsxJN4WBAfbjBHYJY0qVIM6TFSmi/WfrhDm7ptwVPQ71iE/IpmYe+QzHcQmLkoz1VIV0e+ZMZ2fN1QD5ofnVczl9DLF8Pk0TIIAsYEKc/e01d6m5n+y7vSXQqHjRa8mWcC+hnDK5wQxZaHgwLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sGl/Y0g3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-441d1ed82dbso19061455e9.0
        for <stable@vger.kernel.org>; Fri, 16 May 2025 03:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1747392029; x=1747996829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9/D6lYZls2BWjWpZt2g/sTx/5BxVlF4dtuEMmn0jBB0=;
        b=sGl/Y0g3SBdzgomtqh7aAIhIM9+2524vqHynVRriIf0dYgjq/bqsQyuPrc9y/Jn0A5
         PNOIiweLwX588EVl26TrVCGxcim47UqtICay3p7BcMvZmNfqSLCeU8EQI4leqdt01q2V
         xs7cHNb26jpnWTEbZaXXNaST4hlX9cQ6GPgpPZ1WUSItxllS4h1k90H8mBsqnYXKB5qG
         TnjVt2zoslckNDnj9XPd4a/RUbZzow0Yz9ICfvoqlfB7cIT1Y8rWluI0eoBslKDYrKZL
         gg40PMI+njZQ95jQcDepjpA2AgveCzBN8VTDZf90iQsnlgB12ZVYSFeOqatpfnUj7Eji
         pCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747392029; x=1747996829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/D6lYZls2BWjWpZt2g/sTx/5BxVlF4dtuEMmn0jBB0=;
        b=sWJb5VkVTAETXFKI3XsYPVx0yJCLwgTOUQPQTaFjbrEXh+zK15Db3dEQtFxUSuVDnQ
         K+IDkb8cc4eo5tVtIOqQrp73XxhZW9nla7ynhZFHk34oBQQxsPAXffP+DzIIe/viDyJ3
         fzFbtY572kQhp2Uxrfo6744wRWjpdvjamGD179RJmYZwHJPDcY+jSHPd1wsFnB8KxTVJ
         ySObTwJyy5Cdccr8v/oHDWMrBOZLQJJQSzMnvxvbMiS9498oi2qnVoD6uji9tONC36Ao
         kr1a//jMnhwNMYjpaVQZSp2L8Hp++cV4jHBT9lhwOK7UN1X9WPVqCVjcx/3+WTU/lGty
         QHUQ==
X-Forwarded-Encrypted: i=1; AJvYcCULQCVGW3Ohy/y8j3vAM27t91yIsh99JYFbJ/rjNA41All3rOmrRjp3AAtLnkwGYMmLky6DUys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7+DSYrqQ/vs4cUTA4meeVDHo8vOLIomv2sYBKNsLh1NECZgh/
	aRcfViZNW67oBPRURCeNc+oX4t3u8P/CnQ58bBNE1NdwZYToG/9err4xpZng2rxzevbPRnV+WJs
	1mFBI
X-Gm-Gg: ASbGncsNPZxceqZbCqoAcIT20kq4o8yNcAnXgvCf9dNGUB6KCwd4de7Io2Zuznz3diw
	F/ZTyXNcDReFlIjs6FkPJLdWksGFebi8AcLOZeL/ogH9BI+DL5W7k2j16PEGAoZVWZrOdBFMoGY
	YRe0pTHBWzGcjS6ejnfQWBTZwXspN/PiTssgiwC8nCAippunAp6bof+rlaWC/dSZE77LOcyuAJp
	XceNyiklOd3VDWx5WWEJ4brYBg8swfYHkLsVmfWu3KWI6RhBjyMSLycVvYdhVuPwE5jHm+eE3kW
	hPvPzJ0Gc0ZYmi4geD+rq3Kk6QuN6yTe/bkmvEiiNxEOBR14Wfk11LiLGIwUfpo4O8iKxAm6TL4
	OwvlNhBXb4qVWJrswz+lLKRVQ
X-Google-Smtp-Source: AGHT+IEkveirfZoVjmBNTeL1wlQxfdi/+yuj3FFTnYkHDey8ix0A99YrVgeOzmWXo2/MPNYmRSeKCg==
X-Received: by 2002:a05:600c:4ec6:b0:442:e147:bea6 with SMTP id 5b1f17b1804b1-442fd950bd4mr25855615e9.11.1747392029382;
        Fri, 16 May 2025 03:40:29 -0700 (PDT)
Received: from brgl-uxlite.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3369293sm104607025e9.6.2025.05.16.03.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 03:40:28 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Johan Hovold <johan@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] gpio: sysfs: add missing mutex_destroy()
Date: Fri, 16 May 2025 12:40:23 +0200
Message-ID: <20250516104023.20561-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We initialize the data->mutex in gpiod_export() but lack the
corresponding mutex_destroy() in gpiod_unexport() causing a resource
leak with mutex debugging enabled. Add the call right before kfreeing
the GPIO data.

Fixes: 6ffcb7971486 ("gpio: sysfs: use per-gpio locking")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 4a3aa09dad9d..cd3381a4bc93 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -713,6 +713,7 @@ void gpiod_unexport(struct gpio_desc *desc)
 	}
 
 	put_device(dev);
+	mutex_destroy(&data->mutex);
 	kfree(data);
 }
 EXPORT_SYMBOL_GPL(gpiod_unexport);
-- 
2.45.2


