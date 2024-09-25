Return-Path: <stable+bounces-77728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED74398671C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 21:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FEC4B21B66
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 19:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8289D1459F7;
	Wed, 25 Sep 2024 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlXDPWbC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BEE1D5AD6;
	Wed, 25 Sep 2024 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727293527; cv=none; b=qZYf302HvebSHkRMF7OrJCnVOd+WFpIeGsiM0amq+TP9uMv1W06w+7bQDdVxNJfPlGwrihgztugOXeAS0HqMmbzoC+bbzXxdGITy9fZ4OsNu+GOYwEF+GZikwqE7DvCS0vBY6WcP/S9x//rbrpvgHbaEu4Q6rIDuE393V+U/080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727293527; c=relaxed/simple;
	bh=xYRWbpv879xE3PMgRkyZQKkj1xwpFjw7PCHc84DbX0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oyd2pQOBcTN6r3HCywJdozrBGgmQ+/LOYh+A4lx7Xc/6u4kfyFT76G31pfqGkt35nh4kYUWCZ/X90xbMVpK3qDUkAtzIXKFWvtTMnVq+7EbLHRV12mXnwAxWi5R1YXgf6estRs+4quYltnE5MUKj9byhciMiXzdCIKlVI8tgmGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlXDPWbC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727293526; x=1758829526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xYRWbpv879xE3PMgRkyZQKkj1xwpFjw7PCHc84DbX0c=;
  b=FlXDPWbCgF6r/5z3oAlwA9fDEyfjoz6lzpWVZIIqkX8so3LGvqGQO//9
   l3Fasr1ioggvaD9Wcmtn2Ywj+SW57fox1iXM6nHI+mHcvS5SWWv0XR13/
   Yoqjj5mKwE5ZqvDw6YtHUP1CUXSs0wIxrE06lVYKrPCZ4lCpDMAKQpsvz
   Zhscu717D+gcZjzQxU0/sSkCyAXtTKDBFF+YOdTbsVo2TafQ+AkdW7mCz
   0h0rfijoMZThlC9rpupr9rMhPEoAtG0GO+VndQgeuRHjkygCkxXJmmGIL
   q21qqjEWyATZRMD0NWCWsrw4CpC0c2tah8lLK2REx+O1cqlopSN2dMOfj
   w==;
X-CSE-ConnectionGUID: HwMZwlfATOqCg933tO8vkA==
X-CSE-MsgGUID: BeeEX4EdSCy1CTG89vD8uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26236304"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="26236304"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 12:45:26 -0700
X-CSE-ConnectionGUID: 20uqWXZ4SLO7NwKjoGC72g==
X-CSE-MsgGUID: IL1/F/aBQR+QjEqsv7yVOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="72026506"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 12:45:25 -0700
Date: Wed, 25 Sep 2024 12:51:02 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"regressions@leemhuis.info" <regressions@leemhuis.info>,
	"Neri, Ricardo" <ricardo.neri@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"Gupta, Pawan Kumar" <pawan.kumar.gupta@intel.com>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>,
	"thomas.lindroth@gmail.com" <thomas.lindroth@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [STABLE REGRESSION] Possible missing backport of x86_match_cpu()
 change in v6.1.96
Message-ID: <20240925195102.GA17227@ranerica-svr.sc.intel.com>
References: <eb709d67-2a8d-412f-905d-f3777d897bfa@gmail.com>
 <a79fa3cc-73ef-4546-b110-1f448480e3e6@leemhuis.info>
 <2024081217-putt-conform-4b53@gregkh>
 <05ced22b5b68e338795c8937abb8141d9fa188e6.camel@intel.com>
 <2024091900-unimpeded-catalyst-b09f@gregkh>
 <20240924024551.GA13538@ranerica-svr.sc.intel.com>
 <c20149f35be104c0aa8e995b0f3c7727e095323a.camel@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c20149f35be104c0aa8e995b0f3c7727e095323a.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Sep 25, 2024 at 05:20:41AM +0000, Zhang, Rui wrote:
> > > 
> > > If so, can you submit the needed backports for us to apply?  That's
> > > the
> > > easiest way for us to take them, thanks.
> > 
> > I audited all the uses of x86_match_cpu(match). All callers that
> > construct
> > the `match` argument using the family of X86_MATCH_* macros from
> > arch/x86/
> > include/asm/cpu_device_id.h function correctly because the commit B
> > has
> > been backported to v6.1.99 and to v6.6.50 -- 93022482b294 ("x86/cpu:
> > Fix
> > x86_match_cpu() to match just X86_VENDOR_INTEL").
> > 
> > Only those callers that use their own thing to compose the `match`
> > argument
> > are buggy:
> >     * arch/x86/mm/init.c
> >     * drivers/powercap/intel_rapl_msr.c (only in 6.1.99)
> 
> Thanks for auditing this. I overlooked the intel_rapl driver case.
> > 
> > Summarizing, v6.1.99 needs these two commits from mainline
> >     * d05b5e0baf42 ("powercap: RAPL: fix invalid initialization for
> >       pl4_supported field")
> >     * 2eda374e883a ("x86/mm: Switch to new Intel CPU model defines")
> > 
> > v6.6.50 only needs the second commit.
> 
> Well, commit B 93022482b294 ("x86/cpu: Fix x86_match_cpu() to match
> just X86_VENDOR_INTEL") is backported to all stable kernels. And the
> above two broken cases are also there.
> 
> So I suppose we need to backport all of them to 5.x stable kernel as
> well.

Indeed, this the case. It has been backported to v5.15.y and v5.10.y, but
not to v5.4.y nor 4.19.y.

I found one more case in those two v5.x versions. I will post the
backports.

