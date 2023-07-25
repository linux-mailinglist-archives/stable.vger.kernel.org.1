Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C62C761558
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjGYL2T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbjGYL1w (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:27:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCEBE1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:27:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 703FB61691
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803D5C433C8;
        Tue, 25 Jul 2023 11:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284469;
        bh=N+uZkkjdDi5XwF6oJ0mFAZ3NyLa9VcUF7QTU3049rNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S2+CDY0oxQnZj943Sw435TFfNDhJrkAwmvCQqNn7DCymurLOjwUQrn90mDf3h2I6C
         JLATObVEd5lJMTT5FVcwVxcoSyFvy0NpfzQhiaJqAJHYmc1uKLjcrKSce/eGV8ytyJ
         7+a7+BJbwB7NEbYPJRvQDhyoxRZfYlsSBtvZCHNs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 367/509] riscv, bpf: Fix inconsistent JIT image generation
Date:   Tue, 25 Jul 2023 12:45:06 +0200
Message-ID: <20230725104610.523714473@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

[ Upstream commit c56fb2aab23505bb7160d06097c8de100b82b851 ]

In order to generate the prologue and epilogue, the BPF JIT needs to
know which registers that are clobbered. Therefore, the during
pre-final passes, the prologue is generated after the body of the
program body-prologue-epilogue. Then, in the final pass, a proper
prologue-body-epilogue JITted image is generated.

This scheme has worked most of the time. However, for some large
programs with many jumps, e.g. the test_kmod.sh BPF selftest with
hardening enabled (blinding constants), this has shown to be
incorrect. For the final pass, when the proper prologue-body-epilogue
is generated, the image has not converged. This will lead to that the
final image will have incorrect jump offsets. The following is an
excerpt from an incorrect image:

  | ...
  |     3b8:       00c50663                beq     a0,a2,3c4 <.text+0x3c4>
  |     3bc:       0020e317                auipc   t1,0x20e
  |     3c0:       49630067                jalr    zero,1174(t1) # 20e852 <.text+0x20e852>
  | ...
  |  20e84c:       8796                    c.mv    a5,t0
  |  20e84e:       6422                    c.ldsp  s0,8(sp)    # Epilogue start
  |  20e850:       6141                    c.addi16sp      sp,16
  |  20e852:       853e                    c.mv    a0,a5       # Incorrect jump target
  |  20e854:       8082                    c.jr    ra

The image has shrunk, and the epilogue offset is incorrect in the
final pass.

Correct the problem by always generating proper prologue-body-epilogue
outputs, which means that the first pass will only generate the body
to track what registers that are touched.

Fixes: 2353ecc6f91f ("bpf, riscv: add BPF JIT for RV64G")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20230710074131.19596-1-bjorn@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/net/bpf_jit.h      |  6 +++---
 arch/riscv/net/bpf_jit_core.c | 19 +++++++++++++------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index ab0cd6d10ccf3..ef336fe160044 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -69,7 +69,7 @@ struct rv_jit_context {
 	struct bpf_prog *prog;
 	u16 *insns;		/* RV insns */
 	int ninsns;
-	int body_len;
+	int prologue_len;
 	int epilogue_offset;
 	int *offset;		/* BPF to RV */
 	unsigned long flags;
@@ -215,8 +215,8 @@ static inline int rv_offset(int insn, int off, struct rv_jit_context *ctx)
 	int from, to;
 
 	off++; /* BPF branch is from PC+1, RV is from PC */
-	from = (insn > 0) ? ctx->offset[insn - 1] : 0;
-	to = (insn + off > 0) ? ctx->offset[insn + off - 1] : 0;
+	from = (insn > 0) ? ctx->offset[insn - 1] : ctx->prologue_len;
+	to = (insn + off > 0) ? ctx->offset[insn + off - 1] : ctx->prologue_len;
 	return ninsns_rvoff(to - from);
 }
 
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 750b15c319d5d..ef17bc8055d4c 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -43,7 +43,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
 	bool tmp_blinded = false, extra_pass = false;
 	struct bpf_prog *tmp, *orig_prog = prog;
-	int pass = 0, prev_ninsns = 0, prologue_len, i;
+	int pass = 0, prev_ninsns = 0, i;
 	struct rv_jit_data *jit_data;
 	struct rv_jit_context *ctx;
 	unsigned int image_size = 0;
@@ -83,6 +83,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		prog = orig_prog;
 		goto out_offset;
 	}
+
+	if (build_body(ctx, extra_pass, NULL)) {
+		prog = orig_prog;
+		goto out_offset;
+	}
+
 	for (i = 0; i < prog->len; i++) {
 		prev_ninsns += 32;
 		ctx->offset[i] = prev_ninsns;
@@ -91,12 +97,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	for (i = 0; i < NR_JIT_ITERATIONS; i++) {
 		pass++;
 		ctx->ninsns = 0;
+
+		bpf_jit_build_prologue(ctx);
+		ctx->prologue_len = ctx->ninsns;
+
 		if (build_body(ctx, extra_pass, ctx->offset)) {
 			prog = orig_prog;
 			goto out_offset;
 		}
-		ctx->body_len = ctx->ninsns;
-		bpf_jit_build_prologue(ctx);
+
 		ctx->epilogue_offset = ctx->ninsns;
 		bpf_jit_build_epilogue(ctx);
 
@@ -155,10 +164,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	if (!prog->is_func || extra_pass) {
 		bpf_jit_binary_lock_ro(jit_data->header);
-		prologue_len = ctx->epilogue_offset - ctx->body_len;
 		for (i = 0; i < prog->len; i++)
-			ctx->offset[i] = ninsns_rvoff(prologue_len +
-						      ctx->offset[i]);
+			ctx->offset[i] = ninsns_rvoff(ctx->offset[i]);
 		bpf_prog_fill_jited_linfo(prog, ctx->offset);
 out_offset:
 		kfree(ctx->offset);
-- 
2.39.2



