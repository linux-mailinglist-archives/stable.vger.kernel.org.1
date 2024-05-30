Return-Path: <stable+bounces-47722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E10FB8D4E9D
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 17:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5890DB22086
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 15:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097EF17C21A;
	Thu, 30 May 2024 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cp5GZZiy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E393186E54;
	Thu, 30 May 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081495; cv=none; b=HI+c69uqo8zdYQdk0pAzkKJDa1sitmXjWX0EEvFkRIZGfDiU8P0llrplXwrIcedCp2/6qedJkfmcC3jl6QUgtEuY0Z8Fb8FzgI12Ft4ifKSWbfUPd+TAjw+XVW2Hl/ZH20cwEVuMSjbNtg+shr/2gDg8LinIKQYhHm1oR8PKM1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081495; c=relaxed/simple;
	bh=IljhmVxTDzvtrv3mOEhigmPGh0BrJLJN1QUnxx32mcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dW3Z64oS+/hlGbzt1+FVNXruBL4uNYZCw92LyMa4CqrfVRTpVjoQhnoYbv0iGap1VNxnPSEb2OwMlHGo7POkefp6R2b4cVsFSwg0FKIeoGDdLVlAxEKjKfFificbFI2SCSAA0kC+mj6v34Ue5H7uHYxCnMGes7h1bZVt2LsHpjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cp5GZZiy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717081494; x=1748617494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IljhmVxTDzvtrv3mOEhigmPGh0BrJLJN1QUnxx32mcw=;
  b=cp5GZZiyEuVJwVNS6xUW36IhSMNbfmJdfWemzV2u0lGnM0rojmEmg8KH
   S66QQWXsn4f+QKz53/9UL5EA+jIpH5EaASHDOjQl5C3Pq/zcj3FsVWyl0
   wnviExjihknGBnbCY4+QQktASdtv3/p/xUT6IGEfaWotIpjAao/AfQE0M
   xBBffs/lb7W7LcdSOhUvEMUzrD0fpUTYWDPcO0DT+zy/ndJnkXrhfq11a
   qrfca4rWCWe8oPF7R5qura/4mSE7Pq6BdSNTFHI31hE/hmKrfw5yyrQF7
   kaTWzCQq82cuErtXruS3RNx25k+0XD2UyQPSCDswQF9zAMIj4JYHgFdEU
   g==;
X-CSE-ConnectionGUID: Y83xnBPnT/eRR5XwOrUCKQ==
X-CSE-MsgGUID: ySz499phRHWqsWcqjf1XDg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="36098441"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="36098441"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:04:54 -0700
X-CSE-ConnectionGUID: z3MUCgqCRVS22tK33CNHmQ==
X-CSE-MsgGUID: CoIBRMhNRZqWDNh0ETfYpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="40738331"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:04:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sChKj-0000000C6yT-0WvX;
	Thu, 30 May 2024 18:04:49 +0300
Date: Thu, 30 May 2024 18:04:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, x86@kernel.org, bp@alien8.de,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: Provide default cache line size if not
 enumerated
Message-ID: <ZliVkBXxTq8H3Eey@smile.fi.intel.com>
References: <20240517200534.8EC5F33E@davehans-spike.ostc.intel.com>
 <ZkspXhQFcWvBkL2q@smile.fi.intel.com>
 <ZliJiM8g5p-uJSPd@smile.fi.intel.com>
 <f4509e64-f062-4aea-b00f-a44a298adc5b@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4509e64-f062-4aea-b00f-a44a298adc5b@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 30, 2024 at 07:16:03AM -0700, Dave Hansen wrote:
> On 5/30/24 07:13, Andy Shevchenko wrote:
> > What's the status of this? (It seems you have to rebase it on top of the
> > existing patches in the same area).
> 
> Queued as of about 10 seconds ago:

Thank you!

> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/urgent&id=b9210e56d71d9deb1ad692e405f6b2394f7baa4d

-- 
With Best Regards,
Andy Shevchenko



