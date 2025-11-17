Return-Path: <stable+bounces-194970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 619F8C64DBF
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 16:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D78C4E65D8
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AED33B970;
	Mon, 17 Nov 2025 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kw7IEkrz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E60339714;
	Mon, 17 Nov 2025 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763393028; cv=none; b=fcYONBZ2OC08pFFQt3k9gfLl7IrtmHl1DPFdvGymgl2BKVqz29JF2yi3fcg88SbTbWgBvgBL05CUn7cus0Ymf66QuqjppN56T2F0x8EyDlEOZN2XQ393ZWd1AIRkFKIm6xhovpdiWF499VXlcTqEyfMV8EzAr8jybJMg/fAOr9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763393028; c=relaxed/simple;
	bh=R207KvhirYCVpdy19bCCIuuklsmD3ljT/ayIsEAqa2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ds8EAdLWY/2ykrLnAcWDiW349quCId6LnkKuLusIUiRoE6lk+EsJkvuPtYvEKgFnheo/K514OLZ361Nu43a9fXhRBSooNsathjRhNJ5mOBferycpckuGVUP4UWYlObSUMQrtZDMFTLtHITyRcYorVNoMWK3Zo2v7B70inRFfpGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kw7IEkrz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763393027; x=1794929027;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R207KvhirYCVpdy19bCCIuuklsmD3ljT/ayIsEAqa2w=;
  b=kw7IEkrzOyA+o331n0t0fePw1zC7m7REi450SGm9ViLOmpOfwqrmNZks
   USFvoJ9vYd/srmsSOqKQERbht0a7HTdMGzIY/uY2t+/AVLNUtWTTwOUGt
   QoaqE/Bw8vg9xd7X+B+cxp/i1LhjyryAnv9ZwZf2c1kFzp98827TpCVUv
   UnWjixsh6avycKcIgOWHpRkeEyCP7Q/S8TzNRZ9MlhUapNvZPToQzulQ9
   tO/leOgzrhd9zoy+C85cIE3RTvQhBrHwMcz8JB2m3bPs1tUspFQftvy2a
   7otkzcfguQxAkAPNkF1AJAmdV6nixShKr7vbakshyIWxmDvr2ZYHEv3AE
   w==;
X-CSE-ConnectionGUID: EEKVZn5uTEy9G92ZJW5Skw==
X-CSE-MsgGUID: ocV1gfNLQKe8f/x/ZILqzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65328016"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="65328016"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 07:23:46 -0800
X-CSE-ConnectionGUID: s994fjxCQL20ZCVPvdXqAw==
X-CSE-MsgGUID: Ob3lUQMhTKKoiLWoc9Ur0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="190636817"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO [10.245.244.255]) ([10.245.244.255])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 07:23:44 -0800
Message-ID: <d25feb0d-2ede-4722-a499-095139870c96@linux.intel.com>
Date: Mon, 17 Nov 2025 17:23:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] xhci: dbgtty: fix device unregister
To: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org
References: <20251114150147.584150-1-ukaszb@google.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20251114150147.584150-1-ukaszb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Łukasz

On 11/14/25 17:01, Łukasz Bartosik wrote:
> From: Łukasz Bartosik <ukaszb@chromium.org>
> 
> When DbC is disconnected then xhci_dbc_tty_unregister_device()
> is called. However if there is any user space process blocked
> on write to DbC terminal device then it will never be signalled
> and thus stay blocked indifinitely.
> 
> This fix adds a tty_hangup() call in xhci_dbc_tty_unregister_device().
> The tty_hangup() wakes up any blocked writers and causes subsequent
> write attempts to DbC terminal device to fail.

Nice catch

> 
> Cc: stable@vger.kernel.org
> Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
> Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
> ---
>   drivers/usb/host/xhci-dbgtty.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
> index d894081d8d15..6ea31af576c7 100644
> --- a/drivers/usb/host/xhci-dbgtty.c
> +++ b/drivers/usb/host/xhci-dbgtty.c
> @@ -535,6 +535,13 @@ static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
>   
>   	if (!port->registered)
>   		return;
> +	/*
> +	 * Hang up the TTY. This wakes up any blocked
> +	 * writers and causes subsequent writes to fail.
> +	 */
> +	if (port->port.tty)
> +		tty_hangup(port->port.tty);

I'm not a tty expert but would the tty_port_tty_vhangup(&port->port) make
sense here?

No need to check for port->port.tty, and it does all the needed locking and
tty reference counting.

It is also synchronous which should probably be ok as this is either called
from a delayed workqueue, during suspend, or remove()

Thanks
Mathias

