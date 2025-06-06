Return-Path: <stable+bounces-151737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDE5AD092E
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 22:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD25189BC40
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 20:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C604D21773F;
	Fri,  6 Jun 2025 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maNdaJrr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16081DE887;
	Fri,  6 Jun 2025 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749243200; cv=none; b=pUVU8bcGs5Ks93sT3zzRGtAY9MQwO0RHSmlr5hOgLAvUXpatkr33TCTeCnPs1LVtZo1yvSg7533KwhS/xkd4Qjh2qr9vTSxApEcP2ofT0Ss9FPvLbadRmbUBKHYw1pMtgVPJgheKbsikoKx1Nsfbmn9MhkxvHknCpqXTaMx+GJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749243200; c=relaxed/simple;
	bh=te0rz6iuH+tuOfeWxtRzrEQXLcAUOuPCArfYha2FS8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDpJ//KNrdOwU0zp1E2mDJs/rq+D9PNrbbck2yWB1kVnFBIFIvYeyALmf+0lp5Rcjmpqa0iIas0fFvnztdHytSvIXcealdgJoqKAwyQniPOhwGPK9u24x6cX5BtDXYDqwv8Ktz29ZdBsoR405B2hw+eAAYkybWa03CG6IkB5A3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maNdaJrr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749243198; x=1780779198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=te0rz6iuH+tuOfeWxtRzrEQXLcAUOuPCArfYha2FS8Q=;
  b=maNdaJrrFJmbF7qBzXgb7krjpgnt1c/6Jx6IvNg7lGUZXfd+v/On1p2M
   Yk5QafNi1aQOxJAxUw/ZNXUr4dn5sDIFmGUcqxEUJmilpVCZ+cr3d+Wzw
   4wZlTHZ00lSCd7xd69xDiWbQVinX6kI2DV8Kp/tmhx5Wa0MlIp4A/PeNn
   lavAoIdOqpRJC3BGO+qjb18SkwVVyu+V3iEa44C+1DCejBNVihDfnKq+P
   nMOOPZm55gVh/rw9yWfPT1QAkvnUqJWr7jqrnAJ+PRU4UYrD3XyY57bm4
   j0K8lJ+oYzalIz9AIejRbgq6QS1cIaD6IxIaC5Wh4V2hgPBc2ZlayVWX8
   g==;
X-CSE-ConnectionGUID: G9mqQ4hOTBicBocx8FxEBg==
X-CSE-MsgGUID: PnlqbgcFSpmTUfeiEfk+MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="73931460"
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="73931460"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 13:53:17 -0700
X-CSE-ConnectionGUID: ZUzEG+hISHSsKQ+aQroEfA==
X-CSE-MsgGUID: sQ9MDDtzTx2DxZmGMHll6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="176806018"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by fmviesa001.fm.intel.com with ESMTP; 06 Jun 2025 13:53:16 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86/intel-uncore-freq: Fail module load when plat_info is NULL
Date: Fri,  6 Jun 2025 13:53:00 -0700
Message-ID: <20250606205300.2384494-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address a Smatch static checker warning regarding an unchecked
dereference in the function call:
set_cdie_id(i, cluster_info, plat_info)
when plat_info is NULL.

Instead of addressing this one case, in general if plat_info is NULL
then it can cause other issues. For example in a two package system it
will give warning for duplicate sysfs entry as package ID will be always
zero for both packages when creating string for attribute group name.

plat_info is derived from TPMI ID TPMI_BUS_INFO, which is integral to
the core TPMI design. Therefore, it should not be NULL on a production
platform. Consequently, the module should fail to load if plat_info is
NULL.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/platform-driver-x86/aEKvGCLd1qmX04Tc@stanley.mountain/T/#u
Fixes: 8a54e2253e4c ("platform/x86/intel-uncore-freq: Uncore frequency control via TPMI")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org
---
 .../x86/intel/uncore-frequency/uncore-frequency-tpmi.c   | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index 1c7b2f2716ca..44d9948ed224 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -511,10 +511,13 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 
 	/* Get the package ID from the TPMI core */
 	plat_info = tpmi_get_platform_data(auxdev);
-	if (plat_info)
-		pkg = plat_info->package_id;
-	else
+	if (unlikely(!plat_info)) {
 		dev_info(&auxdev->dev, "Platform information is NULL\n");
+		ret = -ENODEV;
+		goto err_rem_common;
+	}
+
+	pkg = plat_info->package_id;
 
 	for (i = 0; i < num_resources; ++i) {
 		struct tpmi_uncore_power_domain_info *pd_info;
-- 
2.49.0


