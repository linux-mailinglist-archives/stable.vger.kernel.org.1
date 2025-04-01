Return-Path: <stable+bounces-127293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 027B1A775C4
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 09:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5065A188B9D1
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 07:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BB01E7C11;
	Tue,  1 Apr 2025 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2UOoP3N"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A111078F
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743494261; cv=none; b=sP6/uRmbLxCX53G8/5onZ+jm6RRSSdLClkD0xm1Pl8M+MLcxgiPNCyVVuBeMpRw8QFDl15e24aH91bc6O+bM6kwMFpH1MUKPexQ5wFwIwhRrTya1xgp70gcDpggXdATkw0wV903m147Ysogc/hNoaL4FgSgm1Bmz3WHht7aog+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743494261; c=relaxed/simple;
	bh=gsOC6Rdr7oKwXyERdvN9ZCknZbemPP5V4VJ2wdV1FgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7pV9gK31bCaKPxrbtENyr0CUKlLhVuHDIRrN0KxhRTET8hpIk6pdU/ZTCexLn75L6iQGCZQesMiHE5UsfLBA+U7IKp9LsDanBCESheIbyPFzAJr4nO/bMhI8hlawy8oAsOZp9caIv+5eM+X62i05UjoNWNJq+7M8DpLH0aWWsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2UOoP3N; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743494258; x=1775030258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gsOC6Rdr7oKwXyERdvN9ZCknZbemPP5V4VJ2wdV1FgE=;
  b=j2UOoP3N5Qg2Yzp5uEKTdcU6arkoKupPyO/DMNePjzo/ZB9E47KAByJ9
   retf9jNm1hTb79v04oVIwnCr/L1ZaKX0RIOyEr/8Gy8iBpAWgukrjiBuM
   W5gAlCPwofYa+knazz9vaoDbQoqWwFinjD19nq7fYW4+N+MKa4EEm/nAf
   JgnQFFq2+/iYwk2v9w/5pofmo9V+bryVLYU9GRI9whHyQCR2LsBMAx3ni
   8KudHhB5EQdr8qkpcVM45DPmvmsFiMNCdP7hh1xXKJSpX5aB/CaCvSKM2
   81nkY9i9pF0TGFL5Qoi8+y110ORz3WTvxaOCgMA7VoXn0s2GFW67QnsRQ
   Q==;
X-CSE-ConnectionGUID: gGcViaerQ0qi4UqfHzhmdA==
X-CSE-MsgGUID: 7JTUoykHR5K/iVCErIZvHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44054386"
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="44054386"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 00:57:38 -0700
X-CSE-ConnectionGUID: n/HefCdgTY6bVQlhI/Aoyw==
X-CSE-MsgGUID: 04wal0V/Tc6yT+lACGj31A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="131172051"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 01 Apr 2025 00:57:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 825BC278; Tue, 01 Apr 2025 10:57:34 +0300 (EEST)
Date: Tue, 1 Apr 2025 10:57:34 +0300
From: Kirill Shutemov <kirill.shutemov@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: dave.hansen@linux.intel.com, x86@kernel.org, 
	Vishal Annapurve <vannapurve@google.com>, Nikolay Borisov <nik.borisov@suse.com>, stable@vger.kernel.org, 
	linux-coco@lists.linux.dev
Subject: Re: [PATCH] x86/ioremap: Maintain consistent IORES_MAP_ENCRYPTED for
 BIOS data
Message-ID: <z7h6sepvvrqvmpiccqubganhshcbzzrbvda7dntzufqywei4gz@6clsg5lbvamd>
References: <174346288005.2166708.14425674491111625620.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174346288005.2166708.14425674491111625620.stgit@dwillia2-xfh.jf.intel.com>

On Mon, Mar 31, 2025 at 04:14:40PM -0700, Dan Williams wrote:
> Nikolay reports [1] that accessing BIOS data (first 1MB of the physical
> address space) via /dev/mem results in an SEPT violation.
> 
> The cause is ioremap() (via xlate_dev_mem_ptr()) establishing an
> unencrypted mapping where the kernel had established an encrypted
> mapping previously.
> 
> Teach __ioremap_check_other() that this address space shall always be
> mapped as encrypted as historically it is memory resident data, not MMIO
> with side-effects.

I am not sure if all AMD platforms would survive that.

Tom?

> 
> Cc: <x86@kernel.org>
> Cc: Vishal Annapurve <vannapurve@google.com>
> Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Nikolay Borisov <nik.borisov@suse.com>
> Closes: http://lore.kernel.org/20250318113604.297726-1-nik.borisov@suse.com [1]
> Tested-by: Nikolay Borisov <nik.borisov@suse.com>
> Fixes: 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/mm/ioremap.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 42c90b420773..9e81286a631e 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -122,6 +122,10 @@ static void __ioremap_check_other(resource_size_t addr, struct ioremap_desc *des
>  		return;
>  	}
>  
> +	/* Ensure BIOS data (see devmem_is_allowed()) is consistently mapped */
> +	if (PHYS_PFN(addr) < 256)

Maybe
	if (addr < BIOS_END)

?

> +		desc->flags |= IORES_MAP_ENCRYPTED;
> +
>  	if (!IS_ENABLED(CONFIG_EFI))
>  		return;
>  
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

