Return-Path: <stable+bounces-124120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E05A5D6D5
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 08:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486AA3B784F
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 07:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D1F1EA7E3;
	Wed, 12 Mar 2025 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="C6+vpoH2"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919011E9B34;
	Wed, 12 Mar 2025 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763273; cv=none; b=QOOHp6Gjj7LQiqcHqolDkIUbALbJd4E6TJSKi4mFGl3YG5w3jwnqHQw40BPjV13q/LHq8Sf0/GZZ8joFY73jOLwEND9O6fwlo6gys+HJL8IvI1eylmJmhc2Pa0f/IHqjazy/zz8+8CrYa94bVTq6yHo3OSseBV9btODTim6DzTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763273; c=relaxed/simple;
	bh=p+8NQyptigK6LSXRY0dhiA9xz9BOW4cmtkxmZpnpj7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGEgqRlm7SkrV0WrMAv0Q5HJZ3XNpxzspsXpZNG/cSouhGphCahnT/HSnHjTGzAjgIeHhx9y1+XNGyrw2scxSr5tGAmPSDmF189icJSywMQi24B47U12RHeOhT0HuMPQ/WXPnbZzBaI9bvocg61cIii98dBzA4Mnj4cQzkt3gZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=C6+vpoH2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.162.36] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id EB7A72045FF0;
	Wed, 12 Mar 2025 00:07:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB7A72045FF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741763270;
	bh=K3+hbNRBuhKGQ5kI6/gUAGXIu2sJtNpSgo5MWwBx36U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C6+vpoH24BuGgZQRrJkibK/XKfmr0bbe6cDCHyiYXPah3Ft4OZuDr3XzRlzbmgNqi
	 mE3NC1MT8rR7rqVVvO7gj1AxydY5rD9896Rw9dXwJPMuw51sGpMFZXXCU1gey96IHu
	 J79bVD0hIrtThp7q4mr9iG9Q58avOdnKaBvb3v6g=
Message-ID: <16004c77-de73-4208-9a10-feee7225e738@linux.microsoft.com>
Date: Wed, 12 Mar 2025 12:37:43 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] sched/topology: Enable topology_span_sane check only
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
References: <20250310052509.1416-1-namjain@linux.microsoft.com>
 <xhsmh34fjr3av.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <xhsmh34fjr3av.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/2025 9:02 PM, Valentin Schneider wrote:
> On 10/03/25 10:55, Naman Jain wrote:
>> From: Saurabh Sengar <ssengar@linux.microsoft.com>
>>
>> On a x86 system under test with 1780 CPUs, topology_span_sane() takes
>> around 8 seconds cumulatively for all the iterations. It is an expensive
>> operation which does the sanity of non-NUMA topology masks.
>>
>> CPU topology is not something which changes very frequently hence make
>> this check optional for the systems where the topology is trusted and
>> need faster bootup.
>>
>> Restrict this to sched_verbose kernel cmdline option so that this penalty
>> can be avoided for the systems who want to avoid it.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap")
>> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Co-developed-by: Naman Jain <namjain@linux.microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> ---
>> Changes since v4:
>> https://lore.kernel.org/all/20250306055354.52915-1-namjain@linux.microsoft.com/
>>        - Rephrased print statement and moved it to sched_domain_debug.
>>          (addressing Valentin's comments)
>> Changes since v3:
>> https://lore.kernel.org/all/20250203114738.3109-1-namjain@linux.microsoft.com/
>>        - Minor typo correction in comment
>>        - Added Tested-by tag from Prateek for x86
>> Changes since v2:
>> https://lore.kernel.org/all/1731922777-7121-1-git-send-email-ssengar@linux.microsoft.com/
>>        - Use sched_debug() instead of using sched_debug_verbose
>>          variable directly (addressing Prateek's comment)
>>
>> Changes since v1:
>> https://lore.kernel.org/all/1729619853-2597-1-git-send-email-ssengar@linux.microsoft.com/
>>        - Use kernel cmdline param instead of compile time flag.
>>
>> Adding a link to the other patch which is under review.
>> https://lore.kernel.org/lkml/20241031200431.182443-1-steve.wahl@hpe.com/
>> Above patch tries to optimize the topology sanity check, whereas this
>> patch makes it optional. We believe both patches can coexist, as even
>> with optimization, there will still be some performance overhead for
>> this check.
>>
>> ---
>>   kernel/sched/topology.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index c49aea8c1025..d7254c47af45 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -132,8 +132,11 @@ static void sched_domain_debug(struct sched_domain *sd, int cpu)
>>   {
>>        int level = 0;
>>
>> -	if (!sched_debug_verbose)
>> +	if (!sched_debug_verbose) {
>> +		pr_info_once("%s: Scheduler topology debugging disabled, add 'sched_verbose' to the cmdline to enable it\n",
>> +			     __func__);
>>                return;
>> +	}
>>
> 
> Nit: I've been told not to break warnings over multiple lines so they can
> be grep'ed, but given this has the "sched_domain_debug:" prefix I think we
> could get away with the below.
> 
> Regardless:
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> 
> ---
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index d7254c47af455..b4dc7c7d2c41c 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -133,7 +133,8 @@ static void sched_domain_debug(struct sched_domain *sd, int cpu)
>   	int level = 0;
>   
>   	if (!sched_debug_verbose) {
> -		pr_info_once("%s: Scheduler topology debugging disabled, add 'sched_verbose' to the cmdline to enable it\n",
> +		pr_info_once("%s: Scheduler topology debugging disabled, "
> +			     "add 'sched_verbose' to the cmdline to enable it\n",
>   			     __func__);
>   		return;
>   	}


Thanks for reviewing. I'll wait a couple more days to push the next
version.

Thanks,
Naman

