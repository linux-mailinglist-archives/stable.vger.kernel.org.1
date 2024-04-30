Return-Path: <stable+bounces-42012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566D68B70F0
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787921C22147
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5559B12B176;
	Tue, 30 Apr 2024 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="joryNmmx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128A212D1EA;
	Tue, 30 Apr 2024 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474274; cv=none; b=fUacQiKe7WCsbK+N6A3oAvbwN+d1a9HN3eXAdz+c9AEQgHQY1nH8GCr72CNfU2td5GD2L3D0aBXQGkZQcw/v/7PgDdykrqN4F3vClioxXl+4psu+bsjR9roBTUWWxa9fulFe0YTcf33nm9iPqost0oI5e7ddH6yoOoB3kBU5qjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474274; c=relaxed/simple;
	bh=y9XCdegh40yJHTlYHgKZYs8UL+HWs10pI/56n5e9Q/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZohpaVB68VwRMW7oAQuATMUrq+z2x+lWopwNiqeLq+UKLEwAboGfAe8jGWjgpw1vW1yj3hHAEGtytG8UnXTUpWR2itEi0eXi2MNmKsWk6gtfOUtI2bkQZYVa0SwBtlbTgt2QOZi2MrPSjSDG0M/gj6TXq6o4JqdSrX8bdtZQAIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=joryNmmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4E7C2BBFC;
	Tue, 30 Apr 2024 10:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474273;
	bh=y9XCdegh40yJHTlYHgKZYs8UL+HWs10pI/56n5e9Q/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=joryNmmxwPP1ES9KUtNCXI6itX3j8skUSyHeNoWWOZNzh++or1qhRMg+g47nKNntN
	 rr3N5gLlFA1aOwZVct3z7HcG48E5eWkPVFBJ5c9UWj9zulf+B2hwZwdo7NrsUV/ULF
	 cAIZg9Tj2A1erFpoyhmbdaHYKBcCaiKjQ2xEy4/4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sindhu Devale <sindhu.devale@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Robert Ganzynkowicz <robert.ganzynkowicz@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 109/228] i40e: Do not use WQ_MEM_RECLAIM flag for workqueue
Date: Tue, 30 Apr 2024 12:38:07 +0200
Message-ID: <20240430103106.950274363@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sindhu Devale <sindhu.devale@intel.com>

[ Upstream commit 2cc7d150550cc981aceedf008f5459193282425c ]

Issue reported by customer during SRIOV testing, call trace:
When both i40e and the i40iw driver are loaded, a warning
in check_flush_dependency is being triggered. This seems
to be because of the i40e driver workqueue is allocated with
the WQ_MEM_RECLAIM flag, and the i40iw one is not.

Similar error was encountered on ice too and it was fixed by
removing the flag. Do the same for i40e too.

[Feb 9 09:08] ------------[ cut here ]------------
[  +0.000004] workqueue: WQ_MEM_RECLAIM i40e:i40e_service_task [i40e] is
flushing !WQ_MEM_RECLAIM infiniband:0x0
[  +0.000060] WARNING: CPU: 0 PID: 937 at kernel/workqueue.c:2966
check_flush_dependency+0x10b/0x120
[  +0.000007] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq
snd_timer snd_seq_device snd soundcore nls_utf8 cifs cifs_arc4
nls_ucs2_utils rdma_cm iw_cm ib_cm cifs_md4 dns_resolver netfs qrtr
rfkill sunrpc vfat fat intel_rapl_msr intel_rapl_common irdma
intel_uncore_frequency intel_uncore_frequency_common ice ipmi_ssif
isst_if_common skx_edac nfit libnvdimm x86_pkg_temp_thermal
intel_powerclamp gnss coretemp ib_uverbs rapl intel_cstate ib_core
iTCO_wdt iTCO_vendor_support acpi_ipmi mei_me ipmi_si intel_uncore
ioatdma i2c_i801 joydev pcspkr mei ipmi_devintf lpc_ich
intel_pch_thermal i2c_smbus ipmi_msghandler acpi_power_meter acpi_pad
xfs libcrc32c ast sd_mod drm_shmem_helper t10_pi drm_kms_helper sg ixgbe
drm i40e ahci crct10dif_pclmul libahci crc32_pclmul igb crc32c_intel
libata ghash_clmulni_intel i2c_algo_bit mdio dca wmi dm_mirror
dm_region_hash dm_log dm_mod fuse
[  +0.000050] CPU: 0 PID: 937 Comm: kworker/0:3 Kdump: loaded Not
tainted 6.8.0-rc2-Feb-net_dev-Qiueue-00279-gbd43c5687e05 #1
[  +0.000003] Hardware name: Intel Corporation S2600BPB/S2600BPB, BIOS
SE5C620.86B.02.01.0013.121520200651 12/15/2020
[  +0.000001] Workqueue: i40e i40e_service_task [i40e]
[  +0.000024] RIP: 0010:check_flush_dependency+0x10b/0x120
[  +0.000003] Code: ff 49 8b 54 24 18 48 8d 8b b0 00 00 00 49 89 e8 48
81 c6 b0 00 00 00 48 c7 c7 b0 97 fa 9f c6 05 8a cc 1f 02 01 e8 35 b3 fd
ff <0f> 0b e9 10 ff ff ff 80 3d 78 cc 1f 02 00 75 94 e9 46 ff ff ff 90
[  +0.000002] RSP: 0018:ffffbd294976bcf8 EFLAGS: 00010282
[  +0.000002] RAX: 0000000000000000 RBX: ffff94d4c483c000 RCX:
0000000000000027
[  +0.000001] RDX: ffff94d47f620bc8 RSI: 0000000000000001 RDI:
ffff94d47f620bc0
[  +0.000001] RBP: 0000000000000000 R08: 0000000000000000 R09:
00000000ffff7fff
[  +0.000001] R10: ffffbd294976bb98 R11: ffffffffa0be65e8 R12:
ffff94c5451ea180
[  +0.000001] R13: ffff94c5ab5e8000 R14: ffff94c5c20b6e05 R15:
ffff94c5f1330ab0
[  +0.000001] FS:  0000000000000000(0000) GS:ffff94d47f600000(0000)
knlGS:0000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000001] CR2: 00007f9e6f1fca70 CR3: 0000000038e20004 CR4:
00000000007706f0
[  +0.000000] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  +0.000001] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  +0.000001] PKRU: 55555554
[  +0.000001] Call Trace:
[  +0.000001]  <TASK>
[  +0.000002]  ? __warn+0x80/0x130
[  +0.000003]  ? check_flush_dependency+0x10b/0x120
[  +0.000002]  ? report_bug+0x195/0x1a0
[  +0.000005]  ? handle_bug+0x3c/0x70
[  +0.000003]  ? exc_invalid_op+0x14/0x70
[  +0.000002]  ? asm_exc_invalid_op+0x16/0x20
[  +0.000006]  ? check_flush_dependency+0x10b/0x120
[  +0.000002]  ? check_flush_dependency+0x10b/0x120
[  +0.000002]  __flush_workqueue+0x126/0x3f0
[  +0.000015]  ib_cache_cleanup_one+0x1c/0xe0 [ib_core]
[  +0.000056]  __ib_unregister_device+0x6a/0xb0 [ib_core]
[  +0.000023]  ib_unregister_device_and_put+0x34/0x50 [ib_core]
[  +0.000020]  i40iw_close+0x4b/0x90 [irdma]
[  +0.000022]  i40e_notify_client_of_netdev_close+0x54/0xc0 [i40e]
[  +0.000035]  i40e_service_task+0x126/0x190 [i40e]
[  +0.000024]  process_one_work+0x174/0x340
[  +0.000003]  worker_thread+0x27e/0x390
[  +0.000001]  ? __pfx_worker_thread+0x10/0x10
[  +0.000002]  kthread+0xdf/0x110
[  +0.000002]  ? __pfx_kthread+0x10/0x10
[  +0.000002]  ret_from_fork+0x2d/0x50
[  +0.000003]  ? __pfx_kthread+0x10/0x10
[  +0.000001]  ret_from_fork_asm+0x1b/0x30
[  +0.000004]  </TASK>
[  +0.000001] ---[ end trace 0000000000000000 ]---

Fixes: 4d5957cbdecd ("i40e: remove WQ_UNBOUND and the task limit of our workqueue")
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Robert Ganzynkowicz <robert.ganzynkowicz@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://lore.kernel.org/r/20240423182723.740401-2-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index bb4ab3a9576b9..4c38782d95516 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16733,7 +16733,7 @@ static int __init i40e_init_module(void)
 	 * since we need to be able to guarantee forward progress even under
 	 * memory pressure.
 	 */
-	i40e_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0, i40e_driver_name);
+	i40e_wq = alloc_workqueue("%s", 0, 0, i40e_driver_name);
 	if (!i40e_wq) {
 		pr_err("%s: Failed to create workqueue\n", i40e_driver_name);
 		return -ENOMEM;
-- 
2.43.0




