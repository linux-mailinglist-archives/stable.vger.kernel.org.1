Return-Path: <stable+bounces-119922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D96A4951B
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 10:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FEB3A59B5
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 09:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF31B25C712;
	Fri, 28 Feb 2025 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3SAatq9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07F257434;
	Fri, 28 Feb 2025 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735022; cv=none; b=jDD99HwcxxCZI7AABMCdrHaDxVzxdXRQdOOI00dk9yGdBdvYZTOkMhTEq375zy9w1WsLgOmStr/IXbC/p5Ib993SqhxlVKmGYaD/VX3VJmsEctxE495l/OjFlYCpYjUnLPHrOCvk4MORX8aV3wHVgO71iDk6wJSN75T+F+O3JdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735022; c=relaxed/simple;
	bh=vueB8glrxQlRjIMAss1r71kAHRNbnxrNli+SINmYOp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BA8oySEp73XwDOfAh9zaKKz33RdJUv0j5tZ3WKittKLw0ph4mXl6ZSLUDHakalFeJskaC4GveyV5fCy23DsBpYDNzFCDIcgx8FxWRCdBWefORDQopE5h8IxIPRidGfkljzOgkj6SRCbT/zyQ62UNy53C2DRah55muDjFuM6Ulfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3SAatq9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740735021; x=1772271021;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vueB8glrxQlRjIMAss1r71kAHRNbnxrNli+SINmYOp4=;
  b=V3SAatq9sX9FRNKYU0bJMvcASKVdC9DCqqhE4+2DD3MzKyK2+IT0lLDY
   CZfhrQ0gIA58TaBaa0utRIe1goat3FRj/4U5Ovll48PrRt/zOBoIYvwNf
   ThTTem4qAuVD4fgsveuAyaIZkKJkmZ43RIq7Flv71wQwIaEWWi/THoyw/
   AvNk2A2Eui7j1i1gKjYbeDiE7MFOJTyGazYbLU4i6Y7wFXwnR4dYxYKyZ
   Htk5kDipPQQJ14vG7aLBDTGrYwPFqof6hkvg3bNNK019GWmvwhwVrqw8D
   JkEEBSgFHW/VVjuKB0yNJeqxR4o7fhtnb7TtSrgAhfFULpbORZ1DCwyMG
   A==;
X-CSE-ConnectionGUID: 8Mdr2y6LRNiWYHY8Saejzg==
X-CSE-MsgGUID: 0VqJnVbaTtKxb/h+roQNAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45438694"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="45438694"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 01:30:21 -0800
X-CSE-ConnectionGUID: Ql+YnlPFR8mAYyWI4sxNoQ==
X-CSE-MsgGUID: wfjEbwY/SauCZb3PqK/3UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148214038"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa001.fm.intel.com with ESMTP; 28 Feb 2025 01:30:19 -0800
Message-ID: <31b489db-9028-4eea-b84d-9497d49fdddc@linux.intel.com>
Date: Fri, 28 Feb 2025 11:31:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xhci: Restrict USB4 tunnel detection for USB3 devices to
 Intel hosts
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marc Zyngier <maz@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Oliver Upton <oliver.upton@linux.dev>,
 stable@vger.kernel.org
References: <20250227194529.2288718-1-maz@kernel.org>
 <2025022709-unread-mystified-ddf1@gregkh>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <2025022709-unread-mystified-ddf1@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.2.2025 22.20, Greg Kroah-Hartman wrote:
> On Thu, Feb 27, 2025 at 07:45:29PM +0000, Marc Zyngier wrote:
>> When adding support for USB3-over-USB4 tunnelling detection, a check
>> for an Intel-specific capability was added. This capability, which
>> goes by ID 206, is used without any check that we are actually
>> dealing with an Intel host.
>>
>> As it turns out, the Cadence XHCI controller *also* exposes an
>> extended capability numbered 206 (for unknown purposes), but of
>> course doesn't have the Intel-specific registers that the tunnelling
>> code is trying to access. Fun follows.
>>
>> The core of the problems is that the tunnelling code blindly uses
>> vendor-specific capabilities without any check (the Intel-provided
>> documentation I have at hand indicates that 192-255 are indeed
>> vendor-specific).
>>
>> Restrict the detection code to Intel HW for real, preventing any
>> further explosion on my (non-Intel) HW.
>>
>> Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: stable@vger.kernel.org
>> Fixes: 948ce83fbb7df ("xhci: Add USB4 tunnel detection for USB3 devices on Intel hosts")
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>   drivers/usb/host/xhci-hub.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
>> index 9693464c05204..69c278b64084b 100644
>> --- a/drivers/usb/host/xhci-hub.c
>> +++ b/drivers/usb/host/xhci-hub.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/unaligned.h>
>>   #include <linux/bitfield.h>
>> +#include <linux/pci.h>
>>   
>>   #include "xhci.h"
>>   #include "xhci-trace.h"
>> @@ -770,9 +771,16 @@ static int xhci_exit_test_mode(struct xhci_hcd *xhci)
>>   enum usb_link_tunnel_mode xhci_port_is_tunneled(struct xhci_hcd *xhci,
>>   						struct xhci_port *port)
>>   {
>> +	struct usb_hcd *hcd;
>>   	void __iomem *base;
>>   	u32 offset;
>>   
>> +	/* Don't try and probe this capability for non-Intel hosts */
>> +	hcd = xhci_to_hcd(xhci);
>> +	if (!dev_is_pci(hcd->self.controller) ||
>> +	    to_pci_dev(hcd->self.controller)->vendor != PCI_VENDOR_ID_INTEL)
>> +		return USB_LINK_UNKNOWN;
> 
> Ugh, nice catch.
> 
> Mathias, want me to just take this directly for now and not wait for you
> to resend it?

Yes, please, take it directly

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>

Thanks
Mathias

