Return-Path: <stable+bounces-125160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0C2A691E8
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC261B63C63
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1690209679;
	Wed, 19 Mar 2025 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TcNqDgT0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812E720A5D5;
	Wed, 19 Mar 2025 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394996; cv=none; b=hM7waB+QzZrf3YZ6T/hrsF/8srcwud+D1aQbmUErBU6o376ccvmaHT54UM75Fs9qQHDCufJkKcNA6OIOEzM2oJqlwoc+61K4ProS4NAy6oJtnuCGwfduKAoIJfbQjRC9zIldQdZP9yhm8JsW3imEGHunoHVGtb2g8SoZvF/N2T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394996; c=relaxed/simple;
	bh=el3Gngeduqh2Mae/kALfUsTerUfs+bjveSZGY16TsqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwcHZzsTdwYRUcJJ8YZSDNuUUQ2dzZu8L9kKtEAfxP0IeX/8B0QlU6pM3ziCN5CK9wYBOLRAyV6j5SQcRnLfND7HzzhJS3HhxQElnhYzp85VYbprDbSd2AvneV3kiVwBLvpCD3DnNLufU6OwuQhVeUFsyYCuH5F5d1chNXcV8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TcNqDgT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20F5C4CEE4;
	Wed, 19 Mar 2025 14:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742394996;
	bh=el3Gngeduqh2Mae/kALfUsTerUfs+bjveSZGY16TsqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TcNqDgT0eemV7Pxh8UDUtUgv2hdAzGWAwVusbmK4HvYjy0ACnpOPL3xvF8REn2g+Z
	 mGGuozjeSutyQneUxHZN9AlHf4PveXi7Jap+XLCqv0U1XAlwAWWR50BKGMyn20EAht
	 tZZ9DYja8iY5iF1fnZ5F4vCIWiE2mXMhGt1U+G1k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.13 202/241] net: mana: cleanup mana struct after debugfs_remove()
Date: Wed, 19 Mar 2025 07:31:12 -0700
Message-ID: <20250319143032.724253945@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
References: <20250319143027.685727358@linuxfoundation.org>
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

From: Shradha Gupta <shradhagupta@linux.microsoft.com>

commit 3e64bb2ae7d9f2b3a8259d4d6b86ed1984d5460a upstream.

When on a MANA VM hibernation is triggered, as part of hibernate_snapshot(),
mana_gd_suspend() and mana_gd_resume() are called. If during this
mana_gd_resume(), a failure occurs with HWC creation, mana_port_debugfs
pointer does not get reinitialized and ends up pointing to older,
cleaned-up dentry.
Further in the hibernation path, as part of power_down(), mana_gd_shutdown()
is triggered. This call, unaware of the failures in resume, tries to cleanup
the already cleaned up  mana_port_debugfs value and hits the following bug:

[  191.359296] mana 7870:00:00.0: Shutdown was called
[  191.359918] BUG: kernel NULL pointer dereference, address: 0000000000000098
[  191.360584] #PF: supervisor write access in kernel mode
[  191.361125] #PF: error_code(0x0002) - not-present page
[  191.361727] PGD 1080ea067 P4D 0
[  191.362172] Oops: Oops: 0002 [#1] SMP NOPTI
[  191.362606] CPU: 11 UID: 0 PID: 1674 Comm: bash Not tainted 6.14.0-rc5+ #2
[  191.363292] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 11/21/2024
[  191.364124] RIP: 0010:down_write+0x19/0x50
[  191.364537] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 53 48 89 fb e8 de cd ff ff 31 c0 ba 01 00 00 00 <f0> 48 0f b1 13 75 16 65 48 8b 05 88 24 4c 6a 48 89 43 08 48 8b 5d
[  191.365867] RSP: 0000:ff45fbe0c1c037b8 EFLAGS: 00010246
[  191.366350] RAX: 0000000000000000 RBX: 0000000000000098 RCX: ffffff8100000000
[  191.366951] RDX: 0000000000000001 RSI: 0000000000000064 RDI: 0000000000000098
[  191.367600] RBP: ff45fbe0c1c037c0 R08: 0000000000000000 R09: 0000000000000001
[  191.368225] R10: ff45fbe0d2b01000 R11: 0000000000000008 R12: 0000000000000000
[  191.368874] R13: 000000000000000b R14: ff43dc27509d67c0 R15: 0000000000000020
[  191.369549] FS:  00007dbc5001e740(0000) GS:ff43dc663f380000(0000) knlGS:0000000000000000
[  191.370213] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  191.370830] CR2: 0000000000000098 CR3: 0000000168e8e002 CR4: 0000000000b73ef0
[  191.371557] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  191.372192] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[  191.372906] Call Trace:
[  191.373262]  <TASK>
[  191.373621]  ? show_regs+0x64/0x70
[  191.374040]  ? __die+0x24/0x70
[  191.374468]  ? page_fault_oops+0x290/0x5b0
[  191.374875]  ? do_user_addr_fault+0x448/0x800
[  191.375357]  ? exc_page_fault+0x7a/0x160
[  191.375971]  ? asm_exc_page_fault+0x27/0x30
[  191.376416]  ? down_write+0x19/0x50
[  191.376832]  ? down_write+0x12/0x50
[  191.377232]  simple_recursive_removal+0x4a/0x2a0
[  191.377679]  ? __pfx_remove_one+0x10/0x10
[  191.378088]  debugfs_remove+0x44/0x70
[  191.378530]  mana_detach+0x17c/0x4f0
[  191.378950]  ? __flush_work+0x1e2/0x3b0
[  191.379362]  ? __cond_resched+0x1a/0x50
[  191.379787]  mana_remove+0xf2/0x1a0
[  191.380193]  mana_gd_shutdown+0x3b/0x70
[  191.380642]  pci_device_shutdown+0x3a/0x80
[  191.381063]  device_shutdown+0x13e/0x230
[  191.381480]  kernel_power_off+0x35/0x80
[  191.381890]  hibernate+0x3c6/0x470
[  191.382312]  state_store+0xcb/0xd0
[  191.382734]  kobj_attr_store+0x12/0x30
[  191.383211]  sysfs_kf_write+0x3e/0x50
[  191.383640]  kernfs_fop_write_iter+0x140/0x1d0
[  191.384106]  vfs_write+0x271/0x440
[  191.384521]  ksys_write+0x72/0xf0
[  191.384924]  __x64_sys_write+0x19/0x20
[  191.385313]  x64_sys_call+0x2b0/0x20b0
[  191.385736]  do_syscall_64+0x79/0x150
[  191.386146]  ? __mod_memcg_lruvec_state+0xe7/0x240
[  191.386676]  ? __lruvec_stat_mod_folio+0x79/0xb0
[  191.387124]  ? __pfx_lru_add+0x10/0x10
[  191.387515]  ? queued_spin_unlock+0x9/0x10
[  191.387937]  ? do_anonymous_page+0x33c/0xa00
[  191.388374]  ? __handle_mm_fault+0xcf3/0x1210
[  191.388805]  ? __count_memcg_events+0xbe/0x180
[  191.389235]  ? handle_mm_fault+0xae/0x300
[  191.389588]  ? do_user_addr_fault+0x559/0x800
[  191.390027]  ? irqentry_exit_to_user_mode+0x43/0x230
[  191.390525]  ? irqentry_exit+0x1d/0x30
[  191.390879]  ? exc_page_fault+0x86/0x160
[  191.391235]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  191.391745] RIP: 0033:0x7dbc4ff1c574
[  191.392111] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d d5 ea 0e 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
[  191.393412] RSP: 002b:00007ffd95a23ab8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[  191.393990] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007dbc4ff1c574
[  191.394594] RDX: 0000000000000005 RSI: 00005a6eeadb0ce0 RDI: 0000000000000001
[  191.395215] RBP: 00007ffd95a23ae0 R08: 00007dbc50003b20 R09: 0000000000000000
[  191.395805] R10: 0000000000000001 R11: 0000000000000202 R12: 0000000000000005
[  191.396404] R13: 00005a6eeadb0ce0 R14: 00007dbc500045c0 R15: 00007dbc50001ee0
[  191.396987]  </TASK>

To fix this, we explicitly set such mana debugfs variables to NULL after
debugfs_remove() is called.

Fixes: 6607c17c6c5e ("net: mana: Enable debugfs files for MANA device")
Cc: stable@vger.kernel.org
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Link: https://patch.msgid.link/1741688260-28922-1-git-send-email-shradhagupta@linux.microsoft.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 11 ++++++++++-
 drivers/net/ethernet/microsoft/mana/mana_en.c   | 10 ++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index be95336ce089..11457b6296cc 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1547,6 +1547,7 @@ unmap_bar:
 	 * adapter-MTU file and apc->mana_pci_debugfs folder.
 	 */
 	debugfs_remove_recursive(gc->mana_pci_debugfs);
+	gc->mana_pci_debugfs = NULL;
 	pci_iounmap(pdev, bar0_va);
 free_gc:
 	pci_set_drvdata(pdev, NULL);
@@ -1569,6 +1570,8 @@ static void mana_gd_remove(struct pci_dev *pdev)
 
 	debugfs_remove_recursive(gc->mana_pci_debugfs);
 
+	gc->mana_pci_debugfs = NULL;
+
 	pci_iounmap(pdev, gc->bar0_va);
 
 	vfree(gc);
@@ -1622,6 +1625,8 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
 
 	debugfs_remove_recursive(gc->mana_pci_debugfs);
 
+	gc->mana_pci_debugfs = NULL;
+
 	pci_disable_device(pdev);
 }
 
@@ -1648,8 +1653,10 @@ static int __init mana_driver_init(void)
 	mana_debugfs_root = debugfs_create_dir("mana", NULL);
 
 	err = pci_register_driver(&mana_driver);
-	if (err)
+	if (err) {
 		debugfs_remove(mana_debugfs_root);
+		mana_debugfs_root = NULL;
+	}
 
 	return err;
 }
@@ -1659,6 +1666,8 @@ static void __exit mana_driver_exit(void)
 	pci_unregister_driver(&mana_driver);
 
 	debugfs_remove(mana_debugfs_root);
+
+	mana_debugfs_root = NULL;
 }
 
 module_init(mana_driver_init);
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index aa1e47233fe5..ae76ecc7a5d3 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -738,12 +738,11 @@ static const struct net_device_ops mana_devops = {
 static void mana_cleanup_port_context(struct mana_port_context *apc)
 {
 	/*
-	 * at this point all dir/files under the vport directory
-	 * are already cleaned up.
-	 * We are sure the apc->mana_port_debugfs remove will not
-	 * cause any freed memory access issues
+	 * make sure subsequent cleanup attempts don't end up removing already
+	 * cleaned dentry pointer
 	 */
 	debugfs_remove(apc->mana_port_debugfs);
+	apc->mana_port_debugfs = NULL;
 	kfree(apc->rxqs);
 	apc->rxqs = NULL;
 }
@@ -1254,6 +1253,7 @@ static void mana_destroy_eq(struct mana_context *ac)
 		return;
 
 	debugfs_remove_recursive(ac->mana_eqs_debugfs);
+	ac->mana_eqs_debugfs = NULL;
 
 	for (i = 0; i < gc->max_num_queues; i++) {
 		eq = ac->eqs[i].eq;
@@ -1914,6 +1914,7 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 
 	for (i = 0; i < apc->num_queues; i++) {
 		debugfs_remove_recursive(apc->tx_qp[i].mana_tx_debugfs);
+		apc->tx_qp[i].mana_tx_debugfs = NULL;
 
 		napi = &apc->tx_qp[i].tx_cq.napi;
 		if (apc->tx_qp[i].txq.napi_initialized) {
@@ -2099,6 +2100,7 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 		return;
 
 	debugfs_remove_recursive(rxq->mana_rx_debugfs);
+	rxq->mana_rx_debugfs = NULL;
 
 	napi = &rxq->rx_cq.napi;
 
-- 
2.48.1




