Return-Path: <stable+bounces-39962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1F58A5C19
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 22:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF123282645
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 20:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D13D71B50;
	Mon, 15 Apr 2024 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="k2SGAzo0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BC5156672;
	Mon, 15 Apr 2024 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713211997; cv=none; b=PO0rrhoab6uZTdwk1Wev7CdOQLWATLsCO11LrEZobSjCP6brRfO3d+mpsfib50ZTJkt1Yj/tnRms32yblHDbRSfgz4/t/xQK+/uN+UNseb34zUoVCSSAxpe4re6xHyTUp/cjWeUE66/P7wZzShGZtLDuK/0JN6P6wAs7EP/NdJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713211997; c=relaxed/simple;
	bh=XhZaUqi33iNdimf+kH/jB/mlkObACX1QivTcl91epn8=;
	h=Date:To:From:Subject:Message-Id; b=UZreqVGPlcWO3Viw66TCHzZ8FZkT8ZND4896MxN/zog4g/QpXNjt4pmUxWivgdC6afYItDCqLkTxdhIo9yzp6JDEGLAl3ldqKY6/d4Oasq9Qg49cfX4TmhkUWGOD2b/IpVq3kxBF7etYpxCWItm1xQO+Ky4CsK2Iovy0DafRRiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=k2SGAzo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59170C113CC;
	Mon, 15 Apr 2024 20:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713211996;
	bh=XhZaUqi33iNdimf+kH/jB/mlkObACX1QivTcl91epn8=;
	h=Date:To:From:Subject:From;
	b=k2SGAzo09fz9yAZFQhevNviOQuPG7uIKRr9UI8a4Qv94PeAVXRvFKR6bjdug1RYLV
	 Fe1cla1dcKSwp6ThHCgypajdCYYtTSfUnsYM9VIwo1yO+kVG3IxTNexT6ehqxEbv3I
	 jhlJfpQXpgzuHN1GWn6U4l8TM/ID1omqRbSMgTBc=
Date: Mon, 15 Apr 2024 13:13:15 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,mhiramat@kernel.org,qiang4.zhang@intel.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + bootconfig-use-memblock_free_late-to-free-xbc-memory-to-buddy.patch added to mm-hotfixes-unstable branch
Message-Id: <20240415201316.59170C113CC@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: bootconfig: use memblock_free_late to free xbc memory to buddy
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     bootconfig-use-memblock_free_late-to-free-xbc-memory-to-buddy.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/bootconfig-use-memblock_free_late-to-free-xbc-memory-to-buddy.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Qiang Zhang <qiang4.zhang@intel.com>
Subject: bootconfig: use memblock_free_late to free xbc memory to buddy
Date: Sun, 14 Apr 2024 19:49:45 +0800

On the time to free xbc memory in xbc_exit(), memblock may has handed
over memory to buddy allocator. So it doesn't make sense to free memory
back to memblock. memblock_free() called by xbc_exit() even causes UAF bugs
on architectures with CONFIG_ARCH_KEEP_MEMBLOCK disabled like x86.
Following KASAN logs shows this case.

This patch fixes the xbc memory free problem by calling memblock_free()
in early xbc init error rewind path and calling memblock_free_late() in
xbc exit path to free memory to buddy allocator.

[    9.410890] ==================================================================
[    9.418962] BUG: KASAN: use-after-free in memblock_isolate_range+0x12d/0x260
[    9.426850] Read of size 8 at addr ffff88845dd30000 by task swapper/0/1

[    9.435901] CPU: 9 PID: 1 Comm: swapper/0 Tainted: G     U             6.9.0-rc3-00208-g586b5dfb51b9 #5
[    9.446403] Hardware name: Intel Corporation RPLP LP5 (CPU:RaptorLake)/RPLP LP5 (ID:13), BIOS IRPPN02.01.01.00.00.19.015.D-00000000 Dec 28 2023
[    9.460789] Call Trace:
[    9.463518]  <TASK>
[    9.465859]  dump_stack_lvl+0x53/0x70
[    9.469949]  print_report+0xce/0x610
[    9.473944]  ? __virt_addr_valid+0xf5/0x1b0
[    9.478619]  ? memblock_isolate_range+0x12d/0x260
[    9.483877]  kasan_report+0xc6/0x100
[    9.487870]  ? memblock_isolate_range+0x12d/0x260
[    9.493125]  memblock_isolate_range+0x12d/0x260
[    9.498187]  memblock_phys_free+0xb4/0x160
[    9.502762]  ? __pfx_memblock_phys_free+0x10/0x10
[    9.508021]  ? mutex_unlock+0x7e/0xd0
[    9.512111]  ? __pfx_mutex_unlock+0x10/0x10
[    9.516786]  ? kernel_init_freeable+0x2d4/0x430
[    9.521850]  ? __pfx_kernel_init+0x10/0x10
[    9.526426]  xbc_exit+0x17/0x70
[    9.529935]  kernel_init+0x38/0x1e0
[    9.533829]  ? _raw_spin_unlock_irq+0xd/0x30
[    9.538601]  ret_from_fork+0x2c/0x50
[    9.542596]  ? __pfx_kernel_init+0x10/0x10
[    9.547170]  ret_from_fork_asm+0x1a/0x30
[    9.551552]  </TASK>

[    9.555649] The buggy address belongs to the physical page:
[    9.561875] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x45dd30
[    9.570821] flags: 0x200000000000000(node=0|zone=2)
[    9.576271] page_type: 0xffffffff()
[    9.580167] raw: 0200000000000000 ffffea0011774c48 ffffea0012ba1848 0000000000000000
[    9.588823] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[    9.597476] page dumped because: kasan: bad access detected

[    9.605362] Memory state around the buggy address:
[    9.610714]  ffff88845dd2ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    9.618786]  ffff88845dd2ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    9.626857] >ffff88845dd30000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[    9.634930]                    ^
[    9.638534]  ffff88845dd30080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[    9.646605]  ffff88845dd30100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[    9.654675] ==================================================================

Link: https://lkml.kernel.org/r/20240414114944.1012359-1-qiang4.zhang@linux.intel.com
Signed-off-by: Qiang Zhang <qiang4.zhang@intel.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/bootconfig.h |    7 ++++++-
 lib/bootconfig.c           |   19 +++++++++++--------
 2 files changed, 17 insertions(+), 9 deletions(-)

--- a/include/linux/bootconfig.h~bootconfig-use-memblock_free_late-to-free-xbc-memory-to-buddy
+++ a/include/linux/bootconfig.h
@@ -287,7 +287,12 @@ int __init xbc_init(const char *buf, siz
 int __init xbc_get_info(int *node_size, size_t *data_size);
 
 /* XBC cleanup data structures */
-void __init xbc_exit(void);
+void __init _xbc_exit(bool early);
+
+static inline void xbc_exit(void)
+{
+	_xbc_exit(false);
+}
 
 /* XBC embedded bootconfig data in kernel */
 #ifdef CONFIG_BOOT_CONFIG_EMBED
--- a/lib/bootconfig.c~bootconfig-use-memblock_free_late-to-free-xbc-memory-to-buddy
+++ a/lib/bootconfig.c
@@ -61,9 +61,12 @@ static inline void * __init xbc_alloc_me
 	return memblock_alloc(size, SMP_CACHE_BYTES);
 }
 
-static inline void __init xbc_free_mem(void *addr, size_t size)
+static inline void __init xbc_free_mem(void *addr, size_t size, bool early)
 {
-	memblock_free(addr, size);
+	if (early)
+		memblock_free(addr, size);
+	else if (addr)
+		memblock_free_late(__pa(addr), size);
 }
 
 #else /* !__KERNEL__ */
@@ -73,7 +76,7 @@ static inline void *xbc_alloc_mem(size_t
 	return malloc(size);
 }
 
-static inline void xbc_free_mem(void *addr, size_t size)
+static inline void xbc_free_mem(void *addr, size_t size, bool early)
 {
 	free(addr);
 }
@@ -904,13 +907,13 @@ static int __init xbc_parse_tree(void)
  * If you need to reuse xbc_init() with new boot config, you can
  * use this.
  */
-void __init xbc_exit(void)
+void __init _xbc_exit(bool early)
 {
-	xbc_free_mem(xbc_data, xbc_data_size);
+	xbc_free_mem(xbc_data, xbc_data_size, early);
 	xbc_data = NULL;
 	xbc_data_size = 0;
 	xbc_node_num = 0;
-	xbc_free_mem(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX);
+	xbc_free_mem(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX, early);
 	xbc_nodes = NULL;
 	brace_index = 0;
 }
@@ -963,7 +966,7 @@ int __init xbc_init(const char *data, si
 	if (!xbc_nodes) {
 		if (emsg)
 			*emsg = "Failed to allocate bootconfig nodes";
-		xbc_exit();
+		_xbc_exit(true);
 		return -ENOMEM;
 	}
 	memset(xbc_nodes, 0, sizeof(struct xbc_node) * XBC_NODE_MAX);
@@ -977,7 +980,7 @@ int __init xbc_init(const char *data, si
 			*epos = xbc_err_pos;
 		if (emsg)
 			*emsg = xbc_err_msg;
-		xbc_exit();
+		_xbc_exit(true);
 	} else
 		ret = xbc_node_num;
 
_

Patches currently in -mm which might be from qiang4.zhang@intel.com are

bootconfig-use-memblock_free_late-to-free-xbc-memory-to-buddy.patch


