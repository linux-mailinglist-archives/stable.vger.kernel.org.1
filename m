Return-Path: <stable+bounces-83420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E980999C1D
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 07:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C17CB22D2B
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 05:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887C319A285;
	Fri, 11 Oct 2024 05:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2+fq54q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B21194088;
	Fri, 11 Oct 2024 05:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624839; cv=none; b=Rg0rQB60I4PYvEMb7Y0siZjdOhZoyTqHO/qA9BDkwmEHlqNW7ShL/gAIWnBSAH/lzCCj2lSnay4m6jDSIG2s7SOe9TUaNhk5zR+hZbw3Y35lEN/w52dUSvOW6HA/VkNIzXsfJJbYXLuzEK+dDKwN7KbJajn5kF8zpr3KLSO0WJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624839; c=relaxed/simple;
	bh=NsxdIIwYHFf0138CTC+6ydgAfFnZVbKm5fxxekCvu8E=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=j1TLke/3n/lwRjcCRIR1HAIIdEInHH1Ctsqi2QhgJD7X40Pp2P/62rsEha4rkl6B8TodM06UI4tbrD17IoHr9DOohS2uP6+wnfuvJvhLQlsAWfLar6NHBSqELa83G3gFPNiWjT5mVs4JKZd1O2Rw16o0X1K+eFGXt2EgdMNsuek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2+fq54q; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728624836; x=1760160836;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NsxdIIwYHFf0138CTC+6ydgAfFnZVbKm5fxxekCvu8E=;
  b=c2+fq54qyqAf/tbP/GKLXmDHjtYLTtl5w3Gx1JqiaJmN0U+czMVOqjfn
   6GP9HJUf4/LycJDTCwF0LgrFGYrOcLQ53bw25pm1AkmXUewyI1YXCMZqr
   A1K4a82EUZGWF20NntklHc9s+5yYEWaIYU98230RA76Oj1TfGklKu1Xdj
   pDkUx7/Sz3F0D4pHbYtmQsQglqhlhcLV9Yzd1d+PiO1Vb00xMKKKz7S4H
   sXhVOsdmmXZUY1Dx3PuuVwlmM4hL5LT3SFtvjRWry2v9XiT7u/kNWfPdn
   RxW+KL72CzXk0xi/BmZhkez52GnjP516OUwWB9eRIpxvj+EPvisEWYa/w
   w==;
X-CSE-ConnectionGUID: 0qyd7hutSxO3C6UKZCxbuQ==
X-CSE-MsgGUID: wlFouyE2SN2L2rU7PUvpkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28124532"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="28124532"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 22:33:56 -0700
X-CSE-ConnectionGUID: iJrwIJSbRmmosvl8Rbvtyg==
X-CSE-MsgGUID: uyX7M/OySj6Msbbk7IP1EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="80814127"
Received: from inaky-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.111.110])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 22:33:55 -0700
Subject: [PATCH 0/5] cxl: Initialization and shutdown fixes
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com, ira.weiny@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, stable@vger.kernel.org,
 Zijun Hu <zijun_hu@icloud.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Gregory Price <gourry@gourry.net>, Vishal Verma <vishal.l.verma@intel.com>,
 linux-cxl@vger.kernel.org
Date: Thu, 10 Oct 2024 22:33:53 -0700
Message-ID: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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

[1]: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net

---

Dan Williams (5):
      cxl/port: Fix CXL port initialization order when the subsystem is built-in
      cxl/port: Fix cxl_bus_rescan() vs bus_rescan_devices()
      cxl/acpi: Ensure ports ready at cxl_acpi_probe() return
      cxl/port: Fix use-after-free, permit out-of-order decoder shutdown
      cxl/test: Improve init-order fidelity relative to real-world systems


 drivers/base/core.c          |   35 +++++++
 drivers/cxl/Kconfig          |    1
 drivers/cxl/Makefile         |   12 +--
 drivers/cxl/acpi.c           |    7 +
 drivers/cxl/core/hdm.c       |   50 +++++++++--
 drivers/cxl/core/port.c      |   13 ++-
 drivers/cxl/core/region.c    |   48 +++-------
 drivers/cxl/cxl.h            |    3 -
 include/linux/device.h       |    3 +
 tools/testing/cxl/test/cxl.c |  200 +++++++++++++++++++++++-------------------
 tools/testing/cxl/test/mem.c |    1
 11 files changed, 228 insertions(+), 145 deletions(-)

base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b

