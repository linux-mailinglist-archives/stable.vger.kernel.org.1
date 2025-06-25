Return-Path: <stable+bounces-158604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB30AE8788
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 17:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C7217546C
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CAF26A0AB;
	Wed, 25 Jun 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UY1Xpoop"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1107C263F40;
	Wed, 25 Jun 2025 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864274; cv=none; b=dk0cbm/C2EpMXQueLZiOFEXqyZJTJPxUqLHDoNNP3hhaytckzo4rTt+uAF6PSmEtrmV+T4AWLT0guYcrLHoWXjsko3Z0UiaoRup/+eka3FduoJdZmonKBFt+6zQ4l+mqYD/kn2MOqXOrNW7Ni/fX0ChREAK19/nmuVAmpLQjEpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864274; c=relaxed/simple;
	bh=ZvhfCYM3KxG47BaRpGbI8s1R7i1lYFhYIexVDWca3QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pchf5IMl9V0+M8EOLIkVUVNaZf4VBaCW0AXYtACQq+v5GBVSl5jR6bMIN6+GuuhIKvBPASevvbRiBVMt3vws5IMUqjKZ48Dak6oN8POsVHwOwCrXqT/GO9ye2wG/bP8ZBxicRHVB5NvL2Vj/aRV4Hf+8rOPuws101wOo1l9nKwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UY1Xpoop; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750864273; x=1782400273;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZvhfCYM3KxG47BaRpGbI8s1R7i1lYFhYIexVDWca3QQ=;
  b=UY1Xpoopn4C3II3mz5NREPQPgTo6VfSyKAEg72Mun3XpiSAp41Tpz0m9
   uFVexlFsvCdAIE7tcfOBAgvKNXMa9PtGSkttggs+KyGsmazuW7o0Hp9tW
   Wky6YxJ1C2IH/hg4pO434OobIGHwYaIrmhdRjYOFd0rB+Mq42Jy3vgVAr
   DQtUAtffeDX3BuAekUOFJ9y6dLAeUufFwweNgvbwoq67nBaah3kRqqol6
   XBIk72aO0UzL2vnSQCHEggg2G2xA18y9bBTdkkjlg/pidP+CpWasFedpz
   jAO5rAPxOCR9e9xxGznhEKnaf6nkNLfuxG3PMdoGCC1412SF68NszhSM4
   Q==;
X-CSE-ConnectionGUID: ixxZUyP0SwOUNeswruuTpw==
X-CSE-MsgGUID: vRxsDw04TBmWTLiTf98iEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="56819558"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="56819558"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 08:11:13 -0700
X-CSE-ConnectionGUID: GLP+cuaJQ2WG9gUA2C/qEw==
X-CSE-MsgGUID: ES3/B24lTX2FPEgGJS1Knw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="157742213"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jun 2025 08:11:10 -0700
Message-ID: <c9584bc8-bb9f-41f9-af3c-b606b4e4ee06@linux.intel.com>
Date: Wed, 25 Jun 2025 18:11:09 +0300
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
 <c8ea2d32-4e8e-49da-9d75-000d34f8e819@linux.intel.com>
 <67d4d34a-a15f-47b1-9238-d4d6792b89e5@oss.qualcomm.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <67d4d34a-a15f-47b1-9238-d4d6792b89e5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.6.2025 19.40, Konrad Dybcio wrote:
> On 6/24/25 11:47 AM, Mathias Nyman wrote:
>> On 23.6.2025 23.31, Konrad Dybcio wrote:
>>> On 6/11/25 1:24 PM, Mathias Nyman wrote:

>>> Hi, this patch seems to cause the following splat on QC
>>> SC8280XP CRD board when resuming the system:
>>>
>>> [root@sc8280xp-crd ~]# ./suspend_test.sh
>>> [   37.887029] PM: suspend entry (s2idle)
>>> [   37.903850] Filesystems sync: 0.012 seconds
>>> [   37.915071] Freezing user space processes
>>> [   37.920925] Freezing user space processes completed (elapsed 0.001 seconds)
>>> [   37.928138] OOM killer disabled.
>>> [   37.931479] Freezing remaining freezable tasks
>>> [   37.937476] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>>> [   38.397272] Unable to handle kernel paging request at virtual address dead00000000012a
>>> [   38.405444] Mem abort info:
>>> [   38.408349]   ESR = 0x0000000096000044
>>> [   38.412231]   EC = 0x25: DABT (current EL), IL = 32 bits
>>> [   38.417712]   SET = 0, FnV = 0
>>> [   38.420873]   EA = 0, S1PTW = 0
>>> [   38.424133]   FSC = 0x04: level 0 translation fault
>>> [   38.429168] Data abort info:
>>> [   38.432150]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
>>> [   38.437804]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
>>> [   38.443014]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>> [   38.448495] [dead00000000012a] address between user and kernel address ranges
>>> [   38.455852] Internal error: Oops: 0000000096000044 [#1]  SMP
>>> [   38.461693] Modules linked in:
>>> [   38.464872] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.16.0-rc3-next-20250623-00003-g85d3e4a2835b #12226 NONE
>>> [   38.475880] Hardware name: Qualcomm QRD, BIOS 6.0.230525.BOOT.MXF.1.1.c1-00114-MAKENA-1 05/25/2023
>>> [   38.485096] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [   38.492263] pc : __run_timer_base+0x1e0/0x330
>>> [   38.496784] lr : __run_timer_base+0x1c4/0x330
>>> [   38.501291] sp : ffff800080003e80
>>> [   38.504718] x29: ffff800080003ee0 x28: ffff800080003e98 x27: dead000000000122
>>> [   38.512069] x26: 0000000000000000 x25: 0000000000000000 x24: ffffbc2c54fcdc80
>>> [   38.519417] x23: 0000000000000101 x22: ffff0000871002d0 x21: 00000000ffff99c6
>>> [   38.526766] x20: ffffbc2c54fc1f08 x19: ffff0001fef65dc0 x18: ffff800080005028
>>> [   38.534113] x17: 0000000000000001 x16: ffff0001fef65e60 x15: ffff0001fef65e20
>>> [   38.541472] x14: 0000000000000040 x13: ffff0000871002d0 x12: ffff800080003ea0
>>> [   38.548819] x11: 00000000e0000cc7 x10: ffffbc2c54f647c8 x9 : ffff800080003e98
>>> [   38.556178] x8 : dead000000000122 x7 : 0000000000000000 x6 : ffffbc2c5133c620
>>> [   38.563526] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
>>> [   38.570884] x2 : 0000000000000079 x1 : 000000000000007b x0 : 0000000000000001
>>> [   38.578233] Call trace:
>>> [   38.580771]  __run_timer_base+0x1e0/0x330 (P)
>>> [   38.585279]  run_timer_softirq+0x40/0x78
>>> [   38.589333]  handle_softirqs+0x14c/0x3dc
>>> [   38.593404]  __do_softirq+0x1c/0x2c
>>> [   38.597025]  ____do_softirq+0x18/0x28
>>> [   38.600825]  call_on_irq_stack+0x3c/0x50
>>> [   38.604890]  do_softirq_own_stack+0x24/0x34
>>> [   38.609220]  __irq_exit_rcu+0xc4/0x174
>>> [   38.613108]  irq_exit_rcu+0x18/0x40
>>> [   38.616718]  el1_interrupt+0x40/0x5c
>>> [   38.620423]  el1h_64_irq_handler+0x20/0x30
>>> [   38.624662]  el1h_64_irq+0x6c/0x70
>>> [   38.628181]  arch_local_irq_enable+0x8/0xc (P)
>>> [   38.632787]  cpuidle_enter+0x40/0x5c
>>> [   38.636484]  call_cpuidle+0x24/0x48
>>> [   38.640104]  do_idle+0x1a8/0x228
>>> [   38.643452]  cpu_startup_entry+0x3c/0x40
>>> [   38.647507]  kernel_init+0x0/0x138
>>> [   38.651026]  start_kernel+0x334/0x3f0
>>> [   38.654828]  __primary_switched+0x90/0x98
>>> [   38.658990] Code: 36000428 a94026c8 f9000128 b4000048 (f9000509)
>>> [   38.665273] ---[ end trace 0000000000000000 ]---
>>> [   38.670045] Kernel panic - not syncing: Oops: Fatal exception in interrupt
>>> [   38.677126] SMP: stopping secondary CPUs
>>> Waiting for ssh to finish
>>
>> Thanks for the report.
>> Does reverting this one patch fix the issue?
> 
> It seems to, but the bug is not 100% reproducible (sometimes it takes
> 2+ sus/res cycles to trigger). Alan's change doesn't seem to have a
> consistent effect.
> 
>> What does ./suspend_test.sh look like?
> 
> Nothing special:
> 
> # Set up RTC wakeup
> echo +10 > /sys/class/rtc/rtc0/wakealarm;
> # Go to sleep
> echo mem > /sys/power/state
> 
> # Dump the AOSS sleep stats
> grep ^ /sys/kernel/debug/qcom_stats/*
> 

I added some memory debugging but wasn't able to trigger this.

Does this oneliner help? It's a shot in the dark.

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index d41a6c239953..1cc853c428fc 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1418,6 +1418,7 @@ static void hub_quiesce(struct usb_hub *hub, enum hub_quiescing_type type)
  
	/* Stop hub_wq and related activity */
	timer_delete_sync(&hub->irq_urb_retry);
+	flush_delayed_work(&hub->init_work);
	usb_kill_urb(hub->urb);
	if (hub->has_indicators)
		cancel_delayed_work_sync(&hub->leds);


If not, then could you add 'initcall_debug' to kernel cmd line, and usb core
dynamic debug before suspend test

mount -t debugfs none /sys/kernel/debug
echo 'module usbcore =p' >/sys/kernel/debug/dynamic_debug/control

Also curious about lsusb -t output

Thanks
Mathias


