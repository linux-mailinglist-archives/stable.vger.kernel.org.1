Return-Path: <stable+bounces-61847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6EF93CFEF
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 10:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7E51F250EF
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 08:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E25B36D;
	Fri, 26 Jul 2024 08:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHRWyuJd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AFE13D255;
	Fri, 26 Jul 2024 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984108; cv=none; b=Cno5l+0ZtXno/uCTggQWWpOAlA0zL/HjT6CZo6cn0AwVhPwPAz3VmoFGEZ6wlKS1+Dpjgdzu4h+dCY+9+5NBvtI0w5ad7iY4c+rmjYQMPazVqxjmyQHYQXJCMKUBxAy2T8RKVZpoc2RSr4j90LRSf1zWF+jnH1pjTf37mETT4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984108; c=relaxed/simple;
	bh=he8U9UZkpAtKkVBLgORPLmjh+O4ksWKp5HJkZbNarpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLzWCoPv0v5RkylhIYAs9LOht0AGZoX1Rt0nBff/tf4zfES800PiezRY8DPBxPm4UFfeKSGaC7v7tSnhz7EkQLl0OKZCcCHi3oyYATSwt9a4Zwc/EMzFHOyyKEgyq6efffQmZ9Bs50QfGjfwDtpmHJIzOnLB5nBt8XO7/XRk+U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHRWyuJd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa7bso253185a12.1;
        Fri, 26 Jul 2024 01:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721984105; x=1722588905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STqdda2SEZjOE7whuhp/QZewj60K8H9Mte6gIw2bzZk=;
        b=nHRWyuJdilrkq8823QUw6DjfMClQVL4EI1iJw71Ij69h2Q2dEu4Ui0Lixk2zXZtPj2
         Db4tPCBiGrb3+rmonavD9OUnNRYLq8k5v0nXtA0iiTzyACaOtbEMKEKvgWd+ItvQG+n3
         Wy9wwYx0eQLZoV4tnvW+ohf6CmK8t8ASCyBRypIpQ5XCLvrx1XBdYQMbPKaRFQlzoFAD
         KOsCKY61TJfw4JlP6r+fThikXnXnPgW0thjgMz8w5TRyXXN7ToxvHOGDogoUNMFys7Wu
         4hX8BwInCMNflKq8IcyjG+907fMxaP6aRinlqkkPbUKssn8/93AvA3jXub9jHS7Zjjml
         s4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721984105; x=1722588905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STqdda2SEZjOE7whuhp/QZewj60K8H9Mte6gIw2bzZk=;
        b=TPKCiURFvQ18O59vU8B/XYOaAQHUcBcmBN4mIkwnqD8QzGfO/uyu5DaDn+kcBgtdwq
         yb+M6A8dBte3LLiocupuCAZ/trFuoQqjrHsv5tuONffbq+e4bDRB04oYvlva4dANKFhu
         IrXqOeNDPUGcCYDgCSEwKe8er464aq+D3Ck8uZ1QSPdz4qo8DdPVLHsL6LU14+5ekxRs
         aVuM3ZHtscV5tVsCEP+dDZ1WdD/xYpyjcrDhvaqAeSBwCFC6wADtyzPoo1xBlFpQ9YaR
         3CCcvxY0/qWgNhq0gtP4Aoh558r/82bpXTrzkOUgzoi+FZrZmNzpA3Hdii7l1av7yQGS
         EL0w==
X-Forwarded-Encrypted: i=1; AJvYcCXPnF+5MTxyC5ZLXAES6vXhiz9M8W10xlwrVR2GWZTpgnrds3Y08Ao3YLEa3KuGllXvEm1LRKMhEweFTp1YWM37E2FWSyB0MSb5QnQE1jrUWskXuso+XSaMZQFi6l+IRu7ABz3d
X-Gm-Message-State: AOJu0YwWY2V7vNXHA75cXup7Qs7wyT80144dzjFpaTThYwSbWKx4WuYT
	WS+aph+y1RRqhBQX8DSZ16n3K/beRccn4J8WXpcs5SqKNOXs9emIHEE0veKq7I0btdCRv9S55li
	VrpJKYUttNSR8E3z4SfHDBSJ1f6Y=
X-Google-Smtp-Source: AGHT+IEuCu0LH7RWYE4C2+y6Xq5Gd2lTUbSPZXSufj4wZklvkT/2hJWwi5rBWclTtW6+ZEIpzQUnvUyY0BRiDSmspAE=
X-Received: by 2002:a50:8d5a:0:b0:5a1:7362:91d9 with SMTP id
 4fb4d7f45d1cf-5ac629fb8d8mr3328924a12.22.1721984104539; Fri, 26 Jul 2024
 01:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fdaf2e41bb6a0c5118ff9cc21f4f62583208d885.1718655070.git.dsimic@manjaro.org>
 <CAKGbVbs8VmCXVOHbhkCYEHNJiKWwy10p0SV9J09h2h7xjs7hUg@mail.gmail.com>
 <CAKGbVbsM4rCprWdp+aGXE-pvCkb6N7weUyG2z4nXqFpv+y=LrA@mail.gmail.com>
 <20240618-great-hissing-skink-b7950e@houat> <4813a6885648e5368028cd822e8b2381@manjaro.org>
 <457ae7654dba38fcd8b50e38a1275461@manjaro.org> <2c072cc4bc800a0c52518fa2476ef9dd@manjaro.org>
 <CAKGbVbsGm7emEPzGuf0Xn5k22Pbjfg9J9ykJHtvDF3SacfDg6A@mail.gmail.com>
 <74c69c3bb4498099a195ec890e1a7896@manjaro.org> <4498852466ec9b49cc5288c5f091b3ae@manjaro.org>
 <CAKGbVbucXy+5Sn9U55DY69Lw9bQ+emmN1G4L8DQcUC1wdFSP_Q@mail.gmail.com> <7d1c35d6829f00fa62ea39b6fee656be@manjaro.org>
In-Reply-To: <7d1c35d6829f00fa62ea39b6fee656be@manjaro.org>
From: Qiang Yu <yuq825@gmail.com>
Date: Fri, 26 Jul 2024 16:54:52 +0800
Message-ID: <CAKGbVbukwz5naLwe7oW+UU8Ghtz6PmTjZ8k0PNZr2+h1Y20Qzw@mail.gmail.com>
Subject: Re: [PATCH] drm/lima: Mark simple_ondemand governor as softdep
To: Dragan Simic <dsimic@manjaro.org>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, 
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	linux-kernel@vger.kernel.org, Philip Muller <philm@manjaro.org>, 
	Oliver Smith <ollieparanoid@postmarketos.org>, Daniel Smith <danct12@disroot.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 4:03=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Qiang Yu,
>
> On 2024-07-26 08:07, Qiang Yu wrote:
> > Yeah, I agree weakdep is a better choice here. It solves the confusion
> > of softdep which the depend module is optional.
>
> Thanks, I'm glad that you agree.
>
> > But I prefer using weakdep directly instead of creating an aliasing of
> > it which has no actual difference.
>
> Just checking, did you have a chance to read what I wrote in my earlier
> response on the linux-modules mailing list, [7] which includes a rather
> elaborate explanation of the intent behind MODULE_HARDDEP being
> currently
> just a proposed alias for MODULE_WEAKDEP?  It also describes why using
> this alias might save use some time and effort in the future.
>
> [7]
> https://lore.kernel.org/linux-modules/0720a516416a92a8f683053d37ee9481@ma=
njaro.org/
>
Yeah, I've seen that mail. But I haven't seen clearly how weakdep will chan=
ge
in the future which could break our usage here. As an interface exposed to =
other
users, I expect it should be stable.

> > On Thu, Jul 25, 2024 at 4:21=E2=80=AFPM Dragan Simic <dsimic@manjaro.or=
g>
> > wrote:
> >>
> >> Hello Qiang,
> >>
> >> On 2024-06-26 08:49, Dragan Simic wrote:
> >> > On 2024-06-26 03:11, Qiang Yu wrote:
> >> >> On Wed, Jun 26, 2024 at 2:15=E2=80=AFAM Dragan Simic <dsimic@manjar=
o.org>
> >> >> wrote:
> >> >>> Just checking, any further thoughts about this patch?
> >> >>>
> >> >> I'm OK with this as a temp workaround because it's simple and do no
> >> >> harm
> >> >> even it's not perfect. If no other better suggestion for short term=
,
> >> >> I'll submit
> >> >> this at weekend.
> >> >
> >> > Thanks.  Just as you described it, it's far from perfect, but it's
> >> > still
> >> > fine until there's a better solution, such as harddeps.  I'll contin=
ue
> >> > my
> >> > research about the possibility for adding harddeps, which would
> >> > hopefully
> >> > replace quite a few instances of the softdep (ab)use.
> >>
> >> Another option has become available for expressing additional module
> >> dependencies, weakdeps. [1][2]  Long story short, weakdeps are similar
> >> to softdeps, in the sense of telling the initial ramdisk utilities to
> >> include additional kernel modules, but weakdeps result in no module
> >> loading being performed by userspace.
> >>
> >> Maybe "weak" isn't the best possible word choice (arguably, "soft"
> >> also
> >> wasn't the best word choice), but weakdeps should be a better choice
> >> for
> >> use with Lima and governor_simpleondemand, because weakdeps provide
> >> the
> >> required information to the utilities used to generate initial
> >> ramdisk,
> >> while the actual module loading is left to the kernel.
> >>
> >> The recent addition of weakdeps renders the previously mentioned
> >> harddeps
> >> obsolete, because weakdeps actually do what we need.  Obviously,
> >> "weak"
> >> doesn't go along very well with the actual nature of the dependency
> >> between
> >> Lima and governor_simpleondemand, but it's pretty much just the
> >> somewhat
> >> unfortunate word choice.
> >>
> >> The support for weakdeps has been already added to the kmod [3][4] and
> >> Dracut [5] userspace utilities.  I'll hopefully add support for
> >> weakdeps
> >> to mkinitcpio [6] rather soon.
> >>
> >> Maybe we could actually add MODULE_HARDDEP() as some kind of syntactic
> >> sugar, which would currently be an alias for MODULE_WEAKDEP(), so the
> >> actual hard module dependencies could be expressed properly, and
> >> possibly
> >> handled differently in the future, with no need to go back and track
> >> all
> >> such instances of hard module dependencies.
> >>
> >> With all this in mind, here's what I'm going to do:
> >>
> >> 1) Submit a patch that adds MODULE_HARDDEP() as syntactic sugar
> >> 2) Implement support for weakdeps in Arch Linux's mkinitcpio [6]
> >> 3) Depending on what kind of feedback the MODULE_HARDDEP() patch
> >> receives,
> >>     I'll submit follow-up patches for Lima and Panfrost, which will
> >> swap
> >>     uses of MODULE_SOFTDEP() with MODULE_HARDDEP() or MODULE_WEAKDEP()
> >>
> >> Looking forward to your thoughts.
> >>
> >> [1]
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/include/linux/module.h?id=3D61842868de13aa7fd7391c626e889f4d6f1450bf
> >> [2]
> >> https://lore.kernel.org/linux-kernel/20240724102349.430078-1-jtornosm@=
redhat.com/T/#u
> >> [3]
> >> https://github.com/kmod-project/kmod/commit/05828b4a6e9327a63ef94df544=
a042b5e9ce4fe7
> >> [4]
> >> https://github.com/kmod-project/kmod/commit/d06712b51404061eef92cb275b=
8303814fca86ec
> >> [5]
> >> https://github.com/dracut-ng/dracut-ng/commit/8517a6be5e20f4a6d87e55fc=
e35ee3e29e2a1150
> >> [6] https://gitlab.archlinux.org/archlinux/mkinitcpio/mkinitcpio

