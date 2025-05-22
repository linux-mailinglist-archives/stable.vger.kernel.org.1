Return-Path: <stable+bounces-146082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E22AC0B8A
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 14:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2DB1674D7
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 12:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF12028A708;
	Thu, 22 May 2025 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ie84OimI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91348268682;
	Thu, 22 May 2025 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747916650; cv=none; b=QlYxOMqkjSmjUXBMGs8wvk8/DX6w8S7qczaFYgTogH9CrY1MyraFNquRhtDvqHyfjQouqo5L3vf+sO6CrDKqW6oCSEci0vjAky1LHWoVHtCGkMKZsStTjHNLsA80WaJtew4tq5wCqpdIRYw8CkVFU+Yjq6ha4JQNfB3UxBAbvW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747916650; c=relaxed/simple;
	bh=M42ZpmGj6WOB9FCiYWfWW4REKJAyVSHfmZWm5I0db3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rfindJI6NTGdSQEA/dsLkf7HNoxJ5Jp34VPioJS2IxZeFzaRyoGl+H4ZoLR6pF8UzrPKZBrgDP+UZlbu5Lbyf0ik2pfTHkAWlmk7dnVx7sZqG4jpb6D5gverDiVCusN6fZgVvT8K7zx4X64zC1RTjz+C1XAMRUCg3Li5jexpmD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ie84OimI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747916649; x=1779452649;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M42ZpmGj6WOB9FCiYWfWW4REKJAyVSHfmZWm5I0db3s=;
  b=ie84OimI00igOWLdplzHaxMV7Kb2u8vJjwf9ZehfQvj9gWubTNBsvslS
   A4sHWSmAMNnwj9Axy/4x1lANMO/XI7bfPpMsRD9xppZBmBO5tQpcY0ENh
   hpwduho2srREeZFgT3UgS+XgoP2a5PcU8PW8NpWe7YdzcjfqdLmjYeOnF
   eqLTvL5X6gyPGXeg0IsACMxEAxUr5kskIWfTskP82iaNebx2fQ79PzeSP
   ep3sNzjuTa4NFFjzyHSkFWxTt8ZLKlOy7iRJLijGkLbwnFOqAjxYMEiR1
   TIjo15b7u9efpHbwdBFroY9zIPWnYaPCy01wd5DCq3bKsEjkaRUMxxmR4
   w==;
X-CSE-ConnectionGUID: t5VNgwlcTaenVrGak1/wTw==
X-CSE-MsgGUID: gLH7eQV6RnGAklQbP6bNBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50080685"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="50080685"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 05:24:08 -0700
X-CSE-ConnectionGUID: vPTXhtDoQMezQzTFOO6dpQ==
X-CSE-MsgGUID: rxbfBXteSbe4kcTj9+cTEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="163841604"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa002.fm.intel.com with ESMTP; 22 May 2025 05:24:05 -0700
Message-ID: <6bfee225-7519-41ab-8ae9-99267c5ce06e@intel.com>
Date: Thu, 22 May 2025 15:24:04 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Revert "usb: xhci: Implement
 xhci_handshake_check_state() helper"
To: Roy Luo <royluo@google.com>, Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Udipto Goswami <udipto.goswami@oss.qualcomm.com>,
 quic_ugoswami@quicinc.com, Thinh.Nguyen@synopsys.com,
 gregkh@linuxfoundation.org, michal.pecio@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250517043942.372315-1-royluo@google.com>
 <8f023425-3f9b-423c-9459-449d0835c608@linux.intel.com>
 <CAMTwNXB0QLP-b=RmLPtRJo=T_efN_3H4dd5AiMNYrJDXddJkMA@mail.gmail.com>
 <fbf92981-6601-4ee9-a494-718e322ac1b9@linux.intel.com>
 <CA+zupgyU2czaczPcqavYBi=NrPqKqgp7SbrUocy0qbJ0m9np6g@mail.gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@intel.com>
In-Reply-To: <CA+zupgyU2czaczPcqavYBi=NrPqKqgp7SbrUocy0qbJ0m9np6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.5.2025 5.21, Roy Luo wrote:
>>>> Udipto Goswami, can you recall the platforms that needed this workaroud?
>>>> and do we have an easy way to detect those?
>>>
>>> Hi Mathias,
>>>
>>>   From what I recall, we saw this issue coming up on our QCOM mobile
>>> platforms but it was not consistent. It was only reported in long runs
>>> i believe. The most recent instance when I pushed this patch was with
>>> platform SM8650, it was a watchdog timeout issue where xhci_reset() ->
>>> xhci_handshake() polling read timeout upon xhci remove. Unfortunately
>>> I was not able to simulate the scenario for more granular testing and
>>> had validated it with long hours stress testing.
>>> The callstack was like so:
>>>
>>> Full call stack on core6:
>>> -000|readl([X19] addr = 0xFFFFFFC03CC08020)
>>> -001|xhci_handshake(inline)
>>> -001|xhci_reset([X19] xhci = 0xFFFFFF8942052250, [X20] timeout_us = 10000000)
>>> -002|xhci_resume([X20] xhci = 0xFFFFFF8942052250, [?] hibernated = ?)
>>> -003|xhci_plat_runtime_resume([locdesc] dev = ?)
>>> -004|pm_generic_runtime_resume([locdesc] dev = ?)
>>> -005|__rpm_callback([X23] cb = 0xFFFFFFE3F09307D8, [X22] dev =
>>> 0xFFFFFF890F619C10)
>>> -006|rpm_callback(inline)
>>> -006|rpm_resume([X19] dev = 0xFFFFFF890F619C10,
>>> [NSD:0xFFFFFFC041453AD4] rpmflags = 4)
>>> -007|__pm_runtime_resume([X20] dev = 0xFFFFFF890F619C10, [X19] rpmflags = 4)
>>> -008|pm_runtime_get_sync(inline)
>>> -008|xhci_plat_remove([X20] dev = 0xFFFFFF890F619C00)
>>
>> Thank you for clarifying this.
>>
>> So patch avoids the long timeout by always cutting xhci reinit path short in
>> xhci_resume() if resume was caused by pm_runtime_get_sync() call in
>> xhci_plat_remove()
>>
>> void xhci_plat_remove(struct platform_device *dev)
>> {
>>          xhci->xhc_state |= XHCI_STATE_REMOVING;
>>          pm_runtime_get_sync(&dev->dev);
>>          ...
>> }
>>
>> I think we can revert this patch, and just make sure that we don't reset the
>> host in the reinit path of xhci_resume() if XHCI_STATE_REMOVING is set.
>> Just return immediately instead.
>>
> 
> Just to be sure, are you proposing that we skip xhci_reset() within
> the reinit path
> of xhci_resume()? If we do that, could that lead to issues with
> subsequent operations
> in the reinit sequence, such as xhci_init() or xhci_run()?

I suggest to only skip xhci_reset in xhci_resume() if XHCI_STATE_REMOVING is set.

This should be similar to what is going on already.

xhci_reset() currently returns -ENODEV if XHCI_STATE_REMOVING is set, unless reset
completes extremely fast. xhci_resume() bails out if xhci_reset() returns error:

xhci_resume()
   ...
   if (power_lost) {
     ...
     retval = xhci_reset(xhci, XHCI_RESET_LONG_USEC);
     spin_unlock_irq(&xhci->lock);
     if (retval)
       return retval;
> 
> Do you prefer to group the change to skip xhci_reset() within the
> reinit path together
> with this revert? or do you want it to be sent and reviewed separately?

First a patch that bails out from xhci_resume() if XHCI_STATE_REMOVING is set
and we are in the reinit (power_lost) path about to call xhci_reset();

Then a second patch that reverts 6ccb83d6c497 ("usb: xhci: Implement
xhci_handshake_check_state()

Does this sound reasonable?

should avoid the QCOM 10sec watchdog issue as next xhci_rest() called
in xhci_remove() path has a short 250ms timeout, and ensure the
SNPS DWC3 USB regression won't trigger.

Thanks
Mathias


