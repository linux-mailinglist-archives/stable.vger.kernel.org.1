Return-Path: <stable+bounces-146325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AB2AC3AC8
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 09:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E3F188BA8D
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 07:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FDB1DE2BA;
	Mon, 26 May 2025 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NqtRUhMw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B5CEAE7;
	Mon, 26 May 2025 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748245193; cv=none; b=fdP8TbHhM1p94YTWJw0c7JY0JHUE8tor4Kb21x8UJw2Uh9NxW7Swtsubw0b43POd8PVstHd3uGX76iP6nsHQAVaqIKyFU9A/E7FjwGBraD8jIH59MZsbUQNRkTPQSfHPAVZMcs/+u7YQvlABH2xdbq/zxBhFVttNMfR4yVjI1SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748245193; c=relaxed/simple;
	bh=IBYAM02gDnPNQWz4PJvgXSa+zSTTw55qR4Wjew9vvcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N20vTkm+tf86nwPM7TQ/Z1956XebWEPXOb0aLE2RlPLUPcR1eC5cFnwr3yLr9t7G4UY4gugfohQBQgPK3r1/j6ABf31QhCYzN6JezNjmHDxln/vInnC6dvIl8yIDvPgSvt8q3D8k2KWBwt/hs65KFrJb04Od79yue53acwejrlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NqtRUhMw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748245191; x=1779781191;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IBYAM02gDnPNQWz4PJvgXSa+zSTTw55qR4Wjew9vvcA=;
  b=NqtRUhMwZPv068y92INuiwkrNvMh3wllX87sRSXuJ7vPIKdClv+OfAaP
   /e+/SM6z6XgkwtO+Hp09UPoHfZ1eMLsV/zDL9qi1ikC/HEiGsrxf9c215
   9zExfYIlSVBnurhdzBqBFg9TCEofskKsiADLw+2rwuuh0m6sMQ2DD/WkM
   wfclbNfMSnt4an40yFT472zn7gXLzNxnEhel3iMBSxb2rBV+TydPL1D89
   QNViMcAkPlQS6ny+i5Q6Jvr3gBAr85yfqj0N5Bd0SK5Be50lN5ZabRtN/
   JGWj+Y3i7uYFS/qYQ1jjOnTMvcgrdTSY/NRwVbq9NQo3buhIVcNo+Z3i0
   Q==;
X-CSE-ConnectionGUID: bQ5DraHTSXG/FzuiSpFJ1A==
X-CSE-MsgGUID: t4d0K/PxS+CSmg3kc/hRYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="50266426"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="50266426"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 00:39:50 -0700
X-CSE-ConnectionGUID: Y9e57ER8SDy5G6wGIUAEmw==
X-CSE-MsgGUID: RVKkfV8RTK6gwePf1FzckQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="147412219"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa004.fm.intel.com with ESMTP; 26 May 2025 00:39:48 -0700
Message-ID: <b982ff0e-1ae8-429d-aa11-c3e81a9c14e5@linux.intel.com>
Date: Mon, 26 May 2025 10:39:47 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] usb: xhci: Skip xhci_reset in xhci_resume if xhci
 is being removed
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
 Roy Luo <royluo@google.com>
Cc: "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "michal.pecio@gmail.com" <michal.pecio@gmail.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250522190912.457583-1-royluo@google.com>
 <20250522190912.457583-2-royluo@google.com>
 <20250523230633.u46zpptaoob5jcdk@synopsys.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250523230633.u46zpptaoob5jcdk@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.5.2025 2.06, Thinh Nguyen wrote:
> Hi Mathias, Roy,
> 
> On Thu, May 22, 2025, Roy Luo wrote:
>> xhci_reset() currently returns -ENODEV if XHCI_STATE_REMOVING is
>> set, without completing the xhci handshake, unless the reset completes
>> exceptionally quickly. This behavior causes a regression on Synopsys
>> DWC3 USB controllers with dual-role capabilities.
>>
>> Specifically, when a DWC3 controller exits host mode and removes xhci
>> while a reset is still in progress, and then attempts to configure its
>> hardware for device mode, the ongoing, incomplete reset leads to
>> critical register access issues. All register reads return zero, not
>> just within the xHCI register space (which might be expected during a
>> reset), but across the entire DWC3 IP block.
>>
>> This patch addresses the issue by preventing xhci_reset() from being
>> called in xhci_resume() and bailing out early in the reinit flow when
>> XHCI_STATE_REMOVING is set.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 6ccb83d6c497 ("usb: xhci: Implement xhci_handshake_check_state() helper")
>> Suggested-by: Mathias Nyman <mathias.nyman@intel.com>
>> Signed-off-by: Roy Luo <royluo@google.com>
>> ---
>>   drivers/usb/host/xhci.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>> index 90eb491267b5..244b12eafd95 100644
>> --- a/drivers/usb/host/xhci.c
>> +++ b/drivers/usb/host/xhci.c
>> @@ -1084,7 +1084,10 @@ int xhci_resume(struct xhci_hcd *xhci, bool power_lost, bool is_auto_resume)
>>   		xhci_dbg(xhci, "Stop HCD\n");
>>   		xhci_halt(xhci);
>>   		xhci_zero_64b_regs(xhci);
>> -		retval = xhci_reset(xhci, XHCI_RESET_LONG_USEC);
>> +		if (xhci->xhc_state & XHCI_STATE_REMOVING)
>> +			retval = -ENODEV;
>> +		else
>> +			retval = xhci_reset(xhci, XHCI_RESET_LONG_USEC);
> 
> How can this prevent the xhc_state from changing while in reset? There's
> no locking in xhci-plat.

Patch 2/2, which is the revert of 6ccb83d6c497 prevents xhci_reset() from
aborting due to xhc_state flags change.

This patch makes sure xHC is not reset twice if xhci is resuming due to
remove being called. (XHCI_STATE_REMOVING is set).
The Qcom platform has watchdog issues with the 10 second XHCI_RESET_LONG_USEC
timeout reset during resume at remove.

> 
> I would suggest to simply revert the commit 6ccb83d6c497 that causes
> regression first. We can investigate and look into a solution to the
> specific Qcom issue afterward.

Why intentionally bring back the Qcom watchdog issue by only reverting
6ccb83d6c497 ?. Can't we solve both in one go?

> 
> Note that this commit may impact role-switching flow for all DRD dwc3
> (and perhaps others), which may also impact other Qcom DRD platforms.

Could you expand on this, I'm not sure I follow.

xHC will be reset later in remove path:

xhci_plat_remove()
   usb_remove_hcd()
     hcd->driver->stop(hcd) -> xhci_stop()
       xhci_reset(xhci, XHCI_RESET_SHORT_USEC);

Thanks
Mathias


