Return-Path: <stable+bounces-88194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B0F9B0F1D
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 21:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549E7282F58
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 19:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE78E214416;
	Fri, 25 Oct 2024 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpqzsAVu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8047C15B97D;
	Fri, 25 Oct 2024 19:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884781; cv=none; b=qXrC0CufCoL6F4aPkHlCdGWnjUIVJXXQ60gQKDOfx6IouiDo5F1R0E/2aI+EWV+ki6knEi2UPt81PMFyB3Lsd1iKBbRxBpjZSZOrKuS/iJbtNWhchjkgGFi8CnelEaDLojCJp4b0VPQ23sWr70p8XTmMERi4MIl3e6qBEqTmI1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884781; c=relaxed/simple;
	bh=ibaICnpqKXRmsUkdw41V0NvYkpAkwv05XSEz+06OQgw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdfUA51ZE0AOaMuivuKyUS5BNO+DwA5UUYmbRj0nHJJ1b9hStsf0D18Viklw/NpBqIyVyxuOLEiKfbPMLLvGiH1ClpoHoQ3RC+DUlOmJi+reEXugsSmRLnXuUImeHGpl8GpNdLq5cZnY4qeVkr4bWYG6WAtsfEu/Yg8scrX72QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XpqzsAVu; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729884778; x=1761420778;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ibaICnpqKXRmsUkdw41V0NvYkpAkwv05XSEz+06OQgw=;
  b=XpqzsAVuaec4RVBrZA5DcQO5PfaknUXoU6c/68uTGJ5aVV9bMUakoStS
   xPD/uWzSqkJAblUwBFVThXNeBhz4fmT/Mo7L5vtAs0k8oRU+7Pfa3zRjm
   nmdZmZx/Q/ckVoEmiNk3Wov9Fx/y8r8jXpZmKycxAuult7Ra32L+dfXqq
   R4k+sWXcXpTHY28hAG2NOty8Bm8J4pywV6SDdFlKUfasDZ1jnzdpVmkyh
   Gckfrg4S4ydbhD1k6vd7YCZpuIfGcaggs3AocGKUEftXfYCXdNjcH8BHU
   BTcVeaSmNIg21hKuUpGRPLPqExeG45+cs3Ue2Jt+mt5p0RRZKMheJa3tN
   A==;
X-CSE-ConnectionGUID: UqkvH8weR+KRMvBMwWKycQ==
X-CSE-MsgGUID: uYZTX9CJSKmh7AIUVJG6BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29463317"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="29463317"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 12:32:57 -0700
X-CSE-ConnectionGUID: aGq8HiRdT3C8tLg6FXeiOw==
X-CSE-MsgGUID: AdccOR1xTHSDz/ybfHERWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="80661638"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.111.137])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 12:32:57 -0700
Subject: [PATCH v3 1/6] cxl/port: Fix CXL port initialization order when the
 subsystem is built-in
From: Dan Williams <dan.j.williams@intel.com>
To: ira.weiny@intel.com
Cc: Gregory Price <gourry@gourry.net>, Gregory Price <gourry@gourry.net>,
 stable@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alejandro Lucero <alucerop@amd.com>, Alejandro Lucero <alucerop@amd.com>,
 dave.jiang@intel.com, linux-cxl@vger.kernel.org
Date: Fri, 25 Oct 2024 12:32:55 -0700
Message-ID: <172988474904.476062.7961350937442459266.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <172964780249.81806.11601867702278939388.stgit@dwillia2-xfh.jf.intel.com>
References: <172964780249.81806.11601867702278939388.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

When the CXL subsystem is built-in the module init order is determined
by Makefile order. That order violates expectations. The expectation is
that cxl_acpi and cxl_mem can race to attach. If cxl_acpi wins the race,
cxl_mem will find the enabled CXL root ports it needs. If cxl_acpi loses
the race it will retrigger cxl_mem to attach via cxl_bus_rescan(). That
flow only works if cxl_acpi can assume ports are enabled immediately
upon cxl_acpi_probe() return. That in turn can only happen in the
CONFIG_CXL_ACPI=y case if the cxl_port driver is registered before
cxl_acpi_probe() runs.

Fix up the order to prevent initialization failures. Ensure that
cxl_port is built-in when cxl_acpi is also built-in, arrange for
Makefile order to resolve the subsys_initcall() order of cxl_port and
cxl_acpi, and arrange for Makefile order to resolve the
device_initcall() (module_init()) order of the remaining objects.

As for what contributed to this not being found earlier, the CXL
regression environment, cxl_test, builds all CXL functionality as a
module to allow to symbol mocking and other dynamic reload tests.  As a
result there is no regression coverage for the built-in case.

Reported-by: Gregory Price <gourry@gourry.net>
Closes: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net
Tested-by: Gregory Price <gourry@gourry.net>
Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
Cc: stable@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Tested-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v2
- Partial re-roll patch1 to address comments and collect tags
- Move cxl_port to subsys_initcall, clarify changelog (Alejandro)

 drivers/cxl/Kconfig  |    1 +
 drivers/cxl/Makefile |   20 ++++++++++++++------
 drivers/cxl/port.c   |   17 ++++++++++++++++-
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 29c192f20082..876469e23f7a 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -60,6 +60,7 @@ config CXL_ACPI
 	default CXL_BUS
 	select ACPI_TABLE_LIB
 	select ACPI_HMAT
+	select CXL_PORT
 	help
 	  Enable support for host managed device memory (HDM) resources
 	  published by a platform's ACPI CXL memory layout description.  See
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index db321f48ba52..2caa90fa4bf2 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,13 +1,21 @@
 # SPDX-License-Identifier: GPL-2.0
+
+# Order is important here for the built-in case:
+# - 'core' first for fundamental init
+# - 'port' before platform root drivers like 'acpi' so that CXL-root ports
+#   are immediately enabled
+# - 'mem' and 'pmem' before endpoint drivers so that memdevs are
+#   immediately enabled
+# - 'pci' last, also mirrors the hardware enumeration hierarchy
 obj-y += core/
-obj-$(CONFIG_CXL_PCI) += cxl_pci.o
-obj-$(CONFIG_CXL_MEM) += cxl_mem.o
+obj-$(CONFIG_CXL_PORT) += cxl_port.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
-obj-$(CONFIG_CXL_PORT) += cxl_port.o
+obj-$(CONFIG_CXL_MEM) += cxl_mem.o
+obj-$(CONFIG_CXL_PCI) += cxl_pci.o
 
-cxl_mem-y := mem.o
-cxl_pci-y := pci.o
+cxl_port-y := port.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o security.o
-cxl_port-y := port.o
+cxl_mem-y := mem.o
+cxl_pci-y := pci.o
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 861dde65768f..9dc394295e1f 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -208,7 +208,22 @@ static struct cxl_driver cxl_port_driver = {
 	},
 };
 
-module_cxl_driver(cxl_port_driver);
+static int __init cxl_port_init(void)
+{
+	return cxl_driver_register(&cxl_port_driver);
+}
+/*
+ * Be ready to immediately enable ports emitted by the platform CXL root
+ * (e.g. cxl_acpi) when CONFIG_CXL_PORT=y.
+ */
+subsys_initcall(cxl_port_init);
+
+static void __exit cxl_port_exit(void)
+{
+	cxl_driver_unregister(&cxl_port_driver);
+}
+module_exit(cxl_port_exit);
+
 MODULE_DESCRIPTION("CXL: Port enumeration and services");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);


