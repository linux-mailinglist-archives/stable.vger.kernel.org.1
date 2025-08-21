Return-Path: <stable+bounces-171935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD5AB2EA0C
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 03:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2CB1171A77
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 01:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846A91B87F2;
	Thu, 21 Aug 2025 01:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/WW3Luy"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932BC1632DD
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 01:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738497; cv=none; b=W8xEflLPZ4OREg+UwjHldoD6AVK+PeVCgALR99q2L2rOv1sHCu/YFwu6g9HjY5faiOx0Jb0bQPGZkVblnsNV/A4wMLy63znUfHYACD2LeNfxjSfmZ4sR+4D/PqSWmVLUcisU8fh5o2BWeHEqwU5AGTdE9hvoETQwBxI6BRZKSpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738497; c=relaxed/simple;
	bh=8kTU1n+xaCdto/irG3ILeQHG8Yy2ik7dXsDiYP3zOhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5ZRxK/hv9P6StDGu87auldJG0WcBxM02RgP74Ium2TELiGxcXc7jnLECbZ6UVQXHZbAxAGiWbLrRZk87YKsA4mc0BbK3/yV+K+Ydl47RWqJ9xkLvGPyPUc4oBZ99mikSUcDwhx1Rp5/LLzF0GIOAu1DTZrdkgOLX7BtZGF7USE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/WW3Luy; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-61bf9ef4cc0so260019eaf.0
        for <stable@vger.kernel.org>; Wed, 20 Aug 2025 18:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755738494; x=1756343294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GokggVHwsWgtzvgyN/qEZFMv+f52a+8zLwqs+NYYW14=;
        b=Z/WW3LuyOxsFUjhelxi4vMbykIxckmkpBf5Pk1LDAwOVSQlVjXrYelFFV4lzKsVA8Y
         Sc3qnPIlZ1L6lXGFUA6+/pnVnLvn3a1GZwe2bqIuTPvCgsGko4vPztKpGf/uxt2HBflO
         XFtVqbtRLLIGDHPF8fDPX/lX3DqPc253p+AUcTO0EYmbs+AUV8k2govC1ICCkBUDBa4w
         UN6O33jPtaJJpB6wDof5KwEnC/QHeZgGL67wE+BCS8UQd+mf38aMtoa6MeLonW+Ne4QE
         lJrGU1GqDdzEWt7ip2ukUCKLaR4cBqfc7txxuuyqvbnhIM2DwHKHFURo95NaMjozgGqt
         8Pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755738494; x=1756343294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GokggVHwsWgtzvgyN/qEZFMv+f52a+8zLwqs+NYYW14=;
        b=K3vcJMnGg5S/p0l23lmIpsfCb+Io+0MoGCmKG3yYEg6eW4EuZnFrlYAiaxpoey+SYO
         XnemrEn4IHxEcaEp04Jy17AUQKyrkVBFVpK25r0WHJzNPdCB8uBzxHLwiM8s4u+9sKDu
         +JuX6roGCOKuZlTRHcQx8X2Dsgx3ShyBPfwMcXoWYEOrSr/T/URgMsOPwRH2z0HERgsL
         i2VdD1pHX65YdKrEiYq2jSKbVfSq4kSW654bIcAmXTsnQeoT0/Kjw1sQf/EyfqZ1udqr
         6qcFrUst63V2IWf4T70w3ET8ma5P6pN2g7esinjDL9H4FhUE5/BoplU6LOWKLDjp4gQ1
         oNFg==
X-Forwarded-Encrypted: i=1; AJvYcCXa3XVQpSp+ThtI2HeGWij2dW2TpHVumkwvjSO/IQNmGhWuaY85oelncB6qMV6lVMEUMQ2Lk5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwePirXvQ7snaLARnpvb3r8McnzQhiKq0H3TP05ykiO/bWdYMg5
	ztk+36iiuOTUiUk7hs2bqf6HZ5y1eKhncoqMkm/IpuwV4hvDA8a6/JEfT/xCfZjkT+D7Yle4Tqh
	iAc+Y2Slh0hhwFl+1GSGjxgLy5sVGpl4=
X-Gm-Gg: ASbGncuq40z4Sq0S9bsnM8aWS0SgTugLLJZVx71kEXLS5F/fhnaRN/3quG4zU6U1r9K
	HVd/geUOzQ0db5gUKzm2JGfyTsjbJ5b10FQSnmNhqSQrKPLs8Uo29VnbiFJv785+ynq8QYlmJ1t
	hNUEwGho0/Rc9qGamuyBOSOMZiOcSQFlbrb6pA0E3CVoeJsGvwOuqD2pkjA/a8F1NcLIu50//oj
	DOkgWARTOmQErE=
X-Google-Smtp-Source: AGHT+IGMEq9pUyB7v0+w/oAnTu045iauyj+xCtdjs1ZA7QXJ8rtw+r/qDQiXoul2PqnBQyc4BEn2rmtyCs5i345g5Ao=
X-Received: by 2002:a05:6820:80a:b0:61d:a32d:610f with SMTP id
 006d021491bc7-61dab37e23dmr228323eaf.3.1755738494510; Wed, 20 Aug 2025
 18:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABFDxMHpodpNQM_a=T0vf48k486mYqukCVnQPbanLh+G_HH+9g@mail.gmail.com>
 <20250820182736.84941-1-sj@kernel.org>
In-Reply-To: <20250820182736.84941-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Thu, 21 Aug 2025 10:08:03 +0900
X-Gm-Features: Ac12FXwY0QvAKJXu1Lstb6SiLaFsDLAKOkZbXUCeMOgo9sq_Zc-hrouZIUfRh_0
Message-ID: <CABFDxMGmVgswVoZFgBz=7xqA59M7fMt0jw2QHqWjm-W9tZktWg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/damon/core: set quota->charged_from to jiffies at
 first charge window
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 3:27=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Wed, 20 Aug 2025 22:18:53 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > Hello, SeongJae
> >
> > On Wed, Aug 20, 2025 at 2:27=E2=80=AFAM SeongJae Park <sj@kernel.org> w=
rote:
> > >
> > > On Wed, 20 Aug 2025 00:01:23 +0900 Sang-Heon Jeon <ekffu200098@gmail.=
com> wrote:
> > >
> > > > Kernel initialize "jiffies" timer as 5 minutes below zero, as shown=
 in
> > > > include/linux/jiffies.h
> > > >
> > > > /*
> > > >  * Have the 32 bit jiffies value wrap 5 minutes after boot
> > > >  * so jiffies wrap bugs show up earlier.
> > > >  */
> > > >  #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> > > >
> > > > And they cast unsigned value to signed to cover wraparound
> > >
> > > "they" sounds bit vague.  I think "jiffies comparison helper function=
s" would
> > > be better.
> >
> > I agree, I will change it.
> >
> > > >
> > > >  #define time_after_eq(a,b) \
> > > >   (typecheck(unsigned long, a) && \
> > > >   typecheck(unsigned long, b) && \
> > > >   ((long)((a) - (b)) >=3D 0))
> > > >
> > > > In 64bit system, these might not be a problem because wrapround occ=
urs
> > > > 300 million years after the boot, assuming HZ value is 1000.
> > > >
> > > > With same assuming, In 32bit system, wraparound occurs 5 minutues a=
fter
> > > > the initial boot and every 49 days after the first wraparound. And =
about
> > > > 25 days after first wraparound, it continues quota charging window =
up to
> > > > next 25 days.
> > >
> > > It would be nice if you can further explain what real user impacts th=
at could
> > > make.  To my understanding the impact is that, when the unexpected ex=
tension of
> > > the charging window is happened, the scheme will work until the quota=
 is full,
> > > but then stops working until the unexpectedly extended window is over=
.
> > >
> > > The after-boot issue is really bad since there is no way to work arou=
nd other
> > > than reboot the machine.
> >
> > I agree with your point that user impact should be added to commit
> > messages. Before modifying the commit message, I want to check that my
> > understanding of "user impact" is correct.
>
> I think you should make clear at least you believe you understand the
> consequences of your patches including user impacts before sending your p=
atches
> without RFC tag.  I'd suggest you to take more time on making such
> preparational confidences and/or discussions _before_ sending non-RFC pat=
ches.
> You're nver lagging.  Take your time.

I think that I checked about user impact already but it should be
insufficient. As you said, I should discuss it first. Anyway, the
whole thing is my mistake. I'm really so sorry.

So, Would it be better to send an RFC patch even now, instead of
asking on this email thread? (I'll make next v3 patch with RFC tag,
it's not question of v3 direction and just about remained question on
this email thread)

> >
> > In the logic before this patch is applied, I think
> > time_after_eq(jiffies, ...) should only evaluate to false when the MSB
> > of jiffies is 1 and charged_from is 0. because if charging has
> > occurred, it changes charge_from to jiffies at that time.
>
> It is not the only case that time_after_eq() can be evaluated to false.  =
Maybe
> you're saying only about the just-after-boot running case?  If so, please
> clarify.  You and I know the context, but others may not.  I hope the com=
mit
> message be nicer for them.

I think it is not just-after-boot running case also whole and only
case, because charging changes charged_from to jiffies. if it is not
the only case, could you please describe the specific case?

> > Therefore,
> > esz should also be zero because it is initialized with charged_from.
> > So I think the real user impact is that "quota is not applied", rather
> > than "stops working". If my understanding is wrong, please let me know
> > what point is wrong.
>
> Thank you for clarifying your view.  The code is behaving in the way you
> described above.  It is because damon_set_effective_quota(), which sets t=
he
> esz, is called only when the time_after_eq() call returns true.
>
> However, this is a bug rather than an intended behavior.  The current beh=
avior
> is making the first charging window just be wasted without doing nothing.
>
> Probably the bug was introduced by the commit that introduced esz.

Thanks for your explanation. I'll try to cover this point in the next
patch as well.

> >
> > > >
> > > > Example 1: initial boot
> > > > jiffies=3D0xFFFB6C20, charged_from+interval=3D0x000003E8
> > > > time_after_eq(jiffies, charged_from+interval)=3D(long)0xFFFB6838; I=
n
> > > > signed values, it is considered negative so it is false.
> > >
> > > The above part is using hex numbers and look like psuedo-code.  This =
is
> > > unnecessarily difficult to read.  To me, this feels like your persona=
l note
> > > rather than a nice commit message that written for others.  I think y=
ou could
> > > write this in a much better way.
> > >
> > > >
> > > > Example 2: after about 25 days first wraparound
> > > > jiffies=3D0x800004E8, charged_from+interval=3D0x000003E8
> > > > time_after_eq(jiffies, charged_from+interval)=3D(long)0x80000100; I=
n
> > > > signed values, it is considered negative so it is false
> > >
> > > Ditto.
> >
> > Okay, I think I can fix these sections with explanation using MSB.
>
> Also please make it easier to read for more human people.

I see.

> >
> > > >
> > > > So, change quota->charged_from to jiffies at damos_adjust_quota() w=
hen
> > > > it is consider first charge window.
> > > >
> > > > In theory; but almost impossible; quota->total_charged_sz and
> > > > qutoa->charged_from should be both zero even if it is not in first
> > >
> > > s/should/could/ ?
> >
> > Sorry for my poor english.
> >
> > > Also, explaining when that "could" happen will be nice.
> >
> > I want to confirm this situation as well. I think the situation below
> > is the only case.
>
> Again, if there is anything unclear, let's do discussions before sending
> non-RFC patches.
>
> >
> > 1. jiffies overflows to exactly 0
> > 2. And quota is configured but never actually applied, so total_charged=
_sz is 0
>
> Or, total_charged_sz is also overflows and bcome 0.

Thanks for clarifying me.

> > 3. And charging occurs at that exact moment.
>
> It's not necessarily when charging occurs but when damon_adjust_quota() i=
s
> called.  More technically speaking once per the scheme's apply interval.

Ditto.

> >
> > Is that right? If right, I think this situation is almost impossible
> > and uncommon. I feel like It's unnecessary to describe it. I'm not
> > trying to ignore your valuable opinion, but do you still think it's
> > better to add a description?
>
> I'm ok to completely drop the explanation.  But if you are gonna mention =
it
> partially, please clarify.

I see, your opinion is reasonable. I'll keep that in my mind.

> >
> > > > charge window. But It will only delay one reset_interval, So it is =
not
> > > > big problem.
> > > >
> > > > Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for sc=
hemes application speed control") # 5.16
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > >
> > > I think the commit message could be much be improved, but the code ch=
ange seems
> > > right.
> >
> > Once again, Sorry for my poor english. I'm doing my best on my own.
>
> This is not about English skill but the commit "message".  Your English s=
kill
> is good and probably betetr than mine.  But I ad a difficult time at revi=
ewing
> your patch, and feeling it could been easier if the message was nicer.
>
> So what I'm saying is that I tink this patch's commit message can be more=
 nice
> to readers.

You're right. I'll try to make the commit message more clear. I'm
really sorry for bothering you.

>
> Thanks,
> SJ
>
> [...]

Best Regards
Sang-Heon Jeon

