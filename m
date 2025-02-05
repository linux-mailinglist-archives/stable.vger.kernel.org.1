Return-Path: <stable+bounces-112281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D260FA284E7
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 08:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4AC18867E9
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 07:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD2B228C92;
	Wed,  5 Feb 2025 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JRD5kY+C"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22764228C91;
	Wed,  5 Feb 2025 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738740247; cv=none; b=XRv7VM9+umepuvrYNCVO3oZND9rRRzVIb+OUfY8D0Ac36Z+BhyPNI8emo7BR9RAjA3UfOOd/9erRqsFcEPQYv6wRkCH7QDed45DAv+/AmXpnh0cvPtvyBLi+z6gkXC160rHG+4SCYCg7E2fbDbRNjM0q3ufmRuCJX/QWwgkV1BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738740247; c=relaxed/simple;
	bh=Cj+Pbd2/n1KYGHKtDmEbSbjEAdbJy4st9tAoUhSsWuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEYbVG6iquzznsi8XTDZLSBDUUvNSALXxDJzPJjPBA1HfmUyz/RYmQhqQ3tzG+Yo+WD67iufta3O9qTa9MmL1Gb2KX/q4PDcejNTBDYpBX3g1Hegf+Al8MZ5NWVbI7ZJXEfimMwFPH+U/4yBJ60qj9DVEaTnduxmTStjeTFOK8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JRD5kY+C; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.84.73] (unknown [167.220.238.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id 89ABC203F585;
	Tue,  4 Feb 2025 23:24:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 89ABC203F585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738740245;
	bh=M5OQQ11HeiOo2qp+8sLAhdiGvT4ZXKIkzKf7G8IAmO4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JRD5kY+C9R5ef8/QcMU5axu1dttEyYFB/4dQvNdFAOgiM/L+aKx4soAdj7ug4jrVd
	 SJmWcMthL9Aw19RU7G6WcITKUyIuRs4zIL5+DrGi1L1Y0FTTQwZj+FapQaPm8rgofz
	 BlPuJY7Rl6YlayUXg+vWkeiGrdpqspU1Vr1c1tus=
Message-ID: <ee7f3c75-b7f6-416b-b6e6-983c466f1c83@linux.microsoft.com>
Date: Wed, 5 Feb 2025 12:53:58 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/topology: Enable topology_span_sane check only
 for debug builds
To: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>,
 Saurabh Singh Sengar <ssengar@linux.microsoft.com>, srivatsa@csail.mit.edu,
 Michael Kelley <mhklinux@outlook.com>
References: <20250203114738.3109-1-namjain@linux.microsoft.com>
 <bf469858-dedf-490a-abf2-b066aee6077e@amd.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <bf469858-dedf-490a-abf2-b066aee6077e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/5/2025 12:50 PM, K Prateek Nayak wrote:
> Hello Naman,
> 
> On 2/3/2025 5:17 PM, Naman Jain wrote:
>> From: Saurabh Sengar <ssengar@linux.microsoft.com>
>>
>> On a x86 system under test with 1780 CPUs, topology_span_sane() takes

<.>

>>   {
>>       int i = cpu + 1;
>> +    /* Skip the topology sanity check for non-debug, as it is a time- 
>> consuming operatin */
> 
> s/operatin/operation/
> 
>> +    if (!sched_debug()) {
>> +        pr_info_once("%s: Skipping topology span sanity check. Use 
>> `sched_verbose` boot parameter to enable it.\n",
> 
> This could be broken down as follows:
> 
>          pr_info_once("%s: Skipping topology span sanity check."
>                   " Use `sched_verbose` boot parameter to enable it.\n",
>                   __func__);
> 
> Running:
> 
>      grep -r -A 5 "pr_info(.*[^;,]$" kernel/
> 
> gives similar usage across kernel/*. Apart from those nits, feel
> free to add:
> 
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com> # x86
> 
> if the future version does not change much.
> 

Hello Prateek,
Thanks for reviewing and testing this. I'll make changes based on your
feedback in next version.

Regards,
Naman


