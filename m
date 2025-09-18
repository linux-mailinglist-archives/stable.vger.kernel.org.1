Return-Path: <stable+bounces-180498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A652B83D41
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 11:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32658179651
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 09:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA95242D93;
	Thu, 18 Sep 2025 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E0x2ynBY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CDE1D9663
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188298; cv=none; b=I3SowrWgJSkwkJMJocch7S0IuGiCi6EXHv3MeJtNNcBvLwpVMm3Gd3RpbzaYrt+rfNsZSM/MhVWM53FRpjX9/bc7QEfoGE5wU1t4Y7JTOL5+V0GwqVEEQP1KqVfE+50jKSs8vXkCiJSYfrYDaIsVY+H/rWeb3Eb29oo8vAVTWYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188298; c=relaxed/simple;
	bh=sP4AHCkAkbd/YxZxQkK4mSoGzrnznrymsItntTUNu0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3QxPaIAbG+5G99InGNygmFhxXayZEJRRbnCdJSwn+6KkUzE+drszVbvct2Rjdw/CcOsIQtpOLfW6rlLcobRb7A77rEIYLVBgEL7Vf8+UqUDkJmfrZx2QuCitlurBxgnvjY9rFncwKfB8IllQo5qGa3dlhCxKwX+YVt+T00fzR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E0x2ynBY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758188297; x=1789724297;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sP4AHCkAkbd/YxZxQkK4mSoGzrnznrymsItntTUNu0M=;
  b=E0x2ynBYuTmecBD01V7gOJ34V7lbm7apgX9/MPyq3tlt5L+L0/10Ntf9
   aJ8UrGXeSrkoMWfy1tPa9Lvrs8ZsyjEEPnNZWX//QUiFeVqwM6benBY5m
   8qiqTmluDzbeklc6/IsvO6Rs7goojpfTjI0TEeS7zCV+jWEXufMNMcoxu
   OjkTo7hI56ljtHTqL32YlJAXI7GUTomIiO7xyuBC+VwfZd7NkPERl3nV5
   cAsFlZCrCWkTlLZjpuIlxxI5psSp1BVnVMUTSEHSA67EappJmcWvtKDf7
   JPpZ2iSgb6mO8oNrqEJ4pgCGq1J4Maan7Kuhp6Far1DJ8Lbi4oVH1nKeb
   Q==;
X-CSE-ConnectionGUID: sP2xFJvCQm+Nt/PCvscIog==
X-CSE-MsgGUID: KYBYl85uReOchJAQvssrgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60444054"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="60444054"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 02:38:16 -0700
X-CSE-ConnectionGUID: 3edeNqo4SM67ZVBhNH1FOg==
X-CSE-MsgGUID: EN5vAJpaQfy0XQdImMMbBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175938149"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.244.228]) ([10.245.244.228])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 02:38:15 -0700
Message-ID: <321635af-b292-4849-9844-a52a881ef87c@intel.com>
Date: Thu, 18 Sep 2025 10:38:13 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/xe: Don't copy pinned kernel bos twice on
 suspend
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20250918092207.54472-1-thomas.hellstrom@linux.intel.com>
 <20250918092207.54472-2-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20250918092207.54472-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/09/2025 10:22, Thomas Hellström wrote:
> We were copying the bo content the bos on the list
> "xe->pinned.late.kernel_bo_present" twice on suspend.
> 
> Presumingly the intent is to copy the pinned external bos on
> the first pass.
> 
> This is harmless since we (currently) should have no pinned
> external bos needing copy since
> a) exernal system bos don't have compressed content,
> b) We do not (yet) allow pinning of VRAM bos.
> 
> Still, fix this up so that we copy pinned external bos on
> the first pass. We're about to allow bos pinned in VRAM.
> 
> Fixes: c6a4d46ec1d7 ("drm/xe: evict user memory in PM notifier")
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.16+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/xe/xe_bo_evict.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
> index 7484ce55a303..d5dbc51e8612 100644
> --- a/drivers/gpu/drm/xe/xe_bo_evict.c
> +++ b/drivers/gpu/drm/xe/xe_bo_evict.c
> @@ -158,8 +158,8 @@ int xe_bo_evict_all(struct xe_device *xe)
>   	if (ret)
>   		return ret;
>   
> -	ret = xe_bo_apply_to_pinned(xe, &xe->pinned.late.kernel_bo_present,
> -				    &xe->pinned.late.evicted, xe_bo_evict_pinned);
> +	ret = xe_bo_apply_to_pinned(xe, &xe->pinned.late.external,
> +				    &xe->pinned.late.external, xe_bo_evict_pinned);
>   
>   	if (!ret)
>   		ret = xe_bo_apply_to_pinned(xe, &xe->pinned.late.kernel_bo_present,


