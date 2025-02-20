Return-Path: <stable+bounces-118498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 173ADA3E341
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 19:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1638819C0322
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 18:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6632139DB;
	Thu, 20 Feb 2025 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0sbsXDK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43852135A2;
	Thu, 20 Feb 2025 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074576; cv=none; b=ZPVUi0a8glyi4xVYs+d/XU2yJCmDReAM1TuEXmtGytlUgnUfUaDZjEsWeBjxDGPxYcxcZEDKKr/k6WdEBp45Df89pwdT9Igge7U9V+aiCVnZlfhjUBjQbFzH09yVs2eamcajmr9vgPEVpd39uFwgcWU54xbmH59dRjjxk2i+fx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074576; c=relaxed/simple;
	bh=CUChw1zpKX1czFg5QtOhwWs6v9dQ8q/Dvl9QBfBP5/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZzz28ba9iv83zKcARWDMWzm2zWOljzulKD7Kp3ZTAXdBWyGlVZWo47VfjsgaOAZ39sQACZwpzVXADLq6oVq1sJKoSdOnzFTDqG2dNTrjUNlAw8tm6ZxRXAh4L1UyVidX/6lBak5qw+PCDDiUIt4nCnj/zspxxgIFSPoTm1LUDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0sbsXDK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740074575; x=1771610575;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CUChw1zpKX1czFg5QtOhwWs6v9dQ8q/Dvl9QBfBP5/0=;
  b=a0sbsXDKXwL8alAjuL0WF145c1UrZkyTjSF6h2kCiuFUdDMO7WhhyBSa
   t51OCncozUN1gdPZhlC3+YMqrZySYN6YqNYrMpyKpZJaGoeDuXT98hx5Z
   uWOgovvc/8VXH6EDzHxQyK1IwDwf6lPi4dNmcRoNNYst4KNB3YZR1g8dm
   Gyq+3kLjPbZ3fnNQpVJe2jtls2vISFhlORY1f9VxBd1LNw4uvP4jNfyo+
   kIRdl7E0Y8mEo+n9PVjVvKNJAB1617HN2E+z4N7qUH9SxEJQDSnYgAGb5
   dMUOdHuVBbWtVbHfjsfhgyAsV5CMOdEVukFMKU1iHWhaenCEuWA9xRqcy
   g==;
X-CSE-ConnectionGUID: RKrZoccAQ2KLAukXU1xklw==
X-CSE-MsgGUID: wrp1g1bzQqOU5Ritco42aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="63346303"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="63346303"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 10:02:54 -0800
X-CSE-ConnectionGUID: W9agr/+RTS6tJSBDtvX1pg==
X-CSE-MsgGUID: VDrQa2UqS4KG472jDCWkCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="120219174"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.82]) ([10.125.110.82])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 10:02:53 -0800
Message-ID: <d1da214c-53d3-45ac-a8b6-51821c5416e4@intel.com>
Date: Thu, 20 Feb 2025 10:02:54 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/vmemmap: Synchronize with global pgds if populating
 init_mm's pgd
To: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>, linux-kernel@vger.kernel.org
Cc: osalvador@suse.de, 42.hyeyoo@gmail.com, byungchul@sk.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 akpm@linux-foundation.org, stable@vger.kernel.org, linux-mm@kvack.org,
 max.byungchul.park@sk.com, max.byungchul.park@gmail.com
References: <20250220064105.808339-1-gwan-gyeong.mun@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250220064105.808339-1-gwan-gyeong.mun@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/19/25 22:41, Gwan-gyeong Mun wrote:
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 01ea7c6df303..7935859bcc21 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1498,6 +1498,54 @@ static long __meminitdata addr_start, addr_end;
>  static void __meminitdata *p_start, *p_end;
>  static int __meminitdata node_start;
>  
> +static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
> +{
> +	void *p = vmemmap_alloc_block(size, node);
> +
> +	if (!p)
> +		return NULL;
> +	memset(p, 0, size);
> +
> +	return p;
> +}

This is a pure copy and paste of the generic function. I assume this is
because the mm/sparse-vmemmap.c is static. But this kind of copying is
really unfortunate.

...
> +pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
> +{
> +	pgd_t *pgd = pgd_offset_k(addr);
> +
> +	if (pgd_none(*pgd)) {
> +		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
> +
> +		if (!p)
> +			return NULL;
> +
> +		pgd_populate(&init_mm, pgd, p);
> +		sync_global_pgds(addr, addr);
> +	}
> +
> +	return pgd;
> +}

I'd _really_ like to find another way to do this. We really don't want
to add copy-and-paste versions of generic functions that we now need to
maintain on the x86 side.

The _best_ way is probably to create some p*d_populate_kernel() helpers:

void pgd_populate_kernel(unsigned long addr, pgd_t *pgd, p4d_t *p4d)
{
	pgd_populate(&init_mm, pgd, p4d);
	arch_sync_global_pgds(addr, addr+something);
}

and move over most of the callers of:

	p*d_populate(&init_mm, ...);

Because I suspect that'll fix your issue _and_ solve the generic class
of issues where folks populate a kernel page table entry but forget to
call sync_global_pgds().

