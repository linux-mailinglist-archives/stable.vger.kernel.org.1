Return-Path: <stable+bounces-98561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE659E4719
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 22:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC62167CFC
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6B0191F9B;
	Wed,  4 Dec 2024 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1b+cjZe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560B919BBA;
	Wed,  4 Dec 2024 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733348769; cv=none; b=Md2nStNf3H36vDYEWBRqkgQqqgyozM3RpYy8L1WljQ2dPMcNjuS7gncXdPHasoC19PgdeEl7SlsI0580OFVu1U7vfDn51TQjfxA2qUopktwFkbaRIoS5onYZaBDVGunW1xIrnAKOc831M00UQmGpJHUObhnljfaZAhZpzz8FhRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733348769; c=relaxed/simple;
	bh=t+1yZQ2yj5jDedfR7Qxs3G0ejCWg1EregGj5E/3jjSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCzPIg8roBLG3y51cQBb0FgSaq7ibOLLOnf0sS2hI5rBrSMPmxsTTK6dBsiGY6xul3OHgC8/EM7Iw4rW2FdgwPjf5cXV1MMQ44pGaWKTYDjwbEXNlPuKdlPf+cVN336FraULU144Mru/f7xfo1UliZp8U1ku69OTHxu3aZLnX04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1b+cjZe; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733348766; x=1764884766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t+1yZQ2yj5jDedfR7Qxs3G0ejCWg1EregGj5E/3jjSM=;
  b=M1b+cjZePnN5fQG+4AxX99sD3oyvvDrh1IEBwow5+iQ1YYFBueceId56
   mSrd80cxVVbQSAayMf+pB9c51sGkWnCxAuqKvcgcPRHWwefUqnU0GqSIo
   8yLh6J0sopWqUO5RTb0mefCCS98qSSt37fl4e0Yb6vKOR+SytMfBo7TP2
   B6PK3EDDh0ypWg19CfuPOCJyrEFUHdHFU6akUv10KNDz3jnjZdfWqkll7
   9TG5xF7VAJOUzQJCc/VM13XTTuVDpMumKG8VCB8q7ODBMhZcKZQ4+GSbF
   lUNujWEOVMlJo8KnICNlqGFBQgSaDICOlyAiBpihyYbSufZh05G+psTkk
   g==;
X-CSE-ConnectionGUID: GAq7aFgORK2XWx7NeiD3Ew==
X-CSE-MsgGUID: NtHXmErGQ7O53tTxBhZ9gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="32995277"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="32995277"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 13:46:05 -0800
X-CSE-ConnectionGUID: RVcurs7sRD6wYNuyblX5qw==
X-CSE-MsgGUID: ifksASnzQY2wsyfIrvnc2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="93768613"
Received: from slindbla-desk.ger.corp.intel.com (HELO intel.com) ([10.245.246.225])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 13:46:00 -0800
Date: Wed, 4 Dec 2024 22:45:56 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: nirmoy.das@linux.intel.com, jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
	tursulin@ursulin.net, airlied@gmail.com, daniel@ffwll.ch,
	chris@chris-wilson.co.uk, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@outlook.com>,
	stable@vger.kernel.org, Nirmoy Das <nirmoy.das@intel.com>
Subject: Re: [PATCH RESEND v2] drm/i915: Fix memory leak by correcting cache
 object name in error handler
Message-ID: <Z1DNlAPvPNtgpMXO@ashyti-mobl2.lan>
References: <20241127201042.29620-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127201042.29620-1-jiashengjiangcool@gmail.com>

Hi Jiasheng,

On Wed, Nov 27, 2024 at 08:10:42PM +0000, Jiasheng Jiang wrote:
> From: Jiasheng Jiang <jiashengjiangcool@outlook.com>
> 
> Replace "slab_priorities" with "slab_dependencies" in the error handler
> to avoid memory leak.
> 
> Fixes: 32eb6bcfdda9 ("drm/i915: Make request allocation caches global")
> Cc: <stable@vger.kernel.org> # v5.2+
> Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@outlook.com>

merged to drm-intel-next.

Thanks,
Andi

