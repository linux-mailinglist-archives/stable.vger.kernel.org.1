Return-Path: <stable+bounces-61367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FC993BDE0
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 10:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793561F218EC
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 08:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D816173355;
	Thu, 25 Jul 2024 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="kDO/nAF9"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AAC173344;
	Thu, 25 Jul 2024 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721895731; cv=none; b=c1j/7gi0NMUcOsYCyT/8hzE7epdAk+QEW4AZDHtQtoicTyrFJcEwjuCxuTPHa7Hu1tdKGsFp8gbMTw5Ywcep5iey1+QE90UaH+UNqVZMzRAs0phLCZKlQjzZ4mD9pt9LGL+WpDnvqZIM0I5G6Cx4P3wslf85GNn34G3C+Q17KoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721895731; c=relaxed/simple;
	bh=DsO4l+1CWvHLeuw2Pcg4JWgN6nEZDFclGCFVANyouVY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=jIzP1Nx0/GwyGOtWNNFppDPTZY++uik5iuE+Z3z0YzlueaRWCNqvYGo5toYkk9eqYe1/JhfhY0f76Iw2GaFASh/qNDX+6BtXaE14w1pG0qMIN1x07AY9iHRGTCe/nBlWJdO7z7+SaFmoWiM+2QJXe/GAzJJqh44TUgp5pryk0NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=kDO/nAF9; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721895718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wMuhPzhWYBQGZ7Bqktm49ddv+vjHbeLKw6H45dx/3w=;
	b=kDO/nAF9ITEj9v1PSHQ83bKtoeDY3A19jUWfNW7dlsUln/H79ExtlzjbnoNqrPjkS7uc/A
	O8DzdV/2FAk+B19EFWqrTrs8PgMHMXJHh320zwu+LGEMpbweyegRIS+xeRQ0nLjl1NUqWd
	i965o3sjMGR44J0hRJVjaBPe7bh3ESXWK3u/4PMl9OPXPnH7O7JG5xrfdrWZxdoFhurAXy
	KV9Qnx80zfh5NMmxE8EAUcugE6MTvYKe0bFjCsDepXu1mY0O64NECzsAbWeCM/f2xcBECR
	n50FFHTqFBaH0KZtly64dDmXtEPsOKdBOtzHA82wluEH81RaeWLSCQD/9jW+BQ==
Date: Thu, 25 Jul 2024 10:21:58 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Qiang Yu <yuq825@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 lima@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 linux-kernel@vger.kernel.org, Philip Muller <philm@manjaro.org>, Oliver
 Smith <ollieparanoid@postmarketos.org>, Daniel Smith <danct12@disroot.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/lima: Mark simple_ondemand governor as softdep
In-Reply-To: <74c69c3bb4498099a195ec890e1a7896@manjaro.org>
References: <fdaf2e41bb6a0c5118ff9cc21f4f62583208d885.1718655070.git.dsimic@manjaro.org>
 <CAKGbVbs8VmCXVOHbhkCYEHNJiKWwy10p0SV9J09h2h7xjs7hUg@mail.gmail.com>
 <CAKGbVbsM4rCprWdp+aGXE-pvCkb6N7weUyG2z4nXqFpv+y=LrA@mail.gmail.com>
 <20240618-great-hissing-skink-b7950e@houat>
 <4813a6885648e5368028cd822e8b2381@manjaro.org>
 <457ae7654dba38fcd8b50e38a1275461@manjaro.org>
 <2c072cc4bc800a0c52518fa2476ef9dd@manjaro.org>
 <CAKGbVbsGm7emEPzGuf0Xn5k22Pbjfg9J9ykJHtvDF3SacfDg6A@mail.gmail.com>
 <74c69c3bb4498099a195ec890e1a7896@manjaro.org>
Message-ID: <4498852466ec9b49cc5288c5f091b3ae@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Qiang,

On 2024-06-26 08:49, Dragan Simic wrote:
> On 2024-06-26 03:11, Qiang Yu wrote:
>> On Wed, Jun 26, 2024 at 2:15 AM Dragan Simic <dsimic@manjaro.org> 
>> wrote:
>>> Just checking, any further thoughts about this patch?
>>> 
>> I'm OK with this as a temp workaround because it's simple and do no 
>> harm
>> even it's not perfect. If no other better suggestion for short term, 
>> I'll submit
>> this at weekend.
> 
> Thanks.  Just as you described it, it's far from perfect, but it's 
> still
> fine until there's a better solution, such as harddeps.  I'll continue 
> my
> research about the possibility for adding harddeps, which would 
> hopefully
> replace quite a few instances of the softdep (ab)use.

Another option has become available for expressing additional module
dependencies, weakdeps. [1][2]  Long story short, weakdeps are similar
to softdeps, in the sense of telling the initial ramdisk utilities to
include additional kernel modules, but weakdeps result in no module
loading being performed by userspace.

Maybe "weak" isn't the best possible word choice (arguably, "soft" also
wasn't the best word choice), but weakdeps should be a better choice for
use with Lima and governor_simpleondemand, because weakdeps provide the
required information to the utilities used to generate initial ramdisk,
while the actual module loading is left to the kernel.

The recent addition of weakdeps renders the previously mentioned 
harddeps
obsolete, because weakdeps actually do what we need.  Obviously, "weak"
doesn't go along very well with the actual nature of the dependency 
between
Lima and governor_simpleondemand, but it's pretty much just the somewhat
unfortunate word choice.

The support for weakdeps has been already added to the kmod [3][4] and
Dracut [5] userspace utilities.  I'll hopefully add support for weakdeps
to mkinitcpio [6] rather soon.

Maybe we could actually add MODULE_HARDDEP() as some kind of syntactic
sugar, which would currently be an alias for MODULE_WEAKDEP(), so the
actual hard module dependencies could be expressed properly, and 
possibly
handled differently in the future, with no need to go back and track all
such instances of hard module dependencies.

With all this in mind, here's what I'm going to do:

1) Submit a patch that adds MODULE_HARDDEP() as syntactic sugar
2) Implement support for weakdeps in Arch Linux's mkinitcpio [6]
3) Depending on what kind of feedback the MODULE_HARDDEP() patch 
receives,
    I'll submit follow-up patches for Lima and Panfrost, which will swap
    uses of MODULE_SOFTDEP() with MODULE_HARDDEP() or MODULE_WEAKDEP()

Looking forward to your thoughts.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/module.h?id=61842868de13aa7fd7391c626e889f4d6f1450bf
[2] 
https://lore.kernel.org/linux-kernel/20240724102349.430078-1-jtornosm@redhat.com/T/#u
[3] 
https://github.com/kmod-project/kmod/commit/05828b4a6e9327a63ef94df544a042b5e9ce4fe7
[4] 
https://github.com/kmod-project/kmod/commit/d06712b51404061eef92cb275b8303814fca86ec
[5] 
https://github.com/dracut-ng/dracut-ng/commit/8517a6be5e20f4a6d87e55fce35ee3e29e2a1150
[6] https://gitlab.archlinux.org/archlinux/mkinitcpio/mkinitcpio


>>> On 2024-06-18 21:22, Dragan Simic wrote:
>>> > On 2024-06-18 12:33, Dragan Simic wrote:
>>> >> On 2024-06-18 10:13, Maxime Ripard wrote:
>>> >>> On Tue, Jun 18, 2024 at 04:01:26PM GMT, Qiang Yu wrote:
>>> >>>> On Tue, Jun 18, 2024 at 12:33 PM Qiang Yu <yuq825@gmail.com> wrote:
>>> >>>> >
>>> >>>> > I see the problem that initramfs need to build a module dependency chain,
>>> >>>> > but lima does not call any symbol from simpleondemand governor module.
>>> >>>> > softdep module seems to be optional while our dependency is hard one,
>>> >>>> > can we just add MODULE_INFO(depends, _depends), or create a new
>>> >>>> > macro called MODULE_DEPENDS()?
>>> >>
>>> >> I had the same thoughts, because softdeps are for optional module
>>> >> dependencies, while in this case it's a hard dependency.  Though,
>>> >> I went with adding a softdep, simply because I saw no better option
>>> >> available.
>>> >>
>>> >>>> This doesn't work on my side because depmod generates modules.dep
>>> >>>> by symbol lookup instead of modinfo section. So softdep may be our
>>> >>>> only
>>> >>>> choice to add module dependency manually. I can accept the softdep
>>> >>>> first, then make PM optional later.
>>> >>
>>> >> I also thought about making devfreq optional in the Lima driver,
>>> >> which would make this additional softdep much more appropriate.
>>> >> Though, I'm not really sure that's a good approach, because not
>>> >> having working devfreq for Lima might actually cause issues on
>>> >> some devices, such as increased power consumption.
>>> >>
>>> >> In other words, it might be better to have Lima probing fail if
>>> >> devfreq can't be initialized, rather than having probing succeed
>>> >> with no working devfreq.  Basically, failed probing is obvious,
>>> >> while a warning in the kernel log about no devfreq might easily
>>> >> be overlooked, causing regressions on some devices.
>>> >>
>>> >>> It's still super fragile, and depends on the user not changing the
>>> >>> policy. It should be solved in some other, more robust way.
>>> >>
>>> >> I see, but I'm not really sure how to make it more robust?  In
>>> >> the end, some user can blacklist the simple_ondemand governor
>>> >> module, and we can't do much about it.
>>> >>
>>> >> Introducing harddeps alongside softdeps would make sense from
>>> >> the design standpoint, but the amount of required changes wouldn't
>>> >> be trivial at all, on various levels.
>>> >
>>> > After further investigation, it seems that the softdeps have
>>> > already seen a fair amount of abuse for what they actually aren't
>>> > intended, i.e. resolving hard dependencies.  For example, have
>>> > a look at the commit d5178578bcd4 (btrfs: directly call into
>>> > crypto framework for checksumming) [1] and the lines containing
>>> > MODULE_SOFTDEP() at the very end of fs/btrfs/super.c. [2]
>>> >
>>> > If a filesystem driver can rely on the abuse of softdeps, which
>>> > admittedly are a bit fragile, I think we can follow the same
>>> > approach, at least for now.
>>> >
>>> > With all that in mind, I think that accepting this patch, as well
>>> > as the related Panfrost patch, [3] should be warranted.  I'd keep
>>> > investigating the possibility of introducing harddeps in form
>>> > of MODULE_HARDDEP() and the related support in kmod project,
>>> > similar to the already existing softdep support, [4] but that
>>> > will inevitably take a lot of time, both for implementing it
>>> > and for reaching various Linux distributions, which is another
>>> > reason why accepting these patches seems reasonable.
>>> >
>>> > [1]
>>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5178578bcd4
>>> > [2]
>>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/btrfs/super.c#n2593
>>> > [3]
>>> > https://lore.kernel.org/dri-devel/4e1e00422a14db4e2a80870afb704405da16fd1b.1718655077.git.dsimic@manjaro.org/
>>> > [4]
>>> > https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/commit/?id=49d8e0b59052999de577ab732b719cfbeb89504d

