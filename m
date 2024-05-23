Return-Path: <stable+bounces-45619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351108CCC3F
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 08:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58371F21D82
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 06:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044D613B597;
	Thu, 23 May 2024 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vbw8JBUO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4267813B590
	for <stable@vger.kernel.org>; Thu, 23 May 2024 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716445764; cv=none; b=fe+blrPleQyOkmSykDLwsSgrSNb1bxnf1ux83ktljgsG6ZQvA0EMkVQrCa37NNHnwax8ZK2pXY+SCgOy/DuXtVJmeY+MCE5/9YE9uBgfPYlntta1DxtKszJnX1Qzu8rpSR6obzhPfIOygSHtywB6rk/psj/jw6zEzetfFehm7Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716445764; c=relaxed/simple;
	bh=DkeyImkNItoVz6DC0vz60wd++hgIhK2QXUuRObW2C6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNV/3BNCsEZLLRVFYlzIes6lzOgTtSm+cwiXTiWlvFfRj4MV1vIkjNK0ORXouHBaMcuL7HoQ7nyrn9xEg8YB8/Lfv9VRv5N40Lf3zATlndC9xHGUDEozgQDjccZ27+c9mYLC/IqGUTQ+UxQaSTYmLfoPW0Eflv0WSU2DzjOE84w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vbw8JBUO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716445763; x=1747981763;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DkeyImkNItoVz6DC0vz60wd++hgIhK2QXUuRObW2C6E=;
  b=Vbw8JBUONg2y5dKNr36PM7rD2dG2HH2ZK3OOvrst1QGXkJp8PmKqaeGT
   UL8eyRuhNPGCxx/2nfkTZzqsq8/FAJMr0b1sq4JejAq4HuBcrf08EjSQW
   +mh+nEQwljSqFw1uypXuSOrY/Q61l242vDqBjJq7RbjtJfDHD5mPIdPFF
   yzuUE2xRaRMVfPT31Ccx9lcV6TWM7nNrqcxIhuAYaKMDLUnNnrKWqle0s
   /Q2UzD1GQasXTv1delvVgkO9YvBb5uaiIBpEqXHL/z2jxrKk2xT5HwiKd
   EdVAP5nam21xHOfogWvmutoXIBpr8lv8bjLA73WnctHLDMrbgp5f9591l
   A==;
X-CSE-ConnectionGUID: NoYAi+nSToO0Vji2EvWAnw==
X-CSE-MsgGUID: Ur+cFiKeQCOjgStEDl9x7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12572838"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12572838"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 23:29:22 -0700
X-CSE-ConnectionGUID: uVz5PhSYQIW8DMJzIF/iuA==
X-CSE-MsgGUID: T/AAcBheQuC2pWJkGb6CMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="34021125"
Received: from jlawryno-mobl.ger.corp.intel.com (HELO [10.246.25.110]) ([10.246.25.110])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 23:29:20 -0700
Message-ID: <6f32bf37-e239-45f9-a41e-46fef2dc2cca@linux.intel.com>
Date: Thu, 23 May 2024 08:29:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/shmem-helper: Fix BUG_ON() on mmap(PROT_WRITE,
 MAP_PRIVATE)
To: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
 "Wachowski, Karol" <karol.wachowski@intel.com>,
 =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
 Eric Anholt <eric@anholt.net>, Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, stable@vger.kernel.org
References: <20240520100514.925681-1-jacek.lawrynowicz@linux.intel.com>
 <ZkyVyLVQn25taxCn@phenom.ffwll.local>
 <CAKMK7uFnOYJED0G2XJk4mf-dAD1VWrpVUvccFGz_g2sZSpTsVA@mail.gmail.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <CAKMK7uFnOYJED0G2XJk4mf-dAD1VWrpVUvccFGz_g2sZSpTsVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 21.05.2024 14:58, Daniel Vetter wrote:
> On Tue, 21 May 2024 at 14:38, Daniel Vetter <daniel@ffwll.ch> wrote:
>>
>> On Mon, May 20, 2024 at 12:05:14PM +0200, Jacek Lawrynowicz wrote:
>>> From: "Wachowski, Karol" <karol.wachowski@intel.com>
>>>
>>> Lack of check for copy-on-write (COW) mapping in drm_gem_shmem_mmap
>>> allows users to call mmap with PROT_WRITE and MAP_PRIVATE flag
>>> causing a kernel panic due to BUG_ON in vmf_insert_pfn_prot:
>>> BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
>>>
>>> Return -EINVAL early if COW mapping is detected.
>>>
>>> This bug affects all drm drivers using default shmem helpers.
>>> It can be reproduced by this simple example:
>>> void *ptr = mmap(0, size, PROT_WRITE, MAP_PRIVATE, fd, mmap_offset);
>>> ptr[0] = 0;
>>>
>>> Fixes: 2194a63a818d ("drm: Add library for shmem backed GEM objects")
>>> Cc: Noralf Trønnes <noralf@tronnes.org>
>>> Cc: Eric Anholt <eric@anholt.net>
>>> Cc: Rob Herring <robh@kernel.org>
>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>> Cc: Maxime Ripard <mripard@kernel.org>
>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>> Cc: David Airlie <airlied@gmail.com>
>>> Cc: Daniel Vetter <daniel@ffwll.ch>
>>> Cc: dri-devel@lists.freedesktop.org
>>> Cc: <stable@vger.kernel.org> # v5.2+
>>> Signed-off-by: Wachowski, Karol <karol.wachowski@intel.com>
>>> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
>>
>> Excellent catch!
>>
>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> I reviewed the other helpers, and ttm/vram helpers already block this with
>> the check in ttm_bo_mmap_obj.
>>
>> But the dma helpers does not, because the remap_pfn_range that underlies
>> the various dma_mmap* function (at least on most platforms) allows some
>> limited use of cow. But it makes no sense at all to all that only for
>> gpu buffer objects backed by specific allocators.
>>
>> Would you be up for the 2nd patch that also adds this check to
>> drm_gem_dma_mmap, so that we have a consistent uapi?
>>
>> I'll go ahead and apply this one to drm-misc-fixes meanwhile.
> 
> Forgot to add: A testcase in igt would also be really lovely.
> 
> https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#validating-changes-with-igt
> -Sima

OK, we will take a look at the test case.
We have no easy way to test dma helpers, so it would be best if someone using them could make a fix.


Regards,
Jacek

