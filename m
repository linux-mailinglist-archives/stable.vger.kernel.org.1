Return-Path: <stable+bounces-75847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FDA97565E
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 17:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115EC1C22CFF
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 15:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2E719C552;
	Wed, 11 Sep 2024 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PjeOxHP7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4701038DE1;
	Wed, 11 Sep 2024 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067155; cv=none; b=E97JWvCIMNnH416VW0zwXwvdjqEXhTtUDsnOXlhl2hGCmGFqEZZK/rJfdbtZNwRUAUzKpPEktYZKZ2hEMOH1fgsrvh9k8M24GiWfp+ADHXjEwNJxHYyzsDeKAQ31a4bh+7JhVbVPUYsMedcvH+ANdkra8ApqHJWj0lU/SGprgvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067155; c=relaxed/simple;
	bh=I7TOYOV0X+sl4yRBZMSMqcGVltMkSNKivipdeWSVjxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnxtCg8nRIM9lYOJCS/xIozakF0MgI9706gz702uLpmyyoKr1SaMCJcvGff01c5UUwxvBxvVGFkZC7sM9ir6tyhdcm3AQpIv6Q72rfsjaoTon+vOxQP6mBxDhQcumzE2Iil7poSz3VqxJOv1HyCCHyaEce3oSdZPGrsKV98Cn4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PjeOxHP7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726067154; x=1757603154;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I7TOYOV0X+sl4yRBZMSMqcGVltMkSNKivipdeWSVjxg=;
  b=PjeOxHP7YOIoLks4y7dZh/fwFOzFnYV5iBm1a7Vbb7eZCGYf1T92gtsY
   agnULkVilsfmzvJGRUdCaKDj0DbXZc+85ekwh0sL1zMNHer162p6AREpu
   Ws2sqc2iOneLwTEMjgAaH23f0UNolxu2oJdEIR3I/HJBCDtAOqf2z21MD
   O8p/C0pA0j8uSQTHYXcujK/f8NuhBSBJUrrlnMisfBw1jd0J4NlLkA18v
   s7YJn0UOHL8FiDHTTavLsgTPVFy894FXJ7PaHTHKn+WasXJj1qrboju6A
   t3dTsSt0ypMOoEcmAZx+KH3Oqgi/Qpp/w27I57SRhB6l51TDGE105ZHqm
   Q==;
X-CSE-ConnectionGUID: w53S7PQ+TnWFaAPVAU/UBg==
X-CSE-MsgGUID: vpiry80bThGvvPxmng6BWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="28609056"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="28609056"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 08:05:53 -0700
X-CSE-ConnectionGUID: WPJQ2vlkRHiXpufoIrMFbA==
X-CSE-MsgGUID: YCDcUTeQT/uNie3BOY/0Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="67687500"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa006.jf.intel.com with ESMTP; 11 Sep 2024 08:05:52 -0700
Message-ID: <d222e5b9-7241-46a1-84fe-be2343fa4346@linux.intel.com>
Date: Wed, 11 Sep 2024 18:07:58 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] xhci: Fix control transfer error on Etron xHCI host
To: Kuangyi Chiang <ki.chiang65@gmail.com>, gregkh@linuxfoundation.org,
 mathias.nyman@intel.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240911051716.6572-1-ki.chiang65@gmail.com>
 <20240911051716.6572-2-ki.chiang65@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20240911051716.6572-2-ki.chiang65@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.9.2024 8.17, Kuangyi Chiang wrote:
> Performing a stability stress test on a USB3.0 2.5G ethernet adapter
> results in errors like this:
> 
> [   91.441469] r8152 2-3:1.0 eth3: get_registers -71
> [   91.458659] r8152 2-3:1.0 eth3: get_registers -71
> [   91.475911] r8152 2-3:1.0 eth3: get_registers -71
> [   91.493203] r8152 2-3:1.0 eth3: get_registers -71
> [   91.510421] r8152 2-3:1.0 eth3: get_registers -71
> 
> The r8152 driver will periodically issue lots of control-IN requests
> to access the status of ethernet adapter hardware registers during
> the test.
> 
> This happens when the xHCI driver enqueue a control TD (which cross
> over the Link TRB between two ring segments, as shown) in the endpoint
> zero's transfer ring. Seems the Etron xHCI host can not perform this
> TD correctly, causing the USB transfer error occurred, maybe the upper
> driver retry that control-IN request can solve problem, but not all
> drivers do this.
> 
> |     |
> -------
> | TRB | Setup Stage
> -------
> | TRB | Link
> -------
> -------
> | TRB | Data Stage
> -------
> | TRB | Status Stage
> -------
> |     |
> 

What if the link TRB is between Data and Status stage, does that
case work normally?

> To work around this, the xHCI driver should enqueue a No Op TRB if
> next available TRB is the Link TRB in the ring segment, this can
> prevent the Setup and Data Stage TRB to be breaked by the Link TRB.

There are some hosts that need the 'Chain' bit set in the Link TRB,
does that work in this case?

Thanks
Mathias


