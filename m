Return-Path: <stable+bounces-158430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F7AAE6CA1
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 18:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B144A2E74
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F31B2E2EFD;
	Tue, 24 Jun 2025 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="guGZCIP3"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D042E1759
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750783227; cv=none; b=GuxCG/RaSIPbxFfkmzI6uZeHAkJJjLcJZZhBXvfIsRbw6RC86VyfY7s0+d5UYH+MhO6kudzTI7+TpDlZtNXcDr68310pKggE8us6UQNNDGZH8OF1/U+uirrV7r/4ViBd9NWFfQqEd8zC16mkaje1/PJCx9GpLtZIK0XyY3WuZRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750783227; c=relaxed/simple;
	bh=gNbfS3IQIw+ZA/Tbc1eqTzjOvW49DznDyTFvf00LwRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awyMF85jcYAHGcb/EOSzR1oQTri173181mTkxBCoEtHP6jvzwYgSW429dMdN5N93m86XbkDwJ+cGRmsi2WQk7sMH2Yo7H43scI5LCzh2rB57gg0DkD6TwTvUcB2RTQxMhbGNu6UXcWho6dYtqGbmc9cm7UDVItcaT2LAPuwbq3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=guGZCIP3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OCK5Dw024743
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 16:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iBz7B261UilGw8l0cFlngfc5bC9U8v/iHsxpZb5CMf0=; b=guGZCIP3M1/1JQCm
	AZvfR6qZMeXH2lAvS3ajG/CUmCcXuRUc6NnqdEd/OCxzmgWVivu8pbl+z9AIYZVp
	0MZU7VbUJ5J7/Zubc9fSwxnJ6rRcM8DKS6G2qn/Q/LLemV4sGDMFDPTPhjiI/7Oo
	wgu3M19I+UGnL31FNksrELgcMRRpPVZFn3yNzW+RWrNIOQjc6pj0Iy8dHiTzV7bO
	TSaXqVMWXEmXX0rHJbYEnCEndDkHIbgSGzP9YG12wBNZPkIdjGMiQHlAnQUQQAdg
	LTeTYsbTc0/4WvAZeIcYbQOJxK0JzOUxhMPSb5lJbYokGu9yXi2BylorbD/HSslF
	jTrvZw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f8ymuvha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 16:40:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d3ea727700so86591885a.3
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 09:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750783223; x=1751388023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBz7B261UilGw8l0cFlngfc5bC9U8v/iHsxpZb5CMf0=;
        b=sDT00OMQ40NkdTWdZk1wFvmErS7WoY70kOsELmR+qggHxp2H3fGbXSpUmg8HyI7t2v
         Do6X2lWukd+ffgmFCAT7cDnK01NuDyCkf46Vd7Gsg11vtTGlf6mtVBZQyH1QWJDVLMvm
         Y34sffMSrEXreNqDboAMQE+fXH1mKN4tpQ1Zwegqn4rRsfGj9s78EQ4H2HGHc29fiRFD
         hGrAhgBa2XATBASnnqwb5ur0VUDCIIXcr7OFVMwKhpiciSAEdDeG7xpeqb2GDj8uEuxn
         JRT0ylrvLQfKlOArSANhZEJqWjO3CaLiQRbQ+kcMAQXoz4eRXY4yYPpOaO/3EqpCfbjs
         0SDg==
X-Forwarded-Encrypted: i=1; AJvYcCXdFmkUEehoAqSsxXToSSwAUG6sgK68w6xi+l35inqeOTjbn8t6Dc1FPG50AeBJ4y26kT55MRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNlFj2YtHEV83TmKVrYHDT6wDkDQyUk5xK6TJ5gBW/SCw+JISP
	RNvNXxpcG1RbCfeTKQrGku7vd+kh4gYSzG0Yh2oYoLFdsq9Wms7dNg4+Y98EMqvrB9GUkC/zhsb
	VZ3mVWJMZa/2VKx2DSFfuua5nRxepzwrUACTetjAKQRrnAf0kr4ssVugALsQ=
X-Gm-Gg: ASbGncsoIjRECfOajKBTTkeL1LMkPrdJN7OdnHmvjZMR84axsIvj22JOliq6uA0cIw9
	p9kdRAnphv7x3/CFVBhsyTB5gppX5GEdqTsDOBRqPtfM5uaTXb1gvIiWTq1k4ykP/hk4YaYRdhs
	vc1Ns59mRNO6bg8I2qlTuaG7AhP0R3A4V7TBxikFxiKKOdnHFD0Ta5sEosf394hpx3zszfqFkQQ
	L3TEhVXtxf1uBd25r9+pehYSBjYr5vV8Fue7HOFM5uXr9bEybQ/XST4VWkFw6KYazqoqeuVLbGh
	anVUlIq8ZpLWlhLBTLbltnhbiXF72HtkitHejJmflebgRI/+6IZyJvBQ85iykfoJ8XvVqCW4rDm
	WSD8=
X-Received: by 2002:a05:620a:4708:b0:7c5:79e8:412a with SMTP id af79cd13be357-7d3f98b4b8dmr960282685a.2.1750783223059;
        Tue, 24 Jun 2025 09:40:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPqHhsv+zekMkO/9EZrbowlEpSkryyjGSkX63Yw6hzZKBV3xkpzSKd1B0PRQ0dVJYh0CwAyA==
X-Received: by 2002:a05:620a:4708:b0:7c5:79e8:412a with SMTP id af79cd13be357-7d3f98b4b8dmr960280485a.2.1750783222328;
        Tue, 24 Jun 2025 09:40:22 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054209a93sm899311366b.166.2025.06.24.09.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 09:40:21 -0700 (PDT)
Message-ID: <67d4d34a-a15f-47b1-9238-d4d6792b89e5@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 18:40:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: hub: fix detection of high tier USB3 devices
 behind suspended hubs
To: Mathias Nyman <mathias.nyman@linux.intel.com>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu, oneukum@suse.com,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
References: <20250611112441.2267883-1-mathias.nyman@linux.intel.com>
 <acaaa928-832c-48ca-b0ea-d202d5cd3d6c@oss.qualcomm.com>
 <c8ea2d32-4e8e-49da-9d75-000d34f8e819@linux.intel.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <c8ea2d32-4e8e-49da-9d75-000d34f8e819@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEzOSBTYWx0ZWRfX+oFIdg5ondZH
 o6ZvbexbCVZ2SjjCEf/7+SKMKUIT2PcPVGKnwgyMW56hYww02bPh81CG5WpdKdzmVyeXPeFyZeF
 M3eSQve6DuOYpuoXOoJKUCaIXz3LSlY66nAAp7VvoevROVP1tDMmeysnigESBSYGjFHd8tuxYJJ
 SYz0qAJdtmwJANNrzXyR7tgzhewqGQ+8oZJ7wYOXANjiMMaNBPxsIr+cVdXN/ooHWaOhvft4Dzy
 P9rIkn6nvN7TeR/fvPJOGqJygVYQEe5p3xfqaLCRG0xUwSxmPoJRBJ2PEdL2y4MPvVjNR05nJPt
 WHqEhvhfIJGCHgm7IoEHVFGVFbgCckUoxvmL6EpVOv/+v7qz/RKTIgKk4nDfATWPwjRju2NurUo
 /cJy4zQNT63ofoGIDDEYqUErV1AxCZMfsB4ViOcrbsp8vOdfawwoE7ALE/1aY0lHqxYRnOaB
X-Proofpoint-ORIG-GUID: XWj683L02KATI2dFphSrgdWYIhfmywHi
X-Proofpoint-GUID: XWj683L02KATI2dFphSrgdWYIhfmywHi
X-Authority-Analysis: v=2.4 cv=GLYIEvNK c=1 sm=1 tr=0 ts=685ad4f8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=kec498a_61XqED03bvkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240139

On 6/24/25 11:47 AM, Mathias Nyman wrote:
> On 23.6.2025 23.31, Konrad Dybcio wrote:
>> On 6/11/25 1:24 PM, Mathias Nyman wrote:
>>> USB3 devices connected behind several external suspended hubs may not
>>> be detected when plugged in due to aggressive hub runtime pm suspend.
>>>
>>> The hub driver immediately runtime-suspends hubs if there are no
>>> active children or port activity.
>>>
>>> There is a delay between the wake signal causing hub resume, and driver
>>> visible port activity on the hub downstream facing ports.
>>> Most of the LFPS handshake, resume signaling and link training done
>>> on the downstream ports is not visible to the hub driver until completed,
>>> when device then will appear fully enabled and running on the port.
>>>
>>> This delay between wake signal and detectable port change is even more
>>> significant with chained suspended hubs where the wake signal will
>>> propagate upstream first. Suspended hubs will only start resuming
>>> downstream ports after upstream facing port resumes.
>>>
>>> The hub driver may resume a USB3 hub, read status of all ports, not
>>> yet see any activity, and runtime suspend back the hub before any
>>> port activity is visible.
>>>
>>> This exact case was seen when conncting USB3 devices to a suspended
>>> Thunderbolt dock.
>>>
>>> USB3 specification defines a 100ms tU3WakeupRetryDelay, indicating
>>> USB3 devices expect to be resumed within 100ms after signaling wake.
>>> if not then device will resend the wake signal.
>>>
>>> Give the USB3 hubs twice this time (200ms) to detect any port
>>> changes after resume, before allowing hub to runtime suspend again.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 2839f5bcfcfc ("USB: Turn on auto-suspend for USB 3.0 hubs.")
>>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>>> ---
>> Hi, this patch seems to cause the following splat on QC
>> SC8280XP CRD board when resuming the system:
>>
>> [root@sc8280xp-crd ~]# ./suspend_test.sh
>> [   37.887029] PM: suspend entry (s2idle)
>> [   37.903850] Filesystems sync: 0.012 seconds
>> [   37.915071] Freezing user space processes
>> [   37.920925] Freezing user space processes completed (elapsed 0.001 seconds)
>> [   37.928138] OOM killer disabled.
>> [   37.931479] Freezing remaining freezable tasks
>> [   37.937476] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>> [   38.397272] Unable to handle kernel paging request at virtual address dead00000000012a
>> [   38.405444] Mem abort info:
>> [   38.408349]   ESR = 0x0000000096000044
>> [   38.412231]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [   38.417712]   SET = 0, FnV = 0
>> [   38.420873]   EA = 0, S1PTW = 0
>> [   38.424133]   FSC = 0x04: level 0 translation fault
>> [   38.429168] Data abort info:
>> [   38.432150]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
>> [   38.437804]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
>> [   38.443014]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> [   38.448495] [dead00000000012a] address between user and kernel address ranges
>> [   38.455852] Internal error: Oops: 0000000096000044 [#1]  SMP
>> [   38.461693] Modules linked in:
>> [   38.464872] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.16.0-rc3-next-20250623-00003-g85d3e4a2835b #12226 NONE
>> [   38.475880] Hardware name: Qualcomm QRD, BIOS 6.0.230525.BOOT.MXF.1.1.c1-00114-MAKENA-1 05/25/2023
>> [   38.485096] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [   38.492263] pc : __run_timer_base+0x1e0/0x330
>> [   38.496784] lr : __run_timer_base+0x1c4/0x330
>> [   38.501291] sp : ffff800080003e80
>> [   38.504718] x29: ffff800080003ee0 x28: ffff800080003e98 x27: dead000000000122
>> [   38.512069] x26: 0000000000000000 x25: 0000000000000000 x24: ffffbc2c54fcdc80
>> [   38.519417] x23: 0000000000000101 x22: ffff0000871002d0 x21: 00000000ffff99c6
>> [   38.526766] x20: ffffbc2c54fc1f08 x19: ffff0001fef65dc0 x18: ffff800080005028
>> [   38.534113] x17: 0000000000000001 x16: ffff0001fef65e60 x15: ffff0001fef65e20
>> [   38.541472] x14: 0000000000000040 x13: ffff0000871002d0 x12: ffff800080003ea0
>> [   38.548819] x11: 00000000e0000cc7 x10: ffffbc2c54f647c8 x9 : ffff800080003e98
>> [   38.556178] x8 : dead000000000122 x7 : 0000000000000000 x6 : ffffbc2c5133c620
>> [   38.563526] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
>> [   38.570884] x2 : 0000000000000079 x1 : 000000000000007b x0 : 0000000000000001
>> [   38.578233] Call trace:
>> [   38.580771]  __run_timer_base+0x1e0/0x330 (P)
>> [   38.585279]  run_timer_softirq+0x40/0x78
>> [   38.589333]  handle_softirqs+0x14c/0x3dc
>> [   38.593404]  __do_softirq+0x1c/0x2c
>> [   38.597025]  ____do_softirq+0x18/0x28
>> [   38.600825]  call_on_irq_stack+0x3c/0x50
>> [   38.604890]  do_softirq_own_stack+0x24/0x34
>> [   38.609220]  __irq_exit_rcu+0xc4/0x174
>> [   38.613108]  irq_exit_rcu+0x18/0x40
>> [   38.616718]  el1_interrupt+0x40/0x5c
>> [   38.620423]  el1h_64_irq_handler+0x20/0x30
>> [   38.624662]  el1h_64_irq+0x6c/0x70
>> [   38.628181]  arch_local_irq_enable+0x8/0xc (P)
>> [   38.632787]  cpuidle_enter+0x40/0x5c
>> [   38.636484]  call_cpuidle+0x24/0x48
>> [   38.640104]  do_idle+0x1a8/0x228
>> [   38.643452]  cpu_startup_entry+0x3c/0x40
>> [   38.647507]  kernel_init+0x0/0x138
>> [   38.651026]  start_kernel+0x334/0x3f0
>> [   38.654828]  __primary_switched+0x90/0x98
>> [   38.658990] Code: 36000428 a94026c8 f9000128 b4000048 (f9000509)
>> [   38.665273] ---[ end trace 0000000000000000 ]---
>> [   38.670045] Kernel panic - not syncing: Oops: Fatal exception in interrupt
>> [   38.677126] SMP: stopping secondary CPUs
>> Waiting for ssh to finish
> 
> Thanks for the report.
> Does reverting this one patch fix the issue?

It seems to, but the bug is not 100% reproducible (sometimes it takes
2+ sus/res cycles to trigger). Alan's change doesn't seem to have a
consistent effect.

> What does ./suspend_test.sh look like?

Nothing special:

# Set up RTC wakeup
echo +10 > /sys/class/rtc/rtc0/wakealarm;
# Go to sleep
echo mem > /sys/power/state

# Dump the AOSS sleep stats
grep ^ /sys/kernel/debug/qcom_stats/*

> Could it be triggered by (system) suspending the hub while the delayed work
> is still pending?

Maybe. What I was able to confirm is that kicking USB nodes off of DT (i.e.
removing USB controllers from the system) makes the platform no longer crash.

Konrad

