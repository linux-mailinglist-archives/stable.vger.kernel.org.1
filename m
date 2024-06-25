Return-Path: <stable+bounces-55795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17085916FF8
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 20:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A201C23093
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 18:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BFC176AC5;
	Tue, 25 Jun 2024 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="loLhMqFG"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3F413BC2F;
	Tue, 25 Jun 2024 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339337; cv=none; b=MFVYAisWVYg8ZJPjNTxNVrSBDmSXdbqpmeHL82xEy87Nbmnqb3C7dt1Gubj/WvMvXOna5Dxyj2+P8jovro9Jy7qhe7/7CFLHuXLNq7x1W1wsCbCB9Dem19ZF8HXMv0GWVfNE54saOTmNQeQmzyKddX/gkYHKaKjdzPf2vCpSrwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339337; c=relaxed/simple;
	bh=c1YPqLsd/PZZOqnbat83z7KOPHi+vCF4g7CQiVRUy2s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cDHtsXjJVOvpA2suqjby11QoGRJfMuDoV/4skPDhSiL6M2jaR6F47NpSjXOhv1WwPm38VmMSxT0VL7BbA1FZPfqaLXnRsuNASwFS8Q2BTN4IB15wOpmBQWhQEUeqbnddB5+faDHmpRsfZ6S0w6pxVQmBLCwMezMRE1VcsPLrtR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=loLhMqFG; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1719339330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgdNz8GhllyBAYDE79E5X5a/W0pTJU2nuZpZ5CuBm9Y=;
	b=loLhMqFGKS6bl+M010SntmQrppSMI3Xofn9x7rk8E4RTpUG3G6QLUbKDo48mpoDNs2RTPz
	jl0MaMoiitpE+nfPzUqVIsuf8u71zBE9Je21l5lXOX8uPeL53iilUWIUzrmg6V1ZvguS68
	O0T9l1dPqQLy+38r79te0SQGprQz2rYQDVltW+312wy48MpH9MX9FwEZetjkIRKy2hKXmG
	xsjJQiYV/qmj8pfuIZXLphXSsBMYkScqjlzYRnHw4BMQ6Qh/Fq5CTJjOnxDa1ytqWy2SMW
	d5x5F5MfWuw20q7dkfv6oujwL6UoyfK0VkjsKFGAR2hqb3fr4EzihcDISc+HPw==
Date: Tue, 25 Jun 2024 20:15:28 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Qiang Yu <yuq825@gmail.com>, dri-devel@lists.freedesktop.org,
 lima@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 linux-kernel@vger.kernel.org, Philip Muller <philm@manjaro.org>, Oliver
 Smith <ollieparanoid@postmarketos.org>, Daniel Smith <danct12@disroot.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/lima: Mark simple_ondemand governor as softdep
In-Reply-To: <457ae7654dba38fcd8b50e38a1275461@manjaro.org>
References: <fdaf2e41bb6a0c5118ff9cc21f4f62583208d885.1718655070.git.dsimic@manjaro.org>
 <CAKGbVbs8VmCXVOHbhkCYEHNJiKWwy10p0SV9J09h2h7xjs7hUg@mail.gmail.com>
 <CAKGbVbsM4rCprWdp+aGXE-pvCkb6N7weUyG2z4nXqFpv+y=LrA@mail.gmail.com>
 <20240618-great-hissing-skink-b7950e@houat>
 <4813a6885648e5368028cd822e8b2381@manjaro.org>
 <457ae7654dba38fcd8b50e38a1275461@manjaro.org>
Message-ID: <2c072cc4bc800a0c52518fa2476ef9dd@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello everyone,

Just checking, any further thoughts about this patch?

On 2024-06-18 21:22, Dragan Simic wrote:
> On 2024-06-18 12:33, Dragan Simic wrote:
>> On 2024-06-18 10:13, Maxime Ripard wrote:
>>> On Tue, Jun 18, 2024 at 04:01:26PM GMT, Qiang Yu wrote:
>>>> On Tue, Jun 18, 2024 at 12:33 PM Qiang Yu <yuq825@gmail.com> wrote:
>>>> >
>>>> > I see the problem that initramfs need to build a module dependency chain,
>>>> > but lima does not call any symbol from simpleondemand governor module.
>>>> > softdep module seems to be optional while our dependency is hard one,
>>>> > can we just add MODULE_INFO(depends, _depends), or create a new
>>>> > macro called MODULE_DEPENDS()?
>> 
>> I had the same thoughts, because softdeps are for optional module
>> dependencies, while in this case it's a hard dependency.  Though,
>> I went with adding a softdep, simply because I saw no better option
>> available.
>> 
>>>> This doesn't work on my side because depmod generates modules.dep
>>>> by symbol lookup instead of modinfo section. So softdep may be our 
>>>> only
>>>> choice to add module dependency manually. I can accept the softdep
>>>> first, then make PM optional later.
>> 
>> I also thought about making devfreq optional in the Lima driver,
>> which would make this additional softdep much more appropriate.
>> Though, I'm not really sure that's a good approach, because not
>> having working devfreq for Lima might actually cause issues on
>> some devices, such as increased power consumption.
>> 
>> In other words, it might be better to have Lima probing fail if
>> devfreq can't be initialized, rather than having probing succeed
>> with no working devfreq.  Basically, failed probing is obvious,
>> while a warning in the kernel log about no devfreq might easily
>> be overlooked, causing regressions on some devices.
>> 
>>> It's still super fragile, and depends on the user not changing the
>>> policy. It should be solved in some other, more robust way.
>> 
>> I see, but I'm not really sure how to make it more robust?  In
>> the end, some user can blacklist the simple_ondemand governor
>> module, and we can't do much about it.
>> 
>> Introducing harddeps alongside softdeps would make sense from
>> the design standpoint, but the amount of required changes wouldn't
>> be trivial at all, on various levels.
> 
> After further investigation, it seems that the softdeps have
> already seen a fair amount of abuse for what they actually aren't
> intended, i.e. resolving hard dependencies.  For example, have
> a look at the commit d5178578bcd4 (btrfs: directly call into
> crypto framework for checksumming) [1] and the lines containing
> MODULE_SOFTDEP() at the very end of fs/btrfs/super.c. [2]
> 
> If a filesystem driver can rely on the abuse of softdeps, which
> admittedly are a bit fragile, I think we can follow the same
> approach, at least for now.
> 
> With all that in mind, I think that accepting this patch, as well
> as the related Panfrost patch, [3] should be warranted.  I'd keep
> investigating the possibility of introducing harddeps in form
> of MODULE_HARDDEP() and the related support in kmod project,
> similar to the already existing softdep support, [4] but that
> will inevitably take a lot of time, both for implementing it
> and for reaching various Linux distributions, which is another
> reason why accepting these patches seems reasonable.
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5178578bcd4
> [2] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/btrfs/super.c#n2593
> [3] 
> https://lore.kernel.org/dri-devel/4e1e00422a14db4e2a80870afb704405da16fd1b.1718655077.git.dsimic@manjaro.org/
> [4] 
> https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/commit/?id=49d8e0b59052999de577ab732b719cfbeb89504d

