Return-Path: <stable+bounces-81521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92EE993F74
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 09:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3581C20953
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 07:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85701C2313;
	Tue,  8 Oct 2024 06:52:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F38416BE23;
	Tue,  8 Oct 2024 06:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370343; cv=none; b=csi2CGRHznyz7cQy0rWgX7eyymlMvmG/rmYBKjUO4xNPydW04+5fbfMPeX/P1yXKCW4Lp33zFnqhxXy20P8SoUgmEwlN81Ub3Zob5FCt4AfMIe295JdwOdnypOUpirWuAHlOhonI0cmY1M6Kiuea6epPYz8HG7BoIlCE5kV7Nr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370343; c=relaxed/simple;
	bh=eEOWzuvo/FmcAgVBISBrHFW39bZKpgtNl7Kg3g4iBqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqIERUUdgyqiyN+r2OCX2MAS/5DkCOKlwxJvns9Yss7/uvnzXkOLsCzdjKuVSxDjeqEkTpm07w7BbUp6E6tnEIy6Hp+sIi43jMzY9yFRtAQ5mkCAG0CwebjkwRxvkYg90dzmX50qQJz1687iuRbKAj5mCpUM0tkMC9zW/E3R1Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68BB8DA7;
	Mon,  7 Oct 2024 23:52:50 -0700 (PDT)
Received: from [10.57.21.241] (unknown [10.57.21.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0838A3F640;
	Mon,  7 Oct 2024 23:52:18 -0700 (PDT)
Message-ID: <93e822b1-76d1-454b-a42f-adf9292d4da6@arm.com>
Date: Tue, 8 Oct 2024 07:52:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: etm4x: Fix PID tracing when perf is run in an
 init PID namespace
To: Leo Yan <leo.yan@linux.dev>, Julien Meunier <julien.meunier@nokia.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 stable@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240925131357.9468-1-julien.meunier@nokia.com>
 <20241007200528.GB30834@debian-dev>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20241007200528.GB30834@debian-dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/2024 9:05 PM, Leo Yan wrote:
> 
> Hi Julien,
> 
> On Wed, Sep 25, 2024 at 03:13:56PM +0200, Julien Meunier wrote:
>> The previous implementation limited the tracing capabilities when perf
>> was run in the init PID namespace, making it impossible to trace
>> applications in non-init PID namespaces.
>>
>> This update improves the tracing process by verifying the event owner.
>> This allows us to determine whether the user has the necessary
>> permissions to trace the application.
> 
> The original commit aab473867fed is not for constraint permission. It is
> about PID namespace mismatching issue.
> 
> E.g. Perf runs in non-root namespace, thus it records process info in the
> non-root PID namespace. On the other hand, Arm CoreSight traces PID for
> root namespace, as a result, it will lead mess when decoding.
> 
> With this change, I am not convinced that Arm CoreSight can trace PID for
> non-root PID namespace. Seems to me, the concerned issue is still existed
> - it might cause PID mismatching issue between hardware trace data and
> Perf's process info.

I thought again and found I was wrong with above conclusion. This patch is a
good fixing for the perf running in root namespace to profile programs in
non-root namespace. Sorry for noise.

Maybe it is good to improve a bit comments to avoid confusion. See below.

[...]

>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index bf01f01964cf..8365307b1aec 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -695,7 +695,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>>
>>       /* Only trace contextID when runs in root PID namespace */

We can claim the requirement for the *tool* running in root PID namespae.

  /* Only trace contextID when the tool runs in root PID namespace */


>>       if ((attr->config & BIT(ETM_OPT_CTXTID)) &&
>> -         task_is_in_init_pid_ns(current))
>> +         task_is_in_init_pid_ns(event->owner))
>>               /* bit[6], Context ID tracing bit */
>>               config->cfg |= TRCCONFIGR_CID;
>>
>> @@ -710,7 +710,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>>                       goto out;
>>               }
>>               /* Only trace virtual contextID when runs in root PID namespace */

Ditto.

  /* Only trace virtual contextID when the tool runs in root PID namespace */

With above change:

Reviewed-by: Leo Yan <leo.yan@arm.com>

>> -             if (task_is_in_init_pid_ns(current))
>> +             if (task_is_in_init_pid_ns(event->owner))
>>                       config->cfg |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;
>>       }
>>
>> --
>> 2.34.1
>>
>>

