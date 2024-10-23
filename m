Return-Path: <stable+bounces-87788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 774F99ABB1A
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 03:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61C81C22471
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 01:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612A2339A8;
	Wed, 23 Oct 2024 01:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDP85mAw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA9F20323;
	Wed, 23 Oct 2024 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729647800; cv=none; b=jO+tFPS7yoekIbKzsZglOOTF71WAgZ/j0iCKSy246yCtT/qgvz2AG8mbW68/50ypoZSIXJ3Ftf2DqVgd4wucQHej0UcXiGqd4jCxJmEtRuIReor65/cPz+My90qXz7NTII7IJcifKrkTHx+iyXn9wqo8uLAAdqJ+KxLek7rANAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729647800; c=relaxed/simple;
	bh=QgpSEzV0YSMCLxZpRzGlf6GnlFif3OnO58CGeVmrVnQ=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=XgVQT/p7oCWQL5Zh5XvvttrHfNMO/xcuPeRDkBaH+viQHO8gyo7jith5BWmkbC+3c1FEBZVVDKv0tO9PkZuPjp0VfNRQi9+MLXCZys2wuySSRoMXNQxx56cRrl2fiakThV85diD7S4U3mYN2rFcIuYUJUVhQey/idqcuStjIneg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDP85mAw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729647798; x=1761183798;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QgpSEzV0YSMCLxZpRzGlf6GnlFif3OnO58CGeVmrVnQ=;
  b=RDP85mAwdkwj7THYpsOqwLbyM0/Um8Sv7/fkcB1EF6vNzvHFuWfUl4qv
   KX5CSGJG+8F1lyRZmFJzhB+WSCrgtcPsSRD4L61Jr42uyMGfUeAW2/go7
   +W64T8sjggtskb99pn0HMAijDMDh3CQzSWLYaC6uLQikBZq9wBe8ksQSQ
   tK5ZJQ9VD07WRpxnvIzXn4uydz2vLYC4TqWJmv6AHbqQSQhGBC+OYfp+S
   h2net5ba4sfOri+q0A3HiAxgpoBvD8elexRCFx1NNYA3PmGsCbAcvI2BG
   j2ltvLIur0X16DKzi9sh48fb5LNtprxrfnzZDcTrzPB0wAMSwpNEEiVz8
   Q==;
X-CSE-ConnectionGUID: +sVhEuBNTJuZyS7ihaaiOw==
X-CSE-MsgGUID: 6WVpMTu9Ql2jNTYgdQlWvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="28658036"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="28658036"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 18:43:17 -0700
X-CSE-ConnectionGUID: SxEhoHsiRSeKvLgZmUP2nQ==
X-CSE-MsgGUID: yTLWsjrWS3GrMOayktl75A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="84630679"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.110.222])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 18:43:17 -0700
Subject: [PATCH v2 0/6] cxl: Initialization and shutdown fixes
From: Dan Williams <dan.j.williams@intel.com>
To: ira.weiny@intel.com
Cc: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Gregory Price <gourry@gourry.net>, Zijun Hu <quic_zijuhu@quicinc.com>,
 Vishal Verma <vishal.l.verma@intel.com>, dave.jiang@intel.com,
 linux-cxl@vger.kernel.org
Date: Tue, 22 Oct 2024 18:43:15 -0700
Message-ID: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Changes since v1 [1]:
- Fix some misspellings missed by checkpatch in changelogs (Jonathan)
- Add comments explaining the order of objects in drivers/cxl/Makefile
  (Jonathan)
- Rename attach_device => cxl_rescan_attach (Jonathan)
- Fixup Zijun's email (Zijun)

[1]: http://lore.kernel.org/172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com

---

Original cover:

Gregory's modest proposal to fix CXL cxl_mem_probe() failures due to
delayed arrival of the CXL "root" infrastructure [1] prompted questions
of how the existing mechanism for retrying cxl_mem_probe() could be
failing.

The critical missing piece in the debug was that Gregory's setup had
almost all CXL modules built-in to the kernel.

On the way to that discovery several other bugs and init-order corner
cases were discovered.

The main fix is to make sure the drivers/cxl/Makefile object order
supports root CXL ports being fully initialized upon cxl_acpi_probe()
exit. The modular case has some similar potential holes that are fixed
with MODULE_SOFTDEP() and other fix ups. Finally, an attempt to update
cxl_test to reproduce the original report resulted in the discovery of a
separate long standing use after free bug in cxl_region_detach().

[2]: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net

---

Dan Williams (6):
      cxl/port: Fix CXL port initialization order when the subsystem is built-in
      cxl/port: Fix cxl_bus_rescan() vs bus_rescan_devices()
      cxl/acpi: Ensure ports ready at cxl_acpi_probe() return
      cxl/port: Fix use-after-free, permit out-of-order decoder shutdown
      cxl/port: Prevent out-of-order decoder allocation
      cxl/test: Improve init-order fidelity relative to real-world systems


 drivers/base/core.c          |   35 +++++++
 drivers/cxl/Kconfig          |    1 
 drivers/cxl/Makefile         |   20 +++-
 drivers/cxl/acpi.c           |    7 +
 drivers/cxl/core/hdm.c       |   50 +++++++++--
 drivers/cxl/core/port.c      |   13 ++-
 drivers/cxl/core/region.c    |   91 ++++++++++---------
 drivers/cxl/cxl.h            |    3 -
 include/linux/device.h       |    3 +
 tools/testing/cxl/test/cxl.c |  200 +++++++++++++++++++++++-------------------
 tools/testing/cxl/test/mem.c |    1 
 11 files changed, 269 insertions(+), 155 deletions(-)

base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b

