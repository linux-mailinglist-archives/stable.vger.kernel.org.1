Return-Path: <stable+bounces-83296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EC2997C80
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 07:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E603AB236D8
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 05:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B4119ABDC;
	Thu, 10 Oct 2024 05:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTCNln0F"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F043D66
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 05:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728538562; cv=none; b=K3Et1VDRNqI9a9h4GU5XFVd8Hxi0cmqsoRJd+Zae0hLEYKIaoIGktR0HFkND5IpMCQcguPO+7cfKicU+1LDWmeLfLExDgEx+8uBHzZZlCV9kfwz9v86Ox2/bpGghW2UUG/4sRRp3gG43HsmSCbg4to+8HCzXt/UJCTIIdyA5p9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728538562; c=relaxed/simple;
	bh=uB3NmZBkGVerQTB4lhfE33CQu/+AjaBRDnatltlQTz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mnQ5c9e3ET1ik86mWHa2fb6dAF0oPP1WkrHedi80FR65aZqN0sENkFuA8R8dgIqkq4BIkwBcl6phpm+hA7vYPsQ5eTVUrD0iYK5c29Sem3EnnLu9rmwAfojqaggAhjW1/72nAHRHFwG3DW7VnjFoD7p1MWLUdmYGv3HJ2pLDh0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTCNln0F; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728538560; x=1760074560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uB3NmZBkGVerQTB4lhfE33CQu/+AjaBRDnatltlQTz4=;
  b=kTCNln0FEvZWgEZXW3UygIUWW9ogRx6mNYusAalUAzwypvIxO+7EwU65
   o4fdQdXubSLv2Xk7/lgxlvXuwWsO5aCf0/0JXjoQ7Cx/pr4IHqIiOly6b
   j8TMdXn8J8H3JB4Dfj6v48h+mdvUPJeBG3xR4822l7ZQNl59DomHdT2BJ
   lkGLfdDsUoh4mtkzxuKylWy5tIzrFhsZGDAxcOOb/KYILb1FwIFMHYsLL
   xWlOAAA8Ma2WSZRq2m8TfpojzyoPwbq2JX4yFxpDL3CssKuL7klSaTTn0
   8rfMWPoT5TCoutmhyB6JntvKmrI7P6w1PX3dvKIy/KGrvtMoPwg4p+cH4
   Q==;
X-CSE-ConnectionGUID: aeOQKlLeQmmT8smHK44dQg==
X-CSE-MsgGUID: wBTtg0yPRHG0nFLXREIT5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28007026"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="28007026"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 22:36:00 -0700
X-CSE-ConnectionGUID: U2w6J4G6TMa4wPK2B5NyDA==
X-CSE-MsgGUID: 7yUqPLOXQQK2DT67z6blkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="81003819"
Received: from unknown (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.245.243.193])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 22:35:56 -0700
From: Huang Ying <ying.huang@intel.com>
To: stable@vger.kernel.org
Cc: Huang Ying <ying.huang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4.y -v2] resource: fix region_intersects() vs add_memory_driver_managed()
Date: Thu, 10 Oct 2024 13:35:51 +0800
Message-Id: <20241010053551.1229361-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2024100733-tiara-detective-885e@gregkh>
References: <2024100733-tiara-detective-885e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit b4afe4183ec77f230851ea139d91e5cf2644c68b upstream.

On a system with CXL memory, the resource tree (/proc/iomem) related to
CXL memory may look like something as follows.

490000000-50fffffff : CXL Window 0
  490000000-50fffffff : region0
    490000000-50fffffff : dax0.0
      490000000-50fffffff : System RAM (kmem)

Because drivers/dax/kmem.c calls add_memory_driver_managed() during
onlining CXL memory, which makes "System RAM (kmem)" a descendant of "CXL
Window X".  This confuses region_intersects(), which expects all "System
RAM" resources to be at the top level of iomem_resource.  This can lead to
bugs.

For example, when the following command line is executed to write some
memory in CXL memory range via /dev/mem,

 $ dd if=data of=/dev/mem bs=$((1 << 10)) seek=$((0x490000000 >> 10)) count=1
 dd: error writing '/dev/mem': Bad address
 1+0 records in
 0+0 records out
 0 bytes copied, 0.0283507 s, 0.0 kB/s

the command fails as expected.  However, the error code is wrong.  It
should be "Operation not permitted" instead of "Bad address".  More
seriously, the /dev/mem permission checking in devmem_is_allowed() passes
incorrectly.  Although the accessing is prevented later because ioremap()
isn't allowed to map system RAM, it is a potential security issue.  During
command executing, the following warning is reported in the kernel log for
calling ioremap() on system RAM.

 ioremap on RAM at 0x0000000490000000 - 0x0000000490000fff
 WARNING: CPU: 2 PID: 416 at arch/x86/mm/ioremap.c:216 __ioremap_caller.constprop.0+0x131/0x35d
 Call Trace:
  memremap+0xcb/0x184
  xlate_dev_mem_ptr+0x25/0x2f
  write_mem+0x94/0xfb
  vfs_write+0x128/0x26d
  ksys_write+0xac/0xfe
  do_syscall_64+0x9a/0xfd
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

The details of command execution process are as follows.  In the above
resource tree, "System RAM" is a descendant of "CXL Window 0" instead of a
top level resource.  So, region_intersects() will report no System RAM
resources in the CXL memory region incorrectly, because it only checks the
top level resources.  Consequently, devmem_is_allowed() will return 1
(allow access via /dev/mem) for CXL memory region incorrectly.
Fortunately, ioremap() doesn't allow to map System RAM and reject the
access.

So, region_intersects() needs to be fixed to work correctly with the
resource tree with "System RAM" not at top level as above.  To fix it, if
we found a unmatched resource in the top level, we will continue to search
matched resources in its descendant resources.  So, we will not miss any
matched resources in resource tree anymore.

In the new implementation, an example resource tree

|------------- "CXL Window 0" ------------|
|-- "System RAM" --|

will behave similar as the following fake resource tree for
region_intersects(, IORESOURCE_SYSTEM_RAM, ),

|-- "System RAM" --||-- "CXL Window 0a" --|

Where "CXL Window 0a" is part of the original "CXL Window 0" that
isn't covered by "System RAM".

Link: https://lkml.kernel.org/r/20240906030713.204292-2-ying.huang@intel.com
Fixes: c221c0b0308f ("device-dax: "Hotplug" persistent memory for use like normal RAM")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/resource.c | 58 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 841737bbda9e..48e995ff7465 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -536,21 +536,63 @@ EXPORT_SYMBOL_GPL(page_is_ram);
 int region_intersects(resource_size_t start, size_t size, unsigned long flags,
 		      unsigned long desc)
 {
-	struct resource res;
+	resource_size_t ostart, oend;
 	int type = 0; int other = 0;
-	struct resource *p;
+	struct resource *p, *dp;
+	bool is_type, covered;
+	struct resource res;
 
 	res.start = start;
 	res.end = start + size - 1;
 
 	read_lock(&resource_lock);
 	for (p = iomem_resource.child; p ; p = p->sibling) {
-		bool is_type = (((p->flags & flags) == flags) &&
-				((desc == IORES_DESC_NONE) ||
-				 (desc == p->desc)));
-
-		if (resource_overlaps(p, &res))
-			is_type ? type++ : other++;
+		if (!resource_overlaps(p, &res))
+			continue;
+		is_type = (p->flags & flags) == flags &&
+			(desc == IORES_DESC_NONE || desc == p->desc);
+		if (is_type) {
+			type++;
+			continue;
+		}
+		/*
+		 * Continue to search in descendant resources as if the
+		 * matched descendant resources cover some ranges of 'p'.
+		 *
+		 * |------------- "CXL Window 0" ------------|
+		 * |-- "System RAM" --|
+		 *
+		 * will behave similar as the following fake resource
+		 * tree when searching "System RAM".
+		 *
+		 * |-- "System RAM" --||-- "CXL Window 0a" --|
+		 */
+		covered = false;
+		ostart = max(res.start, p->start);
+		oend = min(res.end, p->end);
+		for (dp = p->child; dp; dp = next_resource(dp, false)) {
+			if (!resource_overlaps(dp, &res))
+				continue;
+			is_type = (dp->flags & flags) == flags &&
+				(desc == IORES_DESC_NONE || desc == dp->desc);
+			if (is_type) {
+				type++;
+				/*
+				 * Range from 'ostart' to 'dp->start'
+				 * isn't covered by matched resource.
+				 */
+				if (dp->start > ostart)
+					break;
+				if (dp->end >= oend) {
+					covered = true;
+					break;
+				}
+				/* Remove covered range */
+				ostart = max(ostart, dp->end + 1);
+			}
+		}
+		if (!covered)
+			other++;
 	}
 	read_unlock(&resource_lock);
 
-- 
2.39.2


