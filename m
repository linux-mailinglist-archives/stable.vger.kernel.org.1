Return-Path: <stable+bounces-4903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFF2807F59
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 04:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2671C20B75
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 03:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4198539B;
	Thu,  7 Dec 2023 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3xZ93oI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EB8D73;
	Wed,  6 Dec 2023 19:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701921429; x=1733457429;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tEV0WPHf89klT1cgAfwuGimvd7WgGWIyZu2vOFpC8Ro=;
  b=m3xZ93oI7PLKe5bt0ZEnkUM3Nmdu9qrKaIEDCIDrffi+HzQsRScF6YWy
   xCAtoOTCEjR5PVj6rd6kB2y1yXMBiejzfY6NnfcspwHTUq3VXPLsK3+zR
   SrLnzchSw++tHztjsoNV5Ilvio+T4Vuc5F0lhQsiM7Uh+GUhQc1cZgGnx
   sZW5XJMG80I2WMhoiYPZnAcLvkZPBwPsvQeEbxTvD/5EcbknxLY0Ioew2
   dTuveiTJpF2tUpky+JYSYJIHEdZHwfDKrbUk/cr7kv1yHDOw5EFgcgUct
   IucXhFI7EEXhezoNOzIRaa66wsrW9u3EOfU47MSRo/sc7bUkxc3sDaeBc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="12880909"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="12880909"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 19:57:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1018800612"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1018800612"
Received: from dpdesmon-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.70.214])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 19:57:07 -0800
Subject: [PATCH] cxl/hdm: Fix dpa translation locking
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: stable@vger.kernel.org, Alison Schofield <alison.schofield@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Date: Wed, 06 Dec 2023 19:57:06 -0800
Message-ID: <170192142664.461900.3169528633970716889.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The helper, cxl_dpa_resource_start(), snapshots the dpa-address of an
endpoint-decoder after acquiring the cxl_dpa_rwsem. However, it is
sufficient to assert that cxl_dpa_rwsem is held rather than acquire it
in the helper. Otherwise, it triggers multiple lockdep reports:

1/ Tracing callbacks are in an atomic context that can not acquire sleeping
locks:

    BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1525
    in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1288, name: bash
    preempt_count: 2, expected: 0
    RCU nest depth: 0, expected: 0
    [..]
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230524-3.fc38 05/24/2023
    Call Trace:
     <TASK>
     dump_stack_lvl+0x71/0x90
     __might_resched+0x1b2/0x2c0
     down_read+0x1a/0x190
     cxl_dpa_resource_start+0x15/0x50 [cxl_core]
     cxl_trace_hpa+0x122/0x300 [cxl_core]
     trace_event_raw_event_cxl_poison+0x1c9/0x2d0 [cxl_core]

2/ The rwsem is already held in the inject poison path:

    WARNING: possible recursive locking detected
    6.7.0-rc2+ #12 Tainted: G        W  OE    N
    --------------------------------------------
    bash/1288 is trying to acquire lock:
    ffffffffc05f73d0 (cxl_dpa_rwsem){++++}-{3:3}, at: cxl_dpa_resource_start+0x15/0x50 [cxl_core]

    but task is already holding lock:
    ffffffffc05f73d0 (cxl_dpa_rwsem){++++}-{3:3}, at: cxl_inject_poison+0x7d/0x1e0 [cxl_core]
    [..]
    Call Trace:
     <TASK>
     dump_stack_lvl+0x71/0x90
     __might_resched+0x1b2/0x2c0
     down_read+0x1a/0x190
     cxl_dpa_resource_start+0x15/0x50 [cxl_core]
     cxl_trace_hpa+0x122/0x300 [cxl_core]
     trace_event_raw_event_cxl_poison+0x1c9/0x2d0 [cxl_core]
     __traceiter_cxl_poison+0x5c/0x80 [cxl_core]
     cxl_inject_poison+0x1bc/0x1e0 [cxl_core]

This appears to have been an issue since the initial implementation and
uncovered by the new cxl-poison.sh test [1]. That test is now passing with
these changes.

Fixes: 28a3ae4ff66c ("cxl/trace: Add an HPA to cxl_poison trace events")
Link: http://lore.kernel.org/r/e4f2716646918135ddbadf4146e92abb659de734.1700615159.git.alison.schofield@intel.com [1]
Cc: <stable@vger.kernel.org>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c  |    3 +--
 drivers/cxl/core/port.c |    4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 529baa8a1759..7d97790b893d 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -363,10 +363,9 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
 {
 	resource_size_t base = -1;
 
-	down_read(&cxl_dpa_rwsem);
+	lockdep_assert_held(&cxl_dpa_rwsem);
 	if (cxled->dpa_res)
 		base = cxled->dpa_res->start;
-	up_read(&cxl_dpa_rwsem);
 
 	return base;
 }
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 38441634e4c6..f6e9b2986a9a 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -226,9 +226,9 @@ static ssize_t dpa_resource_show(struct device *dev, struct device_attribute *at
 			    char *buf)
 {
 	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
-	u64 base = cxl_dpa_resource_start(cxled);
 
-	return sysfs_emit(buf, "%#llx\n", base);
+	guard(rwsem_read)(&cxl_dpa_rwsem);
+	return sysfs_emit(buf, "%#llx\n", cxl_dpa_resource_start(cxled));
 }
 static DEVICE_ATTR_RO(dpa_resource);
 


