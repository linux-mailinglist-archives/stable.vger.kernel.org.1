Return-Path: <stable+bounces-43172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733C08BE0A6
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 13:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A700B229EF
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 11:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551391509BC;
	Tue,  7 May 2024 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNHtiz8n"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422D6AD5D;
	Tue,  7 May 2024 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079957; cv=none; b=HW1KK6g0Pdm87zh6lXnQHkPWV927VVdUtkvRVvcNKhvN47b2if0wtcVBg1F5fHNkffqH47ddCE0o+Srm4KwsGlMllCI6S8V2xZLTScKs3/2oS1OokaGlf9iEiQwjq7nLdC0EsPHM/uCouGFCxKo99qd/LyJZRYARlbT6wIXYlOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079957; c=relaxed/simple;
	bh=qsiykdfT6HGbR0ILtz1HnDdybhnkI6RfpUXlO9B3Wak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMb2FiqPcJztE0f2C7+R2lu71dQzERZEpuaCZ8LmhNSs6o7amYh0xp6KvZeGjIN4fg0awnZDUAdt818+VLquIX9ycdfjB9n+o93fGHiiLeUS1vtYHh7Y2VnM/QSdJ0OOXhkMhkzpjkrwnHIfru5hHEp+ujmIyrH0b/alEYTRUZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNHtiz8n; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715079955; x=1746615955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qsiykdfT6HGbR0ILtz1HnDdybhnkI6RfpUXlO9B3Wak=;
  b=iNHtiz8noH76lGywmvHPsdKh3vMTMi5KcdaX3ifyjt5FHjjoN6tFgtw7
   2IOEa4pixPWDCfD8oIuOjgLVo92O3mehkxRfd3s2HelZyEIvXdShbCofB
   8384pkY2iLO37l6g4Xk5uoPAMvz6jDvh9hkkH5WgqDLsIltod9NM5UEcW
   nbwzZta+tQ7x9veA4TdYXe4ZEh7aXLrlekaW55hgp6+X+c4yrWhSABdyg
   LEeVfRch1Kxj61ibJYVtqAWV63g4qNP1GfMvP4x48htnleaGyr2fSpwo7
   oTcRgCY83WAFUeNCurYrn4wXMfsZufsPfrXqimNxE2rqYlh4R2LVqfL4U
   g==;
X-CSE-ConnectionGUID: KSypa5y/R9OViAhP21rHcw==
X-CSE-MsgGUID: orFPKtkGQfC/tWDG+bU8tw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="11406462"
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="11406462"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 04:05:54 -0700
X-CSE-ConnectionGUID: 365tfxiDTwaI0bkDHm+j9A==
X-CSE-MsgGUID: cCnkjgeJSdact9Hn5hHLhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="28458630"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 07 May 2024 04:05:49 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 07 May 2024 14:05:48 +0300
Date: Tue, 7 May 2024 14:05:48 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Karthikeyan Ramasubramanian <kramasub@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
	Jani Nikula <jani.nikula@intel.com>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: Re: [PATCH v2] drivers/i915/intel_bios: Fix parsing backlight BDB
 data
Message-ID: <ZjoLDJJdfZKKcBFt@intel.com>
References: <20240221180622.v2.1.I0690aa3e96a83a43b3fc33f50395d334b2981826@changeid>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221180622.v2.1.I0690aa3e96a83a43b3fc33f50395d334b2981826@changeid>
X-Patchwork-Hint: comment

On Wed, Feb 21, 2024 at 06:06:24PM -0700, Karthikeyan Ramasubramanian wrote:
> Starting BDB version 239, hdr_dpcd_refresh_timeout is introduced to
> backlight BDB data. Commit 700034566d68 ("drm/i915/bios: Define more BDB
> contents") updated the backlight BDB data accordingly. This broke the
> parsing of backlight BDB data in VBT for versions 236 - 238 (both
> inclusive) and hence the backlight controls are not responding on units
> with the concerned BDB version.
> 
> backlight_control information has been present in backlight BDB data
> from at least BDB version 191 onwards, if not before. Hence this patch
> extracts the backlight_control information for BDB version 191 or newer.
> Tested on Chromebooks using Jasperlake SoC (reports bdb->version = 236).
> Tested on Chromebooks using Raptorlake SoC (reports bdb->version = 251).
> 
> Fixes: 700034566d68 ("drm/i915/bios: Define more BDB contents")
> Cc: stable@vger.kernel.org
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@chromium.org>
> ---
> 
> Changes in v2:
> - removed checking the block size of the backlight BDB data

I fixed up the formatting of the commit message a bit,
added a note indicating why it's ok to remove the size
checks, and pushed to drm-intel-next. Thanks.

> 
>  drivers/gpu/drm/i915/display/intel_bios.c     | 19 ++++---------------
>  drivers/gpu/drm/i915/display/intel_vbt_defs.h |  5 -----
>  2 files changed, 4 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
> index aa169b0055e97..8c1eb05fe77d2 100644
> --- a/drivers/gpu/drm/i915/display/intel_bios.c
> +++ b/drivers/gpu/drm/i915/display/intel_bios.c
> @@ -1042,22 +1042,11 @@ parse_lfp_backlight(struct drm_i915_private *i915,
>  	panel->vbt.backlight.type = INTEL_BACKLIGHT_DISPLAY_DDI;
>  	panel->vbt.backlight.controller = 0;
>  	if (i915->display.vbt.version >= 191) {
> -		size_t exp_size;
> +		const struct lfp_backlight_control_method *method;
>  
> -		if (i915->display.vbt.version >= 236)
> -			exp_size = sizeof(struct bdb_lfp_backlight_data);
> -		else if (i915->display.vbt.version >= 234)
> -			exp_size = EXP_BDB_LFP_BL_DATA_SIZE_REV_234;
> -		else
> -			exp_size = EXP_BDB_LFP_BL_DATA_SIZE_REV_191;
> -
> -		if (get_blocksize(backlight_data) >= exp_size) {
> -			const struct lfp_backlight_control_method *method;
> -
> -			method = &backlight_data->backlight_control[panel_type];
> -			panel->vbt.backlight.type = method->type;
> -			panel->vbt.backlight.controller = method->controller;
> -		}
> +		method = &backlight_data->backlight_control[panel_type];
> +		panel->vbt.backlight.type = method->type;
> +		panel->vbt.backlight.controller = method->controller;
>  	}
>  
>  	panel->vbt.backlight.pwm_freq_hz = entry->pwm_freq_hz;
> diff --git a/drivers/gpu/drm/i915/display/intel_vbt_defs.h b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> index a9f44abfc9fc2..b50cd0dcabda9 100644
> --- a/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> +++ b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> @@ -897,11 +897,6 @@ struct lfp_brightness_level {
>  	u16 reserved;
>  } __packed;
>  
> -#define EXP_BDB_LFP_BL_DATA_SIZE_REV_191 \
> -	offsetof(struct bdb_lfp_backlight_data, brightness_level)
> -#define EXP_BDB_LFP_BL_DATA_SIZE_REV_234 \
> -	offsetof(struct bdb_lfp_backlight_data, brightness_precision_bits)
> -
>  struct bdb_lfp_backlight_data {
>  	u8 entry_size;
>  	struct lfp_backlight_data_entry data[16];
> -- 
> 2.44.0.rc0.258.g7320e95886-goog

-- 
Ville Syrjälä
Intel

