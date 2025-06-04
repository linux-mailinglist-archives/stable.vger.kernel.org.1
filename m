Return-Path: <stable+bounces-151422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF00ACE010
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 16:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3786B7A7266
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824A428F504;
	Wed,  4 Jun 2025 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DO5iJMat"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD3870810;
	Wed,  4 Jun 2025 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046640; cv=none; b=GhecgNakvgXcuAwiWLWbo+Qw0Blp3VtayZyrPO+x5Xor09f48AM26KKeBnYge3U5pysk7P7IeiWzQKhvFsfSFzA0PaZdrwxOMt/MPQ0XYquGufAgm8uCSJ1G8lM1Hm5mYI9duqkqkSOxFVLMcQTZ06qGWjk/2dRI5cGA278lG1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046640; c=relaxed/simple;
	bh=N3zAS7KbRmxSSWpgx3DYsurs4M4ohLgCBpXoeWFUkw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udv7KiIuiohS5PjCDNv39iJGo4T+rSmXHlVwoIqDLMDwVjXVTe2aErOZx9DbjIN4lKFARHQSLpfYzWViV1Iu+cFJlqD8Jj33HcLXNHRnGrRggF1Jbtc3/Hubtr/pOOr3ps6Ud8pfLNl9IcMduc7NKTTE/EJ27N36iu2jdkBhdIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DO5iJMat; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749046638; x=1780582638;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N3zAS7KbRmxSSWpgx3DYsurs4M4ohLgCBpXoeWFUkw0=;
  b=DO5iJMatiaPgo0B+pKqysW/ezQSUbW/50nyWb6orpugLeqrvpCWYO348
   EoXB5f2eqKw6WVfn+bHtqSi659XwvBHhVASD/TCxOEiXjrXPedgCJRkyd
   M7seKPOm7rEk8nz6pGTocx6o7uGZyWUYdxcLEHbqFWaYSvixk8qGPBfTz
   3fgI9vMnGN0aDt/53lYNrHDSboLw1xCV7bKYzmCBG6R1hXFbkJbLHlvq/
   bEBzqRT4sK25M04lJkQYlKcxm3NVUbfkg7TYMOJCPXR/MWjf57rFAgLTl
   1QO/FYXQdw7ePbSCzwpMUUWJ8ruaulP8Bj89fKkxK4MIbZ6iXK1y91MBc
   Q==;
X-CSE-ConnectionGUID: rWzHQ6hdT+uRNpUeFdz49g==
X-CSE-MsgGUID: fqTOauj6QgOI6NVqdudaeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="62489080"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="62489080"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 07:17:17 -0700
X-CSE-ConnectionGUID: zm8arlrJTxmzd+YMP9V39w==
X-CSE-MsgGUID: 231SeiXeTnuDl2uDP9aoOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="145169480"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa007.fm.intel.com with ESMTP; 04 Jun 2025 07:17:15 -0700
Message-ID: <459184db-6fc6-453b-933d-299f827bdc55@linux.intel.com>
Date: Wed, 4 Jun 2025 17:17:14 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] usb: xhci: Skip xhci_reset in xhci_resume if xhci
 is being removed
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
 Roy Luo <royluo@google.com>,
 "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "michal.pecio@gmail.com" <michal.pecio@gmail.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250522190912.457583-1-royluo@google.com>
 <20250522190912.457583-2-royluo@google.com>
 <20250523230633.u46zpptaoob5jcdk@synopsys.com>
 <b982ff0e-1ae8-429d-aa11-c3e81a9c14e5@linux.intel.com>
 <20250529011745.xkssevnj2u44dxqm@synopsys.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250529011745.xkssevnj2u44dxqm@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.5.2025 4.17, Thinh Nguyen wrote:
> On Mon, May 26, 2025, Mathias Nyman wrote:
>> On 24.5.2025 2.06, Thinh Nguyen wrote:
>>> Hi Mathias, Roy,
>>>
>>> On Thu, May 22, 2025, Roy Luo wrote:
>>>> xhci_reset() currently returns -ENODEV if XHCI_STATE_REMOVING is
>>>> set, without completing the xhci handshake, unless the reset completes
>>>> exceptionally quickly. This behavior causes a regression on Synopsys
>>>> DWC3 USB controllers with dual-role capabilities.
>>>>
>>>> Specifically, when a DWC3 controller exits host mode and removes xhci
>>>> while a reset is still in progress, and then attempts to configure its
>>>> hardware for device mode, the ongoing, incomplete reset leads to
>>>> critical register access issues. All register reads return zero, not
>>>> just within the xHCI register space (which might be expected during a
>>>> reset), but across the entire DWC3 IP block.
>>>>
>>>> This patch addresses the issue by preventing xhci_reset() from being
>>>> called in xhci_resume() and bailing out early in the reinit flow when
>>>> XHCI_STATE_REMOVING is set.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 6ccb83d6c497 ("usb: xhci: Implement xhci_handshake_check_state() helper")
>>>> Suggested-by: Mathias Nyman <mathias.nyman@intel.com>
>>>> Signed-off-by: Roy Luo <royluo@google.com>
>>>> ---
>>>>    drivers/usb/host/xhci.c | 5 ++++-
>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>>>> index 90eb491267b5..244b12eafd95 100644
>>>> --- a/drivers/usb/host/xhci.c
>>>> +++ b/drivers/usb/host/xhci.c
>>>> @@ -1084,7 +1084,10 @@ int xhci_resume(struct xhci_hcd *xhci, bool power_lost, bool is_auto_resume)
>>>>    		xhci_dbg(xhci, "Stop HCD\n");
>>>>    		xhci_halt(xhci);
>>>>    		xhci_zero_64b_regs(xhci);
>>>> -		retval = xhci_reset(xhci, XHCI_RESET_LONG_USEC);
>>>> +		if (xhci->xhc_state & XHCI_STATE_REMOVING)
>>>> +			retval = -ENODEV;
>>>> +		else
>>>> +			retval = xhci_reset(xhci, XHCI_RESET_LONG_USEC);
>>>
>>> How can this prevent the xhc_state from changing while in reset? There's
>>> no locking in xhci-plat.
>>
>> Patch 2/2, which is the revert of 6ccb83d6c497 prevents xhci_reset() from
>> aborting due to xhc_state flags change.
>>
>> This patch makes sure xHC is not reset twice if xhci is resuming due to
>> remove being called. (XHCI_STATE_REMOVING is set).
> 
> Wouldn't it still be possible for xhci to be removed in the middle of
> reset on resume? The watchdog may still timeout afterward if there's an
> issue with reset right?
> 

Probably yes, but that problem is the same if we only revert 6ccb83d6c497.

>> Why intentionally bring back the Qcom watchdog issue by only reverting
>> 6ccb83d6c497 ?. Can't we solve both in one go?
> 
> I feel that the fix is doesn't cover all the scenarios, that's why I
> suggest the revert for now and wait until the fix is properly tested
> before applying it to stable?

Ok, we have different views on this.

I think we should avoid causing as much known regression as possible even
if the patch  might not cover all scenarios.

By reverting 6ccb83d6c497 we fix a SNPS DWC3 regression, but at the same
time bring back the Qcom issue, so cause another regression.

We can avoid the main part or the Qcom regression by adding this patch as
issue is with (long) xhci reset during resume if xhci is being removed, and
driver always resumes xhci during ->remove callback.

If we discover the patch is not perfect then we fix it

Thanks
Mathias

