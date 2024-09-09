Return-Path: <stable+bounces-73988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EEE97137B
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 11:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11BEB21F5E
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 09:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC0E1B3B29;
	Mon,  9 Sep 2024 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="df+srGlx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCDA1B3B1A
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874059; cv=none; b=gxi2Jmtk3hE5ZgtfiZSVUSlTxjMPSzRW23tHHEL4BYIbsm7I+/QvkktLvrLPSzcDSUZ8dkC/T25M5Zi9DVTjswJRCrRLXYC0/L9q5OOdd4uaaZpOiCz5H9pcftVGfKb5psYzF6uY5r6Kl30+SzMp0QjjhGqMWtyB6OV0hnZASQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874059; c=relaxed/simple;
	bh=ZX8JeUzZtwC9DY0sa3lCUCCrglgEUya5de/tbILFcLw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gYzaeRnDqEfg5Z9/0tkfTjWpReRm5FoZ+nadL5Q8Hmv6SpanF4HzD2LP2R2lAV5bF9qW6JA/JhDfaJgmA9MsVh3N0tywVG6UfAPykB0rXrNR60l8AYipI+aidTgzcZLpp04lvNe88dvJ7Rj32Fhup0QcIUnyfUOVYxnmkqwvINE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=df+srGlx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725874057; x=1757410057;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ZX8JeUzZtwC9DY0sa3lCUCCrglgEUya5de/tbILFcLw=;
  b=df+srGlxskTWAiqMGEJ1GNVpHRclU/YTNxm66MfmYEWzp1JnW2JSf+mI
   t0M6k+KJ5UhvrjU8TJUPXnPjc9XWwe1Ff60KBzaNBPKEBhXDFL6obRuMx
   9Ntvcj6qGGJ031rw9KOVwaj/dxDbtwyccDVCnTL2MA7ZTmFFh6SwYkSD0
   j+Xie+u/VCshbZf+TpTRRPXLqaPg6sVvQiGNdSC64GaDtDHUjZjMsKe5U
   ZJSYVZBCSowsGpVLcWf3pnWzaVJI10fNQABhXepgHx5s6WxgIGpITJNgl
   07s4liXmR2B1lgzGnA+Ysb12if3NesIQgFVK4/FWvD6SWZto0DSWzwW50
   w==;
X-CSE-ConnectionGUID: Wh95hPOOQbCePTCqlBHuxQ==
X-CSE-MsgGUID: urC2A3miQiebdQamjqXsWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24672234"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="24672234"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:27:36 -0700
X-CSE-ConnectionGUID: i93HDXq4RfWuhIxqFVF5mQ==
X-CSE-MsgGUID: uAE50xKtRsSnmt9bf9KgeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="89888267"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.176])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:27:29 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: "Kulkarni, Vandita" <vandita.kulkarni@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/i915/bios: fix printk format width
In-Reply-To: <SJ0PR11MB6789D9701C99A53699E65D438D9D2@SJ0PR11MB6789.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240905112519.4186408-1-jani.nikula@intel.com>
 <SJ0PR11MB6789D9701C99A53699E65D438D9D2@SJ0PR11MB6789.namprd11.prod.outlook.com>
Date: Mon, 09 Sep 2024 12:27:26 +0300
Message-ID: <878qw1mb29.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 05 Sep 2024, "Kulkarni, Vandita" <vandita.kulkarni@intel.com> wrote:
>> -----Original Message-----
>> From: Intel-gfx <intel-gfx-bounces@lists.freedesktop.org> On Behalf Of Jani
>> Nikula
>> Sent: Thursday, September 5, 2024 4:55 PM
>> To: intel-gfx@lists.freedesktop.org
>> Cc: Nikula, Jani <jani.nikula@intel.com>; stable@vger.kernel.org
>> Subject: [PATCH] drm/i915/bios: fix printk format width
>>
>> s/0x04%x/0x%04x/ to use 0 prefixed width 4 instead of printing 04 verbatim.
>>
>> Fixes: 51f5748179d4 ("drm/i915/bios: create fake child devices on missing
>> VBT")
>> Cc: <stable@vger.kernel.org> # v5.13+
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>> ---
>
> LGTM.
> Reviewed-by: Vandita Kulkarni <vandita.kulkarni@intel.com>

Pushed to din, thanks for the review.

BR,
Jani.


>
> Thanks.
>>  drivers/gpu/drm/i915/display/intel_bios.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_bios.c
>> b/drivers/gpu/drm/i915/display/intel_bios.c
>> index cd32c9cd38a9..daa4b9535123 100644
>> --- a/drivers/gpu/drm/i915/display/intel_bios.c
>> +++ b/drivers/gpu/drm/i915/display/intel_bios.c
>> @@ -2949,7 +2949,7 @@ init_vbt_missing_defaults(struct intel_display
>> *display)
>>               list_add_tail(&devdata->node, &display-
>> >vbt.display_devices);
>>
>>               drm_dbg_kms(display->drm,
>> -                         "Generating default VBT child device with type
>> 0x04%x on port %c\n",
>> +                         "Generating default VBT child device with type
>> 0x%04x on port
>> +%c\n",
>>                           child->device_type, port_name(port));
>>       }
>>
>> --
>> 2.39.2
>

-- 
Jani Nikula, Intel

