Return-Path: <stable+bounces-2253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D887F8366
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B241C2579F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43116381CB;
	Fri, 24 Nov 2023 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FO5jdbBY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048483418E;
	Fri, 24 Nov 2023 19:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C7FC433C7;
	Fri, 24 Nov 2023 19:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853431;
	bh=CQX/moh9lHuCd1SCXoqcqv7vE/Bds3D5c1N777mmH1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FO5jdbBYPNCTt7QW4AKF+Bectjm72HLJoEEKsdx5JLiVQPvXMxIg/6QclNGMPRPS7
	 GfNuCDO5sQQrrQ6P6SUusxL4WWdKSGod4ROCrUQlOgCz3V/v0UCj5vR2vMspH2hL1l
	 vFuP9tqtjhHdvmRD83t+Gg1gnNu3IZSATeS04URE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hao Sun <sunhao.th@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 5.15 159/297] bpf: Fix check_stack_write_fixed_off() to correctly spill imm
Date: Fri, 24 Nov 2023 17:53:21 +0000
Message-ID: <20231124172005.812190802@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hao Sun <sunhao.th@gmail.com>

commit 811c363645b33e6e22658634329e95f383dfc705 upstream.

In check_stack_write_fixed_off(), imm value is cast to u32 before being
spilled to the stack. Therefore, the sign information is lost, and the
range information is incorrect when load from the stack again.

For the following prog:
0: r2 = r10
1: *(u64*)(r2 -40) = -44
2: r0 = *(u64*)(r2 - 40)
3: if r0 s<= 0xa goto +2
4: r0 = 1
5: exit
6: r0  = 0
7: exit

The verifier gives:
func#0 @0
0: R1=ctx(off=0,imm=0) R10=fp0
0: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
1: (7a) *(u64 *)(r2 -40) = -44        ; R2_w=fp0 fp-40_w=4294967252
2: (79) r0 = *(u64 *)(r2 -40)         ; R0_w=4294967252 R2_w=fp0
fp-40_w=4294967252
3: (c5) if r0 s< 0xa goto pc+2
mark_precise: frame0: last_idx 3 first_idx 0 subseq_idx -1
mark_precise: frame0: regs=r0 stack= before 2: (79) r0 = *(u64 *)(r2 -40)
3: R0_w=4294967252
4: (b7) r0 = 1                        ; R0_w=1
5: (95) exit
verification time 7971 usec
stack depth 40
processed 6 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0

So remove the incorrect cast, since imm field is declared as s32, and
__mark_reg_known() takes u64, so imm would be correctly sign extended
by compiler.

Fixes: ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST instruction")
Cc: stable@vger.kernel.org
Signed-off-by: Hao Sun <sunhao.th@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231101-fix-check-stack-write-v3-1-f05c2b1473d5@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2885,7 +2885,7 @@ static int check_stack_write_fixed_off(s
 		   insn->imm != 0 && env->bpf_capable) {
 		struct bpf_reg_state fake_reg = {};
 
-		__mark_reg_known(&fake_reg, (u32)insn->imm);
+		__mark_reg_known(&fake_reg, insn->imm);
 		fake_reg.type = SCALAR_VALUE;
 		save_register_state(state, spi, &fake_reg, size);
 	} else if (reg && is_spillable_regtype(reg->type)) {



