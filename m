Return-Path: <stable+bounces-268919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JsleIPWDPmqVHQkAu9opvQ
	(envelope-from <stable+bounces-268919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:51:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1CF6CDB84
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:51:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lankhorst.se header.s=default header.b=KIQdaBNS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268919-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268919-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lankhorst.se;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CD6E30071DA
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDFF3F23B7;
	Fri, 26 Jun 2026 13:47:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C7F3F7897
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 13:47:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481627; cv=none; b=abO5gVfQ9V2TRiCEuhctqtvJzyqy52POgp+6z6cmPiVGB+o4QlH3zoxyR0zDj0ocqkFcPFML+amjbCyVEJ+c2rgQlMf4RBVm0tn5kWU1JCtn/OZcNgZVmqFNmmvmYd/g4wmf2lIPz0RjR5i0M23cZYIkqxyxVn4/rZLyIrHSk2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481627; c=relaxed/simple;
	bh=q3+6V4eUQTKeZdpgI2StYKFRIAAyMrDmrm4eav+dXXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfEJYAA31tecewy9mRHdAKVExeLbCEeRjpryoCXg4tO9dEJQkm2jtZZnhWrrBCARR+WChV/YJWDJFUbuPNyRUG3JZuzjf8hN1XbpsjhV+iGT9zbw3hyKs8hWwZTsL6UYfhBFMHBRQX/dF5oMjtNMMl5uOUZRWbj+pyHKc8+0Tfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=KIQdaBNS; arc=none smtp.client-ip=141.105.120.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1782481022;
	bh=q3+6V4eUQTKeZdpgI2StYKFRIAAyMrDmrm4eav+dXXY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KIQdaBNS3t8bzt7l/l2ZUCs+9sorsb/73JMeAScFYOKkFEbu0vK5ClFC6ww9Hcwc3
	 aPIOSKP4u9nuKTVKywNDTPcPhbW+lzI9SJSBQKUA8ADoHDdVdBLGuszILh0QaRBlyA
	 YFArkJSzmf2mMetBT5Vds8SqlHpVqjqrKi3ecnNXzVnsoucZXpMLVEFUkcdM9PXLeo
	 ODuwyJ8zZXg3fAMvUcX5t/fJghlp758Qn5yX+0A4BCL1XNzGstzAUPEKqoNFYiuCd8
	 CYlfnP3ibAO/qKO8CIe2+FdI+66zZgUlnSru+Bttwv9cJSTutLV2euCmEhK1cDToNg
	 EwyZKcgi1TSHA==
Message-ID: <9924291e-5108-41b3-9131-12b292e8bcd2@lankhorst.se>
Date: Fri, 26 Jun 2026 15:37:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/display: consider DPT when WA 22019338487 is
 active
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Nikolay Mikhaylov <sonny@milton.pro>,
 Uma Shankar <uma.shankar@intel.com>, Jani Nikula <jani.nikula@intel.com>,
 stable@vger.kernel.org
References: <20260623090155.268763-2-matthew.auld@intel.com>
 <9e04ec82-712d-41b6-9fe8-78aeb015d67c@intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <9e04ec82-712d-41b6-9fe8-78aeb015d67c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lankhorst.se,none];
	R_DKIM_ALLOW(-0.20)[lankhorst.se:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268919-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:matthew.auld@intel.com,m:intel-xe@lists.freedesktop.org,m:thomas.hellstrom@linux.intel.com,m:matthew.brost@intel.com,m:rodrigo.vivi@intel.com,m:sonny@milton.pro,m:uma.shankar@intel.com,m:jani.nikula@intel.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dev@lankhorst.se,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lankhorst.se:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@lankhorst.se,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lankhorst.se:dkim,lankhorst.se:mid,lankhorst.se:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:email,gitlab.freedesktop.org:url,milton.pro:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA1CF6CDB84

Hey,

On 6/26/26 12:27, Matthew Auld wrote:
> On 23/06/2026 10:01, Matthew Auld wrote:
>> WA 22019338487 (22019338487_display) indicates that stolen memory should
>> not be used for display allocations on affected platforms (like Lunar
>> Lake). In particular we need to be mindful of not hammering stolen over
>> the BAR from the host side, like with issuing many writes.
>>
>> While the fbdev allocation in xe_display_bo.c properly respected this
>> workaround, the Display Page Table (DPT) allocation in xe_fb_pin.c
>> continued to unconditionally attempt to allocate from stolen memory on
>> all integrated GPUs.
>>
>> Check XE_DEVICE_WA(xe, 22019338487_display) before attempting to
>> allocate the DPT from stolen memory. If the workaround applies, skip the
>> stolen allocation attempt and let the driver naturally fall back to
>> allocating from system memory.
>>
>> Without this we will end up hammering stolen when programming the DPT on
>> the host side during the normal operation, which seems to be exactly
>> what the WA wants us to avoid.
>>
>> There are a bunch of users all getting some kind of hard hang in the fb
>> pin programming sequence on LNL, so wondering if this could help there.
>>
>> v2 (Jani):
>>    - Invert the WA check. No functional change.
>>
>> Assisted-by: Gemini:gemini-3.1-pro-preview
>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513
>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> Fixes: 775d0adc01a5 ("drm/xe/fbdev: Limit the usage of stolen for LNL+")
>> Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Cc: Nikolay Mikhaylov <sonny@milton.pro>
>> Cc: Uma Shankar <uma.shankar@intel.com>
>> Cc: Jani Nikula <jani.nikula@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.12+
> 
> Ping on this? So far two separate users report this fixes the hard machine hang for them, after several days of testing.

Can we instead disable stolen entirely so we no longer need this workaround?

https://patchwork.freedesktop.org/patch/735208/?series=159035&rev=19
https://patchwork.freedesktop.org/patch/735215/?series=159035&rev=19
https://patchwork.freedesktop.org/patch/735223/?series=159035&rev=19

Sending a new version soon, I can split out those patches if needed.
Ideally we find a way to preserve the initial framebuffer by blitting
from the DSB FB to a system memory FB, but this may affect module load time.

Kind regards,
~Maarten Lankhorst

> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513#note_3537314
> 
> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513#note_3531435
> 
> Looking through the HSD I think it is clear we need something like this for the WA.
> 
>> ---
>>   drivers/gpu/drm/xe/display/xe_fb_pin.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
>> index f93c98bec5b5..8ebb52741ea6 100644
>> --- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
>> +++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
>> @@ -20,6 +20,9 @@
>>   #include "xe_pat.h"
>>   #include "xe_pm.h"
>>   #include "xe_vram_types.h"
>> +#include "xe_wa.h"
>> +
>> +#include <generated/xe_device_wa_oob.h>
>>     static void
>>   write_dpt_rotated(struct xe_bo *bo, struct iosys_map *map, u32 *dpt_ofs, u32 bo_ofs,
>> @@ -172,6 +175,8 @@ static int __xe_pin_fb_vma_dpt(struct drm_gem_object *obj,
>>                              XE_BO_FLAG_GGTT |
>>                              XE_BO_FLAG_PAGETABLE,
>>                              pin_params->alignment, false);
>> +    else if (XE_DEVICE_WA(xe, 22019338487_display))
>> +        dpt = ERR_PTR(-ENODEV);
>>       else
>>           dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
>>                              dpt_size,  ~0ull,
> 


