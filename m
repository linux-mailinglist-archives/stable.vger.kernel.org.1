Return-Path: <stable+bounces-213248-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEkgHO0CgmmYNgMAu9opvQ
	(envelope-from <stable+bounces-213248-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:15:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB598DA723
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC47B307F041
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 14:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4EC3A6401;
	Tue,  3 Feb 2026 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQeSLRNV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D4C39E6EF;
	Tue,  3 Feb 2026 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128047; cv=none; b=aWetZ5Qvqj5eZnCRV/ICPZCscGxF5ARB3GLR/IZ9OnObYkHCrVPjzuRarNOLLd42mdGjuxtswcs2VQpj/wqES7bkXRxD69OBuenQaLtEkoSo+fBFrAbKH0q2qplq29w4CtWBZ/Uv/3U4sYdBJWw3tHRs9KVOnvcOK6HSe93QenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128047; c=relaxed/simple;
	bh=ChkTyTfsD+ScNh6I/AtsTfCR/K8111Ia2tOeHs92giY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmNJ7kRaMdfJlnIgl0UagnV+xZg+Ie+zknhQUNnhnCc/Ug2jLiGffX5VCQBLRTioe2UJ9fyjatOjOsvbjmJ+hEN05LLCWTZp3kMlnHbUHE3c3Y3DqMfI2cmxQnog6dV132uxez8Qu045Yv7eUi5iAb7V9L081Pb2yhWiftDdN5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQeSLRNV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770128046; x=1801664046;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ChkTyTfsD+ScNh6I/AtsTfCR/K8111Ia2tOeHs92giY=;
  b=RQeSLRNVrXBj03CPhCMZlXbJyjJoS9u33E4PJU1t2Wy7T1fidUJnQ0gX
   VDrlE31J4lnPvlWYvRPI2pQoZWNBrng5rigukMMhDZtO2LDkXiewBHHOp
   u7/qD1y/56zQCJXKh6dQ1qYPfc+a7CwruTPJ+1Ugvj5IECyEuymOLtdvx
   r44Bl86oSIm91WM5xYvTu80HQ5/Liby1KUUHCC+SjMSbCzqlGaX8SWZdE
   i89gXZrPhSz+jdiRDR2aq35EJ8gmb4VQNTESnhEt+LNyVMfh94o8Bov0F
   jfXfkWusHBlNPjRR9n05aEDFu/wTb2Bs4gBbcZNNtdotExTWtg7R4qvwU
   w==;
X-CSE-ConnectionGUID: i/P3F8A/SPGPyGaQTTJpBg==
X-CSE-MsgGUID: 5JQKvfBJQmuUe1ef9+oaHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="82724742"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="82724742"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 06:14:06 -0800
X-CSE-ConnectionGUID: BTV6ynkiSb2wZkbGjJ+KfA==
X-CSE-MsgGUID: tC6EnTifSSGWaVf+0v289g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209651425"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO [10.245.245.85]) ([10.245.245.85])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 06:14:03 -0800
Message-ID: <6acaaae2-4e93-46f5-8170-277bc369f922@linux.intel.com>
Date: Tue, 3 Feb 2026 16:14:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] usb: host: xhci-sideband: fix deadlock in unregister
 path
To: Guan-Yu Lin <guanyulin@google.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@intel.com, stern@rowland.harvard.edu,
 wesley.cheng@oss.qualcomm.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260130074746.287750-1-guanyulin@google.com>
 <2026013133-tamale-massager-3c76@gregkh>
 <CAOuDEK0o2jqqOUZVUdi9JDcyXRQHEuL9GCBrU0VQhWAfDtJnUg@mail.gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <CAOuDEK0o2jqqOUZVUdi9JDcyXRQHEuL9GCBrU0VQhWAfDtJnUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213248-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathias.nyman@linux.intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linux.intel.com:mid]
X-Rspamd-Queue-Id: EB598DA723
X-Rspamd-Action: no action

On 2/2/26 12:03, Guan-Yu Lin wrote:
> On Sat, Jan 31, 2026 at 8:15 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Fri, Jan 30, 2026 at 07:47:46AM +0000, Guan-Yu Lin wrote:
>>> When a USB device is disconnected or a driver is unbound, the USB core
>>> invokes the driver's disconnect callback while holding the udev device
>>> lock. If the driver calls xhci_sideband_unregister(), it eventually
>>> reaches usb_offload_put(), which attempts to acquire the same udev
>>> lock, resulting in a self-deadlock.
>>>
>>> Introduce lockless variants __usb_offload_get() and __usb_offload_put()
>>> to allow modifying the offload usage count when the device lock is
>>> already held. These helpers use device_lock_assert() to ensure callers
>>> meet the locking requirements.
>>
>> Ugh.  Didn't I warn about this when the original functions were added?
>>
>> Adding functions with __ is a mess, please make these names, if you
>> _REALLY_ need them, obvious that this is a no lock function.
>>
>> And now that you added the lockless functions, are there any in-kernel
>> users of the locked versions?  At a quick glance I didn't see them, did
>> I miss it somewhere?
>>
>> thanks,
>>
>> greg k-h
> 
> Hi Greg,
> 
> You are right; xhci-sideband.c is the only in-kernel user of the
> locked versions. I will rename the __ functions to usb_offload_* and
> remove the locked variants in the next version to clean up the API.
> 
> Regarding the deadlock fix itself, we have analyzed two potential
> solutions. The core issue is that xhci_sideband_unregister() (and
> xhci_sideband_remove_interrupter()) needs to decrement the offload
> usage count (which requires the USB device lock), but it is called
> from the disconnect path where that lock is already held.
> 
> Option A: Fix the Callers of xhci_sideband functions
> In this approach, we keep the usb_offload calls inside the
> xhci_sideband functions but replace the internal usb_lock_device()
> with device_lock_assert(). We then update callers in
> qc_audio_offload.c to explicitly acquire the lock.
> This ensures the offload count remains tightly coupled with the
> interrupter's lifecycle, though it effectively changes the API
> contract: calling xHCI sideband functions now requires holding the USB
> device lock.
> 
> Option B: Decouple usb_offload functions from xhci_sideband functions
> In this approach, we strip the usb_offload calls out of xhci_sideband
> functions entirely. The client driver (qc_audio_offload) becomes
> responsible for the full transaction: acquiring the lock, managing
> usb_offload_get/put(), and creating/removing the interrupter. This
> restores clean encapsulation (xHCI functions only handle hardware),
> but it places the burden on the client driver to correctly balance the
> usb_offload calls.
> 
> I lean towards Option A to ensure the offload count implies an active
> interrupter by design, but please let me know if you prefer the
> cleaner separation of Option B.

I would prefer option B
Decouple the offload from sideband.

The secondary interrupter in sideband was specifically createad for
qc_audio_offload.

Vendors using the xHCI hardware Audio sideband Capability (xHCI 7.9)
won't use a secondary interrupter, but might sill want to prevent suspending
the device. So it shuold be better to make this decision in the class driver.

The offload count shoudn't be that complicated. Isn't it binary at the moment?
We don't allow more than one sideband per device, and it can only have one
interrupter.

I unfortunately couldn't participate in the review and development of
drivers/usb/core/offload.c, but my original idea before it was implemented
was to keep usb core out of sideband as much as possible as its not really
a part of usb specification.

This is also why I added the sideband pointer to struct xhci_virt_device.
It allows us to figure out if a device is dedicated for sideband use.

so xhci_sideband_check() could be something like

bool xhci_sideband_check(struct xhci_hcd *xhci)
{
	guard(spinlock_irqsave)(&xhci->lock);

	for (int i = 1; i < HC_MAX_SLOTS; i++) {
	if (xhci->devs[i] && xhci->devs[i]->sideband)
		return true;
	}
	return false;
}

Thanks
Mathias

