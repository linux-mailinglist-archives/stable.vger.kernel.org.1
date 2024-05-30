Return-Path: <stable+bounces-47672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7FA8D44F5
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 07:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0616C1F225B4
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 05:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654F4381C8;
	Thu, 30 May 2024 05:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="S0KhlLcL"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7613D288B1
	for <stable@vger.kernel.org>; Thu, 30 May 2024 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717048320; cv=none; b=HO6FV0w7Vmcv9cd+/DR1bVe7Ymx6uXJmcE+TXri9BUghhr0rZYr3iTe5ezOtlfLbrD3X4hf+Y3uYln9iWF6UPK5OyCvdzaQV7CYziwetgxn8rIE0MiOMWqz0xKTo7vhxcd7qvqq/NQ/yGn5rpa4dwtQ80afiSnSUsPC1jYtLVyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717048320; c=relaxed/simple;
	bh=lKmbzPR08psUT+v0csI7cxGJZwtefGOvXM2mYVI5gR0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bO7ubgEIpr/dx00Tw/Kr53Kcl/GwZLD6EVyS1O4ddWpcEeviIGNmnhIIt0IWgGmCZQcyxM/6TPbmCBHTYwrjatCTfbaqRI2WNT81FjGnnFvuraMZjTp4kOuNel/TY7IymtGhAcG2g8HOK1Yq2Q7c4Cjwe/97aQMaK2crHtI1zsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=S0KhlLcL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 271B920B9260; Wed, 29 May 2024 22:51:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 271B920B9260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1717048312;
	bh=hWPezramp0qUfUBH5xShjf9TvyKC6uhMUbIYUkIKMdc=;
	h=Date:From:To:Subject:From;
	b=S0KhlLcLOw1uIk0F6c27sTvyA0pztQP8SvmkPXCqdMFpvSkLG0yte4jpMCvfP78s/
	 m+4/rxbjc5mhY0aTNc0QDAtmI8B7lIcx+BfVh8aeXqPZKI2vAWX+kXRhkQvPkKuVRl
	 R3WpyMucrZtpZ5PVsh4T+/4G8NXroceRPP3pq+gA=
Date: Wed, 29 May 2024 22:51:52 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: stable@vger.kernel.org
Subject: Request for backporting of two drm patches
Message-ID: <20240530055152.GA13146@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,
Can you please pick up the following two drm patches to linux-5.15.y
and newer?
As these bugs affect these kernel versions too
 
List of patches to be backported
Patch 1:
5abffb66d12bcac84bf7b66389c571b8bb6e82bd
drm: Check output polling initialized before disabling
 
Patch 2:
048a36d8a6085bbd8ab9e5794b713b92ac986450
drm: Check polling initialized before enabling in drm_helper_probe_single_connector_modes

These however do not apply cleanly on the 5.15.y branch, so I am also
attaching rebased versions of these patches in the mail
 
Thanks and Regards,
Shradha.

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-drm-Check-output-polling-initialized-before-disablin.patch"

From a49cb22e6017a7b2e38148cf7dea6d52b550d607 Mon Sep 17 00:00:00 2001
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
Date: Thu, 1 Feb 2024 22:43:28 -0800
Subject: [PATCH 1/2] drm: Check output polling initialized before disabling

In drm_kms_helper_poll_disable() check if output polling
support is initialized before disabling polling. If not flag
this as a warning.
Additionally in drm_mode_config_helper_suspend() and
drm_mode_config_helper_resume() calls, that re the callers of these
functions, avoid invoking them if polling is not initialized.
For drivers like hyperv-drm, that do not initialize connector
polling, if suspend is called without this check, it leads to
suspend failure with following stack
[  770.719392] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[  770.720592] printk: Suspending console(s) (use no_console_suspend to debug)
[  770.948823] ------------[ cut here ]------------
[  770.948824] WARNING: CPU: 1 PID: 17197 at kernel/workqueue.c:3162 __flush_work.isra.0+0x212/0x230
[  770.948831] Modules linked in: rfkill nft_counter xt_conntrack xt_owner udf nft_compat crc_itu_t nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink vfat fat mlx5_ib ib_uverbs ib_core mlx5_core intel_rapl_msr intel_rapl_common kvm_amd ccp mlxfw kvm psample hyperv_drm tls drm_shmem_helper drm_kms_helper irqbypass pcspkr syscopyarea sysfillrect sysimgblt hv_balloon hv_utils joydev drm fuse xfs libcrc32c pci_hyperv pci_hyperv_intf sr_mod sd_mod cdrom t10_pi sg hv_storvsc scsi_transport_fc hv_netvsc serio_raw hyperv_keyboard hid_hyperv crct10dif_pclmul crc32_pclmul crc32c_intel hv_vmbus ghash_clmulni_intel dm_mirror dm_region_hash dm_log dm_mod
[  770.948863] CPU: 1 PID: 17197 Comm: systemd-sleep Not tainted 5.14.0-362.2.1.el9_3.x86_64 #1
[  770.948865] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 05/09/2022
[  770.948866] RIP: 0010:__flush_work.isra.0+0x212/0x230
[  770.948869] Code: 8b 4d 00 4c 8b 45 08 89 ca 48 c1 e9 04 83 e2 08 83 e1 0f 83 ca 02 89 c8 48 0f ba 6d 00 03 e9 25 ff ff ff 0f 0b e9 4e ff ff ff <0f> 0b 45 31 ed e9 44 ff ff ff e8 8f 89 b2 00 66 66 2e 0f 1f 84 00
[  770.948870] RSP: 0018:ffffaf4ac213fb10 EFLAGS: 00010246
[  770.948871] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8c992857
[  770.948872] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff9aad82b00330
[  770.948873] RBP: ffff9aad82b00330 R08: 0000000000000000 R09: ffff9aad87ee3d10
[  770.948874] R10: 0000000000000200 R11: 0000000000000000 R12: ffff9aad82b00330
[  770.948874] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
[  770.948875] FS:  00007ff1b2f6bb40(0000) GS:ffff9aaf37d00000(0000) knlGS:0000000000000000
[  770.948878] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  770.948878] CR2: 0000555f345cb666 CR3: 00000001462dc005 CR4: 0000000000370ee0
[  770.948879] Call Trace:
[  770.948880]  <TASK>
[  770.948881]  ? show_trace_log_lvl+0x1c4/0x2df
[  770.948884]  ? show_trace_log_lvl+0x1c4/0x2df
[  770.948886]  ? __cancel_work_timer+0x103/0x190
[  770.948887]  ? __flush_work.isra.0+0x212/0x230
[  770.948889]  ? __warn+0x81/0x110
[  770.948891]  ? __flush_work.isra.0+0x212/0x230
[  770.948892]  ? report_bug+0x10a/0x140
[  770.948895]  ? handle_bug+0x3c/0x70
[  770.948898]  ? exc_invalid_op+0x14/0x70
[  770.948899]  ? asm_exc_invalid_op+0x16/0x20
[  770.948903]  ? __flush_work.isra.0+0x212/0x230
[  770.948905]  __cancel_work_timer+0x103/0x190
[  770.948907]  ? _raw_spin_unlock_irqrestore+0xa/0x30
[  770.948910]  drm_kms_helper_poll_disable+0x1e/0x40 [drm_kms_helper]
[  770.948923]  drm_mode_config_helper_suspend+0x1c/0x80 [drm_kms_helper]
[  770.948933]  ? __pfx_vmbus_suspend+0x10/0x10 [hv_vmbus]
[  770.948942]  hyperv_vmbus_suspend+0x17/0x40 [hyperv_drm]
[  770.948944]  ? __pfx_vmbus_suspend+0x10/0x10 [hv_vmbus]
[  770.948951]  dpm_run_callback+0x4c/0x140
[  770.948954]  __device_suspend_noirq+0x74/0x220
[  770.948956]  dpm_noirq_suspend_devices+0x148/0x2a0
[  770.948958]  dpm_suspend_end+0x54/0xe0
[  770.948960]  create_image+0x14/0x290
[  770.948963]  hibernation_snapshot+0xd6/0x200
[  770.948964]  hibernate.cold+0x8b/0x1fb
[  770.948967]  state_store+0xcd/0xd0
[  770.948969]  kernfs_fop_write_iter+0x124/0x1b0
[  770.948973]  new_sync_write+0xff/0x190
[  770.948976]  vfs_write+0x1ef/0x280
[  770.948978]  ksys_write+0x5f/0xe0
[  770.948979]  do_syscall_64+0x5c/0x90
[  770.948981]  ? syscall_exit_work+0x103/0x130
[  770.948983]  ? syscall_exit_to_user_mode+0x12/0x30
[  770.948985]  ? do_syscall_64+0x69/0x90
[  770.948986]  ? do_syscall_64+0x69/0x90
[  770.948987]  ? do_user_addr_fault+0x1d6/0x6a0
[  770.948989]  ? do_syscall_64+0x69/0x90
[  770.948990]  ? exc_page_fault+0x62/0x150
[  770.948992]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  770.948995] RIP: 0033:0x7ff1b293eba7
[  770.949010] Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  770.949011] RSP: 002b:00007ffde3912128 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  770.949012] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007ff1b293eba7
[  770.949013] RDX: 0000000000000005 RSI: 00007ffde3912210 RDI: 0000000000000004
[  770.949014] RBP: 00007ffde3912210 R08: 000055d7dd4c9510 R09: 00007ff1b29b14e0
[  770.949014] R10: 00007ff1b29b13e0 R11: 0000000000000246 R12: 0000000000000005
[  770.949015] R13: 000055d7dd4c53e0 R14: 0000000000000005 R15: 00007ff1b29f69e0
[  770.949016]  </TASK>
[  770.949017] ---[ end trace e6fa0618bfa2f31d ]---

This patch also fixes some rebasing issues on 5.15.y branch

Built-on: Rhel9, Ubuntu22
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/1706856208-9617-1-git-send-email-shradhagupta@linux.microsoft.com
---
 drivers/gpu/drm/drm_modeset_helper.c | 19 ++++++++++++++++---
 drivers/gpu/drm/drm_probe_helper.c   | 12 ++++++++++--
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm_modeset_helper.c
index da483125e063..97071ff5e540 100644
--- a/drivers/gpu/drm/drm_modeset_helper.c
+++ b/drivers/gpu/drm/drm_modeset_helper.c
@@ -198,13 +198,22 @@ int drm_mode_config_helper_suspend(struct drm_device *dev)
 
 	if (!dev)
 		return 0;
+	/*
+	 * Don't disable polling if it was never initialized
+	 */
+	if (dev->mode_config.poll_enabled)
+		drm_kms_helper_poll_disable(dev);
 
-	drm_kms_helper_poll_disable(dev);
 	drm_fb_helper_set_suspend_unlocked(dev->fb_helper, 1);
 	state = drm_atomic_helper_suspend(dev);
 	if (IS_ERR(state)) {
 		drm_fb_helper_set_suspend_unlocked(dev->fb_helper, 0);
-		drm_kms_helper_poll_enable(dev);
+		/*
+		 * Don't enable polling if it was never initialized
+		 */
+		if (dev->mode_config.poll_enabled)
+			drm_kms_helper_poll_enable(dev);
+
 		return PTR_ERR(state);
 	}
 
@@ -244,7 +253,11 @@ int drm_mode_config_helper_resume(struct drm_device *dev)
 	dev->mode_config.suspend_state = NULL;
 
 	drm_fb_helper_set_suspend_unlocked(dev->fb_helper, 0);
-	drm_kms_helper_poll_enable(dev);
+	/*
+	 * Don't enable polling if it is not initialized
+	 */
+	if (dev->mode_config.poll_enabled)
+		drm_kms_helper_poll_enable(dev);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index f6b72e03688d..08d75590fdc0 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -235,6 +235,9 @@ drm_connector_mode_valid(struct drm_connector *connector,
  * Drivers can call this helper from their device resume implementation. It is
  * not an error to call this even when output polling isn't enabled.
  *
+ * If device polling was never initialized before, this call will trigger a
+ * warning and return.
+ *
  * Note that calls to enable and disable polling must be strictly ordered, which
  * is automatically the case when they're only call from suspend/resume
  * callbacks.
@@ -246,7 +249,8 @@ void drm_kms_helper_poll_enable(struct drm_device *dev)
 	struct drm_connector_list_iter conn_iter;
 	unsigned long delay = DRM_OUTPUT_POLL_PERIOD;
 
-	if (!dev->mode_config.poll_enabled || !drm_kms_helper_poll)
+	if (drm_WARN_ON_ONCE(dev, !dev->mode_config.poll_enabled) ||
+	    !drm_kms_helper_poll || dev->mode_config.poll_running)
 		return;
 
 	drm_connector_list_iter_begin(dev, &conn_iter);
@@ -742,14 +746,18 @@ EXPORT_SYMBOL(drm_kms_helper_is_poll_worker);
  * not an error to call this even when output polling isn't enabled or already
  * disabled. Polling is re-enabled by calling drm_kms_helper_poll_enable().
  *
+ * If however, the polling was never initialized, this call will trigger a
+ * warning and return
+ *
  * Note that calls to enable and disable polling must be strictly ordered, which
  * is automatically the case when they're only call from suspend/resume
  * callbacks.
  */
 void drm_kms_helper_poll_disable(struct drm_device *dev)
 {
-	if (!dev->mode_config.poll_enabled)
+	if (drm_WARN_ON(dev, !dev->mode_config.poll_enabled))
 		return;
+
 	cancel_delayed_work_sync(&dev->mode_config.output_poll_work);
 }
 EXPORT_SYMBOL(drm_kms_helper_poll_disable);
-- 
2.34.1


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0002-drm-Check-polling-initialized-before-enabling-in-drm.patch"

From b0302ce41b5870226fefeb827bb86d245be2b122 Mon Sep 17 00:00:00 2001
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
Date: Thu, 1 Feb 2024 22:43:44 -0800
Subject: [PATCH 2/2] drm: Check polling initialized before enabling in
 drm_helper_probe_single_connector_modes

In function drm_helper_probe_single_connector_modes() when we enable
polling again, if it is already uninitialized, a warning is reported.
This patch fixes the warning message by checking if poll is initialized
before enabling it.
This patch also fixes some rebasing issues on 5.15.y branch

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202401191128.db8423f1-oliver.sang@intel.com
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/1706856224-9725-1-git-send-email-shradhagupta@linux.microsoft.com
---
 drivers/gpu/drm/drm_probe_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 08d75590fdc0..e79bb93072dd 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -498,7 +498,8 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 	}
 
 	/* Re-enable polling in case the global poll config changed. */
-	if (drm_kms_helper_poll != dev->mode_config.poll_running)
+	if (dev->mode_config.poll_enabled &&
+	    (drm_kms_helper_poll != dev->mode_config.poll_running))
 		drm_kms_helper_poll_enable(dev);
 
 	dev->mode_config.poll_running = drm_kms_helper_poll;
-- 
2.34.1


--IS0zKkzwUGydFO0o--

