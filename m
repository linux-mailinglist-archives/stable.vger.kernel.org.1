Return-Path: <stable+bounces-127316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B9CA77955
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 13:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CA1188EAE3
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 11:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9471F152F;
	Tue,  1 Apr 2025 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iwpsfu0m"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3681EF361
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743505693; cv=none; b=OVJPk7BQ9A1UapOV0co0Rt0XKK0YMjioA6sr3KNUy/HTeJL+o5owdimRiWNhmrlI7hn7wG8g32RtnQkDOC/Inj4iZP72HG0vkg/qVPaJt0sw+jlMvo5dvnlhTHHiAYsvF+T83JrtwjvHTKF/bBgRrFTVwAYDi6DwSF9S1dmMtoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743505693; c=relaxed/simple;
	bh=c2kkyDGmcy0tJfiAWkCKNxeyCjaVZX2wrgt6fLQSKdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jTZa7rzIO4qnfZWq+ukU3MnxdvM0EZzdrYpUPnPoSK8uxyo/ddprI0qEnRgR7dLOtvGrUdUKBvt/o22WBjL6+9c0mRJfFldrjbC8TYm3wS674aGvdu1GGGmg/ZAX+2bfdywoOs5PRxpoZWs/9UAp9Z+UCQlPYqpg8qdD4lqDeAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iwpsfu0m; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743505692; x=1775041692;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c2kkyDGmcy0tJfiAWkCKNxeyCjaVZX2wrgt6fLQSKdU=;
  b=Iwpsfu0m31eq4qdIr5b1G2760NR4mkru+DPWw0YtWzd3RYMwjQjHywPn
   pqry14ru0X0F9thGYx6yr9mi21vTnV9jIEDbupf/AgxVynHMweULlLjI+
   QTLw4rYKuCxnh3KxQ4akGOSV0kznb+O+ISRFnOy0mzGse1pbxRNbfPDJC
   Wk252/DKLr4dZ0c3IAoTKbrI5p8pVpKIjgkiWjvw0PNnTeDuMxMs2vn/0
   bXEjlNGD9WtnwTZN7JNwgc2tDacD1kR3XiztLUfGe4PXw0EScoZB3/aHb
   DmGxFkgXUs2j5GWZ57xWntlPWRzqdPQTqTAleqqjp1DbsiBOWRs72LXkA
   Q==;
X-CSE-ConnectionGUID: 8HvHuRAxQ1q4wcf1KcogBg==
X-CSE-MsgGUID: d/o6FcgIRA6QMyEGgHnaNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44949514"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="44949514"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 04:08:11 -0700
X-CSE-ConnectionGUID: BNGP+o/0TlyK2YDsElcaDg==
X-CSE-MsgGUID: mcmaoTbxQlq6VWzDvRV/DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="126114486"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 04:08:10 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: stable@vger.kernel.org
Cc: Karol Wachowski <karol.wachowski@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH] accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
Date: Tue,  1 Apr 2025 13:08:07 +0200
Message-ID: <20250401110807.415197-1-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Wachowski <karol.wachowski@intel.com>

commit dad945c27a42dfadddff1049cf5ae417209a8996 upstream.

Trigger recovery of the NPU upon receiving HW context violation from
the firmware. The context violation error is a fatal error that prevents
any subsequent jobs from being executed. Without this fix it is
necessary to reload the driver to restore the NPU operational state.

This is simplified version of upstream commit as the full implementation
would require all engine reset/resume logic to be backported.

Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250107173238.381120-13-maciej.falkowski@linux.intel.com
Fixes: 0adff3b0ef12 ("accel/ivpu: Share NPU busy time in sysfs")
Cc: <stable@vger.kernel.org> # v6.11+
---
 drivers/accel/ivpu/ivpu_job.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index be2e2bf0f43f0..70b3676974407 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -482,6 +482,8 @@ static struct ivpu_job *ivpu_job_remove_from_submitted_jobs(struct ivpu_device *
 	return job;
 }
 
+#define VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW 0xEU
+
 static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32 job_status)
 {
 	struct ivpu_job *job;
@@ -490,6 +492,9 @@ static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32
 	if (!job)
 		return -ENOENT;
 
+	if (job_status == VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW)
+		ivpu_pm_trigger_recovery(vdev, "HW context violation");
+
 	if (job->file_priv->has_mmu_faults)
 		job_status = DRM_IVPU_JOB_STATUS_ABORTED;
 
-- 
2.45.1


