Return-Path: <stable+bounces-108927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C59A120F4
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E38188CB8B
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2C7248BC1;
	Wed, 15 Jan 2025 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N4W8jJ/0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE3D248BA1;
	Wed, 15 Jan 2025 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938272; cv=none; b=RyPYe6F0K/xJMBX+3YPW+WTNKowwhqza5kd4ds27GTL0N+WbJhcZ8QAKSX7Uu3a3oYhwt4wnQfILst4xpsx8qv2FctrWQJYSQ5i7KTzHleQH8WHSv9RpyX+U9LxfYjXOZ7Ki1qw1KerxbFmdgEJgYEMAFfoRNRi89kDcX8OZERg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938272; c=relaxed/simple;
	bh=jfpMIuCMMF+Sy7gPgQltN1bxdCZCNsDy/CfBXdtjPEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFOO4sdvLEoJQyPlOYklo9B+13UoVq7m8wpa+j0dH/Apz2CZAwh8naFCCF1qlAGI6nfzagDZaWC75GqdYP3Yyldp6OcsdWYrSpnLAEop06Pio9XO3eIPc3CjZqDLxy8sBfyG9RyB01cyBDbIhhFjSKp8dlm3GVhor0d0zVdnIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N4W8jJ/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30639C4CEE1;
	Wed, 15 Jan 2025 10:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736938271;
	bh=jfpMIuCMMF+Sy7gPgQltN1bxdCZCNsDy/CfBXdtjPEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N4W8jJ/0P3JU8IgnG8q1z11BOsCR4ZCRIs5gd3RAL4LBC5vc6cS9nZ5huzLo0WtGy
	 mJL7z6JDk8tclNjFz+q8bVMens327tmKjZTs/C5aFokRVwdaEhYS6bvtfhfMtmfZVT
	 RqEzKRxNGU6oiZ8IlsYmEBgUY5Ohzd5PAeHf0yAw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leo Li <sunpeng.li@amd.com>,
	Melissa Wen <mwen@igalia.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 126/189] drm/amd/display: fix page fault due to max surface definition mismatch
Date: Wed, 15 Jan 2025 11:37:02 +0100
Message-ID: <20250115103611.471210995@linuxfoundation.org>
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

commit 7de8d5c90be9ad9f6575e818a674801db2ada794 upstream.

DC driver is using two different values to define the maximum number of
surfaces: MAX_SURFACES and MAX_SURFACE_NUM. Consolidate MAX_SURFACES as
the unique definition for surface updates across DC.

It fixes page fault faced by Cosmic users on AMD display versions that
support two overlay planes, since the introduction of cursor overlay
mode.

[Nov26 21:33] BUG: unable to handle page fault for address: 0000000051d0f08b
[  +0.000015] #PF: supervisor read access in kernel mode
[  +0.000006] #PF: error_code(0x0000) - not-present page
[  +0.000005] PGD 0 P4D 0
[  +0.000007] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[  +0.000006] CPU: 4 PID: 71 Comm: kworker/u32:6 Not tainted 6.10.0+ #300
[  +0.000006] Hardware name: Valve Jupiter/Jupiter, BIOS F7A0131 01/30/2024
[  +0.000007] Workqueue: events_unbound commit_work [drm_kms_helper]
[  +0.000040] RIP: 0010:copy_stream_update_to_stream.isra.0+0x30d/0x750 [amdgpu]
[  +0.000847] Code: 8b 10 49 89 94 24 f8 00 00 00 48 8b 50 08 49 89 94 24 00 01 00 00 8b 40 10 41 89 84 24 08 01 00 00 49 8b 45 78 48 85 c0 74 0b <0f> b6 00 41 88 84 24 90 64 00 00 49 8b 45 60 48 85 c0 74 3b 48 8b
[  +0.000010] RSP: 0018:ffffc203802f79a0 EFLAGS: 00010206
[  +0.000009] RAX: 0000000051d0f08b RBX: 0000000000000004 RCX: ffff9f964f0a8070
[  +0.000004] RDX: ffff9f9710f90e40 RSI: ffff9f96600c8000 RDI: ffff9f964f000000
[  +0.000004] RBP: ffffc203802f79f8 R08: 0000000000000000 R09: 0000000000000000
[  +0.000005] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9f96600c8000
[  +0.000004] R13: ffff9f9710f90e40 R14: ffff9f964f000000 R15: ffff9f96600c8000
[  +0.000004] FS:  0000000000000000(0000) GS:ffff9f9970000000(0000) knlGS:0000000000000000
[  +0.000005] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000005] CR2: 0000000051d0f08b CR3: 00000002e6a20000 CR4: 0000000000350ef0
[  +0.000005] Call Trace:
[  +0.000011]  <TASK>
[  +0.000010]  ? __die_body.cold+0x19/0x27
[  +0.000012]  ? page_fault_oops+0x15a/0x2d0
[  +0.000014]  ? exc_page_fault+0x7e/0x180
[  +0.000009]  ? asm_exc_page_fault+0x26/0x30
[  +0.000013]  ? copy_stream_update_to_stream.isra.0+0x30d/0x750 [amdgpu]
[  +0.000739]  ? dc_commit_state_no_check+0xd6c/0xe70 [amdgpu]
[  +0.000470]  update_planes_and_stream_state+0x49b/0x4f0 [amdgpu]
[  +0.000450]  ? srso_return_thunk+0x5/0x5f
[  +0.000009]  ? commit_minimal_transition_state+0x239/0x3d0 [amdgpu]
[  +0.000446]  update_planes_and_stream_v2+0x24a/0x590 [amdgpu]
[  +0.000464]  ? srso_return_thunk+0x5/0x5f
[  +0.000009]  ? sort+0x31/0x50
[  +0.000007]  ? amdgpu_dm_atomic_commit_tail+0x159f/0x3a30 [amdgpu]
[  +0.000508]  ? srso_return_thunk+0x5/0x5f
[  +0.000009]  ? amdgpu_crtc_get_scanout_position+0x28/0x40 [amdgpu]
[  +0.000377]  ? srso_return_thunk+0x5/0x5f
[  +0.000009]  ? drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x160/0x390 [drm]
[  +0.000058]  ? srso_return_thunk+0x5/0x5f
[  +0.000005]  ? dma_fence_default_wait+0x8c/0x260
[  +0.000010]  ? srso_return_thunk+0x5/0x5f
[  +0.000005]  ? wait_for_completion_timeout+0x13b/0x170
[  +0.000006]  ? srso_return_thunk+0x5/0x5f
[  +0.000005]  ? dma_fence_wait_timeout+0x108/0x140
[  +0.000010]  ? commit_tail+0x94/0x130 [drm_kms_helper]
[  +0.000024]  ? process_one_work+0x177/0x330
[  +0.000008]  ? worker_thread+0x266/0x3a0
[  +0.000006]  ? __pfx_worker_thread+0x10/0x10
[  +0.000004]  ? kthread+0xd2/0x100
[  +0.000006]  ? __pfx_kthread+0x10/0x10
[  +0.000006]  ? ret_from_fork+0x34/0x50
[  +0.000004]  ? __pfx_kthread+0x10/0x10
[  +0.000005]  ? ret_from_fork_asm+0x1a/0x30
[  +0.000011]  </TASK>

Fixes: 1b04dcca4fb1 ("drm/amd/display: Introduce overlay cursor mode")
Suggested-by: Leo Li <sunpeng.li@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3693
Signed-off-by: Melissa Wen <mwen@igalia.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1c86c81a86c60f9b15d3e3f43af0363cf56063e7)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c                |    2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_state.c          |    8 ++++----
 drivers/gpu/drm/amd/display/dc/dc.h                     |    2 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h              |    2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h               |    1 -
 drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c |    2 +-
 6 files changed, 8 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4421,7 +4421,7 @@ static bool commit_minimal_transition_ba
 	struct pipe_split_policy_backup policy;
 	struct dc_state *intermediate_context;
 	struct dc_state *old_current_state = dc->current_state;
-	struct dc_surface_update srf_updates[MAX_SURFACE_NUM] = {0};
+	struct dc_surface_update srf_updates[MAX_SURFACES] = {0};
 	int surface_count;
 
 	/*
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -483,9 +483,9 @@ bool dc_state_add_plane(
 	if (stream_status == NULL) {
 		dm_error("Existing stream not found; failed to attach surface!\n");
 		goto out;
-	} else if (stream_status->plane_count == MAX_SURFACE_NUM) {
+	} else if (stream_status->plane_count == MAX_SURFACES) {
 		dm_error("Surface: can not attach plane_state %p! Maximum is: %d\n",
-				plane_state, MAX_SURFACE_NUM);
+				plane_state, MAX_SURFACES);
 		goto out;
 	} else if (!otg_master_pipe) {
 		goto out;
@@ -600,7 +600,7 @@ bool dc_state_rem_all_planes_for_stream(
 {
 	int i, old_plane_count;
 	struct dc_stream_status *stream_status = NULL;
-	struct dc_plane_state *del_planes[MAX_SURFACE_NUM] = { 0 };
+	struct dc_plane_state *del_planes[MAX_SURFACES] = { 0 };
 
 	for (i = 0; i < state->stream_count; i++)
 		if (state->streams[i] == stream) {
@@ -875,7 +875,7 @@ bool dc_state_rem_all_phantom_planes_for
 {
 	int i, old_plane_count;
 	struct dc_stream_status *stream_status = NULL;
-	struct dc_plane_state *del_planes[MAX_SURFACE_NUM] = { 0 };
+	struct dc_plane_state *del_planes[MAX_SURFACES] = { 0 };
 
 	for (i = 0; i < state->stream_count; i++)
 		if (state->streams[i] == phantom_stream) {
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1390,7 +1390,7 @@ struct dc_scratch_space {
 	 * store current value in plane states so we can still recover
 	 * a valid current state during dc update.
 	 */
-	struct dc_plane_state plane_states[MAX_SURFACE_NUM];
+	struct dc_plane_state plane_states[MAX_SURFACES];
 
 	struct dc_stream_state stream_state;
 };
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -56,7 +56,7 @@ struct dc_stream_status {
 	int plane_count;
 	int audio_inst;
 	struct timing_sync_info timing_sync_info;
-	struct dc_plane_state *plane_states[MAX_SURFACE_NUM];
+	struct dc_plane_state *plane_states[MAX_SURFACES];
 	bool is_abm_supported;
 	struct mall_stream_config mall_stream_config;
 	bool fpo_in_use;
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -76,7 +76,6 @@ struct dc_perf_trace {
 	unsigned long last_entry_write;
 };
 
-#define MAX_SURFACE_NUM 6
 #define NUM_PIXEL_FORMATS 10
 
 enum tiling_mode {
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c
@@ -813,7 +813,7 @@ static bool remove_all_phantom_planes_fo
 {
 	int i, old_plane_count;
 	struct dc_stream_status *stream_status = NULL;
-	struct dc_plane_state *del_planes[MAX_SURFACE_NUM] = { 0 };
+	struct dc_plane_state *del_planes[MAX_SURFACES] = { 0 };
 
 	for (i = 0; i < context->stream_count; i++)
 			if (context->streams[i] == stream) {



