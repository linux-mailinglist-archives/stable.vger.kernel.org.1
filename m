Return-Path: <stable+bounces-60712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21D79392F9
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 19:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6743C1F223A7
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604BA16EB6F;
	Mon, 22 Jul 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL5mRUL4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921AFC2FD;
	Mon, 22 Jul 2024 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668276; cv=none; b=ldblnqcweoUdM14YwSaSySRvVMnLr3X+8qRT5I2T0sm0vCF4n2H8Ri45ylucpNJJhCh78/5GdizEf1hYbO77SV8w4whk7jYChuoXbUIG4+mac/Ye0ZsSydFOJlBLrB0MzWd2nhIiJPnSVk+qR499gstminIHunBLYAyFPGQ7gnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668276; c=relaxed/simple;
	bh=CXBh8LFTmCrFo3O3jXXkAATuZ9qWv5yVnqNpJJjcWcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmHXodHwWEmiJCIp1CQIH40LFEjViMaHgQ7XYgB4uTJFHHOlBcvcqMLrTlNF1zKPMI9skPLz6w1sCJmljt47cr4UnjPmzpACNOlBXf7AF6B1nQohL8cZg/OpRe1seg27LngSN18SYTzLQzS42l2zSqIPTj3KmZx1R3u+sAYS5+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mL5mRUL4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4279c10a40eso33298825e9.3;
        Mon, 22 Jul 2024 10:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721668273; x=1722273073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfBt7EurseGXYsoA5Am2BgLzNyvZGNlVYktkOB++CV8=;
        b=mL5mRUL4qYVhdaSN8SmtgCpMFXALrTbXx1aA+cRdBRjROhybWQhsiZ5FNUwNnLipOI
         R//BYJ2YVE0g3brT0AElAj+F5hU7vvd+Itk0a79QfvLvHr6ArZ+iKtmt2W7XnAUxCvHF
         4vC1H/FjPxKfQPgNaabkkfk90lEfiv+wci9dX31kvXf4JD65szM2SvnCIddxBPi3oz5y
         PUrPvFAeH0RVS0AYK82IdFXwBdeVGXj7hyGKDu7eHC5PZSj+rm4LItBWXEbSxbmlqI1O
         5DVZQRDwfvnKDpGu/IrlS087SJfoVWrR3u8ofRv590QMn17iMnFVvSfNNkOKQTv34+E8
         8Njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721668273; x=1722273073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfBt7EurseGXYsoA5Am2BgLzNyvZGNlVYktkOB++CV8=;
        b=KI1yVEi3x593o+p0E4mr3oNubtDZp6OcW57XIBb047Xg1jsr/AoyxGsMPdIc14nXSk
         c37a84L6uqhbR6RJw6cezMF2VMSjBxWTkCR0YbH4qkFFIyUL5SJNEbw9JgDhYnJb7IrZ
         AYMMKFc6BLW6RSkwXE9ENmCYFQmFkpwMY3Ptq+ni0mBdqoJ8a8IC1ZqYo0nCzETcVjR5
         gg2eCSBkSTsKqUaKiFv2LIBUxZ8dCIRou9tuNBGiDZzex1amx6c273ZVF/1eFwCeTUXS
         l9Nt3eq6D0b6DHwcE27vpKLTaVuxkVJiK8lcQwL18ofs4OsEB2U6IobJ1d6e8NUyHHlm
         WD4w==
X-Forwarded-Encrypted: i=1; AJvYcCVL0Qfp4TXTG1DTPzgH0j+zCZC7by7Msa7h6jeW5NUjHr1h5/GKW239kz2BQOCDPgo/4LXxzOd1xoXsY/seo38qI5ZLTkHYIElpIGngBNCXmpOER3HECBIreeoVYpUPmxqhZEx6
X-Gm-Message-State: AOJu0YyQTUtyXhVm617ZsATsiNt6LHHfM54m27dn6zA2sUnHGTlkodwP
	0RvZa7OHYvgPvsaS5pekYLlhjI2q8R3JHFY4pX8/ra1x7eRL+RZmOZHEroQF7l6/V9uJ6lPUklz
	BhQ4WT68l2yUHa7BBWYRK8hrATrE=
X-Google-Smtp-Source: AGHT+IGTzxUv/FX5sa6ydbtvPdM8kuzOuT/RSsIxMbrBNtwenw401mF1FVn9AiDPUcfG3bAbS96SPPuKAfI2rcyJTd4=
X-Received: by 2002:a05:600c:470b:b0:426:6e95:78d6 with SMTP id
 5b1f17b1804b1-427dc516017mr48785615e9.4.1721668272647; Mon, 22 Jul 2024
 10:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240721192048.3530097-2-crwulff@gmail.com> <29bc21ae-1f8a-47fd-b361-c761564f483a@rowland.harvard.edu>
 <CAB0kiBJYm9F4w5H8+9=dcmoCecgCwe6rTDM+=Ch1x-4mXEqB5A@mail.gmail.com> <b35e043d-a371-4cf9-b414-34ba72df1ccc@rowland.harvard.edu>
In-Reply-To: <b35e043d-a371-4cf9-b414-34ba72df1ccc@rowland.harvard.edu>
From: Chris Wulff <crwulff@gmail.com>
Date: Mon, 22 Jul 2024 13:11:01 -0400
Message-ID: <CAB0kiBKDB=1kF4YRXckph4QG7tQbDdBMsOtcQh9+p1jtyokdPw@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: core: Check for unset descriptor
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Roy Luo <royluo@google.com>, Krishna Kurapati <quic_kriskura@quicinc.com>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, yuan linyu <yuanlinyu@hihonor.com>, 
	Paul Cercueil <paul@crapouillou.net>, Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 9:38=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Mon, Jul 22, 2024 at 09:00:07AM -0400, Chris Wulff wrote:
> > On Sun, Jul 21, 2024 at 9:07=E2=80=AFPM Alan Stern <stern@rowland.harva=
rd.edu> wrote:
> > >
> > > On Sun, Jul 21, 2024 at 03:20:49PM -0400, crwulff@gmail.com wrote:
> > > > From: Chris Wulff <crwulff@gmail.com>
...
> > The previous check was also hiding the error, and introduced a panic.
> > I could add a printk to that error case, though it would be unassociate=
d
> > with the gadget that caused the problem. This function does also return
> > an error code when it fails, so the calling function can check that and
> > print an error.
>
> Okay.  It wouldn't hurt to print out an error message, even if there's
> no way to tell which gadget it refers to.  A dump_stack() would help in
> that regard, but it won't be needed if the guilty party will always be
> pretty obvious.
>
> By the way, how did you manage to trigger this error?  None of the
> in-kernel gadget drivers are known to have this bug, and both the
> gadgetfs and raw_gadget drivers prevent userspace from doing it.  Were
> you testing a gadget driver that was under development?

I am working on adding alternate settings to UAC1/2 gadgets, so this really
was a case of trying to make the failure in development easier to deal with=
.
I don't believe there are any problems with existing gadgets causing this.

I will add an error message and submit a new version. Perhaps
WARN_ON_ONCE would be appropriate here to get that backtrace
instead of a printk?

>
> Alan Stern

