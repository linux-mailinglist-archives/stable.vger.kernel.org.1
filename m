Return-Path: <stable+bounces-114499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B919A2E841
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 10:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293371649C9
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 09:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5481C4A0E;
	Mon, 10 Feb 2025 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ovGWKNYZ"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187CF1C3C01;
	Mon, 10 Feb 2025 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181206; cv=none; b=uMPN/+gj/NG8qMcUZ6PgBBhitGYF1UCLWt2M/8shOp7IpJTE8N2Y0I5nO5fuUj8qZbyoCbyFkeMGheDIp7+WuvaRKa/TpXbCrbUVqoEcm4w9g/eIGXRsNdLtGYgR+qbRZAE+sNi2b2gu1y2c84MCCRz968lBWDAsjytzo80c07w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181206; c=relaxed/simple;
	bh=IO+O6EUi+uAuGXL49mw0amt+smHLueMfx2555wz9A3Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uryKQP0sIkCpDA2SeHxQY67rwWsd38W3Zx233Nu+KNqaZNo0RtBfbEgxq+7FHT2Rb07/DiM6EvpoINczAdvL/9vxDT44EHpuY+LU4TLGeTbDywNeBRsm1+psKRPkmg1AWKcMbcME1ZvSSRT4trnv5ZZVSLvqVOdzRS8y8lXrz8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ovGWKNYZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.84.73] (unknown [167.220.238.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id BAF3A210733E;
	Mon, 10 Feb 2025 01:53:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BAF3A210733E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739181204;
	bh=ul4PqToDU4EOqIEkhiabbprEgPldGXOLOtdJ7Wxw19U=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ovGWKNYZqPdKyurIannMR1Ek323hBTUtkGTmWdt17z23who+oJ5ArrYzTL1mPJ+cm
	 T4OsQOWgOrcq1mcJPCRU0fRwBmDyOBrSAcB9RY0iuQTupVPkU76azAJUS8cuvIeSui
	 OpwOpMKcS6EfvByhmqs49BFTUe0dLy3JrINuz+Jk=
Message-ID: <d3884226-b145-4960-b5c8-ca8284aff9ef@linux.microsoft.com>
Date: Mon, 10 Feb 2025 15:23:19 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/topology: Enable topology_span_sane check only
 for debug builds
From: Naman Jain <namjain@linux.microsoft.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>,
 Saurabh Singh Sengar <ssengar@linux.microsoft.com>, srivatsa@csail.mit.edu,
 Michael Kelley <mhklinux@outlook.com>, namjain@linux.microsoft.com
References: <20250203114738.3109-1-namjain@linux.microsoft.com>
 <bf469858-dedf-490a-abf2-b066aee6077e@amd.com>
 <ee7f3c75-b7f6-416b-b6e6-983c466f1c83@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <ee7f3c75-b7f6-416b-b6e6-983c466f1c83@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/5/2025 12:53 PM, Naman Jain wrote:
> 
> 
> On 2/5/2025 12:50 PM, K Prateek Nayak wrote:
>> Hello Naman,
>>
>> On 2/3/2025 5:17 PM, Naman Jain wrote:
>>> From: Saurabh Sengar <ssengar@linux.microsoft.com>
>>>
>>> On a x86 system under test with 1780 CPUs, topology_span_sane() takes
> 
> <.>
> 
>>>   {
>>>       int i = cpu + 1;
>>> +    /* Skip the topology sanity check for non-debug, as it is a 
>>> time- consuming operatin */
>>
>> s/operatin/operation/
>>
>>> +    if (!sched_debug()) {
>>> +        pr_info_once("%s: Skipping topology span sanity check. Use 
>>> `sched_verbose` boot parameter to enable it.\n",
>>
>> This could be broken down as follows:
>>
>>          pr_info_once("%s: Skipping topology span sanity check."
>>                   " Use `sched_verbose` boot parameter to enable it.\n",
>>                   __func__);
>>
>> Running:
>>
>>      grep -r -A 5 "pr_info(.*[^;,]$" kernel/
>>
>> gives similar usage across kernel/*. Apart from those nits, feel
>> free to add:
>>
>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com> # x86
>>
>> if the future version does not change much.
>>
> 
> Hello Prateek,
> Thanks for reviewing and testing this. I'll make changes based on your
> feedback in next version.
> 
> Regards,
> Naman
> 

Hi Prateek,
After breaking down the print msg based on your suggestion, checkpatch
gives a warning. There are no warnings reported with current version of
change. Even the fix suggested by checkpatch is aligned to what we have
right now. So I'll keep it like this, not push further changes as of now
and wait for the maintainers to pick the patch.

WARNING: quoted string split across lines
#57: FILE: kernel/sched/topology.c:2365:
+               pr_info_once("%s: Skipping topology span sanity check."
+                            " Use `sched_verbose` boot parameter to
enable it.\n",

total: 0 errors, 1 warnings, 14 lines checked

Regards,
Naman

