Return-Path: <stable+bounces-160156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E413AF8C11
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 10:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F373BAE1A
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 08:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4B12BE7A5;
	Fri,  4 Jul 2025 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nznebFvT"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC732BD03C
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751617635; cv=none; b=mFF5TELTgvy+o/LX4951fJykF5rU6Qlwlzp9YRt6ZKI2632lN+7n1jqVPRocekc/o+fmZiDF9K5YXoY3xXRZS8tLpv4+DvMnMV6seeFwxeYxpKnl1aMLVtZNlLO5xXVcRpuCnBy1OMWBEM1lwEKgQdWXcUUVpy65mZzZ8RhFrVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751617635; c=relaxed/simple;
	bh=KyQG4/PtXk1I0N8JEou8JyB93SVP5PTQ2ACI4AMtZdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzYBpwCw2Kad47fMNq7Y7YyDMbjWzEe1CD4OOtGBY+FrAHKPvLssdyF+qrsaYdJU4qHOwDjhJ6LaKD9yQ+fFCbv9eHajNHGZjnTt+2u0xb0yHv9JfS8bHAX4rCFtWJt6tOovd1ZbEQZyRLuK0q93ZEuJmWRzJZmzgxziOaBxEk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nznebFvT; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32b49ac6431so5877561fa.1
        for <stable@vger.kernel.org>; Fri, 04 Jul 2025 01:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751617630; x=1752222430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MAVLF41QmphRvqRBx4yeoftDy/YqQapTAiNPyaFzl8=;
        b=nznebFvTA22RTOMZvHFZzsd7rNJKGAKZIFJb0n2qrjV34Xjzn2Tjtq4LMWqtwv6pfI
         BBvozIQhxce9sKDdqvPLkgI437YypMrKbYxUaPhDCGyMxyaewXZVUdcd8tbZAzqkaZKI
         C9MpDcFi3eHy2Np0yeeHIjt6tAMfMlxLWtZBX+W5Tb9oUME6YalO8Cl+2UyszUMSIiFw
         wRZZX1r9aE1yQWHR402+iA8SWD/D9AQbVL+0YKmjFPRuBFYuFcWIwQbNqQquci+gAqTX
         Vt8+sKkvotYx0QXeIr8Os86DxhRQQcIQ7q9sUkE9LOijaViykqUJQdUVoVvu9kUIGP0F
         dlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751617630; x=1752222430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MAVLF41QmphRvqRBx4yeoftDy/YqQapTAiNPyaFzl8=;
        b=M0UUDYrNUoGqO/VKVYhamuOMNiiuIJLML8wQyLljZI/+vSY9ldm4EkUwyBj0vBsebG
         PKmdxYBQpocjt40LBe9z5JKgr4QSTRs5YjbGdN/yHalriAIhVPImSZD5RM122CN+3fb2
         1v6gWTm74hcZLRr4NhKG9Rrqogv8gEPVvit7jXipC/APtUdR6Lh/8OraHJtNbc9XjVHA
         f8b+QXYoy27lhvfiVIYLiGOPLcFdioQrwwJrg0RpLX8uFpLJlFjgGmZGsNeO/ySdbvgV
         YzIoB5hmLxNbPkQe3+ZoiBo7EyPAn1KTloyHG916x7gUjYvbPZ+lntynnXLjFlRA1RQJ
         YBfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgwfl8nZfArjHv8zg3K3TjNJdArvEl6STb5wPLbyZRPIAQ/5OPf+MTd/wTFMrRcwWbcHMJHIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpA0ZrHLdrJpTxX98YxOR60yJK5a9d+Fy1i5v6sLBef/tplEEP
	ZsyeEOSP6Hr5Hy2QzeSho3Icc55Pk8Z6QKVDwuJ6cVFPsJUAAxe42hHMzzOKnipmMgd5beTEXo+
	wfopEM5VUw6l3uQ5cfvqUeYVPT+dh69lKVxiA0xKIew==
X-Gm-Gg: ASbGnctsQkyUIOoz3ytocdadxWxf0KNJH09WVtbuSjCs4j6GQD8SQ4dV3NJlLoPAhZx
	zLXRk1yR4xJNU5LxN1qbiyY2R7mRvQYf84mEDx3Erfs5G+V1CN4LZNMnDb4klbhJrA8fBewaEZf
	Yc1cu5qnw3S3R2p2MaqP2tIpyfNoo2xJsO98N5zq82W3DuzRGLnLxetagQn0t0sQXM/AJfQPgbn
	A==
X-Google-Smtp-Source: AGHT+IFs9a89t3WB+Sx+Cdpp8ljm2QeBOISKgp49Ml1f7/SqzSNJCWirzIGOCGoUWJUDcONIPDY/mAc44F8rbBRpRLE=
X-Received: by 2002:a2e:8a84:0:b0:32b:50c5:2593 with SMTP id
 38308e7fff4ca-32e5f59c739mr2995621fa.18.1751617630354; Fri, 04 Jul 2025
 01:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703191829.2952986-1-hugo@hugovil.com>
In-Reply-To: <20250703191829.2952986-1-hugo@hugovil.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 4 Jul 2025 10:26:58 +0200
X-Gm-Features: Ac12FXyuss_6x_4e0DROEyXhPHF7MGwZ75tlcuNi7uvqnc0xqRBj_OAhsSL1laQ
Message-ID: <CAMRc=MdP5BMVF0p5W9qSRZuPKBa0YCTxB-gLQWT_r0hBp+8ksA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix efficiency regression when using gpio_chip_get_multiple()
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	stable@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 9:18=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> w=
rote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> commit 74abd086d2ee ("gpiolib: sanitize the return value of
> gpio_chip::get_multiple()") altered the value returned by
> gc->get_multiple() in case it is positive (> 0), but failed to
> return for other cases (<=3D 0).
>
> This may result in the "if (gc->get)" block being executed and thus
> negates the performance gain that is normally obtained by using
> gc->get_multiple().
>
> Fix by returning the result of gc->get_multiple() if it is <=3D 0.
>
> Also move the "ret" variable to the scope where it is used, which as an
> added bonus fixes an indentation error introduced by the aforementioned
> commit.

Thanks, I queued it for fixes. I typically keep local variables at the
top of the function (just a personal readability preference) but since
this function already has scope-local variables, let's do it. What is
the indentation error you're mentioning exactly?

Bart

>
> Fixes: 74abd086d2ee ("gpiolib: sanitize the return value of gpio_chip::ge=
t_multiple()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/gpio/gpiolib.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index fdafa0df1b43..3a3eca5b4c40 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -3297,14 +3297,15 @@ static int gpiod_get_raw_value_commit(const struc=
t gpio_desc *desc)
>  static int gpio_chip_get_multiple(struct gpio_chip *gc,
>                                   unsigned long *mask, unsigned long *bit=
s)
>  {
> -       int ret;
> -
>         lockdep_assert_held(&gc->gpiodev->srcu);
>
>         if (gc->get_multiple) {
> +               int ret;
> +
>                 ret =3D gc->get_multiple(gc, mask, bits);
>                 if (ret > 0)
>                         return -EBADE;
> +               return ret;
>         }
>
>         if (gc->get) {
>
> base-commit: b4911fb0b060899e4eebca0151eb56deb86921ec
> --
> 2.39.5
>

