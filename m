Return-Path: <stable+bounces-115030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DCEA321C7
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 10:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0C71610E3
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 09:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F408205E06;
	Wed, 12 Feb 2025 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Lobg896n"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3C8205AD6
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351341; cv=none; b=ZrPH2E+JEaqLiyuj5lb/SjQ+FHqdBzOa1Qwwv7ifYVeGQ5ZEQou1v3tiLIIBjN6tkJSJel89W8Ap8g+S5ZSuYLww7Ve1Pg6w45li9kQCuamQvZ6eePKhEuo0NiL680tt7U4ZNzZvzmPmTT+50t4MdntALJ8J7/QZD9KRZL5XsSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351341; c=relaxed/simple;
	bh=OvqYnpRvYG0LGpobj7IV6ZwhbVEj/AeD6iszKsbWduI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWy9IKKugnqDKWu6n33+U/Ay9Y/K8Q8NYBNoYyQk0+yQQRUuknc4JAxRmSgDsWjyhoYWDOYsnWct3aAYCljdnr1cs8GQok48nfv1yiwPM314XRIuXcXB2E47URfjjocpmHgrLdz7l6Nvhcc2ww/nkwoxhIeP9XaGpLCq78pTlGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Lobg896n; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-439585a067eso5744105e9.3
        for <stable@vger.kernel.org>; Wed, 12 Feb 2025 01:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739351337; x=1739956137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKD7ISvSvAMVM8VZFenVGXThc2qL1nsB/7rDLqi7zUI=;
        b=Lobg896ndhZPs6yXKqr/cY4V7/DEA7KP+TKLxYtHkgSFX6r/2uTz0cdPtjt8gaTqsc
         MxQJekncT4s+ZuSl29i2orX8oEVZW197VtoyPqmW6ONGYRIzggpGncki5lsRe4YYZekx
         tF2+mFj5ALB1JxVZNrJIqUch+7VTdWt6hTb3I1LuDfIg8JiwFg37fzKnBx5Bg0zovYrW
         kIhsvXnpDVt9dnG+w5gjDIH2Nujzk71OtTcslUox8/RmPkgF6BVDdyeT5LirvYv3lePs
         Ce03jxrq5pQOQd9Nkb6hPh1lS3cgDyo/wsnrFx+Noqe0rM2QPDGcV0fKmOL2rc7b58Zl
         h6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739351337; x=1739956137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKD7ISvSvAMVM8VZFenVGXThc2qL1nsB/7rDLqi7zUI=;
        b=LguWQpmhj0F7IFcFj8cGaUfvenQQe7tlTcflbQmQ4mk6WLnInr+1vBDRJ6kch3iGtd
         2/wafTks9tk9rcs8Rp8409E7gBlahgma6UcvUQRlkWHOBIZVnp7iku7F2xVfXuZx1jkP
         EizpxtADhw//Y71BgsK6KJxGpeYhwnIdwHOtfhGS01l8itc6YC6vUGv9MnxhTLC4vyUV
         22rEfyzE+mZnqJSFXVn6JJ0Us3a2IZIQM2RYV/7xMt5c3YjpSpaPB7JEtS42AArF8j0H
         A80hKVHzJc0+6paHYqBgeaqK2jRdBe+sO43S0wMhdnqD/mlf+5JmbkoRf5JgZEFDO1rz
         flnw==
X-Forwarded-Encrypted: i=1; AJvYcCVNH7W7nPNjpKkRnmmgRjubyf3uFMSYsbJxNdmR+TouB1fOW6Xs3hK/P141nEJLlqU1lU/SbOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvSUqcSId0U1td8hyVtyWn40lKa6NXrkyMgRcq/3xgLxvhhUlL
	uNWsoUdL0AQ2YlowuBbZL7l1+ioqHse1cjvTynhH8/sTGgU5A+IvyTWIfat9q0o=
X-Gm-Gg: ASbGncv8BPakhUrXd+ZjmvutJ1axS50KOLqHDTDrya9W6Q2Hzc5a8oKHx+Q2CYF+knI
	xUJamqVR4o9PP/pk7QaclUXkOMKf/cNbG5RQQ0iM5D5Epu500/zmQzmTq8DRWRsChrwpjf9MRBx
	1/dJgXi2gc37DfzYACtIJE09KGLdReJf2vXKpaoTTscAcMyKjYoE3Lw6WPy4oJM1N0TSTxmZ5o3
	B2WV7mbVwK+utcru8QSnLccksjG1vnBElwqcbcD85c47N1l+qCi41tTUUDZ3nEfCK2aF5lO5gad
	QKqsyeeo3U7ZWBs=
X-Google-Smtp-Source: AGHT+IFkWvd1ex79ASDD1erZLM9AfGHHCjVCSYDIPWJ+oZLpJ2fy77FdM8qDbkbqPp6eM3En7ZTtig==
X-Received: by 2002:a5d:64c2:0:b0:38d:d666:5448 with SMTP id ffacd0b85a97d-38dea2d363dmr1957104f8f.40.1739351337520;
        Wed, 12 Feb 2025 01:08:57 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:521c:13af:4882:344c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a078689sm13220325e9.37.2025.02.12.01.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 01:08:57 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: mario.limonciello@amd.com,
	westeri@kernel.org,
	andriy.shevchenko@linux.intel.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	Mario Limonciello <superm1@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org,
	Delgan <delgan.py@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add a quirk for Acer Nitro ANV14
Date: Wed, 12 Feb 2025 10:08:55 +0100
Message-ID: <173935133349.8493.1997870240852943455.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250211203222.761206-1-superm1@kernel.org>
References: <20250211203222.761206-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 11 Feb 2025 14:32:01 -0600, Mario Limonciello wrote:
> Spurious immediate wake up events are reported on Acer Nitro ANV14. GPIO 11 is
> specified as an edge triggered input and also a wake source but this pin is
> supposed to be an output pin for an LED, so it's effectively floating.
> 
> Block the interrupt from getting set up for this GPIO on this device.
> 
> 
> [...]

Applied, thanks!

[1/1] gpiolib: acpi: Add a quirk for Acer Nitro ANV14
      commit: 8743d66979e494c5378563e6b5a32e913380abd8

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

