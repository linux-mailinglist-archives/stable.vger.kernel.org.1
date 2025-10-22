Return-Path: <stable+bounces-188907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77225BFA550
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 08:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115B718C6B8D
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 06:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD9D2F360B;
	Wed, 22 Oct 2025 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="G2SblonT"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E0E2F2916
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115849; cv=none; b=tJpsRQgxQvONwI0i+fUy4e+pUAq9RnI3QTiArnc+5phOBHmc90zvnzUtT4t3YCsjsfUjLLGwVwIIHLZkZg7ySX99FdAABSEyAiO466LGjXG+W1/6zKW1guCSGYm4nwNhbem+Cd+zcPi2b/B655Hhr7s4IgjCgIc0Px7FIIK+GkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115849; c=relaxed/simple;
	bh=98PAuLdi5bAL91h4qCl8dx1pL2En1aNP3Fd0W9MUOXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTAd7GrEBOJTL5RK/53bJg1KuyChBQhxd6sZ9wkFA18g2t8Iq+9HbgbferxW6weO7vdFXnyWLjLPAhx2wBxWY+Cv+0sl1CErchJDQAJAqUBIzdIIlobJJHNpI0zwg8PF3zmNCEghjLdUiQTeDKXOdb9gOXLXtG2B9i25I2ZmuZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=G2SblonT; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-591ec0e4b3fso1535770e87.2
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 23:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761115845; x=1761720645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98PAuLdi5bAL91h4qCl8dx1pL2En1aNP3Fd0W9MUOXg=;
        b=G2SblonTD+zIs/XsqYGOF6Ti/V1CReKuYkzBOP1SuUtgTrEziaWZX66J0NV6Sj8tL9
         OtEVUmckZVsP3Q5/EJAFqafD6bvdxk6nY55LAArQY7IFYei5c3f11IGkrkwNfgoNrfri
         NWGSR6q/+HuZI8YnRYQcwzOYM80vIKpah9C07SMtYpP0CEcOuM4f/hQG8VIRAh3iK8XD
         VMlzkfJFNICGexHODWZyLRQ6O5dy5V3iOnyRlMcB3L04M6JtA/UpaLInqHjgzO6UDtjs
         eVFV0AOU5svhNjIpMW69cb/OvgBjeMRF1Udzo2R65nDIQWRCldu+yTPAU78Qag3X6Mif
         jGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761115845; x=1761720645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98PAuLdi5bAL91h4qCl8dx1pL2En1aNP3Fd0W9MUOXg=;
        b=EPGY6KwZkMHpD0OdjQ3zk63TFKisj5eZ8y2rGhHf/BarlSZx0hXhptOgYcmJlQH6Nr
         IN4r9pHf41R++YWrVTxL1312TEDeoQLilz8lXvX3i2gI7uwQGVUhtWzPSRrRaKJhDubP
         aePESN0ygezWA4i73ANCSQbNSWJs3w6rPaZecDa0saV2PlC+cHjoXIniO1GTSN835/f+
         2TDveD2BcXSEtHL8tJVWT4nqU3jP8T4ZAGx752M0UtGDtzXBGUFK95X7xhUhyxPcjTWX
         JOTcIlsRCy4GA1CvwcSYMeR/NOV/7GIQQ1bNbhhzbOKNwpKaehdq7UqQMJ+mIROWRGyn
         P33w==
X-Forwarded-Encrypted: i=1; AJvYcCWOBi5399YU4KBQYiA0AovSg+GLv1t4P3E7rDDfhNYKT1dJqBwF2SnASE0t/R+UikN3vZdeQkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+EQvvcZYytuIre1iLkTyKi+28dXgLEzsJthPmH2HEacUepH1H
	ii0Iisd7j1pvxnoq7uxDz1p/lLbw+X69+8FFKCCXmCIn9ULbjIKW+B1LQsv9O9TEw2EKWcxQ/+l
	BnBKQjLR5xQ7LnNCoopZNR/nnIuAWkF2K+/8a9TxkCQ==
X-Gm-Gg: ASbGncsHGFF48DXncFxCe9G8Bmf6UTB+QYCLQpJMfnOdHAiDnsmQehnWU1H55E7pWDa
	xR7T7vzaIW3KIxK0hH2Gyv+NE/EEfzc+rqnjGyc3kMAss6Sjri8CJXGGX6sWYrM+sxmesVXQP4n
	Cs18v+BpfjYtdk7pOxjS/lyJZAMivoQHd2ODydpL9wJc5bhExPDIi2QTLQriiwt6RdJUdwoTvui
	i30RH18LVVCZtMssUFiNc9B/5ZVbccxDppUGFwpnTv3stMYUYoLFeh66ppEjT+e15DvH68Gcwav
	443fFpDBHfqMj94P3qRcT6qEJLw=
X-Google-Smtp-Source: AGHT+IGr3zukKNYzeyIqR+TYPmYQbS3OFcssWzGNvaljz37h2jEpar009J9nuKk8lRLqnblAhVZVoA4VbyVfP/oprbc=
X-Received: by 2002:a05:6512:318b:b0:579:ec3a:ada2 with SMTP id
 2adb3069b0e04-591d84cf71fmr6407192e87.4.1761115845419; Tue, 21 Oct 2025
 23:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMRc=MeFZTDk4cgzEJNnkrJOEneFUBLwtKjkpV3-cLSm=xsxNg@mail.gmail.com>
 <20251022021843.6073-1-wbg@kernel.org>
In-Reply-To: <20251022021843.6073-1-wbg@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 08:50:33 +0200
X-Gm-Features: AS18NWBBs20dJ04q9W8nyqQ0zArr1FQChkJ-T0_854tkBtyhYXLfHhbwUGei9wE
Message-ID: <CAMRc=McqqxWTf4CbZJRSBSD1BnLNZmed_G0OsMNob1wTZmj=pA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gpio: idio-16: Define fixed direction of the GPIO lines
To: William Breathitt Gray <wbg@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Michael Walle <mwalle@kernel.org>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 4:19=E2=80=AFAM William Breathitt Gray <wbg@kernel.=
org> wrote:
> >
> > Turns out, this requires commit ae495810cffe ("gpio: regmap: add the
> > .fixed_direction_output configuration parameter") so I cannot queue it =
for
> > v6.18. What do you want me to do? Send the first two ones upstream and =
apply
> > this for v6.19?
> >
> > Bartosz
>
> Sorry for the confusion this caused. It looks like `b4 prep --edit-deps`
> will add explict dependencies, so I'll use that from now on to hopefully
> prevent this kind of problem in the future.
>
> So we'll need this fix in v6.18 as well because the IDIO-16 drivers are
> completely broken right now. In theory we could revert the entire GPIO
> regmap migration series [^1], but that would be a far more invasive
> solution prone to further regressions. Instead, picking the commit
> ae495810cffe dependency with the remaining patches is the cleanest
> solution to this regression.
>
> William Breathitt Gray
>
> [^1] https://lore.kernel.org/r/cover.1680618405.git.william.gray@linaro.o=
rg

Eh... Ok I will pick ae495810cffe into fixes, send it upstream with
this series and then pull v6.18-rc3 back into gpio/for-next and
resolve the conflict.

Bartosz

