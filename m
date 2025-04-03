Return-Path: <stable+bounces-127641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3A0A7A6A8
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979231897BB3
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21798250C0C;
	Thu,  3 Apr 2025 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PRJK2XUr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D065624E4B2;
	Thu,  3 Apr 2025 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693938; cv=none; b=hq+3ghxs7Gnt9fjau0RyvwEf1CcZ7CHxoPRclJXYW9ZI+YSkUv9ZlETK4NtIJEcYnABrQhro0C45QW3P5z27i0DMvacjtxRJfdb2apjT1/Mtwlnz7b4ErBpjh7X+BDPRVSwkQrXnnouV+M1zUKl1bz2Vy9lnxxhd7LOu8wGYGoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693938; c=relaxed/simple;
	bh=CRVaRGSmh6oBIc71dOY+rKwcTPgB4Fk65RaLimeUPYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJoywVqFrVcAFUJbzLAZKeWsDyDqO8iK6L8hlNQ3YZlx5HVPRx89Qsmcsl3bIb5dOTiCz9lept1bvQy5ubN8PgCNyTwCIKk36JpbbCN4JpMfc2SWDrSCPSkam6/x5l845KUL2Y/29D9jYVKScUrA7CGXzVaExP5s68d2Q1ZAmK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PRJK2XUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D1AC4CEE3;
	Thu,  3 Apr 2025 15:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743693938;
	bh=CRVaRGSmh6oBIc71dOY+rKwcTPgB4Fk65RaLimeUPYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRJK2XUrwxJJ85OEvCROaRVb/YvL+NMS71n2kMWBEb5zY33TqYEdGCGhZqhY4yiZh
	 o7AobQd4/gSa8KYBx4hUUmn49vIYmG6EdGFZH5ggRZKEZLPjIhmeHg15qCwO/l+OhF
	 V3D6p6tXgwebBF0ITffzmKnjr74LQsN4fTZ3aErA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luo Qiu <luoqiu@kylinsec.com.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.13 19/23] memstick: rtsx_usb_ms: Fix slab-use-after-free in rtsx_usb_ms_drv_remove
Date: Thu,  3 Apr 2025 16:20:36 +0100
Message-ID: <20250403151622.828001456@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403151622.273788569@linuxfoundation.org>
References: <20250403151622.273788569@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luo Qiu <luoqiu@kylinsec.com.cn>

commit 4676741a3464b300b486e70585c3c9b692be1632 upstream.

This fixes the following crash:

==================================================================
BUG: KASAN: slab-use-after-free in rtsx_usb_ms_poll_card+0x159/0x200 [rtsx_usb_ms]
Read of size 8 at addr ffff888136335380 by task kworker/6:0/140241

CPU: 6 UID: 0 PID: 140241 Comm: kworker/6:0 Kdump: loaded Tainted: G            E      6.14.0-rc6+ #1
Tainted: [E]=UNSIGNED_MODULE
Hardware name: LENOVO 30FNA1V7CW/1057, BIOS S0EKT54A 07/01/2024
Workqueue: events rtsx_usb_ms_poll_card [rtsx_usb_ms]
Call Trace:
 <TASK>
 dump_stack_lvl+0x51/0x70
 print_address_description.constprop.0+0x27/0x320
 ? rtsx_usb_ms_poll_card+0x159/0x200 [rtsx_usb_ms]
 print_report+0x3e/0x70
 kasan_report+0xab/0xe0
 ? rtsx_usb_ms_poll_card+0x159/0x200 [rtsx_usb_ms]
 rtsx_usb_ms_poll_card+0x159/0x200 [rtsx_usb_ms]
 ? __pfx_rtsx_usb_ms_poll_card+0x10/0x10 [rtsx_usb_ms]
 ? __pfx___schedule+0x10/0x10
 ? kick_pool+0x3b/0x270
 process_one_work+0x357/0x660
 worker_thread+0x390/0x4c0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x190/0x1d0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2d/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 161446:
 kasan_save_stack+0x20/0x40
 kasan_save_track+0x10/0x30
 __kasan_kmalloc+0x7b/0x90
 __kmalloc_noprof+0x1a7/0x470
 memstick_alloc_host+0x1f/0xe0 [memstick]
 rtsx_usb_ms_drv_probe+0x47/0x320 [rtsx_usb_ms]
 platform_probe+0x60/0xe0
 call_driver_probe+0x35/0x120
 really_probe+0x123/0x410
 __driver_probe_device+0xc7/0x1e0
 driver_probe_device+0x49/0xf0
 __device_attach_driver+0xc6/0x160
 bus_for_each_drv+0xe4/0x160
 __device_attach+0x13a/0x2b0
 bus_probe_device+0xbd/0xd0
 device_add+0x4a5/0x760
 platform_device_add+0x189/0x370
 mfd_add_device+0x587/0x5e0
 mfd_add_devices+0xb1/0x130
 rtsx_usb_probe+0x28e/0x2e0 [rtsx_usb]
 usb_probe_interface+0x15c/0x460
 call_driver_probe+0x35/0x120
 really_probe+0x123/0x410
 __driver_probe_device+0xc7/0x1e0
 driver_probe_device+0x49/0xf0
 __device_attach_driver+0xc6/0x160
 bus_for_each_drv+0xe4/0x160
 __device_attach+0x13a/0x2b0
 rebind_marked_interfaces.isra.0+0xcc/0x110
 usb_reset_device+0x352/0x410
 usbdev_do_ioctl+0xe5c/0x1860
 usbdev_ioctl+0xa/0x20
 __x64_sys_ioctl+0xc5/0xf0
 do_syscall_64+0x59/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 161506:
 kasan_save_stack+0x20/0x40
 kasan_save_track+0x10/0x30
 kasan_save_free_info+0x36/0x60
 __kasan_slab_free+0x34/0x50
 kfree+0x1fd/0x3b0
 device_release+0x56/0xf0
 kobject_cleanup+0x73/0x1c0
 rtsx_usb_ms_drv_remove+0x13d/0x220 [rtsx_usb_ms]
 platform_remove+0x2f/0x50
 device_release_driver_internal+0x24b/0x2e0
 bus_remove_device+0x124/0x1d0
 device_del+0x239/0x530
 platform_device_del.part.0+0x19/0xe0
 platform_device_unregister+0x1c/0x40
 mfd_remove_devices_fn+0x167/0x170
 device_for_each_child_reverse+0xc9/0x130
 mfd_remove_devices+0x6e/0xa0
 rtsx_usb_disconnect+0x2e/0xd0 [rtsx_usb]
 usb_unbind_interface+0xf3/0x3f0
 device_release_driver_internal+0x24b/0x2e0
 proc_disconnect_claim+0x13d/0x220
 usbdev_do_ioctl+0xb5e/0x1860
 usbdev_ioctl+0xa/0x20
 __x64_sys_ioctl+0xc5/0xf0
 do_syscall_64+0x59/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Last potentially related work creation:
 kasan_save_stack+0x20/0x40
 kasan_record_aux_stack+0x85/0x90
 insert_work+0x29/0x100
 __queue_work+0x34a/0x540
 call_timer_fn+0x2a/0x160
 expire_timers+0x5f/0x1f0
 __run_timer_base.part.0+0x1b6/0x1e0
 run_timer_softirq+0x8b/0xe0
 handle_softirqs+0xf9/0x360
 __irq_exit_rcu+0x114/0x130
 sysvec_apic_timer_interrupt+0x72/0x90
 asm_sysvec_apic_timer_interrupt+0x16/0x20

Second to last potentially related work creation:
 kasan_save_stack+0x20/0x40
 kasan_record_aux_stack+0x85/0x90
 insert_work+0x29/0x100
 __queue_work+0x34a/0x540
 call_timer_fn+0x2a/0x160
 expire_timers+0x5f/0x1f0
 __run_timer_base.part.0+0x1b6/0x1e0
 run_timer_softirq+0x8b/0xe0
 handle_softirqs+0xf9/0x360
 __irq_exit_rcu+0x114/0x130
 sysvec_apic_timer_interrupt+0x72/0x90
 asm_sysvec_apic_timer_interrupt+0x16/0x20

The buggy address belongs to the object at ffff888136335000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 896 bytes inside of
 freed 2048-byte region [ffff888136335000, ffff888136335800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x136330
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
page_type: f5(slab)
raw: 0017ffffc0000040 ffff888100042f00 ffffea000417a000 dead000000000002
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 0017ffffc0000040 ffff888100042f00 ffffea000417a000 dead000000000002
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 0017ffffc0000003 ffffea0004d8cc01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888136335280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888136335300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888136335380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888136335400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888136335480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Fixes: 6827ca573c03 ("memstick: rtsx_usb_ms: Support runtime power management")
Signed-off-by: Luo Qiu <luoqiu@kylinsec.com.cn>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/4B7BC3E6E291E6F2+20250317101438.25650-1-luoqiu@kylinsec.com.cn
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/memstick/host/rtsx_usb_ms.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -813,6 +813,7 @@ static void rtsx_usb_ms_drv_remove(struc
 
 	host->eject = true;
 	cancel_work_sync(&host->handle_req);
+	cancel_delayed_work_sync(&host->poll_card);
 
 	mutex_lock(&host->host_mutex);
 	if (host->req) {



