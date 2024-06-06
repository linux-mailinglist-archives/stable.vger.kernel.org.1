Return-Path: <stable+bounces-49798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A898FEEE7
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C37C1F25751
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DEA1C8A11;
	Thu,  6 Jun 2024 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iZwe1zs9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F761C8A0E;
	Thu,  6 Jun 2024 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683714; cv=none; b=bI+gdf4CoVbA1gOxGtVxK4u7u4YIqwzGsGBevb1vxwHNB0/TUdQCTgD8wt706xdnlaWjAn5drIWj8z9sGHJreQHKLEox54VqrmNJcQaiXnwg1mshpXFk4zQ0r8slnZSo1uQMN8WdcbWQQHMhz2u/66DQ58ciLruly0W+6/zUTXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683714; c=relaxed/simple;
	bh=TQ4r3xY74p4LjtFSL58yMpGVZgj17fBSb4SuL+Mk5bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkUIy38TETZMxsMpW2Xnml5T//wxpMlvGBiKOTq+qCSOuXrdHESEmRPSM+aJ1md8aepmYsUeG0eYKHan/dET+CYW/V6CKSp7p0EIiMGROBBJeShlzsD24/nK6GtBQYDWf777XHm8gIRNy4NrHu7V+Y0JYpZZUvOPZOi2CWHde9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iZwe1zs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA62C2BD10;
	Thu,  6 Jun 2024 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683714;
	bh=TQ4r3xY74p4LjtFSL58yMpGVZgj17fBSb4SuL+Mk5bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iZwe1zs9VfoSNzB1Q6qxPlPlx9IphKHPn7yNs1Oz2hf+X1tWbXF0u9/lC9OEZeiKv
	 5hjD/OTXXVe09bPb1ZYDejxe2bvxrfH3fMUnnk+AO6uqoJd+YubdY07+pZPjP2jV9K
	 HuRkgMNc8UcumiJB03VIrSZGdqxM7YZ1x2BtM7uI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Anderson <sean.anderson@linux.dev>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 612/744] drm: zynqmp_dpsub: Always register bridge
Date: Thu,  6 Jun 2024 16:04:44 +0200
Message-ID: <20240606131752.119939731@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: Sean Anderson <sean.anderson@linux.dev>

[ Upstream commit be3f3042391d061cfca2bd22630e0d101acea5fc ]

We must always register the DRM bridge, since zynqmp_dp_hpd_work_func
calls drm_bridge_hpd_notify, which in turn expects hpd_mutex to be
initialized. We do this before zynqmp_dpsub_drm_init since that calls
drm_bridge_attach. This fixes the following lockdep warning:

[   19.217084] ------------[ cut here ]------------
[   19.227530] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
[   19.227768] WARNING: CPU: 0 PID: 140 at kernel/locking/mutex.c:582 __mutex_lock+0x4bc/0x550
[   19.241696] Modules linked in:
[   19.244937] CPU: 0 PID: 140 Comm: kworker/0:4 Not tainted 6.6.20+ #96
[   19.252046] Hardware name: xlnx,zynqmp (DT)
[   19.256421] Workqueue: events zynqmp_dp_hpd_work_func
[   19.261795] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   19.269104] pc : __mutex_lock+0x4bc/0x550
[   19.273364] lr : __mutex_lock+0x4bc/0x550
[   19.277592] sp : ffffffc085c5bbe0
[   19.281066] x29: ffffffc085c5bbe0 x28: 0000000000000000 x27: ffffff88009417f8
[   19.288624] x26: ffffff8800941788 x25: ffffff8800020008 x24: ffffffc082aa3000
[   19.296227] x23: ffffffc080d90e3c x22: 0000000000000002 x21: 0000000000000000
[   19.303744] x20: 0000000000000000 x19: ffffff88002f5210 x18: 0000000000000000
[   19.311295] x17: 6c707369642e3030 x16: 3030613464662072 x15: 0720072007200720
[   19.318922] x14: 0000000000000000 x13: 284e4f5f4e524157 x12: 0000000000000001
[   19.326442] x11: 0001ffc085c5b940 x10: 0001ff88003f388b x9 : 0001ff88003f3888
[   19.334003] x8 : 0001ff88003f3888 x7 : 0000000000000000 x6 : 0000000000000000
[   19.341537] x5 : 0000000000000000 x4 : 0000000000001668 x3 : 0000000000000000
[   19.349054] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff88003f3880
[   19.356581] Call trace:
[   19.359160]  __mutex_lock+0x4bc/0x550
[   19.363032]  mutex_lock_nested+0x24/0x30
[   19.367187]  drm_bridge_hpd_notify+0x2c/0x6c
[   19.371698]  zynqmp_dp_hpd_work_func+0x44/0x54
[   19.376364]  process_one_work+0x3ac/0x988
[   19.380660]  worker_thread+0x398/0x694
[   19.384736]  kthread+0x1bc/0x1c0
[   19.388241]  ret_from_fork+0x10/0x20
[   19.392031] irq event stamp: 183
[   19.395450] hardirqs last  enabled at (183): [<ffffffc0800b9278>] finish_task_switch.isra.0+0xa8/0x2d4
[   19.405140] hardirqs last disabled at (182): [<ffffffc081ad3754>] __schedule+0x714/0xd04
[   19.413612] softirqs last  enabled at (114): [<ffffffc080133de8>] srcu_invoke_callbacks+0x158/0x23c
[   19.423128] softirqs last disabled at (110): [<ffffffc080133de8>] srcu_invoke_callbacks+0x158/0x23c
[   19.432614] ---[ end trace 0000000000000000 ]---

Fixes: eb2d64bfcc17 ("drm: xlnx: zynqmp_dpsub: Report HPD through the bridge")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240308204741.3631919-1-sean.anderson@linux.dev
(cherry picked from commit 61ba791c4a7a09a370c45b70a81b8c7d4cf6b2ae)
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
index 88eb33acd5f0d..face8d6b2a6fb 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
@@ -256,12 +256,12 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_dp;
 
+	drm_bridge_add(dpsub->bridge);
+
 	if (dpsub->dma_enabled) {
 		ret = zynqmp_dpsub_drm_init(dpsub);
 		if (ret)
 			goto err_disp;
-	} else {
-		drm_bridge_add(dpsub->bridge);
 	}
 
 	dev_info(&pdev->dev, "ZynqMP DisplayPort Subsystem driver probed");
@@ -288,9 +288,8 @@ static void zynqmp_dpsub_remove(struct platform_device *pdev)
 
 	if (dpsub->drm)
 		zynqmp_dpsub_drm_cleanup(dpsub);
-	else
-		drm_bridge_remove(dpsub->bridge);
 
+	drm_bridge_remove(dpsub->bridge);
 	zynqmp_disp_remove(dpsub);
 	zynqmp_dp_remove(dpsub);
 
-- 
2.43.0




