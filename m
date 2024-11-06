Return-Path: <stable+bounces-89958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902F99BDBF6
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CA72849C5
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0456C1A2647;
	Wed,  6 Nov 2024 02:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Su/gNFFg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6A21991DD;
	Wed,  6 Nov 2024 02:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858975; cv=none; b=FN3opRGh5pkvmKp2wIjBGRJyNxFpyetEycooV7eqbquHKYlUsFcv2we2S0+0ePOqZRjqeIFdhzjz2oJfqUdc6X6iB8Hc556U+RZ1Eu00U0aPtTNXeNfbXTf++DRWvL9GDEQKGMFpqFWipT4cid8d47g593MDPPZm5sMdeFrCGcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858975; c=relaxed/simple;
	bh=VwRkToClopDoC3qQkobNq7Bo7X0ROJRnsg+iQK1qmsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJBM4YMFfV21mXdsh+IZVpcvHU3bcu0RKZW0yVD3CIXNjO5wPJc5eYYhTyUK7Skx31zyviB8mWuO1LMOpW9cRC7X9F0BRB3jut0ShjSRSgEWmJiY8FqNt0Q9Wv6jQl8zGWQXFpTT7mLagn1elYOKmy9rar1HsZUx5QA4obE7wm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Su/gNFFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6864DC4CECF;
	Wed,  6 Nov 2024 02:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730858975;
	bh=VwRkToClopDoC3qQkobNq7Bo7X0ROJRnsg+iQK1qmsI=;
	h=From:To:Cc:Subject:Date:From;
	b=Su/gNFFgs1tLTcmCpuQtd6WE01txDb34SBZYki1KaJP6qr1DUB5QRrOkEg+PkDbD7
	 TO34OlW5eEMQiAgpn1PxWFDMJtBnB++IkVp7tkanon04ZLzYX0/qFsMzLYlmalfC6C
	 1Hp32n9MzY+tvQRbCVD0mCqOY466f0AAiUsOUrL9xOt+26gEtHLHxbjn9Oz+yhExkr
	 f6VdbtRotfOt5hQ6cfxTU3NXdepN2kO7uUhoXuI7KMdb+xuY/Fu4mAyqZrI48U/lA3
	 g3zs9cukyFwWIH2248D6mKKJ6E73RaZIwwc8yq8K+S9/LhV3bC/wOpyEz5d1lrIrbk
	 q0hYMl3Is1FIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	dan.j.williams@intel.com
Cc: Gregory Price <gourry@gourry.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alejandro Lucero <alucerop@amd.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "cxl/port: Fix CXL port initialization order when the subsystem is built-in" failed to apply to v6.6-stable tree
Date: Tue,  5 Nov 2024 21:09:30 -0500
Message-ID: <20241106020931.165802-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6575b268157f37929948a8d1f3bafb3d7c055bc1 Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 25 Oct 2024 12:32:55 -0700
Subject: [PATCH] cxl/port: Fix CXL port initialization order when the
 subsystem is built-in

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
Link: https://patch.msgid.link/172988474904.476062.7961350937442459266.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/Kconfig  |  1 +
 drivers/cxl/Makefile | 20 ++++++++++++++------
 drivers/cxl/port.c   | 17 ++++++++++++++++-
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 29c192f20082c..876469e23f7a7 100644
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
index db321f48ba52e..2caa90fa4bf25 100644
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
index 861dde65768fe..9dc394295e1fc 100644
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
-- 
2.43.0





