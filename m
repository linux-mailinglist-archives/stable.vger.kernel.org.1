Return-Path: <stable+bounces-220563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BcsOXM9o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:09:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 474301C6A6F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D87C3485482
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E033C3D9DC0;
	Sat, 28 Feb 2026 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+7CwWcD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB973D9DB7;
	Sat, 28 Feb 2026 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300444; cv=none; b=PtOcN84OhimS65GxC5CHIQmjn37ZWDNme2n3ih4OobZA+kOUrHdgRTfvJW5DYtQJ5XvNym4LfM9aYtJcAHfSs5KcgT8SkrBMJWyRWAvsypm3WgtXO0J41PtL5hDTt1wutE7mgXhTxL11FtzOqW6dKe2jAPMThov23tAWLOKExCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300444; c=relaxed/simple;
	bh=mz6fbB2yOkrwl6+aHsnGN2dqGszwg07acNOLfQMNirs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYEoSRP/o5olVEzo8eFQlyucu1lDlKX5VLlOabkSxGWdE+shmwN3VKZPCN9eKcmqHUGItYL6SGRiY39/3KCVYIpOU3rj8kbPx8/FCRRH+mfos33F+BH+kckxjxqlUmCYSjYFig0TmQjfPrs5NCBeyMnfS2YVgF+V5w3i3JNcGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+7CwWcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24D4C116D0;
	Sat, 28 Feb 2026 17:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300444;
	bh=mz6fbB2yOkrwl6+aHsnGN2dqGszwg07acNOLfQMNirs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C+7CwWcDAb7hc+Jsrnrm99NQvgs1UG3Wucd/Fc+J6av58KHo/mJTCmQu3Yp6zdU8t
	 iSzTrDVD8kScvNyFfklmTHQHnodJW2MMvF9JK8E88KDv5BPL6U8G7ynuhKu57TBUP9
	 WmBBUIj4Xi+2mNG8v0+MWzESbbTPVmEnlyMkb9LglESdrYTthYFozHmYN9OS9cAU0F
	 IctnJeQADS9ule3DpX3hM1hIEJrSsR4B/8FdRiDM7CABEMzGKjkSRynMhPejYllIZH
	 kNMhv6kowGqudC1BL7fOGYf89Ru8EcXACUMI2MofHg6PRLTrl1JTEZ0sH5mshZr97C
	 h6ywE0xxWyXUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Jijie Shao <shaojijie@huawei.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 484/844] net: wan: farsync: Fix use-after-free bugs caused by unfinished tasklets
Date: Sat, 28 Feb 2026 12:26:37 -0500
Message-ID: <20260228173244.1509663-485-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220563-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,zju.edu.cn:email]
X-Rspamd-Queue-Id: 474301C6A6F
X-Rspamd-Action: no action

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit bae8a5d2e759da2e0cba33ab2080deee96a09373 ]

When the FarSync T-series card is being detached, the fst_card_info is
deallocated in fst_remove_one(). However, the fst_tx_task or fst_int_task
may still be running or pending, leading to use-after-free bugs when the
already freed fst_card_info is accessed in fst_process_tx_work_q() or
fst_process_int_work_q().

A typical race condition is depicted below:

CPU 0 (cleanup)           | CPU 1 (tasklet)
                          | fst_start_xmit()
fst_remove_one()          |   tasklet_schedule()
  unregister_hdlc_device()|
                          | fst_process_tx_work_q() //handler
  kfree(card) //free      |   do_bottom_half_tx()
                          |     card-> //use

The following KASAN trace was captured:

==================================================================
 BUG: KASAN: slab-use-after-free in do_bottom_half_tx+0xb88/0xd00
 Read of size 4 at addr ffff88800aad101c by task ksoftirqd/3/32
 ...
 Call Trace:
  <IRQ>
  dump_stack_lvl+0x55/0x70
  print_report+0xcb/0x5d0
  ? do_bottom_half_tx+0xb88/0xd00
  kasan_report+0xb8/0xf0
  ? do_bottom_half_tx+0xb88/0xd00
  do_bottom_half_tx+0xb88/0xd00
  ? _raw_spin_lock_irqsave+0x85/0xe0
  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
  ? __pfx___hrtimer_run_queues+0x10/0x10
  fst_process_tx_work_q+0x67/0x90
  tasklet_action_common+0x1fa/0x720
  ? hrtimer_interrupt+0x31f/0x780
  handle_softirqs+0x176/0x530
  __irq_exit_rcu+0xab/0xe0
  sysvec_apic_timer_interrupt+0x70/0x80
 ...

 Allocated by task 41 on cpu 3 at 72.330843s:
  kasan_save_stack+0x24/0x50
  kasan_save_track+0x17/0x60
  __kasan_kmalloc+0x7f/0x90
  fst_add_one+0x1a5/0x1cd0
  local_pci_probe+0xdd/0x190
  pci_device_probe+0x341/0x480
  really_probe+0x1c6/0x6a0
  __driver_probe_device+0x248/0x310
  driver_probe_device+0x48/0x210
  __device_attach_driver+0x160/0x320
  bus_for_each_drv+0x101/0x190
  __device_attach+0x198/0x3a0
  device_initial_probe+0x78/0xa0
  pci_bus_add_device+0x81/0xc0
  pci_bus_add_devices+0x7e/0x190
  enable_slot+0x9b9/0x1130
  acpiphp_check_bridge.part.0+0x2e1/0x460
  acpiphp_hotplug_notify+0x36c/0x3c0
  acpi_device_hotplug+0x203/0xb10
  acpi_hotplug_work_fn+0x59/0x80
 ...

 Freed by task 41 on cpu 1 at 75.138639s:
  kasan_save_stack+0x24/0x50
  kasan_save_track+0x17/0x60
  kasan_save_free_info+0x3b/0x60
  __kasan_slab_free+0x43/0x70
  kfree+0x135/0x410
  fst_remove_one+0x2ca/0x540
  pci_device_remove+0xa6/0x1d0
  device_release_driver_internal+0x364/0x530
  pci_stop_bus_device+0x105/0x150
  pci_stop_and_remove_bus_device+0xd/0x20
  disable_slot+0x116/0x260
  acpiphp_disable_and_eject_slot+0x4b/0x190
  acpiphp_hotplug_notify+0x230/0x3c0
  acpi_device_hotplug+0x203/0xb10
  acpi_hotplug_work_fn+0x59/0x80
 ...

 The buggy address belongs to the object at ffff88800aad1000
  which belongs to the cache kmalloc-1k of size 1024
 The buggy address is located 28 bytes inside of
  freed 1024-byte region
 The buggy address belongs to the physical page:
 page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xaad0
 head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
 flags: 0x100000000000040(head|node=0|zone=1)
 page_type: f5(slab)
 raw: 0100000000000040 ffff888007042dc0 dead000000000122 0000000000000000
 raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
 head: 0100000000000040 ffff888007042dc0 dead000000000122 0000000000000000
 head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
 head: 0100000000000003 ffffea00002ab401 00000000ffffffff 00000000ffffffff
 head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffff88800aad0f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88800aad0f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 >ffff88800aad1000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                             ^
  ffff88800aad1080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88800aad1100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ==================================================================

Fix this by ensuring that both fst_tx_task and fst_int_task are properly
canceled before the fst_card_info is released. Add tasklet_kill() in
fst_remove_one() to synchronize with any pending or running tasklets.
Since unregister_hdlc_device() stops data transmission and reception,
and fst_disable_intr() prevents further interrupts, it is appropriate
to place tasklet_kill() after these calls.

The bugs were identified through static analysis. To reproduce the issue
and validate the fix, a FarSync T-series card was simulated in QEMU and
delays(e.g., mdelay()) were introduced within the tasklet handler to
increase the likelihood of triggering the race condition.

Fixes: 2f623aaf9f31 ("net: farsync: Fix kmemleak when rmmods farsync")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Reviewed-by: Jijie Shao <shaojijie@huawei.com>
Link: https://patch.msgid.link/20260219124637.72578-1-duoming@zju.edu.cn
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wan/farsync.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wan/farsync.c b/drivers/net/wan/farsync.c
index 5b01642ca44e0..6b2d1e63855e8 100644
--- a/drivers/net/wan/farsync.c
+++ b/drivers/net/wan/farsync.c
@@ -2550,6 +2550,8 @@ fst_remove_one(struct pci_dev *pdev)
 
 	fst_disable_intr(card);
 	free_irq(card->irq, card);
+	tasklet_kill(&fst_tx_task);
+	tasklet_kill(&fst_int_task);
 
 	iounmap(card->ctlmem);
 	iounmap(card->mem);
-- 
2.51.0


