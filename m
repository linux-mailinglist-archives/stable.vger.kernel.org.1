Return-Path: <stable+bounces-88977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 546979B2A0E
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 09:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C3A282686
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 08:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF25A190497;
	Mon, 28 Oct 2024 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z9rjCMLU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771B36F2FE;
	Mon, 28 Oct 2024 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730103499; cv=none; b=fFTDGTDpFDgBhjk7brKO+8chMZnEiPHz/GBib1+S7q9ynGnYd4klLVB/Pt9kQn+i3wiDzlQYb4I+ihseosqfEpu7UtD6KJqrt6O8br4l6868ZpEv7bwiNGAAQqdKKWdwQuXexRw1Uyc5k7Pb8pq+pA78iACp+gIIWSC1TriFSxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730103499; c=relaxed/simple;
	bh=R1mMvZvpqkvIqo9TFaQ8duYANFkF6LqvMFLJb4X0uzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWFeutGr0Bo4yl7Q118GgEtYXCYgw8XGQBXVZr/6KMFL7eMkR2+43NgrM6c1+XYlUVf7KxYdcFghrS2blYD9jClge0NzujlLe9WVtRF+X2Gn4ivs6PP1EAvYrmrRMNB9uepuSC1qfuhmgRc3w+HhekXpTttxMn16IwWiPRPUWEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z9rjCMLU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730103497; x=1761639497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R1mMvZvpqkvIqo9TFaQ8duYANFkF6LqvMFLJb4X0uzQ=;
  b=Z9rjCMLU0NFcb366/mtMTMY/r8aooqAqO+8920cHTlDyvJe2D+Rc/WJR
   qKkk/pHKu5f3rUDzKjG4ZhBabzha2g9c0wXzQaD95VAktARYN32iTJNdW
   2JD9jFKalyUJ4jrrBTpMPU7qM1genYhO99NYEy0GxuLKj1PZAEzj/odVo
   z+V83d52e+hDOJ0VVHsoSP/5Y4Ptom0DhELs3moymRe2r2BcEQk8YKNc7
   XsUF/yYwtv/Bzo23jDTDIfbzgl0Fdo0NUClML86+8/XG0vQ0t8FYsIgQ4
   Ye8CXe3pjdHTXWEV08I/wFCRYXxkPbzdyd3SEgmZsWkJt3N8S2GUJ4GJv
   w==;
X-CSE-ConnectionGUID: iR7G233aSgyd7+eveZkrQg==
X-CSE-MsgGUID: 0AqyRbWtTuiP7O0fiMmrOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29795108"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="29795108"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 01:18:17 -0700
X-CSE-ConnectionGUID: xT+zj1ClTyORr5MwusohNA==
X-CSE-MsgGUID: i+Od4F4tSMGsZVVv0AvbBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="112383129"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 28 Oct 2024 01:18:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 63D4813E; Mon, 28 Oct 2024 10:18:13 +0200 (EET)
Date: Mon, 28 Oct 2024 10:18:13 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Rick <rick@581238.xyz>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Sanath.S@amd.com,
	christian@heusel.eu, fabian@fstab.de, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: Dell WD19TB Thunderbolt Dock not working with kernel > 6.6.28-1
Message-ID: <20241028081813.GN275077@black.fi.intel.com>
References: <000f01db247b$d10e1520$732a3f60$@581238.xyz>
 <96560f8e-ab9f-4036-9b4d-6ff327de5382@amd.com>
 <22415e85-9397-42db-9030-43fc5f1c7b35@581238.xyz>
 <20241022161055.GE275077@black.fi.intel.com>
 <7f14476b-8084-4c43-81ec-e31ae3f7a3c6@581238.xyz>
 <20241023061001.GF275077@black.fi.intel.com>
 <4848c9fe-877f-4d73-84d6-e2249bb49840@581238.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4848c9fe-877f-4d73-84d6-e2249bb49840@581238.xyz>

Hi,

On Fri, Oct 25, 2024 at 12:20:55PM +0200, Rick wrote:
> Hi Mika
> 
> On 23-10-2024 08:10, Mika Westerberg wrote:
> > Hi,
> > 
> > On Tue, Oct 22, 2024 at 07:06:50PM +0200, Rick wrote:
> > > Hi Mika,
> > > 
> > > I have removed pcie_asm=force as kernel parameter but still not working on
> > > latest non LTS kernel.
> > 
> > Okay, I still suggest not having that unless you absolutely know that
> > you need it.
> > 
> 
> Noted thank you!
> 
> > > In regards to the disconnect; sorry I think I might have turned of the
> > > docking station myself during that test. I have taken another dmesg without
> > > me disconnecting the docking station:
> > > https://gist.github.com/ricklahaye/9798b7de573d0f29b3ada6a5d99b69f1
> > > 
> > > The cable is the original Thunderbolt 4 cable that came with the docking
> > > station. I have used it on this laptop using Windows (dualboot) without any
> > > issues. Also on another Windows laptop also without issues. It was used in
> > > 40Gbit mode.
> > 
> > In the dmesg you shared above, there are still unplug and USB tunnel
> > creation fails so you only get USB 2.x connection with all the USB
> > devices on the dock.
> > 
> 
> Yes you are right. I removed all attached USB devices from the dock, but
> still see "3:3: USB3 tunnel activation failed, aborting"
> 
> > How do you determine if it "works"? I guess keyboard and mouse (both
> > USB 2.x devices) and display (tunneled over USB4 link) all are working
> > right? However, if you plug in USB 3.x device to the dock it enumerates
> > as FullSpeed instead of SuperSpeed. There is definitely something wrong
> > here. I asked from our TB validation folks if they have any experience
> > with this dock but did not receive any reply yet.
> > 
> > What you mean by 40Gbit mode? The dock exposes two lanes both at 20G so
> > it should always be 40G since we bind the lanes, also in Windows.
> 
> 2 lanes of 20G indeed.
> 
> > 
> > Also In Windows, do you see if the all USB devices on the dock are
> > enumerated as FullSpeed or SuperSpeed? I suspect it's the former there
> > too but can you check? Keyboard and mouse should be FullSpeed but there
> > is some audio device that may be USB 3.x (SuperSpeed), or alternatively
> > if you have USB 3.x memory stick (or any other device) you can plug that
> > to the dock and see how it enumerates.
> 
> I checked on Windows with some 3.1 USB devices, and they were properly seen
> as 3.1 Superspeed+/10Gbps when attached to dock (using USBView from Windows
> SDK).
> 
> I also tried some Linux kernels, and it seems that 6.9 works, and 6.10
> doesn't.
> 
> 6.9: https://gist.github.com/ricklahaye/da8c63edb0c27dc55bef351f9f4dd035

I still see similar issue even with the v6.9 kernel. The link goes up an
down unexpectly.

I wonder if you could try to take traces of the control channel traffic?
I suggest to use v6.11 kernel because it should have all the tracing
bits added then install tbtools [1] and follow the steps here:

  https://github.com/intel/tbtools?tab=readme-ov-file#tracing

Then provide both full dmesg and the trace output. That hopefully shows
if some of the access we are doing in the Linux side is causing the link
to to drop. Let me know if you need more detailed instructions.

Also please drop the "thunderbolt.host_reset=0" from the command line as
that did not help, so it is not needed.

[1] https://github.com/intel/tbtools

