Return-Path: <stable+bounces-192183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C2DC2B368
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 12:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C8E1891042
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 11:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18D830148B;
	Mon,  3 Nov 2025 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/KfQHIV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD14E30103F;
	Mon,  3 Nov 2025 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167734; cv=none; b=MrceagdIL0grQoIBl/VdF1cGR7EPn0eJBMlctCXYyN94NadyJGQohw9m2fqJycZZmCqLSmOB07ljKsEM9TQwEmPMOYdL2yVsbVjlhy2zdlxTHQALOONqhQ7YNPaxm4EN8MUoPVCqEb1ngScxHeO/Thbncdr9a9gCdjbqoQNRtn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167734; c=relaxed/simple;
	bh=+QUKYiq6QyurEYEfuCj/JyfcmWfTRvEucNWiwhh61Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLcXePkSAagfFy73d6fPEyQbFrggZvNumC04/3FtSkpiwjbfvQIdv1c1ETEUfSCy1waxFm1cnmQLH+lMc//xPQS7d5DoY26N8HImW58DPW1Lt5L8KnRQL6rUYs3wVDct93qOFoXxo9VUZ1KpQcctPPfnpzHGrosvQHBCIfx4ZLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/KfQHIV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762167732; x=1793703732;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+QUKYiq6QyurEYEfuCj/JyfcmWfTRvEucNWiwhh61Y8=;
  b=m/KfQHIVpGzqHRVlc5f8DjaIQMRPKPuFDpXSrRS/fGVBowEuazeRJSiS
   UMY40RJfHVllUw/g0IIXPTywKexoajnn4vA1Fch9GEdD3unaD1GiIzaQt
   EClJHih879lUfNGPcEFR/pMq94ocgmwQzoZBelqQepekVnqeYuL/jRxxZ
   9Dmb7BT3HNSsRWhVVg4bs1yYMmwIZvAeEos/moIB54Xp0LEw19TJhVJ+g
   x5CoUXi/jkCnFe6L7gCrAp20zljoG4q6U9fyL4QkWklGcQ1+vGlnLt2rM
   FTKAbAopZ9B/lzsBIJtRuVaxVMA6HJzEROUPxmKDdHMKA+aflkr5h5j4K
   g==;
X-CSE-ConnectionGUID: 3erTDP4VSD2vm65sL0zNxg==
X-CSE-MsgGUID: E/kHXqH4Sm+Ylw9QPiTNZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="74842739"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="74842739"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 03:02:11 -0800
X-CSE-ConnectionGUID: jzZIC2rTShau3xRc3doKGw==
X-CSE-MsgGUID: mIxJirusTs+LpRTi66etVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="191947690"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO [10.245.245.12]) ([10.245.245.12])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 03:02:09 -0800
Message-ID: <11d7b29d-a45f-48e9-bff5-cb94150d0bdf@intel.com>
Date: Mon, 3 Nov 2025 13:02:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: Check kcalloc_node() when allocating
 interrupter array in xhci_mem_init()
To: Michal Pecio <michal.pecio@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
 Wesley Cheng <quic_wcheng@quicinc.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250918130838.3551270-1-lgs201920130244@gmail.com>
 <20251103094036.2d1593bc.michal.pecio@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@intel.com>
In-Reply-To: <20251103094036.2d1593bc.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 10:40, Michal Pecio wrote:
> On Thu, 18 Sep 2025 21:08:38 +0800, Guangshuo Li wrote:
>> kcalloc_node() may fail. When the interrupter array allocation returns
>> NULL, subsequent code uses xhci->interrupters (e.g. in xhci_add_interrupter()
>> and in cleanup paths), leading to a potential NULL pointer dereference.
>>
>> Check the allocation and bail out to the existing fail path to avoid
>> the NULL dereference.
>>
>> Fixes: c99b38c412343 ("xhci: add support to allocate several interrupters")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>> ---
>>   drivers/usb/host/xhci-mem.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
>> index d698095fc88d..da257856e864 100644
>> --- a/drivers/usb/host/xhci-mem.c
>> +++ b/drivers/usb/host/xhci-mem.c
>> @@ -2505,7 +2505,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
>>   		       "Allocating primary event ring");
>>   	xhci->interrupters = kcalloc_node(xhci->max_interrupters, sizeof(*xhci->interrupters),
>>   					  flags, dev_to_node(dev));
>> -
>> +	if (!xhci->interrupters)
>> +		goto fail;
>>   	ir = xhci_alloc_interrupter(xhci, 0, flags);
>>   	if (!ir)
>>   		goto fail;
>> -- 
>> 2.43.0
> 
> Hi Greg and Mathias,
> 
> I noticed that this bug still exists in current 6.6 and 6.12 releases,
> what would be the sensible course of action to fix it?
> 

Not sure this qualifies for stable.
Is this something that has really happened in real life?

The stable-kernel-rules.rst states it should "fix a real bug that bothers people"

If kcalloc_node() fails to allocate that array of pointers then something
else is already badly messed up.

That being said, I don't object this being added to stable either

Thanks
Mathias



