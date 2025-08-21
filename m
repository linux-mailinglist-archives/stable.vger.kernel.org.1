Return-Path: <stable+bounces-171970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96941B2F5E7
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F8A44E23CF
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 11:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529B230EF76;
	Thu, 21 Aug 2025 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rclwp+jx"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80618257846
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774433; cv=none; b=QxOTcUvsqOzQdaIQ8YqKO38MktuynmLLWaGoL+BW6jaStvoxBcLGtRnw6/viI4l77uHwjXvw2bxDnEzMgjoVOJztVP08vjpTWbrfsyQuVq1LULyo4bV8jZbKR9S5Xt2hejXxSFuuvsp8G99R20N8kVp8Dt73Bawe7wxDuS16JYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774433; c=relaxed/simple;
	bh=lq+gs4RnuDDIrP82JMtaZi5rTxofYTYlCI5QlunDzIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0ED2MVkEi1QQsGmL34jHzYtXQ4/3+bbwHSEWJBf1CgJ17yK2u2VdCcn96Y75VQO5GlsFG/YzOCseuYUWKvCylWojvZlP8eTcX77qNmvUjUitVg6pdp89c4KNZyB7lKibTlNiau3mPBzbtVimg5urgOFet94ZoXGY6j+m8qeHpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rclwp+jx; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61c1312553cso195323eaf.3
        for <stable@vger.kernel.org>; Thu, 21 Aug 2025 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755774429; x=1756379229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiIZ6lQmGLvY+69EJfMpz5tBA2tanpZN8rHbO7rGKac=;
        b=Rclwp+jxjZI13zj644Ri54EU6EheR2CGnPUtykwP0UF/K8CvskqYWqGEIIUSVTYh5f
         U+8qq3dkydnbO6yZ54Roj/GEOETh0yBfH/2tj30NhYH/2K/yLezKximi0xOp2rsL8eww
         yeTbW+4I46vxusE+jMkipA2vJZuO5ob4AG2WKrxVhk5+dQwaicUARp0/5gK3ER4lZj73
         sc/tc/tyRg8a0KYRWdzKwuFIEdV1+N2/Dcs/TG1YcytDnPU+5a8hN/VSocvCsU+gSdgC
         u47oMg8hOVR3ALY6QRtfQAKmqMDQYkEqiDw3DKYi8nFUiTfo84ZyWOrrbWpEjGHkn3CJ
         jh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755774429; x=1756379229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiIZ6lQmGLvY+69EJfMpz5tBA2tanpZN8rHbO7rGKac=;
        b=uUMiqW49kWvxxaqqPxgZPYouf/K7WtOzZL8ydBrOV6b+92hcqrDEpxXqAzVs1YKSgz
         izIYUPj9jtzy+Av/clwZx30W5oDqmlrIEETR5jMWtWfgQGhVkeyqKIas9UVScFRHZ6vY
         69RS+LuEQkgQtMoNQ5f2YGZEnW6jmiaPxmfCHs8FtqTDDQZ1for+aZDlqX1BkusUNlr8
         8ye8kyIFw5beGwkY8B3/Z3YKUoSDWG7GUAJ3jOisg/KegDIrojFxACXyZUD0Wl8P7AeU
         wrM+NAoyxkWbC0B6po/hsaashIPJaZv+hfyH5FEE19gS0mzOPO4Pf/xFCNUY1x9eFADm
         wkzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMm2uj3pl7xCFFs0/GfVeSQ5lGhsIjH1cYNm0/PkIehYnzKMaZPSqQl4JdvrEp1/WjccOZxeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynVrRM1kY4IcjxWVbEq4Xt8cz3Gt3UBXH4Qe+EAWngOFFV8oxs
	pY1Lk+OO1y5JsCPyTf8jMQUuZ1QZm5ZrA3dPYHqXDguuEB9buNU/kLDygVvgarzBVmR+wrRfXPZ
	MgvthMZqeXeis/4n4kWKwvYLrpVPsVuU=
X-Gm-Gg: ASbGncvBhtivZGQc0pF2BBtABoX95rSvKwFO1z2gC7/FfJnAa2JXhvW2fhT6GlZSJ9P
	e5gHfYP+HdvdtYhhias/NnStyQ0IdaKg/xT2iqzXGhB7jnBDJmzrAw6U57ChwAOmDM0djSvR7nh
	7HFa/7UMMq/6FSrIcSkXlrBHYl4DwzmKpsVJZ6dgXAPgVNsv0wt97kJVPGd6qWNkanOKVho1CYs
	hC7Bj0ihXwVX0Y=
X-Google-Smtp-Source: AGHT+IHDLck68A4uwh4SnafV/XdhO0tvddlIcwAPIaIuldKdKV8FYfx8DQctiAAl9nm4vwx0UEGSyaMl0wGd0sRiAZE=
X-Received: by 2002:a05:6820:60f:b0:61d:95ee:b387 with SMTP id
 006d021491bc7-61dab39122amr828362eaf.8.1755774429258; Thu, 21 Aug 2025
 04:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABFDxME5ZEAn+6=0GRWybTi-xBzbhhz7U38pMni3SdKjA+Aj-A@mail.gmail.com>
 <20250821054148.53746-1-sj@kernel.org>
In-Reply-To: <20250821054148.53746-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Thu, 21 Aug 2025 20:06:58 +0900
X-Gm-Features: Ac12FXwihon6gThYHt62W99b3GivzmKJ4uU22wv-CFXcXYs_nLemAr_4GPQ0U3U
Message-ID: <CABFDxMHgOPt5zx3q=KRxGGfp86R4V0AgO+FrHDftqLYoG20BWw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/damon/core: set quota->charged_from to jiffies at
 first charge window
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org, 
	stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:41=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Thu, 21 Aug 2025 13:29:04 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > On Thu, Aug 21, 2025 at 11:54=E2=80=AFAM SeongJae Park <sj@kernel.org> =
wrote:
> > >
> > > On Thu, 21 Aug 2025 10:08:03 +0900 Sang-Heon Jeon <ekffu200098@gmail.=
com> wrote:
> > >
> > > > On Thu, Aug 21, 2025 at 3:27=E2=80=AFAM SeongJae Park <sj@kernel.or=
g> wrote:
> > > > >
> > > > > On Wed, 20 Aug 2025 22:18:53 +0900 Sang-Heon Jeon <ekffu200098@gm=
ail.com> wrote:
> > > > >
> > > > > > Hello, SeongJae
> > > > > >
> > > > > > On Wed, Aug 20, 2025 at 2:27=E2=80=AFAM SeongJae Park <sj@kerne=
l.org> wrote:
> > > > > > >
> > > > > > > On Wed, 20 Aug 2025 00:01:23 +0900 Sang-Heon Jeon <ekffu20009=
8@gmail.com> wrote:
> > > [...]
> > > > I think that I checked about user impact already but it should be
> > > > insufficient. As you said, I should discuss it first. Anyway, the
> > > > whole thing is my mistake. I'm really so sorry.
> > >
> > > Everyone makes mistakes.  You don't need to apologize.
> > >
> > > >
> > > > So, Would it be better to send an RFC patch even now, instead of
> > > > asking on this email thread? (I'll make next v3 patch with RFC tag,
> > > > it's not question of v3 direction and just about remained question =
on
> > > > this email thread)
> > >
> > > If you unsure something and there is no reason to send a patch withou=
t a
> > > discussion for the point, please discuss first.  To be honest I don't
> > > understand the above question at all.
> >
> > Ah, I just mean that I need to make a new RFC patch instead of
> > replying to this email thread.
>
> Why?
>
> > I'll just keep asking about previous
> > comments on this email thread.
>
> You said you will send a new patch instead of replying here, and then now=
 you
> are saying you will keep aking to this thread.
>
> I'm confused.

I think I miscommunicated something. I'll just follow your suggestion
below. it's the same as my first thought (discussion here, new patch
after discussion finished)

> [...]
>
> Ok, I think this discussion is going unnecessarily deep and only wasting =
our
> time at clarifying intention of past sentence.  Meanwhile apparently you
> understood my major points.  To repeat, please clarify what is the proble=
m and
> user impacts, when and how it happens, and why the solution solves it.
>
> Let's restart.  Could you please rewrite the commit log for this patch an=
d send
> the draft as a reply to this?
>
> We can further discuss on the new draft if it has more things to improve.=
  And
> once the discussion is finalized, you can post v4 of this patch with the
> updated commit message.

Good Idea. This is the draft for commit message. Also, Thank you for
your patience and understanding.

Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
include/linux/jiffies.h

/*
 * Have the 32 bit jiffies value wrap 5 minutes after boot
 * so jiffies wrap bugs show up earlier.
 */
 #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))

And jiffies comparison help functions cast unsigned value to signed to
cover wraparound

 #define time_after_eq(a,b) \
  (typecheck(unsigned long, a) && \
  typecheck(unsigned long, b) && \
  ((long)((a) - (b)) >=3D 0))

When quota->charged_from is initialized to 0, time_after_eq() can incorrect=
ly
return FALSE even after reset_interval has elapsed. This occurs when
(jiffies - reset_interval) produces a value with MSB=3D1, which is interpre=
ted
as negative in signed arithmetic.

This issue primarily affects 32-bit systems because:
On 64-bit systems: MSB=3D1 values occur after ~292 million years from boot
(assuming HZ=3D1000), almost impossible.

On 32-bit systems: MSB=3D1 values occur during the first 5 minutes after bo=
ot,
and the second half of every jiffies wraparound cycle, starting from day 25
(assuming HZ=3D1000)

When above unexpected FALSE return from time_after_eq() occurs, the
charging window will not reset. The user impact depends on esz value
at that time.

If esz is 0, scheme ignores configured quotas and runs without any
limits.

If esz is not 0, scheme stops working once the quota is exhausted. It
remains until the charging window finally resets.

So, change quota->charged_from to jiffies at damos_adjust_quota() when
it is considered as the first charge window. By this change, we can avoid
unexpected FALSE return from time_after_eq()


>
> Thanks,
> SJ

Best Regards
Sang-Heon Jeon

