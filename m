Return-Path: <stable+bounces-140168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1604DAAA5C4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9DE97B0E28
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA73317C1B;
	Mon,  5 May 2025 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXSvnC8G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2178317C1A;
	Mon,  5 May 2025 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484264; cv=none; b=u9VF7r/P5h9jAL8rdCw4SiDioSBa993HWYREBtEIGatKXAAgPd3uwA7XIIu9dhl0usYFmUyIUT+UkKK0rCX5uGmVoBzIOrlkR6yvXGwjihT+PlROMrne11pge1EjVaVVOG7va5R7iELyhqWls2fhcGuhlUmu0AtedDw2OvyFlpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484264; c=relaxed/simple;
	bh=kadxP6WANXnFgGHhpgdEJ1JC4CJv8Ro89kYhIKY7X9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYVjGZ4gKhlTrDVOTtW0Enqp7H2s+8JT/zsqi714FWU0LtHffKHkZeveTLAO2T08dT75nKtpownBeRnQVYlXLQQukK8OkprPi5WoO8f5QN+xHn/34CNXQou+9AWuA4Q2g3wzLHLqxZJbCtFfRY6OuWd/C6TChaP4NYJ01/gNAZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXSvnC8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43441C4CEED;
	Mon,  5 May 2025 22:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484264;
	bh=kadxP6WANXnFgGHhpgdEJ1JC4CJv8Ro89kYhIKY7X9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EXSvnC8GHe5Dz2wRbxXRQc5U/bCCs8sKGBPGP/kzz1am2ZZSn/NPk0MRYnyxzA1Ue
	 UQVpryQrnlhTDl22357u+neG/gtxZJUSUlblvhNAPZVPeFCNq8Hf57tO1Cx3aWqrRN
	 M7HWZ/pEi3e9ij7NO4dSj+HFiPCGGpnCvzJlZrBaOPFT0/+sq3Hl5AInbC1FybACue
	 ES2jE6QBiK2G8HUBGC58GhCaHBlU+fagxJAHgtTFUyVhiCM/xFpmtSNvhPtr5h377V
	 h8IXtpT7TK2qqXrup/3zlq/Vqn0sjuoFKDZ+kiFqAXRe8j/5tp1kh+Wlwlex8HFUH+
	 ngfAXggh4G9DQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	=?UTF-8?q?Piotr=20Pi=C3=B3rkowski?= <piotr.piorkowski@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 421/642] drm/xe/pf: Release all VFs configs on device removal
Date: Mon,  5 May 2025 18:10:37 -0400
Message-Id: <20250505221419.2672473-421-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

[ Upstream commit 611160b02a40ce3f60ab94eea85b394dca1cafd2 ]

If we try to manually provision VFs using debugfs and then we
try to unload the driver, we will see complains like:

 [ ] Memory manager not clean during takedown.
 [ ] RIP: 0010:drm_mm_takedown+0x3f/0x100
 [ ] [drm:drm_mm_takedown] *ERROR* node [fedff000 + 00001000]: inserted at
      drm_mm_insert_node_in_range+0x2bd/0x520
      xe_ggtt_node_insert+0x52/0x90 [xe]
      pf_provision_vf_ggtt+0x1fa/0xac0 [xe]
      xe_gt_sriov_pf_config_set_ggtt+0x79/0x7a0 [xe]
      ggtt_set+0x53/0x80 [xe]
      simple_attr_write_xsigned.isra.0+0xd2/0x150
      simple_attr_write+0x14/0x30
      debugfs_attr_write+0x4e/0x80

 [ ] xe 0000:00:02.0: [drm] *ERROR* GT0: GUC ID manager unclean (1/65535)
 [ ] xe 0000:00:02.0: [drm] GT0:      total 65535
 [ ] xe 0000:00:02.0: [drm] GT0:      used 1
 [ ] xe 0000:00:02.0: [drm] GT0:      range 65534..65534 (1)

 [ ] xe 0000:00:02.0: [drm] *ERROR* GT0: GuC doorbells manager unclean (1/256)
 [ ] xe 0000:00:02.0: [drm] GT0:      count: 256
 [ ] xe 0000:00:02.0: [drm] GT0:      available range: 1..255 (255)
 [ ] xe 0000:00:02.0: [drm] GT0:      available total: 255
 [ ] xe 0000:00:02.0: [drm] GT0:      reserved range: 0..0 (1)
 [ ] xe 0000:00:02.0: [drm] GT0:      reserved total: 1

This could be easily fixed by adding config release action.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Piotr Piórkowski <piotr.piorkowski@intel.com>
Reviewed-by: Piotr Piórkowski <piotr.piorkowski@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250211155034.1028-1-michal.wajdeczko@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_sriov_pf.c        |  6 +++++
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c | 29 ++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.h |  1 +
 3 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf.c
index 6f906c8e8108b..b80930a6bc1a2 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf.c
@@ -78,6 +78,12 @@ int xe_gt_sriov_pf_init_early(struct xe_gt *gt)
  */
 int xe_gt_sriov_pf_init(struct xe_gt *gt)
 {
+	int err;
+
+	err = xe_gt_sriov_pf_config_init(gt);
+	if (err)
+		return err;
+
 	return xe_gt_sriov_pf_migration_init(gt);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
index 4bd255adfb401..aaca54b40091f 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
@@ -2320,6 +2320,35 @@ int xe_gt_sriov_pf_config_restore(struct xe_gt *gt, unsigned int vfid,
 	return err;
 }
 
+static void fini_config(void *arg)
+{
+	struct xe_gt *gt = arg;
+	struct xe_device *xe = gt_to_xe(gt);
+	unsigned int n, total_vfs = xe_sriov_pf_get_totalvfs(xe);
+
+	mutex_lock(xe_gt_sriov_pf_master_mutex(gt));
+	for (n = 1; n <= total_vfs; n++)
+		pf_release_vf_config(gt, n);
+	mutex_unlock(xe_gt_sriov_pf_master_mutex(gt));
+}
+
+/**
+ * xe_gt_sriov_pf_config_init - Initialize SR-IOV configuration data.
+ * @gt: the &xe_gt
+ *
+ * This function can only be called on PF.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int xe_gt_sriov_pf_config_init(struct xe_gt *gt)
+{
+	struct xe_device *xe = gt_to_xe(gt);
+
+	xe_gt_assert(gt, IS_SRIOV_PF(xe));
+
+	return devm_add_action_or_reset(xe->drm.dev, fini_config, gt);
+}
+
 /**
  * xe_gt_sriov_pf_config_restart - Restart SR-IOV configurations after a GT reset.
  * @gt: the &xe_gt
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.h b/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.h
index f894e9d4abba2..513e6512a575b 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.h
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.h
@@ -63,6 +63,7 @@ int xe_gt_sriov_pf_config_restore(struct xe_gt *gt, unsigned int vfid,
 
 bool xe_gt_sriov_pf_config_is_empty(struct xe_gt *gt, unsigned int vfid);
 
+int xe_gt_sriov_pf_config_init(struct xe_gt *gt);
 void xe_gt_sriov_pf_config_restart(struct xe_gt *gt);
 
 int xe_gt_sriov_pf_config_print_ggtt(struct xe_gt *gt, struct drm_printer *p);
-- 
2.39.5


