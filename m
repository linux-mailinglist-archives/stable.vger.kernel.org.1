Return-Path: <stable+bounces-86824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDBE9A3EF6
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 14:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0231C2520E
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 12:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AF143AB0;
	Fri, 18 Oct 2024 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BjJBlnZs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D265813AA2A;
	Fri, 18 Oct 2024 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729256260; cv=none; b=qkHNP8aJEYkJ7Gi1h3QfMAmnyApQ151TjB0L4Cj6kv+bqsGzoHJZ5lZiGHxke7D7uTtmodFWRVnYKLIiQ+H5gSiQqq1onqHDpTl9TxE4tflwZlaBggNynDC1evKvJiJ964JU0JNbXXu5uj96exKsjLDTmqm+XtSJx4zOaUYusHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729256260; c=relaxed/simple;
	bh=0vi3a1mXgYGi7GRXfKsrnUCbV0Q+BiHOW7Bq6nhRpVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVYK9yK80fGpoH3L4IvdE9EUPfWjYXh0pTM6Wa/gGVWB5k8C9TRxQVCLI9ZCBI67T9EvZHCuiajEqO+3aaTpPp6abK82I14O4AwdzOitPn5lMMaNXSWNewJHZ7RYlXN5A2xphBFQpjoH0NTwed1K9beHCtsqxWvqlNmTHm80n5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BjJBlnZs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729256259; x=1760792259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0vi3a1mXgYGi7GRXfKsrnUCbV0Q+BiHOW7Bq6nhRpVk=;
  b=BjJBlnZsGx7fb0FLTgI9K5ZDeK7oDvGRIrp+z23hUjJzOSCnfatZmcRJ
   UaPD6JPcDxnuw9qn4CuwKnc3D7HUwlpZ0E8URhnPXFPNlt+8QgttgLexa
   4X/zDdFG1q7t4A3ckMD2Sk4MNEkkodrFjZdXVqweSn4RhUI3BRzFcQMvH
   INqHt0ntSLY2t4chyVH63XjqISVDFAtvmHi9tavQfJYApa+3Z82rVoYMC
   sNZaH7IPc1iayYc1oga27Bp4d7eRowNSe/ev1uOpbr2I3qPtJy3J4lXaO
   47BaFcMJWY3OCwPZWSwrbgtG5kuX9fzhX5vGL+rM6y5glJ948UFSPImDz
   Q==;
X-CSE-ConnectionGUID: uZ78g29WR1u+jBEQxxm1sg==
X-CSE-MsgGUID: CoAn6KX+TbOolnQRkRIDNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="39412773"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="39412773"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:57:37 -0700
X-CSE-ConnectionGUID: G9LB692CSuS0E4anPdXY2w==
X-CSE-MsgGUID: r3KnnZ/hSOqpnxrDRYyR+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="79283610"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:57:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t1mXq-00000004T8S-2EsZ;
	Fri, 18 Oct 2024 15:57:30 +0300
Date: Fri, 18 Oct 2024 15:57:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, mika.westerberg@linux.intel.com,
	ying.huang@intel.com, bhe@redhat.com, tglx@linutronix.de,
	takahiro.akashi@linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH] resource,kexec: walk_system_ram_res_rev must retain
 resource flags
Message-ID: <ZxJbOinZ0E4Ppmak@smile.fi.intel.com>
References: <20241017190347.5578-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017190347.5578-1-gourry@gourry.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 17, 2024 at 03:03:47PM -0400, Gregory Price wrote:
> walk_system_ram_res_rev() erroneously discards resource flags when
> passing the information to the callback.
> 
> This causes systems with IORESOURCE_SYSRAM_DRIVER_MANAGED memory to
> have these resources selected during kexec to store kexec buffers
> if that memory happens to be at placed above normal system ram.
> 
> This leads to undefined behavior after reboot. If the kexec buffer
> is never touched, nothing happens. If the kexec buffer is touched,
> it could lead to a crash (like below) or undefined behavior.
> 
> Tested on a system with CXL memory expanders with driver managed
> memory, TPM enabled, and CONFIG_IMA_KEXEC=y. Adding printk's
> showed the flags were being discarded and as a result the check
> for IORESOURCE_SYSRAM_DRIVER_MANAGED passes.
> 
> find_next_iomem_res: name(System RAM (kmem))
> 		     start(10000000000)
> 		     end(1034fffffff)
> 		     flags(83000200)
> 
> locate_mem_hole_top_down: start(10000000000) end(1034fffffff) flags(0)
> 
> [.] BUG: unable to handle page fault for address: ffff89834ffff000

Please, cut this down to only important ~3-5 lines as suggested in
the Submitting Patches documentation.

Yeah, I see that Andrew applied it to hist testing branch, if it's not going to
be updated there, consider above as a hint for the future contributions with
backtraces.

-- 
With Best Regards,
Andy Shevchenko



