Return-Path: <stable+bounces-121663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B2EA58BAC
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 06:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD333188968C
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 05:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2C61C5D5C;
	Mon, 10 Mar 2025 05:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q1xcQq+7"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F3D1C5D53;
	Mon, 10 Mar 2025 05:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741584385; cv=none; b=lh7xgv8QSXfGWXgfiFN0ccP6zp0TthcHmH+GKTWop+h573QXkbWldnU05i+xYk57hJu68s81uZQKQ6Labwegfpva8/XMeGaikZaj9DWVGFI1c+mOgMPQ6/L4ql6sUFTIJu+t10HN8T6WX5PpmGL7fF7cpk3S+VH/xAxabv2g0AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741584385; c=relaxed/simple;
	bh=sWokZzYxm1CeYRCiODzRXUpzs0uUoJmauuGQM4qMOHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H73DN07v+yLQgENzPCTjbullOmRSKJcHVTfxJx+sPNiSTb40403nM5yB4nSVWi8ky4x8ske26mfmWrFsumGETxNVuia4k7QhjAqu5thR6jBBeAjnoYekdKfVZjy3L5z08t2Zj92I1hT+tzWQTtd6F+sCKVBGlCItZMYR+2mXk0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Q1xcQq+7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.210.62] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6F4D521104A7;
	Sun,  9 Mar 2025 22:26:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6F4D521104A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741584383;
	bh=+UbeTRTcINNlR4Gih81eaCwNs9yvnE21ELsLzgn4KcY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q1xcQq+73dAl58mRgBpFOYVbowai+v05Ls2mWkhKKeYYXJmk+a4cMMB1zBIYQI/xL
	 H6/hdxFI994dIxlN3vKmtLugwzGHwS9IfkGNUZ0vXUGHW/sYtv/XQkWzCyot6DmDh1
	 a1oeAkB/1qwZsTxXQbOzk+jeekdgkKF5B5r5Zt9U=
Message-ID: <61eb1bb6-2ccf-4d89-be47-34bfe0ea9778@linux.microsoft.com>
Date: Mon, 10 Mar 2025 10:56:12 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sched/topology: Enable topology_span_sane check only
 for debug builds
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>,
 Saurabh Singh Sengar <ssengar@linux.microsoft.com>, srivatsa@csail.mit.edu,
 Michael Kelley <mhklinux@outlook.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20250306055354.52915-1-namjain@linux.microsoft.com>
 <xhsmhwmd2ds0o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <81b11433-58ac-4a2c-a497-d6d91e330810@linux.microsoft.com>
 <d033e4cc-728e-41cd-8fd8-616b2eb7709f@amd.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <d033e4cc-728e-41cd-8fd8-616b2eb7709f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/7/2025 9:11 PM, K Prateek Nayak wrote:
> Hello Naman,
> 
> On 3/7/2025 8:35 PM, Naman Jain wrote:
>>
>>
>> On 3/6/2025 10:18 PM, Valentin Schneider wrote:
>>> On 06/03/25 11:23, Naman Jain wrote:
>>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>>> index c49aea8c1025..666f0a18cc6c 100644
>>>> --- a/kernel/sched/topology.c
>>>> +++ b/kernel/sched/topology.c
>>>> @@ -2359,6 +2359,13 @@ static bool topology_span_sane(struct 
>>>> sched_domain_topology_level *tl,
>>>>   {
>>>>        int i = cpu + 1;
>>>>
>>>> +    /* Skip the topology sanity check for non-debug, as it is a 
>>>> time-consuming operation */
>>>> +    if (!sched_debug()) {
>>>> +        pr_info_once("%s: Skipping topology span sanity check. Use 
>>>> `sched_verbose` boot parameter to enable it.\n",
>>>> +                 __func__);
>>>
>>> FWIW I'm not against this change, however if you want to add messaging
>>> about sched_verbose I'd put that in e.g. sched_domain_debug() (as a 
>>> print
>>> once like you've done here) with something along the lines of:
>>>
>>>    "Scheduler topology debugging disabled, add 'sched_verbose' to the 
>>> cmdline to enable it"
>>
>>
>> Thank you so much for reviewing.
>> Please correct me if I misunderstood. Are you proposing below change?
>>
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -2361,7 +2361,7 @@ static bool topology_span_sane(struct 
>> sched_domain_topology_level *tl,
>>
>>          /* Skip the topology sanity check for non-debug, as it is a 
>> time-consuming operation */
>>          if (!sched_debug()) {
>> -               pr_info_once("%s: Skipping topology span sanity check. 
>> Use `sched_verbose` boot parameter to enable it.\n",
>> +               pr_info_once("%s: Scheduler topology debugging 
>> disabled, add 'sched_verbose' to the cmdline to enable it\n",
>>                               __func__);
>>                  return true;
>>          }
>>
> 
> I think Valentin meant moving the same pr_info_once() to the early exit
> case in sched_domain_debug() for "!sched_debug_verbose" to notify the
> user that sched_debug() is disabled and they can turn it on using
> "sched_verbose" as opposed to announcing it from topology_span_sane().

Sure, thanks. Sent v5 with this change.

Regards,
Naman
> 


