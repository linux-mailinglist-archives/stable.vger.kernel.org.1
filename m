Return-Path: <stable+bounces-99535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A441C9E7224
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97326188654A
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18071474AF;
	Fri,  6 Dec 2024 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q3YSxWVx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CD913E03A;
	Fri,  6 Dec 2024 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497503; cv=none; b=YsU9IBRzhuZI6mHjBTWfxTnKaOn3QQRrmGTdOwGg+tiSITWcacKcBpiphzKMcBFV30vP78BiHhncHZIw6nNnQiBrzWBTfitc+nPWgDVZeHJ3SgKl7eopb89ZA2mv+8Hp9pc3xfE0wXQc7IU4nbxVIupX0pHE5PDXrDs0FMNVdlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497503; c=relaxed/simple;
	bh=W9FHymcGS3ZCzzdBXJ6kuqcqDSBjBucyQ6gFVbY/t4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIAjMOGSrr69vYWLaO9YN8F6AiujGceSIQmPFb2NKoAoTlOe7awp4DYC+jaL8/ag9WTGNzRaK+YAqHlu/3Ttjs4TZiWXe3CwIRxNrUCb4ZlwxhUarn/xGK5tjoasVzqCQ7n+eMJIl9cxeYn1WHxGbEqdxMrjex6y/MSeLy3LR+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q3YSxWVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902F8C4CED1;
	Fri,  6 Dec 2024 15:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497503;
	bh=W9FHymcGS3ZCzzdBXJ6kuqcqDSBjBucyQ6gFVbY/t4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3YSxWVxE6xWFk5FcO2AwitOeHaHd2wL0ib81R3sHsL7cWK8BFApFonw99u+BDhM6
	 TkCcY1B01RrqZUcSIxOO1LDH5hFVB//m12sHe6zuq4Yj2byZMU4HAhSjZ/vaWNNycQ
	 k1BDXmEOaoX0D05431doXZrC976emqvh1gvvTi0M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kai Huang <kai.huang@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 308/676] x86/tdx: Rename __tdx_module_call() to __tdcall()
Date: Fri,  6 Dec 2024 15:32:07 +0100
Message-ID: <20241206143705.371620209@linuxfoundation.org>
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

From: Kai Huang <kai.huang@intel.com>

[ Upstream commit 5efb96289e581c187af1bc288ce5d26ed6181749 ]

__tdx_module_call() is only used by the TDX guest to issue TDCALL to the
TDX module.  Rename it to __tdcall() to match its behaviour, e.g., it
cannot be used to make host-side SEAMCALL.

Also rename tdx_module_call() which is a wrapper of __tdx_module_call()
to tdcall().

No functional change intended.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/785d20d99fbcd0db8262c94da6423375422d8c75.1692096753.git.kai.huang%40intel.com
Stable-dep-of: f65aa0ad79fc ("x86/tdx: Dynamically disable SEPT violations from causing #VEs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/coco/tdx/tdcall.S        | 10 +++++-----
 arch/x86/coco/tdx/tdx-shared.c    |  2 +-
 arch/x86/coco/tdx/tdx.c           | 18 +++++++++---------
 arch/x86/include/asm/shared/tdx.h |  4 ++--
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index e5d4b7d8ecd4a..6aebac08f2bfe 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -40,8 +40,8 @@
 .section .noinstr.text, "ax"
 
 /*
- * __tdx_module_call()  - Used by TDX guests to request services from
- * the TDX module (does not include VMM services) using TDCALL instruction.
+ * __tdcall()  - Used by TDX guests to request services from the TDX
+ * module (does not include VMM services) using TDCALL instruction.
  *
  * Transforms function call register arguments into the TDCALL register ABI.
  * After TDCALL operation, TDX module output is saved in @out (if it is
@@ -62,7 +62,7 @@
  *
  *-------------------------------------------------------------------------
  *
- * __tdx_module_call() function ABI:
+ * __tdcall() function ABI:
  *
  * @fn  (RDI)          - TDCALL Leaf ID,    moved to RAX
  * @rcx (RSI)          - Input parameter 1, moved to RCX
@@ -77,9 +77,9 @@
  *
  * Return status of TDCALL via RAX.
  */
-SYM_FUNC_START(__tdx_module_call)
+SYM_FUNC_START(__tdcall)
 	TDX_MODULE_CALL host=0
-SYM_FUNC_END(__tdx_module_call)
+SYM_FUNC_END(__tdcall)
 
 /*
  * TDX_HYPERCALL - Make hypercalls to a TDX VMM using TDVMCALL leaf of TDCALL
diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
index f10cd3e4a04ed..90631abdac34d 100644
--- a/arch/x86/coco/tdx/tdx-shared.c
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -35,7 +35,7 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 	}
 
 	tdcall_rcx = start | page_size;
-	if (__tdx_module_call(TDG_MEM_PAGE_ACCEPT, tdcall_rcx, 0, 0, 0, NULL))
+	if (__tdcall(TDG_MEM_PAGE_ACCEPT, tdcall_rcx, 0, 0, 0, NULL))
 		return 0;
 
 	return accept_size;
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index fd389b137fab8..e37a2464ac7fc 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -68,10 +68,10 @@ EXPORT_SYMBOL_GPL(tdx_kvm_hypercall);
  * should only be used for calls that have no legitimate reason to fail
  * or where the kernel can not survive the call failing.
  */
-static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
-				   struct tdx_module_output *out)
+static inline void tdcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+			  struct tdx_module_output *out)
 {
-	if (__tdx_module_call(fn, rcx, rdx, r8, r9, out))
+	if (__tdcall(fn, rcx, rdx, r8, r9, out))
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
@@ -93,9 +93,9 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
 {
 	u64 ret;
 
-	ret = __tdx_module_call(TDG_MR_REPORT, virt_to_phys(tdreport),
-				virt_to_phys(reportdata), TDREPORT_SUBTYPE_0,
-				0, NULL);
+	ret = __tdcall(TDG_MR_REPORT, virt_to_phys(tdreport),
+			virt_to_phys(reportdata), TDREPORT_SUBTYPE_0,
+			0, NULL);
 	if (ret) {
 		if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
 			return -EINVAL;
@@ -154,7 +154,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	 * Guest-Host-Communication Interface (GHCI), section 2.4.2 TDCALL
 	 * [TDG.VP.INFO].
 	 */
-	tdx_module_call(TDG_VP_INFO, 0, 0, 0, 0, &out);
+	tdcall(TDG_VP_INFO, 0, 0, 0, 0, &out);
 
 	/*
 	 * The highest bit of a guest physical address is the "sharing" bit.
@@ -600,7 +600,7 @@ void tdx_get_ve_info(struct ve_info *ve)
 	 * Note, the TDX module treats virtual NMIs as inhibited if the #VE
 	 * valid flag is set. It means that NMI=>#VE will not result in a #DF.
 	 */
-	tdx_module_call(TDG_VP_VEINFO_GET, 0, 0, 0, 0, &out);
+	tdcall(TDG_VP_VEINFO_GET, 0, 0, 0, 0, &out);
 
 	/* Transfer the output parameters */
 	ve->exit_reason = out.rcx;
@@ -780,7 +780,7 @@ void __init tdx_early_init(void)
 	cc_set_mask(cc_mask);
 
 	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
-	tdx_module_call(TDG_VM_WR, 0, TDCS_NOTIFY_ENABLES, 0, -1ULL, NULL);
+	tdcall(TDG_VM_WR, 0, TDCS_NOTIFY_ENABLES, 0, -1ULL, NULL);
 
 	/*
 	 * All bits above GPA width are reserved and kernel treats shared bit
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 78f109446da6f..9e3699b751ef2 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -88,8 +88,8 @@ struct tdx_module_output {
 };
 
 /* Used to communicate with the TDX module */
-u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
-		      struct tdx_module_output *out);
+u64 __tdcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+	     struct tdx_module_output *out);
 
 bool tdx_accept_memory(phys_addr_t start, phys_addr_t end);
 
-- 
2.43.0




