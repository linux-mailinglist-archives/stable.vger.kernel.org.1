Return-Path: <stable+bounces-268966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X8SpOIyWPmp0IgkAu9opvQ
	(envelope-from <stable+bounces-268966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:11:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AACF6CE598
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:11:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Ou9zimq9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268966-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268966-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7177E3082E58
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6CE37AA87;
	Fri, 26 Jun 2026 15:07:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE5B379C55
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 15:07:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486431; cv=none; b=Sp0guvl1Oe3tdeSwx1eP4Qe288ZZyMfkTLfOmIykBlk0sQFBajVWE90mJYCvX1d7jjVUGbRpQzN5wFxEMBGiWypl9dOT04R4Z+yIOUX0YoN1x548LxrxUhVw2OrGNheJdBHldbgvO7RUbziHaDBW02u0gC3wGoYvgplr/77mLtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486431; c=relaxed/simple;
	bh=sMAUKDeidRfha7YaQL3BkoGzplItdf7D1VROiHjazYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esBrjMs8NJd1IQBrbYBDneD84T4UDRjLS7pFvf3MA2nyTPcp/41hKtcOOyAt0QkrBoB7mOlTzFxts2Ojec8d5P4EZQ5uJsKYOu3eAUnBNwRSvOz4XBZriOQjOXPzyGo0//UZPcXOkpq6zwPasZ82w1eqj/GBiYrMx5gJEkWoT/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ou9zimq9; arc=none smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782486425; x=1814022425;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sMAUKDeidRfha7YaQL3BkoGzplItdf7D1VROiHjazYk=;
  b=Ou9zimq9sg3NJXBWXj8p5MT8ZU2GhYr8uVc/MP3+uis4xRFJzKMtUAuO
   8VK99Wh98WACq74D72tZAvMN08ay7zFNRNQhCNngQnhyJpG4OLJPbsgog
   ro7xP19g+WJWyXxt50fr1zxVocwnWaroayPvii3R0KesoiWrRjni0MOQa
   X1duEx6U95V3YLvKgrmRehGhp9RGQV/8N1eTyqcYlmENcOyQr2Od6hOlX
   v08WN9z+MU9qZh0oLgBVn1410R+0wkq4w0ZoP75G5ZV40L1Pyr5hY2T7E
   Ap4MxMcyoJ5CQA/vrKx2HrL+6e8i0CwlNs/SjADcPP589xtfhn2hSQHnK
   w==;
X-CSE-ConnectionGUID: SzR2jl/wQqCKIMc/yrIJSA==
X-CSE-MsgGUID: SJsPLESoSE278+RhbG2nVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="93934292"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="93934292"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 08:07:03 -0700
X-CSE-ConnectionGUID: XIPvQGblQRuGhbUgSgQjBw==
X-CSE-MsgGUID: 8yyP9Tk8SnW/bdb3qCOT7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="250266147"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.244.49]) ([10.245.244.49])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 08:07:01 -0700
Message-ID: <ba1c7833-fb68-48ad-a8ce-fbc3f5387dec@intel.com>
Date: Fri, 26 Jun 2026 16:06:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/display: consider DPT when WA 22019338487 is
 active
To: Maarten Lankhorst <dev@lankhorst.se>, intel-xe@lists.freedesktop.org
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Nikolay Mikhaylov <sonny@milton.pro>,
 Uma Shankar <uma.shankar@intel.com>, Jani Nikula <jani.nikula@intel.com>,
 stable@vger.kernel.org
References: <20260623090155.268763-2-matthew.auld@intel.com>
 <9e04ec82-712d-41b6-9fe8-78aeb015d67c@intel.com>
 <9924291e-5108-41b3-9131-12b292e8bcd2@lankhorst.se>
 <dd6a1825-9c22-4c94-9ab5-7ccd24f96990@intel.com>
 <d6d3687d-3635-45c9-b5fc-42106d8e7019@lankhorst.se>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <d6d3687d-3635-45c9-b5fc-42106d8e7019@lankhorst.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268966-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dev@lankhorst.se,m:intel-xe@lists.freedesktop.org,m:thomas.hellstrom@linux.intel.com,m:matthew.brost@intel.com,m:rodrigo.vivi@intel.com,m:sonny@milton.pro,m:uma.shankar@intel.com,m:jani.nikula@intel.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,milton.pro:email,gitlab.freedesktop.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AACF6CE598

On 26/06/2026 15:53, Maarten Lankhorst wrote:
> Hey,
> 
> On 6/26/26 16:32, Matthew Auld wrote:
>> On 26/06/2026 14:37, Maarten Lankhorst wrote:
>>> Hey,
>>>
>>> On 6/26/26 12:27, Matthew Auld wrote:
>>>> On 23/06/2026 10:01, Matthew Auld wrote:
>>>>> WA 22019338487 (22019338487_display) indicates that stolen memory should
>>>>> not be used for display allocations on affected platforms (like Lunar
>>>>> Lake). In particular we need to be mindful of not hammering stolen over
>>>>> the BAR from the host side, like with issuing many writes.
>>>>>
>>>>> While the fbdev allocation in xe_display_bo.c properly respected this
>>>>> workaround, the Display Page Table (DPT) allocation in xe_fb_pin.c
>>>>> continued to unconditionally attempt to allocate from stolen memory on
>>>>> all integrated GPUs.
>>>>>
>>>>> Check XE_DEVICE_WA(xe, 22019338487_display) before attempting to
>>>>> allocate the DPT from stolen memory. If the workaround applies, skip the
>>>>> stolen allocation attempt and let the driver naturally fall back to
>>>>> allocating from system memory.
>>>>>
>>>>> Without this we will end up hammering stolen when programming the DPT on
>>>>> the host side during the normal operation, which seems to be exactly
>>>>> what the WA wants us to avoid.
>>>>>
>>>>> There are a bunch of users all getting some kind of hard hang in the fb
>>>>> pin programming sequence on LNL, so wondering if this could help there.
>>>>>
>>>>> v2 (Jani):
>>>>>      - Invert the WA check. No functional change.
>>>>>
>>>>> Assisted-by: Gemini:gemini-3.1-pro-preview
>>>>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513
>>>>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>>>>> Fixes: 775d0adc01a5 ("drm/xe/fbdev: Limit the usage of stolen for LNL+")
>>>>> Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>>>> Cc: Nikolay Mikhaylov <sonny@milton.pro>
>>>>> Cc: Uma Shankar <uma.shankar@intel.com>
>>>>> Cc: Jani Nikula <jani.nikula@intel.com>
>>>>> Cc: <stable@vger.kernel.org> # v6.12+
>>>>
>>>> Ping on this? So far two separate users report this fixes the hard machine hang for them, after several days of testing.
>>>
>>> Can we instead disable stolen entirely so we no longer need this workaround?
>>
>> I'm not sure. You mean disable it except for fbc etc ? We just need some patch to disable at least this dpt path on LNL, which is also easy to backport. We can take your patch to disable this completely instead and I guess remove the WA, so long as we can easily backport it. Either way we just need to land a fix for this ASAP.
> 
> There are 3 patches here:
> 1. Disable stolen for newly created framebuffers
> 2. Disable stolen for DPT
> 3. Disable stolen when taking over firmware framebuffers if media_gt exists
> 
> First 2 are always safe to backport, last one would need a more intrusive fix to prevent regressions, like copying the stolen framebuffer to system memory.

Ok. Should we split 1 & 2 into skipping it only for LNL, which we 
backport, and then another patch to remove stolen completely on top, 
which we don't backport, for those usages? Or least I'm not sure if 
there is some good reason why we want to make use of stolen on other 
platforms, so maybe that should be reviewed/handled separately. I know 
for the WA it's bad idea, but for other platforms I'm not sure tbh. 
Probably need to confirm with display folks.

> 
>>>
>>> https://patchwork.freedesktop.org/patch/735208/?series=159035&rev=19
>>> https://patchwork.freedesktop.org/patch/735215/?series=159035&rev=19
>>> https://patchwork.freedesktop.org/patch/735223/?series=159035&rev=19
>>>
>>> Sending a new version soon, I can split out those patches if needed.
>>> Ideally we find a way to preserve the initial framebuffer by blitting
>>> from the DSB FB to a system memory FB, but this may affect module load time.
>>>
>>> Kind regards,
>>> ~Maarten Lankhorst
>>>
>>>> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513#note_3537314
>>>>
>>>> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513#note_3531435
>>>>
>>>> Looking through the HSD I think it is clear we need something like this for the WA.
>>>>
>>>>> ---
>>>>>     drivers/gpu/drm/xe/display/xe_fb_pin.c | 5 +++++
>>>>>     1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
>>>>> index f93c98bec5b5..8ebb52741ea6 100644
>>>>> --- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
>>>>> +++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
>>>>> @@ -20,6 +20,9 @@
>>>>>     #include "xe_pat.h"
>>>>>     #include "xe_pm.h"
>>>>>     #include "xe_vram_types.h"
>>>>> +#include "xe_wa.h"
>>>>> +
>>>>> +#include <generated/xe_device_wa_oob.h>
>>>>>       static void
>>>>>     write_dpt_rotated(struct xe_bo *bo, struct iosys_map *map, u32 *dpt_ofs, u32 bo_ofs,
>>>>> @@ -172,6 +175,8 @@ static int __xe_pin_fb_vma_dpt(struct drm_gem_object *obj,
>>>>>                                XE_BO_FLAG_GGTT |
>>>>>                                XE_BO_FLAG_PAGETABLE,
>>>>>                                pin_params->alignment, false);
>>>>> +    else if (XE_DEVICE_WA(xe, 22019338487_display))
>>>>> +        dpt = ERR_PTR(-ENODEV);
>>>>>         else
>>>>>             dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
>>>>>                                dpt_size,  ~0ull,
>>>>
>>>
>>
> 


