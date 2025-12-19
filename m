Return-Path: <stable+bounces-203080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BB9CCFCBD
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 13:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DC5B30F017A
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 12:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC1E33C1AC;
	Fri, 19 Dec 2025 11:48:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50A633BBBF;
	Fri, 19 Dec 2025 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766144921; cv=none; b=g8jARNYaOFw18Fpx8UyYZMer1enrHblPRZiT00xA3ZI7wQ/kVYNOkgvfeQESsapS4tvTJ9gXcIi+yzOvKKp306YRerMQgMRTq/Iwe/ELxg5a9luRMVH90y3ZociRXRCwup016Ub0AlEVaZSqzQdvAu9XXMHWu1CURj3rZ0txB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766144921; c=relaxed/simple;
	bh=fNlxxZB+b0V8l3H1HCT2COnETyD9EW24ZEq7VPh6Gek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCfn7a6aGqodmgYy5uDdMNSHx70cXI95owXZYQfqm44lLH3RKx/6TauWDTz12exMj8pPdbFprKMu4T3rp0DtktQ+bgndFUckayTwcQOkgeigRe1LgJ/marKiY/GvgtobGtNLeC9Ila3LsfBt27sMwnRGC+DG6A56jzuva7feeKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBF2DFEC;
	Fri, 19 Dec 2025 03:48:30 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7931C3F73F;
	Fri, 19 Dec 2025 03:48:36 -0800 (PST)
Message-ID: <5a967265-b527-4ca0-bf63-f5f7cf9013a3@arm.com>
Date: Fri, 19 Dec 2025 11:48:35 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] coresight: etm-perf: Fix reference count leak
 in etm_setup_aux
To: Leo Yan <leo.yan@arm.com>
Cc: Ma Ke <make24@iscas.ac.cn>, jie.gan@oss.qualcomm.com,
 james.clark@linaro.org, akpm@linux-foundation.org,
 alexander.shishkin@linux.intel.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mathieu.poirier@linaro.org, mike.leach@linaro.org, stable@vger.kernel.org
References: <f85c7d37-4980-46f0-9136-353a35a8f0ed@oss.qualcomm.com>
 <20251219023949.12699-1-make24@iscas.ac.cn>
 <20251219094141.GA9788@e132581.arm.com>
 <d4946831-fc8c-4727-abec-3edd92e357d1@arm.com>
 <20251219113803.GC9788@e132581.arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20251219113803.GC9788@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/12/2025 11:38, Leo Yan wrote:
> On Fri, Dec 19, 2025 at 09:59:54AM +0000, Suzuki K Poulose wrote:
> 
> [...]
> 
>>> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
>>> index 0db64c5f4995..2b34f818ba88 100644
>>> --- a/drivers/hwtracing/coresight/coresight-platform.c
>>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
>>> @@ -107,14 +107,16 @@ coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
>>>    	 * platform bus.
>>>    	 */
>>>    	dev = bus_find_device_by_fwnode(&platform_bus_type, fwnode);
>>> -	if (dev)
>>> -		return dev;
>>>    	/*
>>>    	 * We have a configurable component - circle through the AMBA bus
>>>    	 * looking for the device that matches the endpoint node.
>>>    	 */
>>> -	return bus_find_device_by_fwnode(&amba_bustype, fwnode);
>>> +	if (!dev)
>>> +		dev = bus_find_device_by_fwnode(&amba_bustype, fwnode);
>>> +
>>> +	put_device(dev);
>>
>> ^^ NAK, see below.
>>
>>> +	return dev;
>>>    }
>>>    /*
>>> @@ -274,7 +276,6 @@ static int of_coresight_parse_endpoint(struct device *dev,
>>>    	of_node_put(rparent);
>>>    	of_node_put(rep);
>>> -	put_device(rdev);
>>
>> This doesn't look good. We can't use the "dev" reliably without the
>> reference count. We are opening up use-after-free.
> 
> My understanding is we don't grab a device from
> coresight_find_device_by_fwnode().  The callers only check whether the
> device is present on the bus; if it isn't, the driver defers probe.
> 
> This is similiar to coresight_find_csdev_by_fwnode(), which calls
> put_device(dev) to release refcnt immediately.  This is why I
> suggested the change, so the two functions behave consistently.
> 

I see, sorry. I saw some other uses of the device, but clearly I was 
wrong. May be we should simply re-structure the function to :

bool coresight_fwnode_device_present(fwnode)
{

	// find and drop the ref if required.
	return true/false;
}

The name "find_device_by_fwnode" and returning a freed reference doesn't
look good to me.

Suzuki

> Thanks,
> Leo


