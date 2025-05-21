Return-Path: <stable+bounces-145941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3570CABFEE0
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 23:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA97D4E5392
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 21:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EE42BD010;
	Wed, 21 May 2025 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvJgU9TE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5828FA96;
	Wed, 21 May 2025 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747862768; cv=none; b=fyO9uPvLzM23wtzacgB+KTx8fFdzEtBmbTFJkeJtbeiUuvasvVHMhI5NvHbn+v/Q8sSuBxmWCQroMY43lh1k66jFlpEl/rh29IeXyW4zbooWyop7mKrosSk1hQybR/gdNr7tV7S8IQk6C1IYimAwnQg0UNGgQu4JxDImUV9K3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747862768; c=relaxed/simple;
	bh=bcXmaaPzQjxXCtKv8uM2pdouSD5ZCy58z4JthWLzheA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ez4+crCFEICFgmQ9M+fyuI2IETsM9a6EviaE4h6Jvy7qsGj2FW7XCjHEqOi/ol+XDF/3TugY1V+wRLTofMQt/BuOatXLg3KjdiF8d5/xwoXyS/SZlnIMHoILHzppO7b3k7o1dcEk89eUCSrgpugvzcwLZm9EH9Xi5ecwjF8TLks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvJgU9TE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747862766; x=1779398766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bcXmaaPzQjxXCtKv8uM2pdouSD5ZCy58z4JthWLzheA=;
  b=hvJgU9TEe1M4r/oLiZYojSjadIx7n0n2Nj4VT0NA7n0iCHWgJeBqXmJe
   OQMGxzUKCdz3zgX0PuI4CvItRfF4eRcZnsuErlqjIoAxmf2o0G9QJ5vN9
   OyAYSnFguMTtPUulNwcG/IWhaHPkLmZCL0AeN16q3M4ZGoSGGwjBLN2f4
   UbvDsCni6jMXQTU6Eor4jLH6Tb6iCsgl6Mko7sRBxCkYvAyW97SBCiVdb
   xSaCEvLnnfOg1uuz6wapTmp2QzbS1Gh9yAmS4i8KLe6d/V3QLYo06dTk1
   XQwRYOqk+loH4inIKkC0/O/GMyGaF/THIYee9AIWBEqmWaxlcmjW2Bf00
   A==;
X-CSE-ConnectionGUID: tUykYRcIT/at6wqM00yT7w==
X-CSE-MsgGUID: wuhg6ZUvQFihpEWSs+9u7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="61207328"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="61207328"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:26:05 -0700
X-CSE-ConnectionGUID: z+3VBKYXQ5KkKqOJj9HalQ==
X-CSE-MsgGUID: pPhP+5HhSbezxQOijYiolg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="145390862"
Received: from ssuvarig-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.23])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:26:05 -0700
Date: Wed, 21 May 2025 14:25:56 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org,
	Salvatore Bonaccorso <carnil@debian.org>,
	Moritz =?utf-8?Q?M=C3=BChlenhoff?= <mmuhlenhoff@wikimedia.org>
Subject: Re: [PATCH 5.15 00/59] 5.15.184-rc1 review
Message-ID: <20250521212103.gpdkplv77acgsdsb@desk>
References: <20250520125753.836407405@linuxfoundation.org>
 <81cd1d38-8856-4b27-921d-839d9e385942@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81cd1d38-8856-4b27-921d-839d9e385942@oracle.com>

On Wed, May 21, 2025 at 09:10:58PM +0200, Alexandre Chartre wrote:
> It looks the problem comes from pages allocated for dynamic thunks for modules, and
> this patch appears to fix the problem:
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 43ec73da66d8b..9ca6973e56547 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -460,6 +460,8 @@ void its_free_mod(struct module *mod)
>         for (i = 0; i < mod->its_num_pages; i++) {
>                 void *page = mod->its_page_array[i];
> +               set_memory_nx((unsigned long)page, 1);
> +               set_memory_rw((unsigned long)page, 1);
>                 module_memfree(page);
>         }
>         kfree(mod->its_page_array);
> 
> I don't know the exact underlying issue but I suspect that the kernel doesn't
> correctly handle pages freed without the write permission, and restoring page
> permissions to rw (instead of rox) before freeing prevent the problem.

Your analysis aligns with the proposed fix to backport below patch as well:

x86/modules: Set VM_FLUSH_RESET_PERMS in module_alloc()
https://lore.kernel.org/stable/20250521171635.848656-1-pchelkin@ispras.ru/

