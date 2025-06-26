Return-Path: <stable+bounces-158688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 354D8AE9D52
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 14:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F9A176692
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 12:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA01F1E9B04;
	Thu, 26 Jun 2025 12:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUF3Sbwk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0782F1FE4;
	Thu, 26 Jun 2025 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750940314; cv=none; b=CbbBbYRMHYUbteGymtna7UFwzp7uLWSme7WK2kK93890nBYE2EqtD/o6eTK3APF6KWmTojBMu6t7tcYMXxsklkNHRmaMwN+E+5Vx8nBpoxV2Pu0IFQB2H+31glldxB+Xfx/Y4mzT8j5WY/fc0gPiclITQLUVMEGTgPLC54PAbL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750940314; c=relaxed/simple;
	bh=+854DTGaHzmD59BJyv6qjtpIdJD3yUDSZS1gxAQBm/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAJdwhsbsNC6dKu9NJczHi9DJ91AzWD93yDUROHru+0KWC3LqzcN9QgOaIaiXj3o7l75XgxYhF0c+E4X72xw57HInfWtxz9DDYDq6Es1d77LVSK9FBn78IqMJLZFy35hmgDQ8vkRjnNLLQcRB2TsIl4pjI5oAyNtmsEw/KuUscM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUF3Sbwk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750940312; x=1782476312;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+854DTGaHzmD59BJyv6qjtpIdJD3yUDSZS1gxAQBm/c=;
  b=kUF3Sbwk9p7baJMqUAwJLw7siiWQx7BO06yA/fHGLp7rFpYddus+SPrb
   hP8fmei+uAzwoMvMgRKo12IKEHBoqIdgKMdsboprOut62oMHG/hh3e62r
   Ktpn5NWD6S0N5uQ4bHQ3cP8poTITNWFBJAxplykBsXJR/BlSxjHKLvve4
   QMhbUXupFmVyDxMYzsbbLHHcphQUXrqUWw91l167nyYwYOkh6Hkkxz6OZ
   XXS6utHWz3UBilhSOB9U+qgNeV5UYti3MzYue0xLOsZ9wqeWlVKHgCw8i
   Ib4d2t6gkrFn59uugLOZg6JwmKPTqPCaFG9DWEALOuRvuBiGXeBYhVo1Q
   w==;
X-CSE-ConnectionGUID: pOqoong9QZ6LgRIg76YMlQ==
X-CSE-MsgGUID: VA+3JIpYRcyZmCO4tKA+sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="63490664"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="63490664"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 05:18:32 -0700
X-CSE-ConnectionGUID: GzcCIKJTR0yVvCIf4G1a3Q==
X-CSE-MsgGUID: XVbnHSYlR0OmT+Oq6AFwSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="158256996"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa005.jf.intel.com with ESMTP; 26 Jun 2025 05:18:30 -0700
Message-ID: <85c7024d-69e0-4297-9a02-3afa2d2861f7@linux.intel.com>
Date: Thu, 26 Jun 2025 15:18:29 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: hub: fix detection of high tier USB3 devices
 behind suspended hubs
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu, oneukum@suse.com,
 stable@vger.kernel.org, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
References: <20250611112441.2267883-1-mathias.nyman@linux.intel.com>
 <acaaa928-832c-48ca-b0ea-d202d5cd3d6c@oss.qualcomm.com>
 <c8ea2d32-4e8e-49da-9d75-000d34f8e819@linux.intel.com>
 <67d4d34a-a15f-47b1-9238-d4d6792b89e5@oss.qualcomm.com>
 <c9584bc8-bb9f-41f9-af3c-b606b4e4ee06@linux.intel.com>
 <842ed535-ed0f-43d6-9b69-b5f9aeb853d2@oss.qualcomm.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <842ed535-ed0f-43d6-9b69-b5f9aeb853d2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.6.2025 18.41, Konrad Dybcio wrote:
> On 6/25/25 5:11 PM, Mathias Nyman wrote:
>> On 24.6.2025 19.40, Konrad Dybcio wrote:
>>> On 6/24/25 11:47 AM, Mathias Nyman wrote:
>>>> On 23.6.2025 23.31, Konrad Dybcio wrote:
>>>>> On 6/11/25 1:24 PM, Mathias Nyman wrote:
> 
> [...]
> 
>> I added some memory debugging but wasn't able to trigger this.
>>
>> Does this oneliner help? It's a shot in the dark.
>>
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index d41a6c239953..1cc853c428fc 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -1418,6 +1418,7 @@ static void hub_quiesce(struct usb_hub *hub, enum hub_quiescing_type type)
>>   
>>      /* Stop hub_wq and related activity */
>>      timer_delete_sync(&hub->irq_urb_retry);
>> +    flush_delayed_work(&hub->init_work);
>>      usb_kill_urb(hub->urb);
>>      if (hub->has_indicators)
>>          cancel_delayed_work_sync(&hub->leds);
> 
> I can't seem to trigger the bug anymore with this (and Alan's change)!

Thanks for testing

I'll send a proper patch that does these changes

-Mathias



