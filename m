Return-Path: <stable+bounces-158870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6ADAED4E7
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 08:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386E91896723
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 06:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FF21DF75D;
	Mon, 30 Jun 2025 06:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RvsTUu8W"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C061F237A
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751266128; cv=none; b=MVU5hThSfMOrDLTre89yzgasA23iqXnFZuAUQYeCx6yJ+qX5eAknzz3FbLVXEdR2cEmvdmQldT2sCnywYA5bMQ/H9+DvFulkjVKLe4lqNSl03gbE/fJdPZk3246LDfUbkfiH3ThPLbjDH2XNFk0AAJgnxlbedMx82/fJ2y59+cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751266128; c=relaxed/simple;
	bh=+BuK294Tv0JDPvoL+aMceuYJ9PHfpp9TNu8WSqOYKUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5mDZOGE4EqavyuSXfTSyQSpkluOvOznEaBE3zPcpr9bdD6pwIQJrO8aSUhGSTmHhGhZ+q8qZpSMRi20edg5KCAjwogWfLQhse/s+UJUodSmQ9I9U69x9wW85eLrQirHRLsNaZYg7LlIowZ7NEK9Cd2Q1URJUr5x74mXHu5LMn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RvsTUu8W; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553dceb342aso1574254e87.1
        for <stable@vger.kernel.org>; Sun, 29 Jun 2025 23:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751266125; x=1751870925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/s7Y/McFMi/2nOREVlRuxwUj+a6NqLbABWDrdhUNaw=;
        b=RvsTUu8We0m+jzcAFOFw24iVZVfEP4PC+Plp/arpLNyZF1KEv6sH2DU4i8x62jdZeq
         XfVRvyALvn1Mjup/YshSMyMGcPPHUWx8HF+AlctYtbe8UdZcZVubTz6QkUIxpNpwlAO6
         m8Hla5b4UrLSXLKlMdcmrCQceZ4qYjO4UiU1iusq/N6d5sWq2kE594bhJDwfJGYE/rRg
         YxeJVRNdeda/L6nUIZu6UxAnlvwST1cebH2azlQG+Kbje/cjA088xXKrCXSHTtGIR4sD
         Ep1Oc4CmZGXXuDq7uihYdbwFRRLyYWLCTrfqzyw6qZM4Ry8oT24WBA/eDNpo1iNDEGUF
         T2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751266125; x=1751870925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/s7Y/McFMi/2nOREVlRuxwUj+a6NqLbABWDrdhUNaw=;
        b=EI6DKfP6M3Ih24/YVTRSXSuV24uzToWpbmsjdxXIoeHMQV9x6h6So59kI+2bUQkqqN
         YVEjk04B9ujdPuAhIiZV75IjnLL6XEh5sh4IxrA1nCiV6RbrCad62iQ+x0mjsGcl2sO2
         zel7rTmr6FqAWgwuMV+loHG1e+j3KysfrbOaEragLKzWKWD6ZjS90bQDV+ntF5fNhU9Y
         70WyoB3K0IdIwRa07vxIx2e7SlTkoBnXWirI5GJkm7D/lR17Ii695wXXc1Dz9zpbfEMs
         BHLvY2euCmAqSFQ7R4QgAbjQ0LUZ43+Nj1WJoVWGgnJKJe2nJqKuF3826B/SWlGwCcJY
         Q48A==
X-Gm-Message-State: AOJu0YxOR3C9er+mu9h8VpK5Jutl8ekE7BdzyMJDXFw/fnCP+vI1wvmg
	KaBeEohbMa7NF3X8XYq2aI1A9Py/rFdiQ9eh0MiFZ/EYNpg39JHE0sfxedbzqusjxMw6JtCM5jJ
	a23QVV+q+TWS8IVcWuoZ8zBKWkdjdXCRiOtUm/bZ4sw==
X-Gm-Gg: ASbGncsyQZ0OOPr4H8RRSBqVecQnEhmdjxzqcWYSr9Vio58uZ/atBZZgt/XHBnVmegZ
	RHqCrzorzjw8TP3NEsQtTdNu7fQFmD5AIvpaeZ5s3nf8uB+vs1cDB1ac7H8WgLQTjaIFqhlHPj4
	Un1UBE6N8bYYcil0W4SX4YgMZn0KhYnc0xvXraYugSbidSdDhMYuM865yOLNZknoVJqrmibKcmw
	9A=
X-Google-Smtp-Source: AGHT+IF/rYEDVeqJ1ga/rhvIxNEAFuVarQUhK0ND+vF6Gi96fm5NvwuQx3QOXUn0r2G6s9V/9kqXt+LomKX49vLBzWw=
X-Received: by 2002:ac2:5686:0:b0:553:50c6:b86c with SMTP id
 2adb3069b0e04-5550ba23cffmr3357911e87.57.1751266124952; Sun, 29 Jun 2025
 23:48:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627140453.808884-1-sashal@kernel.org> <CAMRc=McpWPQx2f-7zR9AovKiA1B5BF5QiXHrPXVpT+Xu1uH7cQ@mail.gmail.com>
 <aF_36YgeZqJW1QLF@lappy>
In-Reply-To: <aF_36YgeZqJW1QLF@lappy>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 30 Jun 2025 08:48:33 +0200
X-Gm-Features: Ac12FXw46oFhJPEEVUh5_TGtlgAmsI_sfqlPbCM-WV7hN1y6IRqt5JV_GL09QNc
Message-ID: <CAMRc=McuBLXK-WuqBRKTUAmzkSLgkKEXWhq__vVFBMWgK0NR1Q@mail.gmail.com>
Subject: Re: Patch "ASoC: codec: wcd9335: Convert to GPIO descriptors" has
 been added to the 6.15-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, peng.fan@nxp.com, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 4:10=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Fri, Jun 27, 2025 at 05:34:10PM +0200, Bartosz Golaszewski wrote:
> >On Fri, Jun 27, 2025 at 4:04=E2=80=AFPM Sasha Levin <sashal@kernel.org> =
wrote:
> >>
> >> This is a note to let you know that I've just added the patch titled
> >>
> >>     ASoC: codec: wcd9335: Convert to GPIO descriptors
> >>
> >> to the 6.15-stable tree which can be found at:
> >>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queu=
e.git;a=3Dsummary
> >>
> >> The filename of the patch is:
> >>      asoc-codec-wcd9335-convert-to-gpio-descriptors.patch
> >> and it can be found in the queue-6.15 subdirectory.
> >>
> >> If you, or anyone else, feels it should not be added to the stable tre=
e,
> >> please let <stable@vger.kernel.org> know about it.
> >>
> >>
> >
> >Why is this being backported to stable? It's not a fix, just
> >refactoring and updating to a more modern API.
>
> You've cut out the rest of the message, which hase:
>
> > Stable-dep-of: 9079db287fc3 ("ASoC: codecs: wcd9335: Fix missing free o=
f regulator supplies")
>

Ah, ok I wasn't aware of this tag. Sorry for the noise.

Bartosz

