Return-Path: <stable+bounces-186258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2106BE7291
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 10:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DEC71AA0432
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 08:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C86228688C;
	Fri, 17 Oct 2025 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Kw8bQLFb"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0E7283C89
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689632; cv=none; b=YzcLfi3GgVGMJMtyGsRpqlTM8fd4cq5Sw0rAzuQs/bKplwXWQvzwCoRnGMQYVyEyecIZ6QQaW0nkdTxd/rNTqZ1uw6CxD4em4L+wPEADxcYubMl3tdPyj52al65BZKCmlZFcgX2r17ca+s/WpgUHNVQVKnUX+Oxcu8+JYuFIDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689632; c=relaxed/simple;
	bh=p0fkPR07R3AjfCc+3PqgoNjeMw3Dpbanig7t2u2fafM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYmUuJ3huftuQOivYXzwBDc1wWj8e8yy8/GfYlyHNKoo6+ISqVRiHY9ejQ54121V/PKrgsHrjrrJY9jHZQwbKbIIhXyD1yFlcdVnhidpnViIneGHu9uF6Untfra+soQW64V8eOLA7cY+FerpHFGeoMYO9VeanQq3/VgCfpifP40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Kw8bQLFb; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57ea78e0618so2015560e87.0
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 01:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760689628; x=1761294428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15+cvikOEb/N+bxSV8FiJMWqJU144Pr8Ahk8t+ghMq4=;
        b=Kw8bQLFbwdI6GT9TTZC3waIBDVhOGFYg8ApAv+uObPhivdrN6hgAbKy8nhNwBDlXVV
         65VbCWJKYWxxpBRbqVMIJBSgZs+VOtB/hCf9u+rDKqUFCJgzO0zIXDTNYZOW1rQFgTAD
         dGzDZyLqTa7GwNh6FYgSzumFUtdfULSVljFARuApDrxOiGcW5VoAzouLQpi/WIn4ADp2
         o36uqtDJbuPg5q9oVFMeSsEZ9UU7PuGiGv2LuZDeCziVM7Q1731RtEfV2XeH+ZoZDM48
         QZtzgthv0LL5S9gSJqgtalS6rF8YBzDl8DZKBRM8DVnHaEy6yseeAsErYIxQDHYQVrzz
         x2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760689628; x=1761294428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15+cvikOEb/N+bxSV8FiJMWqJU144Pr8Ahk8t+ghMq4=;
        b=Y/DcZ8Lin2VvfOCkTonqLmiYKSuIEplTaGyJBr2PyZYqmh9XZRfkBzl+DSCX4edsyO
         aX6USmHUBYmUhbdCVj6WKyWlXcWq0HSST/Ts9PzQwTHsGQFm3PHoKp5u2pLDHHvitduk
         bFZKVyfZwE4O55u8oEGzMO8z+tPPmrIV8YRDzme9eRrky/5qz6+ouJa85LVQDylH4G+l
         MLcwaiE75iaqF/K93aYXmBdXt4+eDm9z94puV0meslqGaiTAdG9P6/MhzDB+OI5dGQ7T
         y4EGs09JLfxp/JyNY4ZX0ekGrKDUIfbeFWIKBFVbWUUtzAxowxKNrePh7CqJ4Gioqs9F
         IDEw==
X-Forwarded-Encrypted: i=1; AJvYcCVtgzr3p0k6xqXDCPJChyNQQRKV7OJfIXCzsam+FDBwcP9AmeN+gcA0ucet/Pd36fPH0Tpr204=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4D1Jd+0G67AnJYC4LXuQ7qsG+u1uC6KLV33mqmzLcZKoaGTEl
	N2MVdDtNBguoKQ7dJ6iw59MvxIFqeRA2auvkDzG05vlv6zLtFzxFNyN8b8f1HF84grb8xA0RP3/
	GBFq1W1lT32cjWxf6MG3RQqZO5MDU6kH17xdE+xkYWA==
X-Gm-Gg: ASbGncuBGsBFi3SBlCjMyiPacHRe63yssTC3OUFyDqqMUCrFZOQSYcmp9dFCm6oS93k
	gXScPf3QxJF+TgYYvroAUcAYn9VQimUiuyLc6AqqSekXt71w383PfhM7rP0eB87gzdPsumXjRLj
	GRLEIciXAPsuoSlv+GWhWmsw0Ju+RoVbNnkfq0aO5iPIv+MoXkdfRpNJ0MGchHLRA0lfgwvewp0
	jnCT08nSredeGSWojwTWtp/C2CmZMzK/mf3zadledoo7W0jOexAce+Ntx3xJljBVfNBk1UjLklY
	6zyi3qav6Wz3/d4lEwJjR116+KJkNnTYAxML2Q==
X-Google-Smtp-Source: AGHT+IFwBncw2Alu/QrgMDtxyBQtfNfh1dxGwzHw2WYd6BMmIRW7GTYerndPtj3BFzplWGL9rnd33K0LzXn6GGDseB0=
X-Received: by 2002:a05:6512:131f:b0:58b:151:bc0f with SMTP id
 2adb3069b0e04-591d85aa254mr1018570e87.54.1760689628553; Fri, 17 Oct 2025
 01:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017-fix-gpio-idio-16-regmap-v1-0-a7c71080f740@kernel.org>
In-Reply-To: <20251017-fix-gpio-idio-16-regmap-v1-0-a7c71080f740@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 17 Oct 2025 10:26:55 +0200
X-Gm-Features: AS18NWAvJs_3O-y2cqSEZ1ia1pDDJUTRQDnpYtzwKwzQdQqAvSOQieJIv9e3Y7M
Message-ID: <CAMRc=Md0iMkYtLZseccidLvhacsRRM4CXhL48Y1O2Ri-ZTeK9g@mail.gmail.com>
Subject: Re: [PATCH 0/3] gpio: idio-16: Fix regmap initialization errors
To: William Breathitt Gray <wbg@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Michael Walle <mwalle@kernel.org>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 2:58=E2=80=AFAM William Breathitt Gray <wbg@kernel.=
org> wrote:
>
> The migration of IDIO-16 GPIO drivers to the regmap API resulted in some
> regressions to the gpio-104-idio-16, gpio-pci-idio-16, and gpio-idio-16
> modules. Specifically, the 104-idio-16 and pci-idio-16 GPIO drivers
> utilize regmap caching and thus must set max_register for their
> regmap_config, while gpio-idio-16 requires fixed_direction_output to
> represent the fixed direction of the IDIO-16 GPIO lines. Fixes for these
> regressions are provided by this series.
>
> Link: https://lore.kernel.org/r/cover.1680618405.git.william.gray@linaro.=
org
> Link: https://lore.kernel.org/r/9b0375fd-235f-4ee1-a7fa-daca296ef6bf@nuta=
nix.com
> Signed-off-by: William Breathitt Gray <wbg@kernel.org>
> ---
> William Breathitt Gray (3):
>       gpio: 104-idio-16: Define maximum valid register address offset
>       gpio: pci-idio-16: Define maximum valid register address offset
>       gpio: idio-16: Define fixed direction of the GPIO lines
>
>  drivers/gpio/gpio-104-idio-16.c | 1 +
>  drivers/gpio/gpio-idio-16.c     | 5 +++++
>  drivers/gpio/gpio-pci-idio-16.c | 1 +
>  3 files changed, 7 insertions(+)
> ---
> base-commit: eba11116f39533d2e38cc5898014f2c95f32d23a
> change-id: 20251017-fix-gpio-idio-16-regmap-1282cdc56a19
>
> Best regards,
> --
> William Breathitt Gray <wbg@kernel.org>
>
>

Please use get_maintainer.pl or b4 --auto-to-cc. This is the address
I'm using for reviews.

Bartosz

