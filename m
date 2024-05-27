Return-Path: <stable+bounces-46301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400FA8D001C
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE5C1C20FFB
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 12:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12C915E5AB;
	Mon, 27 May 2024 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvmuBDwy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE7838FA6;
	Mon, 27 May 2024 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813336; cv=none; b=U2fw67bobuT4/G0xrkh/CGnZc8dJRX2tStT0kz283dLwbiQBJ6woYXvBl0qyQv/l1pcnM37E0DGamLMJDY4MuSTkWrS3Q9Y6DmE3RvqRCX/0/dmWXObk2YA6fnYrnPyIpar6lNma09HbY8KTig9Cd1g9nj1rjFB0S/UTkgAUEQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813336; c=relaxed/simple;
	bh=oDlm0qQbyauU+N/HAOHJE8tfYtnpErh+P14GuxtZC/M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=f+76QZIRrNacRJYo4B1HIwdRa+5Ttr2Lrob8RfIq4zwMsvjmGwCIlUxpb/tcRnqdfwVg5jiCaSONKwZKfk0WKOTvQnmRi8qvh9f0XJH7JFJkjkd017noOEUAPa8d626q+YEm3cK2dMtAEPdtlCEhd8s0nQfm4Y9EL4Dv50yynDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvmuBDwy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716813335; x=1748349335;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oDlm0qQbyauU+N/HAOHJE8tfYtnpErh+P14GuxtZC/M=;
  b=YvmuBDwyhnHWTb8pzF3btU4j6J+ecUyyjaSGpaAyelhCbIheMO44lyvc
   5uVM8VdYP+7ARHcSO6ZSERSggSL1anzVFrDWaE1Gi0HQXegVYuHaWjzAT
   J0atiQbdA+2ZU5+0iPLseVCTsdd9vhGdiGByjnZnEB9gatk5dMX2/A3Ut
   4E5EwY7Cdx81NnaN7j4SAF1jub9hpn3Kwo6jYqzS6sN9H1RR13e9pihs4
   TXI557K74h1m6xUsjRPtxGiByy5zl6IYY5B51vHM5AonItZvL8YkQLb5R
   2nQX9cX1xWa4jXvHMbSfv0Xki35qlBQsMIaeg5s8rBsZTzWfj4YEKkVGB
   Q==;
X-CSE-ConnectionGUID: FxBAM9RDQwaw0SypCKfU1Q==
X-CSE-MsgGUID: TAr/TF+7T4a4lD5BDYmbgg==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="38514607"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="38514607"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 05:35:34 -0700
X-CSE-ConnectionGUID: 3QMiM5bJQWKM+fI13JCZlA==
X-CSE-MsgGUID: z6zUzARgR+iOuF/FOfQzYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="39741828"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.138])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 05:35:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ben Widawsky <bwidawsk@kernel.org>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] cxl/pci: Convert PCIBIOS_* return codes to errnos
Date: Mon, 27 May 2024 15:34:02 +0300
Message-Id: <20240527123403.13098-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_{read,write}_config_*word() and pcie_capability_read_word() return
PCIBIOS_* codes, not usual errnos.

Fix return value checks to handle PCIBIOS_* return codes correctly by
dropping < 0 from the check and convert the PCIBIOS_* return codes into
errnos using pcibios_err_to_errno() before returning them.

Fixes: ce17ad0d5498 ("cxl: Wait Memory_Info_Valid before access memory related info")
Fixes: 34e37b4c432c ("cxl/port: Enable HDM Capability after validating DVSEC Ranges")
Fixes: 14d788740774 ("cxl/mem: Consolidate CXL DVSEC Range enumeration in the core")
Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/cxl/core/pci.c | 30 +++++++++++++++---------------
 drivers/cxl/pci.c      |  2 +-
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 8567dd11eaac..9ca67d4e0a89 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -121,7 +121,7 @@ static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
 					   d + CXL_DVSEC_RANGE_SIZE_LOW(id),
 					   &temp);
 		if (rc)
-			return rc;
+			return pcibios_err_to_errno(rc);
 
 		valid = FIELD_GET(CXL_DVSEC_MEM_INFO_VALID, temp);
 		if (valid)
@@ -155,7 +155,7 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
 		rc = pci_read_config_dword(
 			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(id), &temp);
 		if (rc)
-			return rc;
+			return pcibios_err_to_errno(rc);
 
 		active = FIELD_GET(CXL_DVSEC_MEM_ACTIVE, temp);
 		if (active)
@@ -188,7 +188,7 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 	rc = pci_read_config_word(pdev,
 				  d + CXL_DVSEC_CAP_OFFSET, &cap);
 	if (rc)
-		return rc;
+		return pcibios_err_to_errno(rc);
 
 	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
 	for (i = 0; i < hdm_count; i++) {
@@ -225,7 +225,7 @@ static int wait_for_valid(struct pci_dev *pdev, int d)
 	 */
 	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
 	if (rc)
-		return rc;
+		return pcibios_err_to_errno(rc);
 
 	if (val & CXL_DVSEC_MEM_INFO_VALID)
 		return 0;
@@ -234,7 +234,7 @@ static int wait_for_valid(struct pci_dev *pdev, int d)
 
 	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
 	if (rc)
-		return rc;
+		return pcibios_err_to_errno(rc);
 
 	if (val & CXL_DVSEC_MEM_INFO_VALID)
 		return 0;
@@ -250,8 +250,8 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 	int rc;
 
 	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
-	if (rc < 0)
-		return rc;
+	if (rc)
+		return pcibios_err_to_errno(rc);
 
 	if ((ctrl & CXL_DVSEC_MEM_ENABLE) == val)
 		return 1;
@@ -259,8 +259,8 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 	ctrl |= val;
 
 	rc = pci_write_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, ctrl);
-	if (rc < 0)
-		return rc;
+	if (rc)
+		return pcibios_err_to_errno(rc);
 
 	return 0;
 }
@@ -336,11 +336,11 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 
 	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CAP_OFFSET, &cap);
 	if (rc)
-		return rc;
+		return pcibios_err_to_errno(rc);
 
 	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
 	if (rc)
-		return rc;
+		return pcibios_err_to_errno(rc);
 
 	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
 		dev_dbg(dev, "Not MEM Capable\n");
@@ -379,14 +379,14 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 		rc = pci_read_config_dword(
 			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
 		if (rc)
-			return rc;
+			return pcibios_err_to_errno(rc);
 
 		size = (u64)temp << 32;
 
 		rc = pci_read_config_dword(
 			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(i), &temp);
 		if (rc)
-			return rc;
+			return pcibios_err_to_errno(rc);
 
 		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
 		if (!size) {
@@ -400,14 +400,14 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 		rc = pci_read_config_dword(
 			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
 		if (rc)
-			return rc;
+			return pcibios_err_to_errno(rc);
 
 		base = (u64)temp << 32;
 
 		rc = pci_read_config_dword(
 			pdev, d + CXL_DVSEC_RANGE_BASE_LOW(i), &temp);
 		if (rc)
-			return rc;
+			return pcibios_err_to_errno(rc);
 
 		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index e53646e9f2fb..0ec9cbc64896 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -540,7 +540,7 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 
 	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
 	if (rc)
-		return rc;
+		return pcibios_err_to_errno(rc);
 
 	if (cap & PCI_EXP_DEVCTL_URRE) {
 		addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
-- 
2.39.2


