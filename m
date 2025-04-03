Return-Path: <stable+bounces-128041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EC8A7AE93
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2723BDE05
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EF220DD65;
	Thu,  3 Apr 2025 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7gW0god"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E8220C478;
	Thu,  3 Apr 2025 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707828; cv=none; b=Cn77CBlcXLBn+oru+UsaOYC5fsTEzXrC1RdNOaC/SHX0ZSJF3isUm1RluO0tRPTeWgxKrPKwE/gQT/crKVHnQnC8NIOjXXwnkj2LOi9WSNBNQ1tjLOHAHx3+cTSw+Me0Aer586Os3KGXU9mvi0/Hf+fn+6VWDvU+2YH3r1vD3M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707828; c=relaxed/simple;
	bh=I6+V79eqV4rkQpydcsDA3P4Knwh1EnXeHI5oacx9hpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tygOzpKJImbbpRwNOVJnzXUbOZOBF4hcv3rH5B9KhM6XCIm6W1U0rLJg1wWgIpnSAhq3TpeoO3OqC/q6Xq/l80FPSgBlndGH6qnyoIGWYy2hX2LSgWwPwxp+4i0PDUlkbtke3+SQtzjVmHTCyj/KtM+2NLaCYofViOvJ16/Xh4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7gW0god; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DC1C4CEE9;
	Thu,  3 Apr 2025 19:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707828;
	bh=I6+V79eqV4rkQpydcsDA3P4Knwh1EnXeHI5oacx9hpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q7gW0godM1qb03dErpwTC/Tj619H8HBdwHX0Pirxh9qHat415i6E1AoG4miO+ENH3
	 jSUbKsnudCW9e0HI7EBirocxImNzOFSym91cOpYvymr6mnFJFHJ3dvb1/3bHXoOOzn
	 FV/P0FCPkHkkBtPlWnA0hqjzk+SvJaEYthVISr8irspDunpm+kuTm6zlRcskLRT+xs
	 1wNKpQTgwwvKN3dn7Bjwh7igFpPW2P9iRczzUoLycpvy4Tiv1FT3jb3IKZY4DBwjSt
	 7DSXoXcxa6Hy/AKt2C99o8GQqQVyIhcKcaOGKVMOigCrD6JQpojGTAY0ojYBU7OIMs
	 cHa1m77Fmg0bA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 03/33] drm/xe/vf: Don't try to trigger a full GT reset if VF
Date: Thu,  3 Apr 2025 15:16:26 -0400
Message-Id: <20250403191656.2680995-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191656.2680995-1-sashal@kernel.org>
References: <20250403191656.2680995-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

[ Upstream commit 459777724d306315070d24608fcd89aea85516d6 ]

VFs don't have access to the GDRST(0x941c) register that driver
uses to reset a GT. Attempt to trigger a reset using debugfs:

 $ cat /sys/kernel/debug/dri/0000:00:02.1/gt0/force_reset

or due to a hang condition detected by the driver leads to:

 [ ] xe 0000:00:02.1: [drm] GT0: trying reset from force_reset [xe]
 [ ] xe 0000:00:02.1: [drm] GT0: reset queued
 [ ] xe 0000:00:02.1: [drm] GT0: reset started
 [ ] ------------[ cut here ]------------
 [ ] xe 0000:00:02.1: [drm] GT0: VF is trying to write 0x1 to an inaccessible register 0x941c+0x0
 [ ] WARNING: CPU: 3 PID: 3069 at drivers/gpu/drm/xe/xe_gt_sriov_vf.c:996 xe_gt_sriov_vf_write32+0xc6/0x580 [xe]
 [ ] RIP: 0010:xe_gt_sriov_vf_write32+0xc6/0x580 [xe]
 [ ] Call Trace:
 [ ]  <TASK>
 [ ]  ? show_regs+0x6c/0x80
 [ ]  ? __warn+0x93/0x1c0
 [ ]  ? xe_gt_sriov_vf_write32+0xc6/0x580 [xe]
 [ ]  ? report_bug+0x182/0x1b0
 [ ]  ? handle_bug+0x6e/0xb0
 [ ]  ? exc_invalid_op+0x18/0x80
 [ ]  ? asm_exc_invalid_op+0x1b/0x20
 [ ]  ? xe_gt_sriov_vf_write32+0xc6/0x580 [xe]
 [ ]  ? xe_gt_sriov_vf_write32+0xc6/0x580 [xe]
 [ ]  ? xe_gt_tlb_invalidation_reset+0xef/0x110 [xe]
 [ ]  ? __mutex_unlock_slowpath+0x41/0x2e0
 [ ]  xe_mmio_write32+0x64/0x150 [xe]
 [ ]  do_gt_reset+0x2f/0xa0 [xe]
 [ ]  gt_reset_worker+0x14e/0x1e0 [xe]
 [ ]  process_one_work+0x21c/0x740
 [ ]  worker_thread+0x1db/0x3c0

Fix that by sending H2G VF_RESET(0x5507) action instead.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4078
Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250131182502.852-1-michal.wajdeczko@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt.c          |  4 ++++
 drivers/gpu/drm/xe/xe_gt_sriov_vf.c | 16 ++++++++++++++++
 drivers/gpu/drm/xe/xe_gt_sriov_vf.h |  1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 98fe8573e054e..17ba15132a984 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -32,6 +32,7 @@
 #include "xe_gt_pagefault.h"
 #include "xe_gt_printk.h"
 #include "xe_gt_sriov_pf.h"
+#include "xe_gt_sriov_vf.h"
 #include "xe_gt_sysfs.h"
 #include "xe_gt_tlb_invalidation.h"
 #include "xe_gt_topology.h"
@@ -647,6 +648,9 @@ static int do_gt_reset(struct xe_gt *gt)
 {
 	int err;
 
+	if (IS_SRIOV_VF(gt_to_xe(gt)))
+		return xe_gt_sriov_vf_reset(gt);
+
 	xe_gsc_wa_14015076503(gt, true);
 
 	xe_mmio_write32(gt, GDRST, GRDOM_FULL);
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_vf.c b/drivers/gpu/drm/xe/xe_gt_sriov_vf.c
index 4ebc82e607af6..f982d6f9f218d 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_vf.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_vf.c
@@ -57,6 +57,22 @@ static int vf_reset_guc_state(struct xe_gt *gt)
 	return err;
 }
 
+/**
+ * xe_gt_sriov_vf_reset - Reset GuC VF internal state.
+ * @gt: the &xe_gt
+ *
+ * It requires functional `GuC MMIO based communication`_.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int xe_gt_sriov_vf_reset(struct xe_gt *gt)
+{
+	if (!xe_device_uc_enabled(gt_to_xe(gt)))
+		return -ENODEV;
+
+	return vf_reset_guc_state(gt);
+}
+
 static int guc_action_match_version(struct xe_guc *guc,
 				    u32 wanted_branch, u32 wanted_major, u32 wanted_minor,
 				    u32 *branch, u32 *major, u32 *minor, u32 *patch)
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_vf.h b/drivers/gpu/drm/xe/xe_gt_sriov_vf.h
index e541ce57bec24..576ff5e795a8b 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_vf.h
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_vf.h
@@ -12,6 +12,7 @@ struct drm_printer;
 struct xe_gt;
 struct xe_reg;
 
+int xe_gt_sriov_vf_reset(struct xe_gt *gt);
 int xe_gt_sriov_vf_bootstrap(struct xe_gt *gt);
 int xe_gt_sriov_vf_query_config(struct xe_gt *gt);
 int xe_gt_sriov_vf_connect(struct xe_gt *gt);
-- 
2.39.5


