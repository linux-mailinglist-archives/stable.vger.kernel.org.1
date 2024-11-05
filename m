Return-Path: <stable+bounces-89897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F569BD2E0
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A41A1C223DA
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7321D9A7A;
	Tue,  5 Nov 2024 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mTpz46qd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E905178CDE
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730825540; cv=none; b=qFFsZYYNy7WnvIs4I3gpqELUzo3uM9I678hanw4zb/otq1nhiZPU6j+q23rH1m1M9tBYIX7e0e9xJEJ1Ga+g0B8clm35X9forIFUGbwL4ME8z8q3aXNdn1Wd6fvyN6wKurqTR2qj+ferIhpbYjFTB72ZkvFGkRRlYSTlYmfwh0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730825540; c=relaxed/simple;
	bh=P5T45wFLhLXT1It6UhTxPNTlcgcZhO5HRXsC+YqoSAQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pB3xlRxXyIsmue/OFfns/haXmiyTDii6lZmnG+7+b/ozXzA1CffIMqLw1alfGJyXcSwmVohfZ5MVLr6OGOgJSnpLdCVTX9SRnPQ1pMtdJXKFRpbHT/RmhRrleZux/e0wZ0GMEjlOovks2FrvHs5B98NfEzNu5y95cuCs7OEMuNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mTpz46qd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE17C4CECF;
	Tue,  5 Nov 2024 16:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730825537;
	bh=P5T45wFLhLXT1It6UhTxPNTlcgcZhO5HRXsC+YqoSAQ=;
	h=Subject:To:Cc:From:Date:From;
	b=mTpz46qdEVpnj59U3UkDXUrST9wTh4Bz1Hg507rm/rEEcJ7weXqTUw1scE2S037s0
	 Eeah3FiyJ9eDsDAHon4o/FM9fFj56tiASwRpyLgqrAvJiDca1KUQdDO46KztmLU4tY
	 JEhF5FnCGIGR1LgD3zmqJmYZ/Ivkj+Kb9remdII0=
Subject: FAILED: patch "[PATCH] cxl/port: Fix CXL port initialization order when the" failed to apply to 6.1-stable tree
To: dan.j.williams@intel.com,Jonathan.Cameron@huawei.com,alison.schofield@intel.com,alucerop@amd.com,dave.jiang@intel.com,dave@stgolabs.net,gourry@gourry.net,ira.weiny@intel.com,jonathan.cameron@huawei.com,vishal.l.verma@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 05 Nov 2024 17:51:51 +0100
Message-ID: <2024110551-fragrance-deodorant-e7fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6575b268157f37929948a8d1f3bafb3d7c055bc1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110551-fragrance-deodorant-e7fa@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

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


