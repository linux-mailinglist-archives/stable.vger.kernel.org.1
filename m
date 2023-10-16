Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1D97CA228
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjJPIqr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjJPIqr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:46:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA28E6
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:46:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B00C433C9;
        Mon, 16 Oct 2023 08:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446004;
        bh=LlUXUdSsse+Wg1JAvsDF09btoc6KsWFJZocEALWkm9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RcUPPAAEOHzCGbx9JVMtiUs7NDpgh1jm/EsnW8OMl2SuDQRPIqZadP97invhqTgsP
         qHVBGrjcDJZfDTzkI7W3taS0nN8my1k84ABh9aDdgaMRP31r8scqygVwGm1x3LMr8z
         atG14EBGfv5F9ikyWYI26o74nKOhDmIO1jpGhFXw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 029/102] riscv, bpf: Sign-extend return values
Date:   Mon, 16 Oct 2023 10:40:28 +0200
Message-ID: <20231016083954.479433491@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Björn Töpel <bjorn@rivosinc.com>

[ Upstream commit 2f1b0d3d733169eb11680bfa97c266ae5e757148 ]

The RISC-V architecture does not expose sub-registers, and hold all
32-bit values in a sign-extended format [1] [2]:

  | The compiler and calling convention maintain an invariant that all
  | 32-bit values are held in a sign-extended format in 64-bit
  | registers. Even 32-bit unsigned integers extend bit 31 into bits
  | 63 through 32. Consequently, conversion between unsigned and
  | signed 32-bit integers is a no-op, as is conversion from a signed
  | 32-bit integer to a signed 64-bit integer.

While BPF, on the other hand, exposes sub-registers, and use
zero-extension (similar to arm64/x86).

This has led to some subtle bugs, where a BPF JITted program has not
sign-extended the a0 register (return value in RISC-V land), passed
the return value up the kernel, e.g.:

  | int from_bpf(void);
  |
  | long foo(void)
  | {
  |    return from_bpf();
  | }

Here, a0 would be 0xffff_ffff, instead of the expected
0xffff_ffff_ffff_ffff.

Internally, the RISC-V JIT uses a5 as a dedicated register for BPF
return values.

Keep a5 zero-extended, but explicitly sign-extend a0 (which is used
outside BPF land). Now that a0 (RISC-V ABI) and a5 (BPF ABI) differs,
a0 is only moved to a5 for non-BPF native calls (BPF_PSEUDO_CALL).

Fixes: 2353ecc6f91f ("bpf, riscv: add BPF JIT for RV64G")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://github.com/riscv/riscv-isa-manual/releases/download/riscv-isa-release-056b6ff-2023-10-02/unpriv-isa-asciidoc.pdf # [2]
Link: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/download/draft-20230929-e5c800e661a53efe3c2678d71a306323b60eb13b/riscv-abi.pdf # [2]
Link: https://lore.kernel.org/bpf/20231004120706.52848-2-bjorn@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/net/bpf_jit_comp64.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 5fc1386bf311d..3f471884816af 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -220,7 +220,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
 	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
 	/* Set return value. */
 	if (!is_tail_call)
-		emit_mv(RV_REG_A0, RV_REG_A5, ctx);
+		emit_addiw(RV_REG_A0, RV_REG_A5, 0, ctx);
 	emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
 		  is_tail_call ? 4 : 0, /* skip TCC init */
 		  ctx);
@@ -875,7 +875,8 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		if (ret)
 			return ret;
 
-		emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
+		if (insn->src_reg != BPF_PSEUDO_CALL)
+			emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
 		break;
 	}
 	/* tail call */
-- 
2.40.1



