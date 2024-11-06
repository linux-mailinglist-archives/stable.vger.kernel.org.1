Return-Path: <stable+bounces-90106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCEF9BE4EF
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 11:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE8A2821DD
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 10:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B7E1DE4D4;
	Wed,  6 Nov 2024 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ab0F7Azu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FCB193094
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890555; cv=none; b=f4SXmRP0fBCT1/FjD1o0Y2eiFgGZ+CLgq45DV+hcrSeNfIlxVgNBIDthdWQt0OpipKXJp1rbEnQrQV7SaDeKPLc/r70zvYqH6QucRvZ22cwD/eu0WsbQkWxOvK/4hJsknP1/5iSZBbVawHcMWCBOHJ4hunxGRug/iF3ihOZsd1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890555; c=relaxed/simple;
	bh=6q7sgTYxQRgA9QPt05CvYZG30tLcNj75A+bn169rni8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLbyuGcYVkP1peIACR/PlhG674wCTcSV6TK9L2FYyKAY2KlgKRYv9uT8Cb/ml4UkvhFYyg/4q3IKkurVTygHn38AJg/Y2PPo9e42qGRGVR6UiBA8JZ0TkmhsVZrKLQoM0AKBDGxIBUR1mV3W9ZI1vuJaUEOfQXiKVMDf69WCFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ab0F7Azu; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730890554; x=1762426554;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6q7sgTYxQRgA9QPt05CvYZG30tLcNj75A+bn169rni8=;
  b=ab0F7Azu7bZK9bU4zEpXgsnNrSvERVpFVfks+ixykQuDyNaY2kmLhTpc
   mjzZlvEniZwTYszvs1RY8RRO1x6zAwcwv/hDWJHqkIrbHVWHA0oDw7CC2
   Mi8qTjN6if6W34M3tUBNXQ6u/zTNXGhMocU7NIW42tX80poYuEZQJ3c2f
   SO4pHOTcNbx7aYJOSnYtDXn4uEaU08X7N2cBxHlBQO9htOw02IUI9o8CB
   rP9EN6d4W/ZrWb8mQbvC/xfint2cl9ttEhSgo+dJ7qb/yAFZ+VDPUw3pQ
   BbpYD83TKBDza5gETRaDP4V0Oabnh/B8ixXrngFvNbyJrCOzBLT3dwItK
   g==;
X-CSE-ConnectionGUID: +Ft+BkW7QZO2y3FRGEcdYA==
X-CSE-MsgGUID: z1X57WAySOiDJmh3hf7dzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="42081292"
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="42081292"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 02:55:53 -0800
X-CSE-ConnectionGUID: 5mr3BCv5TMqdlFbsYAnVMw==
X-CSE-MsgGUID: PUt/0mEWSVSJNR/zWkcVuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="84114826"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 02:55:51 -0800
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	quic_jhugo@quicinc.com,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	stable@vger.kernel.org,
	Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH] accel/ivpu: Fix Qemu crash when running in passthrough
Date: Wed,  6 Nov 2024 11:55:49 +0100
Message-ID: <20241106105549.2757115-1-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restore PCI state after putting the NPU in D0.
Restoring state before powering up the device caused a Qemu crash
if NPU was running in passthrough mode and recovery was performed.

Fixes: 3534eacbf101 ("accel/ivpu: Fix PCI D0 state entry in resume")
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index 59d3170f5e354..5aac3d64045d3 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -73,8 +73,8 @@ static int ivpu_resume(struct ivpu_device *vdev)
 	int ret;
 
 retry:
-	pci_restore_state(to_pci_dev(vdev->drm.dev));
 	pci_set_power_state(to_pci_dev(vdev->drm.dev), PCI_D0);
+	pci_restore_state(to_pci_dev(vdev->drm.dev));
 
 	ret = ivpu_hw_power_up(vdev);
 	if (ret) {
-- 
2.45.1


