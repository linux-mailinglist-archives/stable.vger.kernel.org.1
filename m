Return-Path: <stable+bounces-57943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344FB9263E1
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 16:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584F61C20A69
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 14:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A5F17E459;
	Wed,  3 Jul 2024 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="vKlkUWrY"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B4A17DE01;
	Wed,  3 Jul 2024 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018359; cv=none; b=KOsYcHAwtGylaK6y6XYhA8Z3tv2DzqeNbpRH2Ue9Rttij4IaLM2XjMb2cVvxDtEGZQMEWXBq74q5DNIhvzpWWR3ysG9cXSAg728tkEMcv9HEKTHzo+Xi09TdJ5o8OjypEZ/owEDCK3moTkHIa3Z6jHvH17yYQdut/aBjvHmZhQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018359; c=relaxed/simple;
	bh=HvGp07wavk1JrZaCJOVO3Zvyms04mXkjTItY8TJVo4I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=C6K+LbAMFHQ/KfkEbuOPZ7Dtp+djWmWQUK6vmB0cms1CUozEUjP25wLtT8GLsoHrtITLhZ/9g15I6TXVx9n+Qk4h3ogiAZN12DtODZyi1PcwI5vAGRd1S0um4mYoFJyWYPpbfPm5dFXb0WVFXcsSZJLOVEV0uElXefQD49Iup9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=vKlkUWrY; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1720018355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVm5E6swsesJb06uFJCAcatfBLzXL+iYie8HScXx3cM=;
	b=vKlkUWrYQaoJmbPXXISLT74VRiQWv32r99RgM5O1kWtx5Mv2m477cvHj8gp52amczXkFah
	lx14wum+G/sArou9KFA3+cv371EGwBCAmUEbc7uGCfknM7jGvRlwEAjPGFc4IrdvzJNmwp
	by2CJ9iD6+7gbLSo943NFtO6/yUQyokBdNrdTtrMbyiOeV1cEDWKrhATxJVU9u3psQgXa5
	q4mhkEI3lbpPvdZsBUkCpIRRL/o8TcmdkhlwvxHH31VT0BVokeBCuwvWO3/4/BHaa4rG53
	y0GwOh8sDu3UJSWTqbFCZpdTlOt8zc5G3urs03TVeET4/Womq/UcsF6Pn1yOlg==
Date: Wed, 03 Jul 2024 16:52:35 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Steven Price <steven.price@arm.com>
Cc: dri-devel@lists.freedesktop.org, boris.brezillon@collabora.com,
 robh@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 linux-kernel@vger.kernel.org, Diederik de Haas <didi.debian@cknow.org>,
 Furkan Kardame <f.kardame@manjaro.org>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: Mark simple_ondemand governor as softdep
In-Reply-To: <e42a55ba-cbb5-47a4-bec6-9c3067040970@arm.com>
References: <4e1e00422a14db4e2a80870afb704405da16fd1b.1718655077.git.dsimic@manjaro.org>
 <f672e7460c92bc9e0c195804f7e99d0b@manjaro.org>
 <e42a55ba-cbb5-47a4-bec6-9c3067040970@arm.com>
Message-ID: <192dbcd968dfebf825a3a759701bf381@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-07-03 15:20, Steven Price wrote:
> On 03/07/2024 13:42, Dragan Simic wrote:
>> On 2024-06-17 22:17, Dragan Simic wrote:
>>> Panfrost DRM driver uses devfreq to perform DVFS, while using
>>> simple_ondemand
>>> devfreq governor by default.  This causes driver initialization to
>>> fail on
>>> boot when simple_ondemand governor isn't built into the kernel
>>> statically,
>>> as a result of the missing module dependency and, consequently, the
>>> required
>>> governor module not being included in the initial ramdisk.  Thus,
>>> let's mark
>>> simple_ondemand governor as a softdep for Panfrost, to have its 
>>> kernel
>>> module
>>> included in the initial ramdisk.
>>> 
>>> This is a rather longstanding issue that has forced distributions to
>>> build
>>> devfreq governors statically into their kernels, [1][2] or has forced
>>> users
>>> to introduce some unnecessary workarounds. [3]
>>> 
>>> For future reference, not having support for the simple_ondemand
>>> governor in
>>> the initial ramdisk produces errors in the kernel log similar to 
>>> these
>>> below,
>>> which were taken from a Pine64 RockPro64:
>>> 
>>>   panfrost ff9a0000.gpu: [drm:panfrost_devfreq_init [panfrost]]
>>> *ERROR* Couldn't initialize GPU devfreq
>>>   panfrost ff9a0000.gpu: Fatal error during GPU init
>>>   panfrost: probe of ff9a0000.gpu failed with error -22
>>> 
>>> Having simple_ondemand marked as a softdep for Panfrost may not
>>> resolve this
>>> issue for all Linux distributions.  In particular, it will remain
>>> unresolved
>>> for the distributions whose utilities for the initial ramdisk
>>> generation do
>>> not handle the available softdep information [4] properly yet. 
>>> However, some
>>> Linux distributions already handle softdeps properly while generating
>>> their
>>> initial ramdisks, [5] and this is a prerequisite step in the right
>>> direction
>>> for the distributions that don't handle them properly yet.
>>> 
>>> [1]
>>> https://gitlab.manjaro.org/manjaro-arm/packages/core/linux/-/blob/linux61/config?ref_type=heads#L8180
>>> [2] https://salsa.debian.org/kernel-team/linux/-/merge_requests/1066
>>> [3] https://forum.pine64.org/showthread.php?tid=15458
>>> [4]
>>> https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/commit/?id=49d8e0b59052999de577ab732b719cfbeb89504d
>>> [5]
>>> https://github.com/archlinux/mkinitcpio/commit/97ac4d37aae084a050be512f6d8f4489054668ad
>>> 
>>> Cc: Diederik de Haas <didi.debian@cknow.org>
>>> Cc: Furkan Kardame <f.kardame@manjaro.org>
>>> Cc: stable@vger.kernel.org
>>> Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
>>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> 
> Reviewed-by: Steven Price <steven.price@arm.com>

Thanks!

>> Just checking, could this patch be accepted, please?  The Lima 
>> counterpart
>> has already been accepted. [6]
> 
> Thanks for the prod - I have to admit I saw there was discussion about
> the Lima patch and so just put this on my list to look again later 
> after
> the discussion had reached a conclusion.
> 
>> The approach in this patch is far from perfect, but it's still fine 
>> until
>> there's a better solution, such as harddeps.  I'll continue my 
>> research
>> about the possibility for introducing harddeps, which would hopefully
>> replace quite a few instances of the softdep (ab)use that already 
>> extend
>> rather far.  For example, have a look at the commit d5178578bcd4 
>> (btrfs:
>> directly call into crypto framework for checksumming) [7] and the 
>> lines
>> containing MODULE_SOFTDEP() at the very end of fs/btrfs/super.c. [8]
> 
> I agree - it's not perfect, but it's the best we have for now. I hope
> sometime we'll have a cleaner solution to express dependencies like 
> this
> (good luck! ;) ).

Thanks. :)  Implementing harddeps is _relatively_ straightforward, but
getting full support for harddeps reach various Linux distributions is
going to be an uphill battle without doubt. :)

>> If a filesystem driver can rely on the (ab)use of softdeps, which may 
>> be
>> fragile or seen as a bit wrong, I think we can follow the same 
>> approach,
>> at least until a better solution is available.
>> 
>> [6]
>> https://cgit.freedesktop.org/drm/drm-misc/commit/?id=0c94f58cef319ad054fd909b3bf4b7d09c03e11c
>> [7]
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5178578bcd4
>> [8]
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/btrfs/super.c#n2593
>> 
>>> ---
>>>  drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>> 
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c
>>> b/drivers/gpu/drm/panfrost/panfrost_drv.c
>>> index ef9f6c0716d5..149737d7a07e 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
>>> @@ -828,3 +828,4 @@ module_platform_driver(panfrost_driver);
>>>  MODULE_AUTHOR("Panfrost Project Developers");
>>>  MODULE_DESCRIPTION("Panfrost DRM Driver");
>>>  MODULE_LICENSE("GPL v2");
>>> +MODULE_SOFTDEP("pre: governor_simpleondemand");

