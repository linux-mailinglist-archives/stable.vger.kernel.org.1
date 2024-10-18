Return-Path: <stable+bounces-86847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 552B89A41BA
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 16:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0206289655
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 14:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14F01FF5F9;
	Fri, 18 Oct 2024 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIt+JL7L"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF9E10E4;
	Fri, 18 Oct 2024 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263078; cv=none; b=Pf36+ZPH+b2+2QB42fpfzGj9o4PX/hpzmdj8QLG6t/UENwL4j9NR6Unxh4nPcdTjXhlb0zzhwU5DDrAPwMfiJrD5ILD7zCiAbrLLUinUFRDk8tB8NRmOzze/sfjmI1sKFQKr37DcWtl1qEUhWuz+bb/+Up/wDhNASajyxwww4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263078; c=relaxed/simple;
	bh=SvFFtXDRxbY5FZUBQWKu5jXQobvklQTQdXW0nWSFaTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIdchyj1D5vbCwlOv6UaIOzhaLOaqs9Mzk3WTDrCv7cCb+pYdbMUOennpbyo1jwhvc37vDUe0PlxfY5oEUREb3j8VcJlUgiXYbjAgVbIagILp/dW3zhezI8FcQilMLwt5fRfoI0+LbXJxnb9N4RYmWs+S+tXem/1Ss/9rHjxAMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIt+JL7L; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729263077; x=1760799077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SvFFtXDRxbY5FZUBQWKu5jXQobvklQTQdXW0nWSFaTk=;
  b=oIt+JL7LA7ZPBve5xMAADAM7LYwGuNjpD9MHNLLA/3SjVUcdIAmdSQA4
   aVOV7lexTBGkpPEMvJcHYA3QzOmWgbm4H/seBfQM+PorMaXBqNh+ykJoj
   oSKb88RMU7RwnfLoBcpW5SLLjk4WI4CWD0TJvWS3lrVywWPt56J39vsRe
   OCua6B6DxhbB3j8IdfqT0/iCpWRVLeiHAAfliCPnYNWdCXgSeM+XaaeHv
   JTk0rxMhb05FGXTDlk38H/uLHBreG1Ks0iMa0+Ocl8qSuK420iPbLM6JO
   6BL+v/9Gcz98HkgWS3yvFO9VJKzmqW2Z8EvK181FoVPFIZvaTk1GzHrht
   g==;
X-CSE-ConnectionGUID: XQ0X5kJmS3a8T8PRYInoKg==
X-CSE-MsgGUID: ABHinBqzQLKxAUd3GIHDDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="32723765"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="32723765"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:51:16 -0700
X-CSE-ConnectionGUID: GtEjq0w+RiC9vSvLGh+Orw==
X-CSE-MsgGUID: Ei+TJ5/0TPudtRSBGS+kzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="78845662"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:51:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t1oJp-00000004VH8-3nZe;
	Fri, 18 Oct 2024 17:51:09 +0300
Date: Fri, 18 Oct 2024 17:51:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: Gregory Price <gourry@gourry.net>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	mika.westerberg@linux.intel.com, ying.huang@intel.com,
	tglx@linutronix.de, takahiro.akashi@linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] resource,kexec: walk_system_ram_res_rev must retain
 resource flags
Message-ID: <ZxJ13aKBqEotI593@smile.fi.intel.com>
References: <20241017190347.5578-1-gourry@gourry.net>
 <ZxHFgmHPe3Cow2n8@MiWiFi-R3L-srv>
 <ZxJTDq-PxxxIgzfv@smile.fi.intel.com>
 <ZxJoLxyfAHxd18UM@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxJoLxyfAHxd18UM@MiWiFi-R3L-srv>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 18, 2024 at 09:52:47PM +0800, Baoquan He wrote:
> On 10/18/24 at 03:22pm, Andy Shevchenko wrote:
> > On Fri, Oct 18, 2024 at 10:18:42AM +0800, Baoquan He wrote:
> > > On 10/17/24 at 03:03pm, Gregory Price wrote:
> > > > walk_system_ram_res_rev() erroneously discards resource flags when
> > > > passing the information to the callback.
> > > > 
> > > > This causes systems with IORESOURCE_SYSRAM_DRIVER_MANAGED memory to
> > > > have these resources selected during kexec to store kexec buffers
> > > > if that memory happens to be at placed above normal system ram.
> > > 
> > > Sorry about that. I haven't checked IORESOURCE_SYSRAM_DRIVER_MANAGED
> > > memory carefully, wondering if res could be set as
> > > 'IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY' plus
> > > IORESOURCE_SYSRAM_DRIVER_MANAGED in iomem_resource tree.
> > > 
> > > Anyway, the change in this patch is certainly better. Thanks.
> > 
> > Can we get more test cases in the respective module, please?
> 
> Do you mean testing CXL memory in kexec/kdump? No, we can't. Kexec/kdump
> test cases basically is system testing, not unit test or module test. It
> needs run system and then jump to 2nd kernel, vm can be used but it
> can't cover many cases existing only on baremetal. Currenly, Redhat's
> CKI is heavily relied on to test them, however I am not sure if system
> with CXL support is available in our LAB.
> 
> Not sure if I got you right.

I meant since we touch resource.c, we should really touch resource_kunit.c
*in addition to*.

-- 
With Best Regards,
Andy Shevchenko



