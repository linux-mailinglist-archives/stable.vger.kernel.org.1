Return-Path: <stable+bounces-100425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69AE9EB1AA
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 14:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6024E283587
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 13:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7980D1A9B2F;
	Tue, 10 Dec 2024 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HEc4BZvH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDA278F44
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733836189; cv=none; b=sQsubLnQIAfaAMWbk9gFYyW2ETQ91w2YzRhWYqpSRO/kmD6vGQ/Af6xzNYhfL2e8Pxkyfz1/C6H7a4cnQnInEjMQxHknNxpLAVA3c+0sJGRBDzBuzPkLpA3CXG33zeqMoKKTaHauMwyTXZDSQom7BWCGz5NXNZpgQD2e03vsPdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733836189; c=relaxed/simple;
	bh=gs3pQyhAtuTtqsflnavxroyRBi2uR2QXMjWyUdGPln4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSSIBlTBagPpRP4DaB1IROIVahAtsOypELjnPil64D//HH2SD8LeRQnAjaG9V8k6YmrwVBVeW3KnLdk78gENvuC7w6AjzImjbKlvFKwheRtI+umau4BVohROE2SZJb0+gFUXNZAbr0nWQlzjQS/s9Oy1wqDAy3co6hI+VVqqkRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HEc4BZvH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733836188; x=1765372188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gs3pQyhAtuTtqsflnavxroyRBi2uR2QXMjWyUdGPln4=;
  b=HEc4BZvHwHLcQLQ+7qRUme5banzzMvVCss70Ncx+vUm7c/+Yvw4o2CKq
   20JK7YdvBTbKu4HB2AVSQMc7QSmud21+foJu7x4YZXnW9s9aiD0nLFdic
   BHAf+FiQoHvLiYq6CzVK1OT2gTJZW0GHlxZiCVgPv9IBXuIVUYDcrz+rk
   3aKeB3aVRk1E87EbKPGajRXf36DvG7MZ9LKnhoCSMaT4eeoNjf8Va3R9n
   kxn6FFvNhtCJdqboWs7AihxMLAwljWMTIU4V9BvxY5lxKcPC8MtYdRGSL
   S49mqvTrM3YVXZuP2bhJXzYIzapwDKg/1G7Enkz1fBIS/CYaOmrMH3knW
   w==;
X-CSE-ConnectionGUID: 4igfJv5OS/OX5rbDPsY0EQ==
X-CSE-MsgGUID: V5B7ShReReuuTQpK3BC4yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34080124"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="34080124"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 05:09:48 -0800
X-CSE-ConnectionGUID: 5X3wo6H4SfqBm5AMrmYskw==
X-CSE-MsgGUID: 4NWQVyBYTqiXVgqKb+j15w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="95242050"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 05:09:46 -0800
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	quic_jhugo@quicinc.com,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	stable@vger.kernel.org,
	Karol Wachowski <karol.wachowski@intel.com>
Subject: [PATCH 3/3] accel/ivpu: Fix WARN in ivpu_ipc_send_receive_internal()
Date: Tue, 10 Dec 2024 14:09:39 +0100
Message-ID: <20241210130939.1575610-4-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241210130939.1575610-1-jacek.lawrynowicz@linux.intel.com>
References: <20241210130939.1575610-1-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move pm_runtime_set_active() to ivpu_pm_inti() so when
ivpu_ipc_send_receive_internal() is executed before ivpu_pm_enable()
it already has correct runtime state, even if last resume was
not successful.

Fixes: 8ed520ff4682 ("accel/ivpu: Move set autosuspend delay to HW specific code")
Cc: <stable@vger.kernel.org> # v6.7+
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Karol Wachowski <karol.wachowski@intel.com>
---
 drivers/accel/ivpu/ivpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index dbc0711e28d13..949f4233946c6 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -378,6 +378,7 @@ void ivpu_pm_init(struct ivpu_device *vdev)
 
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, delay);
+	pm_runtime_set_active(dev);
 
 	ivpu_dbg(vdev, PM, "Autosuspend delay = %d\n", delay);
 }
@@ -392,7 +393,6 @@ void ivpu_pm_enable(struct ivpu_device *vdev)
 {
 	struct device *dev = vdev->drm.dev;
 
-	pm_runtime_set_active(dev);
 	pm_runtime_allow(dev);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
-- 
2.45.1


