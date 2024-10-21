Return-Path: <stable+bounces-87548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E759A6886
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 14:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F20E3B21A20
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A941EBFF2;
	Mon, 21 Oct 2024 12:31:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01241E573C;
	Mon, 21 Oct 2024 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513892; cv=none; b=ZYVu9+tFDKYJIbJ9rJXdxTeM/d30cGuBuo3yGRVTUjIak2sTh3L94aB95hgj41mRYEoZ5S82GbU5dbU1QES6TLGhQiyBzfLPOB/scJfb1t7hQwS1gKLr0AVYAtFmuN0K1dyyavKr8Hwyyi0T4YKh9nczH+CKFSp78b8et4Emy0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513892; c=relaxed/simple;
	bh=m92wye5DSFwxaHNNOjb5jrze6SyyyYf5jrfaCtnsBgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0sGqztXGWsSsZtpeRhEX543wabVleSgqDSccOSoRWqUN1395ni0O9SuzbXf1FpzxHvLyNW7973qwt9QYruMdVtiEXkNMgnBKrGpoL1lHVWg0dI0s7GRxLRxkbZaQWkxrrxlAvYB0hWur/bpbyTkKrLeDYPdZ7kDF7IhX63/mHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A40C9DA7;
	Mon, 21 Oct 2024 05:31:58 -0700 (PDT)
Received: from [10.57.64.219] (unknown [10.57.64.219])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A7BE33F528;
	Mon, 21 Oct 2024 05:31:27 -0700 (PDT)
Message-ID: <b1b17552-646e-42e8-bd00-9c7ae6835612@arm.com>
Date: Mon, 21 Oct 2024 13:31:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] coresight: etm4x: Fix PID tracing when perf is run in
 an init PID namespace
Content-Language: en-GB
To: Julien Meunier <julien.meunier@nokia.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Leo Yan <leo.yan@linux.dev>
Cc: stable@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240925131357.9468-1-julien.meunier@nokia.com>
 <20241008200226.12229-1-julien.meunier@nokia.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20241008200226.12229-1-julien.meunier@nokia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Julien


On 08/10/2024 21:02, Julien Meunier wrote:
> The previous implementation limited the tracing capabilities when perf
> was run in the init PID namespace, making it impossible to trace
> applications in non-init PID namespaces.
> 
> This update improves the tracing process by verifying the event owner.
> This allows us to determine whether the user has the necessary
> permissions to trace the application.
> 
> Cc: stable@vger.kernel.org
> Fixes: aab473867fed ("coresight: etm4x: Don't trace PID for non-root PID namespace")
> Signed-off-by: Julien Meunier <julien.meunier@nokia.com>
> ---
> Changes in v2:
> * Update comments
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 66d44a404ad0..cf41c42399e1 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -693,9 +693,9 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   		config->cfg |= TRCCONFIGR_TS;
>   	}
>   
> -	/* Only trace contextID when runs in root PID namespace */
> +	/* Only trace contextID when the event owner is in root PID namespace */
>   	if ((attr->config & BIT(ETM_OPT_CTXTID)) &&
> -	    task_is_in_init_pid_ns(current))
> +	    task_is_in_init_pid_ns(event->owner))
>   		/* bit[6], Context ID tracing bit */
>   		config->cfg |= TRCCONFIGR_CID;
>   
> @@ -709,8 +709,8 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   			ret = -EINVAL;
>   			goto out;
>   		}
> -		/* Only trace virtual contextID when runs in root PID namespace */
> -		if (task_is_in_init_pid_ns(current))
> +		/* Only trace virtual contextID when the event owner is in root PID namespace */
> +		if (task_is_in_init_pid_ns(event->owner))
>   			config->cfg |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;

Unfortunately this is not safe. i.e., event->owner is not guaranteed to
be stable (even NULL or an invalid pointer) (e.g. kernel created events 
or task exit raced event_start on another CPU).

That said, one thing to note is that the ETM4x driver parses the event 
config in each "event_start" call back, instead of doing once during the
event_init. If we move this to a onetime parsing at the event_init, with
additional checks in place (e.g, !is_kernel_event()), we may be able to
solve it.


e.g., I hit the following on my Juno, while running basic perf session:

$ perf record -e cs_et//u -m ,256M -- /multi-threaded-workload



---8>---

[  243.467425] Unable to handle kernel NULL pointer dereference at 
virtual address 00000000000004b8
[  243.475288] Mem abort info:
[  243.475295]   ESR = 0x0000000096000006
[  243.484097] Mem abort info:
[  243.486890]   EC = 0x25: DABT (current EL), IL = 32 bits
[  243.490644]   ESR = 0x0000000096000006
[  243.493438]   SET = 0, FnV = 0
[  243.498757]   EC = 0x25: DABT (current EL), IL = 32 bits
[  243.502508]   EA = 0, S1PTW = 0
[  243.505564]   SET = 0, FnV = 0
[  243.510882]   FSC = 0x06: level 2 translation fault
[  243.514025]   EA = 0, S1PTW = 0
[  243.517080] Data abort info:
[  243.521962]   FSC = 0x06: level 2 translation fault
[  243.525104]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[  243.527986] Data abort info:
[  243.532868]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  243.538360]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[  243.541242]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  243.546299]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  243.551791] user pgtable: 4k pages, 39-bit VAs, pgdp=0000000906d25000
[  243.557109]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  243.562166] [00000000000004b8] pgd=0800000906d2b003
[  243.568615] user pgtable: 4k pages, 39-bit VAs, pgdp=0000000906d25000
[  243.573933] , p4d=0800000906d2b003
[  243.578816] [00000000000004b8] pgd=0800000906d2b003
[  243.585265] , pud=0800000906d2b003
[  243.588668] , p4d=0800000906d2b003
[  243.593551] , pmd=0000000000000000
[  243.596954] , pud=0800000906d2b003
[  243.600356]
[  243.603760] , pmd=0000000000000000
[  243.607165] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
[  243.608653]
[  243.612058] Modules linked in: coresight_cti coresight_cpu_debug 
coresight_stm coresight_etm4x coresight_tmc coresight_replicator 
coresight_funnel coresight_tpiu coresight ip_tables x_tables ipv6
[  243.637327] CPU: 1 UID: 0 PID: 413 Comm: sort-thread Not tainted 
6.12.0-rc4+ #286
[  243.644839] Hardware name: ARM LTD ARM Juno Development Platform/ARM 
Juno Development Platform, BIOS EDK II Feb  1 2019
[  243.655649] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[  243.662637] pc : task_active_pid_ns+0x8/0x28
[  243.666937] lr : etm4_enable+0x538/0x7a8 [coresight_etm4x]
[  243.672459] sp : ffffffc0859a3b20
[  243.675783] x29: ffffffc0859a3b20 x28: 0000000000000001 x27: 
ffffff880701bfb0
[  243.682959] x26: ffffff8804dad900 x25: ffffff88045b4e08 x24: 
ffffff88045b4d30
[  243.690132] x23: ffffff880732c080 x22: ffffff8804cf6d08 x21: 
ffffff880732c118
[  243.697305] x20: ffffff880732a800 x19: 0000000000000000 x18: 
0000000000000000
[  243.704477] x17: 000000000000004a x16: 0000000000000075 x15: 
0000000000000007
[  243.711649] x14: 0000000000000131 x13: 0000019d0000019b x12: 
003000000000000c
[  243.718822] x11: 000000000000004a x10: 0000000000001790 x9 : 
ffffffc07bd1a2a0
[  243.725995] x8 : ffffff8805c1ab70 x7 : 0000000000000000 x6 : 
ffffff8802ba6d80
[  243.733167] x5 : 0000000000000000 x4 : ffffff8805c1ab70 x3 : 
ffffff8807a53c80
[  243.740339] x2 : 0000000000004000 x1 : ffffff8807a53c80 x0 : 
0000000000000000
[  243.747511] Call trace:
[  243.749964]  task_active_pid_ns+0x8/0x28
[  243.753911]  etm_event_start+0x160/0x208 [coresight]
[  243.758926]  etm_event_add+0x48/0x78 [coresight]
[  243.763587]  event_sched_in+0xc8/0x1a8
[  243.767357]  merge_sched_in+0x1e4/0x578
[  243.771213]  visit_groups_merge.constprop.0.isra.0+0x20c/0x4d8
[  243.777071]  ctx_sched_in+0x1c8/0x250
[  243.780750]  perf_event_sched_in+0x68/0xa8
[  243.784866]  __perf_event_task_sched_in+0x1dc/0x360
[  243.789765]  finish_task_switch.isra.0+0x13c/0x2f8
[  243.794576]  schedule_tail+0x1c/0xc8
[  243.798169]  ret_from_fork+0x4/0x20
[  243.801681] Code: 811705e8 ffffffc0 aa1e03e9 d503201f (f9425c00)
[  243.807791] ---[ end trace 0000000000000000 ]---
[  259.636480] Kernel panic - not syncing: Oops: Fatal exception
[  259.642246] SMP: stopping secondary CPUs
[  260.806180] SMP: failed to stop secondary CPUs 2-4
[  260.810992] Kernel Offset: disabled
[  260.814488] CPU features: 0x08,c0000043,40200000,0200421b
[  260.819902] Memory Limit: none
[  277.740579] ---[ end Kernel panic - not syncing: Oops: Fatal 
exception ]---

>   	}
>   


