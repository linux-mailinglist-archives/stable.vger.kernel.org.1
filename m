Return-Path: <stable+bounces-52233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048BA9091EF
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 19:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906C9282780
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 17:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C486482DB;
	Fri, 14 Jun 2024 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aqad9p7x"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A84F19D89C
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718387137; cv=none; b=nzMBV9N4jAWfJe+7I7lN+lGmDMCbLyP/YggQ2y8opU7NoG84KWSEyeeMfKhsud3fLa3ZI7iLucv6iaUtNSCjD7NSIXTY6N55JDIy7sNP4D/74qwoVE3hsA4RxtL/u3G/V6hIA7vIhZz3d+escdMoSVFloaUGEpGJU9cTt4nyupk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718387137; c=relaxed/simple;
	bh=DGIl0O3Tvpb8O2/F3T0MuCBwEikleKsZWYWGtAXNEIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=on5t2HMWcAqk6P96TqIio897mLFKNEiGaxMtp5RSy1NhMGsKYxvN8KKDQ2eShCMz10/+FSia1kbUPA0V6xwiQjjHwkSyEzmE/WFiQmQgyFwoEzjxtSCAOzdsBtyrkWkcSqgnr/ZhXL2VZ3cP6q0olSGUyg6BfpAk4GFVU5g1ySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aqad9p7x; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso2925591276.0
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 10:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718387134; x=1718991934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGIl0O3Tvpb8O2/F3T0MuCBwEikleKsZWYWGtAXNEIA=;
        b=Aqad9p7xE7MOAIFiePqPzywRqNNiavMq5Gynh3tAzYbEGsxjzxjY1isgBWB7T/vTmp
         52eIJTF3vFlMWiz044B5dandbN+j3r/wTX7y5LhyoSqvaD/LZRxx3+4m3dB+gNIdcNhc
         THP5q65SdOuPqUGLyAaojnZhfaxRHuBf9F8Kt+K/6PWIO8a31FnVIwtXZzgENRQUKGIZ
         7C+6jGFQhSW6az+jFMsHmv4RinhgXqbc9XWLXsHZyFXISZSTn455Sxivgf8b0aCGjAoi
         SGVQ2Y6JdB01s3BIlrblDJSXWMdLEt2/g/qfNDVyAy94XAGdVoRazHZoKHLjNrdgXhg0
         OApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718387134; x=1718991934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGIl0O3Tvpb8O2/F3T0MuCBwEikleKsZWYWGtAXNEIA=;
        b=jKhchTEL/HgdIo9a0hk8bmRtTHIrhEAX2Ryr8I7CikFNpTAmEnyWjeLXhlVcmAc7Nx
         pzEa5k17YSs8r+No9W4rrmIoYK6TlX6cyrgV/tbkTuvTOsawMDjkCKOohGeaaMojM3Th
         594hUgkuIIRJcXKlUS981SgITIS7lFarqH+b6vAG+xtuRmP33zRSTRljMVsjHRFCl1jl
         B7s0Gw38n+9ksZEuoXYANzy+zslL2zuF5Avf2i2nEPVBH2tiV3f6hdbePEve4YE+KrAI
         QOgZ7UXJR1+beJmCYZCyCwF7pIn+LDWLocmFyNmx6JEgmr6CQyGP31Xgv7Xm4WYw3rRP
         Akdw==
X-Forwarded-Encrypted: i=1; AJvYcCUY4+Wfr5syujAVAVzPR88PQ9xRfhtRCHnLcWqJv/vgvV2C7Fwfl1CZmNeMzIftJCWN2TTzCfYzGDZp8TbaUYMeYIxUdhCa
X-Gm-Message-State: AOJu0Yz/PN0iyRgEwuZNlj0B4Ajl0lSXag0drG0/z9IAdv8uBGrfJ2yc
	V8cNoadUyJdtWIFUfL0YIgSDErKsT7SizRjlLEViYIRAXkqkB0M9SN6Bk8/4AQz9fr8/bbsrXMe
	xnlM2O/ARQK6q9+AHLBUZwRzY/BQ=
X-Google-Smtp-Source: AGHT+IF3eAYDsL0RP/CUOqmdHO5As+bjEt8y169LlWphxmzycyE1r42304sTuprAQhDehWn9rtMUhfYHEr5egZaVUVg=
X-Received: by 2002:a25:86d0:0:b0:dfe:f4e3:72cb with SMTP id
 3f1490d57ef6-dff153d56d0mr3133644276.27.1718387134354; Fri, 14 Jun 2024
 10:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACzhbgRjDNkpaQOYsUN+v+jn3E2DVxX0Q4WuQWNjfwEx4Fps6g@mail.gmail.com>
 <87zfro3yy5.fsf@gentoo.org> <2024061400-squash-yodel-4f49@gregkh>
 <87tthv52ka.fsf@gentoo.org> <2024061411-jalapeno-avatar-5326@gregkh>
In-Reply-To: <2024061411-jalapeno-avatar-5326@gregkh>
From: Leah Rumancik <leah.rumancik@gmail.com>
Date: Fri, 14 Jun 2024 10:45:23 -0700
Message-ID: <CACzhbgR36=uVNO+k0kxBfeF3YmvoF+UxA06We6r18tCUV9hdtA@mail.gmail.com>
Subject: Re: [PATCH 6.6] backport: fix 6.6 backport of changes to fork
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sam James <sam@gentoo.org>, stable@vger.kernel.org, 
	Miaohe Lin <linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

After some more investigating, it seems while the original patch fixes
a race with hugetlbfs, it creates an issue for vfio which results in a
WARN which will fail xfstests when they _check_dmesg. I have been able
to resolve this on our kernel. Today I'll check which upstream kernels
it is applicable to and send out fixes where needed.

- Leah

On Fri, Jun 14, 2024 at 2:08=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Jun 14, 2024 at 09:52:21AM +0100, Sam James wrote:
> > Greg KH <gregkh@linuxfoundation.org> writes:
> >
> > > On Fri, Jun 14, 2024 at 05:55:46AM +0100, Sam James wrote:
> > >> Is it worth reverting the original bad backport for now, given it ca=
uses
> > >> xfstests failures?
> > >
> > > Sounds like a good idea to me, anyone want to submit the revert so we
> > > can queue it up?
> >
> > Thanks for the nudge, I wasn't planning on but why not?
> >
> > 6.1: https://lore.kernel.org/stable/20240614084038.3133260-1-sam@gentoo=
.org/T/#u
> > 6.6: https://lore.kernel.org/stable/20240614085102.3198934-1-sam@gentoo=
.org/T/#u
> >
> > Hope I've done it right. Cheers.
>
> Looks good, I'll queue them up for the next round of releases after this
> one is out, unless someone fixes this up before then.
>
> thanks,
>
> greg k-h

