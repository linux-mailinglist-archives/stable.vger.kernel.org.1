Return-Path: <stable+bounces-20643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A442385AAB8
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3216B2500F
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7513A481A3;
	Mon, 19 Feb 2024 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sse1FjMl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35279481A7
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366587; cv=none; b=TxReD9e+RwkJh/Ov6AooMX5KkHcnKEyY9tPc+WPiVZvEvSDAAEuUsTKqkb7cbmO8PhPcdtPfTe8tpLtGyJaE26lG8gslCX9apdrilZQDTD++DpCGMRRCqrGj8Jn6qEwczf2E65v9PKWbQySOVq+CzMIQKRtUOxu4ImpedcpOJPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366587; c=relaxed/simple;
	bh=KW9BFA5WAU7Xwc8lSvHsSmuM3rU/nO4v5y0sdTKzeMM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HUSz4W3NXxEAmL/wLmz5T1/2r7fRsM6wbUk/w75r2Vfrvp5njRxpr05AKy5dsda0DCR4k/CxEu/zIGSafuXIDL5lIO5eFxa4R/WFyS7VezuZm6nyKQpyR3vQZzS/FvH0G6rsuGN6lEM//3sMc0oa569U2L7PU1gL4q58h4hgztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sse1FjMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEF7C433C7;
	Mon, 19 Feb 2024 18:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708366586;
	bh=KW9BFA5WAU7Xwc8lSvHsSmuM3rU/nO4v5y0sdTKzeMM=;
	h=Subject:To:Cc:From:Date:From;
	b=sse1FjMl8q9NzktX5dkfOGy2GDia/n/0bLU7PlQJmPWJy12a/0QisRw2tZpq8G7hb
	 axs8+ozq7G5zahnRcWdg/u8U5DBGVgvf0B61JFhQVZs6i0asjH82o6AKoY2KUVfEy1
	 bQlv846BuQw7hCT8sZpsM2JggGBxFxw+gLoZWsb0=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix MST Null Ptr for RV" failed to apply to 6.1-stable tree
To: jerry.zuo@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,wayne.lin@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:16:24 +0100
Message-ID: <2024021923-repose-genre-7137@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e6a7df96facdcf5b1f71eb3ec26f2f9f6ad61e57
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021923-repose-genre-7137@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

e6a7df96facd ("drm/amd/display: Fix MST Null Ptr for RV")
c18842a2e81a ("drm/amd/display: Return error code on DSC atomic check failure")
bf77fda02411 ("drm/amd/display: Drop unnecessary DCN guards")
cdf657fc1f4c ("amdgpu: fix build on non-DCN platforms.")
c689e1e362ea ("drm/amdgpu/display/mst: Fix mst_state->pbn_div and slot count assignments")
028c4ccfb812 ("drm/amd/display: force connector state when bpc changes during compliance")
7cce4cd628be ("drm/amdgpu/mst: Stop ignoring error codes and deadlocking")
b1a98cf89a69 ("drm/amd/display: Wrong colorimetry workaround")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e6a7df96facdcf5b1f71eb3ec26f2f9f6ad61e57 Mon Sep 17 00:00:00 2001
From: Fangzhi Zuo <jerry.zuo@amd.com>
Date: Mon, 22 Jan 2024 13:43:46 -0500
Subject: [PATCH] drm/amd/display: Fix MST Null Ptr for RV

The change try to fix below error specific to RV platform:

BUG: kernel NULL pointer dereference, address: 0000000000000008
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 4 PID: 917 Comm: sway Not tainted 6.3.9-arch1-1 #1 124dc55df4f5272ccb409f39ef4872fc2b3376a2
Hardware name: LENOVO 20NKS01Y00/20NKS01Y00, BIOS R12ET61W(1.31 ) 07/28/2022
RIP: 0010:drm_dp_atomic_find_time_slots+0x5e/0x260 [drm_display_helper]
Code: 01 00 00 48 8b 85 60 05 00 00 48 63 80 88 00 00 00 3b 43 28 0f 8d 2e 01 00 00 48 8b 53 30 48 8d 04 80 48 8d 04 c2 48 8b 40 18 <48> 8>
RSP: 0018:ffff960cc2df77d8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8afb87e81280 RCX: 0000000000000224
RDX: ffff8afb9ee37c00 RSI: ffff8afb8da1a578 RDI: ffff8afb87e81280
RBP: ffff8afb83d67000 R08: 0000000000000001 R09: ffff8afb9652f850
R10: ffff960cc2df7908 R11: 0000000000000002 R12: 0000000000000000
R13: ffff8afb8d7688a0 R14: ffff8afb8da1a578 R15: 0000000000000224
FS:  00007f4dac35ce00(0000) GS:ffff8afe30b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000010ddc6000 CR4: 00000000003506e0
Call Trace:
 <TASK>
 ? __die+0x23/0x70
 ? page_fault_oops+0x171/0x4e0
 ? plist_add+0xbe/0x100
 ? exc_page_fault+0x7c/0x180
 ? asm_exc_page_fault+0x26/0x30
 ? drm_dp_atomic_find_time_slots+0x5e/0x260 [drm_display_helper 0e67723696438d8e02b741593dd50d80b44c2026]
 ? drm_dp_atomic_find_time_slots+0x28/0x260 [drm_display_helper 0e67723696438d8e02b741593dd50d80b44c2026]
 compute_mst_dsc_configs_for_link+0x2ff/0xa40 [amdgpu 62e600d2a75e9158e1cd0a243bdc8e6da040c054]
 ? fill_plane_buffer_attributes+0x419/0x510 [amdgpu 62e600d2a75e9158e1cd0a243bdc8e6da040c054]
 compute_mst_dsc_configs_for_state+0x1e1/0x250 [amdgpu 62e600d2a75e9158e1cd0a243bdc8e6da040c054]
 amdgpu_dm_atomic_check+0xecd/0x1190 [amdgpu 62e600d2a75e9158e1cd0a243bdc8e6da040c054]
 drm_atomic_check_only+0x5c5/0xa40
 drm_mode_atomic_ioctl+0x76e/0xbc0
 ? _copy_to_user+0x25/0x30
 ? drm_ioctl+0x296/0x4b0
 ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
 drm_ioctl_kernel+0xcd/0x170
 drm_ioctl+0x26d/0x4b0
 ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
 amdgpu_drm_ioctl+0x4e/0x90 [amdgpu 62e600d2a75e9158e1cd0a243bdc8e6da040c054]
 __x64_sys_ioctl+0x94/0xd0
 do_syscall_64+0x60/0x90
 ? do_syscall_64+0x6c/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f4dad17f76f
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c>
RSP: 002b:00007ffd9ae859f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000055e255a55900 RCX: 00007f4dad17f76f
RDX: 00007ffd9ae85a90 RSI: 00000000c03864bc RDI: 000000000000000b
RBP: 00007ffd9ae85a90 R08: 0000000000000003 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000c03864bc
R13: 000000000000000b R14: 000055e255a7fc60 R15: 000055e255a01eb0
 </TASK>
Modules linked in: rfcomm snd_seq_dummy snd_hrtimer snd_seq snd_seq_device ccm cmac algif_hash algif_skcipher af_alg joydev mousedev bnep >
 typec libphy k10temp ipmi_msghandler roles i2c_scmi acpi_cpufreq mac_hid nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_mas>
CR2: 0000000000000008
---[ end trace 0000000000000000 ]---
RIP: 0010:drm_dp_atomic_find_time_slots+0x5e/0x260 [drm_display_helper]
Code: 01 00 00 48 8b 85 60 05 00 00 48 63 80 88 00 00 00 3b 43 28 0f 8d 2e 01 00 00 48 8b 53 30 48 8d 04 80 48 8d 04 c2 48 8b 40 18 <48> 8>
RSP: 0018:ffff960cc2df77d8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8afb87e81280 RCX: 0000000000000224
RDX: ffff8afb9ee37c00 RSI: ffff8afb8da1a578 RDI: ffff8afb87e81280
RBP: ffff8afb83d67000 R08: 0000000000000001 R09: ffff8afb9652f850
R10: ffff960cc2df7908 R11: 0000000000000002 R12: 0000000000000000
R13: ffff8afb8d7688a0 R14: ffff8afb8da1a578 R15: 0000000000000224
FS:  00007f4dac35ce00(0000) GS:ffff8afe30b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000010ddc6000 CR4: 00000000003506e0

With a second DP monitor connected, drm_atomic_state in dm atomic check
sequence does not include the connector state for the old/existing/first
DP monitor. In such case, dsc determination policy would hit a null ptr
when it tries to iterate the old/existing stream that does not have a
valid connector state attached to it. When that happens, dm atomic check
should call drm_atomic_get_connector_state for a new connector state.
Existing dm has already done that, except for RV due to it does not have
official support of dsc where .num_dsc is not defined in dcn10 resource
cap, that prevent from getting drm_atomic_get_connector_state called.
So, skip dsc determination policy for ASICs that don't have DSC support.

Cc: stable@vger.kernel.org # 6.1+
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2314
Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d292f290cd6e..59d2eee72a32 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10731,11 +10731,13 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			goto fail;
 		}
 
-		ret = compute_mst_dsc_configs_for_state(state, dm_state->context, vars);
-		if (ret) {
-			DRM_DEBUG_DRIVER("compute_mst_dsc_configs_for_state() failed\n");
-			ret = -EINVAL;
-			goto fail;
+		if (dc_resource_is_dsc_encoding_supported(dc)) {
+			ret = compute_mst_dsc_configs_for_state(state, dm_state->context, vars);
+			if (ret) {
+				DRM_DEBUG_DRIVER("compute_mst_dsc_configs_for_state() failed\n");
+				ret = -EINVAL;
+				goto fail;
+			}
 		}
 
 		ret = dm_update_mst_vcpi_slots_for_dsc(state, dm_state->context, vars);


