Return-Path: <stable+bounces-3145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D4F7FD55E
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 12:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6D51C20FC3
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 11:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62321C691;
	Wed, 29 Nov 2023 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYOLdhJv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBF8DA;
	Wed, 29 Nov 2023 03:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701256817; x=1732792817;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BDryF4drDiMlV8ObzZKyRpkH+tIJuhjbBuLC14j2we4=;
  b=nYOLdhJvJRkuz9Y5EtZzAJREy4cd7b2DGBRgbxfmWMGHI9TqBWlKN9A3
   F+xCVWLMpT/Lt9Cg8nHtglf9AzO/j0PqFYe0uCKgzeSu4x4k3qc/pDc6q
   qCJj0FJ49qdSk8yaGVP2tQ7ykbD6ekgVtBOT6lky01C91cvX3E5uKcHvz
   08eMdzcCTFewe/CALzXw7Y5nAvLpiqNASMOTxFTKyJJLdWRxeEm4CzNmv
   Rm8BFQyfcnR2e8VK/GgI2orDAsr1i3rxc0WkLN9Lw0dpL98wDTIfjrfJk
   Or3ZTF9+nNFsdbfWaxyS/OrHW0A+fIbKi1S/VCI7PiB7+LtKJS6FB091y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="390308828"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="390308828"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 03:20:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="1016234957"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="1016234957"
Received: from akuporos-mobl.ger.corp.intel.com ([10.251.221.122])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 03:20:10 -0800
Date: Wed, 29 Nov 2023 13:20:08 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Pavel Machek <pavel@denx.de>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
    patches@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>, 
    torvalds@linux-foundation.org, akpm@linux-foundation.org, 
    linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
    lkft-triage@lists.linaro.org, jonathanh@nvidia.com, f.fainelli@gmail.com, 
    sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
    conor@kernel.org, allen.lkml@gmail.com, alexander.deucher@amd.com, 
    mario.limonciello@amd.com, zhujun2@cmss.chinamobile.com, sashal@kernel.org, 
    skhan@linuxfoundation.org, bhelgaas@google.com
Subject: Re: [PATCH 4.14 00/53] 4.14.331-rc2 review
In-Reply-To: <ZWZQCJtD7kmX9iRO@duo.ucw.cz>
Message-ID: <526d5e1-66fd-f4f6-fc24-56f478a85170@linux.intel.com>
References: <20231125163059.878143365@linuxfoundation.org> <ZWUBaYipygLMkfjz@duo.ucw.cz> <f4a7634-3d34-af29-36ca-6f3439b4ce9@linux.intel.com> <ZWZQCJtD7kmX9iRO@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1588401085-1701256816=:1861"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1588401085-1701256816=:1861
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 28 Nov 2023, Pavel Machek wrote:

> Hi!
> 
> > > > This is the start of the stable review cycle for the 4.14.331 release.
> > > > There are 53 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > 
> > > > Ilpo J�rvinen <ilpo.jarvinen@linux.intel.com>
> > > >     RDMA/hfi1: Use FIELD_GET() to extract Link Width
> > > 
> > > This is a good cleanup, but not a bugfix.
> > > 
> > > > Ilpo J�rvinen <ilpo.jarvinen@linux.intel.com>
> > > >     atm: iphase: Do PCI error checks on own line
> > > 
> > > Just a cleanup, not sure why it was picked for stable.
> > 
> > Just an additional bit of information, there have been quite many cleanups 
> > from me which have recently gotten the stable notification for some 
> > mysterious reason. When I had tens of them in my inbox and for various 
> > kernel versions, I immediately stopped caring to stop it from happening.
> > 
> > AFAIK, I've not marked those for stable inclusion so I've no idea what
> > got them included.
> 
> Fixes tag can do it. Plus, "AUTOSEL" robot does it randomly, with no
> human oversight :-(.

I know Fixes tag will surely do it. However, the two above mentioned 
patches were in series that were sent without any Fixes tags nor cc 
stables for any of the patches within the same series.

-- 
 i.

--8323329-1588401085-1701256816=:1861--

