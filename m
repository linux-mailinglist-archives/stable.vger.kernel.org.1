Return-Path: <stable+bounces-181763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 149ACBA342B
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 11:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C6A384778
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 09:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545DF29E114;
	Fri, 26 Sep 2025 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sZirVNKC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B82872608
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880655; cv=none; b=c3jLAp2AGOfNQQnZ4lhrWwrcuVoNAMpFk9z+seiX+csXFysvuU/EOQs0WnRRoTMl5JdOr1B72lEN+hTfUin50tK6Uq/ncck6+D7pBs5W573/CC/kP7OYYOVjpW/olEhv4jMZCpzYFD0t2grKojGVvGh/edXZfzr7rNdwt3ZqchQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880655; c=relaxed/simple;
	bh=pSTGxTVn/zpOADQlpLLlrFQ3O7dddV8wjcyu0d9N78k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAPjBnolweEjK77pQVzHYIwzFeWyvDQroumHT6O4FRyk9fLA51Xt0y2RuoxBJVH41CzMAghMX4dGJIYb0vU5VUkNE3K9JKFjKNY0944JuH2wY0YSwRuYHg0G+qv3VbI9qfggt5btT8LZ7O/E8/GjqEdCdAJenn4Y8eEaVkwFlSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sZirVNKC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46cf7bbfda8so10808045e9.2
        for <stable@vger.kernel.org>; Fri, 26 Sep 2025 02:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758880652; x=1759485452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Kxy+zDkcHliCNrZ/JPAcR9GylbEx4LYmoR1pgjRV4E=;
        b=sZirVNKCvvIkXRb7JR1uzWw81ekdTMnS1wafQr+1S8ltTN5JC7jNwREgC1FYxnVDVK
         rEA/E4mGdz78j1uNmbyO5cX/eoLOonSeZrhHR6mYSWb+PXw2dk7oF7LoYZrNV4NlhlqQ
         dhwj00imPKAfxLJUcY4YGXnc8x9GwyxZc4CR598D5xLkLxkh6A9fnheSATvZRbDmEyt+
         4txLMwj9fBxjEaDA9+lvM8EIFDv14pxVZW5u05u8wphqJUtbTdV6rgL3BLpVbwiYru1j
         mb7ucW0iDKUeVlta8G0KYvepkjJ7emqtpYGTOiro0zlNFQIw7/khu8GaXsnTH3iiNnZM
         TFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758880652; x=1759485452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Kxy+zDkcHliCNrZ/JPAcR9GylbEx4LYmoR1pgjRV4E=;
        b=nBVjy/mZDJLlYGr+bgR7ABiK37qygg/B5+xgfFwjtl5uTqEabljHxdLwUJfeR/lfes
         M6AcHDhjRUzWMtI8mpAOgwEMajMlKf4L47kVX5EhlX5tLGRtqszNX7v1Qlu9BIohZXkI
         ZH2v9OrehyDgJU8L46cRcLJ1EW2dFPit2GNjwKn3fBKXUNUDvsx4i5EWNJ75ya/Xgq9+
         spYT4vyDTeZBNf2jxtoytrVbhVcU9qK5R86eAdmqBlnRmW+kdCMK4WWZNue6x/3nqrjG
         fbDXcmXKgQefMeZV35fLjqxmr3NAuLR8Dt9hT/+i+sDwKBIXw1Scy+zQks9NdfwARMhD
         niQA==
X-Forwarded-Encrypted: i=1; AJvYcCVDuOlXuarnYFYDV6uNUuXCv/lPOJSDX3ue6cYe1tnL2KQetrqqWQ+gymixv3yr6wadQSgbDCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQG2tK95TKTDt0aAQnQCPsiHFTkcCP0bfn1Ytb9ipELcFX8Do/
	/UHOM/68GkYKWwOnYCKPO8HABOEi8cmbBFgsnoEynldTvzBag08ctUAthxE5a2nQvrI=
X-Gm-Gg: ASbGncvj+oJrnwc7yvKG2wKTS/xQ5kXJJT/hvgxiySDisrjWtemGYNqntoq9GkV6Yfs
	TdCS1dh/7dlrJJXa76INGllGFxquQ80luicQzgKhG3QR3rB9IsKu1lGHsBOIVUcfMwx2wNI7SSP
	ZY8/5cBhR09o37usDoHiV7xYkjT46V8UfgQBQ6HH/S8w+0dHSGquvujERmha0aDh/GBk1OcEn6F
	+kzEOHQ0fKLNy6jTNFsmD2V2uCpdEo/6YSSqys4nK8l8b5GB60uXGLKMC+IzaDWLfN88H25KTBw
	hRILuCsR2W/S/O01/iNm5Uoky1JcEXrAGTzfE6sFgug/mtpuc2p16mPRvjjnnik8fh/Bcdya4p5
	J7M2pwO7fbMdb61Cjhbjk7z4=
X-Google-Smtp-Source: AGHT+IE/q7gcEasaydfPlSh1kSSOSBJAZe/1ZBQmjjrYMZ94FaitrgjVEefEJEXUDsJu0At0EET9aA==
X-Received: by 2002:a05:600c:1c92:b0:46e:3dad:31ea with SMTP id 5b1f17b1804b1-46e3dad3310mr19221425e9.17.1758880651763;
        Fri, 26 Sep 2025 02:57:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ab15:a65:aecd:6def])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e34074983sm66168915e9.10.2025.09.26.02.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 02:57:31 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	Conor Dooley <conor@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	stable@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril.Jean@microchip.com,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] gpio: mpfs: fix setting gpio direction to output
Date: Fri, 26 Sep 2025 11:57:30 +0200
Message-ID: <175888059620.38209.6546087887696517521.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250925-boogieman-carrot-82989ff75d10@spud>
References: <20250925-boogieman-carrot-82989ff75d10@spud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 25 Sep 2025 16:39:18 +0100, Conor Dooley wrote:
> mpfs_gpio_direction_output() actually sets the line to input mode.
> Use the correct register settings for output mode so that this function
> actually works as intended.
> 
> This was a copy-paste mistake made when converting to regmap during the
> driver submission process. It went unnoticed because my test for output
> mode is toggling LEDs on an Icicle kit which functions with the
> incorrect code. The internal reporter has yet to test the patch, but on
> their system the incorrect setting may be the reason for failures to
> drive the GPIO lines on the BeagleV-fire board.
> 
> [...]

I'm about to send my last PR with fixes for v6.17 and this hasn't been
in next even for a day so let me queue this for v6.18 and it will get
backported once it's upstream next week.

[1/1] gpio: mpfs: fix setting gpio direction to output
      https://git.kernel.org/brgl/linux/c/bc061143637532c08d9fc657eec93fdc2588068e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

