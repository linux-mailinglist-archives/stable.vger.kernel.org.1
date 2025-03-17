Return-Path: <stable+bounces-124619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D74A6485B
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 10:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62091883668
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 09:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7489322ACE3;
	Mon, 17 Mar 2025 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Xkd/RWw0"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35FC22A81E;
	Mon, 17 Mar 2025 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205442; cv=none; b=slWYSDIRvQItFiFH3B3hcQ/5NZXhUrerH/9qmBmj7xBhVKV8fRV9nBV7fUJu0D+SAsd3LB7QbBJB7+bu9Fl67iViZRFolvMv4erzVJJrexIF8G9SChDrU+brVqtp3f3MjxbnXQ19vbo7K0d1+2ob8B/MrJVY1t92Fr1FLZ1Uq6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205442; c=relaxed/simple;
	bh=kMtkAlLK2V+OrVGCRvzbRI/my96MeuyTuAHg3u2InlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KlqYZID3149NU3MJhFk55kIFJtZTpgAjYR5+sFdkTboFk5OS4vkiJeTRzEp7IBABjv/KzIBjukhtbKngfQCB9lz88l3PLoUwGwOI/IMUbPppmL4N/ioe1HeYCfB9KrZTx5OO8gvt0ORteTX/OX5x3WjTMjF997otUmJjVeWLn8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Xkd/RWw0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.22] (unknown [167.220.238.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6457A2045FF1;
	Mon, 17 Mar 2025 02:57:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6457A2045FF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742205434;
	bh=1gNif6YjABdnpvf0u2zC4lMhgEA3cPPjxTKRt/DuQzA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xkd/RWw0UNhAs25aPukjNo5Zzf9Kv1zu4UXPShasMtdq98S26whVV8HxvpbhKR69Y
	 GSToIiamXIAK8v8uB2j9s1b6fafrYGzqATnb9J3c7N4erc5l9rciOR3oYj8EWuNI7J
	 E9r2SqcCinRqvc/HPtbD3L8g2BmjkwUhPWdr5UrY=
Message-ID: <8c2c67cc-d8a0-42cf-b9fe-c5e5c4f627c6@linux.microsoft.com>
Date: Mon, 17 Mar 2025 15:27:08 +0530
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


Hi Valentin,
Splitting the warning to different lines give checkpatch error with 
--strict option. --fix option suggests we keep it like we have it 
originally(single line). Please let me know if you feel we can change it 
to something else or if you are fine with picking the change for next 
iteration. Thanks again.

# ./scripts/checkpatch.pl --strict 
v6-0001-sched-topology-Enable-topology_span_sane-check-on.patch
WARNING: quoted string split across lines
#40: FILE: kernel/sched/topology.c:137:
+               pr_info_once("%s: Scheduler topology debugging disabled, "
+                            "add 'sched_verbose' to the cmdline to 
enable it\n",

total: 0 errors, 1 warnings, 0 checks, 23 lines checked


Regards,
Naman

