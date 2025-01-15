Return-Path: <stable+bounces-108960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA12A12121
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5163188CB8D
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25F1E9905;
	Wed, 15 Jan 2025 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bHvqh9wo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB78F1E98F6;
	Wed, 15 Jan 2025 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938384; cv=none; b=N9DKn9TDtg8jKwRGzYyzHMANubA6FkzVkjzgjtGaxKpeXQYs5XuKRjGVShU9DrDYN58RVlDIOeiP2+FRcXoWERgwROAxAUqZPNpSJ8K/dUp0LvFjDMAT3o9uAt/avZEfzB4f5SkqwzWnrLUVMpOx2Ymji0RJluThBoueCyCMAwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938384; c=relaxed/simple;
	bh=NAe26oVsu6fquadRJOAXuS/4E6SoD/3tkl2hEeP8V0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohNz7A6Jl2+W54WhbkRIUmP8aBdhoiC37/44hUNGtnQ6u2C/r1luDPFBhK0sBjeqPlQh/yKAho2RFfpE+FKnGHC01AJx6i+Wpn8ZOH7LykAM6Q9vin0iG37mhq4Qi/6u8g7qFo8++QkxosAj6/aMS5wow1RRJT6nlK/Nu0hp5q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bHvqh9wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE5AC4CEDF;
	Wed, 15 Jan 2025 10:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736938384;
	bh=NAe26oVsu6fquadRJOAXuS/4E6SoD/3tkl2hEeP8V0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHvqh9wowBdEksPKt+v9jLqaU85RKDnN6/1R30PHJBYn+ZC/COdHJfonsXEZm6mIW
	 E7J0axCRC+Plq9STl/+ony1My1trwReagF2Z2MLRhNHPILu2JNL/ghA+jlxzSDGaY+
	 KPYOB162nCe1il3L3PrT+PuljcMumBquA16FMzsk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fabio Scaccabarozzi <fsvm88@gmail.com>,
	Melissa Wen <mwen@igalia.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 125/189] drm/amd/display: fix divide error in DM plane scale calcs
Date: Wed, 15 Jan 2025 11:37:01 +0100
Message-ID: <20250115103611.433508138@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
References: <20250115103606.357764746@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Melissa Wen <mwen@igalia.com>

commit 5225fd2a26211d012533acf98a6ad3f983885817 upstream.

dm_get_plane_scale doesn't take into account plane scaled size equal to
zero, leading to a kernel oops due to division by zero. Fix by setting
out-scale size as zero when the dst size is zero, similar to what is
done by drm_calc_scale(). This issue started with the introduction of
cursor ovelay mode that uses this function to assess cursor mode changes
via dm_crtc_get_cursor_mode() before checking plane state.

[Dec17 17:14] Oops: divide error: 0000 [#1] PREEMPT SMP NOPTI
[  +0.000018] CPU: 5 PID: 1660 Comm: surface-DP-1 Not tainted 6.10.0+ #231
[  +0.000007] Hardware name: Valve Jupiter/Jupiter, BIOS F7A0131 01/30/2024
[  +0.000004] RIP: 0010:dm_get_plane_scale+0x3f/0x60 [amdgpu]
[  +0.000553] Code: 44 0f b7 41 3a 44 0f b7 49 3e 83 e0 0f 48 0f a3 c2 73 21 69 41 28 e8 03 00 00 31 d2 41 f7 f1 31 d2 89 06 69 41 2c e8 03 00 00 <41> f7 f0 89 07 e9 d7 d8 7e e9 44 89 c8 45 89 c1 41 89 c0 eb d4 66
[  +0.000005] RSP: 0018:ffffa8df0de6b8a0 EFLAGS: 00010246
[  +0.000006] RAX: 00000000000003e8 RBX: ffff9ac65c1f6e00 RCX: ffff9ac65d055500
[  +0.000003] RDX: 0000000000000000 RSI: ffffa8df0de6b8b0 RDI: ffffa8df0de6b8b4
[  +0.000004] RBP: ffff9ac64e7a5800 R08: 0000000000000000 R09: 0000000000000a00
[  +0.000003] R10: 00000000000000ff R11: 0000000000000054 R12: ffff9ac6d0700010
[  +0.000003] R13: ffff9ac65d054f00 R14: ffff9ac65d055500 R15: ffff9ac64e7a60a0
[  +0.000004] FS:  00007f869ea00640(0000) GS:ffff9ac970080000(0000) knlGS:0000000000000000
[  +0.000004] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000003] CR2: 000055ca701becd0 CR3: 000000010e7f2000 CR4: 0000000000350ef0
[  +0.000004] Call Trace:
[  +0.000007]  <TASK>
[  +0.000006]  ? __die_body.cold+0x19/0x27
[  +0.000009]  ? die+0x2e/0x50
[  +0.000007]  ? do_trap+0xca/0x110
[  +0.000007]  ? do_error_trap+0x6a/0x90
[  +0.000006]  ? dm_get_plane_scale+0x3f/0x60 [amdgpu]
[  +0.000504]  ? exc_divide_error+0x38/0x50
[  +0.000005]  ? dm_get_plane_scale+0x3f/0x60 [amdgpu]
[  +0.000488]  ? asm_exc_divide_error+0x1a/0x20
[  +0.000011]  ? dm_get_plane_scale+0x3f/0x60 [amdgpu]
[  +0.000593]  dm_crtc_get_cursor_mode+0x33f/0x430 [amdgpu]
[  +0.000562]  amdgpu_dm_atomic_check+0x2ef/0x1770 [amdgpu]
[  +0.000501]  drm_atomic_check_only+0x5e1/0xa30 [drm]
[  +0.000047]  drm_mode_atomic_ioctl+0x832/0xcb0 [drm]
[  +0.000050]  ? __pfx_drm_mode_atomic_ioctl+0x10/0x10 [drm]
[  +0.000047]  drm_ioctl_kernel+0xb3/0x100 [drm]
[  +0.000062]  drm_ioctl+0x27a/0x4f0 [drm]
[  +0.000049]  ? __pfx_drm_mode_atomic_ioctl+0x10/0x10 [drm]
[  +0.000055]  amdgpu_drm_ioctl+0x4e/0x90 [amdgpu]
[  +0.000360]  __x64_sys_ioctl+0x97/0xd0
[  +0.000010]  do_syscall_64+0x82/0x190
[  +0.000008]  ? __pfx_drm_mode_createblob_ioctl+0x10/0x10 [drm]
[  +0.000044]  ? srso_return_thunk+0x5/0x5f
[  +0.000006]  ? drm_ioctl_kernel+0xb3/0x100 [drm]
[  +0.000040]  ? srso_return_thunk+0x5/0x5f
[  +0.000005]  ? __check_object_size+0x50/0x220
[  +0.000007]  ? srso_return_thunk+0x5/0x5f
[  +0.000005]  ? srso_return_thunk+0x5/0x5f
[  +0.000005]  ? drm_ioctl+0x2a4/0x4f0 [drm]
[  +0.000039]  ? __pfx_drm_mode_createblob_ioctl+0x10/0x10 [drm]
[  +0.000043]  ? srso_return_thunk+0x5/0x5f
[  +0.000005]  ? srso_return_thunk+0x5/0x5f
[  +0.000005]  ? __pm_runtime_suspend+0x69/0xc0
[  +0.000006]  ? srso_return_thunk+0x5/0x5f
[  +0.000005]  ? amdgpu_drm_ioctl+0x71/0x90 [amdgpu]
[  +0.000366]  ? srso_return_thunk+0x5/0x5f
[  +0.000006]  ? syscall_exit_to_user_mode+0x77/0x210
[  +0.000007]  ? srso_return_thunk+0x5/0x5f
[  +0.000005]  ? do_syscall_64+0x8e/0x190
[  +0.000006]  ? srso_return_thunk+0x5/0x5f
[  +0.000006]  ? do_syscall_64+0x8e/0x190
[  +0.000006]  ? srso_return_thunk+0x5/0x5f
[  +0.000007]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000008] RIP: 0033:0x55bb7cd962bc
[  +0.000007] Code: 4c 89 6c 24 18 4c 89 64 24 20 4c 89 74 24 28 0f 57 c0 0f 11 44 24 30 89 c7 48 8d 54 24 08 b8 10 00 00 00 be bc 64 38 c0 0f 05 <49> 89 c7 48 83 3b 00 74 09 4c 89 c7 ff 15 62 64 99 00 48 83 7b 18
[  +0.000005] RSP: 002b:00007f869e9f4da0 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
[  +0.000007] RAX: ffffffffffffffda RBX: 00007f869e9f4fb8 RCX: 000055bb7cd962bc
[  +0.000004] RDX: 00007f869e9f4da8 RSI: 00000000c03864bc RDI: 000000000000003b
[  +0.000003] RBP: 000055bb9ddcbcc0 R08: 00007f86541b9920 R09: 0000000000000009
[  +0.000004] R10: 0000000000000004 R11: 0000000000000217 R12: 00007f865406c6b0
[  +0.000003] R13: 00007f86541b5290 R14: 00007f865410b700 R15: 000055bb9ddcbc18
[  +0.000009]  </TASK>

Fixes: 1b04dcca4fb1 ("drm/amd/display: Introduce overlay cursor mode")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3729
Reported-by: Fabio Scaccabarozzi <fsvm88@gmail.com>
Co-developed-by: Fabio Scaccabarozzi <fsvm88@gmail.com>
Signed-off-by: Fabio Scaccabarozzi <fsvm88@gmail.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ab75a0d2e07942ae15d32c0a5092fd336451378c)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11115,8 +11115,8 @@ dm_get_plane_scale(struct drm_plane_stat
 	int plane_src_w, plane_src_h;
 
 	dm_get_oriented_plane_size(plane_state, &plane_src_w, &plane_src_h);
-	*out_plane_scale_w = plane_state->crtc_w * 1000 / plane_src_w;
-	*out_plane_scale_h = plane_state->crtc_h * 1000 / plane_src_h;
+	*out_plane_scale_w = plane_src_w ? plane_state->crtc_w * 1000 / plane_src_w : 0;
+	*out_plane_scale_h = plane_src_h ? plane_state->crtc_h * 1000 / plane_src_h : 0;
 }
 
 /*



