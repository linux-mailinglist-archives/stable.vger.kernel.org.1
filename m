Return-Path: <stable+bounces-145690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEE6ABE06D
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 18:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65BC27B59B8
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE92258CE3;
	Tue, 20 May 2025 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTLDJenN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B714A06;
	Tue, 20 May 2025 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757907; cv=none; b=mm7BBnESYatPWpek+ox9zcv8/UfxYOgYc2phBSaAAziYnGe8XyQdqFK3YcGfgFMIvs+ZKCNT9rrz5O6rrlr6ft4/vS366E77FVa0UoTfZJdEZRuqD4dQP9RFVeqnfd2dmgm6tAf61aZFK8YTDKf9h2keeT4/CcV/UIJy+dSIukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757907; c=relaxed/simple;
	bh=FWAcuH6OHyVpX6QxTtnReOCIzbpcnElu4hy+ppdiWoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLVdbsfrWGLhYw1QyVEOIlCIcZ5aPfaxKs7bJmkKy6zZqsaFF8KUnoDEcwXC1HPqdvPQQ/yC8wQZjdvf8+Pyi75v09OTqz9pDW6OhyzCqf9dIGIzeXrd0vdrkqzersdtcU4ZiDzv8eAVGPHUJ+VX88uerhMGVQ8qrmEq8COgNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTLDJenN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747757906; x=1779293906;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FWAcuH6OHyVpX6QxTtnReOCIzbpcnElu4hy+ppdiWoM=;
  b=DTLDJenNbtlFRQToq/fWlSIw/fYB+T2B/HXcrv+iE8aF/M2wnGOT9lH8
   vV6EdYB3/I7ixHBwImY64ovk+LWfPz0cNWYC8pXQ+dVY7+WK0baYNjvRO
   NrMNxoa0+tZGK/l9K7BgFlPrkWomIR6YFsMazsGmOyihUw3hccyXHOuC5
   urEVyjLPxk7twi9QuHNy0DKtoarfTOxoPdCW9E46z/tjDgNRe8zJwRSMT
   J0XDo0VDtGlFTQWfB5riL+XsCz//cfHOfE9+gIE68jPS51jtAHyzqiREq
   04ealoUXTAeijlEnFvSQUy06aT6lwsSherqQ922f/9otaqpuEBeSHimtc
   Q==;
X-CSE-ConnectionGUID: 0yFcgpNoSwO/XTctvTq2yA==
X-CSE-MsgGUID: WWT48XaDSGSwUDWJFW5E2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="48957789"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="48957789"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 09:18:25 -0700
X-CSE-ConnectionGUID: YOrPUupMTlikiM1ZUpcNcQ==
X-CSE-MsgGUID: ruB6orzDSRONDzk4DrROZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140154366"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa008.fm.intel.com with ESMTP; 20 May 2025 09:18:23 -0700
Message-ID: <fbf92981-6601-4ee9-a494-718e322ac1b9@linux.intel.com>
Date: Tue, 20 May 2025 19:18:21 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Revert "usb: xhci: Implement
 xhci_handshake_check_state() helper"
To: Udipto Goswami <udipto.goswami@oss.qualcomm.com>
Cc: Roy Luo <royluo@google.com>, mathias.nyman@intel.com,
 quic_ugoswami@quicinc.com, Thinh.Nguyen@synopsys.com,
 gregkh@linuxfoundation.org, michal.pecio@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250517043942.372315-1-royluo@google.com>
 <8f023425-3f9b-423c-9459-449d0835c608@linux.intel.com>
 <CAMTwNXB0QLP-b=RmLPtRJo=T_efN_3H4dd5AiMNYrJDXddJkMA@mail.gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <CAMTwNXB0QLP-b=RmLPtRJo=T_efN_3H4dd5AiMNYrJDXddJkMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.5.2025 21.13, Udipto Goswami wrote:
> On Mon, May 19, 2025 at 6:23 PM Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
>>
>> On 17.5.2025 7.39, Roy Luo wrote:
>>> This reverts commit 6ccb83d6c4972ebe6ae49de5eba051de3638362c.
>>>
>>> Commit 6ccb83d6c497 ("usb: xhci: Implement xhci_handshake_check_state()
>>> helper") was introduced to workaround watchdog timeout issues on some
>>> platforms, allowing xhci_reset() to bail out early without waiting
>>> for the reset to complete.
>>>
>>> Skipping the xhci handshake during a reset is a dangerous move. The
>>> xhci specification explicitly states that certain registers cannot
>>> be accessed during reset in section 5.4.1 USB Command Register (USBCMD),
>>> Host Controller Reset (HCRST) field:
>>> "This bit is cleared to '0' by the Host Controller when the reset
>>> process is complete. Software cannot terminate the reset process
>>> early by writinga '0' to this bit and shall not write any xHC
>>> Operational or Runtime registers until while HCRST is '1'."
>>>
>>> This behavior causes a regression on SNPS DWC3 USB controller with
>>> dual-role capability. When the DWC3 controller exits host mode and
>>> removes xhci while a reset is still in progress, and then tries to
>>> configure its hardware for device mode, the ongoing reset leads to
>>> register access issues; specifically, all register reads returns 0.
>>> These issues extend beyond the xhci register space (which is expected
>>> during a reset) and affect the entire DWC3 IP block, causing the DWC3
>>> device mode to malfunction.
>>
>> I agree with you and Thinh that waiting for the HCRST bit to clear during
>> reset is the right thing to do, especially now when we know skipping it
>> causes issues for SNPS DWC3, even if it's only during remove phase.
>>
>> But reverting this patch will re-introduce the issue originally worked
>> around by Udipto Goswami, causing regression.
>>
>> Best thing to do would be to wait for HCRST to clear for all other platforms
>> except the one with the issue.
>>
>> Udipto Goswami, can you recall the platforms that needed this workaroud?
>> and do we have an easy way to detect those?
> 
> Hi Mathias,
> 
>  From what I recall, we saw this issue coming up on our QCOM mobile
> platforms but it was not consistent. It was only reported in long runs
> i believe. The most recent instance when I pushed this patch was with
> platform SM8650, it was a watchdog timeout issue where xhci_reset() ->
> xhci_handshake() polling read timeout upon xhci remove. Unfortunately
> I was not able to simulate the scenario for more granular testing and
> had validated it with long hours stress testing.
> The callstack was like so:
> 
> Full call stack on core6:
> -000|readl([X19] addr = 0xFFFFFFC03CC08020)
> -001|xhci_handshake(inline)
> -001|xhci_reset([X19] xhci = 0xFFFFFF8942052250, [X20] timeout_us = 10000000)
> -002|xhci_resume([X20] xhci = 0xFFFFFF8942052250, [?] hibernated = ?)
> -003|xhci_plat_runtime_resume([locdesc] dev = ?)
> -004|pm_generic_runtime_resume([locdesc] dev = ?)
> -005|__rpm_callback([X23] cb = 0xFFFFFFE3F09307D8, [X22] dev =
> 0xFFFFFF890F619C10)
> -006|rpm_callback(inline)
> -006|rpm_resume([X19] dev = 0xFFFFFF890F619C10,
> [NSD:0xFFFFFFC041453AD4] rpmflags = 4)
> -007|__pm_runtime_resume([X20] dev = 0xFFFFFF890F619C10, [X19] rpmflags = 4)
> -008|pm_runtime_get_sync(inline)
> -008|xhci_plat_remove([X20] dev = 0xFFFFFF890F619C00)

Thank you for clarifying this.

So patch avoids the long timeout by always cutting xhci reinit path short in
xhci_resume() if resume was caused by pm_runtime_get_sync() call in
xhci_plat_remove()

void xhci_plat_remove(struct platform_device *dev)
{
	xhci->xhc_state |= XHCI_STATE_REMOVING;
	pm_runtime_get_sync(&dev->dev);
	...
}

I think we can revert this patch, and just make sure that we don't reset the
host in the reinit path of xhci_resume() if XHCI_STATE_REMOVING is set.
Just return immediately instead.

xhci_reset() will be called with a shorter timeout later in the remove path

Not entirely sure remove path needs to call pm_runtime_get_sync().
I think it just tries to prevent runtime suspend/resume from racing with remove.
PCI code seems to call pm_runtime_get_noresume() in remove path instead.

Thanks
Mathias

