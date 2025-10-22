Return-Path: <stable+bounces-188909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 049F1BFA5A5
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 08:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4C574FBEC8
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 06:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D602F28F5;
	Wed, 22 Oct 2025 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IZF57K8e"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D4B224AF0
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116069; cv=none; b=qfLOUV2uR/aYNocQINRvlZERS/xpnKezDoE2+EOjmxM0hifat49l+K/vL500PPWjKnqP/MPWUp2BBR5lavmiTXA9SVQ0T2z5Yuap9u1m+AhuABWX2rlTX42oyBBMbMMdcYnV0Mpm6Q1nOc/0yhI8C3KIx0swQR1Ae3fTKINFFvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116069; c=relaxed/simple;
	bh=Ah8PG5J743WoNYOxpQyKjv3h/CacudCbl+vpW6XErgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlwiJNjEYbwvzoS1YWinNB/R53l0WM1j/FbSZk9QatQz4wjc7fou5SDvqbcqzDFG5iTb+ENWXlL4vwHtaNR05Sxy9o+/kgvf1F2UZCWBFtU305QjxiIWCCKYn4HDr1ENG/LS47wJQt7eTw5188thDTPQ/9iGSLdyu8RopOaVGrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IZF57K8e; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42421b1514fso4009233f8f.2
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761116065; x=1761720865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8ofwNtGiAL6AxuIGzZrtcIojpwaY7cB/ELuMg3Y+QA=;
        b=IZF57K8e+O2XP5uL26g4JPmSF3KlLdoXslJqCK8yUEqUKWEsVUpEGsii0PF15UZmaL
         BIlI2rekhTmn+xei4QE5xAvVmy+0y8zXMfUVYTft9qXHUzckUT2GBqr5cjApOCtLSfY5
         cjukzVtr6d6Pv3bHq7xhjGjIGWq41khjaFiNz9iULjS82ITDoGbJEc8NohSA7s+2STM5
         R6GdetKj7j8+qsxSQje/Q5vAeBm+EHu3TVCW3nI4DlhnmMNWoUkJrhUJCVOUqBdYKZR1
         trOlcOJbDUOAIZh6EED2/9Hyu1Mj54YMbEYOF03MljNlAd6Uas1/3sqrKnhKCCF8boP7
         tZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761116065; x=1761720865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8ofwNtGiAL6AxuIGzZrtcIojpwaY7cB/ELuMg3Y+QA=;
        b=tXeYSplZk4PpXn90lfOTdzYKUDXinGXFofIGeSvNPcAcNMjlLXBYzoQJFDtTdElbMH
         wrhp1K8sqZyk26oEonxDIlbnkejAhFtzljt0P7ktwe0tdRNQE8Mc+97g5PMDWZtxDvkD
         LklyVD+0iL8buwoeYdBJwBqB54rclpHHJticro6ThfZccz4M4LQxNqWvWBElUattvIdm
         rUJRrvRpifi975gh80/QaWv0urdxmE4GEY5ACW4fesKV6ajMwNhvPqvW9Ta94p2P6BGc
         jVqfVYpB2MUKl19djDoCMzYeNT2N+tAgqc9qq2H8cSR0k9oDwiYCQi/j+z0fewcJ/Qvw
         86PA==
X-Forwarded-Encrypted: i=1; AJvYcCXCTj1b4y6Xz2DAVOu97Qi/jSdbioZKOj4gWtBUCeiB543qiRoKmhmdYDeJagHfd+x8z91X1zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0VqEXxRCKJ3a+7dlZpA0QEni9plcApvPzoKOE5fZMJCqTRqr
	vuEe4V3HGpCySxB0MtXkT+QfnoPfxC6Vvm3KCX3tWPvK1h+g7C8JfGLwgv0/4dJTnOo=
X-Gm-Gg: ASbGncvDdajg9pvQ2rWd0z3IvLfRdSg7+0DYWflRry5ONoZN4U/XtfzXTxEvdnyGd9Q
	p3ESnJ16aYFKBFxcZvtjFdzyDef1ePjVohcCqioBPok0Ck6XlXz92C/2tG5zWNO1kle4NfUuznC
	eBpWmodr/8CneS3sDVZDfZ1auLW0441kcvh5UMgyC63alI9YAE5pzLOUrTguVxLWGZgE9dan7Pq
	iymogGSZioShj6r/6u//8fYr0tKRxfojjQB8Rg5ZNhGGJiLwOmadOL2hRORAproIF8k7m8l2e24
	9rs04+zE9QGyPWszcUB9aJXgTfLSy7MmYTDibhIa/Xq5jS/NwS/nm8lnq/hatI7I96Kl/EWVUtB
	v8wj+cwULweDksJREh3JggSs13LcvMB9uCoQIKJSjoqGhRz7c0jWaZo9LOMZRXiy0ZNbNg27OtO
	o1sw==
X-Google-Smtp-Source: AGHT+IGeS49WdlsfP1XvLx4YQzh+izqkykPAWb+jEk7om9xBT2YfRwHS9OSz8bm5e5uOfp01dJD2TQ==
X-Received: by 2002:a05:6000:2881:b0:428:3fa7:77ed with SMTP id ffacd0b85a97d-4283fa778b8mr8595836f8f.46.1761116064486;
        Tue, 21 Oct 2025 23:54:24 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:69df:73af:f16a:eada])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9f9dsm23722959f8f.39.2025.10.21.23.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:54:23 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Michael Walle <mwalle@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Cave-Ayland <mark.caveayland@nutanix.com>,
	stable@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/3] gpio: idio-16: Fix regmap initialization errors
Date: Wed, 22 Oct 2025 08:54:22 +0200
Message-ID: <176111605268.7660.15686618336635662485.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251020-fix-gpio-idio-16-regmap-v2-0-ebeb50e93c33@kernel.org>
References: <20251020-fix-gpio-idio-16-regmap-v2-0-ebeb50e93c33@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 20 Oct 2025 17:51:43 +0900, William Breathitt Gray wrote:
> The migration of IDIO-16 GPIO drivers to the regmap API resulted in some
> regressions to the gpio-104-idio-16, gpio-pci-idio-16, and gpio-idio-16
> modules. Specifically, the 104-idio-16 and pci-idio-16 GPIO drivers
> utilize regmap caching and thus must set max_register for their
> regmap_config, while gpio-idio-16 requires fixed_direction_output to
> represent the fixed direction of the IDIO-16 GPIO lines. Fixes for these
> regressions are provided by this series.
> 
> [...]

Applied, thanks!

[3/3] gpio: idio-16: Define fixed direction of the GPIO lines
      https://git.kernel.org/brgl/linux/c/2ba5772e530f73eb847fb96ce6c4017894869552

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

