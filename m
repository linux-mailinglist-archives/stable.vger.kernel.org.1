Return-Path: <stable+bounces-119865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CE1A489C9
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 21:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4749E3ACBDE
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 20:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF56C270EC2;
	Thu, 27 Feb 2025 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sXa9rgGI"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D92222576
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687843; cv=none; b=bcP3KebaJbjATsVQfyCy1M56KK5cOdrBOwhTW2g5JtBr4UwiqiaT684RTfZmcXjyRmmumJexZT+xhJ1DKgjkY0v4Ke7hoyqV7PjQn+HWgMjG3wNW/zv6LEcK3z4U7zoc9i+N01/KlNW0clZI/QqTHDx/jUu2kS9LuZmw9y5ul6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687843; c=relaxed/simple;
	bh=xzuDAtDLsMklMIj9X/3E5DszvjVGsPUE/6ktORRqvH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJYlfoFnaH1KCWtSE5WPql0bpLEGQJR18H1zcHwji5vjl6MSOaw8KqdjfpaMNl39zbPhoygxa7LfNGkzUht+eiJ0ENTEzgx9PF4QlcV0gzWPhbrUNKhW3JrXNn55+pwVIBvAzDNeqfcUM+HizDaj5BdqrKiRY4CmrDLXOqwSRH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sXa9rgGI; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-307c13298eeso17116771fa.0
        for <stable@vger.kernel.org>; Thu, 27 Feb 2025 12:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740687839; x=1741292639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyq7rCZAildVjmFezfKBEpeheeeS0M9w2vanP83edP4=;
        b=sXa9rgGIe72AnWm0kXhbz3sA5TE/JUAwI6iiCqmenS/s2pEofei0vZHc6nvjWCSyNQ
         XDpD77aRHuidyuC+OXRs7wtDaQs1v9jELmLnKwSR8HxERM5eNJVkLvoLBGNiuKMijhFl
         p11C2I9WVuxd6mJ1HpR+ABEBKdm/1c2w0WURWljxCJjwZrFekIXGu6NOIUXqXqw4aB+s
         7BoP3r5y2F4KRaiohrYJfptuXZ6nlxs3cGTb/NDyB508SzRTJWMERZWL3EkesLpyAFZH
         VGbcQuQc0/VqMCicmazGTA74QJCYlxVO78OowOVCzL8AjU5ZePoJ0ejjBLZYuLG5soxZ
         NArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740687839; x=1741292639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyq7rCZAildVjmFezfKBEpeheeeS0M9w2vanP83edP4=;
        b=d274/GOQbDXRrGi9uIhC22Q2o1SDNRBYCWCCczaZGeHGUKlMuzFCrjmxwHBd4zORxH
         q7NqQ0LpI+ZL9EIYTHQvLy98Rts7kSYj4i3NAZYZ8Jh9d8zJlZYiUuiqf525jM+pgU22
         mXp1RLUD3ZVv43wyRurcGdtqWEczCTQ48FzBolkx1ZFbpNwAn5d4NJn0bBSuAbBFVbpP
         P5O+E3icFOgLG0ruaS63JdWRkeaeGXVGZfZwZxuW7x6pRt6SiXG33efEfPW967AjQzyd
         blq+sDKQruyQgy/uUT2Of1drp77foqlhGY2RbrlMZ8DKnCJ/Xpb+ZSfdjq8glHyiAD30
         AdEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo9Bt1ZWUyzfhjAggOWQwFACPOHVElrkr6G6eSu12vx+CVjitiYgIgHtdX/o8aU28Bt50fXbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhoI6ubwLJauzJYWzw7FoUhXHiLUqePn8pzL3PJ8uvUFb0ygo/
	Gmnfh33feQWLCYIhVuIiEvSwLyaA0qUQJLMju0tLPoGrGOHZuj1/jptaphWWig7zgdm0Nr1IT+r
	hmlurW8Il8VxebQwnZle6D9n192Q06I4G+5fHi12X4ygwYzLk
X-Gm-Gg: ASbGncsBSOxA049qXjUFe+431Tg57mzNY6uzUpJGA40LqEYt0DV6pnaO0KGF9ghq15y
	XjmqniWjeNWko7GzcrvGMJvlDrxwQ8N8KfVCU5ngJBw4rfRsWsBBq5NmelykHdFlU2GhuHie9jD
	XtsRZjFk4=
X-Google-Smtp-Source: AGHT+IF8jr1RPuup3BcxHI4jeLlB8xSlyodMY3QSAvlSz4clUiZCsM6vxrH9ix6FZsUN5FoNEP8fAezlutGEF+kORI0=
X-Received: by 2002:a2e:b8d1:0:b0:309:1f1a:276b with SMTP id
 38308e7fff4ca-30b90a0d479mr2534371fa.10.1740687838584; Thu, 27 Feb 2025
 12:23:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220085001.860-1-vulab@iscas.ac.cn>
In-Reply-To: <20250220085001.860-1-vulab@iscas.ac.cn>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 27 Feb 2025 21:23:47 +0100
X-Gm-Features: AQ5f1JrSbsBZYhsgrUajyxaLegYWak-pVEINzJX3bUZh51BhE0XwC_gtDg2DUjQ
Message-ID: <CACRpkdZShkMhO9vTvdbyEzkGLL2+mfnLmADGukNZ-Xw=NNxksQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nomadik: Add error handling for find_nmk_gpio_from_pin
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wentao,

thanks for your patch!

On Thu, Feb 20, 2025 at 9:51=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:

> When find_nmk_gpio_from_pin fails to find a valid GPIO chip
> for the given pin, the bit variable remains uninitialized. This
> uninitialized value is then passed to __nmk_gpio_set_mode,
> leading to undefined behavior and undesired address access.
>
> To fix this, add error handling to check the return value of
> find_nmk_gpio_from_pin. Log an error message indicating an
> invalid pin offset and return -EINVAL immediately  If the function
> fails.
>
> Fixes: 75d270fda64d ("gpio: nomadik: request dynamic ID allocation")
> Cc: stable@vger.kernel.org # 6.9+

Unnecessary to tag for stable. It is not causing regressions.
Skip this and apply for nonurgent fixes.

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

