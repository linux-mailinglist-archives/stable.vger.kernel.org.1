Return-Path: <stable+bounces-35585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5448950CE
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 12:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4031C22405
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 10:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0697162147;
	Tue,  2 Apr 2024 10:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBxwDqPg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DF160B96
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055009; cv=none; b=opsaxWw/T3wZX6CmVoyU7n9JKNskTf4q7cyz3N7MIXOyI9dCL15PLPPnIe93+kaPSt8oVhF497mXi5+5hFfxD5u0t9pVqOsanre3328MD2pVB40MQf3wdEdy51b+aG0IEDEh2N+i/CIaat401/3lus52YbCkNbwGh6wleBLR9ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055009; c=relaxed/simple;
	bh=bn1O6jpz8P3aPcwD7qpRxdk76si1wGA4aXAasuYV0pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChL3cYYyUaiS3L2bxCWYrJWoA8aBcoPwBUdr8lnLk4OUaAMvG2gLprn5G/k6DWrLQcMQdaGiARkrjdGBppijW6HZKdUz4+Cmqfm0J5y/NVjjJ1YxSEtNDOjnDRfoX6UfatthsmPqqQY4G6JoeCyIrO01uF4G1hGmAnsk5Eh4Kcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oBxwDqPg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712055008; x=1743591008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bn1O6jpz8P3aPcwD7qpRxdk76si1wGA4aXAasuYV0pU=;
  b=oBxwDqPgDIod2roqjKQq6rO+a09ZimLMi+1MI69QfcguCKz61ptbyH9W
   4rwgs2QO/PUES3AhPJEmZQD6DDWgYNI3laf1Ah+e0DRCPOTtDHHHXepDy
   Jr/1xyFQYlr2QuBd30HSSOTLrqNeYS74yaK3Fcv/TGkftzAA+GmV8y8Pn
   jZlhT1zwkSlbOlHm1QCOwFm5TFuCOl81p1M/qxaxBGH5i08o7OYm6czYH
   OAmVgWIPPCcUxZBIPtc6bYz18gmH1egNvuxbnvVmWBuqXr7RBdwGRelW9
   o/+YQqzO4smED8j1AvNdTGkMBmOi2WRYWhFEqTcrYTBT4p4+86c6dQQsA
   g==;
X-CSE-ConnectionGUID: ymH5vtJ9TfKZwXf/LVRong==
X-CSE-MsgGUID: CKu9/r9bSH2FfGg7kTHPKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="17944407"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="17944407"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:50:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="18002492"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:50:06 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	quic_jhugo@quicinc.com,
	"Wachowski, Karol" <karol.wachowski@intel.com>,
	stable@vger.kernel.org,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH 1/8] accel/ivpu: Check return code of ipc->lock init
Date: Tue,  2 Apr 2024 12:49:22 +0200
Message-ID: <20240402104929.941186-2-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240402104929.941186-1-jacek.lawrynowicz@linux.intel.com>
References: <20240402104929.941186-1-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Wachowski, Karol" <karol.wachowski@intel.com>

Return value of drmm_mutex_init(ipc->lock) was unchecked.

Fixes: 5d7422cfb498 ("accel/ivpu: Add IPC driver and JSM messages")
Cc: <stable@vger.kernel.org> # v6.3+
Signed-off-by: Wachowski, Karol <karol.wachowski@intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_ipc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index 04ac4b9840fb..56ff067f63e2 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2020-2023 Intel Corporation
+ * Copyright (C) 2020-2024 Intel Corporation
  */
 
 #include <linux/genalloc.h>
@@ -501,7 +501,11 @@ int ivpu_ipc_init(struct ivpu_device *vdev)
 	spin_lock_init(&ipc->cons_lock);
 	INIT_LIST_HEAD(&ipc->cons_list);
 	INIT_LIST_HEAD(&ipc->cb_msg_list);
-	drmm_mutex_init(&vdev->drm, &ipc->lock);
+	ret = drmm_mutex_init(&vdev->drm, &ipc->lock);
+	if (ret) {
+		ivpu_err(vdev, "Failed to initialize ipc->lock, ret %d\n", ret);
+		goto err_free_rx;
+	}
 	ivpu_ipc_reset(vdev);
 	return 0;
 
-- 
2.43.2


