Return-Path: <stable+bounces-87789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F04E19ABB1B
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 03:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6A11C224E7
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 01:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4EC339A8;
	Wed, 23 Oct 2024 01:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejr6m//b"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79EA20323;
	Wed, 23 Oct 2024 01:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729647808; cv=none; b=HTnl4AWwJ0qs+KzjbOZPdVtLqSa3xg61Fch5+IYJjC8n1USJ5oBwJZWM+zr3KzdIuWU5vyrMzizsG9kui9VqobUvOY5IGzi2wqSfKN9e09h6p7t1nVMQrJN7fCoALWmVfzGEMbYgVo92cZguTJHzfCIi7hd2NLUBfxCadMSNAhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729647808; c=relaxed/simple;
	bh=hRlt6zWXN+JO1BCxg9TJx3kZIWg+qY5u+t8CECAw79I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUwWZgEq6eGZLCAnRmoA3vzqTCgCOCmU+Dm7E0t7UwqKh5OBY422Aa15BIWGle1IO55Tg0koJQJVxWXwEtin2IYSN0ZjVGoOZ6l7nNQtLGbGQcD0n+c8bShflYE6eS4yvG5gcO/JYxO/7eX40xh0Ffa+FAUrcBIrYHYx2awMtAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejr6m//b; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729647807; x=1761183807;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hRlt6zWXN+JO1BCxg9TJx3kZIWg+qY5u+t8CECAw79I=;
  b=ejr6m//bC9VdH/UX3jy62fotKCym8DXrzOnQ9xRN5X+8MvpMimCJJNY7
   ogp+Di7jnz9TdZMn2jcLDoDYEQpl6pRwUbujkdrjcmUcjnRVjJkAKrWj0
   y7zBIy465obwiyGZemcQr+bkLXCxWGBs1A8go7uLufQeieTYO1Pu6O8E2
   a7L/ckav8IojmiyE5dcz1YJ/W39JJsiaWZpJJDWYz5kokqPBy+q2vmcaR
   kzO/KBrTDuJvya/36LziPEcMPiPDw4tWuf18qQ5sa+hyky7EMshEHAGho
   B/9Yg2OqjmAb7UliyV0isjQ9xA+Z1/xuvx6hwLIZENJDlWUaIRedLE+q+
   A==;
X-CSE-ConnectionGUID: lz3YJNCcTxq9Nq2SgTMJZw==
X-CSE-MsgGUID: NU8jjOWvS7WtHQmKIGFJyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="28658048"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="28658048"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 18:43:26 -0700
X-CSE-ConnectionGUID: i2Z/HCKzQLOZxygwkIZ+3Q==
X-CSE-MsgGUID: mWDpW2H9QVCnl0wFzaZ8ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="84630701"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.110.222])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 18:43:25 -0700
Subject: [PATCH v2 1/6] cxl/port: Fix CXL port initialization order when the
 subsystem is built-in
From: Dan Williams <dan.j.williams@intel.com>
To: ira.weiny@intel.com
Cc: Gregory Price <gourry@gourry.net>, Gregory Price <gourry@gourry.net>,
 stable@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, dave.jiang@intel.com,
 linux-cxl@vger.kernel.org
Date: Tue, 22 Oct 2024 18:43:24 -0700
Message-ID: <172964780249.81806.11601867702278939388.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
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
that cxl_acpi and cxl_mem can race to attach and that if cxl_acpi wins
the race cxl_mem will find the enabled CXL root ports it needs and if
cxl_acpi loses the race it will retrigger cxl_mem to attach via
cxl_bus_rescan(). That only works if cxl_acpi can assume ports are
enabled immediately upon cxl_acpi_probe() return. That in turn can only
happen in the CONFIG_CXL_ACPI=y case if the cxl_port object appears
before the cxl_acpi object in the Makefile.

Fix up the order to prevent initialization failures, and make sure that
cxl_port is built-in if cxl_acpi is also built-in.

As for what contributed to this not being found earlier, the CXL
regression environment, cxl_test, builds all CXL functionality as a
module to allow to symbol mocking and other dynamic reload tests.  As a
result there is no regression coverage for the built-in case.

Reported-by: Gregory Price <gourry@gourry.net>
Closes: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net
Tested-by: Gregory Price <gourry@gourry.net>
Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
Cc: <stable@vger.kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/Kconfig  |    1 +
 drivers/cxl/Makefile |   20 ++++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

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


