Return-Path: <stable+bounces-87699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEAA9A9E4C
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 11:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91C81C24BE2
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6B01991AB;
	Tue, 22 Oct 2024 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSD++rOE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E2B1990DC;
	Tue, 22 Oct 2024 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588737; cv=none; b=Q2zI+IIvGBFFV7o/5B4VsaoTq65Not1E9MleXCcI5/43oeL4CzTw47MfObha64Sy7AEFQkMXVMIp3VDSxFPa1Oti3jnfASGd0z4VW9fxU85GGO5JcM8A2eXSU2ceGJrKT3BVZtUy0wIyq1tPHeMBVf1SUzZxC+6+lhTN+5Z83Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588737; c=relaxed/simple;
	bh=ktUntblqwbX11lE4VFhQvbDpXlY5dHHrgSDM8lr7qU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQ+lv7Al11cQjNLz67XTJrZ2n/grcAWxvh/w9QvvYd8tpw9wMGYTggKql1F+Mcprzjm0YbXqdqFH4kslgHWdaWbro4UtVbcM2uTeHFmln1wZcwZjbcGivFyoVET2dmIfLs73c1hE1ULXlC7BU5WvGIBozFLAXXm5xKw+yU46+PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSD++rOE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a628b68a7so699518466b.2;
        Tue, 22 Oct 2024 02:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729588734; x=1730193534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktUntblqwbX11lE4VFhQvbDpXlY5dHHrgSDM8lr7qU8=;
        b=gSD++rOE/qcNeRZkFQkVlCPKX/aN92S2nG04PEE+CZWVHrZH9QuQN4WjJivsKR1Cgv
         VCSN7bt9suy/C4Uw+GjwHn4U7I/OpDvpU8ouxu+4gqcc3/6ZYk6wY1489NKtRLvFTxgb
         uEJymQYzhmaplV8WKbFwtsZbxd3gqG4/w1OAAL8DNrRsPVkg38dWofO2vcrMbvFGJbl6
         T9rQ7bK9a2/aS0DP6AAziPtncJefxdZvK0zPAqB84QcbVyOoeJ9GSc2IdIWPxp8/b5UK
         I1MKxdO2bY0mbCNyscDF03wfOemC+CrN5Hd2Ib6akWdaWQ95GtTK0YtnOkA1BQ4ODf4u
         EoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729588734; x=1730193534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktUntblqwbX11lE4VFhQvbDpXlY5dHHrgSDM8lr7qU8=;
        b=kR4UQn6PePfLtaeMyTMDZPnQxtx3NCKLBQusmwWlh0ZpD4SIvTVPTYkxw8vz+gK6od
         NlZ4oRTngt/Hwm20eYAnLfG8fXy75XDSrvxA6rctzfiEgER8r9MLWyIjekYrwXlCgUlh
         PFmn3vCiiaJV2Y2F1hsX7m0d/zuRN3GFkZi6fiGRELwdkMW8489Ih25C2VIgZ2q7/Sop
         W0/cRHgsE02p0+9HyeyVe/Cw0fymi+LDWbQTFwHIijHpn/cGttGeO6Z7sonnwHqox9XG
         wGij7hOgqMVRvBWj1RFWDM9t+QXa6dPWti5o1syoZ1Q/wwJF13PECma0btNU3bz9lDze
         slfw==
X-Forwarded-Encrypted: i=1; AJvYcCUER0JRFobSThHTRk8VOg3qTBSzDkT02zjciCo6KDyyqZJomQoM3mery0rVd3Y1YM5dMq/pw4Jpd7PL9aWRby8=@vger.kernel.org, AJvYcCVsw3acpT/lPUThzKoy8zzlh7xGpc3Bxk3lkFSeHEEBzXTOvVy5GVTRp1gVkuuN3PKmWlmh8BQj@vger.kernel.org, AJvYcCXljo9jgp0f+Od212AsJfcAH8Ez5/4H0DXPSMC6TZ/TOyGs/XIqfqiil0i/H5aoaHYsq1QFgN+0R/336GV/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4fr70pA8UuIjzIfZI+GwgY7x4vCJ75RMCnYnuRmCImsv2XCmm
	lhsoDrZj4bLwucoiSZkxAcfu+mFdXLs2IJ3sWHKlx2UvWshE4OMaWFvkMtiKst5SKifzgmpF1uq
	DUFQy5+2AovzwmI8mRZmN/RAHaaOGv9al2tw=
X-Google-Smtp-Source: AGHT+IFT5NKjcwFGWBwUpT8dc+RxKHbxg2bHl0QeeeMrYyjueQBanQ3EjdvlH7HxVnRLfDQObus8JJ17e5hMw2M7/mw=
X-Received: by 2002:a17:907:7293:b0:a99:ef5d:443e with SMTP id
 a640c23a62f3a-a9a69773b2emr1500723866b.13.1729588733544; Tue, 22 Oct 2024
 02:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021100421.41734-1-brgl@bgdev.pl> <bb705eb7-c61c-4da9-816e-cbb46c0c16e4@kernel.org>
 <CAMRc=Mcp4LBj0ZZx=hUg9KBk04XXcAtiNv+QjQesN1iCpDC+KA@mail.gmail.com>
In-Reply-To: <CAMRc=Mcp4LBj0ZZx=hUg9KBk04XXcAtiNv+QjQesN1iCpDC+KA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 Oct 2024 12:18:17 +0300
Message-ID: <CAHp75VdLuxL4tqodoiWE_Pq7VjwxVLa-mXnnnOT-j8W=3jetCg@mail.gmail.com>
Subject: Re: [PATCH] lib: string_helpers: fix potential snprintf() output truncation
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jiri Slaby <jirislaby@kernel.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Greg KH <gregkh@linuxfoundation.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:30=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> On Tue, Oct 22, 2024 at 9:15=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org>=
 wrote:
> >
> > On 21. 10. 24, 12:04, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > The output of ".%03u" with the unsigned int in range [0, 4294966295] =
may
> > > get truncated if the target buffer is not 12 bytes.
> >
> > Perhaps, if you elaborate on how 'remainder' can become > 999?
>
> Yeah, I guess it can't. Not sure what we do about such false
> positives, do we have some common way to suppress them?

I already pointed out these kinds of warnings from GCC.
https://lore.kernel.org/all/Zt73a3t8Y8uH5MHG@smile.fi.intel.com/

--=20
With Best Regards,
Andy Shevchenko

