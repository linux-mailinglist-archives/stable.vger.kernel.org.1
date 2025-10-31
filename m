Return-Path: <stable+bounces-191975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BBEC27356
	for <lists+stable@lfdr.de>; Sat, 01 Nov 2025 00:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 617C44E595A
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 23:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391F32EB840;
	Fri, 31 Oct 2025 23:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gALIJ4nS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BB932C921
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761954155; cv=none; b=qxaCaoHPhOcgYPMamMlodQ+ZRPnABmvHGMzKI0zWvREcas2znbIOGjrvfuQ6MBfGUllVJkid3KqbbzsVsM2RmQfvSs1RrptB3te0POSOk3iRW3huVPfLsx+X76gJevfVGR0orwt3i/dLB4Evdl807vQysjkNC/eOb9QgPsrhUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761954155; c=relaxed/simple;
	bh=i/bb4Ywf2Nr6uloK3QTfhPAkrvD5TNMerqRE20boViM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=neQ63kUXNRdEuljuAMcg5afMMuiukvQqCfopHH/gmbjJ2+cTbrPgUt7aM6aQUAQzBpQVT3GqXqtGLqP0ZgSZawJ676c+HTWonBGNoUdgirUOfjiOhYTcoSb+HPsieLoejPnWTfxjMzWwIRNBdMs+O6TZD51zMEhymji+rKkDHgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gALIJ4nS; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761954152; x=1793490152;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i/bb4Ywf2Nr6uloK3QTfhPAkrvD5TNMerqRE20boViM=;
  b=gALIJ4nSMtb4dHHXIhKWUqN9+8BzC9FSYv5SKUxwnTIN7StahebN1f8Q
   WCxwTpXbpXrPx9zTncTgmQFHo2RoDGrLhmJfarFTM+gjTt6CIqIaPjuEY
   GnWvNhfNrJQvmvuG7Z6XcbldoaWLG2uVleY1w2WzF5tuEBFE+0vFGQVXC
   DZUkl7uU3e9360nlVMZ+pXJTfsnyG7pTtUS0mYAh8/usvGgMeCzGYgDk4
   K7bmWPJ2YJXPxxzfxamVnUapypg4J8UCWVeD39rur2TiewEy2/uEhiVWi
   1fCaEDtwOnSInrpD9ZFyYACNTs5Wn441JwIWT4VJlFPhnyZsboqjbl/24
   Q==;
X-CSE-ConnectionGUID: n2JFUtg3T2mcJjSMhayDcw==
X-CSE-MsgGUID: Jwu/bZVbRVa+VhAW7jQhSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="75470367"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="75470367"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 16:42:32 -0700
X-CSE-ConnectionGUID: SUqpsbngTp23PzfQMvyc3A==
X-CSE-MsgGUID: jBzmWsLNSDOAutNknt0cpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="186021323"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 16:42:31 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2] tools/testing/nvdimm: Use per-DIMM device handle
Date: Fri, 31 Oct 2025 16:42:20 -0700
Message-ID: <20251031234227.1303113-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KASAN reports a global-out-of-bounds access when running these nfit
tests: clear.sh, pmem-errors.sh, pfn-meta-errors.sh, btt-errors.sh,
daxdev-errors.sh, and inject-error.sh.

[] BUG: KASAN: global-out-of-bounds in nfit_test_ctl+0x769f/0x7840 [nfit_test]
[] Read of size 4 at addr ffffffffc03ea01c by task ndctl/1215
[] The buggy address belongs to the variable:
[] handle+0x1c/0x1df4 [nfit_test]

nfit_test_search_spa() uses handle[nvdimm->id] to retrieve a device
handle and triggers a KASAN error when it reads past the end of the
handle array. It should not be indexing the handle array at all.

The correct device handle is stored in per-DIMM test data. Each DIMM
has a struct nfit_mem that embeds a struct acpi_nfit_memdev that
describes the NFIT device handle. Use that device handle here. 

Fixes: 10246dc84dfc ("acpi nfit: nfit_test supports translate SPA")
Cc: <stable@vger.kernel.org>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v2:
- Use the correct handle in per-DIMM test data (Dan)
- Update commit message and log
- Update Fixes Tag


 tools/testing/nvdimm/test/nfit.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index cfd4378e2129..f87e9f251d13 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -670,6 +670,7 @@ static int nfit_test_search_spa(struct nvdimm_bus *bus,
 		.addr = spa->spa,
 		.region = NULL,
 	};
+	struct nfit_mem *nfit_mem;
 	u64 dpa;
 
 	ret = device_for_each_child(&bus->dev, &ctx,
@@ -687,8 +688,12 @@ static int nfit_test_search_spa(struct nvdimm_bus *bus,
 	 */
 	nd_mapping = &nd_region->mapping[nd_region->ndr_mappings - 1];
 	nvdimm = nd_mapping->nvdimm;
+	nfit_mem = nvdimm_provider_data(nvdimm);
+	if (!nfit_mem)
+		return -EINVAL;
 
-	spa->devices[0].nfit_device_handle = handle[nvdimm->id];
+	spa->devices[0].nfit_device_handle =
+		__to_nfit_memdev(nfit_mem)->device_handle;
 	spa->num_nvdimms = 1;
 	spa->devices[0].dpa = dpa;
 

base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.37.3


