Return-Path: <stable+bounces-99498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FBE9E71F5
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4651C285FB8
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9742E1537D4;
	Fri,  6 Dec 2024 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pfEvfQKv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C2513E03A;
	Fri,  6 Dec 2024 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497373; cv=none; b=BswL2ibtCKCTslSEfM25omAv5ssWPDRshIodRhzWNA7Wtb14HW/8PxSgkUSKwxOnT0O57FRYym/VIz83wzm26qqKbWLdE/PUuZyD6tectXxzPnp63xnbEF2O48SuDyLVK8sZrlK+DcEXT4P6XlM/Et2bbVPHrdk7m3b2swaI1Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497373; c=relaxed/simple;
	bh=DtR76VFNG//jPbXTfFzsTfkm8yv1u3AuCGMK1eC6VRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmeWM7SICz23O0tPQWObfbuqUEKmas4ClErldFcq4gfzYQIlbMkxSNU5dEAwGc7tR370Yt4PPjgtLYbbz/7O1mm91uajgUvCbaREG3i6mOf/xYHxox3Dt+DuWXcDJrjEtykBdhNAoCNKgG1MFvN5on8kPxxeKeOYND0DPOTisoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pfEvfQKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BACC4CEDC;
	Fri,  6 Dec 2024 15:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497373;
	bh=DtR76VFNG//jPbXTfFzsTfkm8yv1u3AuCGMK1eC6VRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pfEvfQKvXWM4EHZx3k+OWlKH6EtA/muOr857dnNVccmGGBrogHZ9Vbc4DOSImY395
	 j1aclJaRRMBQi+DI5+9BQjn37IrDfhg510nq6dZZ12DrT8ZW7Or+6tjULoy3GTjaxV
	 okfXEzdb9BAhenyUlnVuu9coAHNlnzKM3LvBQaOc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Sachin P Bappalige <sachinpb@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 272/676] powerpc/fadump: Move fadump_cma_init to setup_arch() after initmem_init()
Date: Fri,  6 Dec 2024 15:31:31 +0100
Message-ID: <20241206143703.964864320@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

[ Upstream commit 05b94cae1c47f94588c3e7096963c1007c4d9c1d ]

During early init CMA_MIN_ALIGNMENT_BYTES can be PAGE_SIZE,
since pageblock_order is still zero and it gets initialized
later during initmem_init() e.g.
setup_arch() -> initmem_init() -> sparse_init() -> set_pageblock_order()

One such use case where this causes issue is -
early_setup() -> early_init_devtree() -> fadump_reserve_mem() -> fadump_cma_init()

This causes CMA memory alignment check to be bypassed in
cma_init_reserved_mem(). Then later cma_activate_area() can hit
a VM_BUG_ON_PAGE(pfn & ((1 << order) - 1)) if the reserved memory
area was not pageblock_order aligned.

Fix it by moving the fadump_cma_init() after initmem_init(),
where other such cma reservations also gets called.

<stack trace>
==============
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10010
flags: 0x13ffff800000000(node=1|zone=0|lastcpupid=0x7ffff) CMA
raw: 013ffff800000000 5deadbeef0000100 5deadbeef0000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: VM_BUG_ON_PAGE(pfn & ((1 << order) - 1))
------------[ cut here ]------------
kernel BUG at mm/page_alloc.c:778!

Call Trace:
__free_one_page+0x57c/0x7b0 (unreliable)
free_pcppages_bulk+0x1a8/0x2c8
free_unref_page_commit+0x3d4/0x4e4
free_unref_page+0x458/0x6d0
init_cma_reserved_pageblock+0x114/0x198
cma_init_reserved_areas+0x270/0x3e0
do_one_initcall+0x80/0x2f8
kernel_init_freeable+0x33c/0x530
kernel_init+0x34/0x26c
ret_from_kernel_user_thread+0x14/0x1c

Fixes: 11ac3e87ce09 ("mm: cma: use pageblock_order as the single alignment")
Suggested-by: David Hildenbrand <david@redhat.com>
Reported-by: Sachin P Bappalige <sachinpb@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://patch.msgid.link/3ae208e48c0d9cefe53d2dc4f593388067405b7d.1729146153.git.ritesh.list@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/fadump.h  | 7 +++++++
 arch/powerpc/kernel/fadump.c       | 6 +-----
 arch/powerpc/kernel/setup-common.c | 6 ++++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 526a6a6473128..daa44b2ef35ad 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -32,4 +32,11 @@ extern int early_init_dt_scan_fw_dump(unsigned long node, const char *uname,
 				      int depth, void *data);
 extern int fadump_reserve_mem(void);
 #endif
+
+#if defined(CONFIG_FA_DUMP) && defined(CONFIG_CMA)
+void fadump_cma_init(void);
+#else
+static inline void fadump_cma_init(void) { }
+#endif
+
 #endif /* _ASM_POWERPC_FADUMP_H */
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 4722a9e606e61..1866bac234000 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -80,7 +80,7 @@ static struct cma *fadump_cma;
  * But for some reason even if it fails we still have the memory reservation
  * with us and we can still continue doing fadump.
  */
-static void __init fadump_cma_init(void)
+void __init fadump_cma_init(void)
 {
 	unsigned long long base, size;
 	int rc;
@@ -124,8 +124,6 @@ static void __init fadump_cma_init(void)
 		(unsigned long)cma_get_base(fadump_cma) >> 20,
 		fw_dump.reserve_dump_area_size);
 }
-#else
-static void __init fadump_cma_init(void) { }
 #endif /* CONFIG_CMA */
 
 /* Scan the Firmware Assisted dump configuration details. */
@@ -642,8 +640,6 @@ int __init fadump_reserve_mem(void)
 
 		pr_info("Reserved %lldMB of memory at %#016llx (System RAM: %lldMB)\n",
 			(size >> 20), base, (memblock_phys_mem_size() >> 20));
-
-		fadump_cma_init();
 	}
 
 	return ret;
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 03eaad5949f14..d43db8150767b 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -988,9 +988,11 @@ void __init setup_arch(char **cmdline_p)
 	initmem_init();
 
 	/*
-	 * Reserve large chunks of memory for use by CMA for KVM and hugetlb. These must
-	 * be called after initmem_init(), so that pageblock_order is initialised.
+	 * Reserve large chunks of memory for use by CMA for fadump, KVM and
+	 * hugetlb. These must be called after initmem_init(), so that
+	 * pageblock_order is initialised.
 	 */
+	fadump_cma_init();
 	kvm_cma_reserve();
 	gigantic_hugetlb_cma_reserve();
 
-- 
2.43.0




