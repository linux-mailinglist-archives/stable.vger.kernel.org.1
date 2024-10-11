Return-Path: <stable+bounces-83421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4B3999C1C
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 07:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E04285928
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 05:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9D01F9410;
	Fri, 11 Oct 2024 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="htPjWPNe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2802E2F26;
	Fri, 11 Oct 2024 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624847; cv=none; b=E7FlMzDEhQtxKtQ+UDVX8fOaODpQcoPnGNiIiOYlZ8Jpnx+pAusvsahH94h5F9uOqtxdEG1mcSnJRyWaf5V68XHi96df08fjH+qEFR3GF1l6kmJrL+73la1egG6j30q2VivPYzJkZxFPJYgJpYQwYjLVBLldsGmNanwSI5BDMoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624847; c=relaxed/simple;
	bh=ULtgtOIlkVwYdScG5guVFKkOrJW54pUZLqgsTvXscJU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6X7FHB4r+WaKtIXacXMiYBdWFVc2nIRb125BjNk0k4pzblC5cni1/a2zn6Xi/ND2Rx/gR0956TaUMqlKBaZ5nJf3/5gBRdH7ROziPfbtFqGbOKoovllNKwD0QMzqkFwAeU7a4M6aqGv263FwDQdU6vC4Cb0tfqvOw2rp/xEzRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=htPjWPNe; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728624845; x=1760160845;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ULtgtOIlkVwYdScG5guVFKkOrJW54pUZLqgsTvXscJU=;
  b=htPjWPNe8paVFDcFlbJDXH7PJBuA+HvPLtblQaulMcCn/QeJvJtuZziQ
   cNh6K4VYVbnQKYdxkqmVD8UnIGVXK2zSFTy2tITMeI4L+8NMIxWfyuL4E
   qm7ZNjGqZvXhPgY54sx9yavvQCDloJPTTy/zXm74JYZZCMsBEB7ZcfZuQ
   bJPhHvf3ZoeY5u39Cc8inkobGYiWD5vQbtgTdSZkVov3np0qW4QcxwGlh
   WMhHEfJAEutwlHag6V0XHDwcg9m/7fZ4Rq/De7N0gRcbCeOZgRpGLM5ty
   8PL8bZV3CQFiHDLUiPLn/KeWWlqnd2Bp8O5TqXKR1a8KA7470GzsvJGjx
   g==;
X-CSE-ConnectionGUID: 3vGeTBW3SEKP5qPE/4W8mA==
X-CSE-MsgGUID: WZTP8ivQRBSFchGSbpSSLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28124543"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="28124543"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 22:34:04 -0700
X-CSE-ConnectionGUID: AW9v4LBzTHqtfECgjm8KwA==
X-CSE-MsgGUID: LC0t25+gTYybLvJaHATJOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="80814144"
Received: from inaky-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.111.110])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 22:34:03 -0700
Subject: [PATCH 1/5] cxl/port: Fix CXL port initialization order when the
 subsystem is built-in
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com, ira.weiny@intel.com
Cc: Gregory Price <gourry@gourry.net>, Gregory Price <gourry@gourry.net>,
 stable@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org
Date: Thu, 10 Oct 2024 22:34:02 -0700
Message-ID: <172862484072.2150669.9910214123827630595.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
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
enabled immediately upone cxl_acpi_probe() return. That in turn can only
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
 drivers/cxl/Makefile |   12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

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
index db321f48ba52..374829359275 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,13 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += core/
-obj-$(CONFIG_CXL_PCI) += cxl_pci.o
-obj-$(CONFIG_CXL_MEM) += cxl_mem.o
+obj-$(CONFIG_CXL_PORT) += cxl_port.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
+obj-$(CONFIG_CXL_PCI) += cxl_pci.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
-obj-$(CONFIG_CXL_PORT) += cxl_port.o
+obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 
-cxl_mem-y := mem.o
-cxl_pci-y := pci.o
+cxl_port-y := port.o
 cxl_acpi-y := acpi.o
+cxl_pci-y := pci.o
 cxl_pmem-y := pmem.o security.o
-cxl_port-y := port.o
+cxl_mem-y := mem.o


