Return-Path: <stable+bounces-176958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A453DB3FA63
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D18977A7CD4
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 09:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1550F2EAB83;
	Tue,  2 Sep 2025 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="k34K1Z/m"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86592E7160
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805344; cv=none; b=H0i82uGuv8vNPoZvcokFZ1JbbCUMHmlw2Zu7pO6ht+jclazrUv+8y8VA3joBj7ixVCUFu8X7Ep6Ly4Lt/+M81Uf42iWrgq3/JrKY0lMC8DTAc1o9rGnH2p3kyFQEmxixaDKqGPTeUeb/ap11QxYRgYR+FmtwLE5ifNAT7TlOCpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805344; c=relaxed/simple;
	bh=//HUxWX8DeQeqsCEd7QC8ijoCC/MOXp9FJU6m8p+/e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEMDlz/RPJGNFV3Zv2dDNtNDo9hd2wloK5jfPf+ICfHsG7S4j/7fnMDxynvC7Ks301bDMUp7Yc/dy0xFjvScdqXLlBaxX8Dkn+l8fxat1WuO6EH+aq5bMZuKBn4z3iIrCXaN9OEmqkcLS6YzUl3/S9rz7GN4iG7OnZsbr47P+cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=k34K1Z/m; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f753ec672so2882895e87.2
        for <stable@vger.kernel.org>; Tue, 02 Sep 2025 02:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756805341; x=1757410141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sgn/vJYsBdxnr7Nj+togafj+OMxwmvaU1XUkgIJUYhQ=;
        b=k34K1Z/meQJ4VwbmjIRA5E7E1EAZQSmf4hhxBKjJvEUxPYANVxFPc0MuXLkiH78xaN
         zZBqLDyqSZhOcX1UOxWr3//0S2O/R1o4V1Y8co1WX4XnIYjGfqqjrC471Vvy1rzVoc6d
         zrYeJ9vSg7Qvy76HW1ROt8PNYG2c60YolX4/Geyn81v0bNfoGWsyGlRuoSZJ2dTiDeQI
         oZ7R0VMNFnC9EcUf+tyBgfQN88Pq6Xby2o+4v6N/EZNonhrIMGRNiVJgylr7vJvfpkSr
         t8qPkqXByTYlZNhSs64A8kcLoIknaJqJxTNRROoVapQ5j48nfioGZ8Iep5/JQIYX65Hq
         ZiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756805341; x=1757410141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sgn/vJYsBdxnr7Nj+togafj+OMxwmvaU1XUkgIJUYhQ=;
        b=vKsrqt22ZPeCq77g83+itLtTZVtaAovyW8DotgtI4cAEokrScBeM/qh8Zv701LdQzA
         sxPdJmHNBVu9ZZuwI/YwfL8jcHtXGYXbrMPMxNMb9bn5UfvlIXbgPm8pc9Adpl0aLlwS
         xQn/yVLFyl4YrAQQMyIwu+KtNv1gu0btDR0lJdzwM6eFB9cigq4XUhd3q2ZoLdDlQGmR
         Rk7ZDOm1CUIVUoRtybYd5dVKr2Q7rToR+MjUMA7WvQkeblCrpvVw0eMNZjalk6DOCYdu
         uh1Ety3Fs+L2xnb4ErUF5abEI7WSvYOTiOFGQDr33XJORA7HDEKUqAcEUHM3js1+mPx9
         lguA==
X-Forwarded-Encrypted: i=1; AJvYcCVqVs+bRcjFqPPn6U5JXQgy0EIbUaQuLIcbaqkw/0GrmAlW2hGEE80Gwu2VoaXEln2T+EvbLpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9RxCKa/+jJb5k3mw9GMbnq6jToRqCU//Jath7VgX6nZ+lqJre
	5hIafuS7orqSIVUcUdeE6kveKJFW4wbPwEfDwJ913vt2a0R97/S9Uc5+Vv5Q4gSLpnTXK4siS6X
	94DVIUCy/RJvulaW5RPx1LBAUMDTFP9v+3WfLciufwJcNZA6x50l6
X-Gm-Gg: ASbGncsminuMOacbYBQPdxP4B4wk3eWfp5xb7UIieIhRS2iXr2UUbYDyYjF6SI+UOrd
	SBRXUcn7QJS3TAdbcey0WJMoLeGlFRWARjUIvrJDW7+GXIrVg6+Q6uO4hNFHcwO5ASB7eDdkm14
	irg1PaoQcykRr11YELw6mrsfTMy7PysIf5MF9pS/8peSJbhPsxVR1s748SWAUdKTHlQ1NL1JAKk
	G0a+i8y4SMI7YqC3EcJaiKz5jZ6gxeIy6uh7eIWY91syqZVGg==
X-Google-Smtp-Source: AGHT+IEbZleDaAu1wkbBHOjnlGL8C0lL2XvTBcBG1o0Yu7ShYVTEpic0xTaWFK07gn8fwR7JGIFClShl9m8jNgG1o5M=
X-Received: by 2002:a05:6512:680b:b0:55f:4e62:f0ca with SMTP id
 2adb3069b0e04-55f708db56bmr2636846e87.29.1756805340472; Tue, 02 Sep 2025
 02:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org>
In-Reply-To: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 2 Sep 2025 11:28:49 +0200
X-Gm-Features: Ac12FXwyTg5R9QK3KWUxLTr3m9eLRisbXrlkPr4WlpAVjY7_RF2FsWzkYU59lb4
Message-ID: <CAMRc=Md+2_3w5kdaUF9-nGdHv9C+tGRfN9TTu6E4+hSdFbwGBQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mfd: vexpress: convert the driver to using the new
 generic GPIO chip API
To: Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Pawel Moll <pawel.moll@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 3:36=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> This converts the vexpress-sysreg MFD driver to using the new generic
> GPIO interface but first fixes an issue with an unchecked return value
> of devm_gpiochio_add_data().
>
> Lee: Please, create an immutable branch containing these commits after
> you pick them up, as I'd like to merge it into the GPIO tree and remove
> the legacy interface in this cycle.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Bartosz Golaszewski (2):
>       mfd: vexpress-sysreg: check the return value of devm_gpiochip_add_d=
ata()
>       mfd: vexpress-sysreg: use new generic GPIO chip API
>
>  drivers/mfd/vexpress-sysreg.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250728-gpio-mmio-mfd-conv-d27c2cfbccfe
>
> Best regards,
> --
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>

It's been almost a month, so gentle ping.

Bart

