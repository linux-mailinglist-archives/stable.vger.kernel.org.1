Return-Path: <stable+bounces-203059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9BBCCF425
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 11:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F16793062E7F
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 10:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EA82F9C39;
	Fri, 19 Dec 2025 09:59:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACD22F7AB1;
	Fri, 19 Dec 2025 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766138398; cv=none; b=NHTG7/gZ8h99Kt3dyuXsABpJmF4m/CfDcaDJSz1WXgCHdmjq/13yKsmnJZ62c03ONVghtyLb1hokJR+7GgOwVHfNQ0qqlF39aZ2dUIC1NxrRgvG9pPublzR22jriD8a7x7I8tr0QIvIM5dt0/vIB/UBuKwFwN6Bdc0azzk9/JPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766138398; c=relaxed/simple;
	bh=uKxza8j1CDrl0MlELBfMnQ4t5ylRkrZGQi6TR3Tardw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fyTUD0FcRcfae6SSbhtOExP1e0e89Go2u3p8wLgZo91/qVE1RtvX9fzEngNigRRdU4gmnccrI+RxXdIKD5Ngb2VQC/1XXCYobZV31t4Omn142lebqGJsBLqdcj/+PYsPQV08uZQgK9cr++aUSBV9kv8yMWBwIojiwrTZ6dF2MU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8876DFEC;
	Fri, 19 Dec 2025 01:59:49 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E7EB3F5CA;
	Fri, 19 Dec 2025 01:59:55 -0800 (PST)
Message-ID: <d4946831-fc8c-4727-abec-3edd92e357d1@arm.com>
Date: Fri, 19 Dec 2025 09:59:54 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] coresight: etm-perf: Fix reference count leak
 in etm_setup_aux
To: Leo Yan <leo.yan@arm.com>, Ma Ke <make24@iscas.ac.cn>
Cc: jie.gan@oss.qualcomm.com, james.clark@linaro.org,
 akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
 mike.leach@linaro.org, stable@vger.kernel.org
References: <f85c7d37-4980-46f0-9136-353a35a8f0ed@oss.qualcomm.com>
 <20251219023949.12699-1-make24@iscas.ac.cn>
 <20251219094141.GA9788@e132581.arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20251219094141.GA9788@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/12/2025 09:41, Leo Yan wrote:
> Hi,
> 
> On Fri, Dec 19, 2025 at 10:39:49AM +0800, Ma Ke wrote:
> 
> [...]
> 
>>  From the discussion, I note two possible fix directions:
>>
>> 1. Release the initial reference in etm_setup_aux() (current v2 patch)
>> 2. Modify the behavior of coresight_get_sink_by_id() itself so it
>> doesn't increase the reference count.
> 
> The option 2 is the right way to go.
> 
>> To ensure the correctness of the v3 patch, I'd like to confirm which
>> patch is preferred. If option 2 is the consensus, I'm happy to modify
>> the implementation of coresight_get_sink_by_id() as suggested.
> 
> It is good to use a separate patch to fix
> coresight_find_device_by_fwnode() mentioned by James:
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 0db64c5f4995..2b34f818ba88 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -107,14 +107,16 @@ coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
>   	 * platform bus.
>   	 */
>   	dev = bus_find_device_by_fwnode(&platform_bus_type, fwnode);
> -	if (dev)
> -		return dev;
>   
>   	/*
>   	 * We have a configurable component - circle through the AMBA bus
>   	 * looking for the device that matches the endpoint node.
>   	 */
> -	return bus_find_device_by_fwnode(&amba_bustype, fwnode);
> +	if (!dev)
> +		dev = bus_find_device_by_fwnode(&amba_bustype, fwnode);
> +
> +	put_device(dev);

^^ NAK, see below.

> +	return dev;
>   }
>   
>   /*
> @@ -274,7 +276,6 @@ static int of_coresight_parse_endpoint(struct device *dev,
>   
>   	of_node_put(rparent);
>   	of_node_put(rep);
> -	put_device(rdev);

This doesn't look good. We can't use the "dev" reliably without the 
reference count. We are opening up use-after-free.

NAK for this.

Suzuki

>   
>   	return ret;
>   }
> 
> Thanks for working on this.


