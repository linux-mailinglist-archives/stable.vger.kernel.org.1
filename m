Return-Path: <stable+bounces-15-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A347F57F3
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 07:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89613B20EEE
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 06:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A697DBE66;
	Thu, 23 Nov 2023 06:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n6SS2z24"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297571B6;
	Wed, 22 Nov 2023 22:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700719208; x=1732255208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A6LBOW9QKW6MVFMF8UDZAp66PznLow/kH73T029jb9U=;
  b=n6SS2z24QWMQsBxeY/a0fIgcnUg+FFrF6ElDsjwkqdyOcOxNPBTcsnFR
   13rIp+NkQC8M1zPSUYnQJpTGrzEQPQ6Wk7nGNW+rGG9cGutjQb2S/HqFU
   97S/G1PsJZcs9LO3ZcnEgADw9jZT87FlWvOWUmjqDhGFU/HbWIBW2DsC8
   Qw5+Pkis8G0sOnGyLVi7mOA1YoD55BEDOeCc5RvDCzhmBDDTm5qoKubSv
   pDzHcsxKZthScOwVR/5CWF+q8zQZUO4d9kmYb+qKErL0WHTSnm9lvHmP7
   eTA1/piSVC2qtJmvt2+gIfM+lb8Y3YIYj8DKKY6t/T+GtZF4XxjcrccIx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="396111881"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="396111881"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 22:00:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767105467"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="767105467"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 22 Nov 2023 22:00:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 46A012A6; Thu, 23 Nov 2023 08:00:04 +0200 (EET)
Date: Thu, 23 Nov 2023 08:00:04 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Sanath S <Sanath.S@amd.com>, andreas.noever@gmail.com,
	michael.jamet@intel.com, YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [Patch v2] thunderbolt: Add quirk to reset downstream port
Message-ID: <20231123060004.GA1074920@black.fi.intel.com>
References: <20231122050639.19651-1-Sanath.S@amd.com>
 <20231122060316.GT1074920@black.fi.intel.com>
 <95ceae27-f88d-4915-870a-36cf9418f244@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95ceae27-f88d-4915-870a-36cf9418f244@amd.com>

On Wed, Nov 22, 2023 at 09:43:55AM -0600, Mario Limonciello wrote:
> On 11/22/2023 00:03, Mika Westerberg wrote:
> > Hi,
> > 
> > On Wed, Nov 22, 2023 at 10:36:39AM +0530, Sanath S wrote:
> > > Boot firmware on AMD's Yellow Carp and Pink Sardine allocates
> > > very minimal buses for PCIe downstream ports. This results in
> > > failure to extend the daisy chain.
> > > 
> > > Add quirk to reset the downstream port to help reset the topology
> > > created by boot firmware.
> > 
> > But this resets the USB4 side of ports, how does this help with the PCIe
> > side? Or this also resets the PCIe side? Please add this information to
> > the changelog too.
> 
> IIUC the PCIe side will be implicitly reset as well.
> 
> > 
> > I suppose it is not possible to fix the boot firmware?
> 
> It's a really difficult case to make with firmware team.  Windows and Linux
> have a different behavior here.  The Windows CM doesn't take the existing
> tunnels from firmware and instead always resets them.
> So Windows "isn't affected" by this problem.
> 
> Furthermore there are already lots of systems out "in the wild" as these are
> already both production silicon with shipping OEM products.

Yeah that's what I was afraid :( Okay we've been there before so let's
work it around in the kernel then.

