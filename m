Return-Path: <stable+bounces-40693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D808AE794
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 15:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE2E1F25D94
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F08D13475B;
	Tue, 23 Apr 2024 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XdsF1syq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32F0131BB1
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877784; cv=none; b=XwjsPCKgyK1dZ1l2ykUQPBI6U0+v8cvKrIMk1Lrs8FPrwNwMyJK3GO4IGJl7aTokYno4V0Vih1wxJh0mCD9f+cmp25yr6ueTb27kwpV6II8MRc22LgE114fL4SrVStLwpBBCRjAKz456KGRf02SxcjPb1HycS2IqcTxfj3IkFXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877784; c=relaxed/simple;
	bh=F/03b1ZiQhP1Wb32bYRqE6z88L0/wBnLq3tRDdWlS+A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NcFvm5nCMHaoYMS5FR1+G8QC//OO0ig0SVEZMVh0bm2C2bXIEQECjXhV3JW8w2svct7VLz42/b67Xr6k5r6XjLHEf8LfYrUVWThFetutJWlLjtY0sRnuzHzft6RMPKoXkQIzCG344kDyPE0GBowRJmmVGWAkQPpz2G2w0PUhxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XdsF1syq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C245DC3277B;
	Tue, 23 Apr 2024 13:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713877783;
	bh=F/03b1ZiQhP1Wb32bYRqE6z88L0/wBnLq3tRDdWlS+A=;
	h=Subject:To:Cc:From:Date:From;
	b=XdsF1syqv8NlnoV8hFbuWua171F0AYgC764Gsfb3uDraTn81vXsJAk9l/nwf9E8cs
	 3IoDRICqJYFu3quwVdbrx34iEEZA0I3Ts5L1J9LPz/WMN2KQIAmPOF15H775KNKluR
	 0xXcLomAI/yK6m2XGf7uS3YHnUCWFELSZhTxBVj0=
Subject: FAILED: patch "[PATCH] bootconfig: use memblock_free_late to free xbc memory to" failed to apply to 5.15-stable tree
To: qiang4.zhang@intel.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 06:09:34 -0700
Message-ID: <2024042333-modular-gore-ddf8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 89f9a1e876b5a7ad884918c03a46831af202c8a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042333-modular-gore-ddf8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

89f9a1e876b5 ("bootconfig: use memblock_free_late to free xbc memory to buddy")
512b7931ad05 ("Merge branch 'akpm' (patches from Andrew)")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 89f9a1e876b5a7ad884918c03a46831af202c8a0 Mon Sep 17 00:00:00 2001
From: Qiang Zhang <qiang4.zhang@intel.com>
Date: Sun, 14 Apr 2024 19:49:45 +0800
Subject: [PATCH] bootconfig: use memblock_free_late to free xbc memory to
 buddy

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

Link: https://lore.kernel.org/all/20240414114944.1012359-1-qiang4.zhang@linux.intel.com/

Fixes: 40caa127f3c7 ("init: bootconfig: Remove all bootconfig data when the init memory is removed")
Cc: Stable@vger.kernel.org
Signed-off-by: Qiang Zhang <qiang4.zhang@intel.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index e5ee2c694401..3f4b4ac527ca 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -288,7 +288,12 @@ int __init xbc_init(const char *buf, size_t size, const char **emsg, int *epos);
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
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index c59d26068a64..8841554432d5 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -61,9 +61,12 @@ static inline void * __init xbc_alloc_mem(size_t size)
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
@@ -73,7 +76,7 @@ static inline void *xbc_alloc_mem(size_t size)
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
@@ -963,7 +966,7 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 	if (!xbc_nodes) {
 		if (emsg)
 			*emsg = "Failed to allocate bootconfig nodes";
-		xbc_exit();
+		_xbc_exit(true);
 		return -ENOMEM;
 	}
 	memset(xbc_nodes, 0, sizeof(struct xbc_node) * XBC_NODE_MAX);
@@ -977,7 +980,7 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 			*epos = xbc_err_pos;
 		if (emsg)
 			*emsg = xbc_err_msg;
-		xbc_exit();
+		_xbc_exit(true);
 	} else
 		ret = xbc_node_num;
 


