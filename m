Return-Path: <stable+bounces-116390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2336BA35A1A
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 10:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9192B3ACA33
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 09:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99A6230996;
	Fri, 14 Feb 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p1FEnFa0"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A0D151983
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524876; cv=none; b=o0dXd7uel199+Nj7AuocwF4NC9P6uljwZoUMLGA7h/h6ZVOllEZ24SgnOQvtSYS9UWsUQodPkTUdsoKdQQSZv3L0T7sz+gE+t/J2j4EEgONJANQ3qhOry/GZ38xZmWtLrhQAHX/zwWNdffTrcY0ZdKK+yK0lArtzFcZQDDR2qEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524876; c=relaxed/simple;
	bh=nAgI/y8eJ1E8nc79XXLDgqcje8Y04QIWciPNIuCcLr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjSFN6i9HGMguQQlqGh7Svs5aSmrZQTUqnD6+fWL6DgV4YIQpxFqbg0thsLBVZT/V9/8ezUm1jRL5pbnEVCRAcTNm6gMyIHoiCS+OO9pxwcJde/IHtEKei0+GHRN1nUiyJYXUrP22Fx1hXvFMFF+a4J+LIm0RcAY4X8DnIJnjv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p1FEnFa0; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5450622b325so1837341e87.1
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 01:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739524871; x=1740129671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAgI/y8eJ1E8nc79XXLDgqcje8Y04QIWciPNIuCcLr8=;
        b=p1FEnFa09lSugOKK9Nd0m6W6AHH3ieDTsFDkP1QwHrAY+sW6fc3okIq4krLCLAsWE1
         jsth5OoOunMQ3K1Wl47X8fA4dXSQPHT0zFWbf4wYRkVXXAKknN2fsqid6JF0AYdYEenX
         5ft8Oi+9u/MD0xi8zbIhkKQdUl/J3WoE7W4O4ZRCsBokAYgsXt6TSVJb0Q3/4lpuxe8a
         hY+LuL9xrQqdF0zu1faslNIAG+Px9D7Ym/EdjEV2T8P/ht1WMtVoG6YA4rgHDU3oP/lP
         fRhfK3POOUF2rkn0TRiTozy6rfv6GSidaFq4KP5Y7ieGDN37xkr3HWGnZCBaH+09S3wK
         47kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524871; x=1740129671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAgI/y8eJ1E8nc79XXLDgqcje8Y04QIWciPNIuCcLr8=;
        b=NlGQAKL86YbhVGWCTZ2MBOirUfnNaq3ho7T77ParQ5i2tQsJeuKNBL44SWD2qEdPzK
         XH4RdA4dR7gniwZFAZI5GbFrfytt16NRbYOrVrAn+4ngdbphF4DjA9VwaVBGUPvlxBD/
         zkbxrV3OgnRldjvyH1JJH8NGK4CfEoYLnb5Pv5BmRGmCFQSPConcR6J1HpKFEENwW7d+
         7pdm8Py8KmUWb4U8RnqXv7Fc31kp+UqtDqUn6eUZQNddTzw271b2OGfIQiNSnJkY5MQm
         cIeXZ2hyzz5zdCojPDBoqX/M322+97TXs4vys3fN+cMGGc2SnieNyh6YoUnAayvnfbro
         Hyvw==
X-Forwarded-Encrypted: i=1; AJvYcCX0AGIz5Oz97d6ERKj+L1SkAP7Z4YAyW3oKADjBHWOCes9BWFwEh8Y2WHu9uAZRm8itfD6oyHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxku8QglXtSdxYIuZWOBwQ9lMpWnGDIjmir2byOwCCOOjNBGEIp
	Hw9ECPoITpO9Dq49gt2G6bEVBJwM/WinCUb6YSq213TmAm4EFlYE5VNa8pkZTj/4OadkmBGul4g
	rGKOQOFYdz6Wq9ixcmBJtjTQFEm2BDmFzoouByQHyQKZXQajXvT0=
X-Gm-Gg: ASbGncshvOfBvIXdZnjYHGt6PTQHta4g/vSWWqXGP3q/4MfKxX4BErEyOjPcImAVg/Z
	SelVIIzWuaSaCg9w2T2vcEoYH8H/Y2Fm+DWh/hxnlbQiCINrktGOYYzzvpeclsHgLZ7MF/s8h
X-Google-Smtp-Source: AGHT+IE90b6o1JJv5clQNldUi4eegVlq4Ca3JgGfeUcZ+3CP/urShfREcnZbwFVUloZzXxIeSNiZtb/EuXTKGiYXpXY=
X-Received: by 2002:a05:6512:110d:b0:545:191:81db with SMTP id
 2adb3069b0e04-5451ddda5d7mr2106191e87.50.1739524871552; Fri, 14 Feb 2025
 01:21:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-gpio-sanitize-retvals-v1-0-12ea88506cb2@linaro.org>
In-Reply-To: <20250210-gpio-sanitize-retvals-v1-0-12ea88506cb2@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Feb 2025 10:21:00 +0100
X-Gm-Features: AWEUYZkpajzFykICl53b_t6wma0KSzpRBNdWfZ389OoEnBSGFtcIchXCSCVghNU
Message-ID: <CACRpkdYYj6MO-xAQAJ7dnD22YRbfBZFm18Zg1T9P0sd=5kd8-w@mail.gmail.com>
Subject: Re: [PATCH 0/8] gpiolib: sanitize return values of callbacks
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 11:52=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> We've had instances of drivers returning invalid values from gpio_chip
> calbacks. In several cases these return values would be propagated to
> user-space and confuse programs that only expect 0 or negative errnos
> from ioctl()s. Let's sanitize the return values of callbacks and make
> sure we don't allow anyone see invalid ones.
>
> The first patch checks the return values of get_direction() in kernel
> where needed and is a backportable fix.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This seems reasonable.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

