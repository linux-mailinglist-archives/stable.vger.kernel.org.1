Return-Path: <stable+bounces-17597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED68845AB6
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 15:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593471F2AB57
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 14:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338615F48C;
	Thu,  1 Feb 2024 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="VJ8KMQVK"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D76044360
	for <stable@vger.kernel.org>; Thu,  1 Feb 2024 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799521; cv=none; b=iE6cnoGcPRAiIDT6HdsMH/5L2KxBfiNUKwi/nM5sJ1pAWrV3S8FvLxNMeuS149jFuoSMTWavze94HNqceo7S3g3Gl2mt6MAXyml6BJLulkIp2f7hJfFGHJeEcOMwl+gwuN4VgqbIv2m+GcIleuVBv36/49seX0fOjP8dgtqi4Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799521; c=relaxed/simple;
	bh=6cQNP6TfDmd/3HC3Btlnfj+skXdQYDQjZQxFx0JIFYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2d/BWq/CgGl16hpnbTzoBuPSodz5KZEHM1t9ZA7YO+hA9kK+X7DyjiMyhU0FkThS4sgUmSaHPL+cQLb4myav0EM1+Obr25ddnXpoPyxdQ7b6mIh6ZsNlms3am6iITvKdx6k7d3+90ooZHu+6ITjdY+mWNV/Q3dB+OQ92Tf+4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=VJ8KMQVK; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36396ae2361so4151955ab.1
        for <stable@vger.kernel.org>; Thu, 01 Feb 2024 06:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1706799518; x=1707404318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dU+MsCzscQ6UONm8tpF2vrsbrHPrj73OELKoVqq4DUk=;
        b=VJ8KMQVKT281W4GvgBMFvxm3rTbVvqVBxZE7XMGoLIHmsbdsFVFWZwSKr7ulFcbLTk
         2SI1SaDbg29wRjUNDaWTDNf30Df664sn/sbjwksHVM+rXmJ1SQybbqtEx+1E2SgWP8i7
         aoPHNrXv9cQdrC6G7A2Lsdqhx1mFC2Z4XPyh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706799518; x=1707404318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dU+MsCzscQ6UONm8tpF2vrsbrHPrj73OELKoVqq4DUk=;
        b=wJfwhs0LR5KczAbVHYxrve3iBqrZE0o2tuLRNsJZLnfvFzVCeR57jK1NJ4nVdlPgiJ
         yF7LcYtW09Bg16zz7vyqRcAG2IzuO8fNwf539q6KW/AaXhqzhBhlBhcSJbehcm3kbWhk
         uqZWyoB7jZvQeoDYpdy5nno5LdVyce5USjRCMBcuEuNwsVxjc7aYN3S6Ar4rBD2h0q5X
         YR/L24cFVx6f3VqC8d/l35v7odMHazxf1RsGQkXD1GasU3bGQ6sJlHEy7TeDlJ3RKl/M
         7CLXialJroF4aiJaOZO2MxWzPK8q7oDqZmSLe9f0agjdnl76S787A60pe0T7H8PCy2xu
         QJIA==
X-Gm-Message-State: AOJu0YzYcL+qXK7MsFgHZgWrxGrplHW0B/ICqbifmn/aHKzXoVVy0rQx
	s7ntjKBF58CQI4q+11Wy6qIyIbqT6ChXdhSnnHONliZdkY4VZgaF1Q5bburohEaNulUoT2EHw2j
	/fg==
X-Google-Smtp-Source: AGHT+IGzEp11y0sgvJtC+OgJ+QW8VgnEfCHGkY9+5QyJtutsDGqC04Spkzq/FCuwBbcMYbb01JBebg==
X-Received: by 2002:a05:6e02:e14:b0:363:7a5c:c349 with SMTP id a20-20020a056e020e1400b003637a5cc349mr5450039ilk.12.1706799517798;
        Thu, 01 Feb 2024 06:58:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVh6kwOcdn8TnM0tkD4St+iN1FYI7uJnouRbJIlCLOCAS80j/w341hPNg/G4m7vYPvq+37lRrImCON6yyTVMRvW2A/P9KRt
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id db10-20020a056e023d0a00b003638f9a9debsm442731ilb.75.2024.02.01.06.58.37
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 06:58:37 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36396ae2361so4151805ab.1
        for <stable@vger.kernel.org>; Thu, 01 Feb 2024 06:58:37 -0800 (PST)
X-Received: by 2002:a05:6e02:10c:b0:363:7f00:8072 with SMTP id
 t12-20020a056e02010c00b003637f008072mr5640322ilm.28.1706799517108; Thu, 01
 Feb 2024 06:58:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129170014.969142961@linuxfoundation.org> <20240129170015.067909940@linuxfoundation.org>
 <ZbkfGst991YHqJHK@fedora64.linuxtx.org> <87h6iudc7j.fsf@meer.lwn.net>
 <CAFbkSA2tft--ejgJ58o3G-OxNqnm-C6fK4-kXThsN92NYF8V0A@mail.gmail.com>
 <2024020151-purchase-swerve-a3b3@gregkh> <CAFbkSA25o88DjaWHc3GRk5vkvANnpi-NJ61XJudz4=ARTyrhtw@mail.gmail.com>
In-Reply-To: <CAFbkSA25o88DjaWHc3GRk5vkvANnpi-NJ61XJudz4=ARTyrhtw@mail.gmail.com>
From: Justin Forbes <jforbes@fedoraproject.org>
Date: Thu, 1 Feb 2024 08:58:26 -0600
X-Gmail-Original-Message-ID: <CAFbkSA3M74kvF+v_URm593xSnJTVzeKmy2K6dw0WQYw7BDdwmg@mail.gmail.com>
Message-ID: <CAFbkSA3M74kvF+v_URm593xSnJTVzeKmy2K6dw0WQYw7BDdwmg@mail.gmail.com>
Subject: Re: [PATCH 6.6 003/331] docs: kernel_feat.py: fix potential command injection
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, stable@vger.kernel.org, patches@lists.linux.dev, 
	Jani Nikula <jani.nikula@intel.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 8:41=E2=80=AFAM Justin Forbes <jforbes@fedoraproject=
.org> wrote:
>
> On Thu, Feb 1, 2024 at 8:25=E2=80=AFAM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Feb 01, 2024 at 06:43:46AM -0600, Justin Forbes wrote:
> > > On Tue, Jan 30, 2024 at 10:21=E2=80=AFAM Jonathan Corbet <corbet@lwn.=
net> wrote:
> > > >
> > > > Justin Forbes <jforbes@fedoraproject.org> writes:
> > > >
> > > > > On Mon, Jan 29, 2024 at 09:01:07AM -0800, Greg Kroah-Hartman wrot=
e:
> > > > >> 6.6-stable review patch.  If anyone has any objections, please l=
et me know.
> > > > >>
> > > > >> ------------------
> > > > >>
> > > > >> From: Vegard Nossum <vegard.nossum@oracle.com>
> > > > >>
> > > > >> [ Upstream commit c48a7c44a1d02516309015b6134c9bb982e17008 ]
> > > > >>
> > > > >> The kernel-feat directive passes its argument straight to the sh=
ell.
> > > > >> This is unfortunate and unnecessary.
> > > > >>
> > > > >> Let's always use paths relative to $srctree/Documentation/ and u=
se
> > > > >> subprocess.check_call() instead of subprocess.Popen(shell=3DTrue=
).
> > > > >>
> > > > >> This also makes the code shorter.
> > > > >>
> > > > >> This is analogous to commit 3231dd586277 ("docs: kernel_abi.py: =
fix
> > > > >> command injection") where we did exactly the same thing for
> > > > >> kernel_abi.py, somehow I completely missed this one.
> > > > >>
> > > > >> Link: https://fosstodon.org/@jani/111676532203641247
> > > > >> Reported-by: Jani Nikula <jani.nikula@intel.com>
> > > > >> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> > > > >> Cc: stable@vger.kernel.org
> > > > >> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> > > > >> Link: https://lore.kernel.org/r/20240110174758.3680506-1-vegard.=
nossum@oracle.com
> > > > >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > >
> > > > > This patch seems to be missing something. In 6.6.15-rc1 I get a d=
oc
> > > > > build failure with:
> > > > >
> > > > > /builddir/build/BUILD/kernel-6.6.14-332-g1ff49073b88b/linux-6.6.1=
5-0.rc1.1ff49073b88b.200.fc39.noarch/Documentation/sphinx/kerneldoc.py:133:=
 SyntaxWarning: invalid escape sequence '\.'
> > > > >   line_regex =3D re.compile("^\.\. LINENO ([0-9]+)$")
> > > >
> > > > Ah ... you're missing 86a0adc029d3 (Documentation/sphinx: fix Pytho=
n
> > > > string escapes).  That is not a problem with this patch, though; I =
would
> > > > expect you to get the same error (with Python 3.12) without.
> > >
> > > Well, it appears that 6.6.15 shipped anyway, with this patch included=
,
> > > but not with 86a0adc029d3.  If anyone else builds docs, this thread
> > > should at least show them the fix.  Perhaps we can get the missing
> > > patch into 6.6.16?
> >
> > Sure, but again, that should be independent of this change, right?
>
> I am not sure I would say independent. This particular change causes
> docs to fail the build as I mentioned during rc1.  There were no
> issues building 6.6.14 or previous releases, and no problem building
> 6.7.3.

I can confirm that adding this patch to 6.6.15 makes docs build again.

Justin

> Justin
>
> > thanks,
> >
> > greg k-h
> >
> >
> > >
> > > Jusitn
> > >
> > > > Thanks,
> > > >
> > > > jon
> > > >
> > >
> >

