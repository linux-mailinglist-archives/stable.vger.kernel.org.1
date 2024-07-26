Return-Path: <stable+bounces-61821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C1193CDF7
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 08:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7231F22ED8
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 06:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF776BFA5;
	Fri, 26 Jul 2024 06:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfuul+PQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA0F33981;
	Fri, 26 Jul 2024 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721974037; cv=none; b=iSA9mn2sidcB93ldOFixDJkeJkiHoRu/OIzgQyvDMII9r4lD+OJoR6WG2/8IXtynt6DahbyG3yG1jUo1xy/qll14k/dyVuejyE5EMefob721JUVAO2pT9TUewpkk2JArTxRXy1JvVNZUGEaL0dcHVLnDJIokcuoOCi50UtIrgyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721974037; c=relaxed/simple;
	bh=RMq69Pt8L8ftcbbVlf9prk5OtZRZm0vIgy7wckj/miU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMFx4ltwhKMJ8u6sWHT2X6eTZWCOk0K6UlriR3vIn3e6diQBjLQs250T96PvWOP+l5D+ixW3e4E3H1Q9o7/VTaoTzC+Ia/IJgBLUkvHOrZBf5/BwAMnUJC0KEhH8du8f4uby4NJjgPRCezgHY1bdDBoMWyC8GkiMjtr5HF1n8J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfuul+PQ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5ab2baf13d9so2057692a12.2;
        Thu, 25 Jul 2024 23:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721974034; x=1722578834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ubfjr6Ocr6zIe1L+xjePz5kd4NB55lZQYC/gSXU9YFY=;
        b=dfuul+PQuYh2VJWdwrc7S1IqUIIyp37mtUx4XnL1Wf7vAasMCWgEoAXPIJjM5UdKuO
         uSb5ad32TiTNbksaBATXIY/DljF2a1w4sMifNs34YD9b2wBgtXzNf2AmnZ5+44wVr0Gp
         g4TuvPCT8zOo4pr0G6s2mY7Nzk/tUfC0RqZXyY+lye7MqH1cnp1/wz+jykL7+5jK4CZy
         n/Mw4HyysUkmvFEuwiEtjGzSpO79KaCXXdIa2E9SdZreS7y8+rwIf5nnyp4kgeKt6lPq
         cP2aPe6FU7q7ZCZNMohZwz0BwFuLsi4RexPLwHYh7NYARTB7ORzizdHt1AUYIhDd/zm/
         i3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721974034; x=1722578834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ubfjr6Ocr6zIe1L+xjePz5kd4NB55lZQYC/gSXU9YFY=;
        b=DB/NHBJGj0HK1nLk0TfWFa5u7f7u5ZSyhaGSBnfOW+34dhAXWJV2bzVHqdhq9ihqqx
         fcNiMPbKV2AUbMQ471GYbAQDZoEZ/2xXhDfygjTe9tf/yic4dHORDQeP2OdhUzA4/sFX
         rzRYg3gPAMfDmUQ+liC/YTrlbpv7jmXmadqi3XftZE9gUbmSFhzA7XSh2+FnQj1eKVJx
         TML3vydPw4GnVK3LHThknQFn6CiUnZKsLXqUynqppAsxYIWKm0nl/AenEOSacG+ggrGp
         c2/f0LIgYSQe0zo82PYkIPbCJCHHZAcaic3zG2sdO6JKxzxAwcmT//I0MNPMMQQrM6Qm
         DfPw==
X-Forwarded-Encrypted: i=1; AJvYcCWvcQIWOIACzK0drl7SbJSjnIFvXnrLGzgCg/1K0PLcmjWaOYxJYrdvO89KPk7Q6HLUfZdVGTVB5c2u+HOKy+Gwc2725NlwQLtVHDMTtWx7yWkuPN4+ITNwPmPiCleU9AOYRxKj
X-Gm-Message-State: AOJu0Yy2BBoB0/JxayS/nPaOJdYimrRaoIlmmhDmzZ5Rflz/bPh4FQlS
	+TaTRGRnmxn1yWUNGYh9YOEH1xK/MUYCu1ACX91n/CEf+eoUsv02idfXNTmPGp0u0gVhZZ0bUPS
	4l+FPQhTg3yepJsjARR7LiujSTsU=
X-Google-Smtp-Source: AGHT+IF/8fsIqJNpHOQWbxaBZMMiIh8eN6Ok33gem04j1/xzwJevpoSeZ1YXaFHsr8hA02wHqBoPf77/NGAqKnNq7EE=
X-Received: by 2002:a05:6402:5111:b0:5a3:d140:1a52 with SMTP id
 4fb4d7f45d1cf-5ac2a0ee946mr3705266a12.3.1721974033145; Thu, 25 Jul 2024
 23:07:13 -0700 (PDT)
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
In-Reply-To: <4498852466ec9b49cc5288c5f091b3ae@manjaro.org>
From: Qiang Yu <yuq825@gmail.com>
Date: Fri, 26 Jul 2024 14:07:00 +0800
Message-ID: <CAKGbVbucXy+5Sn9U55DY69Lw9bQ+emmN1G4L8DQcUC1wdFSP_Q@mail.gmail.com>
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

Yeah, I agree weakdep is a better choice here. It solves the confusion
of softdep
which the depend module is optional.

But I prefer using weakdep directly instead of creating an aliasing of
it which has
no actual difference.


On Thu, Jul 25, 2024 at 4:21=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Qiang,
>
> On 2024-06-26 08:49, Dragan Simic wrote:
> > On 2024-06-26 03:11, Qiang Yu wrote:
> >> On Wed, Jun 26, 2024 at 2:15=E2=80=AFAM Dragan Simic <dsimic@manjaro.o=
rg>
> >> wrote:
> >>> Just checking, any further thoughts about this patch?
> >>>
> >> I'm OK with this as a temp workaround because it's simple and do no
> >> harm
> >> even it's not perfect. If no other better suggestion for short term,
> >> I'll submit
> >> this at weekend.
> >
> > Thanks.  Just as you described it, it's far from perfect, but it's
> > still
> > fine until there's a better solution, such as harddeps.  I'll continue
> > my
> > research about the possibility for adding harddeps, which would
> > hopefully
> > replace quite a few instances of the softdep (ab)use.
>
> Another option has become available for expressing additional module
> dependencies, weakdeps. [1][2]  Long story short, weakdeps are similar
> to softdeps, in the sense of telling the initial ramdisk utilities to
> include additional kernel modules, but weakdeps result in no module
> loading being performed by userspace.
>
> Maybe "weak" isn't the best possible word choice (arguably, "soft" also
> wasn't the best word choice), but weakdeps should be a better choice for
> use with Lima and governor_simpleondemand, because weakdeps provide the
> required information to the utilities used to generate initial ramdisk,
> while the actual module loading is left to the kernel.
>
> The recent addition of weakdeps renders the previously mentioned
> harddeps
> obsolete, because weakdeps actually do what we need.  Obviously, "weak"
> doesn't go along very well with the actual nature of the dependency
> between
> Lima and governor_simpleondemand, but it's pretty much just the somewhat
> unfortunate word choice.
>
> The support for weakdeps has been already added to the kmod [3][4] and
> Dracut [5] userspace utilities.  I'll hopefully add support for weakdeps
> to mkinitcpio [6] rather soon.
>
> Maybe we could actually add MODULE_HARDDEP() as some kind of syntactic
> sugar, which would currently be an alias for MODULE_WEAKDEP(), so the
> actual hard module dependencies could be expressed properly, and
> possibly
> handled differently in the future, with no need to go back and track all
> such instances of hard module dependencies.
>
> With all this in mind, here's what I'm going to do:
>
> 1) Submit a patch that adds MODULE_HARDDEP() as syntactic sugar
> 2) Implement support for weakdeps in Arch Linux's mkinitcpio [6]
> 3) Depending on what kind of feedback the MODULE_HARDDEP() patch
> receives,
>     I'll submit follow-up patches for Lima and Panfrost, which will swap
>     uses of MODULE_SOFTDEP() with MODULE_HARDDEP() or MODULE_WEAKDEP()
>
> Looking forward to your thoughts.
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/include/linux/module.h?id=3D61842868de13aa7fd7391c626e889f4d6f1450bf
> [2]
> https://lore.kernel.org/linux-kernel/20240724102349.430078-1-jtornosm@red=
hat.com/T/#u
> [3]
> https://github.com/kmod-project/kmod/commit/05828b4a6e9327a63ef94df544a04=
2b5e9ce4fe7
> [4]
> https://github.com/kmod-project/kmod/commit/d06712b51404061eef92cb275b830=
3814fca86ec
> [5]
> https://github.com/dracut-ng/dracut-ng/commit/8517a6be5e20f4a6d87e55fce35=
ee3e29e2a1150
> [6] https://gitlab.archlinux.org/archlinux/mkinitcpio/mkinitcpio
>
>
> >>> On 2024-06-18 21:22, Dragan Simic wrote:
> >>> > On 2024-06-18 12:33, Dragan Simic wrote:
> >>> >> On 2024-06-18 10:13, Maxime Ripard wrote:
> >>> >>> On Tue, Jun 18, 2024 at 04:01:26PM GMT, Qiang Yu wrote:
> >>> >>>> On Tue, Jun 18, 2024 at 12:33=E2=80=AFPM Qiang Yu <yuq825@gmail.=
com> wrote:
> >>> >>>> >
> >>> >>>> > I see the problem that initramfs need to build a module depend=
ency chain,
> >>> >>>> > but lima does not call any symbol from simpleondemand governor=
 module.
> >>> >>>> > softdep module seems to be optional while our dependency is ha=
rd one,
> >>> >>>> > can we just add MODULE_INFO(depends, _depends), or create a ne=
w
> >>> >>>> > macro called MODULE_DEPENDS()?
> >>> >>
> >>> >> I had the same thoughts, because softdeps are for optional module
> >>> >> dependencies, while in this case it's a hard dependency.  Though,
> >>> >> I went with adding a softdep, simply because I saw no better optio=
n
> >>> >> available.
> >>> >>
> >>> >>>> This doesn't work on my side because depmod generates modules.de=
p
> >>> >>>> by symbol lookup instead of modinfo section. So softdep may be o=
ur
> >>> >>>> only
> >>> >>>> choice to add module dependency manually. I can accept the softd=
ep
> >>> >>>> first, then make PM optional later.
> >>> >>
> >>> >> I also thought about making devfreq optional in the Lima driver,
> >>> >> which would make this additional softdep much more appropriate.
> >>> >> Though, I'm not really sure that's a good approach, because not
> >>> >> having working devfreq for Lima might actually cause issues on
> >>> >> some devices, such as increased power consumption.
> >>> >>
> >>> >> In other words, it might be better to have Lima probing fail if
> >>> >> devfreq can't be initialized, rather than having probing succeed
> >>> >> with no working devfreq.  Basically, failed probing is obvious,
> >>> >> while a warning in the kernel log about no devfreq might easily
> >>> >> be overlooked, causing regressions on some devices.
> >>> >>
> >>> >>> It's still super fragile, and depends on the user not changing th=
e
> >>> >>> policy. It should be solved in some other, more robust way.
> >>> >>
> >>> >> I see, but I'm not really sure how to make it more robust?  In
> >>> >> the end, some user can blacklist the simple_ondemand governor
> >>> >> module, and we can't do much about it.
> >>> >>
> >>> >> Introducing harddeps alongside softdeps would make sense from
> >>> >> the design standpoint, but the amount of required changes wouldn't
> >>> >> be trivial at all, on various levels.
> >>> >
> >>> > After further investigation, it seems that the softdeps have
> >>> > already seen a fair amount of abuse for what they actually aren't
> >>> > intended, i.e. resolving hard dependencies.  For example, have
> >>> > a look at the commit d5178578bcd4 (btrfs: directly call into
> >>> > crypto framework for checksumming) [1] and the lines containing
> >>> > MODULE_SOFTDEP() at the very end of fs/btrfs/super.c. [2]
> >>> >
> >>> > If a filesystem driver can rely on the abuse of softdeps, which
> >>> > admittedly are a bit fragile, I think we can follow the same
> >>> > approach, at least for now.
> >>> >
> >>> > With all that in mind, I think that accepting this patch, as well
> >>> > as the related Panfrost patch, [3] should be warranted.  I'd keep
> >>> > investigating the possibility of introducing harddeps in form
> >>> > of MODULE_HARDDEP() and the related support in kmod project,
> >>> > similar to the already existing softdep support, [4] but that
> >>> > will inevitably take a lot of time, both for implementing it
> >>> > and for reaching various Linux distributions, which is another
> >>> > reason why accepting these patches seems reasonable.
> >>> >
> >>> > [1]
> >>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Dd5178578bcd4
> >>> > [2]
> >>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/fs/btrfs/super.c#n2593
> >>> > [3]
> >>> > https://lore.kernel.org/dri-devel/4e1e00422a14db4e2a80870afb704405d=
a16fd1b.1718655077.git.dsimic@manjaro.org/
> >>> > [4]
> >>> > https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/commit/?i=
d=3D49d8e0b59052999de577ab732b719cfbeb89504d

