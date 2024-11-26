Return-Path: <stable+bounces-95526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D469D9760
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 13:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE8A0B23440
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 12:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402CA1D364C;
	Tue, 26 Nov 2024 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XKhkOKt9"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D001CEE8A
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732624901; cv=none; b=Jsl2V+7U+8MvwpEJ86QAAagrsxIcWkUuX1P+G1ICXA2nQURv6Pcnr0BeZsREhl/M+ngGVqf6jrjaVE78a5XIojNm1/FZ5oiDPJuC8WeT+OH9WzphwwrR5TtGJjet69z858CNszTXZhTIZtziIod5WKg517sV0D+aj9E8nI55hrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732624901; c=relaxed/simple;
	bh=cPTLukRRkvaGSB00X3hsgqrDjbaD+cNjKIgDNOefcOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axArfMJ9+/+3W52o7vH34NO3XKTwP7nP9Rre4eeoCenaz0hiYEJHtIAkkn1+lMFoxJ8TK8/0XITl7pMaG0umBHOe1EOukmIm+JaoRIGs9MEQOz3+Sc0wIf877EJT19PN/ndTo3KQtYKvhttCX1+6HA/g8WMxA6nnlnKerIbh3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XKhkOKt9; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ee7a400647so58969107b3.1
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 04:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732624898; x=1733229698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cPTLukRRkvaGSB00X3hsgqrDjbaD+cNjKIgDNOefcOk=;
        b=XKhkOKt9s0Y+ktsLJ7nOA6W8tFY9+gflqtV+KS+cspuiaN9S3hjKic5OEc5XUcud6b
         ViqsikGnTIUd27TXmq/4TDzc30czyiaQkoUom+Wganbtyg2gM4fDs3IVtjSHw4TEXIYg
         TSsV9yti2NATSuMLZlqhpZh0NQMjmurXRkoTqpnt+mch0QIS4uk6yeU3rH0bdWxUZ5Jc
         ieG5iFuXdRuyA/YFsOTp0lAPgsIrw+vcNSN7BE8gNaiLxoNgCDXeqa9WCcAsCXtmlxew
         KFMck9/sOCSWIeZyPUi3nkuZ2MWRVhNLyLzD9FrL7cu/brk0jMFpq8AZoHNopXBNVQ3p
         eNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732624898; x=1733229698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPTLukRRkvaGSB00X3hsgqrDjbaD+cNjKIgDNOefcOk=;
        b=KIzQbxd7d50MoUiXhTFQVse4YDizJVSq7oXZErLpK3O9346bFaP2RSPWn2ifJ4XU3P
         EmkNzMUbyiFzIM2oacYv0aCl6NiJhHuQp6/6K7Py1rBtDV+qnhTSdpXCWXmIFAm1DaI9
         4sCsrfHS0PQECQWs8CwrkmcmLNSBhY3M7780sRg1QaILQu69H14vn5DwPc/8dhic5j5c
         RT2aD1JhI2R+e4GEA7/fr2x4HIlBIyBAMB8GcQHOndH1h7Gny1NyzcppfWFna1jbSy75
         5cGPrua8We3BfaR3ynIIsaL5gKWgNZeUM9DHwiH5uJxhAAY8ykmOBhgBMmp6obcuDK55
         NiQw==
X-Forwarded-Encrypted: i=1; AJvYcCUNyMBZE13fJ+pHEdD5NDuw4hxrOmkdhPzsqNOXRpeF5gXj3QCLgp72/f1wz9fP7xwHyCqTfQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKOMTcWurbf30m9ylfiqh5HLCTqERzrUgL9UIFYeVsxJJTS+gW
	uSbORFyw+zw6jWO7RnN+ScI6mV+hOZx4g5wbRTwjMCiJstYo4WWB+YTRHgxSBwcyKcAMG2I4oOJ
	mv6BYfR5HzjgGrq44nlVMpvvQa7xMZWM3oaDa9A==
X-Gm-Gg: ASbGncsiJonIuwIyOLLOrYlv+Kz+ZJ4HZcgA0cewaOmQxxnYcjWl5KMwujwNwmP2GnX
	efEoXePZ6NN47fRXjD5fODBq28iUFAKwpkbV+FEjdg21/sF7SC6LONF2NjquSFCE=
X-Google-Smtp-Source: AGHT+IF6l4+hBDV+putwVYiDk0qugPERHe+upMe++6V3UcZ5/+gbIZmfJ4RQdC8Lpth0bOqnEm38/6mER962cgmW0UQ=
X-Received: by 2002:a05:690c:2504:b0:6ea:8d6f:b1bf with SMTP id
 00721157ae682-6eee0779a6dmr182254577b3.0.1732624898603; Tue, 26 Nov 2024
 04:41:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124124919.3338752-1-sashal@kernel.org> <20241124124919.3338752-21-sashal@kernel.org>
In-Reply-To: <20241124124919.3338752-21-sashal@kernel.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 26 Nov 2024 13:41:27 +0100
Message-ID: <CACMJSevZVPcHaEfromwLu1mM5kXE4sVz6f92u5HKLpM65ypbeQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.12 21/23] USB: gadget: pxa27x_udc: Avoid using GPIOF_ACTIVE_LOW
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, daniel@zonque.org, 
	haojian.zhuang@gmail.com, robert.jarzmik@free.fr, 
	linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 13:50, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> [ Upstream commit 62d2a940f29e6aa5a1d844a90820ca6240a99b34 ]
>
> Avoid using GPIOF_ACTIVE_LOW as it's deprecated and subject to remove.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Link: https://lore.kernel.org/r/20241104093609.156059-6-andriy.shevchenko@linux.intel.com
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

All these GPIOF_ACTIVE_LOW patches are not fixes and should be dropped
from stable branches.

Thanks,
Bartosz

