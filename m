Return-Path: <stable+bounces-86861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695FC9A430C
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 17:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1EC6B225E4
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 15:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4532022D7;
	Fri, 18 Oct 2024 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzSwBoqU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51270165EFC;
	Fri, 18 Oct 2024 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267077; cv=none; b=RycnfZ+sfqhuTF904vGOj2hnk7XUnPUl7t5+mu9018pwtimk5YHZsiDAlbAXGh9YBFZ0gLqDUCTTTumWETB5LX4Lgrad6uqQFo38OQaTiP/WTjPHPAJNO8nZWffCF2pI7C5OmJrBYhH1aOmaHwFbQ10dHk5HF99DTQPYTbGmxG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267077; c=relaxed/simple;
	bh=/jhK/IFMqwYDsQdHj+5TZBuOduQ+FEeTuIymxvj+BtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Id4LNhBYUIRBGu74YeAgjMeGcLx5bPwR8Blb8Acvrw7M/fUbuUx9J2URO1Vc0IISG3RhtIHgKD9w9av9ZZPAJ6h7u0thQJc2zBaghGQ3Yptfd5cVnqfASkHMq0JhM+ToZkh2CuA05IHFBdqPhao4ENXmoE4qYu6p44rNoaNOEzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzSwBoqU; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729267075; x=1760803075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/jhK/IFMqwYDsQdHj+5TZBuOduQ+FEeTuIymxvj+BtU=;
  b=KzSwBoqU28f6rjcSyVhUPVQVZ7CtdrUcMdUS9B2NnVKXg6KArmN63VpI
   xz8DpO9A3pNzbQM34I5XfDoTd3pllzgglkI1bNwDmKXWjt+faaOhP56I5
   xevIenPn1qCW6BVqSjWxvnIooFTLEnEct9J0gedb2A0lJ/PJjZXJXuY9j
   sW1rtWxjj3Rm7bU8tETctkc8/5fIeQfr3WojMiG7sZdUXBflMlyflT1w0
   o8Or3o1FJOqqv80nXX4f+QFtBrRHFj1OU56DozhR+WlkSYGiG3lk366Gv
   JJ3CJ1ZfDs8zdXOzvLxPi5BwtdTWnTYal2aaCIQMa425bl75l+h33m4G9
   A==;
X-CSE-ConnectionGUID: whs8T819Sw29+cFEzzTm6g==
X-CSE-MsgGUID: mzsYS/L7Rxu+QUPjKY7o6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="40200885"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="40200885"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 08:57:54 -0700
X-CSE-ConnectionGUID: J/Sl4MABSPKELOlAeygCFg==
X-CSE-MsgGUID: qlkVBjWrQuebpoPjghY1gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="83534334"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 08:57:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t1pMK-00000004WXx-3hbY;
	Fri, 18 Oct 2024 18:57:48 +0300
Date: Fri, 18 Oct 2024 18:57:48 +0300
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
Message-ID: <ZxKFfOIOhxlw2YJD@smile.fi.intel.com>
References: <20241017190347.5578-1-gourry@gourry.net>
 <ZxHFgmHPe3Cow2n8@MiWiFi-R3L-srv>
 <ZxJTDq-PxxxIgzfv@smile.fi.intel.com>
 <ZxJoLxyfAHxd18UM@MiWiFi-R3L-srv>
 <ZxJ13aKBqEotI593@smile.fi.intel.com>
 <ZxJ2NxXpqowd73om@smile.fi.intel.com>
 <ZxKBFMAecrL25Fwb@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxKBFMAecrL25Fwb@MiWiFi-R3L-srv>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 18, 2024 at 11:39:00PM +0800, Baoquan He wrote:
> On 10/18/24 at 05:52pm, Andy Shevchenko wrote:
> > On Fri, Oct 18, 2024 at 05:51:09PM +0300, Andy Shevchenko wrote:
> > > On Fri, Oct 18, 2024 at 09:52:47PM +0800, Baoquan He wrote:
> > > > On 10/18/24 at 03:22pm, Andy Shevchenko wrote:
> > > > > On Fri, Oct 18, 2024 at 10:18:42AM +0800, Baoquan He wrote:

...

> > > > > Can we get more test cases in the respective module, please?
> > > > 
> > > > Do you mean testing CXL memory in kexec/kdump? No, we can't. Kexec/kdump
> > > > test cases basically is system testing, not unit test or module test. It
> > > > needs run system and then jump to 2nd kernel, vm can be used but it
> > > > can't cover many cases existing only on baremetal. Currenly, Redhat's
> > > > CKI is heavily relied on to test them, however I am not sure if system
> > > > with CXL support is available in our LAB.
> > > > 
> > > > Not sure if I got you right.
> > > 
> > > I meant since we touch resource.c, we should really touch resource_kunit.c
> > > *in addition to*.
> > 
> > And to be more clear, there is no best time to add test cases than
> > as early as possible. So, can we add the test cases to the (new) APIs,
> > so we want have an issue like the one this patch fixes?
> 
> I will have a look at kernel/resource_kunit.c to see if I can add
> something for walk_system_ram_res_rev(). Thanks.

Thank you! I will appreciate that.

-- 
With Best Regards,
Andy Shevchenko



