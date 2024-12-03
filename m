Return-Path: <stable+bounces-97574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 112889E2875
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E7C8B63377
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4011F8AC0;
	Tue,  3 Dec 2024 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fxgO6zmm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0BD1F76B0;
	Tue,  3 Dec 2024 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240980; cv=none; b=XiWhX43DoWYxjlTOqsOIU80jjqBWSxH6yR7M6SLY+eXfk5tha2j0Hro65eoXxUZdMaWWMOkwPeWshQPKItiFpLH0oY1FD8XVkr9HzgIeABbVUYlbIbFWrX8vzJOO52LTnScH1cuKihMlLtCjw2XJZDRo0WkfrQTTlr6J6XMT7os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240980; c=relaxed/simple;
	bh=OxeVcH8BrVaT26oWT4vGriqDxVgCf2lVD5TUqmPspFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKgeGYVGXlx6CWoGgIdcJOyB1HeJW0J63e8/AgfcZeD4qsRIkS3uD1nydyl94td/gvWPfiwu7yTg4VTFeY/V3R3LP15UM76oKUwcVwu6WabSFD7X8ONnunIsn/O1wF4fzSlABEFtBZocgxW9eezpYSLBhhkOl8MU53tKgdKqZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fxgO6zmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCB8C4CEE1;
	Tue,  3 Dec 2024 15:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240980;
	bh=OxeVcH8BrVaT26oWT4vGriqDxVgCf2lVD5TUqmPspFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fxgO6zmmhRWe9uhMbJUvNsXTIfwRNWYM2U7lKiM6/M6Nb3Dx6g6pnbEyY7Dq6XqLm
	 yKx8G8LVq/Ud8jn9DYoCuT4Im7+Pv+X/FAGp3GpPoLwspVXt5HcNfE32cW989IS/BV
	 8oE+80Hnph2LJ5StH8vMim59OgEw87ixqOL27PoQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leon Hwang <leon.hwang@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 291/826] bpf, bpftool: Fix incorrect disasm pc
Date: Tue,  3 Dec 2024 15:40:18 +0100
Message-ID: <20241203144755.118300283@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Hwang <leon.hwang@linux.dev>

[ Upstream commit 4d99e509c161f8610de125202c648fa4acd00541 ]

This patch addresses the bpftool issue "Wrong callq address displayed"[0].

The issue stemmed from an incorrect program counter (PC) value used during
disassembly with LLVM or libbfd.

For LLVM: The PC argument must represent the actual address in the kernel
to compute the correct relative address.

For libbfd: The relative address can be adjusted by adding func_ksym within
the custom info->print_address_func to yield the correct address.

Links:
[0] https://github.com/libbpf/bpftool/issues/109

Changes:
v2 -> v3:
  * Address comment from Quentin:
    * Remove the typedef.

v1 -> v2:
  * Fix the broken libbfd disassembler.

Fixes: e1947c750ffe ("bpftool: Refactor disassembler for JIT-ed programs")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Quentin Monnet <qmo@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/bpf/20241031152844.68817-1-leon.hwang@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/jit_disasm.c | 40 ++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index 7b8d9ec89ebd3..c032d2c6ab6d5 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -80,7 +80,8 @@ symbol_lookup_callback(__maybe_unused void *disasm_info,
 static int
 init_context(disasm_ctx_t *ctx, const char *arch,
 	     __maybe_unused const char *disassembler_options,
-	     __maybe_unused unsigned char *image, __maybe_unused ssize_t len)
+	     __maybe_unused unsigned char *image, __maybe_unused ssize_t len,
+	     __maybe_unused __u64 func_ksym)
 {
 	char *triple;
 
@@ -109,12 +110,13 @@ static void destroy_context(disasm_ctx_t *ctx)
 }
 
 static int
-disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len, int pc)
+disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len, int pc,
+		 __u64 func_ksym)
 {
 	char buf[256];
 	int count;
 
-	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, pc,
+	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, func_ksym + pc,
 				      buf, sizeof(buf));
 	if (json_output)
 		printf_json(buf);
@@ -136,8 +138,21 @@ int disasm_init(void)
 #ifdef HAVE_LIBBFD_SUPPORT
 #define DISASM_SPACER "\t"
 
+struct disasm_info {
+	struct disassemble_info info;
+	__u64 func_ksym;
+};
+
+static void disasm_print_addr(bfd_vma addr, struct disassemble_info *info)
+{
+	struct disasm_info *dinfo = container_of(info, struct disasm_info, info);
+
+	addr += dinfo->func_ksym;
+	generic_print_address(addr, info);
+}
+
 typedef struct {
-	struct disassemble_info *info;
+	struct disasm_info *info;
 	disassembler_ftype disassemble;
 	bfd *bfdf;
 } disasm_ctx_t;
@@ -215,7 +230,7 @@ static int fprintf_json_styled(void *out,
 
 static int init_context(disasm_ctx_t *ctx, const char *arch,
 			const char *disassembler_options,
-			unsigned char *image, ssize_t len)
+			unsigned char *image, ssize_t len, __u64 func_ksym)
 {
 	struct disassemble_info *info;
 	char tpath[PATH_MAX];
@@ -238,12 +253,13 @@ static int init_context(disasm_ctx_t *ctx, const char *arch,
 	}
 	bfdf = ctx->bfdf;
 
-	ctx->info = malloc(sizeof(struct disassemble_info));
+	ctx->info = malloc(sizeof(struct disasm_info));
 	if (!ctx->info) {
 		p_err("mem alloc failed");
 		goto err_close;
 	}
-	info = ctx->info;
+	ctx->info->func_ksym = func_ksym;
+	info = &ctx->info->info;
 
 	if (json_output)
 		init_disassemble_info_compat(info, stdout,
@@ -272,6 +288,7 @@ static int init_context(disasm_ctx_t *ctx, const char *arch,
 		info->disassembler_options = disassembler_options;
 	info->buffer = image;
 	info->buffer_length = len;
+	info->print_address_func = disasm_print_addr;
 
 	disassemble_init_for_target(info);
 
@@ -304,9 +321,10 @@ static void destroy_context(disasm_ctx_t *ctx)
 
 static int
 disassemble_insn(disasm_ctx_t *ctx, __maybe_unused unsigned char *image,
-		 __maybe_unused ssize_t len, int pc)
+		 __maybe_unused ssize_t len, int pc,
+		 __maybe_unused __u64 func_ksym)
 {
-	return ctx->disassemble(pc, ctx->info);
+	return ctx->disassemble(pc, &ctx->info->info);
 }
 
 int disasm_init(void)
@@ -331,7 +349,7 @@ int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 	if (!len)
 		return -1;
 
-	if (init_context(&ctx, arch, disassembler_options, image, len))
+	if (init_context(&ctx, arch, disassembler_options, image, len, func_ksym))
 		return -1;
 
 	if (json_output)
@@ -360,7 +378,7 @@ int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 			printf("%4x:" DISASM_SPACER, pc);
 		}
 
-		count = disassemble_insn(&ctx, image, len, pc);
+		count = disassemble_insn(&ctx, image, len, pc, func_ksym);
 
 		if (json_output) {
 			/* Operand array, was started in fprintf_json. Before
-- 
2.43.0




