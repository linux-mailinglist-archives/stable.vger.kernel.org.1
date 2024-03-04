Return-Path: <stable+bounces-25915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F48700D7
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 12:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF621C20A8D
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 11:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921503C067;
	Mon,  4 Mar 2024 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZJ1cpMh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C122C3BB4E;
	Mon,  4 Mar 2024 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709553355; cv=none; b=lLFDB8eT05VqUkLZc9Hqu6tei3kcp2oLw7nX/dVfWiNKr+zsRbnJRuKGr40Vdb17+gtbnYp1h48kGNXB08qgAygMV/LtoVh/3GQERCpIN7bYCefss7a5XvyYA1lyljjOZTLYrBTe2SiWbtqBy86ijKttZSWbH/NWV3K3+dfM/fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709553355; c=relaxed/simple;
	bh=STXcOLTjf1xq1SwKva2e5Epz+VhE7cqnT+3mPxu+aNA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=SlUTVox9NfDXxm2E+WFaWFe8TJYugTSVKTLtLlh8RV+c75bAiP3vQIsxxAEk85B9zkjpba28F+NmJJt9psCpWjKPvZpn6l4l1geW8hE3eg2q90C5j/HtyzybV2pHOc5pfA/k1J6qDOLhS22Fs26TpXMo9vZnboHzucm3IERZgdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZJ1cpMh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709553354; x=1741089354;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=STXcOLTjf1xq1SwKva2e5Epz+VhE7cqnT+3mPxu+aNA=;
  b=AZJ1cpMhZWrq6eJRZd5OwuUIHr6PIqOlCbr/NEWRFIhKpnABwxoWdxcE
   CvonFc7DDBciUkx1Fh6D/SLhWuetbKLuz9fhL4jrdRxzP52DaD0ECmmyo
   w3xzFKN5Bdtsazethez2RMhYRb6lm0ix+eF1aHYm7sDEwAceiZnBy0clr
   PFoY9sNjf2uu7kGIM8fAe6tj+TbwdeeJqVldOjTxUA4UGSolLZcllGUr9
   ZcFsaPtm03xln2nvxqWKxl+qxQOQ3mlyToOGpeqzkhPRpZhZSbDao43jW
   CzkdpDBvPC5giOjflavVJvhWwCz88TvfHvOxPfrzUeshOX4EQlTTYKjzO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="3898898"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="3898898"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 03:55:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="937040376"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="937040376"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 03:55:50 -0800
Message-ID: <a6a04009-c3fe-e50d-d792-d075a14ff825@linux.intel.com>
Date: Mon, 4 Mar 2024 13:57:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Chris Yokum <linux-usb@mail.totalphase.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 stable <stable@vger.kernel.org>, linux-usb@vger.kernel.org,
 Niklas Neronin <niklas.neronin@linux.intel.com>
References: <949223224.833962.1709339266739.JavaMail.zimbra@totalphase.com>
 <50f3ca53-40e3-41f2-8f7a-7ad07c681eea@leemhuis.info>
 <2024030246-wife-detoxify-08c0@gregkh>
 <278587422.841245.1709394906640.JavaMail.zimbra@totalphase.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: 6.5.0 broke XHCI URB submissions for count >512
In-Reply-To: <278587422.841245.1709394906640.JavaMail.zimbra@totalphase.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2.3.2024 17.55, Chris Yokum wrote:
> 
> The submission of >512 URBs is via usbfs, yes. This worked forever, and still works on EHCI, it's just been failing on xHCI once the indicated change was applied.
> 

>>> We have found a regression bug, where more than 512 URBs cannot be
>>> reliably submitted to XHCI. URBs beyond that return 0x00 instead of
>>> valid data in the buffer.
> 
>>
>> FWIW, that's f5af638f0609af ("xhci: Fix transfer ring expansion size
>> calculation") [v6.5-rc1] from Mathias.
>>
>>> Attached is a test program that demonstrates the problem. We used a few
>>> different USB-to-Serial adapters with no driver installed as a
>>> convenient way to reproduce. We check the TRB debug information before
>>> and after to verify the actual number of allocated TRBs.
> 

Could you send me that test program as well?

> Ah, so this is just through usbfs?
> 
>>> With some adapters on unaffected kernels, the TRB map gets expanded
>>> correctly. This directly corresponds to correct functional behavior. On
>>> affected kernels, the TRB ring does not expand, and our functional tests
>>> also will fail.
>>>
>>> We don't know exactly why this happens. Some adapters do work correctly,
>>> so there seems to also be some subtle problem that was being masked by
>>> the liberal expansion of the TRB ring in older kernels. We also saw on
>>> one system that the TRB expansion did work correctly with one particular
>>> adapter. However, on all systems at least two adapters did exhibit the
>>> problem and fail.

Ok, I see, this could be the empty ring exception check in xhci-ring.c:

It could falsely assume ring is empty when it in fact is filled up in one
go by queuing several small urbs.

static unsigned int xhci_ring_expansion_needed(struct xhci_hcd *xhci, struct xhci_ring *ring,
                                                unsigned int num_trbs)
{
  ...
         /* Empty ring special case, enqueue stuck on link trb while dequeue advanced */
         if (trb_is_link(ring->enqueue) && ring->enq_seg->next->trbs == ring->dequeue)
                 return 0;
...
}

https://elixir.bootlin.com/linux/v6.7/source/drivers/usb/host/xhci-ring.c#L333

Can you help me test some patches on your setup?

Thanks
Mathias

  

