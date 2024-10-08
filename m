Return-Path: <stable+bounces-81556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96809944F1
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98141C21631
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 09:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4DB18CBF1;
	Tue,  8 Oct 2024 09:59:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B99716EB42;
	Tue,  8 Oct 2024 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381579; cv=none; b=D4OuKy46e8oXtrImWUqWkvIvGE8Exd7TsJ5Xrxl9aVotw1Dg3dbcpGi/HX7oIEBG8ObvwkanYbsIyEtXCqOmQPZ57gYCiUIsbi0sH8SgOzselInOwMbguODcWjp2u1SifCppjI4WF5PKvGoGAVR93c4buJxPadYCS6z6vg39WS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381579; c=relaxed/simple;
	bh=WQyaXbocJhLew6nNB7zdESM6j9aXbn9MwJAi7hKZcd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EL9Iepzpy3OW0EVJbzbiD21FnwvjApRg9iaNryZUg3rWWM5Ly5v0NUJ6fMJbBmzbBckE/gKX5mMwuudzXN8960l/2k60oBycGNEExWS/2yv7VgxFKQq4oqyFhlwuphXmx4GyyfLLizoTsN1YcMdkOw6/MW9MLwlxVC8RTVxc7lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A372DA7;
	Tue,  8 Oct 2024 03:00:06 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ADDD3F640;
	Tue,  8 Oct 2024 02:59:35 -0700 (PDT)
Message-ID: <c519631b-e02f-438c-a61f-68fa97583668@arm.com>
Date: Tue, 8 Oct 2024 10:59:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: etm4x: Fix PID tracing when perf is run in an
 init PID namespace
To: Leo Yan <leo.yan@arm.com>, Leo Yan <leo.yan@linux.dev>,
 Julien Meunier <julien.meunier@nokia.com>
Cc: Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 stable@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240925131357.9468-1-julien.meunier@nokia.com>
 <20241007200528.GB30834@debian-dev>
 <93e822b1-76d1-454b-a42f-adf9292d4da6@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <93e822b1-76d1-454b-a42f-adf9292d4da6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/10/2024 07:52, Leo Yan wrote:
> On 10/7/2024 9:05 PM, Leo Yan wrote:
>>
>> Hi Julien,
>>
>> On Wed, Sep 25, 2024 at 03:13:56PM +0200, Julien Meunier wrote:
>>> The previous implementation limited the tracing capabilities when perf
>>> was run in the init PID namespace, making it impossible to trace
>>> applications in non-init PID namespaces.
>>>
>>> This update improves the tracing process by verifying the event owner.
>>> This allows us to determine whether the user has the necessary
>>> permissions to trace the application.
>>
>> The original commit aab473867fed is not for constraint permission. It is
>> about PID namespace mismatching issue.
>>
>> E.g. Perf runs in non-root namespace, thus it records process info in the
>> non-root PID namespace. On the other hand, Arm CoreSight traces PID for
>> root namespace, as a result, it will lead mess when decoding.
>>
>> With this change, I am not convinced that Arm CoreSight can trace PID for
>> non-root PID namespace. Seems to me, the concerned issue is still existed
>> - it might cause PID mismatching issue between hardware trace data and
>> Perf's process info.
> 
> I thought again and found I was wrong with above conclusion. This patch is a
> good fixing for the perf running in root namespace to profile programs in
> non-root namespace. Sorry for noise.
> 
> Maybe it is good to improve a bit comments to avoid confusion. See below.
> 
> [...]
> 
>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>> index bf01f01964cf..8365307b1aec 100644
>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>> @@ -695,7 +695,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>>>
>>>        /* Only trace contextID when runs in root PID namespace */
> 
> We can claim the requirement for the *tool* running in root PID namespae.
> 
>    /* Only trace contextID when the tool runs in root PID namespace */

minor nit: I wouldn't call "tool". Let keep it "event owner".

	/* Only trace contextID when the event owner is in root PID namespace */


Julien,

Please could you respin the patch with the comments addressed.

Kind regards
Suzuki


> 
> 
>>>        if ((attr->config & BIT(ETM_OPT_CTXTID)) &&
>>> -         task_is_in_init_pid_ns(current))
>>> +         task_is_in_init_pid_ns(event->owner))
>>>                /* bit[6], Context ID tracing bit */
>>>                config->cfg |= TRCCONFIGR_CID;
>>>
>>> @@ -710,7 +710,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>>>                        goto out;
>>>                }
>>>                /* Only trace virtual contextID when runs in root PID namespace */
> 
> Ditto.
> 
>    /* Only trace virtual contextID when the tool runs in root PID namespace */
> 
> With above change:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> 
>>> -             if (task_is_in_init_pid_ns(current))
>>> +             if (task_is_in_init_pid_ns(event->owner))
>>>                        config->cfg |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;
>>>        }
>>>
>>> --
>>> 2.34.1
>>>
>>>


