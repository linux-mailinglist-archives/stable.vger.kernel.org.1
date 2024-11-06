Return-Path: <stable+bounces-90974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EF69BEBE2
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5371C237D4
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A661F9EAD;
	Wed,  6 Nov 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S950G4H9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AAA1EE036;
	Wed,  6 Nov 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897367; cv=none; b=q0ry4X8+UQOzGc5v4P+8KAuhdUZbOF31vyFwExDJ+i2OMFKuWaq8l4IWP/YFv3SBBPHmPGimn1w7Y68+TqQHzKOyAUbUxbSX0jypCDKNJHH6XOhbS5b43Bo+9S15mVSJU/dsTpVodHTL735YET4UfFL8oWv3pftCbGqW6uvVAD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897367; c=relaxed/simple;
	bh=LfcY5L75qAU9pkv8XXZEsfW9rZUC3fadQDCwAlZkjFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzL4ZPMizEqxzxAGfZPKkPjzY+8zJ5Szyr9RqE/dNPjVxo2JGY+63MnsTDIEyKg4DbgqL5rG6ZGiS9Ra7xYOOxu3lQnrKLnYzx8jS4BDmt1gj+iJSaFlVFmYQ4PYbRxuyOvddo+ppYtT8ENPDItKTB78BlfFvijoOXd8dKBVxpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S950G4H9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2E4C4CECD;
	Wed,  6 Nov 2024 12:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897367;
	bh=LfcY5L75qAU9pkv8XXZEsfW9rZUC3fadQDCwAlZkjFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S950G4H9G1g3VzGdK370JjI9gPU97vIjCVEZCqlf5lNwVdwKwlEIGlnD7+AhGUoF5
	 PiQHFBLW6xLJetKvC9Oed0arX0WKFgr4d24CPHBSH/RExSXuLMPbsEI6hFBB7HV5jO
	 mPWAjGOHV9aKxdfMW6pnxyq0YU14chfKp8TtXgoo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 029/151] bpf: Force checkpoint when jmp history is too long
Date: Wed,  6 Nov 2024 13:03:37 +0100
Message-ID: <20241106120309.639793484@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
References: <20241106120308.841299741@linuxfoundation.org>
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

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit aa30eb3260b2dea3a68d3c42a39f9a09c5e99cee ]

A specifically crafted program might trick verifier into growing very
long jump history within a single bpf_verifier_state instance.
Very long jump history makes mark_chain_precision() unreasonably slow,
especially in case if verifier processes a loop.

Mitigate this by forcing new state in is_state_visited() in case if
current state's jump history is too long.

Use same constant as in `skip_inf_loop_check`, but multiply it by
arbitrarily chosen value 2 to account for jump history containing not
only information about jumps, but also information about stack access.

For an example of problematic program consider the code below,
w/o this patch the example is processed by verifier for ~15 minutes,
before failing to allocate big-enough chunk for jmp_history.

    0: r7 = *(u16 *)(r1 +0);"
    1: r7 += 0x1ab064b9;"
    2: if r7 & 0x702000 goto 1b;
    3: r7 &= 0x1ee60e;"
    4: r7 += r1;"
    5: if r7 s> 0x37d2 goto +0;"
    6: r0 = 0;"
    7: exit;"

Perf profiling shows that most of the time is spent in
mark_chain_precision() ~95%.

The easiest way to explain why this program causes problems is to
apply the following patch:

    diff --git a/include/linux/bpf.h b/include/linux/bpf.h
    index 0c216e71cec7..4b4823961abe 100644
    \--- a/include/linux/bpf.h
    \+++ b/include/linux/bpf.h
    \@@ -1926,7 +1926,7 @@ struct bpf_array {
            };
     };

    -#define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns */
    +#define BPF_COMPLEXITY_LIMIT_INSNS      256 /* yes. 1M insns */
     #define MAX_TAIL_CALL_CNT 33

     /* Maximum number of loops for bpf_loop and bpf_iter_num.
    diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
    index f514247ba8ba..75e88be3bb3e 100644
    \--- a/kernel/bpf/verifier.c
    \+++ b/kernel/bpf/verifier.c
    \@@ -18024,8 +18024,13 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
     skip_inf_loop_check:
                            if (!force_new_state &&
                                env->jmps_processed - env->prev_jmps_processed < 20 &&
    -                           env->insn_processed - env->prev_insn_processed < 100)
    +                           env->insn_processed - env->prev_insn_processed < 100) {
    +                               verbose(env, "is_state_visited: suppressing checkpoint at %d, %d jmps processed, cur->jmp_history_cnt is %d\n",
    +                                       env->insn_idx,
    +                                       env->jmps_processed - env->prev_jmps_processed,
    +                                       cur->jmp_history_cnt);
                                    add_new_state = false;
    +                       }
                            goto miss;
                    }
                    /* If sl->state is a part of a loop and this loop's entry is a part of
    \@@ -18142,6 +18147,9 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
            if (!add_new_state)
                    return 0;

    +       verbose(env, "is_state_visited: new checkpoint at %d, resetting env->jmps_processed\n",
    +               env->insn_idx);
    +
            /* There were no equivalent states, remember the current one.
             * Technically the current state is not proven to be safe yet,
             * but it will either reach outer most bpf_exit (which means it's safe)

And observe verification log:

    ...
    is_state_visited: new checkpoint at 5, resetting env->jmps_processed
    5: R1=ctx() R7=ctx(...)
    5: (65) if r7 s> 0x37d2 goto pc+0     ; R7=ctx(...)
    6: (b7) r0 = 0                        ; R0_w=0
    7: (95) exit

    from 5 to 6: R1=ctx() R7=ctx(...) R10=fp0
    6: R1=ctx() R7=ctx(...) R10=fp0
    6: (b7) r0 = 0                        ; R0_w=0
    7: (95) exit
    is_state_visited: suppressing checkpoint at 1, 3 jmps processed, cur->jmp_history_cnt is 74

    from 2 to 1: R1=ctx() R7_w=scalar(...) R10=fp0
    1: R1=ctx() R7_w=scalar(...) R10=fp0
    1: (07) r7 += 447767737
    is_state_visited: suppressing checkpoint at 2, 3 jmps processed, cur->jmp_history_cnt is 75
    2: R7_w=scalar(...)
    2: (45) if r7 & 0x702000 goto pc-2
    ... mark_precise 152 steps for r7 ...
    2: R7_w=scalar(...)
    is_state_visited: suppressing checkpoint at 1, 4 jmps processed, cur->jmp_history_cnt is 75
    1: (07) r7 += 447767737
    is_state_visited: suppressing checkpoint at 2, 4 jmps processed, cur->jmp_history_cnt is 76
    2: R7_w=scalar(...)
    2: (45) if r7 & 0x702000 goto pc-2
    ...
    BPF program is too large. Processed 257 insn

The log output shows that checkpoint at label (1) is never created,
because it is suppressed by `skip_inf_loop_check` logic:
a. When 'if' at (2) is processed it pushes a state with insn_idx (1)
   onto stack and proceeds to (3);
b. At (5) checkpoint is created, and this resets
   env->{jmps,insns}_processed.
c. Verification proceeds and reaches `exit`;
d. State saved at step (a) is popped from stack and is_state_visited()
   considers if checkpoint needs to be added, but because
   env->{jmps,insns}_processed had been just reset at step (b)
   the `skip_inf_loop_check` logic forces `add_new_state` to false.
e. Verifier proceeds with current state, which slowly accumulates
   more and more entries in the jump history.

The accumulation of entries in the jump history is a problem because
of two factors:
- it eventually exhausts memory available for kmalloc() allocation;
- mark_chain_precision() traverses the jump history of a state,
  meaning that if `r7` is marked precise, verifier would iterate
  ever growing jump history until parent state boundary is reached.

(note: the log also shows a REG INVARIANTS VIOLATION warning
       upon jset processing, but that's another bug to fix).

With this patch applied, the example above is rejected by verifier
under 1s of time, reaching 1M instructions limit.

The program is a simplified reproducer from syzbot report.
Previous discussion could be found at [1].
The patch does not cause any changes in verification performance,
when tested on selftests from veristat.cfg and cilium programs taken
from [2].

[1] https://lore.kernel.org/bpf/20241009021254.2805446-1-eddyz87@gmail.com/
[2] https://github.com/anakryiko/cilium

Changelog:
- v1 -> v2:
  - moved patch to bpf tree;
  - moved force_new_state variable initialization after declaration and
    shortened the comment.
v1: https://lore.kernel.org/bpf/20241018020307.1766906-1-eddyz87@gmail.com/

Fixes: 2589726d12a1 ("bpf: introduce bounded loops")
Reported-by: syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20241029172641.1042523-1-eddyz87@gmail.com

Closes: https://lore.kernel.org/bpf/670429f6.050a0220.49194.0517.GAE@google.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03b5797b8fca9..67eb55a354bcc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16580,9 +16580,11 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	struct bpf_verifier_state_list *sl, **pprev;
 	struct bpf_verifier_state *cur = env->cur_state, *new, *loop_entry;
 	int i, j, n, err, states_cnt = 0;
-	bool force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx);
-	bool add_new_state = force_new_state;
-	bool force_exact;
+	bool force_new_state, add_new_state, force_exact;
+
+	force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx) ||
+			  /* Avoid accumulating infinitely long jmp history */
+			  cur->jmp_history_cnt > 40;
 
 	/* bpf progs typically have pruning point every 4 instructions
 	 * http://vger.kernel.org/bpfconf2019.html#session-1
@@ -16592,6 +16594,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	 * In tests that amounts to up to 50% reduction into total verifier
 	 * memory consumption and 20% verifier time speedup.
 	 */
+	add_new_state = force_new_state;
 	if (env->jmps_processed - env->prev_jmps_processed >= 2 &&
 	    env->insn_processed - env->prev_insn_processed >= 8)
 		add_new_state = true;
-- 
2.43.0




