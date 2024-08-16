Return-Path: <stable+bounces-69338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00619954EF6
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 18:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3791C21C3B
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 16:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323001BCA1C;
	Fri, 16 Aug 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPIAcTeI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C16F2F0;
	Fri, 16 Aug 2024 16:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826197; cv=none; b=kxkKXjPXnrBv5Ad8RwbxzZ9MU3rVFkYzsPnOXDid3ndtzwnG+vqUUUtQvZs7SJLY+nFsfU+8zmwrMnksLVoxPp0UgSo+Zx2T8z/wJmgrarr6XkqCoUf9wKK+LxsYd0CDdHZm//ddGJS/cGT7hISy/xmkTjF7nO7E4+njogq6eXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826197; c=relaxed/simple;
	bh=jpTpSSV9F/SL9g+TdUoyDgRSkH9SqJBsGcdxZf9uEPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XuiV/2o6yrVRHPk+6zUqSx6pMKI83TyEZgzZAWdgpLw2qLDSS1cXSy5nKsZYFzsJST0xBlSj7pgQc7rWvcPWFICg+LsbLIEco2cu6jXXnBscTefJ7QrVzoLoW6P9W5/jPHsK3QwQCsorjwKyzY4s2/YjE4jv9B38kwpQfHaS7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPIAcTeI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723826196; x=1755362196;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jpTpSSV9F/SL9g+TdUoyDgRSkH9SqJBsGcdxZf9uEPo=;
  b=TPIAcTeII0mqNRIrI6CwSQXXJN5rhZS2U18BGTi7UVISy+qr3x2TJA/C
   3tah+jyPFPTMk6sWs9JzQNXP77ZHGs7MfMwTvhiyPzZwGfKN0OMa6iSwM
   zCJoFS1uOJ9FrQ9D03XLiItMF7QRU4ySmqkcDoP4Z/uv+5XbRo3kMyoSw
   dZ4TX/pQN5gX7s0YUpDznZnshmlDuKE8rdJQtwSTcYkPwalhN4IHqaNSv
   c7Bb2IJPOSLUtbi9cAkLiwT82iLtb7Rimy0CLlHK35ydxZkw6kb5H7dyj
   D5KdIz38WadqYJ2ceqolUTvKvJ8dMJHQudehz85pQBAWCjclwoqK62rfG
   A==;
X-CSE-ConnectionGUID: Qx8OEcuZQgyJPPWNDLfSFQ==
X-CSE-MsgGUID: 9V4h0vp9T+6fS5H1HQp3Zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22098401"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="22098401"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 09:36:36 -0700
X-CSE-ConnectionGUID: VbCL0jPUTbqoab3uowuPBA==
X-CSE-MsgGUID: V4RmGtPxTtWGGtamHKi9XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="97229364"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa001.jf.intel.com with ESMTP; 16 Aug 2024 09:36:34 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: ISST: Fix return value on last invalid resource
Date: Fri, 16 Aug 2024 09:36:26 -0700
Message-ID: <20240816163626.415762-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When only the last resource is invalid, tpmi_sst_dev_add() is returing
error even if there are other valid resources before. This function
should return error when there are no valid resources.

Here tpmi_sst_dev_add() is returning "ret" variable. But this "ret"
variable contains the failure status of last call to sst_main(), which
failed for the invalid resource. But there may be other valid resources
before the last entry.

To address this, do not update "ret" variable for sst_main() return
status.

Fixes: 9d1d36268f3d ("platform/x86: ISST: Support partitioned systems")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: <stable@vger.kernel.org> # 6.10+
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 7fa360073f6e..404582307109 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -1549,8 +1549,7 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 			goto unlock_free;
 		}
 
-		ret = sst_main(auxdev, &pd_info[i]);
-		if (ret) {
+		if (sst_main(auxdev, &pd_info[i])) {
 			/*
 			 * This entry is not valid, hardware can partially
 			 * populate dies. In this case MMIO will have 0xFFs.
-- 
2.45.0


