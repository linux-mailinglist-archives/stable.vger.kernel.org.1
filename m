Return-Path: <stable+bounces-168333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F31B23467
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6A82A37A1
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7C92FA0CD;
	Tue, 12 Aug 2025 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ycyIDcSQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC39A2F4A0A;
	Tue, 12 Aug 2025 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023826; cv=none; b=RLY4P03xUEfqHoHRg4IyWbGVPjspqyLI1d3npUj0cZiMzOKzqJ6tpWwjpcNCgWGjPbG8jv1ZE/t8+RPwvkGAXlUCRSA0Zz3QfbChHG1u2G4fvoTQwLCOdmIWOVecpetnkHuuQ6526WkkKe2cX547TIfvw6uSJaO4efqkDfEv5KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023826; c=relaxed/simple;
	bh=6BVf9b5ahkA/vfMcOinSOil8kSkPFkbCm3ZcuYYtmZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNMuRA1VkRA+2kIyfWEB1TzimI9MHJ+/Q7cn1IkV18GcL/QQ6+M0cmQwkNcCDEpTyhHWs/eHC46w+a1OfXvRHimPPtzt0UJV2M0cAkCBrLi7HzVFtJrqTgEpMTC0gpAc7HcXuL3PPtE24sB1aaWmOD+XFiRiPd6wr+hsS0uKVFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ycyIDcSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EA4C4CEF0;
	Tue, 12 Aug 2025 18:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755023826;
	bh=6BVf9b5ahkA/vfMcOinSOil8kSkPFkbCm3ZcuYYtmZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ycyIDcSQ0K72AqGdqnQU5aqJ9pdj4ykPY9eWBLWdUAntoq4Q1fTtFCPKtUcjBCH25
	 TWCfOuUviQZvRPBlLhoFx5tchCsGe9bcjgvjUiM6KfpUofAq1F6eriWFmunylrevQp
	 JfEFolvYaIlDHJvFjJ2QBAmN2XVoDd0h1ounhMR8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 193/627] drm/amdgpu: fix use-after-free in amdgpu_userq_suspend+0x51a/0x5a0
Date: Tue, 12 Aug 2025 19:28:08 +0200
Message-ID: <20250812173426.613431184@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

[ Upstream commit a886d26f2c8f9e3f3c1869ae368d09c75daac553 ]

[  +0.000020] BUG: KASAN: slab-use-after-free in amdgpu_userq_suspend+0x51a/0x5a0 [amdgpu]
[  +0.000817] Read of size 8 at addr ffff88812eec8c58 by task amd_pci_unplug/1733

[  +0.000027] CPU: 10 UID: 0 PID: 1733 Comm: amd_pci_unplug Tainted: G        W          6.14.0+ #2
[  +0.000009] Tainted: [W]=WARN
[  +0.000003] Hardware name: ASUS System Product Name/ROG STRIX B550-F GAMING (WI-FI), BIOS 1401 12/03/2020
[  +0.000004] Call Trace:
[  +0.000004]  <TASK>
[  +0.000003]  dump_stack_lvl+0x76/0xa0
[  +0.000011]  print_report+0xce/0x600
[  +0.000009]  ? srso_return_thunk+0x5/0x5f
[  +0.000006]  ? kasan_complete_mode_report_info+0x76/0x200
[  +0.000007]  ? kasan_addr_to_slab+0xd/0xb0
[  +0.000006]  ? amdgpu_userq_suspend+0x51a/0x5a0 [amdgpu]
[  +0.000707]  kasan_report+0xbe/0x110
[  +0.000006]  ? amdgpu_userq_suspend+0x51a/0x5a0 [amdgpu]
[  +0.000541]  __asan_report_load8_noabort+0x14/0x30
[  +0.000005]  amdgpu_userq_suspend+0x51a/0x5a0 [amdgpu]
[  +0.000535]  ? stop_cpsch+0x396/0x600 [amdgpu]
[  +0.000556]  ? stop_cpsch+0x429/0x600 [amdgpu]
[  +0.000536]  ? __pfx_amdgpu_userq_suspend+0x10/0x10 [amdgpu]
[  +0.000536]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? kgd2kfd_suspend+0x132/0x1d0 [amdgpu]
[  +0.000542]  amdgpu_device_fini_hw+0x581/0xe90 [amdgpu]
[  +0.000485]  ? down_write+0xbb/0x140
[  +0.000007]  ? __mutex_unlock_slowpath.constprop.0+0x317/0x360
[  +0.000005]  ? __pfx_amdgpu_device_fini_hw+0x10/0x10 [amdgpu]
[  +0.000482]  ? __kasan_check_write+0x14/0x30
[  +0.000004]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? up_write+0x55/0xb0
[  +0.000007]  ? srso_return_thunk+0x5/0x5f
[  +0.000005]  ? blocking_notifier_chain_unregister+0x6c/0xc0
[  +0.000008]  amdgpu_driver_unload_kms+0x69/0x90 [amdgpu]
[  +0.000484]  amdgpu_pci_remove+0x93/0x130 [amdgpu]
[  +0.000482]  pci_device_remove+0xae/0x1e0
[  +0.000008]  device_remove+0xc7/0x180
[  +0.000008]  device_release_driver_internal+0x3d4/0x5a0
[  +0.000007]  device_release_driver+0x12/0x20
[  +0.000004]  pci_stop_bus_device+0x104/0x150
[  +0.000006]  pci_stop_and_remove_bus_device_locked+0x1b/0x40
[  +0.000005]  remove_store+0xd7/0xf0
[  +0.000005]  ? __pfx_remove_store+0x10/0x10
[  +0.000006]  ? __pfx__copy_from_iter+0x10/0x10
[  +0.000006]  ? __pfx_dev_attr_store+0x10/0x10
[  +0.000006]  dev_attr_store+0x3f/0x80
[  +0.000006]  sysfs_kf_write+0x125/0x1d0
[  +0.000004]  ? srso_return_thunk+0x5/0x5f
[  +0.000005]  ? __kasan_check_write+0x14/0x30
[  +0.000005]  kernfs_fop_write_iter+0x2ea/0x490
[  +0.000005]  ? rw_verify_area+0x70/0x420
[  +0.000005]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[  +0.000006]  vfs_write+0x90d/0xe70
[  +0.000005]  ? srso_return_thunk+0x5/0x5f
[  +0.000005]  ? __pfx_vfs_write+0x10/0x10
[  +0.000004]  ? local_clock+0x15/0x30
[  +0.000008]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? __kasan_slab_free+0x5f/0x80
[  +0.000005]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? __kasan_check_read+0x11/0x20
[  +0.000004]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? fdget_pos+0x1d3/0x500
[  +0.000007]  ksys_write+0x119/0x220
[  +0.000005]  ? putname+0x1c/0x30
[  +0.000006]  ? __pfx_ksys_write+0x10/0x10
[  +0.000007]  __x64_sys_write+0x72/0xc0
[  +0.000006]  x64_sys_call+0x18ab/0x26f0
[  +0.000006]  do_syscall_64+0x7c/0x170
[  +0.000004]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? __pfx___x64_sys_openat+0x10/0x10
[  +0.000006]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? __kasan_check_read+0x11/0x20
[  +0.000003]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? fpregs_assert_state_consistent+0x21/0xb0
[  +0.000006]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? syscall_exit_to_user_mode+0x4e/0x240
[  +0.000005]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? do_syscall_64+0x88/0x170
[  +0.000003]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? irqentry_exit+0x43/0x50
[  +0.000004]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? exc_page_fault+0x7c/0x110
[  +0.000006]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000006] RIP: 0033:0x7480c0b14887
[  +0.000005] Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  +0.000005] RSP: 002b:00007fff142b0058 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  +0.000006] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007480c0b14887
[  +0.000003] RDX: 0000000000000001 RSI: 00007480c0e7365a RDI: 0000000000000004
[  +0.000003] RBP: 00007fff142b0080 R08: 0000563b2e73c170 R09: 0000000000000000
[  +0.000003] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff142b02f8
[  +0.000003] R13: 0000563b159a72a9 R14: 0000563b159a9d48 R15: 00007480c0f19040
[  +0.000008]  </TASK>

[  +0.000445] Allocated by task 427 on cpu 5 at 29.342331s:
[  +0.000011]  kasan_save_stack+0x28/0x60
[  +0.000006]  kasan_save_track+0x18/0x70
[  +0.000006]  kasan_save_alloc_info+0x38/0x60
[  +0.000005]  __kasan_kmalloc+0xc1/0xd0
[  +0.000006]  __kmalloc_cache_noprof+0x1bd/0x430
[  +0.000007]  amdgpu_driver_open_kms+0x172/0x760 [amdgpu]
[  +0.000493]  drm_file_alloc+0x569/0x9a0
[  +0.000007]  drm_client_init+0x1b7/0x410
[  +0.000007]  drm_fbdev_client_setup+0x174/0x470
[  +0.000006]  drm_client_setup+0x8a/0xf0
[  +0.000006]  amdgpu_pci_probe+0x510/0x10c0 [amdgpu]
[  +0.000483]  local_pci_probe+0xe7/0x1b0
[  +0.000006]  pci_device_probe+0x5bf/0x890
[  +0.000006]  really_probe+0x1fd/0x950
[  +0.000005]  __driver_probe_device+0x307/0x410
[  +0.000006]  driver_probe_device+0x4e/0x150
[  +0.000005]  __driver_attach+0x223/0x510
[  +0.000006]  bus_for_each_dev+0x102/0x1a0
[  +0.000005]  driver_attach+0x3d/0x60
[  +0.000006]  bus_add_driver+0x309/0x650
[  +0.000005]  driver_register+0x13d/0x490
[  +0.000006]  __pci_register_driver+0x1ee/0x2b0
[  +0.000006]  rfcomm_dlc_clear_state+0x69/0x220 [rfcomm]
[  +0.000011]  do_one_initcall+0x9c/0x3e0
[  +0.000007]  do_init_module+0x29e/0x7f0
[  +0.000006]  load_module+0x5c75/0x7c80
[  +0.000006]  init_module_from_file+0x106/0x180
[  +0.000006]  idempotent_init_module+0x377/0x740
[  +0.000006]  __x64_sys_finit_module+0xd7/0x180
[  +0.000006]  x64_sys_call+0x1f0b/0x26f0
[  +0.000006]  do_syscall_64+0x7c/0x170
[  +0.000005]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  +0.000013] Freed by task 1733 on cpu 5 at 59.907086s:
[  +0.000011]  kasan_save_stack+0x28/0x60
[  +0.000006]  kasan_save_track+0x18/0x70
[  +0.000005]  kasan_save_free_info+0x3b/0x60
[  +0.000005]  __kasan_slab_free+0x54/0x80
[  +0.000006]  kfree+0x127/0x470
[  +0.000006]  amdgpu_driver_postclose_kms+0x455/0x760 [amdgpu]
[  +0.000493]  drm_file_free.part.0+0x5b1/0xba0
[  +0.000006]  drm_file_free+0x13/0x30
[  +0.000006]  drm_client_release+0x1c4/0x2b0
[  +0.000006]  drm_fbdev_ttm_fb_destroy+0xd2/0x120 [drm_ttm_helper]
[  +0.000007]  put_fb_info+0x97/0xe0
[  +0.000007]  unregister_framebuffer+0x197/0x380
[  +0.000005]  drm_fb_helper_unregister_info+0x94/0x100
[  +0.000005]  drm_fbdev_client_unregister+0x3c/0x80
[  +0.000007]  drm_client_dev_unregister+0x144/0x330
[  +0.000006]  drm_dev_unregister+0x49/0x1b0
[  +0.000006]  drm_dev_unplug+0x4c/0xd0
[  +0.000006]  amdgpu_pci_remove+0x58/0x130 [amdgpu]
[  +0.000484]  pci_device_remove+0xae/0x1e0
[  +0.000008]  device_remove+0xc7/0x180
[  +0.000007]  device_release_driver_internal+0x3d4/0x5a0
[  +0.000006]  device_release_driver+0x12/0x20
[  +0.000007]  pci_stop_bus_device+0x104/0x150
[  +0.000006]  pci_stop_and_remove_bus_device_locked+0x1b/0x40
[  +0.000006]  remove_store+0xd7/0xf0
[  +0.000006]  dev_attr_store+0x3f/0x80
[  +0.000005]  sysfs_kf_write+0x125/0x1d0
[  +0.000006]  kernfs_fop_write_iter+0x2ea/0x490
[  +0.000006]  vfs_write+0x90d/0xe70
[  +0.000006]  ksys_write+0x119/0x220
[  +0.000006]  __x64_sys_write+0x72/0xc0
[  +0.000006]  x64_sys_call+0x18ab/0x26f0
[  +0.000005]  do_syscall_64+0x7c/0x170
[  +0.000006]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  +0.000012] The buggy address belongs to the object at ffff88812eec8000
               which belongs to the cache kmalloc-rnd-07-4k of size 4096
[  +0.000016] The buggy address is located 3160 bytes inside of
               freed 4096-byte region [ffff88812eec8000, ffff88812eec9000)

[  +0.000023] The buggy address belongs to the physical page:
[  +0.000009] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12eec8
[  +0.000007] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  +0.000005] flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
[  +0.000007] page_type: f5(slab)
[  +0.000008] raw: 0017ffffc0000040 ffff888100054500 dead000000000122 0000000000000000
[  +0.000005] raw: 0000000000000000 0000000080040004 00000000f5000000 0000000000000000
[  +0.000006] head: 0017ffffc0000040 ffff888100054500 dead000000000122 0000000000000000
[  +0.000005] head: 0000000000000000 0000000080040004 00000000f5000000 0000000000000000
[  +0.000006] head: 0017ffffc0000003 ffffea0004bbb201 ffffffffffffffff 0000000000000000
[  +0.000005] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
[  +0.000005] page dumped because: kasan: bad access detected

[  +0.000010] Memory state around the buggy address:
[  +0.000009]  ffff88812eec8b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  +0.000012]  ffff88812eec8b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  +0.000011] >ffff88812eec8c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  +0.000011]                                                     ^
[  +0.000010]  ffff88812eec8c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  +0.000011]  ffff88812eec8d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  +0.000011] ==================================================================

The use-after-free occurs because a delayed work item (`suspend_work`) may still
be pending or running when resources it accesses are freed during device removal
or file close. The previous code used `flush_work(&fpriv->evf_mgr.suspend_work.work)`,
which does not wait for delayed work that has not yet started. As a result, the
delayed work could run after its memory was freed, causing a use-after-free.
By switching to `flush_delayed_work(&fpriv->evf_mgr.suspend_work)`, we ensure that
the kernel waits for both queued and delayed work to finish before
freeing memory, closing this race.

Fixes: adba0929736a ("drm/amdgpu: Fix Illegal opcode in command stream Error")
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 295e7186e156..aac0de86f3e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -664,7 +664,7 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	int ret;
 
-	flush_work(&fpriv->evf_mgr.suspend_work.work);
+	flush_delayed_work(&fpriv->evf_mgr.suspend_work);
 
 	mutex_lock(&uq_mgr->userq_mutex);
 
-- 
2.39.5




