Return-Path: <stable+bounces-92086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C34C9C3C71
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 11:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02B41C222E7
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BCE158555;
	Mon, 11 Nov 2024 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQi/vOmT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D14D184542
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322344; cv=none; b=FGoNtzF1A2HEHkazK7a4siZgHSeFvHbJDAxCKL5qw+puZaD2Fvk7kwP+ucEymDLOUo7T09VidOJoLc+AC4VFLkxqC3+BvJdHju7gtjrFMAUYV3i0q0J7QarECcEzNMRVcN+jUUWa5txSrli5iTmpVssqPIF7n4HeY7whMadsRV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322344; c=relaxed/simple;
	bh=OHcjLUvY9SuGHn5wUkXuhCKVulChLfLMK9DYpyDHWaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UgoBidWdxHN1dzdI45u7JI5lw/lf2EmUGZ2rVfMKnuk4tPQKk6kHPwRvb4fxAHwVz61GIgrRuR++n1UbJlar06T1lbDvVeOYbef6E3K9aEaleoDnOcAnk1HYFWzF8wyMKViX1bv4tgGTC8IrsaoiCgd8ir3xv8pPLXQ2JoHYkCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQi/vOmT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731322341; x=1762858341;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OHcjLUvY9SuGHn5wUkXuhCKVulChLfLMK9DYpyDHWaE=;
  b=JQi/vOmT2fjfKa2/r0728bf9lQmYaWyW0oHBloewPW+TsGWwS7yfYM6o
   7hI6CnHVbYMrd4J9vMiWZzTGK1Z9ANoFLI9bSspjueVVbAQhikYyDF2VV
   e5IE4YToVG9wfoEnSsJaH31Ugt7o679tDNVHQwxL1NEsJk3sFM/YHqcGl
   UKp02mZGkT14jz5IiqTIZSg3TCynOmrBi7wSo/iO03JgrdUGJubsB6Poy
   ELIcq2lel1JrFt3ese18zZtr2UDVmpL6FINk0H2xs1/ojxttnjd2yx4BV
   k7m/VtGUlrp+XEnGJXNUgF2AnKcrjk5gy4836jWsfjIV5EIBOS092rUT2
   Q==;
X-CSE-ConnectionGUID: KDMOV37cRBCSJuRsuoH0RQ==
X-CSE-MsgGUID: FKdGqLYjTB+G4ayIqS7f5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="30521176"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="30521176"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 02:52:21 -0800
X-CSE-ConnectionGUID: UlpSIoPKRXqxvAQVu5Eyaw==
X-CSE-MsgGUID: EAuf3Fo6SzepiY2vtBxbhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="86819592"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.244.91]) ([10.245.244.91])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 02:52:20 -0800
Message-ID: <690673f2-12c7-4b9a-b7d9-a3e6751661b1@intel.com>
Date: Mon, 11 Nov 2024 10:52:18 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe: improve hibernation on igpu
To: Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>
Cc: intel-xe@lists.freedesktop.org, stable@vger.kernel.org,
 ulisses.furquim@intel.com
References: <20241101170156.213490-2-matthew.auld@intel.com>
 <o3edyxjyz4fd5n53dmi2hntoacioufr3rqelxpn5mkbp6vvaue@v4nxwlz6gpte>
 <ZyUpAwD3jzlW+hbA@lstrano-desk.jf.intel.com>
 <zwfqm64323vefwfugk3tcjvhz4mnowbz6ekixeyinh5bmeap5k@hts3jqvzmwvj>
 <ZypgCGh/bCP8K7aK@lstrano-desk.jf.intel.com>
 <huirzn2ia4hs372ov7r77awhjun4fpezltrxcwfxgzzz4r3pga@h5jprda4zrir>
 <ZypxenMNvxL17mau@lstrano-desk.jf.intel.com>
 <u6gqllfd7gq5cg5o2pwljzmg54qbyow33vdzymxzclf4hgaxrr@uu3rr5wstwqq>
 <Zy6fACI72B1ERMEs@lstrano-desk.jf.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <Zy6fACI72B1ERMEs@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/11/2024 23:30, Matthew Brost wrote:
> On Fri, Nov 08, 2024 at 01:42:18PM -0600, Lucas De Marchi wrote:
>> On Tue, Nov 05, 2024 at 11:26:50AM -0800, Matthew Brost wrote:
>>> On Tue, Nov 05, 2024 at 01:18:27PM -0600, Lucas De Marchi wrote:
>>>> On Tue, Nov 05, 2024 at 10:12:24AM -0800, Matthew Brost wrote:
>>>>> On Tue, Nov 05, 2024 at 11:32:37AM -0600, Lucas De Marchi wrote:
>>>>>> On Fri, Nov 01, 2024 at 12:16:19PM -0700, Matthew Brost wrote:
>>>>>>> On Fri, Nov 01, 2024 at 12:38:19PM -0500, Lucas De Marchi wrote:
>>>>>>>> On Fri, Nov 01, 2024 at 05:01:57PM +0000, Matthew Auld wrote:
>>>>>>>>> The GGTT looks to be stored inside stolen memory on igpu which is not
>>>>>>>>> treated as normal RAM.  The core kernel skips this memory range when
>>>>>>>>> creating the hibernation image, therefore when coming back from
>>>>>>>>
>>>>>>>> can you add the log for e820 mapping to confirm?
>>>>>>>>
>>>>>>>>> hibernation the GGTT programming is lost. This seems to cause issues
>>>>>>>>> with broken resume where GuC FW fails to load:
>>>>>>>>>
>>>>>>>>> [drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 10ms, freq = 1250MHz (req 1300MHz), done = -1
>>>>>>>>> [drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
>>>>>>>>> [drm] *ERROR* GT0: firmware signature verification failed
>>>>>>>>> [drm] *ERROR* CRITICAL: Xe has declared device 0000:00:02.0 as wedged.
>>>>>>>>
>>>>>>>> it seems the message above is cut short. Just above these lines don't
>>>>>>>> you have a log with __xe_guc_upload? Which means: we actually upload the
>>>>>>>> firmware again to stolen and it doesn't matter that we lost it when
>>>>>>>> hibernating.
>>>>>>>>
>>>>>>>
>>>>>>> The image is always uploaded. The upload logic uses a GGTT address to
>>>>>>> find firmware image in SRAM...
>>>>>>>
>>>>>>> See snippet from uc_fw_xfer:
>>>>>>>
>>>>>>> 821         /* Set the source address for the uCode */
>>>>>>> 822         src_offset = uc_fw_ggtt_offset(uc_fw) + uc_fw->css_offset;
>>>>>>> 823         xe_mmio_write32(mmio, DMA_ADDR_0_LOW, lower_32_bits(src_offset));
>>>>>>> 824         xe_mmio_write32(mmio, DMA_ADDR_0_HIGH,
>>>>>>> 825                         upper_32_bits(src_offset) | DMA_ADDRESS_SPACE_GGTT);
>>>>>>>
>>>>>>> If the GGTT mappings are in stolen and not restored we will not be
>>>>>>> uploading the correct data for the image.
>>>>>>>
>>>>>>> See the gitlab issue, this has been confirmed to fix a real problem from
>>>>>>> a customer.
>>>>>>
>>>>>> I don't doubt it fixes it, but the justification here is not making much
>>>>>> sense.  AFAICS it doesn't really correspond to what the patch is doing.
>>>>>>
>>>>>>>
>>>>>>> Matt
>>>>>>>
>>>>>>>> It'd be good to know the size of the rsa key in the failing scenarios.
>>>>>>>>
>>>>>>>> Also it seems this is also reproduced in DG2 and I wonder if it's the
>>>>>>>> same issue or something different:
>>>>>>>>
>>>>>>>> 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000064 [0x32/00]
>>>>>>>> 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000072 [0x39/00]
>>>>>>>> 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000086 [0x43/00]
>>>>>>>> 	[drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 5ms, freq = 1700MHz (req 2050MHz), done = -1
>>>>>>>> 	[drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
>>>>>>>> 	[drm] *ERROR* GT0: firmware signature verification failed
>>>>>>>>
>>>>>>>> Cc Ulisses.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Current GGTT users are kernel internal and tracked as pinned, so it
>>>>>>>>> should be possible to hook into the existing save/restore logic that we
>>>>>>>>> use for dgpu, where the actual evict is skipped but on restore we
>>>>>>>>> importantly restore the GGTT programming.  This has been confirmed to
>>>>>>>>> fix hibernation on at least ADL and MTL, though likely all igpu
>>>>>>>>> platforms are affected.
>>>>>>>>>
>>>>>>>>> This also means we have a hole in our testing, where the existing s4
>>>>>>>>> tests only really test the driver hooks, and don't go as far as actually
>>>>>>>>> rebooting and restoring from the hibernation image and in turn powering
>>>>>>>>> down RAM (and therefore losing the contents of stolen).
>>>>>>>>
>>>>>>>> yeah, the problem is that enabling it to go through the entire sequence
>>>>>>>> we reproduce all kind of issues in other parts of the kernel and userspace
>>>>>>>> env leading to flaky tests that are usually red in CI. The most annoying
>>>>>>>> one is the network not coming back so we mark the test as failure
>>>>>>>> (actually abort. since we stop running everything).
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> v2 (Brost)
>>>>>>>>> - Remove extra newline and drop unnecessary parentheses.
>>>>>>>>>
>>>>>>>>> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>>>>>>>>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3275
>>>>>>>>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>>>>>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>>>>>> Cc: <stable@vger.kernel.org> # v6.8+
>>>>>>>>> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>>>>>>>>> ---
>>>>>>>>> drivers/gpu/drm/xe/xe_bo.c       | 37 ++++++++++++++------------------
>>>>>>>>> drivers/gpu/drm/xe/xe_bo_evict.c |  6 ------
>>>>>>>>> 2 files changed, 16 insertions(+), 27 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>>>>>>>>> index 8286cbc23721..549866da5cd1 100644
>>>>>>>>> --- a/drivers/gpu/drm/xe/xe_bo.c
>>>>>>>>> +++ b/drivers/gpu/drm/xe/xe_bo.c
>>>>>>>>> @@ -952,7 +952,10 @@ int xe_bo_restore_pinned(struct xe_bo *bo)
>>>>>>>>> 	if (WARN_ON(!xe_bo_is_pinned(bo)))
>>>>>>>>> 		return -EINVAL;
>>>>>>>>>
>>>>>>>>> -	if (WARN_ON(xe_bo_is_vram(bo) || !bo->ttm.ttm))
>>>>>>>>> +	if (WARN_ON(xe_bo_is_vram(bo)))
>>>>>>>>> +		return -EINVAL;
>>>>>>>>> +
>>>>>>>>> +	if (WARN_ON(!bo->ttm.ttm && !xe_bo_is_stolen(bo)))
>>>>>>>>> 		return -EINVAL;
>>>>>>>>>
>>>>>>>>> 	if (!mem_type_is_vram(place->mem_type))
>>>>>>>>> @@ -1774,6 +1777,7 @@ int xe_bo_pin_external(struct xe_bo *bo)
>>>>>>>>>
>>>>>>>>> int xe_bo_pin(struct xe_bo *bo)
>>>>>>>>> {
>>>>>>>>> +	struct ttm_place *place = &bo->placements[0];
>>>>>>>>> 	struct xe_device *xe = xe_bo_device(bo);
>>>>>>>>> 	int err;
>>>>>>>>>
>>>>>>>>> @@ -1804,8 +1808,6 @@ int xe_bo_pin(struct xe_bo *bo)
>>>>>>>>> 	 */
>>>>>>>>> 	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
>>>>>>>>> 	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
>>>>>>>>> -		struct ttm_place *place = &(bo->placements[0]);
>>>>>>>>> -
>>>>>>>>> 		if (mem_type_is_vram(place->mem_type)) {
>>>>>>>>> 			xe_assert(xe, place->flags & TTM_PL_FLAG_CONTIGUOUS);
>>>>>>>>>
>>>>>>>>> @@ -1813,13 +1815,12 @@ int xe_bo_pin(struct xe_bo *bo)
>>>>>>>>> 				       vram_region_gpu_offset(bo->ttm.resource)) >> PAGE_SHIFT;
>>>>>>>>> 			place->lpfn = place->fpfn + (bo->size >> PAGE_SHIFT);
>>>>>>>>> 		}
>>>>>>>>> +	}
>>>>>>>>>
>>>>>>>>> -		if (mem_type_is_vram(place->mem_type) ||
>>>>>>>>> -		    bo->flags & XE_BO_FLAG_GGTT) {
>>>>>>>>> -			spin_lock(&xe->pinned.lock);
>>>>>>>>> -			list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
>>>>>>>>> -			spin_unlock(&xe->pinned.lock);
>>>>>>>>> -		}
>>>>>>>>> +	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
>>>>>>
>>>>>>
>>>>>> again... why do you say we are restoring the GGTT itself? this seems
>>>>>> rather to allow pinning and then restoring anything that has
>>>>>> the XE_BO_FLAG_GGTT - that's any BO that uses the GGTT, not the GGTT.
>>>>>>
>>>>>
>>>>> I think what you are sayings is right - the patch restores every BOs
>>>>> GGTT mappings rather than restoring the entire contents of the GGTT.
>>>>>
>>>>> This might be a larger problem then as I think the scratch GGTT entries
>>>>> will not be restored - this is problem for both igpu and dgfx devices.
>>>>>
>>>>> This patch should help but is not complete.
>>>>>
>>>>> I think we need a follow up to either...
>>>>>
>>>>> 1. Setup all scratch pages in the GGTT prior to calling
>>>>> xe_bo_restore_kernel and use this flow to restore individual BOs GGTTs.
>>>>
>>>> yes, but for BOs already in system memory we don't need this flow - we
>>>> only need them to be mapped again.
>>>>
>>>
>>> Right. xe_bo_restore_pinned short circuits on a BO not being in VRAM. We could
>>> move that check out into xe_bo_restore_kernel though to avoid grabbing a system
>>
>> Ok. Let's get this in then. I was worried we'd copy the BOs elsewhere
>> and then restore and remap them. Now I see this short-circuit you
>> talked about.
>>
>> I still think it would be more desirable to actually save/restore the
>> page in question rather than go through this route that generates it
>> back by remapping the BOs.
>>
>> Anyway, it fixes the bug and uses infra that was already there for
>> discrete.
>>
> 
> Agree. May take stab at completely fixing our BO backup / restore to
> be not actually BO based at all...
> 
> Rather...
> 
> Backend entire GGTT in shim.
> Backend user VRAM in shim via GPU
> Backend kernel VRAM in shim via GPU.
> 
> Restore GGTT via shim + memcpy.
> Restore kernel VRAM via shim + memcpy.
> Restore user VRAM via shim via GPU.
> 
> I think this would be safer and make Thomas happy to not abuse TTM /
> take dma-resv locks in our suspend / resume code.
> 
> Anyways I pushed this one to drm-xe-next in hopes getting this in 6.12.

Back from some time off, thanks for taking care of this. I think we have 
some more issues with LNL: 
https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3409. Currently 
investigating this, but current thinking is that this is related to 
compression. I believe ccs state will also be in stolen memory, so 
likely we are also missing decompression or saving/restoring the ccs 
during hibernation...

> 
> Matt
> 
>> Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>
>> thanks
>> Lucas De Marchi
>>
>>> BOs dma-resv lock though. In either VRAM or system case xe_ggtt_map_bo is
>>> called.
>>>
>>> Matt
>>>
>>>>>
>>>>> 2. Drop restoring of individual BOs GGTTs entirely and save / restore
>>>>> the GGTTs contents.
>>>>
>>>> ... if we don't risk adding entries to discarded BOs. As long as the
>>>> save happens after invalidating the entries, I think it could work.
>>>>
>>>>>
>>>>> Does this make sense?
>>>>
>>>> yep, thanks.
>>>>
>>>> Lucas De Marchi


