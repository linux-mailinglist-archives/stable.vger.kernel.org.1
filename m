Return-Path: <stable+bounces-91817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 304A49C06F4
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 14:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8014282FDA
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 13:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26D520F5C6;
	Thu,  7 Nov 2024 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coBCSr1N"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E3A1EF087;
	Thu,  7 Nov 2024 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984961; cv=none; b=d6pfpH0GEOX0noA3WBRQz4NuJrr1uTpQcbijsv6TjIrnXv+/wv/8B0hPWaOw6S7aRKT+MT0l8L65kSddcUxK++5bjvl+rVvnHp6T+lUIRhR1+mQd2KsD/hGNx4TwJ64c9SkHXE7GXS1rTAr/iiwtT7Ud87f9Xv6pmyXHROb7myg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984961; c=relaxed/simple;
	bh=ndYeiWWQYLtL7TF3TcK62YMSZ1lDWFKJazxfBAVTPlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0bN59hyNEwb8i4qt9+gyjBSOtoe57oHjvvYwM7CIAlImj7N4EMGOSThNkezFxR5UXGmcuv0zcsQ/iicmDahcV90GL4O22zbwNe+6RPIMJgkrJwIB9H18Zla5v6KGyMvNd8/GFr1sUiN5/3LzR+aFTh5BRSpS3YKhWieJxLLi34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coBCSr1N; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so3597225a12.1;
        Thu, 07 Nov 2024 05:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730984957; x=1731589757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/6wp4Vr/2hV/oyu+TDytxISxtShsM2Q5KzogwygMg8=;
        b=coBCSr1NoeGx2euv0ldNzezgadzWtiivvmqsoRkZWA1ffXZQfu8AUvZDY5ktB+t/9V
         dUmhuVi9rDQ5DIk2KZC/VxTasSA/07SL2w7EABK8MHUxk4Ff95MassTGP7VoDvMB0l0Z
         UOtM1Xlaf2L4hK+mNVbNAdzpUcxF/atHmWyzgPxJc/1qngF9LqNdUYHSg8PRShtm1uti
         MngezW+dQP3JGv1GY8Ud2aA26a+wlkkYHJzpG1DV8oN3GgHimA8dzoyB56GXZ9owQYYh
         HwqTF837jxwWESo/QrUfy7nUOfliAJ42b43AwQntf294HU1iRlF9c4BtByiRuWlgU39A
         jsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984957; x=1731589757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/6wp4Vr/2hV/oyu+TDytxISxtShsM2Q5KzogwygMg8=;
        b=nQ9A11sj0q7l0E54ujBZEXANhW5yZDbYnoqrTdtXPCE45VFVjUpVcoNe1Le6ZBcae/
         Z5NZsAaH/lFfdYsZ2tSQbzD48ZZ8SWP6TDrixFxDXKLOplvDRtX0Wqiya/tz+72OfSXa
         i0hQShGj09XQA4K35lerEnN9FTZ30rg5KHLXxkvxMwp+bVCK2G/DRjxEQ2WwSkfMWTWd
         x/9awbmpazWOoxSszVVrlU7F3Yptvs5TayDFs178hO1uOZli8HI3yfhkRbaQqivhNkAK
         Hyffs6yAopbuMFojltJVNXKDkl3VD5GdZEzjV3I8U3ciwuYl5bQ85oy7enV6/h+t1Nhr
         4XSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUadaitpbK6v64arlpjtONUGxwNg/kNDNXdlKns4UWCSczYvicVFt+UoawhOKpZC+aY9aByHhng@vger.kernel.org, AJvYcCUinWfes4gS+C9Vl0OxrpBlaVCLfxnNY52pSU2Y0q/DIJhk7c2h3O2T1p5P7qQHlPTLYaD74SIOh7SP3NA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVaDhFK2fpjf9laK5om/iXVjuT+fE1Y1V9ZP+muoQaT+HJ86/i
	UjtoNAuJDnwBBQyobZb1eL5rHahVSATIc9UqboTpAJghBuSzvHLXVhOI+R73KO6OUiUQdnAmvKj
	66LG6YFm8+ZCgd8bry07N5740POu7PKBlzhmyQTnP
X-Google-Smtp-Source: AGHT+IHMRqAMb9qqvjoZV614aRHMfqr78BddJOQ4xmoEAJatsbpYvBBe3NjyU9djOgo4/3zKeZh4hspP4AJB2HRzio8=
X-Received: by 2002:a17:907:843:b0:a9e:85f8:2a6d with SMTP id
 a640c23a62f3a-a9ed4c92521mr298548166b.11.1730984956797; Thu, 07 Nov 2024
 05:09:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107124116.579108-1-chenqiuji666@gmail.com> <00d84e12-4c14-4a6b-a5cd-83d81ac90855@redhat.com>
In-Reply-To: <00d84e12-4c14-4a6b-a5cd-83d81ac90855@redhat.com>
From: Qiu-ji Chen <chenqiuji666@gmail.com>
Date: Thu, 7 Nov 2024 21:09:05 +0800
Message-ID: <CANgpojUf53ncbYqQRmfMG6R9WYQHSyPGU=LkWVK-MonNDGa8gQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: fix a possible null pointer dereference in setup_zone_pageset()
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, the previous patch did not correctly check and release the
relevant pointers. Version 2 has fixed these issues. Thank you for
your response.


On Thu, Nov 7, 2024 at 8:53=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 07.11.24 13:41, Qiu-ji Chen wrote:
> > The function call alloc_percpu() returns a pointer to the memory addres=
s,
> > but it hasn't been checked. Our static analysis tool indicates that nul=
l
> > pointer dereference may exist in pointer zone->per_cpu_pageset. It is
> > always safe to judge the null pointer before use.
> >
> > Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 9420f89db2dd ("mm: move most of core MM initialization to mm/mm_=
init.c")
> > ---
> > V2:
> > Fixed the incorrect code logic.
> > Thanks David Hildenbrand for helpful suggestion.
> > ---
> >   mm/page_alloc.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 8afab64814dc..7c8a74fd02d6 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5703,8 +5703,14 @@ void __meminit setup_zone_pageset(struct zone *z=
one)
> >       /* Size may be 0 on !SMP && !NUMA */
> >       if (sizeof(struct per_cpu_zonestat) > 0)
> >               zone->per_cpu_zonestats =3D alloc_percpu(struct per_cpu_z=
onestat);
> > +     if (!zone->per_cpu_zonestats)
> > +             return;
> >
> >       zone->per_cpu_pageset =3D alloc_percpu(struct per_cpu_pages);
> > +     if (!zone->per_cpu_pageset) {
> > +             free_percpu(zone->per_cpu_zonestats);
> > +             return;
> > +     }
> >       for_each_possible_cpu(cpu) {
> >               struct per_cpu_pages *pcp;
> >               struct per_cpu_zonestat *pzstats;
>
> Unmodified patch, likely not what you wanted to send?
>
>
> --
> Cheers,
>
> David / dhildenb
>

