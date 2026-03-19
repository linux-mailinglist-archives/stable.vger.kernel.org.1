Return-Path: <stable+bounces-227284-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Lf6LmDxu2nkqQIAu9opvQ
	(envelope-from <stable+bounces-227284-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:51:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 337C72CB5D8
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C9AB301A7FE
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A938C205E02;
	Thu, 19 Mar 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+1xyquC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E937AA76
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773924701; cv=none; b=EBzq46XLFGrIrSj48Ghue0F0WA7Ns5zshB1sL+xr7YAEaa8A4YFkIMaaekiuUu++Ro558+mZYLmywfnK7XqoxH+oY4Gl67I168tv0amG4mLdBa/l9q1rEty+BnkeD6BYM3cePNwMwJ2EiUPEwebofcXp7F63P2/VyCbJleyIrbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773924701; c=relaxed/simple;
	bh=gZC1hlCLRFE/D7mU/zX3/sJnhAKTRqwA8Oy2+M+5hTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sy7pdDnfjrUXmigC1hJgUDAD+NzezGCqATu0jGyo8lSdavRCJO/W9/aEpynS8o48vMPqwx7BTCwiTJ+V8SV1oOwIBHk3McbIml+NdNqi7lrxSRzafzjWhu7ocD6zA5AiS3tl/YlKu9GtfIXKCtiR/sPQBJgHRreTZZKeYz3Jk3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+1xyquC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844AAC19424;
	Thu, 19 Mar 2026 12:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773924701;
	bh=gZC1hlCLRFE/D7mU/zX3/sJnhAKTRqwA8Oy2+M+5hTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C+1xyquCkDuPnwCblYyQDz3xUZuvC/OaUH99sLcWix93BvSrZVGF8eGbW93ypSRgq
	 IXjZrTu1RqkAkf/rdJblWTkvF7NgseIFPBGMElKAZazyL8Fd31orw9G1QARTFn1CAk
	 vHvHcvwQ/H7B10ClGUYxiV3dhyB8ASJbl76WF2ByRcpaawSwsitSBhNbqaRcNmRW4j
	 0zAAUjZB1rCBAPRkbjrvtFWk1N8zddlRGMzEfnh9VQCmwkIojoTkcqj1deX0dpXQze
	 z9nKn9ZavtejgDXG/Gu1t/8KU6wCQD19/07Qw8Ok86/vjMhpwwM/3we6BU1SostYiO
	 5t8swf+ILc1jA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Naveen N Rao <naveen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] powerpc64/bpf: Fold bpf_jit_emit_func_call_hlp() into bpf_jit_emit_func_call_rel()
Date: Thu, 19 Mar 2026 08:51:37 -0400
Message-ID: <20260319125138.2389388-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031723-runner-capable-b815@gregkh>
References: <2026031723-runner-capable-b815@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227284-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 337C72CB5D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naveen N Rao <naveen@kernel.org>

[ Upstream commit 9670f6d2097c4f97e15c67920dfddc664d7ee91c ]

Commit 61688a82e047 ("powerpc/bpf: enable kfunc call") enhanced
bpf_jit_emit_func_call_hlp() to handle calls out to module region, where
bpf progs are generated. The only difference now between
bpf_jit_emit_func_call_hlp() and bpf_jit_emit_func_call_rel() is in
handling of the initial pass where target function address is not known.
Fold that logic into bpf_jit_emit_func_call_hlp() and rename it to
bpf_jit_emit_func_call_rel() to simplify bpf function call JIT code.

We don't actually need to load/restore TOC across a call out to a
different kernel helper or to a different bpf program since they all
work with the kernel TOC. We only need to do it if we have to call out
to a module function. So, guard TOC load/restore with appropriate
conditions.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://patch.msgid.link/20241030070850.1361304-10-hbathini@linux.ibm.com
Stable-dep-of: 01b6ac727296 ("powerpc64/bpf: fix kfunc call support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/net/bpf_jit_comp64.c | 61 +++++++++----------------------
 1 file changed, 17 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 2cbcdf93cc197..f3be024fc6854 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -202,14 +202,22 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
 	EMIT(PPC_RAW_BLR());
 }
 
-static int
-bpf_jit_emit_func_call_hlp(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
+int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
 {
 	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
 	long reladdr;
 
-	if (WARN_ON_ONCE(!kernel_text_address(func_addr)))
-		return -EINVAL;
+	/* bpf to bpf call, func is not known in the initial pass. Emit 5 nops as a placeholder */
+	if (!func) {
+		for (int i = 0; i < 5; i++)
+			EMIT(PPC_RAW_NOP());
+		/* elfv1 needs an additional instruction to load addr from descriptor */
+		if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1))
+			EMIT(PPC_RAW_NOP());
+		EMIT(PPC_RAW_MTCTR(_R12));
+		EMIT(PPC_RAW_BCTRL());
+		return 0;
+	}
 
 #ifdef CONFIG_PPC_KERNEL_PCREL
 	reladdr = func_addr - local_paca->kernelbase;
@@ -266,7 +274,8 @@ bpf_jit_emit_func_call_hlp(u32 *image, u32 *fimage, struct codegen_context *ctx,
 			 * We can clobber r2 since we get called through a
 			 * function pointer (so caller will save/restore r2).
 			 */
-			EMIT(PPC_RAW_LD(_R2, bpf_to_ppc(TMP_REG_2), 8));
+			if (is_module_text_address(func_addr))
+				EMIT(PPC_RAW_LD(_R2, bpf_to_ppc(TMP_REG_2), 8));
 		} else {
 			PPC_LI64(_R12, func);
 			EMIT(PPC_RAW_MTCTR(_R12));
@@ -276,46 +285,14 @@ bpf_jit_emit_func_call_hlp(u32 *image, u32 *fimage, struct codegen_context *ctx,
 		 * Load r2 with kernel TOC as kernel TOC is used if function address falls
 		 * within core kernel text.
 		 */
-		EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)));
+		if (is_module_text_address(func_addr))
+			EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)));
 	}
 #endif
 
 	return 0;
 }
 
-int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
-{
-	unsigned int i, ctx_idx = ctx->idx;
-
-	if (WARN_ON_ONCE(func && is_module_text_address(func)))
-		return -EINVAL;
-
-	/* skip past descriptor if elf v1 */
-	func += FUNCTION_DESCR_SIZE;
-
-	/* Load function address into r12 */
-	PPC_LI64(_R12, func);
-
-	/* For bpf-to-bpf function calls, the callee's address is unknown
-	 * until the last extra pass. As seen above, we use PPC_LI64() to
-	 * load the callee's address, but this may optimize the number of
-	 * instructions required based on the nature of the address.
-	 *
-	 * Since we don't want the number of instructions emitted to increase,
-	 * we pad the optimized PPC_LI64() call with NOPs to guarantee that
-	 * we always have a five-instruction sequence, which is the maximum
-	 * that PPC_LI64() can emit.
-	 */
-	if (!image)
-		for (i = ctx->idx - ctx_idx; i < 5; i++)
-			EMIT(PPC_RAW_NOP());
-
-	EMIT(PPC_RAW_MTCTR(_R12));
-	EMIT(PPC_RAW_BCTRL());
-
-	return 0;
-}
-
 static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 out)
 {
 	/*
@@ -1102,11 +1079,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			if (ret < 0)
 				return ret;
 
-			if (func_addr_fixed)
-				ret = bpf_jit_emit_func_call_hlp(image, fimage, ctx, func_addr);
-			else
-				ret = bpf_jit_emit_func_call_rel(image, fimage, ctx, func_addr);
-
+			ret = bpf_jit_emit_func_call_rel(image, fimage, ctx, func_addr);
 			if (ret)
 				return ret;
 
-- 
2.51.0


