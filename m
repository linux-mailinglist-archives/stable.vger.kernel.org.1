Return-Path: <stable+bounces-176610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 168D6B39F8E
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 16:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A1A16A915
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 14:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B183E189F3B;
	Thu, 28 Aug 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfR0BCqz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A381221FB4
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389658; cv=none; b=oxJovkH5XJwqtLGQv90AQnkQjKZxFipeH8W89dbCxMXiv1TswmLDSfdiGPoFW5fkcX7ZuAzC9w0LAQQRYYOd2Hhm5HEhTos3OR/xB/rhrL6CEQ/P1BMiaghMnF4RF4IjdZMGZnYzcorWxIYbLEEHedZ0WFIfZ/bS0ac19sMt0fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389658; c=relaxed/simple;
	bh=1bU9Z8Y1Klm+3syABKU3wzwAlwrzkZOd7S4WV6hQ+HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeDzYETygbhYAec6Iy9cxlnAuWIlSyhZe6725WYa/CU7bGYpW8cuJSaiSeNIS+ppmsWQNMTfFtFbT9jZ8kkkKs3oZGiI3drP3wY4F1eFUCgOfXPMfDRNTz/oMHL6f6HuwsmvUCMPfKo3ada/soZKkumkxZsWAbPPULh6vm9ZlOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfR0BCqz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756389656; x=1787925656;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1bU9Z8Y1Klm+3syABKU3wzwAlwrzkZOd7S4WV6hQ+HU=;
  b=FfR0BCqziTmLSLnAs2NsOnRiP5ne2oCvdAW6M1kKtnfLevZVcMENpjmt
   csKN4xN2CDu/ARMBz4gyHZ2L7pOedyC+QaAIBfb+j19QAr7eVsGc9gYPU
   1Mjuz1d9m44sc2tp2pRzAh2ttGo3DduYYHPBXc/HUXhiYN3nXDGtTwcLK
   hR9asnN+X9te175lOzO556kNcBAx6b2JzNhBB56xbWQabUHprJUvghRwU
   Y6wWrQxRzOzY8HNJII+g9Yf8obKkQffiBwWd841r6iYMA5nvR8XNGjryu
   xK/ssHazlEV7EJxn/albsGnWFSPPvkRoUl1f5yXfJa7f4O09RGguXsXKp
   A==;
X-CSE-ConnectionGUID: UeKHmiszQki52822yMzt4w==
X-CSE-MsgGUID: rfClal25QyiCqmWyIK5H4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="62481703"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="62481703"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 07:00:54 -0700
X-CSE-ConnectionGUID: uv0d6gbtRxa56MAT66Gt/w==
X-CSE-MsgGUID: Q1O/JDPfS7aRIynG51Vzog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169366657"
Received: from johunt-mobl9.ger.corp.intel.com (HELO [10.245.245.84]) ([10.245.245.84])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 07:00:52 -0700
Message-ID: <5d0e5447-f264-4574-a368-0891aa93ae15@intel.com>
Date: Thu, 28 Aug 2025 15:00:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Fix incorrect migration of backed-up object to
 VRAM
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
References: <20250828134837.5709-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20250828134837.5709-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/08/2025 14:48, Thomas Hellström wrote:
> If an object is backed up to shmem it is incorrectly identified
> as not having valid data by the move code. This means moving
> to VRAM skips the -EMULTIHOP step and the bo is cleared. This
> causes all sorts of weird behaviour on DGFX if an already evicted
> object is targeted by the shrinker.
> 
> Fix this by using ttm_tt_is_swapped() to identify backed-up
> objects.
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5996
> Fixes: 00c8efc3180f ("drm/xe: Add a shrinker for xe bos")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.15+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

I guess we are missing some test coverage here?

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/xe/xe_bo.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 7d1ff642b02a..4faf15d5fa6d 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -823,8 +823,7 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
>   		return ret;
>   	}
>   
> -	tt_has_data = ttm && (ttm_tt_is_populated(ttm) ||
> -			      (ttm->page_flags & TTM_TT_FLAG_SWAPPED));
> +	tt_has_data = ttm && (ttm_tt_is_populated(ttm) || ttm_tt_is_swapped(ttm));
>   
>   	move_lacks_source = !old_mem || (handle_system_ccs ? (!bo->ccs_cleared) :
>   					 (!mem_type_is_vram(old_mem_type) && !tt_has_data));


