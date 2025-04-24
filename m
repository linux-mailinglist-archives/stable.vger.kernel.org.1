Return-Path: <stable+bounces-136611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9F6A9B473
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 18:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306834A20A8
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 16:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C5828A1CE;
	Thu, 24 Apr 2025 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bR6ULMZa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCCD18B495;
	Thu, 24 Apr 2025 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513321; cv=none; b=GJlvPpDUFzdPrM4vKsVFuABeYsdcYCOKA6CQENpnVrG3NUG7/BvJ2uQp0j3WX/szqoL8swv66JhO6ThKGZdA09m6wARNRPHTGT16fFrrE3HXEFP4Pc5AkuOgcM6YeLHeL6in/utQJIyrXZukz9yJwIvGwVSB8YtqWM25QunHK4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513321; c=relaxed/simple;
	bh=HC19li/AvVr/J/L0lBvGqhb0q0RGSas+mx14ehOq5v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1uMe3ojGGkdgKrw4m0CuC3lPLRR95IJFvTz0SLWulGhx0ORqlooPs1ApJ6wDh+moEMmB1QD4E09h3FM1UvN1375m9BfoltDkuDshX3UNcu9ly/Bi0e6YAXZW3SkWC4A7e4kpgD2H/FAou9/6XhcyTzJREUiCyy/612QjOhRyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bR6ULMZa; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745513318; x=1777049318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HC19li/AvVr/J/L0lBvGqhb0q0RGSas+mx14ehOq5v0=;
  b=bR6ULMZa74bUgqU6mAEnugAalfX9g6qoPfA1ZX+bjGnRYQ1AScUhGPqo
   hD1MtfV/uhDZd6HFQ/BHFhhK5ySPEBiHTP7CkGf5fSJXfdGfaOuAfkHk4
   yUppnMxlTII3DhHfBKmQxSAr8z9Q2JtHtb8Lh8FJl77gPRJXP+5Me5BGi
   9955Byhl33EgZNNv7cypGwndynm+DPOmOANz4nisVriArtAoD7R/tla2S
   2Rq/1Y8KgKAaEek8/uaSbJfIamwoas69XdC8nkO4V/DBE8xttd+DJQ67/
   9UOJ8+4Ls931hm8QdS5hW0o3L2sbqtje9z5TR3Wkxdb0wym9xyfB4KKCZ
   w==;
X-CSE-ConnectionGUID: 7Pv5B3OeTKCUiqlqM0gOxw==
X-CSE-MsgGUID: 33E3iJDET6CCvnpbn7YUCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="46874432"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="46874432"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 09:48:38 -0700
X-CSE-ConnectionGUID: lICXhsAfTs2lDVeEx4Nlog==
X-CSE-MsgGUID: 9Wl/UvjAQFSmn6faTgzZoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="136747043"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 24 Apr 2025 09:48:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6EBEA1AC; Thu, 24 Apr 2025 19:48:33 +0300 (EEST)
Date: Thu, 24 Apr 2025 19:48:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: cl@linux.com, rientjes@google.com, vbabka@suse.cz,
	roman.gushchin@linux.dev, harry.yoo@oracle.com, surenb@google.com,
	pasha.tatashin@soleen.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	quic_tingweiz@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm, slab: clean up slab->obj_exts always
Message-ID: <aAprYawGu-u9a4py@black.fi.intel.com>
References: <20250421075232.2165527-1-quic_zhenhuah@quicinc.com>
 <aApoFXmDE-k2KFFV@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aApoFXmDE-k2KFFV@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 24, 2025 at 07:34:29PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 21, 2025 at 03:52:32PM +0800, Zhenhua Huang wrote:
> > When memory allocation profiling is disabled at runtime or due to an
> > error, shutdown_mem_profiling() is called: slab->obj_exts which
> > previously allocated remains.
> > It won't be cleared by unaccount_slab() because of
> > mem_alloc_profiling_enabled() not true. It's incorrect, slab->obj_exts
> > should always be cleaned up in unaccount_slab() to avoid following error:
> > 
> > [...]BUG: Bad page state in process...
> > ..
> > [...]page dumped because: page still charged to cgroup
> 
> Please, always compile test with `make W=1`. Since CONFIG_WERROR=y this
> effectively breaks the build with Clang.

FWIW, fix has just been sent:
20250424164800.2658961-1-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko



