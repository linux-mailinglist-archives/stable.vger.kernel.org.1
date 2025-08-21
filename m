Return-Path: <stable+bounces-171942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB44B2ECCB
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 06:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F3FA252D1
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 04:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2996244685;
	Thu, 21 Aug 2025 04:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rfr9SEae"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B522505AF
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 04:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750559; cv=none; b=u1lFRilN/ycChfo2fWQn7shO3NztIPILC4C3vwohRQVKO4awBGiKc9ucCuXVWW3CYwoc/GhS6/7+Lfi2shh+3oYGtvuKtnhNhyC0diW9R1mMwkJ2ZZjW+aMpgvT9XVgFzHspZn7czksy03nA6i+OTO1H5Nd7j/FHuiH3ohGUOfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750559; c=relaxed/simple;
	bh=gDRx4mwUvt6KBsgpUBrSflpnqWBTOrb8Y4evN/1DHnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XksRvx0z/fD6SOrtu42c58WL161FJVfR2Q1gIvKxvQ8WzhDG8on0WqDoKEONcPgGFYPU5/NAhJ6k7I6nrR4L+iZ+W6eph1UVz977LGUIHgx80q9qwNB0GaIH2anlJdOs4/M9Jid6+E/lKsBf2a0oIqqAxOKGFoOqFRO3tppBm/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rfr9SEae; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-61bfa392bc1so372119eaf.1
        for <stable@vger.kernel.org>; Wed, 20 Aug 2025 21:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755750556; x=1756355356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8A9C6Y9ZJgiMsi/J5YHom1KPP5jSn1ZRQFc25n88ZJs=;
        b=Rfr9SEaercCYW2s8+zA4/xlrmZDR0Rv9jO7JaIUFtGObK8S00HJptYKKyJPVrYZH6g
         nM/fyhUXigFdjK9MHqlU5jDw72TkL/t1InIwIjA8yDSz8gkY5XiggUY+Z1KPbEuitI1W
         MaJakiUlHSy66fqE78FZ16I039lpZksh9PY0ayAbB5droPDw4jtI72EUtZt/u/rVTTov
         e85eN0SxTp4obGUvtGDbykL4A89ayOjvEc7ReewY9FqZZ6Ebwa5STk4ew5e3Cd5/7t1R
         cB6BSMNeJ2x7gsej2rgpQPJtx6LqwAymwKDvkecKuaZMTtRQ6fbv3FWOYXyCXxwKezO9
         MASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750556; x=1756355356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8A9C6Y9ZJgiMsi/J5YHom1KPP5jSn1ZRQFc25n88ZJs=;
        b=DzykR48tOOzND/u9Ioza/qngelItyjrrawl8tz+DYb/bat1+ASXoLAeSbFh9eNrBxn
         QJUm6zsfZQTaUxXAfWFdMFR5PrcgSjjrb7I3F4ucvepMIDfnk9/KmKdhApkBuakyzKbP
         E6Kwg/NJOPRMxXpeDZqoiBR2bSbLiqHFDnRZJ3r6ZVqQKs1vSD73iyw9N+pWfRonv+G2
         Q4nLHEFvl5jgL2dr4p4V4K3xvf1yKFO42kZmXGieJyj+F5UcyJmc9Ja0qUXeMknYPZO/
         B3+DCkZdWHmzSeMAa6c3umeVp/HAoIa0YLbo4Jp8FbyDROM991Hlr0MIZ7ad1CK/Ao+u
         TBdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHL1LRNDCWG8Tbc6s1Z+wkw+UlR62ISs0AbuFWnw+tzWfSZUpjLnTrg39OJALKKG8VJZ/T7x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqD2uYvZxYTDD045PyUPJNMVBhRFNg1DENGBFFwghmFk/JqBmO
	S0Z9IDzLg2mrRIZbnAY7cBMKHx6kB4hCYp6GBfB34z0XRvIm9VVgD2GmPXTe1vlmuqGg5kqQDfI
	hZZsnuK0pY3kKN/QwXUDD017RHGLbUt8=
X-Gm-Gg: ASbGncsb1yXxXxgoh1VSFC+u6y0MK/Z/dCJwF+bXUMk95Es+TUJRHKoBn1GeJPnOYvX
	5zJLf5+sJuTPTU7pPG3MshokkTguXtJ9wiXG7FjHRusvHlozeZxkY8o2qhhERpV61Iwo05oZHlK
	+NFf6QcuaxoqYJaBb7zxjC4+NY9RoKF2dw7+4eAzVsn4XM6Xh8FvrM7MupMBiQ9+DT5rozp+fmO
	Wowbv0/+HjqEJQ=
X-Google-Smtp-Source: AGHT+IFDjBecc8GcRKMiu+HH3tdyg2aCQxSoKPoBmiKjiHISG5ASpJZTZMSnkG+iLjHlpiuFK45BniXIU9XuY1I+13I=
X-Received: by 2002:a05:6820:620:b0:61c:648:5f96 with SMTP id
 006d021491bc7-61dab2967d9mr478856eaf.0.1755750555517; Wed, 20 Aug 2025
 21:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABFDxMGmVgswVoZFgBz=7xqA59M7fMt0jw2QHqWjm-W9tZktWg@mail.gmail.com>
 <20250821025423.90825-1-sj@kernel.org>
In-Reply-To: <20250821025423.90825-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Thu, 21 Aug 2025 13:29:04 +0900
X-Gm-Features: Ac12FXxwmBhLAYwhb250Nr3Mb1TYmrDdE6eHzv4fHnin_s3-I2GxsKQVwH7Y8BI
Message-ID: <CABFDxME5ZEAn+6=0GRWybTi-xBzbhhz7U38pMni3SdKjA+Aj-A@mail.gmail.com>
Subject: Re: [PATCH v2] mm/damon/core: set quota->charged_from to jiffies at
 first charge window
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 11:54=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> On Thu, 21 Aug 2025 10:08:03 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > On Thu, Aug 21, 2025 at 3:27=E2=80=AFAM SeongJae Park <sj@kernel.org> w=
rote:
> > >
> > > On Wed, 20 Aug 2025 22:18:53 +0900 Sang-Heon Jeon <ekffu200098@gmail.=
com> wrote:
> > >
> > > > Hello, SeongJae
> > > >
> > > > On Wed, Aug 20, 2025 at 2:27=E2=80=AFAM SeongJae Park <sj@kernel.or=
g> wrote:
> > > > >
> > > > > On Wed, 20 Aug 2025 00:01:23 +0900 Sang-Heon Jeon <ekffu200098@gm=
ail.com> wrote:
> [...]
> > I think that I checked about user impact already but it should be
> > insufficient. As you said, I should discuss it first. Anyway, the
> > whole thing is my mistake. I'm really so sorry.
>
> Everyone makes mistakes.  You don't need to apologize.
>
> >
> > So, Would it be better to send an RFC patch even now, instead of
> > asking on this email thread? (I'll make next v3 patch with RFC tag,
> > it's not question of v3 direction and just about remained question on
> > this email thread)
>
> If you unsure something and there is no reason to send a patch without a
> discussion for the point, please discuss first.  To be honest I don't
> understand the above question at all.

Ah, I just mean that I need to make a new RFC patch instead of
replying to this email thread. I'll just keep asking about previous
comments on this email thread.

> >
> > > >
> > > > In the logic before this patch is applied, I think
> > > > time_after_eq(jiffies, ...) should only evaluate to false when the =
MSB
> > > > of jiffies is 1 and charged_from is 0. because if charging has
> > > > occurred, it changes charge_from to jiffies at that time.
> > >
> > > It is not the only case that time_after_eq() can be evaluated to fals=
e.  Maybe
> > > you're saying only about the just-after-boot running case?  If so, pl=
ease
> > > clarify.  You and I know the context, but others may not.  I hope the=
 commit
> > > message be nicer for them.
> >
> > I think it is not just-after-boot running case also whole and only
> > case, because charging changes charged_from to jiffies. if it is not
> > the only case, could you please describe the specific case?
>
> I don't understand the first sentence.  But...
>
> I mean, time_after_eq() can return false for many cases including just wh=
en the
> time is before.  Suppose a case that the first and the second arguments a=
re,
> say, 5000 and 7000.

I think my previous explanation is not enough. I just want to say,
time_after_eq return false, but user expected true case; And I think
that's the point we want to fix.

Maybe I can change my previous question like this, "Is there any
situation, that charged_from has been updated before and even though
reset_interval has passed but time_after_equal() returns false".

I asked this question because I think that kind of situation can't
exist and minimum version of Fixes patch(5.16) uses esz in the same
way as it is now. So I think that we shouldn't use "stop working" in
the commit message.

As I was writing this, I thought about your comments deeply again.
Since you describe the current state of esz as a bug, I think you
might want to write "stop working" to comments, because I think you're
thinking that some fixes patch could change esz initialized value
(also reasonable, I agree)

I think adding an explanation of the above knowledge is good to help
newcomers to understand DAMON well. Also, Could you please check the
above question for a more detailed commit message?

> >
> > > > Therefore,
> > > > esz should also be zero because it is initialized with charged_from=
.
> > > > So I think the real user impact is that "quota is not applied", rat=
her
> > > > than "stops working". If my understanding is wrong, please let me k=
now
> > > > what point is wrong.
> > >
> > > Thank you for clarifying your view.  The code is behaving in the way =
you
> > > described above.  It is because damon_set_effective_quota(), which se=
ts the
> > > esz, is called only when the time_after_eq() call returns true.
> > >
> > > However, this is a bug rather than an intended behavior.  The current=
 behavior
> > > is making the first charging window just be wasted without doing noth=
ing.
> > >
> > > Probably the bug was introduced by the commit that introduced esz.
> >
> > Thanks for your explanation. I'll try to cover this point in the next
> > patch as well.
>
> If you gonna send a patch for fixing this bug, make it as a separate one,
> please.

I didn't mean newer code changes, just commit messge. As you said code
change should be created with another patch, if it has another
intension; Also, i didn't have any plan yet. I'm trying to resolve
this patch first

> [...]
> > > So what I'm saying is that I tink this patch's commit message can be =
more nice
> > > to readers.
> >
> > You're right. I'll try to make the commit message more clear. I'm
> > really sorry for bothering you.
>
> Again, you don't need to apologize.

Maybe, I just want to express my gratitude :)

>
> Thanks,
> SJ
>
> [...]

Best Regards
Sang-Heon Jeon

