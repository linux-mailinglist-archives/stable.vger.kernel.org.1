Return-Path: <stable+bounces-114244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A91A2C22D
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 13:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6834A188C9FB
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 12:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB001DF247;
	Fri,  7 Feb 2025 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+M4EFpD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2873F2417C7;
	Fri,  7 Feb 2025 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929962; cv=none; b=XiEjFHRAKbzKcmPMMnEdKbjpX5M387mLIDS1rySdNHRRQZ6DhJQpjBqIcx/eq+pMCi5U/E1fMHEnDp0gMm0nNAiHgAi8pOMvjyYQxBaBlJ5vMnxUMcP/2GYBNiC6A7NsYBwjl3ucTH6TdLysyH1xwBdRBU//dtmgtrZ+5HsAIUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929962; c=relaxed/simple;
	bh=ma5Hb3GHBC/magnwae6faiDO9xx0GkENHYDG1un8qXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMLTmaWwDdj9aZS9CaTJZbQLi88sPLFkIrnmbXmIDpUEKNG4ETAxY40rDeKFc2q3xoZeueonhpQh85yK5yowrrjP2AQsYymQMYYPNRiSTPzrG1lT8cvpvC+vavEhYH0smbFosG9A+SEwmHyP+iv686EYd16NuFBVX2rKd5HG7Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+M4EFpD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738929961; x=1770465961;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ma5Hb3GHBC/magnwae6faiDO9xx0GkENHYDG1un8qXY=;
  b=G+M4EFpDGk2x40HsBdsJSTl/9DcZZyxBeW+xQAbyxERj17lbH50espKP
   9ovVeb6u1MYEtEQ46O+iqR+A9PSn/hg+KNERakmJLD5Bog6RA+XTLttR7
   YmiryI5LF01ffG26jhGLlqCrF9M0/FuzgHF9wiMF2YfZ3jDz4REMoGr5m
   A6NrW6h2GPrSBQN5/aeC6g/zSG+z3n91/OUsS20UxfaNz0NrL8RKAxc6G
   q6+P3MSJMjOq/3F8Dym9JMFA3/8xFm0Y06P1tN75lt6knTVcpfxdZHlKH
   pAbv+QUnLn9DSjDovDtMrXL47D8eut2tUJ5PupnXmt3S22skNqfQpO0nm
   g==;
X-CSE-ConnectionGUID: aGZ3uO/SS1K2tP7DYQiY9g==
X-CSE-MsgGUID: 8RcjSbIfT3G5Ts/LGqLupg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50207443"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="50207443"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 04:05:59 -0800
X-CSE-ConnectionGUID: kHF5+SKUR8KAc4eXN8bJ/Q==
X-CSE-MsgGUID: +CYmbFsHQUCok7kJ1kQq9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="142389033"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa002.jf.intel.com with ESMTP; 07 Feb 2025 04:05:58 -0800
Message-ID: <b19218ab-5248-47ba-8111-157818415247@linux.intel.com>
Date: Fri, 7 Feb 2025 14:06:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] xhci: Correctly handle last TRB of isoc TD on
 Etron xHCI host
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: gregkh@linuxfoundation.org, ki.chiang65@gmail.com,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 mathias.nyman@intel.com, stable@vger.kernel.org
References: <20250205234205.73ca4ff8@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250205234205.73ca4ff8@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6.2.2025 0.42, Michał Pecio wrote:
>> Not giving back the TD when we get an event for the last TRB in the
>> TD sounds risky. With this change we assume all old and future ETRON
>> hosts will trigger this additional spurious success event.
> 
> error_mid_td can cope with hosts which don't produce the extra success
> event, it was done this way to deal with buggy NECs. The cost is one
> more ESIT of latency on TDs with error.

It makes giving back the TD depend on a future event we can't guarantee.

I still think it better fits the spurious success case.
It's not an error mid TD, it's a spurious success event sent by host
after a completion (error) event for the last TRB in the TD.

Making this change to error_mid_td code also makes that code more
confusing and harder to follow.

>> I think we could handle this more like the XHCI_SPURIOUS_SUCCESS case
>> seen with short transfers, and just silence the error message.
> 
> That's a little dodgy because it frees the TD before the HC is
> completely done with it. *Probably* no problem with data buffers
> (no sensible reason to DMA into them after an earlier error), but
> we could overwrite the transfer ring in rare cases and IDK if it
> would or wouldn't cause problems in this particular case.

We did get an event for the last TRB in the TD, so in normal cases
this TD should be considered complete, and given back.

I don't think the controller has any reason to touch data buffers at
this stage either. Can't recall any iommu/dma issues related to this.

> 
> Same applies to the "short packet" case existing today. I thought
> about fixing it, but IIRC I ran into some differences between HCs
> or out of spec behavior and it got tricky.

For the short transfer case this is more valid concern. Here we give
back the TD after an event mid TD, and we know hardware might still
walk the rest of the TD. It shouldn't touch data buffers either as
short transfer indicates all data has been written.

> 
> Maybe it would make sense to separate giveback (and freeing of the
> data buffer by class drivers) from transfer ring inc_deq(). Do the
> former when we reasonably believe the HC won't touch the buffers
> anymore, do the latter when we are sure that it's in the next TD.

This sounds reasonable, makes sense to keep the software dequeue
pointer where hardware last reported its position. Currently we
advance it to where we assume hardware will be next.

But this is a separate project.
Might need some work around in the driver.

Thanks
Mathias


