Return-Path: <stable+bounces-1037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4307F7DB2
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA43B21796
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7392839FF8;
	Fri, 24 Nov 2023 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M3YUJLRJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3075E381DE;
	Fri, 24 Nov 2023 18:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF694C433C8;
	Fri, 24 Nov 2023 18:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850402;
	bh=9RIIssfQcPCn93qhVdn7/W0Ch6vmjUyqyWxeg9LEHJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M3YUJLRJGRiAf+3oJoLFcHHDVlv6lcUUuAvlNbSSHWn5+folXjSQKfQ5j7abBo5Bs
	 798GEXT0toFTknXfxpwAuHYDsQANfr/xdyZBaoC/6wFEccgTj3zdilgiWIITdqK6sw
	 tWs/xI0QNxKcJioVFtB6lGfzDkaOAYNDBVTgpCtM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 035/491] bpf: Ensure proper register state printing for cond jumps
Date: Fri, 24 Nov 2023 17:44:31 +0000
Message-ID: <20231124172025.752420912@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 1a8a315f008a58f54fecb012b928aa6a494435b3 ]

Verifier emits relevant register state involved in any given instruction
next to it after `;` to the right, if possible. Or, worst case, on the
separate line repeating instruction index.

E.g., a nice and simple case would be:

  2: (d5) if r0 s<= 0x0 goto pc+1       ; R0_w=0

But if there is some intervening extra output (e.g., precision
backtracking log) involved, we are supposed to see the state after the
precision backtrack log:

  4: (75) if r0 s>= 0x0 goto pc+1
  mark_precise: frame0: last_idx 4 first_idx 0 subseq_idx -1
  mark_precise: frame0: regs=r0 stack= before 2: (d5) if r0 s<= 0x0 goto pc+1
  mark_precise: frame0: regs=r0 stack= before 1: (b7) r0 = 0
  6: R0_w=0

First off, note that in `6: R0_w=0` instruction index corresponds to the
next instruction, not to the conditional jump instruction itself, which
is wrong and we'll get to that.

But besides that, the above is a happy case that does work today. Yet,
if it so happens that precision backtracking had to traverse some of the
parent states, this `6: R0_w=0` state output would be missing.

This is due to a quirk of print_verifier_state() routine, which performs
mark_verifier_state_clean(env) at the end. This marks all registers as
"non-scratched", which means that subsequent logic to print *relevant*
registers (that is, "scratched ones") fails and doesn't see anything
relevant to print and skips the output altogether.

print_verifier_state() is used both to print instruction context, but
also to print an **entire** verifier state indiscriminately, e.g.,
during precision backtracking (and in a few other situations, like
during entering or exiting subprogram).  Which means if we have to print
entire parent state before getting to printing instruction context
state, instruction context is marked as clean and is omitted.

Long story short, this is definitely not intentional. So we fix this
behavior in this patch by teaching print_verifier_state() to clear
scratch state only if it was used to print instruction state, not the
parent/callback state. This is determined by print_all option, so if
it's not set, we don't clear scratch state. This fixes missing
instruction state for these cases.

As for the mismatched instruction index, we fix that by making sure we
call print_insn_state() early inside check_cond_jmp_op() before we
adjusted insn_idx based on jump branch taken logic. And with that we get
desired correct information:

  9: (16) if w4 == 0x1 goto pc+9
  mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1
  mark_precise: frame0: parent state regs=r4 stack=: R2_w=1944 R4_rw=P1 R10=fp0
  mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx 9
  mark_precise: frame0: regs=r4 stack= before 8: (66) if w4 s> 0x3 goto pc+5
  mark_precise: frame0: regs=r4 stack= before 7: (b7) r4 = 1
  9: R4=1

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/bpf/20231011223728.3188086-6-andrii@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e7e2687c35884..c3b6f282128bf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1513,7 +1513,8 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 	if (state->in_async_callback_fn)
 		verbose(env, " async_cb");
 	verbose(env, "\n");
-	mark_verifier_state_clean(env);
+	if (!print_all)
+		mark_verifier_state_clean(env);
 }
 
 static inline u32 vlog_alignment(u32 pos)
@@ -13915,6 +13916,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		    !sanitize_speculative_path(env, insn, *insn_idx + 1,
 					       *insn_idx))
 			return -EFAULT;
+		if (env->log.level & BPF_LOG_LEVEL)
+			print_insn_state(env, this_branch->frame[this_branch->curframe]);
 		*insn_idx += insn->off;
 		return 0;
 	} else if (pred == 0) {
@@ -13927,6 +13930,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 					       *insn_idx + insn->off + 1,
 					       *insn_idx))
 			return -EFAULT;
+		if (env->log.level & BPF_LOG_LEVEL)
+			print_insn_state(env, this_branch->frame[this_branch->curframe]);
 		return 0;
 	}
 
-- 
2.42.0




