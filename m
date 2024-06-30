Return-Path: <stable+bounces-56139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7550591D10A
	for <lists+stable@lfdr.de>; Sun, 30 Jun 2024 12:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98CD51C209D7
	for <lists+stable@lfdr.de>; Sun, 30 Jun 2024 10:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ECD12EBCA;
	Sun, 30 Jun 2024 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idMAzM3S"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E2912DDAE;
	Sun, 30 Jun 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719741888; cv=none; b=S553JQWCUQ7SKOq2oCRJcXFi4TvsPBIXwHZxsrSt6/hz7JJS1TGLHdjvyXciyzYMTL/e1wRyORwNVsCeVEmrXTv98Vd8iWweMcmJYET3y3c9qMSu12U+WhneTTqvukFg6QYYykYLU20Z7o+x4LWtbUHC1rsn6+Vw0FNLSDdjPEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719741888; c=relaxed/simple;
	bh=jd86wld+u7/8tOlPpDaYI6KLsajHvkeFtIARj5F5qQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVThE2HKUgsWxfHVUYGKvPAPlkePPY6+EaRigUE2knvkv3Y1iNULzN0Io3OE4avDtGEQANr7XaEHtaeKhOO9F23+WE1JgXLA+lZjkDnVwLT9PzGOXOVHFuV+QIvLAfzIcKOp2131qKbTZwG9PFObA6p+C+eeC/+7Q2b9/plxLDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idMAzM3S; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6fe617966fso159910566b.1;
        Sun, 30 Jun 2024 03:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719741885; x=1720346685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o617bWQRGL7AXpKHgsvXTyzvAX01tVJwbwYGMP9yg4c=;
        b=idMAzM3SG4FVXt/jHNPDg2T5rJQbAbHK/z+Td42Ud9nPosYG4krNAJg9S4qDsudiPk
         6OnPyTGS3cJTBooov8GLMkj2gYKmGk43MGXV+/fAWV1kixm7r7Z8u6tFfC2Opw5/bXck
         UKQYDTXnKHsjrBr72dDs8DRdZZNVNjpmMu2P/kFZjKb2uOJgHoFk+TFsAQuHap/4S++h
         5LGXIeUEAGfuHQyRO0jZFYH3h/KlTgQLZni8NwNWUEjlLJ/5Q67jwja2w0Y8rP1jvMHP
         wITbg0FwzbgZLo7DaodiLNbay05qQitvU3W9cDE6kr152c+Iw6cD42rkA2mWLlKm6jhF
         /GOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719741885; x=1720346685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o617bWQRGL7AXpKHgsvXTyzvAX01tVJwbwYGMP9yg4c=;
        b=T7mWcT2jXOT9rM/H2MEOxleAaB87ALCZxzmZfnTsz5dTHoNumRAMaCuCGmjP2EQXXD
         PSucBLXM64BDE2MoDp4Kd0H9bK1kMf29oZGIKJFW7a87cXT2o4ay/1CIfAZ6t9Isg7Ns
         2z3JkduBh0m+kg2W2mlidmq/wuZDasIobxNnHO2aEjGe1O4SX9Tjf7zIAzc2x6snxhEj
         fayJ55YKy4+aIREX7ClVWCdKQQU/6GF74FTT4S64wWQPbaNm6fmRJOXPcSbnoTHydCbu
         D3/0irkbQKQxLHkJZjSujoUVbGGRKeW5xZ6Y4JNTDwKH2oVDada2GSqg9ZJSTmroYmVD
         amyg==
X-Forwarded-Encrypted: i=1; AJvYcCUqt5Ta9TrrT3J40NakBevI1/7ChXpNiPuc0no6iTNhzS8B46iX05tBsPnSyPKI38rydYEwWZ0CyUE/jThHT+ZzEOzOhlcCifYxoEkHCFcZYwexhWNJh6JUDVnVxD5QmuiDMl6+
X-Gm-Message-State: AOJu0Yy7YP0HEZLbts2BmoEtTccGvvLsYeZx7sOTDIwIWLPHQld7eWQQ
	NnMrXul7aY/ZUZXgSOH0ijUiNyy6KcjjRoJQ1EKcJdc7KwE6xD6ZfIGJ6d3KzBfskkazKjcI+F7
	rsauRgWjY1IOrMeU1/u2XDrH5FVs=
X-Google-Smtp-Source: AGHT+IFPqEU+V1VDRuCLs1LVF3C/KXP2R6B7s5PTM8+z/ve2MiGYbV7HExEQvJFtLMY2yJcfKaeSiA78h2EcS2EpMnE=
X-Received: by 2002:a17:906:bc90:b0:a6f:f1bc:21ce with SMTP id
 a640c23a62f3a-a75144f666amr161051366b.47.1719741884561; Sun, 30 Jun 2024
 03:04:44 -0700 (PDT)
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
 <CAKGbVbsGm7emEPzGuf0Xn5k22Pbjfg9J9ykJHtvDF3SacfDg6A@mail.gmail.com> <74c69c3bb4498099a195ec890e1a7896@manjaro.org>
In-Reply-To: <74c69c3bb4498099a195ec890e1a7896@manjaro.org>
From: Qiang Yu <yuq825@gmail.com>
Date: Sun, 30 Jun 2024 18:04:31 +0800
Message-ID: <CAKGbVbvDdLMAS9Z4yDtY2gmaqM9SGgk7z38Kb0EzWX_y42XE3Q@mail.gmail.com>
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

Applied to drm-misc-next.

On Wed, Jun 26, 2024 at 2:49=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Qiang,
>
> On 2024-06-26 03:11, Qiang Yu wrote:
> > On Wed, Jun 26, 2024 at 2:15=E2=80=AFAM Dragan Simic <dsimic@manjaro.or=
g>
> > wrote:
> >>
> >> Hello everyone,
> >>
> >> Just checking, any further thoughts about this patch?
> >>
> > I'm OK with this as a temp workaround because it's simple and do no
> > harm
> > even it's not perfect. If no other better suggestion for short term,
> > I'll submit
> > this at weekend.
>
> Thanks.  Just as you described it, it's far from perfect, but it's still
> fine until there's a better solution, such as harddeps.  I'll continue
> my
> research about the possibility for adding harddeps, which would
> hopefully
> replace quite a few instances of the softdep (ab)use.
>
> >> On 2024-06-18 21:22, Dragan Simic wrote:
> >> > On 2024-06-18 12:33, Dragan Simic wrote:
> >> >> On 2024-06-18 10:13, Maxime Ripard wrote:
> >> >>> On Tue, Jun 18, 2024 at 04:01:26PM GMT, Qiang Yu wrote:
> >> >>>> On Tue, Jun 18, 2024 at 12:33=E2=80=AFPM Qiang Yu <yuq825@gmail.c=
om> wrote:
> >> >>>> >
> >> >>>> > I see the problem that initramfs need to build a module depende=
ncy chain,
> >> >>>> > but lima does not call any symbol from simpleondemand governor =
module.
> >> >>>> > softdep module seems to be optional while our dependency is har=
d one,
> >> >>>> > can we just add MODULE_INFO(depends, _depends), or create a new
> >> >>>> > macro called MODULE_DEPENDS()?
> >> >>
> >> >> I had the same thoughts, because softdeps are for optional module
> >> >> dependencies, while in this case it's a hard dependency.  Though,
> >> >> I went with adding a softdep, simply because I saw no better option
> >> >> available.
> >> >>
> >> >>>> This doesn't work on my side because depmod generates modules.dep
> >> >>>> by symbol lookup instead of modinfo section. So softdep may be ou=
r
> >> >>>> only
> >> >>>> choice to add module dependency manually. I can accept the softde=
p
> >> >>>> first, then make PM optional later.
> >> >>
> >> >> I also thought about making devfreq optional in the Lima driver,
> >> >> which would make this additional softdep much more appropriate.
> >> >> Though, I'm not really sure that's a good approach, because not
> >> >> having working devfreq for Lima might actually cause issues on
> >> >> some devices, such as increased power consumption.
> >> >>
> >> >> In other words, it might be better to have Lima probing fail if
> >> >> devfreq can't be initialized, rather than having probing succeed
> >> >> with no working devfreq.  Basically, failed probing is obvious,
> >> >> while a warning in the kernel log about no devfreq might easily
> >> >> be overlooked, causing regressions on some devices.
> >> >>
> >> >>> It's still super fragile, and depends on the user not changing the
> >> >>> policy. It should be solved in some other, more robust way.
> >> >>
> >> >> I see, but I'm not really sure how to make it more robust?  In
> >> >> the end, some user can blacklist the simple_ondemand governor
> >> >> module, and we can't do much about it.
> >> >>
> >> >> Introducing harddeps alongside softdeps would make sense from
> >> >> the design standpoint, but the amount of required changes wouldn't
> >> >> be trivial at all, on various levels.
> >> >
> >> > After further investigation, it seems that the softdeps have
> >> > already seen a fair amount of abuse for what they actually aren't
> >> > intended, i.e. resolving hard dependencies.  For example, have
> >> > a look at the commit d5178578bcd4 (btrfs: directly call into
> >> > crypto framework for checksumming) [1] and the lines containing
> >> > MODULE_SOFTDEP() at the very end of fs/btrfs/super.c. [2]
> >> >
> >> > If a filesystem driver can rely on the abuse of softdeps, which
> >> > admittedly are a bit fragile, I think we can follow the same
> >> > approach, at least for now.
> >> >
> >> > With all that in mind, I think that accepting this patch, as well
> >> > as the related Panfrost patch, [3] should be warranted.  I'd keep
> >> > investigating the possibility of introducing harddeps in form
> >> > of MODULE_HARDDEP() and the related support in kmod project,
> >> > similar to the already existing softdep support, [4] but that
> >> > will inevitably take a lot of time, both for implementing it
> >> > and for reaching various Linux distributions, which is another
> >> > reason why accepting these patches seems reasonable.
> >> >
> >> > [1]
> >> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3Dd5178578bcd4
> >> > [2]
> >> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/fs/btrfs/super.c#n2593
> >> > [3]
> >> > https://lore.kernel.org/dri-devel/4e1e00422a14db4e2a80870afb704405da=
16fd1b.1718655077.git.dsimic@manjaro.org/
> >> > [4]
> >> > https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/commit/?id=
=3D49d8e0b59052999de577ab732b719cfbeb89504d

