Return-Path: <stable+bounces-135786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAC2A9909C
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FED92049C
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A77228EA55;
	Wed, 23 Apr 2025 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vxZJFbRD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4672F27FD7A;
	Wed, 23 Apr 2025 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420840; cv=none; b=HoE/Nck2Xr3/juWT6Pw6LU0NQtHbk3lWDC3IvDCMmwvz81+Tn96Ezeo/ibpM7Ys4UkQ5dF75ACJFspctt4aZN4HD1fOvJbFUaWHDYvZv3dBdC58BpyXnF4ZlkSKF9OTzNx4MtuNJuSysHtswEJSADhYaDZ8SUxN+XmAUvgZceTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420840; c=relaxed/simple;
	bh=o12A9tWAH/VZmvQBd6xh7Krj/buu+7aQeX75BLCCwzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geWywjnu71mVTGooZsdObTxGRVdRAWkKyH7izNlvhtxfrBLxLdnWupS1XsWrRW2A/+hoibfMrU4V+ldOw5w8XNsoPf1bPihWT3sluOyGNnxtSpHwfzEHbRHB9f/S+q2ZH+RGJxetcLKXRq9DPZgZnP1A97a9HnfqqcLHhAqVmyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vxZJFbRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1E8C4CEE2;
	Wed, 23 Apr 2025 15:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420840;
	bh=o12A9tWAH/VZmvQBd6xh7Krj/buu+7aQeX75BLCCwzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vxZJFbRDuXRPRdMZLmLtdQ0iC62LZsUFvHBM5qjosZHVvk6UazRJg6fqyNmHM2ifv
	 FnKqzbUyo1ASRlUtDZDEmydKeF01WHGRcVwIXLrqDEKQeRkuz3lsVBsee/wkofHunb
	 3tc0dUz1rNTiiMm4e8ZyhSCIH7gRq985nRqXY+wY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>,
	Dongyan Qian <qiandongyan@loongson.cn>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 167/223] drm/amd/display: Protect FPU in dml2_validate()/dml21_validate()
Date: Wed, 23 Apr 2025 16:43:59 +0200
Message-ID: <20250423142623.970768914@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
References: <20250423142617.120834124@linuxfoundation.org>
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

From: Huacai Chen <chenhuacai@loongson.cn>

commit 366e77cd4923c3aa45341e15dcaf3377af9b042f upstream.

Commit 7da55c27e76749b9 ("drm/amd/display: Remove incorrect FP context
start") removes the FP context protection of dml2_create(), and it said
"All the DC_FP_START/END should be used before call anything from DML2".

However, dml2_validate()/dml21_validate() are not protected from their
callers, causing such errors:

 do_fpu invoked from kernel context![#1]:
 CPU: 10 UID: 0 PID: 331 Comm: kworker/10:1H Not tainted 6.14.0-rc6+ #4
 Workqueue: events_highpri dm_irq_work_func [amdgpu]
 pc ffff800003191eb0 ra ffff800003191e60 tp 9000000107a94000 sp 9000000107a975b0
 a0 9000000140ce4910 a1 0000000000000000 a2 9000000140ce49b0 a3 9000000140ce49a8
 a4 9000000140ce49a8 a5 0000000100000000 a6 0000000000000001 a7 9000000107a97660
 t0 ffff800003790000 t1 9000000140ce5000 t2 0000000000000001 t3 0000000000000000
 t4 0000000000000004 t5 0000000000000000 t6 0000000000000000 t7 0000000000000000
 t8 0000000100000000 u0 ffff8000031a3b9c s9 9000000130bc0000 s0 9000000132400000
 s1 9000000140ec0000 s2 9000000132400000 s3 9000000140ce0000 s4 90000000057f8b88
 s5 9000000140ec0000 s6 9000000140ce4910 s7 0000000000000001 s8 9000000130d45010
 ra: ffff800003191e60 dml21_map_dc_state_into_dml_display_cfg+0x40/0x1140 [amdgpu]
   ERA: ffff800003191eb0 dml21_map_dc_state_into_dml_display_cfg+0x90/0x1140 [amdgpu]
  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
  PRMD: 00000004 (PPLV0 +PIE -PWE)
  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
 ESTAT: 000f0000 [FPD] (IS= ECode=15 EsubCode=0)
  PRID: 0014d010 (Loongson-64bit, Loongson-3C6000/S)
 Process kworker/10:1H (pid: 331, threadinfo=000000007bf9ddb0, task=00000000cc4ab9f3)
 Stack : 0000000100000000 0000043800000780 0000000100000001 0000000100000001
         0000000000000000 0000078000000000 0000000000000438 0000078000000000
         0000000000000438 0000078000000000 0000000000000438 0000000100000000
         0000000100000000 0000000100000000 0000000100000000 0000000100000000
         0000000000000001 9000000140ec0000 9000000132400000 9000000132400000
         ffff800003408000 ffff800003408000 9000000132400000 9000000140ce0000
         9000000140ce0000 ffff800003193850 0000000000000001 9000000140ec0000
         9000000132400000 9000000140ec0860 9000000140ec0738 0000000000000001
         90000001405e8000 9000000130bc0000 9000000140ec02a8 ffff8000031b5db8
         0000000000000000 0000043800000780 0000000000000003 ffff8000031b79cc
         ...
 Call Trace:
 [<ffff800003191eb0>] dml21_map_dc_state_into_dml_display_cfg+0x90/0x1140 [amdgpu]
 [<ffff80000319384c>] dml21_validate+0xcc/0x520 [amdgpu]
 [<ffff8000031b8948>] dc_validate_global_state+0x2e8/0x460 [amdgpu]
 [<ffff800002e94034>] create_validate_stream_for_sink+0x3d4/0x420 [amdgpu]
 [<ffff800002e940e4>] amdgpu_dm_connector_mode_valid+0x64/0x240 [amdgpu]
 [<900000000441d6b8>] drm_connector_mode_valid+0x38/0x80
 [<900000000441d824>] __drm_helper_update_and_validate+0x124/0x3e0
 [<900000000441ddc0>] drm_helper_probe_single_connector_modes+0x2e0/0x620
 [<90000000044050dc>] drm_client_modeset_probe+0x23c/0x1780
 [<9000000004420384>] __drm_fb_helper_initial_config_and_unlock+0x44/0x5a0
 [<9000000004403acc>] drm_client_dev_hotplug+0xcc/0x140
 [<ffff800002e9ab50>] handle_hpd_irq_helper+0x1b0/0x1e0 [amdgpu]
 [<90000000038f5da0>] process_one_work+0x160/0x300
 [<90000000038f6718>] worker_thread+0x318/0x440
 [<9000000003901b8c>] kthread+0x12c/0x220
 [<90000000038b1484>] ret_from_kernel_thread+0x8/0xa4

Unfortunately, protecting dml2_validate()/dml21_validate() out of DML2
causes "sleeping function called from invalid context", so protect them
with DC_FP_START() and DC_FP_END() inside.

Fixes: 7da55c27e767 ("drm/amd/display: Remove incorrect FP context start")
Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Tested-by: Dongyan Qian <qiandongyan@loongson.cn>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c |    9 +++++++--
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c        |    5 +++++
 2 files changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -277,11 +277,16 @@ bool dml21_validate(const struct dc *in_
 {
 	bool out = false;
 
+	DC_FP_START();
+
 	/* Use dml_validate_only for fast_validate path */
-	if (fast_validate) {
+	if (fast_validate)
 		out = dml21_check_mode_support(in_dc, context, dml_ctx);
-	} else
+	else
 		out = dml21_mode_check_and_programming(in_dc, context, dml_ctx);
+
+	DC_FP_END();
+
 	return out;
 }
 
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -734,11 +734,16 @@ bool dml2_validate(const struct dc *in_d
 		return out;
 	}
 
+	DC_FP_START();
+
 	/* Use dml_validate_only for fast_validate path */
 	if (fast_validate)
 		out = dml2_validate_only(context);
 	else
 		out = dml2_validate_and_build_resource(in_dc, context);
+
+	DC_FP_END();
+
 	return out;
 }
 



