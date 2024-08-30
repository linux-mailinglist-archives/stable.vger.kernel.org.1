Return-Path: <stable+bounces-71654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51E796636A
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 15:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D7C284C83
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 13:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A3D1AF4E4;
	Fri, 30 Aug 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4UgI8s1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11246190059;
	Fri, 30 Aug 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025915; cv=none; b=MRLV3lCJ5mKQ8VYt/rhyrATuHXZxiZyeQlG70MtXLWqTrlhXO9CAo6xrDhRsrdutSxrjr4vRmCSlcvLmRZxxDytzGDIxlt2eVhgkUA3y1D7+J3xn7uM7d7urjAtLs+d0Dck4GX8HgHRE7S3+m1NPIXFmZzdzhDnjfnlDPpzfEMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025915; c=relaxed/simple;
	bh=z5c+A6SazVqr8L3iF7US28CgCvu9PZLF+fDGvMs8bP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PAd/wjwJ3U3/PFRQ7Eu0ELIAJeciWfB7Ul4fuA4tYECJ7QF9bhW+exq8hTHup38MJq080lL7AlVu4o+mEAUn2I7Mb3x9rhtxAf/jtpEI+0v/zlR1FR8nR7m3BqK98nVYPrPvGKrHzwlwsEQ1K/eAbrzF5jBh6LJAogOJpNlaRYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4UgI8s1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725025914; x=1756561914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z5c+A6SazVqr8L3iF7US28CgCvu9PZLF+fDGvMs8bP4=;
  b=n4UgI8s1gVYJO75v0PxHx4tF01krstqYIpBN6HBe1m4M19TMRdVUAVM0
   ijm7v9UHYYqRU72PNJGimWfup9cFAUojrMUW/5G8Wd4MGnKFvgfOJ9cDw
   YlhO1qB0JZsc0BRF4/Qw5wsxGRBqJudjj3nVAMStEHNT3m1qRbKzP7H2r
   qmfR2Lorbw7Uz7ZXIKvA6LYv5VV3DKF8XGnhFm0Gvqpd41/GJJj+7ytNs
   v97/lgw72swhiVdWle2rb6ci0ef2WsXPE+4iMq5JcqlAtkrEHqS4MR6Fo
   ZYTpb2DdRYbpghG1LgjXGnPGgLOGSMIejNfTsSlOP8YUv5BcgvSN7c4Xb
   g==;
X-CSE-ConnectionGUID: OhzKoBdfRPSbahXp+K6F6w==
X-CSE-MsgGUID: kJcPnryjQIu3DVIoBvw6bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23804898"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="23804898"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 06:51:54 -0700
X-CSE-ConnectionGUID: EUBIpPy8TYSzts9WRRxs+w==
X-CSE-MsgGUID: 4MP1KPWFTjiy58Y3JUwwpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="68048416"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa003.fm.intel.com with ESMTP; 30 Aug 2024 06:51:51 -0700
Message-ID: <45e02c34-c45d-4ec7-8bd3-6c7808518229@linux.intel.com>
Date: Fri, 30 Aug 2024 16:53:56 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: xhci: fixes lost of data for xHCI Cadence
 Controllers
To: Pawel Laszczak <pawell@cadence.com>,
 "mathias.nyman@intel.com" <mathias.nyman@intel.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "peter.chen@kernel.org" <peter.chen@kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240821055828.78589-1-pawell@cadence.com>
 <PH7PR07MB95388A2D2A3EB3C26E83710FDD8E2@PH7PR07MB9538.namprd07.prod.outlook.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <PH7PR07MB95388A2D2A3EB3C26E83710FDD8E2@PH7PR07MB9538.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.8.2024 9.01, Pawel Laszczak wrote:
> Stream endpoint can skip part of TD during next transfer initialization
> after beginning stopped during active stream data transfer.
> The Set TR Dequeue Pointer command does not clear all internal
> transfer-related variables that position stream endpoint on transfer ring.
> 
> USB Controller stores all endpoint state information within RsvdO fields
> inside endpoint context structure. For stream endpoints, all relevant
> information regarding particular StreamID is stored within corresponding
> Stream Endpoint context.
> Whenever driver wants to stop stream endpoint traffic, it invokes
> Stop Endpoint command which forces the controller to dump all endpoint
> state-related variables into RsvdO spaces into endpoint context and stream
> endpoint context. Whenever driver wants to reinitialize endpoint starting
> point on Transfer Ring, it uses the Set TR Dequeue Pointer command
> to update dequeue pointer for particular stream in Stream Endpoint
> Context. When stream endpoint is forced to stop active transfer in the
> middle of TD, it dumps an information about TRB bytes left in RsvdO fields
> in Stream Endpoint Context which will be used in next transfer
> initialization to designate starting point for XDMA. This field is not
> cleared during Set TR Dequeue Pointer command which causes XDMA to skip
> over transfer ring and leads to data loss on stream pipe.
> 
> Patch fixes this by clearing out all RsvdO fields before initializing new
> transfer via that StreamID.
> 
> Field Rsvd0 is reserved field, so patch should not have impact for other
> xHCI controllers.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: <stable@vger.kernel.org>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Thanks,

Code looks good but maybe we should skip adding this to stable until we are really
sure modifying the RsvdO fields for _all_ host controllers doesn't cause any issues.

I simplified and changed the commit message, is the following ok with you:

usb: xhci: fix loss of data on Cadence xHC

Streams should flush their TRB cache, re-read TRBs, and start executing
TRBs from the beginning of the new dequeue pointer after a 'Set TR
Dequeue Pointer' command.

Cadence controllers may fail to start from the beginning of the dequeue
TRB as it doesn't clear the Opaque 'RsvdO' field of the stream context
during 'Set TR Dequeue' command.
This stream context area is where xHC stores information about the last
partially executed TD when a stream is stopped.
xHC uses this information to resume the transfer where it left mid TD,
when the stream is restarted.

Patch fixes this by clearing out all RsvdO fields before initializing new
Stream transfer using a 'Set TR Dequeue Pointer' command.

Field RsvdO is reserved field, so patch should not have impact on other
xHCI controllers, but don't add this patch to stable kernels yet
before it has worked flawlessly upstream on different hosts for a while.

[simplify and edit commit message -Mathias]

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>


