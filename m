Return-Path: <stable+bounces-136610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1D9A9B43F
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 18:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F0A3BA20A
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 16:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858C6284688;
	Thu, 24 Apr 2025 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVWrs69h"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7688E27F744;
	Thu, 24 Apr 2025 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512477; cv=none; b=K3TDwJzSZt60mBD2f20Fl68W4sDNfwDrR3ZcGQ1Z5oYfxIyrROL+up09tfC9wm/Pg3EP09h241VGD2pTJVzv8bZAQTLqLfwz92MzcWusaIwvBWZVMQk2e6tsf7KOvh64PMPwAeVNh3HgUbQbiQKkCb+dhHw7SeCuG0UzytJxbiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512477; c=relaxed/simple;
	bh=/2+v4MrrIX1tru3YRH21EcKXQRarr69zuxlHYYHXpdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBaGbcB1L6jATEAkkxqbLbbq2c4BGyunTYRNCjIE5bXdOG/KcUeruQHrX1rw52z7a5Zt3u++U4GLtYCQWAm6SiHL4RUqeCsc8r/jWJApwIJIVjSenTG2y1ZCTaAUHgx+kjuOqqwPZ6loh9Jc2c6obLk3haS2eDdC1krvvx7r/d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVWrs69h; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745512474; x=1777048474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/2+v4MrrIX1tru3YRH21EcKXQRarr69zuxlHYYHXpdg=;
  b=hVWrs69hUF5iUmu//q/dWbz8PiOHlomNt7M/G2aT5ekGdbj6xivahQhk
   7vbFEf6xA3IM7Rc1qehxa8JRXuSnWV1hyOno1UYug2vU2kvb06zFNxtxZ
   9Tf9c7qTOIXJ9u3Ejwdu4UjJTCw/dJ/mxh4qArvMXurP4GePqg+TwPpmA
   kIMaRWVqTfqga76SuLvKwYOyzP6DMjjF4DwbuyB5UxzZk0aHIqbINeoOd
   7G1kOV0XoGP06Nn17OpofWHb9WAHeYVVAWZzRM4oeZ3Xq2qLs2FuvLvMj
   vSSs7dxi+X/meBXJlyES2DZALYCACKw82+rCOAEVtCnzU7byYfC1xZAqc
   A==;
X-CSE-ConnectionGUID: H0IhJmdLQ1aoQFWf+td8og==
X-CSE-MsgGUID: lwNAOs58Rnm1sj6XPSHWxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="49815010"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="49815010"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 09:34:34 -0700
X-CSE-ConnectionGUID: riyFq7+hRgmuldfE9BonoQ==
X-CSE-MsgGUID: 5sAVUh6aTpOxttr8Kgxhsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="132657353"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 24 Apr 2025 09:34:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9D4FC1AC; Thu, 24 Apr 2025 19:34:29 +0300 (EEST)
Date: Thu, 24 Apr 2025 19:34:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: cl@linux.com, rientjes@google.com, vbabka@suse.cz,
	roman.gushchin@linux.dev, harry.yoo@oracle.com, surenb@google.com,
	pasha.tatashin@soleen.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	quic_tingweiz@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm, slab: clean up slab->obj_exts always
Message-ID: <aApoFXmDE-k2KFFV@black.fi.intel.com>
References: <20250421075232.2165527-1-quic_zhenhuah@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421075232.2165527-1-quic_zhenhuah@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 21, 2025 at 03:52:32PM +0800, Zhenhua Huang wrote:
> When memory allocation profiling is disabled at runtime or due to an
> error, shutdown_mem_profiling() is called: slab->obj_exts which
> previously allocated remains.
> It won't be cleared by unaccount_slab() because of
> mem_alloc_profiling_enabled() not true. It's incorrect, slab->obj_exts
> should always be cleaned up in unaccount_slab() to avoid following error:
> 
> [...]BUG: Bad page state in process...
> ..
> [...]page dumped because: page still charged to cgroup

Please, always compile test with `make W=1`. Since CONFIG_WERROR=y this
effectively breaks the build with Clang.

-- 
With Best Regards,
Andy Shevchenko



