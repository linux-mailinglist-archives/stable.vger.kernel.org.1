Return-Path: <stable+bounces-69691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CF09581C1
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 11:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6181C282CB0
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 09:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A3E18A6CD;
	Tue, 20 Aug 2024 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5RXaZ3V"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2371891A4
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145249; cv=none; b=cTURbtJsjRPeGAET+d5tWKFSv152YTvVfH+oXQTnyh8KdXoNVl5JUA05s/owZIYcE3+M/QpO2p2t53g479HDLiuaD9ZDBJ6yH9DsXN7VzE8sMBKj587gwQpsc4xTC5WxyMoEcF/w8pkSGp2vHhVyMi43d1C6HwdKoLw7XQuhSOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145249; c=relaxed/simple;
	bh=zKc+w5xsRq6Zc+dcNjwnJQKeu0NX5y+YkQiGDhtyi0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HLprWYrmPe988RLotsZe5rWWB2ccA5PehMdk3De7j8tzgBVaT300KOz5sWJ7zPFAncDoz2KRl270F1vvqgAUIsLgGHepTpaNROZP86UG4mAgRl2mnZ+P0xsXaAebPcOxb3D9T3j+Pog+SHAtz6vf4mwvdhyNOzO5LLjPD9wMdwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5RXaZ3V; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724145248; x=1755681248;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=zKc+w5xsRq6Zc+dcNjwnJQKeu0NX5y+YkQiGDhtyi0s=;
  b=B5RXaZ3VYB+u9+wD0IjT9tFln+H7kbvsjTEYy6zhJ7uTAZ6QvBvpCEV3
   qWhAUSBH1kuguWD6Na6hvSoM6AmwgTtzm9ymA2tgWRBTsDnUb93bMPamA
   g1HZPnimmk6n6X0VCOBpBU12qMeb41HPgUDLHahyfBHpO/vKFlsLQdUUo
   +Dwwwr+9C0NRVpyetkifRspA7V5HKW431eQ0WN3vHk7UF+0EgzewT1tQs
   VEh4LPc5wCrQFFypqIYMn2SKyxhkvTki66SMRbS2WGsl6EptGN4pFLF+o
   Wc8LlkhJuKd7hkNgMbj0efBAgYIA3VMwL/3cz1qHMWeLDg4zgPLvYwCWV
   A==;
X-CSE-ConnectionGUID: +KJ+JMkDTYKkOwncCoo5LQ==
X-CSE-MsgGUID: Oq0w9AdYRF2RRu8TEiUoqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="44954398"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="44954398"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 02:12:43 -0700
X-CSE-ConnectionGUID: F/RcBoSwT+C8fIJD7AoOMQ==
X-CSE-MsgGUID: yKp0ldt7TjSTmY4NqpzPxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="98126776"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.184])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 02:12:40 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm/xe: Read out rawclk_freq for display
In-Reply-To: <87msl763mb.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240819133138.147511-1-maarten.lankhorst@linux.intel.com>
 <20240819133138.147511-2-maarten.lankhorst@linux.intel.com>
 <87msl763mb.fsf@intel.com>
Date: Tue, 20 Aug 2024 12:12:36 +0300
Message-ID: <87bk1n5zi3.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 20 Aug 2024, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Mon, 19 Aug 2024, Maarten Lankhorst <maarten.lankhorst@linux.intel.com> wrote:
>> Failing to read out rawclk makes it impossible to read out backlight,
>> which results in backlight not working when the backlight is off during
>> boot, or when reloading the module.
>>
>> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
>> Cc: <stable@vger.kernel.org> # v6.8+
>
> Please find another way. See [1]. I'm trying to clean up the whole
> RUNTIME_INFO() and rawclk_freq thing, and this makes it harder.

Had another look, and brushed up my old patches, new version at [1].

BR,
Jani.


[1] https://lore.kernel.org/r/cover.1724144570.git.jani.nikula@intel.com


>
> BR,
> Jani.
>
>
> [1] https://lore.kernel.org/r/ddd05f84ca4a6597133bee55ddf4ab593a16e99d.1717672515.git.jani.nikula@intel.com
>
>> ---
>>  drivers/gpu/drm/xe/display/xe_display.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
>> index 30dfdac9f6fa9..79add15c6c4c7 100644
>> --- a/drivers/gpu/drm/xe/display/xe_display.c
>> +++ b/drivers/gpu/drm/xe/display/xe_display.c
>> @@ -159,6 +159,9 @@ int xe_display_init_noirq(struct xe_device *xe)
>>  
>>  	intel_display_device_info_runtime_init(xe);
>>  
>> +	RUNTIME_INFO(xe)->rawclk_freq = intel_read_rawclk(xe);
>> +	drm_dbg(&xe->drm, "rawclk rate: %d kHz\n", RUNTIME_INFO(xe)->rawclk_freq);
>> +
>>  	err = intel_display_driver_probe_noirq(xe);
>>  	if (err) {
>>  		intel_opregion_cleanup(display);

-- 
Jani Nikula, Intel

