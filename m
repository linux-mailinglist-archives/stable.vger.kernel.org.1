Return-Path: <stable+bounces-35587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5DE8950D3
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 12:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1769B1C232DD
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 10:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219ED67A0C;
	Tue,  2 Apr 2024 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvIH1DGl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A40F664C6
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055013; cv=none; b=pmP2jPD6TthCBRcDH1MurLaf60QC67wppGRTHY0UFAvt+sBHpR3CErhl/dHYLWJYfddb5319m2/3TAWD7cy0S7RaL1MqQGj5U7wmPTGbJIqkatJvyWJTiEh1QdDQruxZ1+tKbtEBJv3wpC2fddI3oNNDweuo8W9YNjCopXU1bJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055013; c=relaxed/simple;
	bh=s1NDW3+cRfP0+wLX17eTWGKjCkMauyc5RVspxlnwfXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvjWHTwadCPgx9ZQHmAlKsD5w+1Q7/JG/T/oSei58uf0CrcfmmRaDaidLj7UywbOTTaxo4oIiE12C1F254D+RRgtGbtpHaR11PxNlbEs0RfrmQy1GdauIukZUJaZuq4+rMoS4CAVLCsQwDKKoz2oP0fYq0g89mLm7UfGYajcjtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvIH1DGl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712055012; x=1743591012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s1NDW3+cRfP0+wLX17eTWGKjCkMauyc5RVspxlnwfXg=;
  b=PvIH1DGl645NXRoGsWOXbFN0Tvy5hSwP0wlLcuH2aoBK2qtFEkERTYQX
   kUzcCwmZ+zI6IS/L4Kx6PGwTm1SbCM+umc+N9aQ6NlbCkaDk60vPQwjuR
   5Wu7RCPjdwhWqLqMJoepfbEltrFLoIEcULbR03czELW/aF/7/Au9pGH4b
   ygiLPMXhNU2iBOE8j4mY5F2g438pfMEdYaZmM07Oxh1DUA/0y6xiI8S0y
   PEdKcSLPNiZE3JES7zaix0+4bpaXvh+e5t5FEcUdU75oxUaAwmdVlPQnB
   u7faOyKHgsussTLcmvg98SKIxU0Rgi/4HwaZyl3h3PIAT3zJ3b9uUX+0p
   Q==;
X-CSE-ConnectionGUID: lsBnsOK7Q6e5k0jcstiiUg==
X-CSE-MsgGUID: GN+xEatNSzSoO/Uhm4s/MA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="17944424"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="17944424"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:50:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="18002503"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:50:11 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	quic_jhugo@quicinc.com,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/8] accel/ivpu: Put NPU back to D3hot after failed resume
Date: Tue,  2 Apr 2024 12:49:25 +0200
Message-ID: <20240402104929.941186-5-jacek.lawrynowicz@linux.intel.com>
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

Put NPU in D3hot after ivpu_resume() fails to power up the device.
This will assure that D3->D0 power cycle will be performed before
the next resume and also will minimize power usage in this corner case.

Fixes: 28083ff18d3f ("accel/ivpu: Fix DevTLB errors on suspend/resume and recovery")
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index 325b82f8d971..ba51781b5896 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -97,6 +97,7 @@ static int ivpu_resume(struct ivpu_device *vdev)
 	ivpu_mmu_disable(vdev);
 err_power_down:
 	ivpu_hw_power_down(vdev);
+	pci_set_power_state(to_pci_dev(vdev->drm.dev), PCI_D3hot);
 
 	if (!ivpu_fw_is_cold_boot(vdev)) {
 		ivpu_pm_prepare_cold_boot(vdev);
-- 
2.43.2


