Return-Path: <stable+bounces-172770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CFEB333D6
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 04:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0776F4E15F5
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 02:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7A322576C;
	Mon, 25 Aug 2025 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYawC2wX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCEE21E098;
	Mon, 25 Aug 2025 02:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756087548; cv=none; b=IiXtoOdwaUeyzDtUNUc5BTN/aDviMvCsdPlQZrnDKpfVT6yuOXV5eGngCQWnZOp19cFcwGVTLNa97u2758u1Dft7EfKDRM0TAEpx5q4e6AAQZ3onGTBmt7q1r946/5WNX3osvmdWcWB/xCiFO1dx//NtbB+SFoIh+bWdH77z46c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756087548; c=relaxed/simple;
	bh=BmSIx/kP71XC0Rgdlsh7gVoY4a44YFS+imT9zeT4LXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bq0UCHUPyFyMtlqgZxM1jHD8pGbLCBK9vfdJGkP1DeN+MwsWdodyT+teijfv5R5FuNET+VovTvTbPE2R2vXltK8ApEs0EsadcUDDM3pV6eQDAK428SPhFN0WOGUdKXElv57xI2VRw/MlG5JJriiugAEVwH3Ftt8FZu5RvAXMR5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYawC2wX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756087547; x=1787623547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BmSIx/kP71XC0Rgdlsh7gVoY4a44YFS+imT9zeT4LXw=;
  b=lYawC2wXlCZmRmtY8sKWBwGkHfo0wjm0NHBM6rXqJwocVdfk7n8UVBsr
   AGguWGD0ER/WHJdWvpBbQX+x7JZyJRFwPKaUnqiZ/fXLGev51Viuqg5h0
   wd2CT+2DNFPzFnEC1D18TaXC8v3ipZ67b3wZ85TXssp3YL45+RjjSqmWL
   +RsGE+31TvKrhQ17peHM4coOAsivBilLsNp4lKfFsgpU2jgE6XrjIKHJE
   uR5pfBzSRhpb5bT/4ykKUeHR8/dzPvXwmEE5EKGh+UWBZ4km8sIQsGc8Z
   EcUeV+jTP9k8ii3o6JdQU95YDR/zJdb9m5kmpHooBQlmeT0z0XzjzQrWZ
   w==;
X-CSE-ConnectionGUID: LYPUuYUgQISpt7JGTaaCrg==
X-CSE-MsgGUID: 6MmJTntTTRyKtbH98gDewQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="83704490"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="83704490"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 19:05:45 -0700
X-CSE-ConnectionGUID: 3jWErnLOTymU9gbLOQ+iNw==
X-CSE-MsgGUID: OxCTAE/zS2mEcR1xgp+KCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="173455245"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 24 Aug 2025 19:05:43 -0700
Date: Mon, 25 Aug 2025 09:55:08 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, jgg@nvidia.com, m.szyprowski@samsung.com,
	yilun.xu@intel.com, stable-commits@vger.kernel.org
Subject: Re: Patch "zynq_fpga: use sgtable-based scatterlist wrappers" has
 been added to the 6.16-stable tree
Message-ID: <aKvCfK8gV0UJy+wD@yilunxu-OptiPlex-7050>
References: <2025082118-visitor-lanky-8451@gregkh>
 <aKfn1+1q0VX3zfyG@yilunxu-OptiPlex-7050>
 <2025082242-blemish-stylus-39e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025082242-blemish-stylus-39e0@gregkh>

On Fri, Aug 22, 2025 at 08:26:55AM +0200, Greg KH wrote:
> On Fri, Aug 22, 2025 at 11:45:27AM +0800, Xu Yilun wrote:
> > On Thu, Aug 21, 2025 at 03:20:18PM +0200, gregkh@linuxfoundation.org wrote:
> > > 
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     zynq_fpga: use sgtable-based scatterlist wrappers
> > > 
> > > to the 6.16-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      zynq_fpga-use-sgtable-based-scatterlist-wrappers.patch
> > > and it can be found in the queue-6.16 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > 
> > Hi Greg:
> > 
> > This patch solves sgtable usage issue but causes AMD fpga driver fail,
> > 
> > https://lore.kernel.org/linux-fpga/202508041548.22955.pisa@fel.cvut.cz/
> > 
> > 
> > The fix patch should be applied together with this patch:
> > 
> > https://lore.kernel.org/linux-fpga/20250806070605.1920909-2-yilun.xu@linux.intel.com/
> > 
> 
> What is the git id of that patch in Linus's tree?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1ca61060de92a4320d73adfe5dc8d335653907ac

But I see the original "CC: stable@vger.kernel.org" tag is removed.

Thanks,
Yilun

> 
> thanks,
> 
> greg k-h

