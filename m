Return-Path: <stable+bounces-61833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C51E93CF2B
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 10:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2632B22E01
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 08:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984A717623C;
	Fri, 26 Jul 2024 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="YIz3S+HF"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C65C628;
	Fri, 26 Jul 2024 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981031; cv=none; b=r8xI/6mj8GVb7ApqxIC02aWCkvQyf1KYCIjOIXA7jqAUkJYy+HHxffX4rkrLa0ke3W9ppYGtKPRO5eVqGZq+YQ6CgEilkP7StoPK2Xq9eKfrk9MuShoMIiJGWHd4OUFWT1H7rFCtJvWC8IeLoiHgXro+OzrJGd3455QZpJrjxSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981031; c=relaxed/simple;
	bh=T7G8kbPOCKBslLz6ijMqfbTus8EEef8K47MGcLLco84=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fHuuXF6m9DIh+cPzwtHNlA48J0IaGwibeCmoW1E/Z+lIC1Ufpq9VuFnROHOXaSBUI7TxXqPvyhrEn6RGJS+Dkx8VHJQmSzQQeSc7XnaA9nd9i6pNzfMk7HsiTdqnULEFppp5C5hDvSkcykVpc8XS1RXqKxP2tHMw3GSd+y6jNw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=YIz3S+HF; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721981025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8uPrIS7FtTG+F0LixifOczxNj3Gwa/XPytcYJUQxkc=;
	b=YIz3S+HFZ1U9kVSIsss+N+OxjbI9a0ZWBIZI3fK5tPzzU1GZw1sqNahDfy6IMXDJ7gqjpQ
	uzdF241xTodV0FA9IzDGBHEj/5OEhi0r1/kPaBZ9RKCzbAA3pofeTwxlHwlEB9cvupzJtK
	929LuUhtOpdaYiaf5b7ZLzJBXCVTMV3wIcGxrlvyMpklpzU50vGtVoD/xiw9r+W7+Ruz6G
	vwjsKlnIPErcLYosVi4Hnldxd1d/RcUkVFwi0ums4pY8utYXpNKCbI3vPqbRoxfDF+A2ZH
	Mo1go5tgUXd6KFoMESZTJINIJ6do8PxYv+DJWEEEyY7I7Dy76HK7hBzvo8Ii5A==
Date: Fri, 26 Jul 2024 10:03:45 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Qiang Yu <yuq825@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 lima@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 linux-kernel@vger.kernel.org, Philip Muller <philm@manjaro.org>, Oliver
 Smith <ollieparanoid@postmarketos.org>, Daniel Smith <danct12@disroot.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/lima: Mark simple_ondemand governor as softdep
In-Reply-To: <CAKGbVbucXy+5Sn9U55DY69Lw9bQ+emmN1G4L8DQcUC1wdFSP_Q@mail.gmail.com>
References: <fdaf2e41bb6a0c5118ff9cc21f4f62583208d885.1718655070.git.dsimic@manjaro.org>
 <CAKGbVbs8VmCXVOHbhkCYEHNJiKWwy10p0SV9J09h2h7xjs7hUg@mail.gmail.com>
 <CAKGbVbsM4rCprWdp+aGXE-pvCkb6N7weUyG2z4nXqFpv+y=LrA@mail.gmail.com>
 <20240618-great-hissing-skink-b7950e@houat>
 <4813a6885648e5368028cd822e8b2381@manjaro.org>
 <457ae7654dba38fcd8b50e38a1275461@manjaro.org>
 <2c072cc4bc800a0c52518fa2476ef9dd@manjaro.org>
 <CAKGbVbsGm7emEPzGuf0Xn5k22Pbjfg9J9ykJHtvDF3SacfDg6A@mail.gmail.com>
 <74c69c3bb4498099a195ec890e1a7896@manjaro.org>
 <4498852466ec9b49cc5288c5f091b3ae@manjaro.org>
 <CAKGbVbucXy+5Sn9U55DY69Lw9bQ+emmN1G4L8DQcUC1wdFSP_Q@mail.gmail.com>
Message-ID: <7d1c35d6829f00fa62ea39b6fee656be@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Qiang Yu,

On 2024-07-26 08:07, Qiang Yu wrote:
> Yeah, I agree weakdep is a better choice here. It solves the confusion
> of softdep which the depend module is optional.

Thanks, I'm glad that you agree.

> But I prefer using weakdep directly instead of creating an aliasing of
> it which has no actual difference.

Just checking, did you have a chance to read what I wrote in my earlier
response on the linux-modules mailing list, [7] which includes a rather
elaborate explanation of the intent behind MODULE_HARDDEP being 
currently
just a proposed alias for MODULE_WEAKDEP?  It also describes why using
this alias might save use some time and effort in the future.

[7] 
https://lore.kernel.org/linux-modules/0720a516416a92a8f683053d37ee9481@manjaro.org/

> On Thu, Jul 25, 2024 at 4:21 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> 
>> Hello Qiang,
>> 
>> On 2024-06-26 08:49, Dragan Simic wrote:
>> > On 2024-06-26 03:11, Qiang Yu wrote:
>> >> On Wed, Jun 26, 2024 at 2:15 AM Dragan Simic <dsimic@manjaro.org>
>> >> wrote:
>> >>> Just checking, any further thoughts about this patch?
>> >>>
>> >> I'm OK with this as a temp workaround because it's simple and do no
>> >> harm
>> >> even it's not perfect. If no other better suggestion for short term,
>> >> I'll submit
>> >> this at weekend.
>> >
>> > Thanks.  Just as you described it, it's far from perfect, but it's
>> > still
>> > fine until there's a better solution, such as harddeps.  I'll continue
>> > my
>> > research about the possibility for adding harddeps, which would
>> > hopefully
>> > replace quite a few instances of the softdep (ab)use.
>> 
>> Another option has become available for expressing additional module
>> dependencies, weakdeps. [1][2]  Long story short, weakdeps are similar
>> to softdeps, in the sense of telling the initial ramdisk utilities to
>> include additional kernel modules, but weakdeps result in no module
>> loading being performed by userspace.
>> 
>> Maybe "weak" isn't the best possible word choice (arguably, "soft" 
>> also
>> wasn't the best word choice), but weakdeps should be a better choice 
>> for
>> use with Lima and governor_simpleondemand, because weakdeps provide 
>> the
>> required information to the utilities used to generate initial 
>> ramdisk,
>> while the actual module loading is left to the kernel.
>> 
>> The recent addition of weakdeps renders the previously mentioned
>> harddeps
>> obsolete, because weakdeps actually do what we need.  Obviously, 
>> "weak"
>> doesn't go along very well with the actual nature of the dependency
>> between
>> Lima and governor_simpleondemand, but it's pretty much just the 
>> somewhat
>> unfortunate word choice.
>> 
>> The support for weakdeps has been already added to the kmod [3][4] and
>> Dracut [5] userspace utilities.  I'll hopefully add support for 
>> weakdeps
>> to mkinitcpio [6] rather soon.
>> 
>> Maybe we could actually add MODULE_HARDDEP() as some kind of syntactic
>> sugar, which would currently be an alias for MODULE_WEAKDEP(), so the
>> actual hard module dependencies could be expressed properly, and
>> possibly
>> handled differently in the future, with no need to go back and track 
>> all
>> such instances of hard module dependencies.
>> 
>> With all this in mind, here's what I'm going to do:
>> 
>> 1) Submit a patch that adds MODULE_HARDDEP() as syntactic sugar
>> 2) Implement support for weakdeps in Arch Linux's mkinitcpio [6]
>> 3) Depending on what kind of feedback the MODULE_HARDDEP() patch
>> receives,
>>     I'll submit follow-up patches for Lima and Panfrost, which will 
>> swap
>>     uses of MODULE_SOFTDEP() with MODULE_HARDDEP() or MODULE_WEAKDEP()
>> 
>> Looking forward to your thoughts.
>> 
>> [1] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/module.h?id=61842868de13aa7fd7391c626e889f4d6f1450bf
>> [2] 
>> https://lore.kernel.org/linux-kernel/20240724102349.430078-1-jtornosm@redhat.com/T/#u
>> [3] 
>> https://github.com/kmod-project/kmod/commit/05828b4a6e9327a63ef94df544a042b5e9ce4fe7
>> [4] 
>> https://github.com/kmod-project/kmod/commit/d06712b51404061eef92cb275b8303814fca86ec
>> [5] 
>> https://github.com/dracut-ng/dracut-ng/commit/8517a6be5e20f4a6d87e55fce35ee3e29e2a1150
>> [6] https://gitlab.archlinux.org/archlinux/mkinitcpio/mkinitcpio

