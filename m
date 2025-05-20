Return-Path: <stable+bounces-145716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237CDABE4EA
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 22:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8AF4C4A31
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 20:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C077D25B695;
	Tue, 20 May 2025 20:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2m+Bxd5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F828C853
	for <stable@vger.kernel.org>; Tue, 20 May 2025 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747773419; cv=none; b=ZnRGE7ghCApVL9TufQxSvZyOS/Aymmhpl2KufIeJ7jkY34gL3RcfhsDFbUe529Q7A4pB9BsHEE1IwmbeO+vigNiTiKJX98UPTY8+HtJyk//3Q1ftil8FlPLsVQmd8ZIu+ms1K6/HPUiLzFlCRJlz4qJc5q4IpnGUYY22KypS7d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747773419; c=relaxed/simple;
	bh=RIcfmaKTtd4VIDlEArAOVwY3U/TuBBuX+W0FYjOr1ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrRNBX7V3rewi7hgn8B1Xqze2I+H+LgPtgy+lYHoxqecn+1ErBFKXbzw+x0er0eYR0OJJWCEXVoN+c8WWZW1kwGBjDkAB6z/z9sv11z23jZ39DMCuQOHhVWVFnKsXAsGsODAmGxnkrjpeZyMtDsGX6wRrB+Mu8gA80v3r3sXEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2m+Bxd5; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6019b564d0bso7253056a12.2
        for <stable@vger.kernel.org>; Tue, 20 May 2025 13:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747773415; x=1748378215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/XCxJQ0tjfNX3NNg49vnesXQqH+m1Ea2MKf5/DqpwA=;
        b=M2m+Bxd5S4+lqnbePBkr+0cwZpiLn9dPrw4e9RtOrPrDSKHoKbrzp4CN9cHPz+Y9H2
         /jNcvC8zGmpfShXHyD+x0IVmJAtTDRii26XkIcSFtWF1T+pohtpbmZCsI5aZb/IvljjB
         rwZk19p5iJNBovF2eVi4bkuMzPXgeUrnV82r49jMXiemCXJkqzxqO7V0FaJKlR43wFGB
         8DSPO74pDleDWCRSBK7JsmQwcwh+CwijuV9y8SOy5EQ0m0a5scW7X9UHJUbZptC/WR3k
         J72v4LmpJLl9ExyojmeEK6vrz97m6raJiRctvf+2Z1nAYxU+WSkaC0f/up863/oITfKA
         feLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747773415; x=1748378215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/XCxJQ0tjfNX3NNg49vnesXQqH+m1Ea2MKf5/DqpwA=;
        b=VZai2YpZYyrnvo2W11aJ8c+fIWi2eptP8H6AWrVc1tcOw+jMNk0zaun4PGcMSaxjII
         BijomKiFeiavxKXhQWM8b8WO7pMjsy3K8GnIWJjTpK9PY+6C6u7WtS0Ttq16QThQa8jM
         4TV5xFZcjlC741563r7uJeKis5+e2OKzJ+xZgxi1O+C9XlZMzCEjWLKliMdKRO7Qp5IN
         9g0m4qs1NGHE9Z2Y62e9NcPM0U5g7y9QyHpWbj54Fx9jD/NVWY6a8j9Yin0CqBHYQFnw
         PRtX+xdY8RGzlVSZtvgSusg4g6soE7nXh6AqcCwtTfbTy7hVH6aPMhvGDqAZ+gqRdyF5
         DNbQ==
X-Gm-Message-State: AOJu0Yz8weNtH6JbmQ0cLKZz1GV4+5IAFOmub7dfR/vKdWjQYbbu1LUk
	O/ew8lb7jU8cn75zv3o7z+XZR8xRid3S2bnmHAQjDr2AJwI+nC4Xj9ZFTKxgFK4kTG2Rng==
X-Gm-Gg: ASbGncvPDCihjGILQeDtxbQD9pA51mjsIJa1w807IOHoebrF/uDUYPdlVnM5fJBKTnZ
	ceVkojS/H6VfpmSLst4iFH+oiQg/mM4+I6kb8HNXTE8bz73HIyoGkiPB+2x+X4uIyPcziVL60dk
	KDfxV9xYCzDcl296n58prL5c4MB8uY4h5DVqvdwLuwVbIGso2ZMl4N9hU4M+QkFFjMOFFVTZlIy
	TY6rw0GtLKSlw8Jji+JSCWiLSLdWzCgyNCweK7zYo+EVzoMTcFFtd/1z+8PvFxZSNyKLT1y7mRg
	RPyDPzhqEBZnN6vq34Y2DCcnAWpo1O/Nz/PWuDsEQRHxFoS8rVA01j7jVqdVuwfsCoorXQZhalc
	1HQtHGJUAw1SnXr2daBwpSmJ5k68OLJ1vDZP9+dpZlGfAYsNlVG9LUcfB6gd/lDX7tiM=
X-Google-Smtp-Source: AGHT+IFXg9MUj2quvHRUvCl23nWx2N8xvJ0dJBKnOia793Tf7P3ycLLMCoqBs2F6LwM6njcBsCCj+g==
X-Received: by 2002:a05:6402:13d1:b0:601:9853:5471 with SMTP id 4fb4d7f45d1cf-6019862aabemr13213217a12.31.1747773415368;
        Tue, 20 May 2025 13:36:55 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6004d4f5fe5sm7686527a12.7.2025.05.20.13.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 13:36:55 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: stable@vger.kernel.org
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 6.6.y] gpio: pca953x: fix IRQ storm on system wake up
Date: Tue, 20 May 2025 22:36:37 +0200
Message-ID: <20250520203637.3133360-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025051941-gloomily-occupy-87f2@gregkh>
References: <2025051941-gloomily-occupy-87f2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

If an input changes state during wake-up and is used as an interrupt
source, the IRQ handler reads the volatile input register to clear the
interrupt mask and deassert the IRQ line. However, the IRQ handler is
triggered before access to the register is granted, causing the read
operation to fail.

As a result, the IRQ handler enters a loop, repeatedly printing the
"failed reading register" message, until `pca953x_resume()` is eventually
called, which restores the driver context and enables access to
registers.

Fix by disabling the IRQ line before entering suspend mode, and
re-enabling it after the driver context is restored in `pca953x_resume()`.

An IRQ can be disabled with disable_irq() and still wake the system as
long as the IRQ has wake enabled, so the wake-up functionality is
preserved.

Fixes: b76574300504 ("gpio: pca953x: Restore registers after suspend/resume cycle")
Cc: stable@vger.kernel.org
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250512095441.31645-1-francesco@dolcini.it
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
(cherry picked from commit 3e38f946062b4845961ab86b726651b4457b2af8)
---
 drivers/gpio/gpio-pca953x.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index b882b26ab500..7dc0ff89a7cf 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1222,6 +1222,10 @@ static int pca953x_suspend(struct device *dev)
 	struct pca953x_chip *chip = dev_get_drvdata(dev);
 
 	mutex_lock(&chip->i2c_lock);
+
+	/* Disable IRQ to prevent early triggering while regmap "cache only" is on */
+	if (chip->client->irq > 0)
+		disable_irq(chip->client->irq);
 	regcache_cache_only(chip->regmap, true);
 	mutex_unlock(&chip->i2c_lock);
 
@@ -1247,6 +1251,9 @@ static int pca953x_resume(struct device *dev)
 	}
 
 	mutex_lock(&chip->i2c_lock);
+
+	if (chip->client->irq > 0)
+		enable_irq(chip->client->irq);
 	regcache_cache_only(chip->regmap, false);
 	regcache_mark_dirty(chip->regmap);
 	ret = pca953x_regcache_sync(dev);
-- 
2.43.0


