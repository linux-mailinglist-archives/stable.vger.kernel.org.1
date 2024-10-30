Return-Path: <stable+bounces-89315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9333B9B6276
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 13:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38121C20F53
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 12:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019841E7C37;
	Wed, 30 Oct 2024 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZrTi+1X9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5871E7C12;
	Wed, 30 Oct 2024 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289767; cv=none; b=JjMzd1OegCmammswND4rWEdlgEYa8jTKSUG/q3m3MpDHM71+/Em8HObkRPEH+iIYalh9c5bi/ZwNx0QJgxuEzRYv7LSXFPEY+RlO2aug+oFU8vzverQ66tksrjpXaZKQ8ViHySgfssAlnDNHZt1Y5AcQpey9gbJYfdo9ngmj0bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289767; c=relaxed/simple;
	bh=gCZUhyMVNmBHmH6gwhWKgLqmPkMfLaznUvJP/f8cywk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1E6l4GEpKMYPLtSxQKLwSuHahjFPYUlMF25WvkqH81Vz4wu9o4PxE+ETUs5HwvHT2rkXp26Sm89L6b7HE/+ofjse0nWBDObKkxMSz7dzuYMOV9XxaajwCVYMZi/Dikghnz6gum3s0J5SbBb9yDv6RjUdJRhFIvwfflPCq5+EGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZrTi+1X9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730289765; x=1761825765;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gCZUhyMVNmBHmH6gwhWKgLqmPkMfLaznUvJP/f8cywk=;
  b=ZrTi+1X9jWfASJWICtuTqUJDsMkAq3TEQ25T3YzTP+Pfo+UUKPxZEuDp
   l7TkTcOG4dYdq9oAb4PQCW3t/x5hWVnY0ugmqQnej2tpDi0l8LqkxKmAY
   NQrSkXPXlEUmd63DePs6gndo2hb7/o7TNmIly2o/Ki38FObyfheNnYmIg
   Zl5ShaI30L+ORHZxkTFcu2ilKI1+hnlsRYA3cVTo9QBfjZb/5OEovv83w
   NkdApq71dtsPXkFfYo4BWYGqH9Cmf7WiRr3VyPto5qPBCisF9VjBe/urJ
   KZdodlBhjYguAuAqoYtIuVb5R1xP/V94jymWWA5I8wy7UYSJZR/+FZ7Gs
   w==;
X-CSE-ConnectionGUID: NcU1L9XfROeECrpOBJ5cRg==
X-CSE-MsgGUID: ihTzULlQTQGFhoLwe3PS4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40518456"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40518456"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 05:02:45 -0700
X-CSE-ConnectionGUID: pS07IeRBTEa/Ygowo09Vhw==
X-CSE-MsgGUID: Cf7hSCFwRvG9bYDDwlGwPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="113097360"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa002.jf.intel.com with ESMTP; 30 Oct 2024 05:02:43 -0700
Message-ID: <bceb89ce-7a4b-4447-8bd6-3129a37bfdb3@linux.intel.com>
Date: Wed, 30 Oct 2024 14:04:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] xhci: Combine two if statements for Etron xHCI
 host
To: Kuangyi Chiang <ki.chiang65@gmail.com>, mathias.nyman@intel.com,
 gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241028025337.6372-1-ki.chiang65@gmail.com>
 <20241028025337.6372-2-ki.chiang65@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20241028025337.6372-2-ki.chiang65@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.10.2024 4.53, Kuangyi Chiang wrote:
> Combine two if statements, because these hosts have the same
> quirk flags applied.
> 
> Fixes: 91f7a1524a92 ("xhci: Apply broken streams quirk to Etron EJ188 xHCI host")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>

Added to queue, but I removed the Fixes and stable tags as this is a small
cleanup with no functional changes.

> ---
>   drivers/usb/host/xhci-pci.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 7e538194a0a4..33a6d99afc10 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -395,12 +395,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>   		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
>   
>   	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
> -			pdev->device == PCI_DEVICE_ID_EJ168) {
> -		xhci->quirks |= XHCI_RESET_ON_RESUME;
> -		xhci->quirks |= XHCI_BROKEN_STREAMS;
> -	}
> -	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
> -			pdev->device == PCI_DEVICE_ID_EJ188) {
> +	    (pdev->device == PCI_DEVICE_ID_EJ168 ||
> +	     pdev->device == PCI_DEVICE_ID_EJ188)) {
>   		xhci->quirks |= XHCI_RESET_ON_RESUME;
>   		xhci->quirks |= XHCI_BROKEN_STREAMS;
>   	}


