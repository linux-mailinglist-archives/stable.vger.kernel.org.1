Return-Path: <stable+bounces-83126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBAA995DFC
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 05:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4863E1C2334F
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 03:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BF5131E2D;
	Wed,  9 Oct 2024 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XW9S/Si+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DD826AEC
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728443432; cv=none; b=To/HqcE12jrTeAJGHqPaBaBL+5hbL8QhB8J3Hzn/+0NYQO1ZwC8/ssptIihMmVk5VuDLrdGc8q+Kv9DqBe34dKEs2yShI3QlC+MmlSABWH4fQp+iD6zIyxgMqWJ1Ai08IRbQHBNGaz5H6sXhq6UwOuvilfGCNaHEqyIFq9DpgNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728443432; c=relaxed/simple;
	bh=ERliiDH51Jy2CI+k16D43w/UM25j89C6yk4qCe6/DV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MPjw+jGzmeR8f/0CptzWmOJ7/gmqzSbQAt0kPsgmNzb0pRnN5IkPBVVnlhq1w4QZzCJo2F4LH/l9jvrmgoauhsgYx+Orq796ggA+JYBEU0ocBxVHbNwitOlBtuFipJSKmwaZfRqR2Ua7SvkLWxOfSUejZ3slRAgCfqnZ8AQDIjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XW9S/Si+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728443430; x=1759979430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ERliiDH51Jy2CI+k16D43w/UM25j89C6yk4qCe6/DV0=;
  b=XW9S/Si+TUtZU+kfC1cUHZPb3Y64r8qXpOO0pHi4u9EZbzJhjOXYMFPh
   UAhiR1vROfSb3m5dE4SLC2JOqp2Y2iTNhUUTr1GC/PgPUFE+lQ/0uzOOC
   CGCiuSSt2U39IzE2stGh9W7D1H+g3ZZL4lTMz2MWoZr4FYqXAQyRBagYR
   iVImJgsKzq7DEtvKtw5vaMrLUGeqUzPHv61FQToe19JHrKZN3gsG+62Sy
   rhGeiZoaKSjyO1a5rmcQvZN/gzc2ETJn1wM8trI1/eAc2VFNiq/AhyLJZ
   F3l9snQG3zyeuO53cAXI6bNFO9BDS7R65FJhkBJc8aHAw4O9O5JD66BCC
   A==;
X-CSE-ConnectionGUID: ULKZql+xSWeETcMVGmcTwQ==
X-CSE-MsgGUID: 2Xh0kcLBSaCqnfUJANYatQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="39109398"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="39109398"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 20:10:29 -0700
X-CSE-ConnectionGUID: kj1WFCzbSKqDi76WmYAU9A==
X-CSE-MsgGUID: RzbT1KOVQ1CFEVpu77/13g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="81124115"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.3.32])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 20:10:26 -0700
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
Subject: [PATCH 5.15.y] resource: fix region_intersects() vs add_memory_driver_managed()
Date: Wed,  9 Oct 2024 11:10:00 +0800
Message-Id: <20241009031000.885997-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2024100725-galore-pout-d68c@gregkh>
References: <2024100725-galore-pout-d68c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index cb441e3e7670..972bf1bf4d69 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -480,20 +480,62 @@ EXPORT_SYMBOL_GPL(page_is_ram);
 static int __region_intersects(resource_size_t start, size_t size,
 			unsigned long flags, unsigned long desc)
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
+		for (dp = p->child; dp; dp = next_resource(dp)) {
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
 
 	if (type == 0)
-- 
2.39.2


