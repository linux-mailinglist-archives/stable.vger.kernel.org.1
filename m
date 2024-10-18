Return-Path: <stable+bounces-86807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C909A3AAB
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 11:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B80289680
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 09:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1308A200CB1;
	Fri, 18 Oct 2024 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHpz/Owd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257B9201001;
	Fri, 18 Oct 2024 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245537; cv=none; b=mJzCEpTvzRQ6eP0H9fBGRW7/6RKbiqUdXjTKzq0qppYf1/9gXQAwjXVwiH1bf4g1cwzujWFPkDpQqPrwoFh8W0HMs338XjACTfw8kdQw6zMuKKiV6D4WbTOcdMUMvAKRt9X8k3xVK1E4dmOSMvCQ20BoHVRy9gfDMa2wcNRFLy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245537; c=relaxed/simple;
	bh=QocDQEkDbOeRe7oxzKER+TAS7g0oyVxoxpoy6EMUxfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CENz6nmUYDan/TR+GdHpDeEDnny+ewKyQJc05AeT+zUE4oPfMNFyT1hmQTG2bUE6UT+649v3S/H52IDYoyGWpoAENM3j1IWboww52BhGBXSiT8jc62PcZUeICygAOAxeG+bleA3ir0mcgn/RfmZFPbH5pv0kq4gJeFBoKTZLrCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHpz/Owd; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729245537; x=1760781537;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QocDQEkDbOeRe7oxzKER+TAS7g0oyVxoxpoy6EMUxfk=;
  b=UHpz/Owd5mSnDJjOEBgwN+A5mIIauE5hpILlAiHi3RrkHo5Gz+iOagvs
   VovQxAhzhfHuOXOm1xhacpVE4JeblLDxzeFdaz4yE4jIqLEBNjNraVjN5
   B2AiPH1KCIp8diCU8l0NphbuLwDhaPwF9TP1zpNSKBmm6rG9uUaoBkAqr
   FhmsxZy6vJe5LxaDs4ThlKp1BfskJggu4mmemSITxdOhrEqob2p5HlNXh
   I7iz44HjuE8WwX8lAjq+VNiQGCO94T6293A8jm7y/pAN7egQrhJIYSI5M
   Mibl9NP/xbvkiL9y05C49zqYnzCESv8TOwR5oyuV0PzCrc5I2F0/6ix1Y
   Q==;
X-CSE-ConnectionGUID: sirEz1AuQByJpQqwEVUosg==
X-CSE-MsgGUID: na+rgOUySLqP5GSD51ybqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28862950"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="28862950"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 02:57:06 -0700
X-CSE-ConnectionGUID: buxrekH4TF2FcDsibYBfWw==
X-CSE-MsgGUID: Nje6VC/eTGiUxFz3cvVSUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="109641627"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa002.jf.intel.com with ESMTP; 18 Oct 2024 02:57:04 -0700
Message-ID: <50e69123-a38e-4e0f-a166-8756a18033ba@linux.intel.com>
Date: Fri, 18 Oct 2024 12:59:15 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] xhci: Mitigate failed set dequeue pointer commands
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 stable@vger.kernel.org, Marc SCHAEFER <schaefer@alphanet.ch>
References: <20241017084007.53d3fedd@foxbook>
 <3a22e31a-12bc-4fdc-90d2-e09a7f9d067f@linux.intel.com>
 <20241017181447.7c712c4b@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20241017181447.7c712c4b@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.10.2024 19.14, Michał Pecio wrote:
> On Thu, 17 Oct 2024 16:10:39 +0300, Mathias Nyman wrote:
>>> Hmm, wouldn't a long and partially cached TD basically become
>>> corrupted by this overwrite?
>>
>> Unlikely but not impossible.
>> We already turn all cancelled TDs that we don't stop on into no-ops,
>> so those would already now experience the same problem.
> 
> No, I think they wouldn't. Note in xHCI 1.2, 4.6.9, on page 135 states
> clearly that xHC shall invalidate cached TRBs besides the current TD.
> 
> Same page, point 3, mentions that software "may not modify" the current
> TD, whatever on earth is that supposed to mean. Unfortunately, I can't
> find a clear "shall not" in 4.6.9, but I would see it as such.
> 

Ok, I think we are talking about two different things here.

Point 3 you mentioned is about modifying TDs on the ring, and then continue.
And you are right, xHC should in this case invalidate all future TDs, but
not the current one it stopped on.

I'm talking about point 2, about aborting the current TD where we know
we are queuing a "Set TR Deq" command. Same section states that
Set TD Deq may be used to force xHC to dump any internal state it has for
the ring.

>> We stopped the endpoint, and issued a 'Set TR deq' command which is
>> supposed to clear xHC TRB cache.  I find it hard to believe xHC would
>> continue by caching some select TRBs of a TD to cache.
> 
> The idea is, if Set TR Deq fails, the xHC preserves transfer state and
> cache and tries to continue. If the TD wasn't fully cached when the xHC
> stopped, it remains incomplete. Missing TRBs will be filled with No Ops
> when it restarts, yielding an ivalid TD (e.g. No Op chained at the end).
> 
> So it may turn out that instead of "EP TRB ptr not part of current TD"
> something else would show up, perhaps TRB Errors.

If this is how xHC behaves on failed Set TR Deq commands, then yes,
TRB errors are possible.

But if xHC does clear TD cache on failed Set TR Deq command then it's
smooth sailing.

If we don't turn the TD to no-op then xHC is more likely to write to
freed DMA address in both cases above, which I think is worse.

> 
>> But lets say we end up corrupting the TD. It might still be better
>> than allowing xHC to process the TRBs and write to DMA addresses that
>> might be freed/reused already.
> 
> There is some truth to that, I guess. It's bummer that those bugs are
> here in the first place and no one seems to know where they come from.
> 
> 
> Was this tested on HW? I suppose it wouldn't be hard to corrupt a Set
> TR Deq command to make it fail, stream 0xffff or something like that.
> It may be harder to come up with a realistic test case with long TDs.

Unfortunately no, this patch is an attempt to mitigate the issue seen in
"Strange issues with USB device" [1]. That discussion continued off-list
with a lot more testing and debugging, but I ran out of testing goodwill
before I came up with this partial solution.

1. https://lore.kernel.org/linux-usb/ZsjgmCjHdzck9UKd@alphanet.ch/

Thanks
Mathias

