Return-Path: <stable+bounces-196882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E06FC8482E
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 11:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D43B034D690
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 10:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1181130FC17;
	Tue, 25 Nov 2025 10:37:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (l-sdnproxy.icoremail.net [20.188.111.126])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA702DE71A;
	Tue, 25 Nov 2025 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.188.111.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067028; cv=none; b=mfWObxll+MOOaM7r942LL7+WzYbQGsvDU0DZgareSWoJVua0V1z6AwuvMYlE1jDYnRQOOzZM+w9BrBX+saUmThjrqm7RM9a6fgPFLqXGO1GQdQoq5h/oJuu1eDONZq1vhrYJOjY+J9fz9s08hHGLxAHcX4GakSF+UZensSV16AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067028; c=relaxed/simple;
	bh=az1M7mTx4WSI8e/cbGzC1p1NqHJs+gzXHuryfSU0m5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WePepVEkGyN2YHXo5QY4VVHLm4ANHVqWnMsofWVfDy+El5rzWO4N943mgi0neG+RDn4wA+nd53dO/d5zXG1OoVFCdQBLRmoYhZdr+tFSJl9006QvBsPODOzYjP1unahjxuSAM/02E15xgoJ6bz9WA1l2quEXuFbWPKE4OU0mnoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=20.188.111.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [218.12.18.214])
	by mtasvr (Coremail) with SMTP id _____wDnGVO8hiVpmFExAA--.8819S3;
	Tue, 25 Nov 2025 18:36:44 +0800 (CST)
Received: from ubuntu.localdomain (unknown [218.12.18.214])
	by mail-app4 (Coremail) with SMTP id zi_KCgCXeH+uhiVp0zl8Aw--.52409S4;
	Tue, 25 Nov 2025 18:36:43 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	mitltlatltl@gmail.com,
	linux-kernel@vger.kernel.org,
	sergei.shtylyov@gmail.com,
	Duoming Zhou <duoming@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] usb: typec: ucsi: fix use-after-free caused by uec->work
Date: Tue, 25 Nov 2025 18:36:27 +0800
Message-Id: <cc31e12ef9ffbf86676585b02233165fd33f0d8e.1764065838.git.duoming@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1764065838.git.duoming@zju.edu.cn>
References: <cover.1764065838.git.duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgCXeH+uhiVp0zl8Aw--.52409S4
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwIBAWkktQELkwAKsq
X-CM-DELIVERINFO: =?B?Sf3/8wXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR18YlAikpI5poxpx6509tfGsk84IWOh+bN16FwtytwG9LRYqC3MHG3h41XNB09qz5gAMK
	1nSaSV4ci93tEAf+x+usa4vHYcAbvr5/yJ0bf8ECGbUKH7VFePboM0i1C0Ypww==
X-Coremail-Antispam: 1Uk129KBj93XoWxtFyfCFW8AFy8Jw1xXF48Zrc_yoW7Xw18pF
	nI9rWxGrW8Jry7WF47Jr45JF1Yq3yUAa4Utr4xCr1a9rn5Gw4YqFy8trW7WryDGr48AFy7
	AFnxtrWUtr1DKwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU1iZ23UUUUU==

The delayed work uec->work is scheduled in gaokun_ucsi_probe()
but never properly canceled in gaokun_ucsi_remove(). This creates
use-after-free scenarios where the ucsi and gaokun_ucsi structure
are freed after ucsi_destroy() completes execution, while the
gaokun_ucsi_register_worker() might be either currently executing
or still pending in the work queue. The already-freed gaokun_ucsi
or ucsi structure may then be accessed.

Furthermore, the race window is 3 seconds, which is sufficiently
long to make this bug easily reproducible. The following is the
trace captured by KASAN:

==================================================================
BUG: KASAN: slab-use-after-free in __run_timers+0x5ec/0x630
Write of size 8 at addr ffff00000ec28cc8 by task swapper/0/0
...
Call trace:
 show_stack+0x18/0x24 (C)
 dump_stack_lvl+0x78/0x90
 print_report+0x114/0x580
 kasan_report+0xa4/0xf0
 __asan_report_store8_noabort+0x20/0x2c
 __run_timers+0x5ec/0x630
 run_timer_softirq+0xe8/0x1cc
 handle_softirqs+0x294/0x720
 __do_softirq+0x14/0x20
 ____do_softirq+0x10/0x1c
 call_on_irq_stack+0x30/0x48
 do_softirq_own_stack+0x1c/0x28
 __irq_exit_rcu+0x27c/0x364
 irq_exit_rcu+0x10/0x1c
 el1_interrupt+0x40/0x60
 el1h_64_irq_handler+0x18/0x24
 el1h_64_irq+0x6c/0x70
 arch_local_irq_enable+0x4/0x8 (P)
 do_idle+0x334/0x458
 cpu_startup_entry+0x60/0x70
 rest_init+0x158/0x174
 start_kernel+0x2f8/0x394
 __primary_switched+0x8c/0x94

Allocated by task 72 on cpu 0 at 27.510341s:
 kasan_save_stack+0x2c/0x54
 kasan_save_track+0x24/0x5c
 kasan_save_alloc_info+0x40/0x54
 __kasan_kmalloc+0xa0/0xb8
 __kmalloc_node_track_caller_noprof+0x1c0/0x588
 devm_kmalloc+0x7c/0x1c8
 gaokun_ucsi_probe+0xa0/0x840  auxiliary_bus_probe+0x94/0xf8
 really_probe+0x17c/0x5b8
 __driver_probe_device+0x158/0x2c4
 driver_probe_device+0x10c/0x264
 __device_attach_driver+0x168/0x2d0
 bus_for_each_drv+0x100/0x188
 __device_attach+0x174/0x368
 device_initial_probe+0x14/0x20
 bus_probe_device+0x120/0x150
 device_add+0xb3c/0x10fc
 __auxiliary_device_add+0x88/0x130
...

Freed by task 73 on cpu 1 at 28.910627s:
 kasan_save_stack+0x2c/0x54
 kasan_save_track+0x24/0x5c
 __kasan_save_free_info+0x4c/0x74
 __kasan_slab_free+0x60/0x8c
 kfree+0xd4/0x410
 devres_release_all+0x140/0x1f0
 device_unbind_cleanup+0x20/0x190
 device_release_driver_internal+0x344/0x460
 device_release_driver+0x18/0x24
 bus_remove_device+0x198/0x274
 device_del+0x310/0xa84
...

The buggy address belongs to the object at ffff00000ec28c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 200 bytes inside of
 freed 512-byte region
The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4ec28
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x3fffe0000000040(head|node=0|zone=0|lastcpupid=0x1ffff)
page_type: f5(slab)
raw: 03fffe0000000040 ffff000008801c80 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 03fffe0000000040 ffff000008801c80 dead000000000122 0000000000000000
head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 03fffe0000000002 fffffdffc03b0a01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff00000ec28b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff00000ec28c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff00000ec28c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff00000ec28d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff00000ec28d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Add disable_delayed_work_sync() in gaokun_ucsi_remove() to ensure
that uec->work is properly canceled and prevented from executing
after the ucsi and gaokun_ucsi structure have been deallocated.

Fixes: 00327d7f2c8c ("usb: typec: ucsi: add Huawei Matebook E Go ucsi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
index 8401ab414bd..c5965656bab 100644
--- a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
+++ b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
@@ -503,6 +503,7 @@ static void gaokun_ucsi_remove(struct auxiliary_device *adev)
 {
 	struct gaokun_ucsi *uec = auxiliary_get_drvdata(adev);
 
+	disable_delayed_work_sync(&uec->work);
 	gaokun_ec_unregister_notify(uec->ec, &uec->nb);
 	ucsi_unregister(uec->ucsi);
 	ucsi_destroy(uec->ucsi);
-- 
2.34.1


