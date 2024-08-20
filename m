Return-Path: <stable+bounces-69682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DB295801B
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 09:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6544328453B
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 07:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56021189916;
	Tue, 20 Aug 2024 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFSElBvk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DAC1898ED
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139827; cv=none; b=NBdZqm9OPGar5Ml/2+0VrWJdNJkpuzNHmz/cAFSBWdARJLtvbny03n6M15ikmtPG7RV1CaCsy9uag28LWFRaTOchG6BCDctsuf5QJqMhVlvqPP9jdYHCye/DV5RxaFmiyBdw4ywu7DjN1UIv5APlmdunuD/lY+mmVML23aDJC0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139827; c=relaxed/simple;
	bh=gVB9s2obcpytBMmzG+6BLJ2jbNIYUFM2vcMYDl4UUa4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NipevjcP0LdG2Ke9WEedjBL6/kyYGPnuYJThdnknQLtODuTAYNjnBLeTzVW1RxVxeQwC37IsnpZ9L1LjxIwtfc4411ZFd7+/j94r9Swjx3osr+CxXgAuOE4ENN11x9FWEH6SihjsWZpHQrre+oz3MBnYOgjcCYyOmsU0SiFDPwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFSElBvk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724139826; x=1755675826;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=gVB9s2obcpytBMmzG+6BLJ2jbNIYUFM2vcMYDl4UUa4=;
  b=BFSElBvkgFO5MkzKKv8/mq04TSHsMPc3lF1XsRj/4wFjpsJbun1YXEbn
   clr0wsikorTFu9k3DNmVUaCSHJ6+6wPq7Q143lv082cySfzV6hd8HyMcT
   uS80QuOOoctqyAOdVMXlJNzPRMSim3FlrpUtRM8Jh/6p/Glj2HketHhlC
   kk+R2H26r50VBZE+mgmG6SpJjegxSkbfjV+FhsP+pU59txLz8Rs27H4IU
   kdTBzkfxNQQD0T7x35LlNCxFRfGA45SfV5a3udJd1U6jVuoRGeLz2slyW
   jxG9E4Jg0lcn8dcXlUfK92v3mwZOq3oOfl6MOwfxyz1XbT5kGPUCsAW8W
   Q==;
X-CSE-ConnectionGUID: MSamuLBPTnSKX7gnA1iROA==
X-CSE-MsgGUID: l0shgcHRRs2IDvJKFKOEcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26287955"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="26287955"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:43:45 -0700
X-CSE-ConnectionGUID: OHfPMFEMQsKqmmTkLCtW8w==
X-CSE-MsgGUID: MshdGgv2RdWtubonvxa9hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60688903"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.184])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:43:43 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm/xe: Read out rawclk_freq for display
In-Reply-To: <20240819133138.147511-2-maarten.lankhorst@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240819133138.147511-1-maarten.lankhorst@linux.intel.com>
 <20240819133138.147511-2-maarten.lankhorst@linux.intel.com>
Date: Tue, 20 Aug 2024 10:43:40 +0300
Message-ID: <87msl763mb.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 19 Aug 2024, Maarten Lankhorst <maarten.lankhorst@linux.intel.com> wrote:
> Failing to read out rawclk makes it impossible to read out backlight,
> which results in backlight not working when the backlight is off during
> boot, or when reloading the module.
>
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
> Cc: <stable@vger.kernel.org> # v6.8+

Please find another way. See [1]. I'm trying to clean up the whole
RUNTIME_INFO() and rawclk_freq thing, and this makes it harder.

BR,
Jani.


[1] https://lore.kernel.org/r/ddd05f84ca4a6597133bee55ddf4ab593a16e99d.1717672515.git.jani.nikula@intel.com

> ---
>  drivers/gpu/drm/xe/display/xe_display.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
> index 30dfdac9f6fa9..79add15c6c4c7 100644
> --- a/drivers/gpu/drm/xe/display/xe_display.c
> +++ b/drivers/gpu/drm/xe/display/xe_display.c
> @@ -159,6 +159,9 @@ int xe_display_init_noirq(struct xe_device *xe)
>  
>  	intel_display_device_info_runtime_init(xe);
>  
> +	RUNTIME_INFO(xe)->rawclk_freq = intel_read_rawclk(xe);
> +	drm_dbg(&xe->drm, "rawclk rate: %d kHz\n", RUNTIME_INFO(xe)->rawclk_freq);
> +
>  	err = intel_display_driver_probe_noirq(xe);
>  	if (err) {
>  		intel_opregion_cleanup(display);

-- 
Jani Nikula, Intel

