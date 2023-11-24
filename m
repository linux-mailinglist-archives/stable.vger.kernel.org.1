Return-Path: <stable+bounces-1174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB277F7E5E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09161C21386
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAB32D787;
	Fri, 24 Nov 2023 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VXLGPz4N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE52539FEE;
	Fri, 24 Nov 2023 18:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE63C433C7;
	Fri, 24 Nov 2023 18:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850743;
	bh=x+DYHI6gc77kCsAjrzRqIUF/pfPsmSGvfzTzarKCZt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXLGPz4NkJws+N1b5dN7jO1pt5olYvDnf1JieyqUzfU49RVfqBtWzD9kMDSC3AyZa
	 oFAS2D2EhYuKSyvKbXjTctuvIJwbIYT7EsZMFkOMqePfC4bCuJJEdEqsUwj2Z8FvOE
	 pGnv/kZlfw9wgt3MOO1xYGhkQ7ON6RQh4uZ4ccQY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 172/491] bpf: fix precision backtracking instruction iteration
Date: Fri, 24 Nov 2023 17:46:48 +0000
Message-ID: <20231124172029.647701020@linuxfoundation.org>
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

[ Upstream commit 4bb7ea946a370707315ab774432963ce47291946 ]

Fix an edge case in __mark_chain_precision() which prematurely stops
backtracking instructions in a state if it happens that state's first
and last instruction indexes are the same. This situations doesn't
necessarily mean that there were no instructions simulated in a state,
but rather that we starting from the instruction, jumped around a bit,
and then ended up at the same instruction before checkpointing or
marking precision.

To distinguish between these two possible situations, we need to consult
jump history. If it's empty or contain a single record "bridging" parent
state and first instruction of processed state, then we indeed
backtracked all instructions in this state. But if history is not empty,
we are definitely not done yet.

Move this logic inside get_prev_insn_idx() to contain it more nicely.
Use -ENOENT return code to denote "we are out of instructions"
situation.

This bug was exposed by verifier_loop1.c's bounded_recursion subtest, once
the next fix in this patch set is applied.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Fixes: b5dc0163d8fd ("bpf: precise scalar_value tracking")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20231110002638.4168352-3-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cb5621000993e..b8371feabdbdd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3193,12 +3193,29 @@ static int push_jmp_history(struct bpf_verifier_env *env,
 
 /* Backtrack one insn at a time. If idx is not at the top of recorded
  * history then previous instruction came from straight line execution.
+ * Return -ENOENT if we exhausted all instructions within given state.
+ *
+ * It's legal to have a bit of a looping with the same starting and ending
+ * insn index within the same state, e.g.: 3->4->5->3, so just because current
+ * instruction index is the same as state's first_idx doesn't mean we are
+ * done. If there is still some jump history left, we should keep going. We
+ * need to take into account that we might have a jump history between given
+ * state's parent and itself, due to checkpointing. In this case, we'll have
+ * history entry recording a jump from last instruction of parent state and
+ * first instruction of given state.
  */
 static int get_prev_insn_idx(struct bpf_verifier_state *st, int i,
 			     u32 *history)
 {
 	u32 cnt = *history;
 
+	if (i == st->first_insn_idx) {
+		if (cnt == 0)
+			return -ENOENT;
+		if (cnt == 1 && st->jmp_history[0].idx == i)
+			return -ENOENT;
+	}
+
 	if (cnt && st->jmp_history[cnt - 1].idx == i) {
 		i = st->jmp_history[cnt - 1].prev_idx;
 		(*history)--;
@@ -4073,10 +4090,10 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				 * Nothing to be tracked further in the parent state.
 				 */
 				return 0;
-			if (i == first_idx)
-				break;
 			subseq_idx = i;
 			i = get_prev_insn_idx(st, i, &history);
+			if (i == -ENOENT)
+				break;
 			if (i >= env->prog->len) {
 				/* This can happen if backtracking reached insn 0
 				 * and there are still reg_mask or stack_mask
-- 
2.42.0




