Return-Path: <stable+bounces-79584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F0C98D93E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6641C231E1
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D304F1D1F44;
	Wed,  2 Oct 2024 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lahOHIku"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875561D0DC3;
	Wed,  2 Oct 2024 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877869; cv=none; b=bHn+cm5WzqbQeWwGVnfEaPq9UUqm4nrt1PFGFg1GK4TCOdeCVoKfRg7d9tc/FJti5WJsNftOcZn87nAmFI1CmrkUu548vw3yqmbSnwaXnG4FaTDc0NUnyuYaD+7MKLCwna4kq85Bna9I3BjTuUyni+JRGnqS2i/yieA+DFSjmnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877869; c=relaxed/simple;
	bh=2iblJSfDhavLNlcFc8pxKyWHrvSri+qlUOhY9PRevvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJBSVFL5iuxAScye6aXiHtgyYoHoyNUGLLkVVXdgr0Vq5yo97TmQAgif+Ok+RlF9+5GW05tKO7glY1SPrHx1yMW7h/YsET86gOMhclJNK43vQS82QciZwll1VsGwtdX1UMu8eaTUiMkKyw/qBHofvaLRQI2aH3CfrQD7DNh4f4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lahOHIku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4C0C4CEC2;
	Wed,  2 Oct 2024 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877869;
	bh=2iblJSfDhavLNlcFc8pxKyWHrvSri+qlUOhY9PRevvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lahOHIkuhA4mBFOH2XEBGCrjmrEXjKfpkcQ/ltiq1/Gtdldl3YKu02+NjySnNgU8N
	 wqq+jbirkJx1DHnZT5EsIXtbXJpISzhW074UvgWlgZRn2Ov9R4sipIeOjAcCxrRGw6
	 kGO1NigKTRTLlgpFWqouvCfD7gH07JtHzdIgJKPQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Juergen Gross <jgross@suse.com>,
	Jan Beulich <jbeulich@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 222/634] xen: add capability to remap non-RAM pages to different PFNs
Date: Wed,  2 Oct 2024 14:55:22 +0200
Message-ID: <20241002125819.863191886@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

[ Upstream commit d05208cf7f05420ad10cc7f9550f91d485523659 ]

When running as a Xen PV dom0 it can happen that the kernel is being
loaded to a guest physical address conflicting with the host memory
map.

In order to be able to resolve this conflict, add the capability to
remap non-RAM areas to different guest PFNs. A function to use this
remapping information for other purposes than doing the remap will be
added when needed.

As the number of conflicts should be rather low (currently only
machines with max. 1 conflict are known), save the remap data in a
small statically allocated array.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Stable-dep-of: be35d91c8880 ("xen: tolerate ACPI NVS memory overlapping with Xen allocated memory")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/xen/p2m.c     | 63 ++++++++++++++++++++++++++++++++++++++++++
 arch/x86/xen/xen-ops.h |  3 ++
 2 files changed, 66 insertions(+)

diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index 6bcbdf3b7999f..9a5e6a7c0729e 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -80,6 +80,7 @@
 #include <asm/xen/hypervisor.h>
 #include <xen/balloon.h>
 #include <xen/grant_table.h>
+#include <xen/hvc-console.h>
 
 #include "multicalls.h"
 #include "xen-ops.h"
@@ -793,6 +794,68 @@ int clear_foreign_p2m_mapping(struct gnttab_unmap_grant_ref *unmap_ops,
 	return ret;
 }
 
+/* Remapped non-RAM areas */
+#define NR_NONRAM_REMAP 4
+static struct nonram_remap {
+	phys_addr_t maddr;
+	phys_addr_t paddr;
+	size_t size;
+} xen_nonram_remap[NR_NONRAM_REMAP] __ro_after_init;
+static unsigned int nr_nonram_remap __ro_after_init;
+
+/*
+ * Do the real remapping of non-RAM regions as specified in the
+ * xen_nonram_remap[] array.
+ * In case of an error just crash the system.
+ */
+void __init xen_do_remap_nonram(void)
+{
+	unsigned int i;
+	unsigned int remapped = 0;
+	const struct nonram_remap *remap = xen_nonram_remap;
+	unsigned long pfn, mfn, end_pfn;
+
+	for (i = 0; i < nr_nonram_remap; i++) {
+		end_pfn = PFN_UP(remap->paddr + remap->size);
+		pfn = PFN_DOWN(remap->paddr);
+		mfn = PFN_DOWN(remap->maddr);
+		while (pfn < end_pfn) {
+			if (!set_phys_to_machine(pfn, mfn))
+				panic("Failed to set p2m mapping for pfn=%lx mfn=%lx\n",
+				       pfn, mfn);
+
+			pfn++;
+			mfn++;
+			remapped++;
+		}
+
+		remap++;
+	}
+
+	pr_info("Remapped %u non-RAM page(s)\n", remapped);
+}
+
+/*
+ * Add a new non-RAM remap entry.
+ * In case of no free entry found, just crash the system.
+ */
+void __init xen_add_remap_nonram(phys_addr_t maddr, phys_addr_t paddr,
+				 unsigned long size)
+{
+	BUG_ON((maddr & ~PAGE_MASK) != (paddr & ~PAGE_MASK));
+
+	if (nr_nonram_remap == NR_NONRAM_REMAP) {
+		xen_raw_console_write("Number of required E820 entry remapping actions exceed maximum value\n");
+		BUG();
+	}
+
+	xen_nonram_remap[nr_nonram_remap].maddr = maddr;
+	xen_nonram_remap[nr_nonram_remap].paddr = paddr;
+	xen_nonram_remap[nr_nonram_remap].size = size;
+
+	nr_nonram_remap++;
+}
+
 #ifdef CONFIG_XEN_DEBUG_FS
 #include <linux/debugfs.h>
 #include "debugfs.h"
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index f46a1dd3624da..a6a21dd055270 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -43,6 +43,9 @@ void xen_mm_unpin_all(void);
 #ifdef CONFIG_X86_64
 void __init xen_relocate_p2m(void);
 #endif
+void __init xen_do_remap_nonram(void);
+void __init xen_add_remap_nonram(phys_addr_t maddr, phys_addr_t paddr,
+				 unsigned long size);
 
 void __init xen_chk_is_e820_usable(phys_addr_t start, phys_addr_t size,
 				   const char *component);
-- 
2.43.0




