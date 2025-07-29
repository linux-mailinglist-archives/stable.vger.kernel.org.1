Return-Path: <stable+bounces-165086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600C6B14FE5
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 17:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0145E4E763C
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 15:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183AB1B4257;
	Tue, 29 Jul 2025 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCogGssv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941AC2B2DA;
	Tue, 29 Jul 2025 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801242; cv=none; b=ZP4g/YCKC/E3s97uP8GSjWrW4pgjCljmHFhDGTwlLgYI2m0KvS2wsg7mVJsvABjYCm084WETBilYf9+skxDZBCG4d7sh6d6rsFoLpPG2PWmDDoGIsPLkQJO5l9YWtZY8VIWOWifWlomgWG4qQlTQpd/dISzYFUZPZ/6EZCNvJqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801242; c=relaxed/simple;
	bh=u7juA4MuQ7lbE0d+WZZ706DcalvCZTvaAbeHV6xgHxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSxRG873VmIxhpgld6+zCZBrLw3nFu5mFsUj8uuZu9z/YBrw+o4OY6vjPlRmenlExyn8wVMDHWlJMPDS7VjtP19HrvBBHFGPL2HDZETIJ8TkwdcpmOyiz55lmeYm9RpCsfxaGAgetS94vgG4NC90pSwdyOpGnBna6ZhqLkHUAGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCogGssv; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753801241; x=1785337241;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u7juA4MuQ7lbE0d+WZZ706DcalvCZTvaAbeHV6xgHxw=;
  b=fCogGssv5rTGoWxb9E/eUp0ZXmWxN0+eiYmGpTCQ0ZWXnGkX5GTlEWdj
   6zZbpaZrXLwD3sNif0z90U/k0vV8qBye1q684L347nhxtkbd/HjE9Rhbk
   pUdX2LG+7TR3PlCcNwoLlz7NNy789MT8EKrEuDHPkrHrk8mBEYIEj5iOy
   1JUtMOS91MEI42Dq3mLOAEp97O5bWQaPv2uII5iO6ImRdKdrERhYtnrYG
   Fyy+RINjQYndYiVCoAebcPspFrZ87ic5QXXFPML99700iDyjXJErrs/hk
   7YPhaBBY7Rb+t05VzhbR7nYp20qudovF/8n8CltXP1VwCBNX9Bqmt8tQi
   A==;
X-CSE-ConnectionGUID: 7nO/FMgsTs2gbV27/RoDlw==
X-CSE-MsgGUID: t7CRipDeTouTjozX4EaTPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="67511577"
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="67511577"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 08:00:40 -0700
X-CSE-ConnectionGUID: uH+ITq8aTYe6T0yv5xCNTw==
X-CSE-MsgGUID: fbEa0aIzS0Odsc0/hXrYbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="186386172"
Received: from mnyman-desk.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa002.fm.intel.com with ESMTP; 29 Jul 2025 08:00:37 -0700
Message-ID: <855b4621-fc40-4281-9e44-7a2ac861dd4b@linux.intel.com>
Date: Tue, 29 Jul 2025 18:00:36 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb:xhci:Fix slot_id resource race conflict
To: "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: WeitaoWang@zhaoxin.com, wwt8723@163.com, CobeChen@zhaoxin.com,
 stable@vger.kernel.org
References: <20250725185101.8375-1-WeitaoWang-oc@zhaoxin.com>
 <094f9822-9f12-4c67-b648-84a48c2e154b@linux.intel.com>
 <dec32556-c28e-aeed-8516-2e0bb56c3a58@zhaoxin.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <dec32556-c28e-aeed-8516-2e0bb56c3a58@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29.7.2025 20.25, WeitaoWang-oc@zhaoxin.com wrote:
> On 2025/7/28 21:16, Mathias Nyman wrote:
>>
>> On 25.7.2025 21.51, Weitao Wang wrote:
>>> In such a scenario, device-A with slot_id equal to 1 is disconnecting
>>> while device-B is enumerating, device-B will fail to enumerate in the
>>> follow sequence.
>>>
>>> 1.[device-A] send disable slot command
>>> 2.[device-B] send enable slot command
>>> 3.[device-A] disable slot command completed and wakeup waiting thread
>>> 4.[device-B] enable slot command completed with slot_id equal to 1 and
>>> wakeup waiting thread
>>> 5.[device-B] driver check this slot_id was used by someone(device-A) in
>>> xhci_alloc_virt_device, this device fails to enumerate as this conflict
>>> 6.[device-A] xhci->devs[slot_id] set to NULL in xhci_free_virt_device
>>>
>>> To fix driver's slot_id resources conflict, let the xhci_free_virt_device
>>> functionm call in the interrupt handler when disable slot command success.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 7faac1953ed1 ("xhci: avoid race between disable slot command and host runtime suspend")
>>> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
>>
>> Nice catch, good to get this fixed.
>>
>> This however has the downside of doing a lot in interrupt context.
>>
>> what if we only clear some strategic pointers in the interrupt context,
>> and then do all the actual unmapping and endpoint ring segments freeing,
>> contexts freeing ,etc later?
>>
>> Pseudocode:
>>
>> xhci_handle_cmd_disable_slot(xhci, slot_id, comp_code)
>> {
>>      if (cmd_comp_code == COMP_SUCCESS) {
>>          xhci->dcbaa->dev_context_ptrs[slot_id] = 0;
>>          xhci->devs[slot_id] = NULL;
>>      }
>> }
>>
>> xhci_disable_and_free_slot(xhci, slot_id)
>> {
>>      struct xhci_virt_device *vdev = xhci->devs[slot_id];
>>
>>      xhci_disable_slot(xhci, slot_id);
>>      xhci_free_virt_device(xhci, vdev, slot_id);
>> }
>>
>> xhci_free_virt_device(xhci, vdev, slot_id)
>> {
>>      if (xhci->dcbaa->dev_context_ptrs[slot_id] == vdev->out_ctx->dma)
>>          xhci->dcbaa->dev_context_ptrs[slot_id] = 0;
>>
>>      // free and unmap things just like before
>>      ...
>>
>>      if (xhci->devs[slot_id] == vdev)
>>          xhci->devs[slot_id] = NULL;
>>
>>      kfee(vdev);
>> }
> 
> Hi Mathias,
> 
> Yes, your suggestion is a better revision, I made some modifications
> to the patch which is listed below. Please help to review again.
> Thanks for your help.
> 
> ---
>   drivers/usb/host/xhci-hub.c  |  3 +--
>   drivers/usb/host/xhci-mem.c  | 21 ++++++++++-----------
>   drivers/usb/host/xhci-ring.c |  9 +++++++--
>   drivers/usb/host/xhci.c      | 23 ++++++++++++++++-------
>   drivers/usb/host/xhci.h      |  3 ++-
>   5 files changed, 36 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index 92bb84f8132a..b3a59ce1b3f4 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -704,8 +704,7 @@ static int xhci_enter_test_mode(struct xhci_hcd *xhci,
>           if (!xhci->devs[i])
>               continue;
> 
> -        retval = xhci_disable_slot(xhci, i);
> -        xhci_free_virt_device(xhci, i);
> +        retval = xhci_disable_and_free_slot(xhci, i);
>           if (retval)
>               xhci_err(xhci, "Failed to disable slot %d, %d. Enter test mode anyway\n",
>                    i, retval);
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index 6680afa4f596..fc4aca2e65bc 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -865,21 +865,18 @@ int xhci_alloc_tt_info(struct xhci_hcd *xhci,
>    * will be manipulated by the configure endpoint, allocate device, or update
>    * hub functions while this function is removing the TT entries from the list.
>    */
> -void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id)
> +void xhci_free_virt_device(struct xhci_hcd *xhci, struct xhci_virt_device *dev,
> +        int slot_id)
>   {
> -    struct xhci_virt_device *dev;
>       int i;
>       int old_active_eps = 0;
> 
>       /* Slot ID 0 is reserved */
> -    if (slot_id == 0 || !xhci->devs[slot_id])
> +    if (slot_id == 0 || !dev)
>           return;
> 
> -    dev = xhci->devs[slot_id];
> -
> -    xhci->dcbaa->dev_context_ptrs[slot_id] = 0;
> -    if (!dev)
> -        return;
> +    if (xhci->dcbaa->dev_context_ptrs[slot_id] == dev->out_ctx->dma)

forgot that dev_context_ptrs[] values are stored as le64 while
out_ctx->dma  is in whatever cpu uses.

So above should be:
if (xhci->dcbaa->dev_context_ptrs[slot_id] == cpu_to_le64(dev->out_ctx->dma))

Otherwise it looks good to me

Thanks
Mathias


