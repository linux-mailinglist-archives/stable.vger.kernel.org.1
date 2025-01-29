Return-Path: <stable+bounces-111123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4D0A21D32
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 13:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 246717A2766
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 12:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C07210E9;
	Wed, 29 Jan 2025 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5s7sXAy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A38184;
	Wed, 29 Jan 2025 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738154272; cv=none; b=Rnhr8D3cSJfJwLZOjD86EFwkTyi8EqQ7gHkt6jOdAgAA+uB0uu+6J5lLdifO7+JKwbzeTtz7oP5uU82Ir7/UFEuAxg75OdFk3+zFSkR82RWTQI4MnPUWvfiZZ+gVEHI7qOd7XiywwnxcSgtlp1BpP4irtsrUrhWWoBiv9QOXVtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738154272; c=relaxed/simple;
	bh=WRRnDwa/KTqpTFBdHKVLrRFE8LMDYxRKranHALVFdEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPTRni0ZFHUvA9C7lTvIVKlJuhrNgQNNra35Yn28KTbKu5I5T4uPNCw4NpxO/fmIxG21qhTtRw7jygh+AHYxiJQNjmtH5csesp43dvfGQmhTXXorESqIReL6n6vcgq54jP1PlfIEzkPgDXVWLXkKdbPhPJtvj87Rf7MLa9ydWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5s7sXAy; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738154270; x=1769690270;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WRRnDwa/KTqpTFBdHKVLrRFE8LMDYxRKranHALVFdEw=;
  b=T5s7sXAyxzJiwk5efFz5BVSIb1Q0+Q18mEcIuz2qO2Zw3YB5rjROqnDp
   SpHCf4uo2hkzi2tLhrz8ZgljhNr2ivJA5OJJ+XdGPj0+4wPY/sNuxzo89
   g6lLmhZRhRxU6at8LbRyipPpp7/JShM4HEH/ZKdgvRV0Zc4j4DGApPUYm
   sXjNLmfWe6oIlcw47zbnT6VwCcW28muHShPNzZ60NYl0xTUIwT1AT3OUj
   L4zKAYedgBI4uLJT9Xji4xPrfyL9i/9O3htpVN816zIcY/wZaiOR7zSN2
   R88id0xGQzO28xQbqWgsxGt5Xe0vcaBiKRFFDrduVxGzpxNFiL4fPEro2
   g==;
X-CSE-ConnectionGUID: i90njIwET5GLS/6Okd0nSQ==
X-CSE-MsgGUID: JMMH0wWcRb+GTXo3PsSgnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="38695174"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="38695174"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 04:37:34 -0800
X-CSE-ConnectionGUID: xVr1OLfvRfyWON2pY22Hzg==
X-CSE-MsgGUID: hYaEMfpRSPu0X/hnM10ErQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="109573857"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa010.fm.intel.com with ESMTP; 29 Jan 2025 04:37:32 -0800
Message-ID: <1c44ff09-dd26-489d-9867-8d300a3574ac@linux.intel.com>
Date: Wed, 29 Jan 2025 14:38:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: xhci: quirk for data loss in ISOC transfers
To: Raju Rangoju <Raju.Rangoju@amd.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
 stable@vger.kernel.org
References: <20250127120631.799287-1-Raju.Rangoju@amd.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250127120631.799287-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.1.2025 14.06, Raju Rangoju wrote:
> During the High-Speed Isochronous Audio transfers, xHCI
> controller on certain AMD platforms experiences momentary data
> loss. This results in Missed Service Errors (MSE) being
> generated by the xHCI.
> 
> The root cause of the MSE is attributed to the ISOC OUT endpoint
> being omitted from scheduling. This can happen either when an IN
> endpoint with a 64ms service interval is pre-scheduled prior to
> the ISOC OUT endpoint or when the interval of the ISOC OUT
> endpoint is shorter than that of the IN endpoint. Consequently,
> the OUT service is neglected when an IN endpoint with a service
> interval exceeding 32ms is scheduled concurrently (every 64ms in
> this scenario).
> 
> This issue is particularly seen on certain older AMD platforms.
> To mitigate this problem, it is recommended to adjust the service
> interval of the IN endpoint to not exceed 32ms (interval 8). This
> adjustment ensures that the OUT endpoint will not be bypassed,
> even if a smaller interval value is utilized.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
> Changes since v3:
>   - Bump up the enum number XHCI_LIMIT_ENDPOINT_INTERVAL_9
> 
> Changes since v2:
>   - added stable tag to backport to all stable kernels
> 
> Changes since v1:
>   - replaced hex values with pci device names
>   - corrected the commit message
> 
>   drivers/usb/host/xhci-mem.c |  5 +++++
>   drivers/usb/host/xhci-pci.c | 25 +++++++++++++++++++++++++
>   drivers/usb/host/xhci.h     |  1 +
>   3 files changed, 31 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index 92703efda1f7..d3182ba98788 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -1420,6 +1420,11 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
>   	/* Periodic endpoint bInterval limit quirk */
>   	if (usb_endpoint_xfer_int(&ep->desc) ||
>   	    usb_endpoint_xfer_isoc(&ep->desc)) {
> +		if ((xhci->quirks & XHCI_LIMIT_ENDPOINT_INTERVAL_9) &&
> +		    usb_endpoint_xfer_int(&ep->desc) &&
> +		    interval >= 9) {
> +			interval = 8;

Commit message describes this as an issue triggered by High-Speed Isoc In
endpoints that have interval larger than 32ms.

This code limits interval to 32ms for Interrupt endpoints (any speed),
should it be isoc instead?

Are Full-/Low-speed devices really also affected?

Thanks
Mathias


