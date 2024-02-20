Return-Path: <stable+bounces-21256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0819585C7E5
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EBC28472F
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459E9151CDC;
	Tue, 20 Feb 2024 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1+Wfs8s3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0545F612D7;
	Tue, 20 Feb 2024 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463847; cv=none; b=Gsy5sdPCrQXJzkegfFrhhMDpeDkiRswBxg1DfXAzW0dkUgUz1kkVv7t3XJa8bKWam64Gr7W3eArPa87RBJyHT6BJY0g6QM8LL29CdATku+J6U3nbWjjLx5fEm9xB/NZg2h452tyQ3HEhyydKO2yLcaiW8hAktIKDar+wrQSSHzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463847; c=relaxed/simple;
	bh=jTNZPWWqmOFZUZ8ljGWAZf1ksi8+wnNtsKgBpMW8juo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bM2Nd5qayKO6bzkpzYYT0b1A5YJ0koSh6Li2vNJNbIpLaonrzehsFJgZzFmJ8kk7rr8Rog+5PSHmoni/K93sriVTddUNOZCXEBUyCHnxhWFSnu+tBqPOHPxT6T9BuNJJ1BLJIdfa6HvxqG6vXra5w13mr5Jt7BmUwAg3c3QQ/64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1+Wfs8s3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7984EC433C7;
	Tue, 20 Feb 2024 21:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708463846;
	bh=jTNZPWWqmOFZUZ8ljGWAZf1ksi8+wnNtsKgBpMW8juo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1+Wfs8s35ud9zz8BMQ0RCCI1PuLKs/o5XIr6hba0U3fd2BxTwtuionEhrKmUY9GyK
	 vpNg+BGNfo8/FaeRzRF3AnXhoM+8vz6os4TG7b8bbBq84+yG96g19Bet9i8AFIsBRs
	 7JWJr/XkiZUqZbwrxQrjBj8iZhuM4Gvxs0/gEC4o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wayne Lin <wayne.lin@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Fangzhi Zuo <jerry.zuo@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 171/331] drm/amd/display: Fix MST Null Ptr for RV
Date: Tue, 20 Feb 2024 21:54:47 +0100
Message-ID: <20240220205642.887720184@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205637.572693592@linuxfoundation.org>
References: <20240220205637.572693592@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fangzhi Zuo <jerry.zuo@amd.com>

commit e6a7df96facdcf5b1f71eb3ec26f2f9f6ad61e57 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10358,11 +10358,13 @@ static int amdgpu_dm_atomic_check(struct
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



