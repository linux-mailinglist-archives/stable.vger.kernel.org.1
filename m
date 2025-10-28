Return-Path: <stable+bounces-191493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C79CCC152BB
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 15:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4168335429F
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 14:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AEA204C36;
	Tue, 28 Oct 2025 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s2MjgxQ6"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0EC1E1DE7
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661850; cv=none; b=SQl0f/+T9LDd2Tyyw5qO9OnigeCapA+mHCiE2PpG/VLOi3nSkaSkojFsy/U3il64cKZ7ABpqwq4vK4+3mQ3EOIbno/agpl8wfLii6Ies/WEpuxdNuzTdfg0SlYID5QyVqyVR5MJH1jLl63T77UTVdcJQWCkLwuI47xvoFHOIOXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661850; c=relaxed/simple;
	bh=/EnaIRg4we5FEW80Ou7ogsSNVQciSKk7T2iuyHX0uOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mb1kpw/chdXL5KgU+iDooYfpIb1gybJ1IQFJC1NTxlwGZN78ZpWnMnJngJGpCqaebkppPFJ7goKsTexNhKnuZfNPP6Lm6v5WGveDWP/WE2cHyRYcjBW9VxRLrWefyINF6wyJdcw9MdIG74QOPNJliJ/UwWf8WM4rl3unHXqvoMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s2MjgxQ6; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37902f130e1so21158321fa.1
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761661847; x=1762266647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVxwfZTDpc7M4pQsaPFzCx/W1h+13bfqb6IBb/Bsbhw=;
        b=s2MjgxQ6lTaK6dun6iIHp7vmhEed6zrkl9FD7AP7/pt8N3Nos53voI7c4s0JhMrIQK
         KftvX3G1+qbLqG0Ve4fo08Pg/FpSuaq7rtZynrv7eD6NWKBrjWLsiArPkheUp/91vKz3
         bNB3tWgt7Q4iSnpnZKSjB+uLcKONRZCkBIS+QnRt3KNxGoXrp8hb05ma96QaVUwKnYpd
         hkltdaGRBbgCCqVbVfQA+KOsR9la7PmqQ0zJYMoRucTqfO0NobO+etuO8i7053KCjLZ2
         kWMQLVqGMmrKKXBogFQqEOBJGkPuKtT78HBOh2wmXzdevwcnhWI7KnxN2j3ty4TVTlhk
         UVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761661847; x=1762266647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVxwfZTDpc7M4pQsaPFzCx/W1h+13bfqb6IBb/Bsbhw=;
        b=J+71vPuBSt2yFa1iFw1BAbuhxa1HIt6nBeSLIbFT+gD64UwiOcZvFAbEEcmuHncA1c
         oBOHRlNkoKNoj4u5haK7Sz8d8IGp834wOn8g5bVM7vaorUq1eSjh1mKx916Ss1rDVm1l
         cXC1okAkzds1xZZazQOygniPR2NITwIeOZqD7xX1gW3kmOJNdC/t2zkjCfoZCR5lCd5G
         Ahn3OQmeP/blrSR7YhuKa9JGpisSNesdRQfSWNnYjSv8DyudPaggnTTWzw/7fyZJjl+t
         hACV2/c0zpUZxARdMQBHuIBApfIootHAwJQ/ufSo3kxr0xYwo982rE4aeDBJ0Ed5d69N
         G6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuXdPziqnQjazlPsOHrwH2XI3j1U1UHkgA/qTsJCOy7RwI3B32zP47VaWq9X9wSAFO0YzITWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRFg/TbbubN5OpujKIsNMgvz0aG19oE4b7g7Ijug0IF9R+DUnL
	WAOPvHErE6E7+4s+8GF9gGWt+xhjA1XePb8cvaJp3k/SHcmr2PUxj7SaG3THmDGel5Nbq+GZ9ju
	dFqUn4f+CXPH4JvpKYZYtRMV+jDOGph4VggYC5sgdvg==
X-Gm-Gg: ASbGnctd0FGUfEAz6+rtXrRWV81bOYsda33GjMAhoamwYXQOL2MoGzPgfQxfo7I2IIp
	Km/CQG/WE+pF9o173aXOAGXlda3PJnRYDeKJSKAR9fRl3vik7hz2sFG4izICCIAeGFOt0+o+ykc
	DUYnh085uZpylSp4Io8LyguXJ6k+q4Np7OcsDV/XajYXI01zNg9zpbLBhMMEnpX/oGJUB1p7wDW
	g765SwxSeFCei4nxnacE2lOqSfwhybPGSkRjDyf6xL0CHNCKLL9F8limVnU+w/iPCvfZck=
X-Google-Smtp-Source: AGHT+IGfUDzyVfhtzulYZCc6iSfT211wGg2uBIly7fuTRZ7yuQGh9plAyDcmAhZ0TpLkRKajO5Ig9eKhL0B7O+boJMQ=
X-Received: by 2002:a05:651c:23d2:20b0:378:e0e0:3b3a with SMTP id
 38308e7fff4ca-379076be317mr9148741fa.14.1761661846757; Tue, 28 Oct 2025
 07:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-fix-bmc150-v1-1-ccdc968e8c37@linaro.org>
 <aP9dqnGb_tdWdr7y@smile.fi.intel.com> <CACRpkdb9GYL3dQzn28Q5E_-keJdLLA+TiXxTuNf1aaevKqHJYA@mail.gmail.com>
 <aQCqOJWQpvgI1o1q@smile.fi.intel.com>
In-Reply-To: <aQCqOJWQpvgI1o1q@smile.fi.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 Oct 2025 15:30:35 +0100
X-Gm-Features: AWmQ_blj3ecUmJnRC1MKqgYg_3nbYbn6QScF7hxV1R6JPg_7pa3_fIhb0qICMdE
Message-ID: <CACRpkda6HFnFPHELYAPbco7x4Kr1Ri9PxM4rePOGfihV0mef0Q@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: bmc150: Fix irq assumption regression
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Stephan Gerhold <stephan@gerhold.net>, linux-iio@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 12:34=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Mon, Oct 27, 2025 at 06:24:25PM +0100, Linus Walleij wrote:
> > On Mon, Oct 27, 2025 at 12:55=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Mon, Oct 27, 2025 at 11:18:17AM +0100, Linus Walleij wrote:
> >
> > > Hmm... Isn't this already being discussed somewhere? I have some d=C3=
=A9j=C3=A0-vu.
> >
> > I brought it up on the PostmarkeOS IRC, otherwise I don't
> > know.
>
> It might be that it was a cross-mail that describes the same issue in ano=
ther
> IIO driver.

Hm, I'm a bit worried that this may be a generic problem
in several drivers that now think they can be used without
IRQ but actually crash if you try to do that :/

> > > Wouldn't check for 0 be enough?
> > >
> > >         if (!data->irq)
> >
> > But this driver does not store the IRQ number in the
> > instance struct because it isn't used outside of the probe()
> > function.
> >
> > The information that needs to be stored is bool so that's
> > why I stored a bool.
>
> I understand this, but I think storing the IRQ number is tiny better
> as we might have a chance to need it in the future.

Fair enough, it's a common pattern so I'll rewrite the patch
like this!

Yours,
Linus Walleij

