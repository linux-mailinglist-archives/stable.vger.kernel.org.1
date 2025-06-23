Return-Path: <stable+bounces-156161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB7DAE4DA5
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA46189F2E0
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 19:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE9A2D4B7E;
	Mon, 23 Jun 2025 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWxxu8ob"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8812D4B57
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750707206; cv=none; b=j+i48juuWu4ySk+YdQLQ4AvRrEz9VWVO9lu8sERzyz+8xW+k6N4zMTbF2FziLnA7cKJ7Y1et92xjQhhTtx5IsaOCcE9zqBwvtWmAfBxMJKwB77AeHd2MWhh9NyeQmLOmx5rCmqJlcxcPpOnW2SHdrepqSUng0Xo/9AoklQrZpEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750707206; c=relaxed/simple;
	bh=CcqoJKLFmFYw0m73e93oUNfjIgpeLpNeXEeLbWTYdLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmfspbDuDfqHuwz3pYYg6YK0ZLPlwSi+sFOxFWV8Q25s7/1rnaU5zZOZflcD+gQBBz7N1VRY4Ju3nzA3emNOahNuPwowQP9hLhmDaTRvRERZVDOR81+WS+z6zVRFDZfpPkfNtQ7aDgkJ+5XXklOzIF5//5IApvgksglmM2iWKdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bWxxu8ob; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750707205; x=1782243205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CcqoJKLFmFYw0m73e93oUNfjIgpeLpNeXEeLbWTYdLA=;
  b=bWxxu8obryzAGWbLFCSIVpsvAl9jB7/S+LDoPt1h51+tjd/jkbg0EV0f
   HvO25NYFpc9suFrm975sDxKHIV8Hgeng669a+hG1VjqK3nvoZyfwPsahA
   I0cY8Fg9lkEVgT0fshPcvJ/fU1gXDBf+pWyqA/3pNqD1hLVZsl8jEdRu/
   FOm2VS37GIKhXS/zVE9YYQ9E2+/Q8ClmC3BZ93ZmIf3PNRWpcy+2b6Kfk
   5Fs/NAo4MKrmxhdSLGabSXzHFlCH/OHX8KSe3VHga5pHKUGoa0l1jt14L
   jWP7LYKMDDwrSSZ5GAsXom2FqPhkxGlT4HDBwoPMi9YSbmPWcru14C7w9
   w==;
X-CSE-ConnectionGUID: Vy7a6x/ASmOs8mbTnRyEsA==
X-CSE-MsgGUID: 9YygrJl+SLeMELtsqPQWVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="64360537"
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; 
   d="scan'208";a="64360537"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 12:33:24 -0700
X-CSE-ConnectionGUID: Mbz4DYmeQjGaiQpp249foQ==
X-CSE-MsgGUID: sUtiOcAaTzeT2ybA9Z76ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; 
   d="scan'208";a="151861805"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 12:33:24 -0700
Date: Mon, 23 Jun 2025 12:33:18 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10 v2 14/16] x86/its: Use dynamic thunks for indirect
 branches
Message-ID: <qitd2zp6utylq3timqd7cwlp52rlgdnqcrepmqfgubwbx2rwsh@zstzxye6mb6c>
References: <20250617-its-5-10-v2-14-3e925a1512a1@linux.intel.com>
 <20250618191253-b7cbd0fce517a243@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250618191253-b7cbd0fce517a243@stable.kernel.org>

On Thu, Jun 19, 2025 at 05:03:16AM -0400, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Summary of potential issues:
> ℹ️ This is part 14/16 of a series
> ⚠️ Found follow-up fixes in mainline
> 
> The upstream commit SHA1 provided is correct: 872df34d7c51a79523820ea6a14860398c639b87
> 
> WARNING: Author mismatch between patch and upstream commit:
> Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
> Commit author: Peter Zijlstra<peterz@infradead.org>
> 
> Status in newer kernel trees:
> 6.15.y | Present (exact SHA1)
> 6.12.y | Present (different SHA1: 88a817e60dbb)
> 6.6.y | Present (different SHA1: 3b2234cd50a9)
> 6.1.y | Present (different SHA1: 959cadf09dba)
> 5.15.y | Present (different SHA1: 1b231a497756)
> 
> Found fixes commits:
> a82b26451de1 x86/its: explicitly manage permissions for ITS pages

This commit is not required, 5.10 already explicitly manages permissions
via set_memory_*() calls and patch 13/16 (x86/modules: Set
VM_FLUSH_RESET_PERMS in module_alloc()).

> 0b0cae7119a0 x86/its: move its_pages array to struct mod_arch_specific

This is not a functional change, and hence not mandatory.

> 9f35e33144ae x86/its: Fix build errors when CONFIG_MODULES=n

This is patch 15/16.

