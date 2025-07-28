Return-Path: <stable+bounces-164934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0851B13B5B
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 15:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EC73ABC3F
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4C126738D;
	Mon, 28 Jul 2025 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+qo2EUZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF225F7A4;
	Mon, 28 Jul 2025 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708623; cv=none; b=fnNLVLf4vNbSGcDf+swamzffSeFJxjdNdLCGvIYbhZqGQZAOWIBNZaXnB5QEGAGefzkGv5xlsYLfrZd0OQOtOlzuAdqmMTUIgv4dT3OFf8BsOsht1XJeziDcRv7I0uNqqVBlOgSjwA/KsDXzFJhxElUdnQMSf0QB1ajXkOyhVN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708623; c=relaxed/simple;
	bh=K1X+GjJICl++iuPaSTlChGNvy4DLCEyzYkUZMgPjXK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4wn6je3v1Hh+Kdwdi4a9add911zz5O9OlbMb0/c+xH/j8QfeYPn49Mv7D+7KuqogAH+WM5cQz4ref1a8ZtqY6zujKznpj1eSGaKpHyTb+Be3tirfMo1XVkWQO5brKvwVxPr+c0irxhqW+wGyGb0cP+d3e+qJbLJvDtn+dS9mfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+qo2EUZ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753708621; x=1785244621;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K1X+GjJICl++iuPaSTlChGNvy4DLCEyzYkUZMgPjXK4=;
  b=G+qo2EUZ2ZeQzX+2CQP0QmNSjTj5GEwmfqZwCS4MhZmJiCV9lkwOahw8
   eG07SSPWKDARH2XgEERJxcJMJxfRCpu1KegK753KR99HFRMpPkSpMO5th
   SCELHn8mVmHEZQZhTDu3L+0qX+XqLmtJLdQfCSuVj/dEtABJyuZaR/eTr
   gvNsDz/USKPM2+sg9vghkSTBaHIqummr3zNhDy2k00geFWNKqk3qhuyva
   C/qARFSS2pvCRqFTwZ3hysgFkEO5xHQS8Gt0+vzvCsj4KKRAlidAoyIKa
   Y4o7gOFvF/EYOQJ1C+QuAD3kSg5t1cA3mmCLxnRuBc3nYIkBBYgVUZsEJ
   g==;
X-CSE-ConnectionGUID: R7StVrKAQlOZQwNHE6TiPw==
X-CSE-MsgGUID: hEHZ3LwdQMaMcm6mCqb4YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="59774312"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="59774312"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 06:17:00 -0700
X-CSE-ConnectionGUID: 8Yg7e5nESYKsJ8j965U0eA==
X-CSE-MsgGUID: IzWaxWdSQ5CmPsKVFbJKrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="167739883"
Received: from mnyman-desk.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa004.fm.intel.com with ESMTP; 28 Jul 2025 06:16:52 -0700
Message-ID: <094f9822-9f12-4c67-b648-84a48c2e154b@linux.intel.com>
Date: Mon, 28 Jul 2025 16:16:51 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb:xhci:Fix slot_id resource race conflict
To: Weitao Wang <WeitaoWang-oc@zhaoxin.com>, gregkh@linuxfoundation.org,
 mathias.nyman@intel.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: WeitaoWang@zhaoxin.com, wwt8723@163.com, CobeChen@zhaoxin.com,
 stable@vger.kernel.org
References: <20250725185101.8375-1-WeitaoWang-oc@zhaoxin.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250725185101.8375-1-WeitaoWang-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.7.2025 21.51, Weitao Wang wrote:
> In such a scenario, device-A with slot_id equal to 1 is disconnecting
> while device-B is enumerating, device-B will fail to enumerate in the
> follow sequence.
> 
> 1.[device-A] send disable slot command
> 2.[device-B] send enable slot command
> 3.[device-A] disable slot command completed and wakeup waiting thread
> 4.[device-B] enable slot command completed with slot_id equal to 1 and
> wakeup waiting thread
> 5.[device-B] driver check this slot_id was used by someone(device-A) in
> xhci_alloc_virt_device, this device fails to enumerate as this conflict
> 6.[device-A] xhci->devs[slot_id] set to NULL in xhci_free_virt_device
> 
> To fix driver's slot_id resources conflict, let the xhci_free_virt_device
> functionm call in the interrupt handler when disable slot command success.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7faac1953ed1 ("xhci: avoid race between disable slot command and host runtime suspend")
> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>

Nice catch, good to get this fixed.

This however has the downside of doing a lot in interrupt context.

what if we only clear some strategic pointers in the interrupt context,
and then do all the actual unmapping and endpoint ring segments freeing,
contexts freeing ,etc later?

Pseudocode:

xhci_handle_cmd_disable_slot(xhci, slot_id, comp_code)
{
     if (cmd_comp_code == COMP_SUCCESS) {
         xhci->dcbaa->dev_context_ptrs[slot_id] = 0;
         xhci->devs[slot_id] = NULL;
     }
}

xhci_disable_and_free_slot(xhci, slot_id)
{
     struct xhci_virt_device *vdev = xhci->devs[slot_id];

     xhci_disable_slot(xhci, slot_id);
     xhci_free_virt_device(xhci, vdev, slot_id);
}

xhci_free_virt_device(xhci, vdev, slot_id)
{
     if (xhci->dcbaa->dev_context_ptrs[slot_id] == vdev->out_ctx->dma)
         xhci->dcbaa->dev_context_ptrs[slot_id] = 0;

     // free and unmap things just like before
     ...

     if (xhci->devs[slot_id] == vdev)
         xhci->devs[slot_id] = NULL;

     kfee(vdev);
}


> ---
> v1->v2
>   - Adjust the lock position in the function xhci_free_dev.
> 
>   drivers/usb/host/xhci-hub.c  |  5 +++--
>   drivers/usb/host/xhci-ring.c |  7 +++++--
>   drivers/usb/host/xhci.c      | 35 +++++++++++++++++++++++++----------
>   3 files changed, 33 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index 92bb84f8132a..fd8a64aa5779 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -705,10 +705,11 @@ static int xhci_enter_test_mode(struct xhci_hcd *xhci,
>   			continue;
>   
>   		retval = xhci_disable_slot(xhci, i);
> -		xhci_free_virt_device(xhci, i);
> -		if (retval)
> +		if (retval) {
>   			xhci_err(xhci, "Failed to disable slot %d, %d. Enter test mode anyway\n",
>   				 i, retval);
> +			xhci_free_virt_device(xhci, i);
> +		}
>   	}
>   	spin_lock_irqsave(&xhci->lock, *flags);
>   	/* Put all ports to the Disable state by clear PP */
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 94c9c9271658..93dc28399c3c 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -1589,7 +1589,8 @@ static void xhci_handle_cmd_enable_slot(int slot_id, struct xhci_command *comman
>   		command->slot_id = 0;
>   }
>   
> -static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id)
> +static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id,
> +					u32 cmd_comp_code)
>   {
>   	struct xhci_virt_device *virt_dev;
>   	struct xhci_slot_ctx *slot_ctx;
> @@ -1604,6 +1605,8 @@ static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id)
>   	if (xhci->quirks & XHCI_EP_LIMIT_QUIRK)
>   		/* Delete default control endpoint resources */
>   		xhci_free_device_endpoint_resources(xhci, virt_dev, true);
> +	if (cmd_comp_code == COMP_SUCCESS)
> +		xhci_free_virt_device(xhci, slot_id);
>   }
>   
>   static void xhci_handle_cmd_config_ep(struct xhci_hcd *xhci, int slot_id)
> @@ -1853,7 +1856,7 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
>   		xhci_handle_cmd_enable_slot(slot_id, cmd, cmd_comp_code);
>   		break;
>   	case TRB_DISABLE_SLOT:
> -		xhci_handle_cmd_disable_slot(xhci, slot_id);
> +		xhci_handle_cmd_disable_slot(xhci, slot_id, cmd_comp_code);
>   		break;
>   	case TRB_CONFIG_EP:
>   		if (!cmd->completion)
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 8a819e853288..6c6f6ebb8953 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -3931,13 +3931,14 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
>   		 * the USB device has been reset.
>   		 */
>   		ret = xhci_disable_slot(xhci, udev->slot_id);
> -		xhci_free_virt_device(xhci, udev->slot_id);
>   		if (!ret) {
>   			ret = xhci_alloc_dev(hcd, udev);
>   			if (ret == 1)
>   				ret = 0;
>   			else
>   				ret = -EINVAL;
> +		} else {
> +			xhci_free_virt_device(xhci, udev->slot_id);
>   		}
>   		return ret;
>   	}
> @@ -4085,11 +4086,12 @@ static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
>   	for (i = 0; i < 31; i++)
>   		virt_dev->eps[i].ep_state &= ~EP_STOP_CMD_PENDING;
>   	virt_dev->udev = NULL;
> -	xhci_disable_slot(xhci, udev->slot_id);
> -
> -	spin_lock_irqsave(&xhci->lock, flags);
> -	xhci_free_virt_device(xhci, udev->slot_id);
> -	spin_unlock_irqrestore(&xhci->lock, flags);
> +	ret = xhci_disable_slot(xhci, udev->slot_id);
> +	if (ret) {
> +		spin_lock_irqsave(&xhci->lock, flags);
> +		xhci_free_virt_device(xhci, udev->slot_id);
> +		spin_unlock_irqrestore(&xhci->lock, flags);
> +	}
>   
>   }
>   
> @@ -4128,9 +4130,20 @@ int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id)
>   
>   	wait_for_completion(command->completion);
>   
> -	if (command->status != COMP_SUCCESS)
> +	if (command->status != COMP_SUCCESS) {
>   		xhci_warn(xhci, "Unsuccessful disable slot %u command, status %d\n",
>   			  slot_id, command->status);
> +		switch (command->status) {
> +		case COMP_COMMAND_ABORTED:
> +		case COMP_COMMAND_RING_STOPPED:
> +			xhci_warn(xhci, "Timeout while waiting for disable slot command\n");
> +			ret = -ETIME;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +	}
>   
>   	xhci_free_command(xhci, command);
>   
> @@ -4243,8 +4256,9 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
>   	return 1;
>   
>   disable_slot:
> -	xhci_disable_slot(xhci, udev->slot_id);
> -	xhci_free_virt_device(xhci, udev->slot_id);
> +	ret = xhci_disable_slot(xhci, udev->slot_id);
> +	if (ret)
> +		xhci_free_virt_device(xhci, udev->slot_id);
>   
>   	return 0;
>   }
> @@ -4381,10 +4395,11 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
>   
>   		mutex_unlock(&xhci->mutex);
>   		ret = xhci_disable_slot(xhci, udev->slot_id);
> -		xhci_free_virt_device(xhci, udev->slot_id);
>   		if (!ret) {
>   			if (xhci_alloc_dev(hcd, udev) == 1)
>   				xhci_setup_addressable_virt_dev(xhci, udev);
> +		} else {
> +			xhci_free_virt_device(xhci, udev->slot_id);
>   		}
>   		kfree(command->completion);
>   		kfree(command);


