Return-Path: <stable+bounces-196987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B98AC891E1
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 10:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729C53B66D2
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 09:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496AD320CA2;
	Wed, 26 Nov 2025 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TKo8Ydkz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31433320A32;
	Wed, 26 Nov 2025 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764150637; cv=none; b=nvESxdmUYAQ5sszqQ35lnOXQ/R9C/Rb6xBKNS1+KX9Mvj64Gc6TpXIfufF+zrLg4dof7jwwlqNDmiIjqDg+XTvVd9VsR6O9wowIVasb784jDIGznWUWN0PYuIo0/mjdr2ViuWgNfn//Zfyp9sWsGEFwXAPffQdkDvp5ORG9JemI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764150637; c=relaxed/simple;
	bh=njWROoXaInge3OibSMvthGyMUZf/RJpqVOM51CCCZXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWw4VSsEBn2Dx3OtZN/QeNdZnaEfBaTYJlnG7mJ+REAPcOuRqYxzSP2Q3akIlC/mBcGSO47e5R088HGDQU5iRbdz4gPi8nm35RayAeApR8JMwRIObG1weIo1rYZcdQei9J6Fi1CD+lB0WhLxH/PZlPUArVyGTLFGY77Gz4ldVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TKo8Ydkz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764150635; x=1795686635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=njWROoXaInge3OibSMvthGyMUZf/RJpqVOM51CCCZXE=;
  b=TKo8YdkzGXLi7iLJXr1X7YFmnFyQDpUKHHE7fhjyVPPRt/FIvo8yMH8Q
   US2LWxMaYEN49Ei3X4K0YGJVHmmJplu5Tkb9wVbLK5VzUOidlOg/pMxww
   l5tpF5vnIkd1z+HErLvAHJuGdupeCjOz9Inuy16Yj/v40tmX99RT34nrb
   tc/rVsvn0UNx/OknK/926iGS0yJxGYfmjxcMgj85UtDLjADEUMH+mxhqk
   3ecqGTFXkFjDC3awhBxSLQRKUXrXnZiS6/aTlNp1hP83KQei3EVTVBH4u
   aaNQC39uQJKsJdo3de4BUfqBNjbI3mfjweNtPzC/Pil281vYaAYHWzhju
   A==;
X-CSE-ConnectionGUID: FD2IZUBnTVugDMWxSP1WdQ==
X-CSE-MsgGUID: rUxsm3uFQcKy7+go36e+Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="83793870"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="83793870"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 01:50:34 -0800
X-CSE-ConnectionGUID: k3bAcW1WQUOv2cSMLtq6mQ==
X-CSE-MsgGUID: lOBdngQ6Q+yBYr5uci4OVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="192148937"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO kuha) ([10.124.223.25])
  by orviesa010.jf.intel.com with SMTP; 26 Nov 2025 01:50:30 -0800
Received: by kuha (sSMTP sendmail emulation); Wed, 26 Nov 2025 11:50:24 +0200
Date: Wed, 26 Nov 2025 11:50:24 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	mitltlatltl@gmail.com, linux-kernel@vger.kernel.org,
	sergei.shtylyov@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: ucsi: fix use-after-free caused by
 uec->work
Message-ID: <aSbNYJKpTI1V4LFV@kuha>
References: <cover.1764065838.git.duoming@zju.edu.cn>
 <cc31e12ef9ffbf86676585b02233165fd33f0d8e.1764065838.git.duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc31e12ef9ffbf86676585b02233165fd33f0d8e.1764065838.git.duoming@zju.edu.cn>

Tue, Nov 25, 2025 at 06:36:27PM +0800, Duoming Zhou kirjoitti:
> The delayed work uec->work is scheduled in gaokun_ucsi_probe()
> but never properly canceled in gaokun_ucsi_remove(). This creates
> use-after-free scenarios where the ucsi and gaokun_ucsi structure
> are freed after ucsi_destroy() completes execution, while the
> gaokun_ucsi_register_worker() might be either currently executing
> or still pending in the work queue. The already-freed gaokun_ucsi
> or ucsi structure may then be accessed.
> 
> Furthermore, the race window is 3 seconds, which is sufficiently
> long to make this bug easily reproducible. The following is the
> trace captured by KASAN:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in __run_timers+0x5ec/0x630
> Write of size 8 at addr ffff00000ec28cc8 by task swapper/0/0
> ...
> Call trace:
>  show_stack+0x18/0x24 (C)
>  dump_stack_lvl+0x78/0x90
>  print_report+0x114/0x580
>  kasan_report+0xa4/0xf0
>  __asan_report_store8_noabort+0x20/0x2c
>  __run_timers+0x5ec/0x630
>  run_timer_softirq+0xe8/0x1cc
>  handle_softirqs+0x294/0x720
>  __do_softirq+0x14/0x20
>  ____do_softirq+0x10/0x1c
>  call_on_irq_stack+0x30/0x48
>  do_softirq_own_stack+0x1c/0x28
>  __irq_exit_rcu+0x27c/0x364
>  irq_exit_rcu+0x10/0x1c
>  el1_interrupt+0x40/0x60
>  el1h_64_irq_handler+0x18/0x24
>  el1h_64_irq+0x6c/0x70
>  arch_local_irq_enable+0x4/0x8 (P)
>  do_idle+0x334/0x458
>  cpu_startup_entry+0x60/0x70
>  rest_init+0x158/0x174
>  start_kernel+0x2f8/0x394
>  __primary_switched+0x8c/0x94
> 
> Allocated by task 72 on cpu 0 at 27.510341s:
>  kasan_save_stack+0x2c/0x54
>  kasan_save_track+0x24/0x5c
>  kasan_save_alloc_info+0x40/0x54
>  __kasan_kmalloc+0xa0/0xb8
>  __kmalloc_node_track_caller_noprof+0x1c0/0x588
>  devm_kmalloc+0x7c/0x1c8
>  gaokun_ucsi_probe+0xa0/0x840  auxiliary_bus_probe+0x94/0xf8
>  really_probe+0x17c/0x5b8
>  __driver_probe_device+0x158/0x2c4
>  driver_probe_device+0x10c/0x264
>  __device_attach_driver+0x168/0x2d0
>  bus_for_each_drv+0x100/0x188
>  __device_attach+0x174/0x368
>  device_initial_probe+0x14/0x20
>  bus_probe_device+0x120/0x150
>  device_add+0xb3c/0x10fc
>  __auxiliary_device_add+0x88/0x130
> ...
> 
> Freed by task 73 on cpu 1 at 28.910627s:
>  kasan_save_stack+0x2c/0x54
>  kasan_save_track+0x24/0x5c
>  __kasan_save_free_info+0x4c/0x74
>  __kasan_slab_free+0x60/0x8c
>  kfree+0xd4/0x410
>  devres_release_all+0x140/0x1f0
>  device_unbind_cleanup+0x20/0x190
>  device_release_driver_internal+0x344/0x460
>  device_release_driver+0x18/0x24
>  bus_remove_device+0x198/0x274
>  device_del+0x310/0xa84
> ...
> 
> The buggy address belongs to the object at ffff00000ec28c00
>  which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 200 bytes inside of
>  freed 512-byte region
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4ec28
> head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0x3fffe0000000040(head|node=0|zone=0|lastcpupid=0x1ffff)
> page_type: f5(slab)
> raw: 03fffe0000000040 ffff000008801c80 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
> head: 03fffe0000000040 ffff000008801c80 dead000000000122 0000000000000000
> head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
> head: 03fffe0000000002 fffffdffc03b0a01 00000000ffffffff 00000000ffffffff
> head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff00000ec28b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff00000ec28c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff00000ec28c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                               ^
>  ffff00000ec28d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff00000ec28d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> Add disable_delayed_work_sync() in gaokun_ucsi_remove() to ensure
> that uec->work is properly canceled and prevented from executing
> after the ucsi and gaokun_ucsi structure have been deallocated.
> 
> Fixes: 00327d7f2c8c ("usb: typec: ucsi: add Huawei Matebook E Go ucsi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> index 8401ab414bd..c5965656bab 100644
> --- a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> +++ b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> @@ -503,6 +503,7 @@ static void gaokun_ucsi_remove(struct auxiliary_device *adev)
>  {
>  	struct gaokun_ucsi *uec = auxiliary_get_drvdata(adev);
>  
> +	disable_delayed_work_sync(&uec->work);
>  	gaokun_ec_unregister_notify(uec->ec, &uec->nb);
>  	ucsi_unregister(uec->ucsi);
>  	ucsi_destroy(uec->ucsi);
> -- 
> 2.34.1

-- 
heikki

