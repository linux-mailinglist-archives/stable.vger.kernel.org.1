Return-Path: <stable+bounces-35925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87BC898731
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 14:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BAC1C2237D
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 12:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFDA128379;
	Thu,  4 Apr 2024 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CEQ+1Vah"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3860786634
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233235; cv=none; b=Jz0lvO41bAgHk0rdQNC94C7rpVIp3p/gZ1sjHgfXAoTJzibi8l+m0UerqRQOqEuyqf58hFN111RPNUWZNOOR8iymCDEKY3yCY+TRr4RQGZTAlFRiVGixSSBjNFZpucokHUJMOx/vYhu+0vxe1NcpmNQD6k8Dv50Hd0v3nYPhVLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233235; c=relaxed/simple;
	bh=H3f5IYJ1QWgMCxp8QqRnm74odB6YZNBaYMyZ5mE9B8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vADGXZAe8hrdA/odoBvNrLBCcEfCQarFzaMiua9/v6eISl+b/bdxd87JGHFyXP5hyzDrRYhBmZ1328RjS/wcLUXUrSFR6Jxz2SkHiu1IBpqIpxaKeUmh2XtfDke36wGkjWnDMXUFDwTu/I7XV33sXzRcbBwtTKgIBe3p/Sw4/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CEQ+1Vah; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516cbf3fd3dso754710e87.2
        for <stable@vger.kernel.org>; Thu, 04 Apr 2024 05:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712233231; x=1712838031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUbfvRaTdYI6FJXs+PUDsLKnWz2I5THsnSsWjhmBFSg=;
        b=CEQ+1VahHY1lnHONUcj2WZxOs6Qkp/iF0KkGR/SZ1mL2VsVRudtZAR8laVgyetoym0
         uD4x4KSK59RSy8umCfC5v4WN4lqKep7557O3xU7+jsDSCMlgCNvAqjIGOsgEGh5o1jgT
         7Hx1eBySF4pWlM/uClIfHE/7pz2sGTgc5cQoh1y7adb9/tg6e5vh8fgc3fgpLNpPLR3H
         YAR9V8qqF/33Kcs/P63IWE7bFNjbH+EV9PQw6NnJdLuv1s82+rDJhhJNfPP92enfetXa
         mSfcaw6Ar4jcFjcBfnt+JEijmLotomS2JCLUDF8KYwkyKhdrGp/jKan2j9lhOUd2La0v
         vXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233231; x=1712838031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUbfvRaTdYI6FJXs+PUDsLKnWz2I5THsnSsWjhmBFSg=;
        b=e1X8lPzvfCZmnhiKfmdPIMeljMIRF3JiebbOsDb7ECBhuKnLgkXbfPVRPZAT//DYsV
         dwqU9wYhVen4oH+lJvucOsDeemVSxu7OVSxu9VQmYhT6HQEoexuVNw+4+0IYJk1pt6B6
         Lrv80Vc4vwHCoetdKneTBLPl+7GDDjTrEv++eIM9UuhjvLnAwPjEBv1NRs3wTbcHfjN4
         P0yRJvdpmHLPTs1suA3J7w4kt6MSf9lAR/BvoVNleoaeKoLXgTr3RkBMmRASmqBRv719
         jGWBlmCpxUtILwAFMZXLSt/a0K4uSO3rBvna0+aYtRSuKYVvNKrjdGTnZxeeaeHnuNkI
         x96g==
X-Forwarded-Encrypted: i=1; AJvYcCX10sG8KBibjEcNu6r91zwCrcM90r/bdVtmuJvz4ALGxRwxmHYNZxTT5IsaOlAH+C0lyEUZ3MARZZjrF94Jr7V7cwt3zRgc
X-Gm-Message-State: AOJu0Ywh+vxrQY/SG+0DfbNiUYIM0PQ2Thm7wqWpJb7ZtiXJUnSf5/RH
	+ZNbSVYv8lEo0q8eSU1jMuxSzdITRg3jBpWqyG2In1H7Zr2BdWKb5lpWLh1hjqIZ1guZzeHBsRv
	S/6NQZL9cesIxxcGcGI/ecoUIJnv0fulAC10M7A==
X-Google-Smtp-Source: AGHT+IFXuY19yD67Vs0YeBOAYv5IS0ycYwSWTF9HWesGz64hK8qtn9PkV2yqkWQlXtSA4rvLO2hBr6dSTjjx6khY+oo=
X-Received: by 2002:a05:6512:60b:b0:515:d038:5548 with SMTP id
 b11-20020a056512060b00b00515d0385548mr1623137lfe.31.1712233231216; Thu, 04
 Apr 2024 05:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403131518.61392-1-warthog618@gmail.com> <20240403131518.61392-2-warthog618@gmail.com>
 <CAMRc=Mf0DPN1-npNPQA=3ivQd-PMhf_ZAa6eSFjmQ26Y8_Gv=g@mail.gmail.com> <20240404105912.GA94230@rigel>
In-Reply-To: <20240404105912.GA94230@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 4 Apr 2024 14:20:20 +0200
Message-ID: <CAMRc=MeOW6mcYFR6GL5c0hyfH_ZvqmLqKFSk50jKa-d+4aa4iQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: cdev: fix missed label sanitizing in debounce_setup()
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 12:59=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Thu, Apr 04, 2024 at 10:20:29AM +0200, Bartosz Golaszewski wrote:
> >
> > Now that I look at the actual patch, I don't really like it. We
> > introduce a bug just to fix it a commit later. Such things have been
> > frowned upon in the past.
> >
> > Let me shuffle the code a bit, I'll try to make it a bit more correct.
> >
>
> The debounce_setup() oversight bug is the more severe, so it makes more
> sense to me to fix it first.  But then I my preferred solution would be
> to pull the original patch and submit a corrected patch that merges all
> three, so no bugs, but I assume that isn't an option.
>

Nah, let's not needlessly rebase it. Most I can do is merge the two
but they are really functionally separate so I'd keep it as is in v2.

Bart

