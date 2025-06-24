Return-Path: <stable+bounces-158354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50230AE6143
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 11:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5249D4004DE
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 09:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1893B27F4D0;
	Tue, 24 Jun 2025 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d44DNG/7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD82527C872;
	Tue, 24 Jun 2025 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750758483; cv=none; b=skvui9bbMeQzeYQ62lQIH6yvACclcyjddJEqRMKzLgXfQqgc63d32a3PQCWFwD7GHiG8dMTmrDdbQnBjCljzVmkGRao+uz37/qohi3IelQFXwc0oHrGsoKAzZiVjqsVYQnePGg65vhKp0rI6/uQ4QmE2ve8PX7A0Tcdpgaz28HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750758483; c=relaxed/simple;
	bh=n///fGtdSpT8h/Nj1JMZbBb3xfu39BaKeTW5evsEsKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/Y8quoVBWrNLJXtk1cyxCKVzfKNfFWj5DIopV6ikR2J4+lYomnf14dCc5sdBXv8dgHPbVPquZtL+b+HzKOcqHRXHyO0R185gCuF8hyNwJgB7Ka2frZsS9Ax38Xbtpsch4IO98S9fwspcHv2bhI3oZX/IFxSTE3SSBZ/pIwSNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d44DNG/7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750758482; x=1782294482;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n///fGtdSpT8h/Nj1JMZbBb3xfu39BaKeTW5evsEsKU=;
  b=d44DNG/71Gq+FIfgOuS6egt/CsS0rdkQbP/ugHEr7T2RClPDmL+KS0ve
   KKpPADBuzfZFvTTX/iIywPBehvjQ95fsYa/u88mI0AB1OH73FZ1ZFvq9B
   2jyUhnmU2Xp41uVFFGJ+afspu6hYB3Q5CAAEl+vL25LXFZ1buAPwA8I42
   DG3zaEKWQvH37yA6uDIOAlP8FqA7btftVJA1zTVZh0gY521JJnVSM8KO3
   EKNHSwh6gn6DT0GA1LzHPcM2fDaQqP5KFwd5r9eDtEiJkDb1jEb6WFX8y
   S8tih5bFf4O/sbzU2k9KlMCrYIVaB50xaxk7WbVpuVm6ZH/XJ9OTZsmTr
   w==;
X-CSE-ConnectionGUID: gqmbEGtATtqKOK9YHv9g+w==
X-CSE-MsgGUID: KnOvG5cuSWKMxBQdTs1Sww==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53061607"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="53061607"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 02:48:01 -0700
X-CSE-ConnectionGUID: jMsvlTdwSxS0oMShpnmc/g==
X-CSE-MsgGUID: 8uBVQj0YRLOvVc8yFHjqSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="151463620"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa007.fm.intel.com with ESMTP; 24 Jun 2025 02:47:59 -0700
Message-ID: <c8ea2d32-4e8e-49da-9d75-000d34f8e819@linux.intel.com>
Date: Tue, 24 Jun 2025 12:47:57 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: hub: fix detection of high tier USB3 devices
 behind suspended hubs
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu, oneukum@suse.com,
 stable@vger.kernel.org, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
References: <20250611112441.2267883-1-mathias.nyman@linux.intel.com>
 <acaaa928-832c-48ca-b0ea-d202d5cd3d6c@oss.qualcomm.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <acaaa928-832c-48ca-b0ea-d202d5cd3d6c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.6.2025 23.31, Konrad Dybcio wrote:
> On 6/11/25 1:24 PM, Mathias Nyman wrote:
>> USB3 devices connected behind several external suspended hubs may not
>> be detected when plugged in due to aggressive hub runtime pm suspend.
>>
>> The hub driver immediately runtime-suspends hubs if there are no
>> active children or port activity.
>>
>> There is a delay between the wake signal causing hub resume, and driver
>> visible port activity on the hub downstream facing ports.
>> Most of the LFPS handshake, resume signaling and link training done
>> on the downstream ports is not visible to the hub driver until completed,
>> when device then will appear fully enabled and running on the port.
>>
>> This delay between wake signal and detectable port change is even more
>> significant with chained suspended hubs where the wake signal will
>> propagate upstream first. Suspended hubs will only start resuming
>> downstream ports after upstream facing port resumes.
>>
>> The hub driver may resume a USB3 hub, read status of all ports, not
>> yet see any activity, and runtime suspend back the hub before any
>> port activity is visible.
>>
>> This exact case was seen when conncting USB3 devices to a suspended
>> Thunderbolt dock.
>>
>> USB3 specification defines a 100ms tU3WakeupRetryDelay, indicating
>> USB3 devices expect to be resumed within 100ms after signaling wake.
>> if not then device will resend the wake signal.
>>
>> Give the USB3 hubs twice this time (200ms) to detect any port
>> changes after resume, before allowing hub to runtime suspend again.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 2839f5bcfcfc ("USB: Turn on auto-suspend for USB 3.0 hubs.")
>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>> ---
> Hi, this patch seems to cause the following splat on QC
> SC8280XP CRD board when resuming the system:
> 
> [root@sc8280xp-crd ~]# ./suspend_test.sh
> [   37.887029] PM: suspend entry (s2idle)
> [   37.903850] Filesystems sync: 0.012 seconds
> [   37.915071] Freezing user space processes
> [   37.920925] Freezing user space processes completed (elapsed 0.001 seconds)
> [   37.928138] OOM killer disabled.
> [   37.931479] Freezing remaining freezable tasks
> [   37.937476] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [   38.397272] Unable to handle kernel paging request at virtual address dead00000000012a
> [   38.405444] Mem abort info:
> [   38.408349]   ESR = 0x0000000096000044
> [   38.412231]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   38.417712]   SET = 0, FnV = 0
> [   38.420873]   EA = 0, S1PTW = 0
> [   38.424133]   FSC = 0x04: level 0 translation fault
> [   38.429168] Data abort info:
> [   38.432150]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
> [   38.437804]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> [   38.443014]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [   38.448495] [dead00000000012a] address between user and kernel address ranges
> [   38.455852] Internal error: Oops: 0000000096000044 [#1]  SMP
> [   38.461693] Modules linked in:
> [   38.464872] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.16.0-rc3-next-20250623-00003-g85d3e4a2835b #12226 NONE
> [   38.475880] Hardware name: Qualcomm QRD, BIOS 6.0.230525.BOOT.MXF.1.1.c1-00114-MAKENA-1 05/25/2023
> [   38.485096] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   38.492263] pc : __run_timer_base+0x1e0/0x330
> [   38.496784] lr : __run_timer_base+0x1c4/0x330
> [   38.501291] sp : ffff800080003e80
> [   38.504718] x29: ffff800080003ee0 x28: ffff800080003e98 x27: dead000000000122
> [   38.512069] x26: 0000000000000000 x25: 0000000000000000 x24: ffffbc2c54fcdc80
> [   38.519417] x23: 0000000000000101 x22: ffff0000871002d0 x21: 00000000ffff99c6
> [   38.526766] x20: ffffbc2c54fc1f08 x19: ffff0001fef65dc0 x18: ffff800080005028
> [   38.534113] x17: 0000000000000001 x16: ffff0001fef65e60 x15: ffff0001fef65e20
> [   38.541472] x14: 0000000000000040 x13: ffff0000871002d0 x12: ffff800080003ea0
> [   38.548819] x11: 00000000e0000cc7 x10: ffffbc2c54f647c8 x9 : ffff800080003e98
> [   38.556178] x8 : dead000000000122 x7 : 0000000000000000 x6 : ffffbc2c5133c620
> [   38.563526] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> [   38.570884] x2 : 0000000000000079 x1 : 000000000000007b x0 : 0000000000000001
> [   38.578233] Call trace:
> [   38.580771]  __run_timer_base+0x1e0/0x330 (P)
> [   38.585279]  run_timer_softirq+0x40/0x78
> [   38.589333]  handle_softirqs+0x14c/0x3dc
> [   38.593404]  __do_softirq+0x1c/0x2c
> [   38.597025]  ____do_softirq+0x18/0x28
> [   38.600825]  call_on_irq_stack+0x3c/0x50
> [   38.604890]  do_softirq_own_stack+0x24/0x34
> [   38.609220]  __irq_exit_rcu+0xc4/0x174
> [   38.613108]  irq_exit_rcu+0x18/0x40
> [   38.616718]  el1_interrupt+0x40/0x5c
> [   38.620423]  el1h_64_irq_handler+0x20/0x30
> [   38.624662]  el1h_64_irq+0x6c/0x70
> [   38.628181]  arch_local_irq_enable+0x8/0xc (P)
> [   38.632787]  cpuidle_enter+0x40/0x5c
> [   38.636484]  call_cpuidle+0x24/0x48
> [   38.640104]  do_idle+0x1a8/0x228
> [   38.643452]  cpu_startup_entry+0x3c/0x40
> [   38.647507]  kernel_init+0x0/0x138
> [   38.651026]  start_kernel+0x334/0x3f0
> [   38.654828]  __primary_switched+0x90/0x98
> [   38.658990] Code: 36000428 a94026c8 f9000128 b4000048 (f9000509)
> [   38.665273] ---[ end trace 0000000000000000 ]---
> [   38.670045] Kernel panic - not syncing: Oops: Fatal exception in interrupt
> [   38.677126] SMP: stopping secondary CPUs
> Waiting for ssh to finish

Thanks for the report.
Does reverting this one patch fix the issue?

What does ./suspend_test.sh look like?
Could it be triggered by (system) suspending the hub while the delayed work
is still pending?

Thanks
Mathias

