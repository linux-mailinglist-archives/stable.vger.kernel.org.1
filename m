Return-Path: <stable+bounces-171898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F17B2DDA5
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 15:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBD0724F9B
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 13:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD7827EFEF;
	Wed, 20 Aug 2025 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3PBCysT"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9522D17BEBF
	for <stable@vger.kernel.org>; Wed, 20 Aug 2025 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695947; cv=none; b=ssvLV6oYH03OL7xXKtPu2TN1FIc36DydPtLp1Nvfk14hzVJUP4XXVxEtU4i7bnrfgfMmOaa2rJHeTqi4S/CJmnhaqDjiOO54dMSJhc0q/UxPU+d6qFxH78VGnqdXa1T3tKVenEuv8hebZPey0uxSy0VdT0mEbBX8CQ5UgITNo+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695947; c=relaxed/simple;
	bh=26EgnC9VdzW16nnSO8YsPdt3Kb8gGxlpfNil9NrEA5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vaq9cStJDk6gfQ0EwJEf7UTFXevdAwQBeqUn0yTup6YXCFTlYINmppjFQTJdRdjTSHrKpeHx9jgsVAtrEBZXK/oL3Qd4x9GLyaHnKJaNuju8E3QV0h8xXg3vd/lFyJq13pNlw2Yfhtr/WQJkIkisedg28NtrRQPPDmRArXjmX3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3PBCysT; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-61bd4e14054so2778676eaf.2
        for <stable@vger.kernel.org>; Wed, 20 Aug 2025 06:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755695944; x=1756300744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAMXUsIDqPU8hdhM2JBX5eSeLOvw6AYekbiBZi6aVVM=;
        b=E3PBCysTo6/TgiS9fbJHGD6o4I0rzD1Ugkxdn2kjar3vTnLGi1BBCAC9H4WOFfwDSj
         u8RJnuJGi06ud0i+enudENeWeXrlOONKd2SBSPxOindN44BjeNRaNeF98AhV1QUuEtq7
         ky9V9GSTYODUHXBdljNxyeVFaxVh2JDJVe9l4BfnmNmx95arFgiDouCRUpHBavFs0SUj
         sOXoXO8F+H1UU5UogAxKdXzt3zuej7rujxIE0aZEdJ+k6jcOjkVgFE2MlClHeHXHPthd
         05DtUWBnOOvVzG0+tgBB7bvaMzCy4/qHggPOGjruXG8cM0H9bq34icxyDD/X+LXVEgav
         RRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755695944; x=1756300744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAMXUsIDqPU8hdhM2JBX5eSeLOvw6AYekbiBZi6aVVM=;
        b=opgeHHDDwpj/MrJDkrvOfx3luqfcoUy/lohDP+kBp9F3txTpprkZpGLIeDSL2ob8qp
         CCGBh8rZEzK51Ujgn58yNFFheY9Zdli1qOw23FVAXbiDLofYCfMBumn+6QyKSiyXOvGu
         6nD2VtHEOUpA3BOrDBwH6wvmq4eRAji6SA/RVJ83S0oGkMy6KDavkRI3nYQf3etJ4knN
         RZaRPHNi9/n+Pv0lBVUGdsjGMk52a2FyeXIOFcgVuE9nZgzg5+N+w/W5oL5PvpEn5J/1
         y5nGsENlPatbbrJLYTFzqYRJ24b5hUZVHBiPSrRvCY8nRo4lAgiYDyD9dtklE9+p9MRw
         xEXw==
X-Forwarded-Encrypted: i=1; AJvYcCXY7i6+afEiuHxebVHfzNAxUo0TGgx6IpRKTQaYzaSjpaul+RI/pWMqFJW2hzCn6iB3T0BjqzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn6wechWmzvSbZCNxYNaCBXCcxuPJS2VtaYkj4r68iaPOM2Oxx
	r1NURL8X1R9AJIx7k97Y8iGdqsNKE9qkF0+V/E7hSYgMDaMTn5j0zqoT+5QSPdfn3gMKLMieIiw
	Bu67RebKHG4Q16boyUeiOv/0sj221IE986O/9UTk=
X-Gm-Gg: ASbGncvOQke3X2MEedBQeXaz0Txi1ZnOMb+LeheiWCnUAYdIPhnLvoLN3PZpwE//NWS
	73V4uO+rZyCvVkc60APuP0xLluYOKzkBNcQTN1M83S3+OmzTR6Kh2La6KQTMsLcfhWX0f/ndThW
	vEYKKFTymumeh0cEC0pZhcA4Iz6LymuEM9dvJ2+0ZQjsoX6krROS9yTQTe6oH6UAqcltU8V+0c6
	E6e
X-Google-Smtp-Source: AGHT+IGr8rKQBFa7oMvw8UPeCjSuZwPpiw0MQs64usnbnAp1T4vxRigxd2e5nQ9hOelY88Xonn1OALndKlXWmb7UviY=
X-Received: by 2002:a05:6820:2214:b0:61c:378:acbf with SMTP id
 006d021491bc7-61d9b6e1746mr1657811eaf.5.1755695944429; Wed, 20 Aug 2025
 06:19:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819150123.1532458-1-ekffu200098@gmail.com> <20250819172718.44530-1-sj@kernel.org>
In-Reply-To: <20250819172718.44530-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Wed, 20 Aug 2025 22:18:53 +0900
X-Gm-Features: Ac12FXzi0_NOd2NnDrtbBEuBmHTiFEm9xR0_nofBUIe_5yrnjsOC7F9A8Jr1bJE
Message-ID: <CABFDxMHpodpNQM_a=T0vf48k486mYqukCVnQPbanLh+G_HH+9g@mail.gmail.com>
Subject: Re: [PATCH v2] mm/damon/core: set quota->charged_from to jiffies at
 first charge window
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, SeongJae

On Wed, Aug 20, 2025 at 2:27=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Wed, 20 Aug 2025 00:01:23 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
> > include/linux/jiffies.h
> >
> > /*
> >  * Have the 32 bit jiffies value wrap 5 minutes after boot
> >  * so jiffies wrap bugs show up earlier.
> >  */
> >  #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> >
> > And they cast unsigned value to signed to cover wraparound
>
> "they" sounds bit vague.  I think "jiffies comparison helper functions" w=
ould
> be better.

I agree, I will change it.

> >
> >  #define time_after_eq(a,b) \
> >   (typecheck(unsigned long, a) && \
> >   typecheck(unsigned long, b) && \
> >   ((long)((a) - (b)) >=3D 0))
> >
> > In 64bit system, these might not be a problem because wrapround occurs
> > 300 million years after the boot, assuming HZ value is 1000.
> >
> > With same assuming, In 32bit system, wraparound occurs 5 minutues after
> > the initial boot and every 49 days after the first wraparound. And abou=
t
> > 25 days after first wraparound, it continues quota charging window up t=
o
> > next 25 days.
>
> It would be nice if you can further explain what real user impacts that c=
ould
> make.  To my understanding the impact is that, when the unexpected extens=
ion of
> the charging window is happened, the scheme will work until the quota is =
full,
> but then stops working until the unexpectedly extended window is over.
>
> The after-boot issue is really bad since there is no way to work around o=
ther
> than reboot the machine.

I agree with your point that user impact should be added to commit
messages. Before modifying the commit message, I want to check that my
understanding of "user impact" is correct.

In the logic before this patch is applied, I think
time_after_eq(jiffies, ...) should only evaluate to false when the MSB
of jiffies is 1 and charged_from is 0. because if charging has
occurred, it changes charge_from to jiffies at that time. Therefore,
esz should also be zero because it is initialized with charged_from.
So I think the real user impact is that "quota is not applied", rather
than "stops working". If my understanding is wrong, please let me know
what point is wrong.

> >
> > Example 1: initial boot
> > jiffies=3D0xFFFB6C20, charged_from+interval=3D0x000003E8
> > time_after_eq(jiffies, charged_from+interval)=3D(long)0xFFFB6838; In
> > signed values, it is considered negative so it is false.
>
> The above part is using hex numbers and look like psuedo-code.  This is
> unnecessarily difficult to read.  To me, this feels like your personal no=
te
> rather than a nice commit message that written for others.  I think you c=
ould
> write this in a much better way.
>
> >
> > Example 2: after about 25 days first wraparound
> > jiffies=3D0x800004E8, charged_from+interval=3D0x000003E8
> > time_after_eq(jiffies, charged_from+interval)=3D(long)0x80000100; In
> > signed values, it is considered negative so it is false
>
> Ditto.

Okay, I think I can fix these sections with explanation using MSB.

> >
> > So, change quota->charged_from to jiffies at damos_adjust_quota() when
> > it is consider first charge window.
> >
> > In theory; but almost impossible; quota->total_charged_sz and
> > qutoa->charged_from should be both zero even if it is not in first
>
> s/should/could/ ?

Sorry for my poor english.

> Also, explaining when that "could" happen will be nice.

I want to confirm this situation as well. I think the situation below
is the only case.

1. jiffies overflows to exactly 0
2. And quota is configured but never actually applied, so total_charged_sz =
is 0
3. And charging occurs at that exact moment.

Is that right? If right, I think this situation is almost impossible
and uncommon. I feel like It's unnecessary to describe it. I'm not
trying to ignore your valuable opinion, but do you still think it's
better to add a description?

> > charge window. But It will only delay one reset_interval, So it is not
> > big problem.
> >
> > Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for scheme=
s application speed control") # 5.16
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
>
> I think the commit message could be much be improved, but the code change=
 seems
> right.

Once again, Sorry for my poor english. I'm doing my best on my own.

> Reviewed-by: SeongJae Park <sj@kernel.org>
>
> > ---
> > Changes from v1 [1]
> > - not change current default value of quota->charged_from
> > - set quota->charged_from when it is consider first charge below
> > - add more description of jiffies and wraparound example to commit
> >   messages
> >
> > SeongJae, please re-check Fixes commit is valid. Thank you.
>
> I think it is valid.  Thank you for addressing my comments!
>
>
> Thanks,
> SJ
>
> [...]

Best Regards
Sang-Heon Jeon

