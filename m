Return-Path: <stable+bounces-81324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E74993094
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D418B1C23417
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873AC1D88A1;
	Mon,  7 Oct 2024 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n+z4Khw+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CF61DA4C
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313541; cv=none; b=GvvMoyKRnJVNj2rifMKS616eeB/r1Xx8exnQFGauLG2URJ6uedIpMCPTmOo4xsK1yJBjuAVdaQY2MRCsOsr0/MdPKCuESEACsYLsPhflGymZRr6cq7wTRjovdJZG/PeguRkQJAgbmL269YpYy+CMXO2Xpie+LHYhwAhzMxod/uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313541; c=relaxed/simple;
	bh=q1ZKw8RjlFXC7NUvUDVRFWig9uacfTwrusXeymy2zZs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o9YKHIy5YWIpgCkmL4KP6Jd1Cj9fARtew1Pk0NWMtqR/k8PvrDYgzS3w5H8kexw0KRWncrR7B1XFj7zq0O/lLQtaDrCOS0R/MVIodeyWgWcW0NGjtIMDW37wua/rAqD+mMIzaFuXz7MKW08Wr/C2sr/78l9Tgk9S0+JVNvvLe50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n+z4Khw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AADC4CEC6;
	Mon,  7 Oct 2024 15:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728313540;
	bh=q1ZKw8RjlFXC7NUvUDVRFWig9uacfTwrusXeymy2zZs=;
	h=Subject:To:Cc:From:Date:From;
	b=n+z4Khw+/4FQYVU8OB9S9EAmXM4C94HoKxSfPxDP97OM2WaTVA0GSWXINryYyM9Us
	 q8Vt5PidFPnQNrP2hBZTf/nF9HJ5gmpRWPLMs0r/v/vmy9TZyseTnJdDCpdvBR+cbl
	 VdSDu3Ry+3DFRLqjuFipYaR8/haI8nhtUE5kr2uY=
Subject: FAILED: patch "[PATCH] resource: fix region_intersects() vs" failed to apply to 5.4-stable tree
To: ying.huang@intel.com,akpm@linux-foundation.org,alison.schofield@intel.com,andriy.shevchenko@linux.intel.com,apopple@nvidia.com,bhe@redhat.com,bhelgaas@google.com,dan.j.williams@intel.com,dave.jiang@intel.com,dave@stgolabs.net,david@redhat.com,ira.weiny@intel.com,jonathan.cameron@huawei.com,stable@vger.kernel.org,vishal.l.verma@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 17:05:34 +0200
Message-ID: <2024100733-tiara-detective-885e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x b4afe4183ec77f230851ea139d91e5cf2644c68b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100733-tiara-detective-885e@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

b4afe4183ec7 ("resource: fix region_intersects() vs add_memory_driver_managed()")
14b80582c43e ("resource: Introduce alloc_free_mem_region()")
27674ef6c73f ("mm: remove the extra ZONE_DEVICE struct page refcount")
dc90f0846df4 ("mm: don't include <linux/memremap.h> in <linux/mm.h>")
895749455f60 ("mm: simplify freeing of devmap managed pages")
75e55d8a107e ("mm: move free_devmap_managed_page to memremap.c")
730ff52194cd ("mm: remove pointless includes from <linux/hmm.h>")
f56caedaf94f ("Merge branch 'akpm' (patches from Andrew)")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b4afe4183ec77f230851ea139d91e5cf2644c68b Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Fri, 6 Sep 2024 11:07:11 +0800
Subject: [PATCH] resource: fix region_intersects() vs
 add_memory_driver_managed()

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

diff --git a/kernel/resource.c b/kernel/resource.c
index 14777afb0a99..235dc77f8add 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -540,20 +540,62 @@ static int __region_intersects(struct resource *parent, resource_size_t start,
 			       size_t size, unsigned long flags,
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
 
 	for (p = parent->child; p ; p = p->sibling) {
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
+		for_each_resource(p, dp, false) {
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


