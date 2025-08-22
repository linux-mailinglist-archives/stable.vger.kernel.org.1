Return-Path: <stable+bounces-172314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E490FB30F64
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 08:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C67B6310F
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 06:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEA32C326B;
	Fri, 22 Aug 2025 06:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kr1pAfGw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815F421CC43
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 06:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845108; cv=none; b=UzNY8gMPsRJ8ffOzPfnh2YdQpu5h+O5TashVt0ILMg1FQpOdrK6OhbjctX4K2uAj1tg4fkl9/GRShO/NH3UzC/NOUcruVnk2exmmlObNN7mm98T4pGz9HExMfuKHr/Fq/N2Sv06GOwb52ZMTzH6HwipeqRK29Q+YsiFtekG+Z6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845108; c=relaxed/simple;
	bh=4hD0thfxo3DybHzU0DaZQNng4pdEdGgHYrSwx40002Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2fjI97RwBMXkgKiLcO9sjrO7JU9oVQ4DEl58bXYbs8h/XprcW+jPIAQS3ZMgZhcofmMW4egNKfLkIgrrswPLyklePOkSVy4pOLaurnAIGik+Gd3CADmc9I0vaAJLKriQKH/90sN54D09hNM7p4cDYnITK8AvESnBYaLq6H5ZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kr1pAfGw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755845107; x=1787381107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4hD0thfxo3DybHzU0DaZQNng4pdEdGgHYrSwx40002Q=;
  b=kr1pAfGwyZ0eaI5vhKygkXZ+/d/dg7oguO5NJD0+corttRhkzLvFELZq
   1pgjgP4Np6YR6zeA7m10Vfad4cblRecaW23BtNKZyCciRTV7mgGfmIa/Z
   QZZ6v/DcisoIcGZdtTahbM9ggHMuHo3u9RcxHiX4k9qGmwq3tcoK1oJkD
   0vcv0q39jn6Ihb/2iPR6cF2VIRMJY2iG/ynPm/7mxNMKCbdxQwhAXyr/S
   UE5jgfUrtlZy3ucTpxLzCtxT12D7KwL8sHDV1TIv68YiCmrwSdUo5TKco
   BA4MeURuV5xsvKFCi+TriTKjox75lMsTJ3r6e/U0o5b8q038etLyGcCqy
   g==;
X-CSE-ConnectionGUID: K0pDMolOQj6WPvWofxlhcA==
X-CSE-MsgGUID: HtCGUDgqQOe3StG1v8M9Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="80748155"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="80748155"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 23:45:06 -0700
X-CSE-ConnectionGUID: VMd8/td1RnG4JZTKZ4/jHg==
X-CSE-MsgGUID: EkDWEUpbR82IhjSWQkCebg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="173906072"
Received: from inaky-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.245.244.75])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 23:45:04 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Martin K Petersen <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Archana Patni <archana.patni@intel.com>
Subject: [PATCH 5.15.y 2/2] scsi: ufs: ufs-pci: Fix default runtime and system PM levels
Date: Fri, 22 Aug 2025 09:44:27 +0300
Message-ID: <20250822064427.139229-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250822064427.139229-1-adrian.hunter@intel.com>
References: <20250822064427.139229-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

commit 6de7435e6b81fe52c0ab4c7e181f6b5decd18eb1 upstream.

Intel MTL-like host controllers support auto-hibernate.  Using
auto-hibernate with manual (driver initiated) hibernate produces more
complex operation.  For example, the host controller will have to exit
auto-hibernate simply to allow the driver to enter hibernate state
manually.  That is not recommended.

The default rpm_lvl and spm_lvl is 3, which includes manual hibernate.

Change the default values to 2, which does not.

Note, to be simpler to backport to stable kernels, utilize the UFS PCI
driver's ->late_init() call back.  Recent commits have made it possible
to set up a controller-specific default in the regular ->init() call
back, but not all stable kernels have those changes.

Fixes: 4049f7acef3e ("scsi: ufs: ufs-pci: Add support for Intel MTL")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250723165856.145750-3-adrian.hunter@intel.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/scsi/ufs/ufshcd-pci.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd-pci.c b/drivers/scsi/ufs/ufshcd-pci.c
index 11071c132c1d..ec483ece09b6 100644
--- a/drivers/scsi/ufs/ufshcd-pci.c
+++ b/drivers/scsi/ufs/ufshcd-pci.c
@@ -454,10 +454,23 @@ static int ufs_intel_adl_init(struct ufs_hba *hba)
 	return ufs_intel_common_init(hba);
 }
 
+static void ufs_intel_mtl_late_init(struct ufs_hba *hba)
+{
+	hba->rpm_lvl = UFS_PM_LVL_2;
+	hba->spm_lvl = UFS_PM_LVL_2;
+}
+
 static int ufs_intel_mtl_init(struct ufs_hba *hba)
 {
+	struct ufs_host *ufs_host;
+	int err;
+
 	hba->caps |= UFSHCD_CAP_CRYPTO | UFSHCD_CAP_WB_EN;
-	return ufs_intel_common_init(hba);
+	err = ufs_intel_common_init(hba);
+	/* Get variant after it is set in ufs_intel_common_init() */
+	ufs_host = ufshcd_get_variant(hba);
+	ufs_host->late_init = ufs_intel_mtl_late_init;
+	return err;
 }
 
 static struct ufs_hba_variant_ops ufs_intel_cnl_hba_vops = {
-- 
2.48.1


