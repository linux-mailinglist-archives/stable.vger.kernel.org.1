Return-Path: <stable+bounces-86848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFC49A41BF
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 16:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DEB1F25D06
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 14:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE651FF5F0;
	Fri, 18 Oct 2024 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rjikpbnh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989320E327;
	Fri, 18 Oct 2024 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263167; cv=none; b=PBU7yqlYAW4Gz8wbGRx7mqYjttYDcII8aDsyO04PksOkJbc5LSUBFp7gBQK1GWOH1QhxpyXVFxUeheI4kfSPQBv1Mdl/0axhfPNn1J65281RbvNk1614TfWktYcHqO62+LLDhCoYr4E3tVmNTflv6VVbbthajEFIi3KFtgncPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263167; c=relaxed/simple;
	bh=p6gcj2E2AWyHapsnii9ApBkSENMZ4qCfzEIAfYkDheU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aj88vzUQuYDniSU0PYme62Pyrd1VBMF4eoCvjddRZ9YazdLEcCB22EsSS66x5ap2T9xyttCE/4u+tPkKVdBmw9eQgEXxGI5A8rpeFYlkL4k2Kj4E9m8i7dyJjOOl/2bdLZORo5habd8FYE/o1WQW2DJEati4xEqkfLlrwguHz9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rjikpbnh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729263166; x=1760799166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p6gcj2E2AWyHapsnii9ApBkSENMZ4qCfzEIAfYkDheU=;
  b=RjikpbnhTNddCYTZWOpXvTXrFjZeZe3eMejFOKrQdqo8MkoZj53ExNQj
   EA7PSTt3qsV2qr+dHGwl3uALSHOTyL6LAH1hx2PD6Zq7RUoQfCzA54Ihk
   BhLIuj0d2+oYdaP8yuMputH25up/nA6NEorKVze4Nd/IYvOhmWEt8SYGQ
   ftr+nt7ogjod5BX9OD86F/SpvO5lePruLeFnJ6c5Vu4mSGQS0m1J9n24d
   XevT774sy1frH7r7fRqWvLwIwwhZw2+lOJlBLY0gLKux59CmrGpbHbxrb
   r2HUThQZzuWRkRaWrZsAPOZsHopWHRO7JdLg8IkeNMeqNyUNiahHjFBeS
   Q==;
X-CSE-ConnectionGUID: NfMulYT1QpiphI4eXhIinA==
X-CSE-MsgGUID: gxFECs2NSUWlZ1rkpnW/xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="28931383"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="28931383"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:52:45 -0700
X-CSE-ConnectionGUID: hTqHQxmDRla9eZdI7ktgNw==
X-CSE-MsgGUID: R5JGxbFyTeCcgIegNnEoRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="83463777"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:52:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t1oLH-00000004VIk-40Oj;
	Fri, 18 Oct 2024 17:52:39 +0300
Date: Fri, 18 Oct 2024 17:52:39 +0300
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
Message-ID: <ZxJ2NxXpqowd73om@smile.fi.intel.com>
References: <20241017190347.5578-1-gourry@gourry.net>
 <ZxHFgmHPe3Cow2n8@MiWiFi-R3L-srv>
 <ZxJTDq-PxxxIgzfv@smile.fi.intel.com>
 <ZxJoLxyfAHxd18UM@MiWiFi-R3L-srv>
 <ZxJ13aKBqEotI593@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxJ13aKBqEotI593@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 18, 2024 at 05:51:09PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 18, 2024 at 09:52:47PM +0800, Baoquan He wrote:
> > On 10/18/24 at 03:22pm, Andy Shevchenko wrote:
> > > On Fri, Oct 18, 2024 at 10:18:42AM +0800, Baoquan He wrote:
> > > > On 10/17/24 at 03:03pm, Gregory Price wrote:
> > > > > walk_system_ram_res_rev() erroneously discards resource flags when
> > > > > passing the information to the callback.
> > > > > 
> > > > > This causes systems with IORESOURCE_SYSRAM_DRIVER_MANAGED memory to
> > > > > have these resources selected during kexec to store kexec buffers
> > > > > if that memory happens to be at placed above normal system ram.
> > > > 
> > > > Sorry about that. I haven't checked IORESOURCE_SYSRAM_DRIVER_MANAGED
> > > > memory carefully, wondering if res could be set as
> > > > 'IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY' plus
> > > > IORESOURCE_SYSRAM_DRIVER_MANAGED in iomem_resource tree.
> > > > 
> > > > Anyway, the change in this patch is certainly better. Thanks.
> > > 
> > > Can we get more test cases in the respective module, please?
> > 
> > Do you mean testing CXL memory in kexec/kdump? No, we can't. Kexec/kdump
> > test cases basically is system testing, not unit test or module test. It
> > needs run system and then jump to 2nd kernel, vm can be used but it
> > can't cover many cases existing only on baremetal. Currenly, Redhat's
> > CKI is heavily relied on to test them, however I am not sure if system
> > with CXL support is available in our LAB.
> > 
> > Not sure if I got you right.
> 
> I meant since we touch resource.c, we should really touch resource_kunit.c
> *in addition to*.

And to be more clear, there is no best time to add test cases than
as early as possible. So, can we add the test cases to the (new) APIs,
so we want have an issue like the one this patch fixes?

-- 
With Best Regards,
Andy Shevchenko



