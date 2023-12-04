Return-Path: <stable+bounces-3840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE56802DF0
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 10:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ED05B209CC
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 09:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7750212E6A;
	Mon,  4 Dec 2023 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4bOH0QP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2CECD;
	Mon,  4 Dec 2023 01:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701681062; x=1733217062;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=HF7PazhEJaUGDhVtrd2okSZVq55CFcLcBkpdxxWUXIo=;
  b=f4bOH0QPV64OldHGwH+Tc5dtE/PnCv4iyK2fLqiEBn46QP+XIbzda5v0
   fib1wy8qAD3/FFbktT3ZYPEJhLwhmGE2F9FA6Xv4mIPkh35nnMBBgFPlP
   Ry0270p/QV5GOJMGWxtOSA4EGHFwbklUio7lSQymGXptHU4n/8v0iVlvw
   nls1F7KFDecs2aDDxa//mi0i5fZmNPloexv+c075c+7xFcpoAt21bxcFc
   bFkkV+X55aOGD6756I/jT/omVw9Jj5F5EDFFfVXPakSg0F8ozB8LRog5+
   VReemyB/g2OMs1l8xdByo5g0gq996M01mcU6ev8u5xEjjY818ASjxzZme
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="7027004"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="7027004"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 01:11:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="861314906"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="861314906"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2023 01:10:57 -0800
Message-ID: <3d3b8fd3-a1b9-9793-b709-eda447ebd1ab@linux.intel.com>
Date: Mon, 4 Dec 2023 11:12:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>,
 "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, stable@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev,
 linux-bluetooth@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org
References: <ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-rail.com>
 <8d6070c8-3f82-4a12-8c60-7f1862fef9d9@leemhuis.info>
 <2023120119-bonus-judgingly-bf57@gregkh>
 <6a710423-e76c-437e-ba59-b9cefbda3194@moonlit-rail.com>
 <55c50bf5-bffb-454e-906e-4408c591cb63@molgen.mpg.de>
 <2023120213-octagon-clarity-5be3@gregkh>
 <f1e0a872-cd9a-4ef4-9ac9-cd13cf2d6ea4@moonlit-rail.com>
 <2023120259-subject-lubricant-579f@gregkh>
 <ef575387-4a52-49bd-9c26-3a03ac816b61@moonlit-rail.com>
 <2023120329-length-strum-9ee1@gregkh>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: Regression: Inoperative bluetooth, Intel chipset, mainline kernel
 6.6.2+
In-Reply-To: <2023120329-length-strum-9ee1@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3.12.2023 10.38, Greg KH wrote:
> On Sun, Dec 03, 2023 at 03:32:52AM -0500, Kris Karas (Bug Reporting) wrote:
>> Greg KH wrote:
>>> Thanks for testing, any chance you can try 6.6.4-rc1?  Or wait a few
>>> hours for me to release 6.6.4 if you don't want to mess with a -rc
>>> release.
>>
>> As I mentioned to Greg off-list (to save wasting other peoples' bandwidth),
>> I couldn't find 6.6.4-rc1.  Looking in wrong git tree?  But 6.6.4 is now
>> out, which I have tested and am running at the moment, albeit with the
>> problem commit from 6.6.2 backed out.
>>
>> There is no change with respect to this bug.  The problematic patch
>> introduced in 6.6.2 was neither reverted nor amended.  The "opcode 0x0c03
>> failed" lines to the kernel log continue to be present.
>>
>>> Also, is this showing up in 6.7-rc3?  If so, that would be a big help in
>>> tracking this down.
>>
>> The bug shows up in 6.7-rc3 as well, exactly as it does here in 6.6.2+ and
>> in 6.1.63+.  The problematic patch bisected earlier appears identically (and
>> seems to have been introduced simultaneously) in these recent releases.
> 
> Ok, in a way, this is good as that means I haven't missed a fix, but bad
> in that this does affect everyone more.
> 
> So let's start over, you found the offending commit, and nothing has
> fixed it, so what do we do?  xhci/amd developers, any ideas?
> thanks,
> 
> greg k-h
> 

I suggest reverting these two patches from everywhere (all stable):
a5d6264b638e xhci: Enable RPM on controllers that support low-power states
4baf12181509 xhci: Loosen RPM as default policy to cover for AMD xHC 1.1

Then write a new well tested patch that adds default runtime pm to those AMD
hosts that support it. And only add that to usb-next

-Mathias





