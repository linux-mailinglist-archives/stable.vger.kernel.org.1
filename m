Return-Path: <stable+bounces-128886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A4AA7FAED
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D29117FEE4
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A9C266EEC;
	Tue,  8 Apr 2025 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFSvUJFD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD076265CBD;
	Tue,  8 Apr 2025 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106240; cv=none; b=udPIUKMRTXOZkHVXq/8OAZRqbzO7oZhw2AOKZfA+JlbIZ2IC7n8MVo/1Y5hCE3pywVWrYgZlIWsdvhDp7Z+IHe3bcdBrIONTjsAQ3yVnnqMc7YDm6yW4hyB9UAEnLHZDcHYO6X8xThz0g1Ah+FdRiQMcgp1WOsJk9xgwFqOHwWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106240; c=relaxed/simple;
	bh=c2kkyDGmcy0tJfiAWkCKNxeyCjaVZX2wrgt6fLQSKdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rfQ0KnQFmZO/c1UUGDdrYInPyJerp5o7oTYOn8lrAK3k05ShzUGALflXdyo1BilPcqv6WgqdwX8YkAhGzDYdFGQgz6RLQwExFvVOwjLK3mZmn7xYwrz+aizTG5Rx4d7YFjuDkWfrnN5Khn2Dp34/fjv6exrAqJMFotVd7Ocd9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VFSvUJFD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744106239; x=1775642239;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c2kkyDGmcy0tJfiAWkCKNxeyCjaVZX2wrgt6fLQSKdU=;
  b=VFSvUJFDaUY6jugkRzu1LZIpMfydR92S5i3RX66hUCy2GRHzQv7wn/6r
   2E1xm95xuRxYQfnt8Dz6CLSgSx1SXpTBVwGrzi1nrlCwOEn/oxyOzbjpV
   t6VorHe0BdMUJKD8iKCfVHbPasqlcVdPSRHWoZEGruBmlSYzrZDtbNKNC
   QmBLl91EZ3mVnQHwn7ewzxyfHA2JLLGNFm+gzRv4OmFFPWgvR+eXPxrwK
   NXjCrNx+8n3BrUZyU4Kl85PCSxJYFVd1Bo/fmpPhltUlI3dEjwg7s+fvm
   u0d2DWSevmFld+0rC3WBRazWqFA5Z43V55ymEknIHJ2psbvt8XOaImYI3
   g==;
X-CSE-ConnectionGUID: DOFPd1soTFmH7t7bNARwFA==
X-CSE-MsgGUID: rYcnWhAcSlqDjaz9zSycnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="68002526"
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="68002526"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 02:57:16 -0700
X-CSE-ConnectionGUID: vj85qJ6DTKeB49jeRpfXEg==
X-CSE-MsgGUID: GAfGe7p+Tc+MpogH3haAzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="133424452"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 02:57:13 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Karol Wachowski <karol.wachowski@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH] accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
Date: Tue,  8 Apr 2025 11:57:11 +0200
Message-ID: <20250408095711.635185-1-jacek.lawrynowicz@linux.intel.com>
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


