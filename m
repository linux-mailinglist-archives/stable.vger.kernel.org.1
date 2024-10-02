Return-Path: <stable+bounces-79853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AF998DA9E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3161C227B1
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA541D0DF7;
	Wed,  2 Oct 2024 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ATGZetsn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6161D07BC;
	Wed,  2 Oct 2024 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878658; cv=none; b=NT0iC+VaFR9CLyYlqcKsQ/fcYwVn+MlZrKii6E8BCR4P4c1t0h5UHc5aAnYeKyMyeJcMCJT21fShyOYzZKVRPOH4tNI3oPWIkAzS/gXhV2oVLLFm1/QU/9J8Pfiv5Fwjwwc7oLgBfvCufbNmYF6M2udgA+H78/bGcYOwYNneapA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878658; c=relaxed/simple;
	bh=mjHngy10yhiVNXEm6JTkR7wnznIIFE11NOVltRZLcbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOJ5eODJ2HdbXNH3BvdE+ITDilmR57ys1Sgm+f0PyIq9KEXPuaIRKLt1g8YjQzsGx/c00qOC0fi49DfvT9W4arZXsk1DWdBEX5YjC/90v/WAFxhZe79InF/8bJ1TUGYBKWa+l65JYhF1WRlwWKG4G4tYPJ3j3aaV/T3Y0t9uAP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ATGZetsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5403C4CEC2;
	Wed,  2 Oct 2024 14:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878658;
	bh=mjHngy10yhiVNXEm6JTkR7wnznIIFE11NOVltRZLcbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ATGZetsnlMKtKW5TM8FdJl4JeSYXTziFhIpSmmosBLqMKyQetFYXr12dkxVdV1C0l
	 wuaWFJqrDSIG0ev82wwqC23s1u9mDmWnSS3QYS3Ay3Wa/bUPIYBYqHibQpCKD4s3x0
	 8hVa2EgKGe/LbtT7BWS9ue2M3a2EySXzU2epEww0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Fangzhi Zuo <Jerry.Zuo@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.10 489/634] drm/amd/display: Skip Recompute DSC Params if no Stream on Link
Date: Wed,  2 Oct 2024 14:59:49 +0200
Message-ID: <20241002125830.404355391@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

commit 8151a6c13111b465dbabe07c19f572f7cbd16fef upstream.

[why]
Encounter NULL pointer dereference uner mst + dsc setup.

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

[how]
dsc recompute should be skipped if no mode change detected on the new
request. If detected, keep checking whether the stream is already on
current state or not.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1267,6 +1267,9 @@ static bool is_dsc_need_re_compute(
 	if (new_stream_on_link_num == 0)
 		return false;
 
+	if (new_stream_on_link_num == 0)
+		return false;
+
 	/* check current_state if there stream on link but it is not in
 	 * new request state
 	 */



