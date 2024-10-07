Return-Path: <stable+bounces-81289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF29992BE1
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 14:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64801C21F43
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 12:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F9E1D1F5B;
	Mon,  7 Oct 2024 12:38:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02D11E519;
	Mon,  7 Oct 2024 12:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304700; cv=none; b=fZY7ZPZb2deZkBPKASmaKT5i5YaA4IhoP21ODmIR208r+S0eD0xrFcV6XZfZayujZSwpsKwd25S0SEoXwwt7oywVUikPxg3lO5YY6/CTM3mlCXIZs1+qCBsjHvIIeptZ0s6ChsUIFIemJ+BFnWkMJ/5DWuA2uwOOhMubdURIywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304700; c=relaxed/simple;
	bh=Pipla4zbD9cgP8JFbE4AulSgCDTywrUPj6678G3JbRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMPqHbjQ22RvMoruFkO5F8gKWomdBTNJqkBL22ibmJW3yqhiCRnNR0Q99BF3eqw/RK+KlBX7v28ga2IbsxhC6g8lcYFGOtkIoOTcuXPQ5W4kAgsQCSq+oV7IWfvbmciAWaC5kpv9n5Qc3zTpbG9nBtQOOFenYi/tSao7I2e+b5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5C3CFEC;
	Mon,  7 Oct 2024 05:38:46 -0700 (PDT)
Received: from [10.96.9.194] (PW05HE0L.arm.com [10.96.9.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 451173F640;
	Mon,  7 Oct 2024 05:38:14 -0700 (PDT)
Message-ID: <db5634c4-a851-44c2-843c-6c6d1f78cbe3@arm.com>
Date: Mon, 7 Oct 2024 13:38:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: etm4x: Fix PID tracing when perf is run in an
 init PID namespace
Content-Language: en-GB
To: Julien Meunier <julien.meunier@nokia.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Leo Yan <leo.yan@linux.dev>
Cc: stable@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240925131357.9468-1-julien.meunier@nokia.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240925131357.9468-1-julien.meunier@nokia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/09/2024 14:13, Julien Meunier wrote:
> The previous implementation limited the tracing capabilities when perf
> was run in the init PID namespace, making it impossible to trace
> applications in non-init PID namespaces.
> 
> This update improves the tracing process by verifying the event owner.
> This allows us to determine whether the user has the necessary
> permissions to trace the application.
> 
> Cc: stable@vger.kernel.org
> Fixes: aab473867fed ("coresight: etm4x: Don't trace PID for non-root PID namespace")
> Signed-off-by: Julien Meunier <julien.meunier@nokia.com>

Thanks for the fix, I will queue this for v6.13

Suzuki


> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index bf01f01964cf..8365307b1aec 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -695,7 +695,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   
>   	/* Only trace contextID when runs in root PID namespace */
>   	if ((attr->config & BIT(ETM_OPT_CTXTID)) &&
> -	    task_is_in_init_pid_ns(current))
> +	    task_is_in_init_pid_ns(event->owner))
>   		/* bit[6], Context ID tracing bit */
>   		config->cfg |= TRCCONFIGR_CID;
>   
> @@ -710,7 +710,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   			goto out;
>   		}
>   		/* Only trace virtual contextID when runs in root PID namespace */
> -		if (task_is_in_init_pid_ns(current))
> +		if (task_is_in_init_pid_ns(event->owner))
>   			config->cfg |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;
>   	}
>   


