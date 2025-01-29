Return-Path: <stable+bounces-111125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A86BA21D41
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 13:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C4C57A31C0
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 12:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12424A23;
	Wed, 29 Jan 2025 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ebx6Rr3p"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C04F10E5
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738154417; cv=none; b=ACPuqjOly1FGEC2KO5YzE7qrJzg67zy7XGx9ef+1vT88aEl12to7gHWQCqE5/yXT+KqIBAH31jqp6e7VZUWN8gTscjnaKM1mq/M0VFojNK8p+Zzj8MFTxuN3jm22ovP+5sTvIbOeGbQtTmJlOiTc3BsbVFbMQwqjrfVW8zS5FEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738154417; c=relaxed/simple;
	bh=ORDKKvPDsTtumPUvXJ34As3hCg4Jf6LPzVj4Imt/ICQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pf/1BNLwK0DsIdOVlcYBVUX7Xd/Oy70qvGuLEjflFVlb7KQf98d61EgQKm9RjGrnfklTxBI5TfjpyrT+s2RteifxFcBD5//V+mrJx83G2IzAy6+sdkGRjWZjJpjd8nMkHLRmd2jLPrcasFnFB5fRZrCUA/tilmxGiJK8FJIpXGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ebx6Rr3p; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738154417; x=1769690417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ORDKKvPDsTtumPUvXJ34As3hCg4Jf6LPzVj4Imt/ICQ=;
  b=ebx6Rr3pwmHIBMamY/vQ0w2k2ga64hfhau64dIH5/Kl+JG+wZkpLRWXG
   8XXDjHj86r+rcc2WVkVg8Y9OqEeM3uTW5FRHLmXt2XQuxa31rcFTx6rvH
   zvJweKcOvwW59x1K9Aq13J9kfVyxx3p1IdSmyt9xILzlAXTvMkmAeBFS8
   Zb+V+gYokd0PxAqGUQansrggJqDF+bRfVCaJyYoXLGHixmC+7XkmTxOww
   rkoYU8cL703Me31tb5WnVPlISFLCvQHTNHtaj3M5XHwJDrZonofBVNkeE
   Nx5buzxgggXJx8Lk3zNmVrMHXINuGrgIkWpnrMEgXPEztTyVzSeCdnRX7
   A==;
X-CSE-ConnectionGUID: Z2DJEjJfS4yXuRKJWDjUPQ==
X-CSE-MsgGUID: gml7TBbzRgORnmS9o83dcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="49647266"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="49647266"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 04:40:16 -0800
X-CSE-ConnectionGUID: Zi/2YPCAQVSWEVsi2qhNiw==
X-CSE-MsgGUID: puULkPcaSXO+w6n18m+U7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113030871"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 04:40:13 -0800
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	quic_jhugo@quicinc.com,
	maciej.falkowski@linux.intel.com,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	stable@vger.kernel.org,
	Karol Wachowski <karol.wachowski@intel.com>
Subject: [PATCH 1/3] accel/ivpu: Fix error handling in ivpu_boot()
Date: Wed, 29 Jan 2025 13:40:07 +0100
Message-ID: <20250129124009.1039982-2-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250129124009.1039982-1-jacek.lawrynowicz@linux.intel.com>
References: <20250129124009.1039982-1-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure IRQs and IPC are properly disabled if HW sched or DCT
initialization fails.

Fixes: cc3c72c7e610 ("accel/ivpu: Refactor failure diagnostics during boot")
Cc: <stable@vger.kernel.org> # v6.13+
Reviewed-by: Karol Wachowski <karol.wachowski@intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index ca2bf47ce2484..0c4a82271c26d 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -397,15 +397,19 @@ int ivpu_boot(struct ivpu_device *vdev)
 	if (ivpu_fw_is_cold_boot(vdev)) {
 		ret = ivpu_pm_dct_init(vdev);
 		if (ret)
-			goto err_diagnose_failure;
+			goto err_disable_ipc;
 
 		ret = ivpu_hw_sched_init(vdev);
 		if (ret)
-			goto err_diagnose_failure;
+			goto err_disable_ipc;
 	}
 
 	return 0;
 
+err_disable_ipc:
+	ivpu_ipc_disable(vdev);
+	ivpu_hw_irq_disable(vdev);
+	disable_irq(vdev->irq);
 err_diagnose_failure:
 	ivpu_hw_diagnose_failure(vdev);
 	ivpu_mmu_evtq_dump(vdev);
-- 
2.45.1


