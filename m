Return-Path: <stable+bounces-190053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 185E6C0F9DE
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02BBA4E30A7
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8D431283D;
	Mon, 27 Oct 2025 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWcABCHw"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1989F2C11C2
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585880; cv=none; b=snPSSPp9V7YPaFuMz4a+3HQoT/WptOta5up8jRRIoqKU3/X5OG/m5m4WAoq+BkDuLfhaRDRGZfxwMKUhmCJjUD8E/Y++VcTPSdsABMIMJgAZT12P2n7hRZTHHfegXNlgcUaOlV9sU3D0AM9DcvnwNgTpQT9q7zAVUdKx28/FY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585880; c=relaxed/simple;
	bh=H+UsMyZ1D2M84IvFYt42sGLim/Wl8oj+lV+wL+yA5Wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNYUL0CDB6BV6XNg5MPD7SC/32LDIJCTq3DZISmt+Xzc0cz3Asm66o2ToYGX8/ww0adalFaoq5GvJeAev42IbUfCbIl+Ztz1Vrtj+jHVtM4x8xRI5nBXGuVOVRQObqi9x9qUMy5RxCV0uzrrdGNsYnMcFSqIfL3pw5NnIfhwjgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mWcABCHw; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-591c9934e0cso7139651e87.0
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761585877; x=1762190677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDcoxJRAlkXWqHdk/zGinMH8+PB5csG7SmxeUNdw1uo=;
        b=mWcABCHwriK+jyHnvx7AmQUpBlTGBi+QYXJfByagmDAat7AQIqnMSANzF+Qj7N07CC
         OBH6DB3IbMDdpY68UzpnQNt1Mau7Bjw2R6/y71Wb3QzRnpDjM3ZRAc8ROeeiX+24GLob
         OXXX0iyFY0wJU81ju8fTvEhWePlxSOsD7o3BYr2McMzZ/1RJmQVFW1P7U32P3DW1TA5k
         xn3aKVZ6BM1Xn6KecCINFTlP6zUgVgdg520V5D5f79lfHzUZBFkY02dHsXMgCMR9wxaT
         /6AzdCUYmXn/moQrhmxZxq5WX6X6IftcaoE3h3zLvG1VZg/iYvH57hB2HRYzXxemfipL
         ko4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761585877; x=1762190677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDcoxJRAlkXWqHdk/zGinMH8+PB5csG7SmxeUNdw1uo=;
        b=FFSqYIcCnuRpCfOpCFVm5Y1oXLEmly+78836jNJbKgU2V5MBjNfRM/sVtmi0A4iVgh
         VtfgodfHps8iBcjuVxOSFLeUbCSSz8sTMM3wdKH1m39AhuCZVa1tULhG5hE53vzgkZnw
         aS0y6wp+bzfxVU5hIlreqLJ1UKK88tFtk2t3ANwfNoCX0wVG/s523EFvRILimvObh6dK
         VNC5r5q7Wta4giBHS1arkd9nw4MFkZ5B1AjR4dB36hLzydi38ZdsR6papmVLIvEpscch
         vSU6AV5XGhKmpy3V6Zf2d7G4Qnv39LekF84l17NxWN9U2LyY5dAhLx+c1/i5+9gMX2UQ
         gtag==
X-Forwarded-Encrypted: i=1; AJvYcCXI8571VBF1k9gQjPYmSiVOuGIANAsYT7Cxkz0BlLPwmix3iP0p4IcctniLLUwax2sVQtb+r40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIUgR53Y+Jb8RHFuIvJwGHBYYvlbXPQWZLlRgoFTCXk+16UX5C
	1OEH14YAF9aU6XX2innpqFf47GSojGyz631pJ0PEOuTVZEGv5zQycFxA1nz9clmWUqnwwgHe3k5
	QBiVDLgQC4jerBIhM8yCMFACKK/1/8MVFFtTO7zGkAg==
X-Gm-Gg: ASbGncuUm5Td7wHPiTmknIV2U2npCcEbynUdcaKi9YUvJh1K1cRIKoHSGSQXAAkDlaM
	EySp8fY6+3q0kgXwrJIcK6pz0UqqxObVda/NFlWj6/46Je2U9hLpg7LAdrBnUhApE9AnZ47yZYc
	4HOZ3OsqCxBj84+Jb9vIwT/5YOpVOf5BCTCuVr78eoF2kzcQQWXrRIpUADmnsrsaWDq3MLyPTlK
	KsmTFLlMuf2kLzshOER3PLrKFMVVxJ2b0wAgBRPMAQFW7YO/fVJTD6yCzl6oy3Aw2xBLLA=
X-Google-Smtp-Source: AGHT+IFX0e9200QyVm1MYTKHJt2ce7Ry/DwJ0Qe5QVYRIGSLkt+EL5l5w1SYOJQiqzaagm1IvJXnEkSjT3lx5zSSU0E=
X-Received: by 2002:a05:651c:4393:10b0:378:d690:5d85 with SMTP id
 38308e7fff4ca-3790773f5f0mr1179011fa.40.1761585877172; Mon, 27 Oct 2025
 10:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-fix-bmc150-v1-1-ccdc968e8c37@linaro.org> <aP9dqnGb_tdWdr7y@smile.fi.intel.com>
In-Reply-To: <aP9dqnGb_tdWdr7y@smile.fi.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 18:24:25 +0100
X-Gm-Features: AWmQ_bka7Pw47NNaWKJfaR9a-GIXaKqJFr5gK3KIFi8TtV2j92v-PHbEnL_5aII
Message-ID: <CACRpkdb9GYL3dQzn28Q5E_-keJdLLA+TiXxTuNf1aaevKqHJYA@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: bmc150: Fix irq assumption regression
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Stephan Gerhold <stephan@gerhold.net>, linux-iio@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 12:55=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Mon, Oct 27, 2025 at 11:18:17AM +0100, Linus Walleij wrote:

> Hmm... Isn't this already being discussed somewhere? I have some d=C3=A9j=
=C3=A0-vu.

I brought it up on the PostmarkeOS IRC, otherwise I don't
know.

> > +     /* We do not always have an IRQ */
> > +     if (!data->has_irq)
>
> Wouldn't check for 0 be enough?
>
>         if (!data->irq)

But this driver does not store the IRQ number in the
instance struct because it isn't used outside of the probe()
function.

The information that needs to be stored is bool so that's
why I stored a bool.

Yours,
Linus Walleij

