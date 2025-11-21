Return-Path: <stable+bounces-196495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D8DC7A462
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id C3AB329123
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A708E280A5B;
	Fri, 21 Nov 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oSBgiWtU"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B293E280324
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736488; cv=none; b=MrF+KkY5jM+trhXGSdUIp23IcEl2mfLNskfT8mrj9Zb45xQAp3mP7pWH18QYlo6F6KCcFYoxi+1dOX9fxq51ARmsfNeNsQk8M1rzl9maZpjoYI5w9bUlxzlwwIIG2Z5MwjZnxF5mzQverMyxRDUmaD9zCp+YIaLazmkUxEcXlqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736488; c=relaxed/simple;
	bh=qhIhpTTmPHaOfipnNoCbtlFFSPbh6aivHkHuoEZZBcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qzVZKeiCVthoSVM3EmDQAWz2TeIiKbH3W/dYRfygJGwrYZvzse9QHhevkhye6w+nFftQjNi1cCvNhnDuqWpeGw7miI3QMoskuUc4iNsHUWanUKr0wgtSD20rWkk7F4T/zFdauiVxtMNrfGwPUgxoLETdc78d+Hs7z/ena4bq6P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oSBgiWtU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALE193i007023;
	Fri, 21 Nov 2025 14:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Lmtes3
	1UvJIbo2xqQhVs7E2qNJ4cUe8sqjqItvUGHH4=; b=oSBgiWtUl8f2bNjPT15WIG
	f5mfnu/MEGP2BHXQjis3mwci3mfFaTBIYSrpas+PCpi1IlQEGr/61j8rGh4LjklV
	7I50MzxfEXqvibk3fmUzW7opr333yPSb0f65+t/W+MAyu1xNDSNhu/3/ddwoj2Il
	B9rul5tVFRyqhAPmpheHbenT7xFInlA9KCg1lmGa6aqWLhPLtjc1TJd7N6tFBXRP
	rucu6NlI73Z/PV2ZylPN5L7qAFDvGX3D+hqqxuRFpK/OgzawkyJeD20czm8FxXPn
	gykThojixrAzF9G1ZFLR8IYwbG27wUCvrEE/ugPsXx4sjTNdHNbJT7t1P300Zcag
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmt300n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 14:47:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALEPsjT010419;
	Fri, 21 Nov 2025 14:47:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af3usmuys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 14:47:56 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ALElsO831326514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 14:47:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A67292004B;
	Fri, 21 Nov 2025 14:47:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CC8720043;
	Fri, 21 Nov 2025 14:47:53 +0000 (GMT)
Received: from [9.124.216.84] (unknown [9.124.216.84])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Nov 2025 14:47:53 +0000 (GMT)
Message-ID: <d9ca1c12-bec2-47cc-90b5-8924ddb416f7@linux.ibm.com>
Date: Fri, 21 Nov 2025 20:17:52 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] crash: fix crashkernel resource shrink"
 failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org, akpm@linux-foundation.org, bhe@redhat.com,
        stable@vger.kernel.org, thunder.leizhen@huawei.com
References: <2025112029-arrogance-bondless-6a5b@gregkh>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <2025112029-arrogance-bondless-6a5b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Nqi8d6SgNKXWCsR9fVL1H-ScTGHlnSoe
X-Authority-Analysis: v=2.4 cv=Rv3I7SmK c=1 sm=1 tr=0 ts=69207b9d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=20KFwNOVAAAA:8
 a=i0EeH86SAAAA:8 a=Z4Rwk6OoAAAA:8 a=bS5lpUc7UAEx6uHbnxQA:9 a=QEXdDO2ut3YA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: Nqi8d6SgNKXWCsR9fVL1H-ScTGHlnSoe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX+7FBEW+UyZ8d
 3YvdeQiFnWPy09KmLqPulZBLWKl5vWyjQ/jFMtK7UfkJdXS7IydIgBKZaFAhGU/nJBo8BH6W2sf
 9ndtSD8TljIVUtIjRdh0u+Laxw8kWkSofdKpXaaUpJ7aR714iGHubU5hc/BXUFcCtmNVBSfypwv
 OIY5LZklicO4nba0bzp3MV0IN+JXtTN4LKX/7NDPgYhaMqRPJl1z8RNJ74tjRyX+GKgzwtBJcYg
 sB1zDyJjt5+D9wBcLIyl2kpNx5iSlfM+wfDyRo19bQMpDUmVBRZRAPDLg3JED/6GsuArn0HBvgR
 WvbxYOtu4/eEehnM6/dVV2M8X3MRbQls2++CnWEiU5SiQXEW4pASuuW+h8Xf5za7x7b7f4J50U/
 Ic4oqsKd4BfeW8JboUlSyQbn78PefQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

Hello Greg

On 20/11/25 21:45, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 00fbff75c5acb4755f06f08bd1071879c63940c5
> # <resolve conflicts, build, test, etc.>
> git commit -s

I followed the above steps and back-ported the fix.

> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112029-arrogance-bondless-6a5b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

I used the above command to send the back-ported patch. The command ran
fine, but I do not see my back-ported patch on lore.kernel.org.

This is the first time I am sending a patch using --in-reply, so I am not
sure how it works. Please let me know if you did not receive the
backported patch.

I also kept the Signed-off-by and Acked-by tags in the backported patch,
as it is identical to the original patch.

Thanks,
Sourabh Jain

>
> Possible dependencies:
>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
>  From 00fbff75c5acb4755f06f08bd1071879c63940c5 Mon Sep 17 00:00:00 2001
> From: Sourabh Jain <sourabhjain@linux.ibm.com>
> Date: Sun, 2 Nov 2025 01:07:41 +0530
> Subject: [PATCH] crash: fix crashkernel resource shrink
>
> When crashkernel is configured with a high reservation, shrinking its
> value below the low crashkernel reservation causes two issues:
>
> 1. Invalid crashkernel resource objects
> 2. Kernel crash if crashkernel shrinking is done twice
>
> For example, with crashkernel=200M,high, the kernel reserves 200MB of high
> memory and some default low memory (say 256MB).  The reservation appears
> as:
>
> cat /proc/iomem | grep -i crash
> af000000-beffffff : Crash kernel
> 433000000-43f7fffff : Crash kernel
>
> If crashkernel is then shrunk to 50MB (echo 52428800 >
> /sys/kernel/kexec_crash_size), /proc/iomem still shows 256MB reserved:
> af000000-beffffff : Crash kernel
>
> Instead, it should show 50MB:
> af000000-b21fffff : Crash kernel
>
> Further shrinking crashkernel to 40MB causes a kernel crash with the
> following trace (x86):
>
> BUG: kernel NULL pointer dereference, address: 0000000000000038
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> <snip...>
> Call Trace: <TASK>
> ? __die_body.cold+0x19/0x27
> ? page_fault_oops+0x15a/0x2f0
> ? search_module_extables+0x19/0x60
> ? search_bpf_extables+0x5f/0x80
> ? exc_page_fault+0x7e/0x180
> ? asm_exc_page_fault+0x26/0x30
> ? __release_resource+0xd/0xb0
> release_resource+0x26/0x40
> __crash_shrink_memory+0xe5/0x110
> crash_shrink_memory+0x12a/0x190
> kexec_crash_size_store+0x41/0x80
> kernfs_fop_write_iter+0x141/0x1f0
> vfs_write+0x294/0x460
> ksys_write+0x6d/0xf0
> <snip...>
>
> This happens because __crash_shrink_memory()/kernel/crash_core.c
> incorrectly updates the crashk_res resource object even when
> crashk_low_res should be updated.
>
> Fix this by ensuring the correct crashkernel resource object is updated
> when shrinking crashkernel memory.
>
> Link: https://lkml.kernel.org/r/20251101193741.289252-1-sourabhjain@linux.ibm.com
> Fixes: 16c6006af4d4 ("kexec: enable kexec_crash_size to support two crash kernel regions")
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 3b1c43382eec..99dac1aa972a 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -373,7 +373,7 @@ static int __crash_shrink_memory(struct resource *old_res,
>   		old_res->start = 0;
>   		old_res->end   = 0;
>   	} else {
> -		crashk_res.end = ram_res->start - 1;
> +		old_res->end = ram_res->start - 1;
>   	}
>   
>   	crash_free_reserved_phys_range(ram_res->start, ram_res->end);
>


