Return-Path: <stable+bounces-114508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87984A2EA01
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 11:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28447167FBB
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 10:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9291DE2C4;
	Mon, 10 Feb 2025 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wI3pd9px"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1361CD1FD
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184730; cv=none; b=XH8ntHbAtmCRjEAzDluTeNkUBFBRfOubeYPEE5JrKOOhe+n24Jjx9jxM7IOcX6Os/AUd7Eu1le5smOvOGP+Ox6kLw7C0xJoBgb2s4035MaK80WTUFPYrbQkcHCsce08atyKqNkxw0E/3IUxL3ESIx3YvyhQXqJpwMgjHDar0Dps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184730; c=relaxed/simple;
	bh=RfHBELWftEOI6aduadNpWSnZVyvCMZTRiybMbk/nsKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n5NqBqzqs6V1t5fyyBfg6zU5mWrVrTE01Tcu2c2JNL+XGs4uDx79hPSxFvO7ftz8Us5W4Vg9Bfp3Ox83Hu3F59tGKQOvs5uHN5u4hNizVELBXOKApdfE7k5QvqkfN0jc3KaKD7lutnRB6A8aQDV1oVlhWy/r4X1HBT16AahpcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wI3pd9px; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43934d6b155so9180955e9.1
        for <stable@vger.kernel.org>; Mon, 10 Feb 2025 02:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739184727; x=1739789527; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oe6RHeWjCutLo5iDZJ7f7rTUbrd3skJS2x0XvYoqI4M=;
        b=wI3pd9pxnebMqrq3eY4jY87tbCb9REOQW/vNTZc9FtYS1LToJxqwnhEtSxeF4C2QnR
         A+jwFiRgmUK3DQywWk//dqo+pOD1On08wVDLAwr8llvbbimo9G+9fxY4NjhdZUzChch7
         KyD2WwgS/FpZqLcAAkjAIMzVuyk9Fy3FkRPIAGKUwSVoM4gHOaHuDSEk3KalEmYEo61m
         LbmlySyey2wnVyzshKUEfFKAeQ4Q9KmUlv/sOx/gLeADFzajwLk+SsbJwvTGeJTCO0DY
         7el3Q3Uz90HBteyuNHDAaJXtAlzEqKcVJKoVcjfLTCXpikj0Xi9+yu2KJth7cRZjZESd
         FhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739184727; x=1739789527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oe6RHeWjCutLo5iDZJ7f7rTUbrd3skJS2x0XvYoqI4M=;
        b=rMHY9Te1mehnIthBCNBiRD5OsT3xMI/b+35a8mDoCSunbAQORSnEb4megOPAF7D9xR
         36T8sCc6x8QbYkLLLc7H67y+vSbSPvDKl9fjQbc+M2alRyK9jhJ3vdA6qvZEpJe1NQMo
         G0pKjR8wLuekdmfSh8tyR4uUffWwBn7hauONZ9S1pwTtw3iUxcAcC3MKJUnmzCAk3oR6
         XmvneiKCjREZt4Yy9OYp7gW4A0GyQTB/H5QZdKoOeFEI0zvTImuEO/NQGOHiqxFB3RgP
         AGHRmZlyjvmDaC8h4vVfz0l2vSiQvGrW0p6RBy5g5F2Rl1eOcuK0KuVeEUW/3XRSqhe5
         1N3g==
X-Forwarded-Encrypted: i=1; AJvYcCVj3SOBTL0OLgQg4CjG4Y6Cd+4Fin5tKgytBoM5MgGQhR1JsUGu+wset8l2f7aix8QEvFZUH0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI0ev8XnuDI9FxdRh/EB2KGBy81FM8Zirw5mjggVF6+z8Wo6ul
	GN38p7sxDyVPrnLJLkRF00E6is03DEoF0EE9ctv8g1Qiy8HR94neJXiUxibpw4w=
X-Gm-Gg: ASbGncs8aXVKpCepNZcMmla9KXBccONWt1kLL4j73mFnEYrVa0wlxtGkoKS2YXpNn6H
	wVZAw2aPOj5nnpMx6mdK+d3KQc1QXf5ZiU8GPCEY7CIDlCorYvnKWM1xSlBJWROmui6JziHsw8Q
	HNVkyfA4aVc7gHFb7+Kvd0Uu+dIeFA+CcTHVsgzaeZJ9aH1qkyHBG3jBxZApYYMmAMFUeq8uMgF
	eo51KLebTCMiVTdyXW1sRWcLGTb3Nwz3yfDbz38aOfBgh8MGAcNy0CayV+V8nzKZ0abUR9tH1Zz
	oiOr6vIy
X-Google-Smtp-Source: AGHT+IGBAZdBYR3TYPZOFingx6IDVarvNd1xtuG26gadPMUlJJHpUqSLxIS+6zs0KMce2R6DTrtQJg==
X-Received: by 2002:a05:600c:3c96:b0:436:1b86:f05 with SMTP id 5b1f17b1804b1-439255b81e1mr94425715e9.11.1739184726533;
        Mon, 10 Feb 2025 02:52:06 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:f3e9:47d0:94c6:777f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc53ae9c0sm10557919f8f.101.2025.02.10.02.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 02:52:05 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 10 Feb 2025 11:51:55 +0100
Subject: [PATCH 1/8] gpiolib: check the return value of
 gpio_chip::get_direction()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-gpio-sanitize-retvals-v1-1-12ea88506cb2@linaro.org>
References: <20250210-gpio-sanitize-retvals-v1-0-12ea88506cb2@linaro.org>
In-Reply-To: <20250210-gpio-sanitize-retvals-v1-0-12ea88506cb2@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2846;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=lpE55aITs3TR0edspV0JF4dj9P5jKU0BTQ+eUb+VBxg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnqdpSfnhhEUo6hT94zgAJgM2xjsjhsYO1vA+T0
 5EoGpZakeGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ6naUgAKCRARpy6gFHHX
 cplCEAC9jg6cqsozxgAdfJBzUaYa+ZLzYNwuow+HZhV8fZDTTaaAyTUsXwiBvRP+WiPTHDehfMA
 GTEnGaHrEsFimr6T9IHElWUzybgmTrQRTW2MIfMUjxubcxckxHyPhJw97ErCdtUhfUll0OdXY+T
 ONyN3rJdZkz24OqcN422aTAdH4hKLyMfnv/w0s6x1K/gzsXlf6NyHmDDJh80JRkBMwzEsL6YbO9
 B65JKmxa0gBdnI36HYvYDHPs9QZAMlae0WzAVFzHQRmrNj+pdk932spDIFUwyLCnZC1Ar23KCda
 nbCd0PS4/DgSK1OaEgMamD7jguHCwyF7LIzDou2alhSCWukW4KjO714XP9w7gBWN32YaIibeUyY
 BRX9blIl4eQGtj78PdDvri2lAVfEMT/4rutTNEruVsle+9EPDKf0RsqlnESe4ooJyD3qQZBgo1+
 Gt1eRnBrGe64Id35RqFhIjNgeUroDx7+kGRocsobPWoonDCs9FzDKNiNEpqJEoK5VGlQrZq4+Kf
 1ANNV39UumMhSktuLvFaYeAXjeDgn5ceL3WtGchzDRLIbkEhKuHrvn+PoKWQPGnnWcQG7uPH5xq
 j3SFVEy6JfpgAbpdwr1FHdgvOpP/3jLtNRQHVZ42v2G0mi29Z+9X5cPEDcgXYdwNsrZc1Y5hViP
 xYbtXvwIj1LkIIQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As per the API contract - gpio_chip::get_direction() may fail and return
a negative error number. However, we treat it as if it always returned 0
or 1. Check the return value of the callback and propagate the error
number up the stack.

Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 679ed764cb14..5d3774dc748b 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1057,8 +1057,11 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		desc->gdev = gdev;
 
 		if (gc->get_direction && gpiochip_line_is_valid(gc, desc_index)) {
-			assign_bit(FLAG_IS_OUT,
-				   &desc->flags, !gc->get_direction(gc, desc_index));
+			ret = gc->get_direction(gc, desc_index);
+			if (ret < 0)
+				goto err_cleanup_desc_srcu;
+
+			assign_bit(FLAG_IS_OUT, &desc->flags, !ret);
 		} else {
 			assign_bit(FLAG_IS_OUT,
 				   &desc->flags, !gc->direction_input);
@@ -2728,13 +2731,18 @@ int gpiod_direction_input_nonotify(struct gpio_desc *desc)
 	if (guard.gc->direction_input) {
 		ret = guard.gc->direction_input(guard.gc,
 						gpio_chip_hwgpio(desc));
-	} else if (guard.gc->get_direction &&
-		  (guard.gc->get_direction(guard.gc,
-					   gpio_chip_hwgpio(desc)) != 1)) {
-		gpiod_warn(desc,
-			   "%s: missing direction_input() operation and line is output\n",
-			   __func__);
-		return -EIO;
+	} else if (guard.gc->get_direction) {
+		ret = guard.gc->get_direction(guard.gc,
+					      gpio_chip_hwgpio(desc));
+		if (ret < 0)
+			return ret;
+
+		if (ret != GPIO_LINE_DIRECTION_IN) {
+			gpiod_warn(desc,
+				   "%s: missing direction_input() operation and line is output\n",
+				    __func__);
+			return -EIO;
+		}
 	}
 	if (ret == 0) {
 		clear_bit(FLAG_IS_OUT, &desc->flags);
@@ -2771,12 +2779,18 @@ static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
 						 gpio_chip_hwgpio(desc), val);
 	} else {
 		/* Check that we are in output mode if we can */
-		if (guard.gc->get_direction &&
-		    guard.gc->get_direction(guard.gc, gpio_chip_hwgpio(desc))) {
-			gpiod_warn(desc,
-				"%s: missing direction_output() operation\n",
-				__func__);
-			return -EIO;
+		if (guard.gc->get_direction) {
+			ret = guard.gc->get_direction(guard.gc,
+						      gpio_chip_hwgpio(desc));
+			if (ret < 0)
+				return ret;
+
+			if (ret != GPIO_LINE_DIRECTION_OUT) {
+				gpiod_warn(desc,
+					   "%s: missing direction_output() operation\n",
+					   __func__);
+				return -EIO;
+			}
 		}
 		/*
 		 * If we can't actively set the direction, we are some

-- 
2.45.2


