Return-Path: <stable+bounces-204121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EACCE7D4B
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 19:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD6233064352
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 18:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8353321D0;
	Mon, 29 Dec 2025 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aM2Isasi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301B4331A74;
	Mon, 29 Dec 2025 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033300; cv=none; b=naqwXRb+1QwslfKBd9AXJs9S+q6f+bWjMDUwXF7JsfVLUVJhdTtp/KLSCKxk7E6WUCNLPeEHzbJ9bAV50NYuDd5G9ygEHgBvaPERRMrGuu7VIGKnk8iAJSHQKleCZKwpmpTuwNJ3JAwu/+mNlqHzaziX30sC8M9g5m0mfi9rj5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033300; c=relaxed/simple;
	bh=KdnaDNFI4QJEZ65VGNCdjV9bBZxSrYzy7mLwWKm23ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FE6EOvSGJoiFzVsmyivfANpmYL36HiLS/i5WmLWBUFW+w1An9wbLSwA7Q2Sibr3E7GNy7NRKQ/mU64xieAKOWhL6TCF4rKhhzoMFdOpmQyRZpeIIowm5iyDTjC4uXQ3iyCbi/r1jnMRkRZ/uybGfgNSgt+Hq6dgNauwq8hHJ6UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aM2Isasi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767033299; x=1798569299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KdnaDNFI4QJEZ65VGNCdjV9bBZxSrYzy7mLwWKm23ek=;
  b=aM2IsasihkSy/OS6Nwm15OIxfgYn9YMgqBUy89C70KCXKqeKP+cshKr/
   LaUo/objwOGFQ6FC69q1KUY7YWAvUTczFom15x7hJVbbMwJsrcNjEEcJt
   Rz1uEihrt2tGQaaK3K2R+2RHVnNwS89iP/PnbkLUgutsspZxiXpyt+mZS
   yMZJCYkIFknZQ/ktoH5Sh7Hwr9PswOIqWACtw1g1VTrajGW3NOE7dmLxa
   wNtiFSC0GMLX0U7030X9/WdhGdOEgpIg4CRNaHMoyQ4pfYjy3plYpw2iJ
   rq22QLbCa0lUqErnHS2u4rJS+anPpJbgqSUnBH/10Lu7ov2WsScdpRPl6
   A==;
X-CSE-ConnectionGUID: YELcfPmgRDaR3CNc7pfzuA==
X-CSE-MsgGUID: fEXs5hTARPaOMKG+7o6nQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="86218722"
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="86218722"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 10:34:56 -0800
X-CSE-ConnectionGUID: F3cgYYeqQmmT5Z1JnRHUyg==
X-CSE-MsgGUID: OBsXxWmqRi2bkh0SoW2fUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="205120429"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa003.jf.intel.com with ESMTP; 29 Dec 2025 10:34:56 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: ISST: Store and restore all domains data
Date: Mon, 29 Dec 2025 10:34:50 -0800
Message-ID: <20251229183450.823244-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229183450.823244-1-srinivas.pandruvada@linux.intel.com>
References: <20251229183450.823244-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The suspend/resume callbacks currently only store and restore the
configuration for power domain 0. However, other power domains may also
have modified configurations that need to be preserved across suspend/
resume cycles.

Extend the store/restore functionality to handle all power domains.

Fixes: 91576acab020 ("platform/x86: ISST: Add suspend/resume callbacks")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: stable@vger.kernel.org
---
 .../intel/speed_select_if/isst_tpmi_core.c    | 53 ++++++++++++-------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index f587709ddd47..47026bb3e1af 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -1723,55 +1723,68 @@ EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_remove, "INTEL_TPMI_SST");
 void tpmi_sst_dev_suspend(struct auxiliary_device *auxdev)
 {
 	struct tpmi_sst_struct *tpmi_sst = auxiliary_get_drvdata(auxdev);
-	struct tpmi_per_power_domain_info *power_domain_info;
+	struct tpmi_per_power_domain_info *power_domain_info, *pd_info;
 	struct oobmsm_plat_info *plat_info;
 	void __iomem *cp_base;
+	int num_resources, i;
 
 	plat_info = tpmi_get_platform_data(auxdev);
 	if (!plat_info)
 		return;
 
 	power_domain_info = tpmi_sst->power_domain_info[plat_info->partition];
+	num_resources = tpmi_sst->number_of_power_domains[plat_info->partition];
 
-	cp_base = power_domain_info->sst_base + power_domain_info->sst_header.cp_offset;
-	power_domain_info->saved_sst_cp_control = readq(cp_base + SST_CP_CONTROL_OFFSET);
+	for (i = 0; i < num_resources; i++) {
+		pd_info = &power_domain_info[i];
+		if (!pd_info || !pd_info->sst_base)
+			continue;
 
-	memcpy_fromio(power_domain_info->saved_clos_configs, cp_base + SST_CLOS_CONFIG_0_OFFSET,
-		      sizeof(power_domain_info->saved_clos_configs));
+		cp_base = pd_info->sst_base + pd_info->sst_header.cp_offset;
 
-	memcpy_fromio(power_domain_info->saved_clos_assocs, cp_base + SST_CLOS_ASSOC_0_OFFSET,
-		      sizeof(power_domain_info->saved_clos_assocs));
+		pd_info->saved_sst_cp_control = readq(cp_base + SST_CP_CONTROL_OFFSET);
+		memcpy_fromio(pd_info->saved_clos_configs, cp_base + SST_CLOS_CONFIG_0_OFFSET,
+			      sizeof(pd_info->saved_clos_configs));
+		memcpy_fromio(pd_info->saved_clos_assocs, cp_base + SST_CLOS_ASSOC_0_OFFSET,
+			      sizeof(pd_info->saved_clos_assocs));
 
-	power_domain_info->saved_pp_control = readq(power_domain_info->sst_base +
-						    power_domain_info->sst_header.pp_offset +
-						    SST_PP_CONTROL_OFFSET);
+		pd_info->saved_pp_control = readq(pd_info->sst_base +
+						  pd_info->sst_header.pp_offset +
+						  SST_PP_CONTROL_OFFSET);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_suspend, "INTEL_TPMI_SST");
 
 void tpmi_sst_dev_resume(struct auxiliary_device *auxdev)
 {
 	struct tpmi_sst_struct *tpmi_sst = auxiliary_get_drvdata(auxdev);
-	struct tpmi_per_power_domain_info *power_domain_info;
+	struct tpmi_per_power_domain_info *power_domain_info, *pd_info;
 	struct oobmsm_plat_info *plat_info;
 	void __iomem *cp_base;
+	int num_resources, i;
 
 	plat_info = tpmi_get_platform_data(auxdev);
 	if (!plat_info)
 		return;
 
 	power_domain_info = tpmi_sst->power_domain_info[plat_info->partition];
+	num_resources = tpmi_sst->number_of_power_domains[plat_info->partition];
 
-	cp_base = power_domain_info->sst_base + power_domain_info->sst_header.cp_offset;
-	writeq(power_domain_info->saved_sst_cp_control, cp_base + SST_CP_CONTROL_OFFSET);
-
-	memcpy_toio(cp_base + SST_CLOS_CONFIG_0_OFFSET, power_domain_info->saved_clos_configs,
-		    sizeof(power_domain_info->saved_clos_configs));
+	for (i = 0; i < num_resources; i++) {
+		pd_info = &power_domain_info[i];
+		if (!pd_info || !pd_info->sst_base)
+			continue;
 
-	memcpy_toio(cp_base + SST_CLOS_ASSOC_0_OFFSET, power_domain_info->saved_clos_assocs,
-		    sizeof(power_domain_info->saved_clos_assocs));
+		cp_base = pd_info->sst_base + pd_info->sst_header.cp_offset;
+		writeq(pd_info->saved_sst_cp_control, cp_base + SST_CP_CONTROL_OFFSET);
+		memcpy_toio(cp_base + SST_CLOS_CONFIG_0_OFFSET, pd_info->saved_clos_configs,
+			    sizeof(pd_info->saved_clos_configs));
+		memcpy_toio(cp_base + SST_CLOS_ASSOC_0_OFFSET, pd_info->saved_clos_assocs,
+			    sizeof(pd_info->saved_clos_assocs));
 
-	writeq(power_domain_info->saved_pp_control, power_domain_info->sst_base +
-				power_domain_info->sst_header.pp_offset + SST_PP_CONTROL_OFFSET);
+		writeq(pd_info->saved_pp_control, power_domain_info->sst_base +
+		       pd_info->sst_header.pp_offset + SST_PP_CONTROL_OFFSET);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_resume, "INTEL_TPMI_SST");
 
-- 
2.52.0


