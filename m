Return-Path: <stable+bounces-248977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNa5Eo82CGoHegMAu9opvQ
	(envelope-from <stable+bounces-248977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 11:19:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F7E55ADED
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 11:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D85CE300F525
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 09:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D8231B131;
	Sat, 16 May 2026 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KnINnkac"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3BB2C375A
	for <stable@vger.kernel.org>; Sat, 16 May 2026 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778923148; cv=none; b=TgApscALCo+fxK2b5oBJLOjmhLx70TdzfSps9UCdKBZbk69R01gZzUQKWoIySL3lpgY95tuB44Mhx3gVQvUVP0g3jLVBI6KCsObcENSLDHQoOaXhoV6ZeaqkrzNQQ4AIaYiJ/6sHZHz/OARd0L4OzIa1au2GCu9ggsuf7zcE6Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778923148; c=relaxed/simple;
	bh=eOb5sbdQV10aHUonwTo2zubM7o6+2xf0HTAp6nThwfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fnz9xreWAs535DyYRXmuDNaNaAFmZe526kIbzagqQviY0ga36zsebbhTon3oMmEYSUv7gANYFmxNpIt9DNdx4iRrSaIs2PFZdAUkYGq+Hhu80sirWnckAAoGg8WE3Qj8RODkCCxDwwqNow+IKe5Hng4/tW0rreAS2FezTPVL1fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KnINnkac; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778923146; x=1810459146;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=eOb5sbdQV10aHUonwTo2zubM7o6+2xf0HTAp6nThwfw=;
  b=KnINnkacvexZQo6xn4QoIYeYBp8jmCvYVjoDMLdSyxMPM4rEizdaLpdf
   3CFviCMmlfoxgzTP8KUBXPACcYncqJOdOXVTh0RtLb3zpDdQzkgI0c8xn
   1PyaiiOFBUt+8IJ3+KcIBkhLFbj+PYOsJXRMQHkphVX5YnR9BP4aZoVv1
   AoriaEYJC2lqUF0RXzKMtiA13LrPQA3DqavM2UrbxYy8U5WvjiPifYHEk
   SgHbzHy21zEE3bBB3vce+KO50mtWnQbxcFI9sfoNQMfeQyCtWVKv93wBt
   Jr4ek853Z3DF+HpcpJxL+yCbbpPQGgf74QpxXHjEPDPq09aby0+Q5UsKl
   A==;
X-CSE-ConnectionGUID: 4aXLc2btTaq8e7dYU4LO7w==
X-CSE-MsgGUID: p+UIa428SnCIr1lsdAEHHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79579657"
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="79579657"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 02:19:05 -0700
X-CSE-ConnectionGUID: dR1vF0YzQWy4kKwKWQ4/7A==
X-CSE-MsgGUID: oVmPZFnSQbaR2aD12Xo0IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="277033151"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.160])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 02:19:04 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/xe/display: fix oops in suspend/shutdown without
 display
In-Reply-To: <DM3PPF208195D8D504F655566B2A718B650E3042@DM3PPF208195D8D.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260515160920.1082842-1-jani.nikula@intel.com>
 <DM3PPF208195D8D504F655566B2A718B650E3042@DM3PPF208195D8D.namprd11.prod.outlook.com>
Date: Sat, 16 May 2026 12:19:01 +0300
Message-ID: <47fc29d462ebaa0fde9f229c8384099e9ccd99c0@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 99F7E55ADED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-248977-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.freedesktop.org:url,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

On Fri, 15 May 2026, "Kandpal, Suraj" <suraj.kandpal@intel.com> wrote:
>> Subject: [PATCH] drm/xe/display: fix oops in suspend/shutdown without
>> display
>> 
>> The xe driver keeps track of whether to probe display, and whether display
>> hardware is there, using xe->info.probe_display. It gets set to false if there's no
>> display after intel_display_device_probe(). However, the display may also be
>> disabled via fuses, detected at a later time in
>> intel_display_device_info_runtime_init().
>> 
>> In this case, the xe driver does for_each_intel_crtc() on uninitialized mode
>> config in xe_display_flush_cleanup_work(), leading to a NULL pointer
>> dereference, and generally calls display code with display info cleared.
>> 
>> Check for intel_display_device_present() after
>> intel_display_device_info_runtime_init(), and reset
>> xe->info.probe_display as necessary. Also do unset_display_features()
>> for completeness, although display runtime init has already done that. This will
>> need to be unified across all cases later.
>> 
>> Move intel_display_device_info_runtime_init() call slightly earlier, similar to
>> i915, to avoid a bunch of unnecessary setup for no display cases.
>> 
>> Note #1: The xe driver has no business doing low level display plumbing like
>> for_each_intel_crtc() to begin with. It all needs to happen in display code.
>> 
>> Note #2: The actual bug is present already in commit 44e694958b95
>> ("drm/xe/display: Implement display support"), but the oops was likely
>> introduced later at commit ddf6492e0e50 ("drm/xe/display: Make display
>> suspend/resume work on discrete").
>> 
>> Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7904
>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/6150
>> Cc: <stable@vger.kernel.org> # v6.8+
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> LGTM,
> Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>

Thanks, pushed to drm-intel-next (and not drm-xe-next) to avoid
conflicts with other display changes.

BR,
Jani.

>
>> ---
>>  drivers/gpu/drm/xe/display/xe_display.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/xe/display/xe_display.c
>> b/drivers/gpu/drm/xe/display/xe_display.c
>> index 053abd6f6514..5f25932730f4 100644
>> --- a/drivers/gpu/drm/xe/display/xe_display.c
>> +++ b/drivers/gpu/drm/xe/display/xe_display.c
>> @@ -104,6 +104,15 @@ int xe_display_init_early(struct xe_device *xe)
>> 
>>  	intel_display_driver_early_probe(display);
>> 
>> +	intel_display_device_info_runtime_init(display);
>> +
>> +	/* Display may have been disabled at runtime init */
>> +	if (!intel_display_device_present(display)) {
>> +		xe->info.probe_display = false;
>> +		unset_display_features(xe);
>> +		return 0;
>> +	}
>> +
>>  	/* Early display init.. */
>>  	intel_opregion_setup(display);
>> 
>> @@ -117,8 +126,6 @@ int xe_display_init_early(struct xe_device *xe)
>> 
>>  	intel_bw_init_hw(display);
>> 
>> -	intel_display_device_info_runtime_init(display);
>> -
>>  	err = intel_display_driver_probe_noirq(display);
>>  	if (err)
>>  		goto err_opregion;
>> --
>> 2.47.3
>

-- 
Jani Nikula, Intel

