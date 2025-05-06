Return-Path: <stable+bounces-141771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E65AABF27
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 11:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0863A500067
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 09:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDA7268682;
	Tue,  6 May 2025 09:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8qFU2Rv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E2D24468D
	for <stable@vger.kernel.org>; Tue,  6 May 2025 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523238; cv=none; b=Y1f+s5DchEIrGC/hMBs3oNEb2UX8F9ogRdvQCjMp94z2l7/Kh+low0hT4QqXmS5UQ4P8OVKpvqrskCNh3ZT9VlU9Tjm7ItWAvU/C3xUEHvdeKFikG8GkBP1pJczBEXh88CzlDVLgWtXgXymCl1KNHUOyOPrMCtvHMsIqgnhEsi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523238; c=relaxed/simple;
	bh=QN2bwJgO8y3LLRz8SfXnbJeRv6TrmeqGPsAx9EBkvX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=edGXzuT8jP6KDRLoxfFMR/U2IzpWI8f6T5WCYvHSSuV/xw7ge37JQTSlXGUCyxEyAEH3dPH6fnLNXpH/Bm4yxDFuwiigrh4+gT8ind1w7kYTy3UeaiADKFf7kD1GJN/kOKhHlBWA9xKu/615gvb3LrH/OoiO2wFSnMHz2lcu0mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8qFU2Rv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746523236; x=1778059236;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QN2bwJgO8y3LLRz8SfXnbJeRv6TrmeqGPsAx9EBkvX0=;
  b=B8qFU2RvRKr4FykaQjw0c8qABnEfr+qjQ2eUwSHQqfb+ZD3ilID4wTJe
   HXm0fLTLuCwbXeKZFlErsND0zSx4BKYpJNRRY88OOWP3en+E5VxQEUpxI
   HzJXUcBKeQl02bQLhpq5s9HRsDsOXVCd4RE4N9bAJyKvYjO5bQFvOxjkL
   mpr9EzcRNObiDpicTods+8UIkCJTbiNeX1N3UaODeKCrMRM5LtlVuKzw/
   Sp7BJM1gCnDF8DzGY86JmLWPYyeIaRBtptlD8IvsA7TLxkb85VgK57BBk
   CvKjjOEgmaU5aeuu4VP2rrWCc4j2n3gP97oDQwVsGAfifaT9v5Tp/6ftP
   g==;
X-CSE-ConnectionGUID: 3A4se2w5Sa2OWyebChucSA==
X-CSE-MsgGUID: 6nBHowC/Q8SSyHo0M7FiPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="51997733"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="51997733"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 02:20:35 -0700
X-CSE-ConnectionGUID: OKVqnbqNTJ2Fxe8DCRRobw==
X-CSE-MsgGUID: 2yYWmonuT1C/4tRPAe/CGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="135444988"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 02:20:34 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: jeff.hugo@oss.qualcomm.com,
	lizhi.hou@amd.com,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] accel/ivpu: Use firmware names from upstream repo
Date: Tue,  6 May 2025 11:20:30 +0200
Message-ID: <20250506092030.280276-1-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use FW names from linux-firmware repo instead of deprecated ones.

Fixes: c140244f0cfb ("accel/ivpu: Add initial Panther Lake support")
Cc: <stable@vger.kernel.org> # v6.13+
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_fw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index ccaaf6c100c02..9db741695401e 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -55,18 +55,18 @@ static struct {
 	int gen;
 	const char *name;
 } fw_names[] = {
-	{ IVPU_HW_IP_37XX, "vpu_37xx.bin" },
+	{ IVPU_HW_IP_37XX, "intel/vpu/vpu_37xx_v1.bin" },
 	{ IVPU_HW_IP_37XX, "intel/vpu/vpu_37xx_v0.0.bin" },
-	{ IVPU_HW_IP_40XX, "vpu_40xx.bin" },
+	{ IVPU_HW_IP_40XX, "intel/vpu/vpu_40xx_v1.bin" },
 	{ IVPU_HW_IP_40XX, "intel/vpu/vpu_40xx_v0.0.bin" },
-	{ IVPU_HW_IP_50XX, "vpu_50xx.bin" },
+	{ IVPU_HW_IP_50XX, "intel/vpu/vpu_50xx_v1.bin" },
 	{ IVPU_HW_IP_50XX, "intel/vpu/vpu_50xx_v0.0.bin" },
 };
 
 /* Production fw_names from the table above */
-MODULE_FIRMWARE("intel/vpu/vpu_37xx_v0.0.bin");
-MODULE_FIRMWARE("intel/vpu/vpu_40xx_v0.0.bin");
-MODULE_FIRMWARE("intel/vpu/vpu_50xx_v0.0.bin");
+MODULE_FIRMWARE("intel/vpu/vpu_37xx_v1.bin");
+MODULE_FIRMWARE("intel/vpu/vpu_40xx_v1.bin");
+MODULE_FIRMWARE("intel/vpu/vpu_50xx_v1.bin");
 
 static int ivpu_fw_request(struct ivpu_device *vdev)
 {
-- 
2.45.1


