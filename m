Return-Path: <stable+bounces-99536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9D79E7223
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D077286691
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AF053A7;
	Fri,  6 Dec 2024 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2PHFU6Tu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A9E148832;
	Fri,  6 Dec 2024 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497506; cv=none; b=oBK9B6Rmr0/Jy8IvUOD6hA8YpvNBTSgrSBusCjbcc7Eo+abqb8iH4280g6IXSlalcSW73zWuNAebbGG8Iep/XTvmf2aZwuZ726JbLz71RW//8HFifoKqtEC1GhyGon9Q+3sIGxQraiQza+12cxBgLBIqfQRPZBHa2bp9hk7nZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497506; c=relaxed/simple;
	bh=i9PuDt76cJW56LhkFQ2gomzp2DwDplIbLilKlk5TV2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5cOJUSBoGF0TAHEFdOM1VG9JnDhRM/RCNXQCg/Z0kEo0N9jmeGAZ84M/THXbMRAI9bwDmrPZ5rz9rOjPAR+AtcO6jx8jHKPTz/vk4+XlcaND/TUM8yP+X213QI0oTJoMsEW82ve9qYpqrcaz2E/OujGJMXw99M9O+lVZBIlZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2PHFU6Tu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EB9C4CED1;
	Fri,  6 Dec 2024 15:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497506;
	bh=i9PuDt76cJW56LhkFQ2gomzp2DwDplIbLilKlk5TV2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2PHFU6TuL6HTs4DuW/DyzrGbUQtNKnDFKG1GCSQeki/YQGYxbIioM6yiJNdiMQoLr
	 sut7OsKorWFmub1hTjjRfjuWe/pQdRWJmOp+nP1Vqpm9lGtphuQc1FBmb6A/fWXzmY
	 eI4TvwhB9uo6DSYN9kEGoSxgUkVItmhlkup3E8S0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Kai Huang <kai.huang@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 309/676] x86/tdx: Pass TDCALL/SEAMCALL input/output registers via a structure
Date: Fri,  6 Dec 2024 15:32:08 +0100
Message-ID: <20241206143705.410061361@linuxfoundation.org>
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

[ Upstream commit 57a420bb8186d1d0178b857e5dd5026093641654 ]

Currently, the TDX_MODULE_CALL asm macro, which handles both TDCALL and
SEAMCALL, takes one parameter for each input register and an optional
'struct tdx_module_output' (a collection of output registers) as output.
This is different from the TDX_HYPERCALL macro which uses a single
'struct tdx_hypercall_args' to carry all input/output registers.

The newer TDX versions introduce more TDCALLs/SEAMCALLs which use more
input/output registers.  Also, the TDH.VP.ENTER (which isn't covered
by the current TDX_MODULE_CALL macro) basically can use all registers
that the TDX_HYPERCALL does.  The current TDX_MODULE_CALL macro isn't
extendible to cover those cases.

Similar to the TDX_HYPERCALL macro, simplify the TDX_MODULE_CALL macro
to use a single structure 'struct tdx_module_args' to carry all the
input/output registers.  Currently, R10/R11 are only used as output
register but not as input by any TDCALL/SEAMCALL.  Change to also use
R10/R11 as input register to make input/output registers symmetric.

Currently, the TDX_MODULE_CALL macro depends on the caller to pass a
non-NULL 'struct tdx_module_output' to get additional output registers.
Similar to the TDX_HYPERCALL macro, change the TDX_MODULE_CALL macro to
take a new 'ret' macro argument to indicate whether to save the output
registers to the 'struct tdx_module_args'.  Also introduce a new
__tdcall_ret() for that purpose, similar to the __tdx_hypercall_ret().

Note the tdcall(), which is a wrapper of __tdcall(), is called by three
callers: tdx_parse_tdinfo(), tdx_get_ve_info() and tdx_early_init().
The former two need the additional output but the last one doesn't.  For
simplicity, make tdcall() always call __tdcall_ret() to avoid another
"_ret()" wrapper.  The last caller tdx_early_init() isn't performance
critical anyway.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/483616c1762d85eb3a3c3035a7de061cfacf2f14.1692096753.git.kai.huang%40intel.com
Stable-dep-of: f65aa0ad79fc ("x86/tdx: Dynamically disable SEPT violations from causing #VEs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/coco/tdx/tdcall.S        | 47 ++++++---------
 arch/x86/coco/tdx/tdx-shared.c    |  6 +-
 arch/x86/coco/tdx/tdx.c           | 44 +++++++-------
 arch/x86/include/asm/shared/tdx.h |  8 +--
 arch/x86/kernel/asm-offsets.c     | 12 ++--
 arch/x86/virt/vmx/tdx/tdxcall.S   | 95 +++++++++++++------------------
 6 files changed, 95 insertions(+), 117 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 6aebac08f2bfe..56b9cd32895e4 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -43,37 +43,10 @@
  * __tdcall()  - Used by TDX guests to request services from the TDX
  * module (does not include VMM services) using TDCALL instruction.
  *
- * Transforms function call register arguments into the TDCALL register ABI.
- * After TDCALL operation, TDX module output is saved in @out (if it is
- * provided by the user).
- *
- *-------------------------------------------------------------------------
- * TDCALL ABI:
- *-------------------------------------------------------------------------
- * Input Registers:
- *
- * RAX                 - TDCALL Leaf number.
- * RCX,RDX,R8-R9       - TDCALL Leaf specific input registers.
- *
- * Output Registers:
- *
- * RAX                 - TDCALL instruction error code.
- * RCX,RDX,R8-R11      - TDCALL Leaf specific output registers.
- *
- *-------------------------------------------------------------------------
- *
  * __tdcall() function ABI:
  *
- * @fn  (RDI)          - TDCALL Leaf ID,    moved to RAX
- * @rcx (RSI)          - Input parameter 1, moved to RCX
- * @rdx (RDX)          - Input parameter 2, moved to RDX
- * @r8  (RCX)          - Input parameter 3, moved to R8
- * @r9  (R8)           - Input parameter 4, moved to R9
- *
- * @out (R9)           - struct tdx_module_output pointer
- *                       stored temporarily in R12 (not
- *                       shared with the TDX module). It
- *                       can be NULL.
+ * @fn   (RDI)	- TDCALL Leaf ID, moved to RAX
+ * @args (RSI)	- struct tdx_module_args for input
  *
  * Return status of TDCALL via RAX.
  */
@@ -81,6 +54,22 @@ SYM_FUNC_START(__tdcall)
 	TDX_MODULE_CALL host=0
 SYM_FUNC_END(__tdcall)
 
+/*
+ * __tdcall_ret() - Used by TDX guests to request services from the TDX
+ * module (does not include VMM services) using TDCALL instruction, with
+ * saving output registers to the 'struct tdx_module_args' used as input.
+ *
+ * __tdcall_ret() function ABI:
+ *
+ * @fn   (RDI)	- TDCALL Leaf ID, moved to RAX
+ * @args (RSI)	- struct tdx_module_args for input and output
+ *
+ * Return status of TDCALL via RAX.
+ */
+SYM_FUNC_START(__tdcall_ret)
+	TDX_MODULE_CALL host=0 ret=1
+SYM_FUNC_END(__tdcall_ret)
+
 /*
  * TDX_HYPERCALL - Make hypercalls to a TDX VMM using TDVMCALL leaf of TDCALL
  * instruction
diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
index 90631abdac34d..a7396d0ddef9e 100644
--- a/arch/x86/coco/tdx/tdx-shared.c
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -5,7 +5,7 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 				    enum pg_level pg_level)
 {
 	unsigned long accept_size = page_level_size(pg_level);
-	u64 tdcall_rcx;
+	struct tdx_module_args args = {};
 	u8 page_size;
 
 	if (!IS_ALIGNED(start, accept_size))
@@ -34,8 +34,8 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 		return 0;
 	}
 
-	tdcall_rcx = start | page_size;
-	if (__tdcall(TDG_MEM_PAGE_ACCEPT, tdcall_rcx, 0, 0, 0, NULL))
+	args.rcx = start | page_size;
+	if (__tdcall(TDG_MEM_PAGE_ACCEPT, &args))
 		return 0;
 
 	return accept_size;
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index e37a2464ac7fc..d0d7a42230b84 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -68,10 +68,9 @@ EXPORT_SYMBOL_GPL(tdx_kvm_hypercall);
  * should only be used for calls that have no legitimate reason to fail
  * or where the kernel can not survive the call failing.
  */
-static inline void tdcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
-			  struct tdx_module_output *out)
+static inline void tdcall(u64 fn, struct tdx_module_args *args)
 {
-	if (__tdcall(fn, rcx, rdx, r8, r9, out))
+	if (__tdcall_ret(fn, args))
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
@@ -91,11 +90,14 @@ static inline void tdcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
  */
 int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
 {
+	struct tdx_module_args args = {
+		.rcx = virt_to_phys(tdreport),
+		.rdx = virt_to_phys(reportdata),
+		.r8 = TDREPORT_SUBTYPE_0,
+	};
 	u64 ret;
 
-	ret = __tdcall(TDG_MR_REPORT, virt_to_phys(tdreport),
-			virt_to_phys(reportdata), TDREPORT_SUBTYPE_0,
-			0, NULL);
+	ret = __tdcall(TDG_MR_REPORT, &args);
 	if (ret) {
 		if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
 			return -EINVAL;
@@ -143,7 +145,7 @@ static void __noreturn tdx_panic(const char *msg)
 
 static void tdx_parse_tdinfo(u64 *cc_mask)
 {
-	struct tdx_module_output out;
+	struct tdx_module_args args = {};
 	unsigned int gpa_width;
 	u64 td_attr;
 
@@ -154,7 +156,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	 * Guest-Host-Communication Interface (GHCI), section 2.4.2 TDCALL
 	 * [TDG.VP.INFO].
 	 */
-	tdcall(TDG_VP_INFO, 0, 0, 0, 0, &out);
+	tdcall(TDG_VP_INFO, &args);
 
 	/*
 	 * The highest bit of a guest physical address is the "sharing" bit.
@@ -163,7 +165,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	 * The GPA width that comes out of this call is critical. TDX guests
 	 * can not meaningfully run without it.
 	 */
-	gpa_width = out.rcx & GENMASK(5, 0);
+	gpa_width = args.rcx & GENMASK(5, 0);
 	*cc_mask = BIT_ULL(gpa_width - 1);
 
 	/*
@@ -171,7 +173,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	 * memory.  Ensure that no #VE will be delivered for accesses to
 	 * TD-private memory.  Only VMM-shared memory (MMIO) will #VE.
 	 */
-	td_attr = out.rdx;
+	td_attr = args.rdx;
 	if (!(td_attr & ATTR_SEPT_VE_DISABLE)) {
 		const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
 
@@ -583,7 +585,7 @@ __init bool tdx_early_handle_ve(struct pt_regs *regs)
 
 void tdx_get_ve_info(struct ve_info *ve)
 {
-	struct tdx_module_output out;
+	struct tdx_module_args args = {};
 
 	/*
 	 * Called during #VE handling to retrieve the #VE info from the
@@ -600,15 +602,15 @@ void tdx_get_ve_info(struct ve_info *ve)
 	 * Note, the TDX module treats virtual NMIs as inhibited if the #VE
 	 * valid flag is set. It means that NMI=>#VE will not result in a #DF.
 	 */
-	tdcall(TDG_VP_VEINFO_GET, 0, 0, 0, 0, &out);
+	tdcall(TDG_VP_VEINFO_GET, &args);
 
 	/* Transfer the output parameters */
-	ve->exit_reason = out.rcx;
-	ve->exit_qual   = out.rdx;
-	ve->gla         = out.r8;
-	ve->gpa         = out.r9;
-	ve->instr_len   = lower_32_bits(out.r10);
-	ve->instr_info  = upper_32_bits(out.r10);
+	ve->exit_reason = args.rcx;
+	ve->exit_qual   = args.rdx;
+	ve->gla         = args.r8;
+	ve->gpa         = args.r9;
+	ve->instr_len   = lower_32_bits(args.r10);
+	ve->instr_info  = upper_32_bits(args.r10);
 }
 
 /*
@@ -765,6 +767,10 @@ static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 
 void __init tdx_early_init(void)
 {
+	struct tdx_module_args args = {
+		.rdx = TDCS_NOTIFY_ENABLES,
+		.r9 = -1ULL,
+	};
 	u64 cc_mask;
 	u32 eax, sig[3];
 
@@ -780,7 +786,7 @@ void __init tdx_early_init(void)
 	cc_set_mask(cc_mask);
 
 	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
-	tdcall(TDG_VM_WR, 0, TDCS_NOTIFY_ENABLES, 0, -1ULL, NULL);
+	tdcall(TDG_VM_WR, &args);
 
 	/*
 	 * All bits above GPA width are reserved and kernel treats shared bit
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 9e3699b751ef2..3606463ebf6fb 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -74,11 +74,11 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
 void __tdx_hypercall_failed(void);
 
 /*
- * Used in __tdx_module_call() to gather the output registers' values of the
+ * Used in __tdcall*() to gather the input/output registers' values of the
  * TDCALL instruction when requesting services from the TDX module. This is a
  * software only structure and not part of the TDX module/VMM ABI
  */
-struct tdx_module_output {
+struct tdx_module_args {
 	u64 rcx;
 	u64 rdx;
 	u64 r8;
@@ -88,8 +88,8 @@ struct tdx_module_output {
 };
 
 /* Used to communicate with the TDX module */
-u64 __tdcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
-	     struct tdx_module_output *out);
+u64 __tdcall(u64 fn, struct tdx_module_args *args);
+u64 __tdcall_ret(u64 fn, struct tdx_module_args *args);
 
 bool tdx_accept_memory(phys_addr_t start, phys_addr_t end);
 
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index dc3576303f1ad..50383bc46dd77 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -68,12 +68,12 @@ static void __used common(void)
 #endif
 
 	BLANK();
-	OFFSET(TDX_MODULE_rcx, tdx_module_output, rcx);
-	OFFSET(TDX_MODULE_rdx, tdx_module_output, rdx);
-	OFFSET(TDX_MODULE_r8,  tdx_module_output, r8);
-	OFFSET(TDX_MODULE_r9,  tdx_module_output, r9);
-	OFFSET(TDX_MODULE_r10, tdx_module_output, r10);
-	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
+	OFFSET(TDX_MODULE_rcx, tdx_module_args, rcx);
+	OFFSET(TDX_MODULE_rdx, tdx_module_args, rdx);
+	OFFSET(TDX_MODULE_r8,  tdx_module_args, r8);
+	OFFSET(TDX_MODULE_r9,  tdx_module_args, r9);
+	OFFSET(TDX_MODULE_r10, tdx_module_args, r10);
+	OFFSET(TDX_MODULE_r11, tdx_module_args, r11);
 
 	BLANK();
 	OFFSET(TDX_HYPERCALL_r8,  tdx_hypercall_args, r8);
diff --git a/arch/x86/virt/vmx/tdx/tdxcall.S b/arch/x86/virt/vmx/tdx/tdxcall.S
index 6bdf6e1379534..e9e19e7d77f81 100644
--- a/arch/x86/virt/vmx/tdx/tdxcall.S
+++ b/arch/x86/virt/vmx/tdx/tdxcall.S
@@ -17,34 +17,35 @@
  *            TDX module and hypercalls to the VMM.
  * SEAMCALL - used by TDX hosts to make requests to the
  *            TDX module.
+ *
+ *-------------------------------------------------------------------------
+ * TDCALL/SEAMCALL ABI:
+ *-------------------------------------------------------------------------
+ * Input Registers:
+ *
+ * RAX                 - TDCALL/SEAMCALL Leaf number.
+ * RCX,RDX,R8-R11      - TDCALL/SEAMCALL Leaf specific input registers.
+ *
+ * Output Registers:
+ *
+ * RAX                 - TDCALL/SEAMCALL instruction error code.
+ * RCX,RDX,R8-R11      - TDCALL/SEAMCALL Leaf specific output registers.
+ *
+ *-------------------------------------------------------------------------
  */
-.macro TDX_MODULE_CALL host:req
+.macro TDX_MODULE_CALL host:req ret=0
 	FRAME_BEGIN
-	/*
-	 * R12 will be used as temporary storage for struct tdx_module_output
-	 * pointer. Since R12-R15 registers are not used by TDCALL/SEAMCALL
-	 * services supported by this function, it can be reused.
-	 */
-
-	/* Callee saved, so preserve it */
-	push %r12
-
-	/*
-	 * Push output pointer to stack.
-	 * After the operation, it will be fetched into R12 register.
-	 */
-	push %r9
 
-	/* Mangle function call ABI into TDCALL/SEAMCALL ABI: */
 	/* Move Leaf ID to RAX */
 	mov %rdi, %rax
-	/* Move input 4 to R9 */
-	mov %r8,  %r9
-	/* Move input 3 to R8 */
-	mov %rcx, %r8
-	/* Move input 1 to RCX */
-	mov %rsi, %rcx
-	/* Leave input param 2 in RDX */
+
+	/* Move other input regs from 'struct tdx_module_args' */
+	movq	TDX_MODULE_rcx(%rsi), %rcx
+	movq	TDX_MODULE_rdx(%rsi), %rdx
+	movq	TDX_MODULE_r8(%rsi),  %r8
+	movq	TDX_MODULE_r9(%rsi),  %r9
+	movq	TDX_MODULE_r10(%rsi), %r10
+	movq	TDX_MODULE_r11(%rsi), %r11
 
 .if \host
 	seamcall
@@ -59,49 +60,31 @@
 	 * This value will never be used as actual SEAMCALL error code as
 	 * it is from the Reserved status code class.
 	 */
-	jc .Lseamcall_vmfailinvalid
+	jc .Lseamcall_vmfailinvalid\@
 .else
 	tdcall
 .endif
 
-	/*
-	 * Fetch output pointer from stack to R12 (It is used
-	 * as temporary storage)
-	 */
-	pop %r12
-
-	/*
-	 * Since this macro can be invoked with NULL as an output pointer,
-	 * check if caller provided an output struct before storing output
-	 * registers.
-	 *
-	 * Update output registers, even if the call failed (RAX != 0).
-	 * Other registers may contain details of the failure.
-	 */
-	test %r12, %r12
-	jz .Lout
-
-	/* Copy result registers to output struct: */
-	movq %rcx, TDX_MODULE_rcx(%r12)
-	movq %rdx, TDX_MODULE_rdx(%r12)
-	movq %r8,  TDX_MODULE_r8(%r12)
-	movq %r9,  TDX_MODULE_r9(%r12)
-	movq %r10, TDX_MODULE_r10(%r12)
-	movq %r11, TDX_MODULE_r11(%r12)
-
-.Lout:
-	/* Restore the state of R12 register */
-	pop %r12
+.if \ret
+	/* Copy output registers to the structure */
+	movq %rcx, TDX_MODULE_rcx(%rsi)
+	movq %rdx, TDX_MODULE_rdx(%rsi)
+	movq %r8,  TDX_MODULE_r8(%rsi)
+	movq %r9,  TDX_MODULE_r9(%rsi)
+	movq %r10, TDX_MODULE_r10(%rsi)
+	movq %r11, TDX_MODULE_r11(%rsi)
+.endif
 
+.if \host
+.Lout\@:
+.endif
 	FRAME_END
 	RET
 
 .if \host
-.Lseamcall_vmfailinvalid:
+.Lseamcall_vmfailinvalid\@:
 	mov $TDX_SEAMCALL_VMFAILINVALID, %rax
-	/* pop the unused output pointer back to %r9 */
-	pop %r9
-	jmp .Lout
+	jmp .Lout\@
 .endif	/* \host */
 
 .endm
-- 
2.43.0




