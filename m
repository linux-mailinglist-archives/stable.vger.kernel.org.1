Return-Path: <stable+bounces-112024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8348A25AB8
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 14:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FEF3A21BA
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 13:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556BC204F6E;
	Mon,  3 Feb 2025 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5wtFJe8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A55204C06;
	Mon,  3 Feb 2025 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738588893; cv=none; b=fFScv367dqiH1MzpPxJzdZwzXcZMHtulC1/x6lPySDGnkRhBjfUygGr1ad7YikZv1aLNAHpAtZ+hn8XcNN3W8+70WX1oPbA3NxlBDsZPgP2zDPY8cWSajGhe/g0rgCeDfLCFduyoVngL8z1cJXewzrlQKddxptteTCAv/niAfvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738588893; c=relaxed/simple;
	bh=qNUiPO2yHgXnsW5NYL968qRQlYZ+KbplWMOxfDHT4Pg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MakbPZ3pbftWbFANQh/6s5BsYyLwf+sgF/Ipg1YJbfVi6xAfjpSpy62vflI4jWfRjHBf4UO0EsLMVo4ayeToK/dQdEBKcgcGRSEDaEvv+3moJtEptbasIIqIUDMrthlVRBW/TppKzG6kwzltdlGaPMoOS5qW03RkYUbxNK6ZUoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5wtFJe8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738588891; x=1770124891;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=qNUiPO2yHgXnsW5NYL968qRQlYZ+KbplWMOxfDHT4Pg=;
  b=I5wtFJe8qlk3/6b46f5FAvFb2kCCnPKz4Aw7vuJZJsjlYbO1q4qe64R5
   YPVGcRIM/7NfQi6suxh0WsQeN2T19Hk2L7q+IeBYxwk8YjUaHJWFsqOVA
   0olESev/VkOuhWWgChgqNcWDG6IucN8loxzIVMs+UEkrOP400H9EDefgM
   nVEsnvfd7pPD5praskPLUr9QVPXSjljoeJGycjY0FCFbvHQ5YdJxF7ofw
   LQGYAR6fnG8A4DT3aIBFDJ7y8HKb09EomxT1XkarSfAerdzwI05eFwxiI
   G787v80EyalZEBT+pQI8A2PH/TFuH1YyGH0mMC06jDGDhTvrblkk+0Iik
   w==;
X-CSE-ConnectionGUID: gM2rJpvmQ2iFgOCigd5vgA==
X-CSE-MsgGUID: ieO81YWnRd+Yn26Bdz3zpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="56616568"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="56616568"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 05:21:31 -0800
X-CSE-ConnectionGUID: nlVN1aI0QFSUS/IyFmEeRg==
X-CSE-MsgGUID: 4btVPqeHRnaIw1rKsBA+MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110855444"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 05:21:26 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Haoyu Li <lihaoyu499@gmail.com>, Lee Jones <lee@kernel.org>, Daniel
 Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Rob Herring <robh@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, chenyuan0y@gmail.com,
 zichenxie0106@gmail.com, Haoyu Li <lihaoyu499@gmail.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drivers: video: backlight: Fix NULL Pointer Dereference
 in backlight_device_register()
In-Reply-To: <20250130145228.96679-1-lihaoyu499@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250130145228.96679-1-lihaoyu499@gmail.com>
Date: Mon, 03 Feb 2025 15:21:23 +0200
Message-ID: <87ldun6u5o.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 30 Jan 2025, Haoyu Li <lihaoyu499@gmail.com> wrote:
> In the function "wled_probe", the "wled->name" is dynamically allocated
> (wled_probe -> wled_configure -> devm_kasprintf), which is possible
> to be null.
>
> In the call trace: wled_probe -> devm_backlight_device_register
> -> backlight_device_register, this "name" variable is directly
> dereferenced without checking. We add a null-check statement.
>
> Fixes: f86b77583d88 ("backlight: pm8941: Convert to using %pOFn instead of device_node.name")
> Signed-off-by: Haoyu Li <lihaoyu499@gmail.com>
> Cc: stable@vger.kernel.org

IMO whoever allocates should be responsible for checking NULL instead of
passing NULL around and expecting everyone check their input for NULL.

BR,
Jani.


> ---
>  drivers/video/backlight/backlight.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index f699e5827ccb..b21670bd86de 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -414,6 +414,8 @@ struct backlight_device *backlight_device_register(const char *name,
>  	struct backlight_device *new_bd;
>  	int rc;
>  
> +	if (!name)
> +		return ERR_PTR(-EINVAL);
>  	pr_debug("backlight_device_register: name=%s\n", name);
>  
>  	new_bd = kzalloc(sizeof(struct backlight_device), GFP_KERNEL);

-- 
Jani Nikula, Intel

