Return-Path: <stable+bounces-121402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA1EA56B30
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 16:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1FF189B669
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 15:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77C121C166;
	Fri,  7 Mar 2025 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="af5d+C1Q"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C81521C179;
	Fri,  7 Mar 2025 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359935; cv=none; b=WOz1+tP8B4abtCVq7H3YTbITeBIxDeOwAJX+ZgLSuBjhFsb9Wp9mm8xcgRkxoO38PAHRbJ6FBBJh0aq5Fv/Dfb1gBlypdH0TyqvJcuOHIzWHL78Ixps0ONsXeH8+73WXOeiTA6CzOetfYWXIC4Eqb6SwN27oN3E6L4BS9JyO8Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359935; c=relaxed/simple;
	bh=vkajAd6C+aBL/cx4UI6cMxaNKhLSk483ukm9k5uqSgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Chz5kvc8CuSDGUF2cN+D8v+bgh932Hh/eLF5yCz+JcE7nw2+WlLMo5i76YLIXyD+dZlALEjKYm332cbgytZeXPnUbLeIn37vskEXaEYB2Nifg3dZ+Sr5D5vzGQQVFn9FUBJVc7Egw4gpNoO3kp09Y2BQcY0Gei5Eqh7TZ+vzT7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=af5d+C1Q; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.65.43] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 622232038F38;
	Fri,  7 Mar 2025 07:05:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 622232038F38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741359933;
	bh=qBvGIF1Dvpc7Yt8ucophS5Ds134KAk4AkIU1eqWjtnc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=af5d+C1QG4E3Dv0RaNrDEOOwzVVn9PIMHtjh26hglj7DujoxrmFene6tAhUm1Yd29
	 JFQlqKiizStpfrMS+PfMs/IlmYIJxb7z1bvO9NRLQQUtLsmbgn9H3PoeN2mmrOZSMi
	 Fo6bvB8B2Z5etoYsJjYcs3NeeRz8mVohVhRokXY4=
Message-ID: <81b11433-58ac-4a2c-a497-d6d91e330810@linux.microsoft.com>
Date: Fri, 7 Mar 2025 20:35:23 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sched/topology: Enable topology_span_sane check only
 for debug builds
To: Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>,
 Saurabh Singh Sengar <ssengar@linux.microsoft.com>, srivatsa@csail.mit.edu,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Michael Kelley <mhklinux@outlook.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20250306055354.52915-1-namjain@linux.microsoft.com>
 <xhsmhwmd2ds0o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <xhsmhwmd2ds0o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/6/2025 10:18 PM, Valentin Schneider wrote:
> On 06/03/25 11:23, Naman Jain wrote:
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index c49aea8c1025..666f0a18cc6c 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -2359,6 +2359,13 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
>>   {
>>        int i = cpu + 1;
>>
>> +	/* Skip the topology sanity check for non-debug, as it is a time-consuming operation */
>> +	if (!sched_debug()) {
>> +		pr_info_once("%s: Skipping topology span sanity check. Use `sched_verbose` boot parameter to enable it.\n",
>> +			     __func__);
> 
> FWIW I'm not against this change, however if you want to add messaging
> about sched_verbose I'd put that in e.g. sched_domain_debug() (as a print
> once like you've done here) with something along the lines of:
> 
>    "Scheduler topology debugging disabled, add 'sched_verbose' to the cmdline to enable it"


Thank you so much for reviewing.
Please correct me if I misunderstood. Are you proposing below change?

--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2361,7 +2361,7 @@ static bool topology_span_sane(struct 
sched_domain_topology_level *tl,

         /* Skip the topology sanity check for non-debug, as it is a 
time-consuming operation */
         if (!sched_debug()) {
-               pr_info_once("%s: Skipping topology span sanity check. 
Use `sched_verbose` boot parameter to enable it.\n",
+               pr_info_once("%s: Scheduler topology debugging disabled, 
add 'sched_verbose' to the cmdline to enable it\n",
                              __func__);
                 return true;
         }


Regards,
Naman

> 
>> +		return true;
>> +	}
>> +
>>        /* NUMA levels are allowed to overlap */
>>        if (tl->flags & SDTL_OVERLAP)
>>                return true;
>> --
>> 2.34.1


