Return-Path: <stable+bounces-59151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B360692EF0A
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 20:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153481F22FFB
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 18:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5743916DEC8;
	Thu, 11 Jul 2024 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL8Z+8ws"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74C38398
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720723428; cv=none; b=VkaCTbLc+oUUj4VncxsYqhS1VoefdI8pBmLqPzmDTX1H4GijG12x3orGefmZ5Oh4/BjQwFD0uhk0xTiL0+rt3Ehdk0xjoLDL4ZKfm5KcodBPoBWJzFmajQMGaEpBjELzBv0KDUH6kCjdph0186htc5NB/6+rL6crY9DsW0RxDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720723428; c=relaxed/simple;
	bh=d8y88nX5Ivi8GGCFx19syRGkTnMMwSUOV3IZ3BjdPf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ksPT1PhkJSZKL8ufEYndEzB8Z0YHjoHe9pa/mgFbZQ72t0ZCCNfNNuGgttri9Eu1FycwmEdvxLQFIGa50eIy84bLhU8jhlgPshbb5Hl3d44DdnYf6lJ4OyM9gg4ykJDfBMXoDnmtrjpzH/1p8k9zM0BL3k4Xuxtqb/0u2UTIHts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OL8Z+8ws; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ea8320d48so958901e87.1
        for <stable@vger.kernel.org>; Thu, 11 Jul 2024 11:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720723423; x=1721328223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3zhClhvpPNqATRYbpd+ioAAzMsjmnnU/sxkMD4kSrFY=;
        b=OL8Z+8wseL2AR9jmpG/5LRzIlbilBQ7hvydBbzbB9bYLP3gaTRF7+SExsbFxI2N44c
         0wEMB4+nIE32Gz0Ay6Ye5oRUNIXVtCyPWkfyaLeafW/9TdlH4fTik5UPE553DfyVVFsM
         6jHJGRivmsG3qyM1mXhTHa57MOIPiHOdVwHyxtBHsDzYT39PCiq5GgJI8MS8M+KjUqpQ
         Mr1xBzwWOOTHq/XKqhyhuV43sgZWVRqqidxFCUvoxZq4MwUa2b7eMj/C4Gog8sr4JQhv
         rF3cEcKxffb1F8PA44ArujrfJLRA9QtGSIEQGEjFmO86hyGUSUUUGIY7/01MZqqw2E01
         A/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720723423; x=1721328223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zhClhvpPNqATRYbpd+ioAAzMsjmnnU/sxkMD4kSrFY=;
        b=fuQsu+XIM2xlB9REGexihV5KoWaQJTNd7XiYAs/9pkQlJl11l7mYmm0ckrHGSiStqY
         /NZhNakXFtmo6etTtryltpHPyLGz9Ep2I50e/7EXMhq1CzX7ilnaJt4IelqEs1anXdk9
         rNuDqoU+rcq/8E+no6pN3iuZJY4H7PLUfa+h/4zZLmq9cW9ler/pSz38bpSE6XRqKNcW
         a32nN1DX9+QS21ZdQejyXy8f4DQumgWm0E7cVCAhVIjsOpPnzGDKCtlAUjzxo149KcKY
         O0oCf1Ex6rlEbVQ2BFBW3UFaqzKPzA9sYo6/FYedIig/M39GxFBeThWcRoci04O0doS5
         FBkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkiDECM03FvKN0FM5buCk2d02XglncwVJQXI9wipLQukbaAJB8NWCLUCBnBH8vCJ2Ypgc6mkn3mKMg2MF3fydtQV6jzR4n
X-Gm-Message-State: AOJu0YzCWnGP+t2VMOqK+zMI61EsyvkvH3sYREz9Q8x/iuA9KkpTQNbf
	+8RN8ExT1vFgpPdVrTQzRXtX1ckgipUUdif63eHVJ+o8XNP/mFcHUogMoX0hdw8=
X-Google-Smtp-Source: AGHT+IHbMJlYu8v+88MiMSLDVisiFNvHk7UjUJGHGFr5mCi+Op3ZfC971tKUgWHZ0npBDesnbus+mw==
X-Received: by 2002:a05:6512:4013:b0:52c:dc06:d4ad with SMTP id 2adb3069b0e04-52ecb7ea46fmr122543e87.6.1720723422969;
        Thu, 11 Jul 2024 11:43:42 -0700 (PDT)
Received: from localhost ([171.25.193.79])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb9061be5sm1020841e87.123.2024.07.11.11.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 11:43:42 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	stable@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH stable 5.10] bpf: Allow reads from uninit stack
Date: Thu, 11 Jul 2024 21:43:21 +0300
Message-ID: <20240711184323.2355017-1-maxtram95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit 6715df8d5d24655b9fd368e904028112b54c7de1 ]

This commits updates the following functions to allow reads from
uninitialized stack locations when env->allow_uninit_stack option is
enabled:
- check_stack_read_fixed_off()
- check_stack_range_initialized(), called from:
  - check_stack_read_var_off()
  - check_helper_mem_access()

Such change allows to relax logic in stacksafe() to treat STACK_MISC
and STACK_INVALID in a same way and make the following stack slot
configurations equivalent:

  |  Cached state    |  Current state   |
  |   stack slot     |   stack slot     |
  |------------------+------------------|
  | STACK_INVALID or | STACK_INVALID or |
  | STACK_MISC       | STACK_SPILL   or |
  |                  | STACK_MISC    or |
  |                  | STACK_ZERO    or |
  |                  | STACK_DYNPTR     |

This leads to significant verification speed gains (see below).

The idea was suggested by Andrii Nakryiko [1] and initial patch was
created by Alexei Starovoitov [2].

Currently the env->allow_uninit_stack is allowed for programs loaded
by users with CAP_PERFMON or CAP_SYS_ADMIN capabilities.

A number of test cases from verifier/*.c were expecting uninitialized
stack access to be an error. These test cases were updated to execute
in unprivileged mode (thus preserving the tests).

The test progs/test_global_func10.c expected "invalid indirect read
from stack" error message because of the access to uninitialized
memory region. This error is no longer possible in privileged mode.
The test is updated to provoke an error "invalid indirect access to
stack" because of access to invalid stack address (such error is not
verified by progs/test_global_func*.c series of tests).

The following tests had to be removed because these can't be made
unprivileged:
- verifier/sock.c:
  - "sk_storage_get(map, skb->sk, &stack_value, 1): partially init
  stack_value"
  BPF_PROG_TYPE_SCHED_CLS programs are not executed in unprivileged mode.
- verifier/var_off.c:
  - "indirect variable-offset stack access, max_off+size > max_initialized"
  - "indirect variable-offset stack access, uninitialized"
  These tests verify that access to uninitialized stack values is
  detected when stack offset is not a constant. However, variable
  stack access is prohibited in unprivileged mode, thus these tests
  are no longer valid.

 * * *

Here is veristat log comparing this patch with current master on a
set of selftest binaries listed in tools/testing/selftests/bpf/veristat.cfg
and cilium BPF binaries (see [3]):

$ ./veristat -e file,prog,states -C -f 'states_pct<-30' master.log current.log
File                        Program                     States (A)  States (B)  States    (DIFF)
--------------------------  --------------------------  ----------  ----------  ----------------
bpf_host.o                  tail_handle_ipv6_from_host         349         244    -105 (-30.09%)
bpf_host.o                  tail_handle_nat_fwd_ipv4          1320         895    -425 (-32.20%)
bpf_lxc.o                   tail_handle_nat_fwd_ipv4          1320         895    -425 (-32.20%)
bpf_sock.o                  cil_sock4_connect                   70          48     -22 (-31.43%)
bpf_sock.o                  cil_sock4_sendmsg                   68          46     -22 (-32.35%)
bpf_xdp.o                   tail_handle_nat_fwd_ipv4          1554         803    -751 (-48.33%)
bpf_xdp.o                   tail_lb_ipv4                      6457        2473   -3984 (-61.70%)
bpf_xdp.o                   tail_lb_ipv6                      7249        3908   -3341 (-46.09%)
pyperf600_bpf_loop.bpf.o    on_event                           287         145    -142 (-49.48%)
strobemeta.bpf.o            on_event                         15915        4772  -11143 (-70.02%)
strobemeta_nounroll2.bpf.o  on_event                         17087        3820  -13267 (-77.64%)
xdp_synproxy_kern.bpf.o     syncookie_tc                     21271        6635  -14636 (-68.81%)
xdp_synproxy_kern.bpf.o     syncookie_xdp                    23122        6024  -17098 (-73.95%)
--------------------------  --------------------------  ----------  ----------  ----------------

Note: I limited selection by states_pct<-30%.

Inspection of differences in pyperf600_bpf_loop behavior shows that
the following patch for the test removes almost all differences:

    - a/tools/testing/selftests/bpf/progs/pyperf.h
    + b/tools/testing/selftests/bpf/progs/pyperf.h
    @ -266,8 +266,8 @ int __on_event(struct bpf_raw_tracepoint_args *ctx)
            }

            if (event->pthread_match || !pidData->use_tls) {
    -               void* frame_ptr;
    -               FrameData frame;
    +               void* frame_ptr = 0;
    +               FrameData frame = {};
                    Symbol sym = {};
                    int cur_cpu = bpf_get_smp_processor_id();

W/o this patch the difference comes from the following pattern
(for different variables):

    static bool get_frame_data(... FrameData *frame ...)
    {
        ...
        bpf_probe_read_user(&frame->f_code, ...);
        if (!frame->f_code)
            return false;
        ...
        bpf_probe_read_user(&frame->co_name, ...);
        if (frame->co_name)
            ...;
    }

    int __on_event(struct bpf_raw_tracepoint_args *ctx)
    {
        FrameData frame;
        ...
        get_frame_data(... &frame ...) // indirectly via a bpf_loop & callback
        ...
    }

    SEC("raw_tracepoint/kfree_skb")
    int on_event(struct bpf_raw_tracepoint_args* ctx)
    {
        ...
        ret |= __on_event(ctx);
        ret |= __on_event(ctx);
        ...
    }

With regards to value `frame->co_name` the following is important:
- Because of the conditional `if (!frame->f_code)` each call to
  __on_event() produces two states, one with `frame->co_name` marked
  as STACK_MISC, another with it as is (and marked STACK_INVALID on a
  first call).
- The call to bpf_probe_read_user() does not mark stack slots
  corresponding to `&frame->co_name` as REG_LIVE_WRITTEN but it marks
  these slots as BPF_MISC, this happens because of the following loop
  in the check_helper_call():

	for (i = 0; i < meta.access_size; i++) {
		err = check_mem_access(env, insn_idx, meta.regno, i, BPF_B,
				       BPF_WRITE, -1, false);
		if (err)
			return err;
	}

  Note the size of the write, it is a one byte write for each byte
  touched by a helper. The BPF_B write does not lead to write marks
  for the target stack slot.
- Which means that w/o this patch when second __on_event() call is
  verified `if (frame->co_name)` will propagate read marks first to a
  stack slot with STACK_MISC marks and second to a stack slot with
  STACK_INVALID marks and these states would be considered different.

[1] https://lore.kernel.org/bpf/CAEf4BzY3e+ZuC6HUa8dCiUovQRg2SzEk7M-dSkqNZyn=xEmnPA@mail.gmail.com/
[2] https://lore.kernel.org/bpf/CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com/
[3] git@github.com:anakryiko/cilium.git

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Co-developed-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20230219200427.606541-2-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
Backporting to address the complexity regression introduced by commit
71f656a50176 ("bpf: Fix to preserve reg parent/live fields when copying
range info"), that affects Cilium built with LLVM 18.

 kernel/bpf/verifier.c                         |  11 +-
 .../selftests/bpf/progs/test_global_func10.c  |  31 +++
 tools/testing/selftests/bpf/verifier/calls.c  |  13 +-
 .../bpf/verifier/helper_access_var_len.c      | 104 ++++++---
 .../testing/selftests/bpf/verifier/int_ptr.c  |   9 +-
 .../selftests/bpf/verifier/search_pruning.c   |  13 +-
 tools/testing/selftests/bpf/verifier/sock.c   |  27 ---
 .../selftests/bpf/verifier/spill_fill.c       | 211 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/var_off.c  |  52 -----
 9 files changed, 342 insertions(+), 129 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func10.c

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ad115ccc2fe0..60db311480d0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2807,6 +2807,8 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 						continue;
 					if (type == STACK_MISC)
 						continue;
+					if (type == STACK_INVALID && env->allow_uninit_stack)
+						continue;
 					verbose(env, "invalid read from stack off %d+%d size %d\n",
 						off, i, size);
 					return -EACCES;
@@ -2844,6 +2846,8 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				continue;
 			if (type == STACK_ZERO)
 				continue;
+			if (type == STACK_INVALID && env->allow_uninit_stack)
+				continue;
 			verbose(env, "invalid read from stack off %d+%d size %d\n",
 				off, i, size);
 			return -EACCES;
@@ -4300,7 +4304,8 @@ static int check_stack_range_initialized(
 		stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
 		if (*stype == STACK_MISC)
 			goto mark;
-		if (*stype == STACK_ZERO) {
+		if ((*stype == STACK_ZERO) ||
+		    (*stype == STACK_INVALID && env->allow_uninit_stack)) {
 			if (clobber) {
 				/* helper can write anything into the stack */
 				*stype = STACK_MISC;
@@ -9492,6 +9497,10 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_INVALID)
 			continue;
 
+		if (env->allow_uninit_stack &&
+		    old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_MISC)
+			continue;
+
 		/* explored stack has more populated slots than current stack
 		 * and these slots were used
 		 */
diff --git a/tools/testing/selftests/bpf/progs/test_global_func10.c b/tools/testing/selftests/bpf/progs/test_global_func10.c
new file mode 100644
index 000000000000..8fba3f3649e2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func10.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct Small {
+	long x;
+};
+
+struct Big {
+	long x;
+	long y;
+};
+
+__noinline int foo(const struct Big *big)
+{
+	if (!big)
+		return 0;
+
+	return bpf_get_prandom_u32() < big->y;
+}
+
+SEC("cgroup_skb/ingress")
+__failure __msg("invalid indirect access to stack")
+int global_func10(struct __sk_buff *skb)
+{
+	const struct Small small = {.x = skb->len };
+
+	return foo((struct Big *)&small) ? 1 : 0;
+}
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index eb888c8479c3..4b0628cd2d03 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1948,19 +1948,22 @@
 	 * that fp-8 stack slot was unused in the fall-through
 	 * branch and will accept the program incorrectly
 	 */
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_1, 2, 2),
+	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
+	BPF_JMP_IMM(BPF_JGT, BPF_REG_0, 2, 2),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_48b = { 6 },
-	.errstr = "invalid indirect read from stack R2 off -8+0 size 8",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_XDP,
+	.fixup_map_hash_48b = { 7 },
+	.errstr_unpriv = "invalid indirect read from stack R2 off -8+0 size 8",
+	.result_unpriv = REJECT,
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"calls: ctx read at start of subprog",
diff --git a/tools/testing/selftests/bpf/verifier/helper_access_var_len.c b/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
index 0ab7f1dfc97a..0e24aa11c457 100644
--- a/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
+++ b/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
@@ -29,19 +29,30 @@
 {
 	"helper access to variable memory: stack, bitwise AND, zero included",
 	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 64),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
+	/* set max stack size */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -128, 0),
+	/* set r3 to a random value */
+	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
+	/* use bitwise AND to limit r3 range to [0, 64] */
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_3, 64),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -64),
+	BPF_MOV64_IMM(BPF_REG_4, 0),
+	/* Call bpf_ringbuf_output(), it is one of a few helper functions with
+	 * ARG_CONST_SIZE_OR_ZERO parameter allowed in unpriv mode.
+	 * For unpriv this should signal an error, because memory at &fp[-64] is
+	 * not initialized.
+	 */
+	BPF_EMIT_CALL(BPF_FUNC_ringbuf_output),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid indirect read from stack R1 off -64+0 size 64",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.fixup_map_ringbuf = { 4 },
+	.errstr_unpriv = "invalid indirect read from stack R2 off -64+0 size 64",
+	.result_unpriv = REJECT,
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"helper access to variable memory: stack, bitwise AND + JMP, wrong max",
@@ -183,20 +194,31 @@
 {
 	"helper access to variable memory: stack, JMP, no min check",
 	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 64, 3),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
+	/* set max stack size */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -128, 0),
+	/* set r3 to a random value */
+	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
+	/* use JMP to limit r3 range to [0, 64] */
+	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, 64, 6),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -64),
+	BPF_MOV64_IMM(BPF_REG_4, 0),
+	/* Call bpf_ringbuf_output(), it is one of a few helper functions with
+	 * ARG_CONST_SIZE_OR_ZERO parameter allowed in unpriv mode.
+	 * For unpriv this should signal an error, because memory at &fp[-64] is
+	 * not initialized.
+	 */
+	BPF_EMIT_CALL(BPF_FUNC_ringbuf_output),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid indirect read from stack R1 off -64+0 size 64",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.fixup_map_ringbuf = { 4 },
+	.errstr_unpriv = "invalid indirect read from stack R2 off -64+0 size 64",
+	.result_unpriv = REJECT,
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"helper access to variable memory: stack, JMP (signed), no min check",
@@ -564,29 +586,41 @@
 {
 	"helper access to variable memory: 8 bytes leak",
 	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
+	/* set max stack size */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -128, 0),
+	/* set r3 to a random value */
+	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -64),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -64),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -56),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -48),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -40),
+	/* Note: fp[-32] left uninitialized */
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -24),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -128),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 63),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
+	/* Limit r3 range to [1, 64] */
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_3, 63),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 1),
+	BPF_MOV64_IMM(BPF_REG_4, 0),
+	/* Call bpf_ringbuf_output(), it is one of a few helper functions with
+	 * ARG_CONST_SIZE_OR_ZERO parameter allowed in unpriv mode.
+	 * For unpriv this should signal an error, because memory region [1, 64]
+	 * at &fp[-64] is not fully initialized.
+	 */
+	BPF_EMIT_CALL(BPF_FUNC_ringbuf_output),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid indirect read from stack R1 off -64+32 size 64",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.fixup_map_ringbuf = { 3 },
+	.errstr_unpriv = "invalid indirect read from stack R2 off -64+32 size 64",
+	.result_unpriv = REJECT,
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"helper access to variable memory: 8 bytes no leak (init memory)",
diff --git a/tools/testing/selftests/bpf/verifier/int_ptr.c b/tools/testing/selftests/bpf/verifier/int_ptr.c
index 070893fb2900..02d9e004260b 100644
--- a/tools/testing/selftests/bpf/verifier/int_ptr.c
+++ b/tools/testing/selftests/bpf/verifier/int_ptr.c
@@ -54,12 +54,13 @@
 		/* bpf_strtoul() */
 		BPF_EMIT_CALL(BPF_FUNC_strtoul),
 
-		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	},
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL,
-	.errstr = "invalid indirect read from stack R4 off -16+4 size 8",
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "invalid indirect read from stack R4 off -16+4 size 8",
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"ARG_PTR_TO_LONG misaligned",
diff --git a/tools/testing/selftests/bpf/verifier/search_pruning.c b/tools/testing/selftests/bpf/verifier/search_pruning.c
index 7e36078f8f48..949cbe460248 100644
--- a/tools/testing/selftests/bpf/verifier/search_pruning.c
+++ b/tools/testing/selftests/bpf/verifier/search_pruning.c
@@ -128,9 +128,10 @@
 		BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 3 },
-	.errstr = "invalid read from stack off -16+0 size 8",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.errstr_unpriv = "invalid read from stack off -16+0 size 8",
+	.result_unpriv = REJECT,
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"allocated_stack",
@@ -187,6 +188,8 @@
 	BPF_EXIT_INSN(),
 	},
 	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr = "invalid read from stack off -8+1 size 8",
-	.result = REJECT,
+	.errstr_unpriv = "invalid read from stack off -8+1 size 8",
+	.result_unpriv = REJECT,
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
diff --git a/tools/testing/selftests/bpf/verifier/sock.c b/tools/testing/selftests/bpf/verifier/sock.c
index 8c224eac93df..59d976d22867 100644
--- a/tools/testing/selftests/bpf/verifier/sock.c
+++ b/tools/testing/selftests/bpf/verifier/sock.c
@@ -530,33 +530,6 @@
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = ACCEPT,
 },
-{
-	"sk_storage_get(map, skb->sk, &stack_value, 1): partially init stack_value",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_2, -8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_4, 1),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -8),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_storage_get),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_sk_storage_map = { 14 },
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = REJECT,
-	.errstr = "invalid indirect read from stack",
-},
 {
 	"bpf_map_lookup_elem(smap, &key)",
 	.insns = {
diff --git a/tools/testing/selftests/bpf/verifier/spill_fill.c b/tools/testing/selftests/bpf/verifier/spill_fill.c
index 0b943897aaf6..1e76841b7bfa 100644
--- a/tools/testing/selftests/bpf/verifier/spill_fill.c
+++ b/tools/testing/selftests/bpf/verifier/spill_fill.c
@@ -104,3 +104,214 @@
 	.result = ACCEPT,
 	.retval = POINTER_VALUE,
 },
+{
+	"Spill and refill a u32 const scalar.  Offset to skb->data",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	/* r4 = 20 */
+	BPF_MOV32_IMM(BPF_REG_4, 20),
+	/* *(u32 *)(r10 -8) = r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* r4 = *(u32 *)(r10 -8) */
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_10, -8),
+	/* r0 = r2 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=20 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
+	/* if (r0 > r3) R0=pkt,off=20 R2=pkt R3=pkt_end R4=20 */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	/* r0 = *(u32 *)r2 R0=pkt,off=20,r=20 R2=pkt,r=20 R3=pkt_end R4=20 */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
+{
+	"Spill a u32 const, refill from another half of the uninit u32 from the stack",
+	.insns = {
+	/* r4 = 20 */
+	BPF_MOV32_IMM(BPF_REG_4, 20),
+	/* *(u32 *)(r10 -8) = r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* r4 = *(u32 *)(r10 -4) fp-8=????rrrr*/
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_10, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "invalid read from stack off -4+0 size 4",
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
+},
+{
+	"Spill a u32 const scalar.  Refill as u16.  Offset to skb->data",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	/* r4 = 20 */
+	BPF_MOV32_IMM(BPF_REG_4, 20),
+	/* *(u32 *)(r10 -8) = r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* r4 = *(u16 *)(r10 -8) */
+	BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_10, -8),
+	/* r0 = r2 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
+	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "invalid access to packet",
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
+{
+	"Spill u32 const scalars.  Refill as u64.  Offset to skb->data",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	/* r6 = 0 */
+	BPF_MOV32_IMM(BPF_REG_6, 0),
+	/* r7 = 20 */
+	BPF_MOV32_IMM(BPF_REG_7, 20),
+	/* *(u32 *)(r10 -4) = r6 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_6, -4),
+	/* *(u32 *)(r10 -8) = r7 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_7, -8),
+	/* r4 = *(u64 *)(r10 -8) */
+	BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_10, -8),
+	/* r0 = r2 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
+	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "invalid access to packet",
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
+{
+	"Spill a u32 const scalar.  Refill as u16 from fp-6.  Offset to skb->data",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	/* r4 = 20 */
+	BPF_MOV32_IMM(BPF_REG_4, 20),
+	/* *(u32 *)(r10 -8) = r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* r4 = *(u16 *)(r10 -6) */
+	BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_10, -6),
+	/* r0 = r2 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
+	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "invalid access to packet",
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
+{
+	"Spill and refill a u32 const scalar at non 8byte aligned stack addr.  Offset to skb->data",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	/* r4 = 20 */
+	BPF_MOV32_IMM(BPF_REG_4, 20),
+	/* *(u32 *)(r10 -8) = r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* *(u32 *)(r10 -4) = r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -4),
+	/* r4 = *(u32 *)(r10 -4),  */
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_10, -4),
+	/* r0 = r2 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=U32_MAX */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
+	/* if (r0 > r3) R0=pkt,umax=U32_MAX R2=pkt R3=pkt_end R4= */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	/* r0 = *(u32 *)r2 R0=pkt,umax=U32_MAX R2=pkt R3=pkt_end R4= */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "invalid access to packet",
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
+{
+	"Spill and refill a umax=40 bounded scalar.  Offset to skb->data",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_1,
+		    offsetof(struct __sk_buff, tstamp)),
+	BPF_JMP_IMM(BPF_JLE, BPF_REG_4, 40, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* *(u32 *)(r10 -8) = r4 R4=umax=40 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* r4 = (*u32 *)(r10 - 8) */
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_10, -8),
+	/* r2 += r4 R2=pkt R4=umax=40 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_4),
+	/* r0 = r2 R2=pkt,umax=40 R4=umax=40 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	/* r2 += 20 R0=pkt,umax=40 R2=pkt,umax=40 */
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 20),
+	/* if (r2 > r3) R0=pkt,umax=40 R2=pkt,off=20,umax=40 */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_3, 1),
+	/* r0 = *(u32 *)r0 R0=pkt,r=20,umax=40 R2=pkt,off=20,r=20,umax=40 */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
+{
+	"Spill a u32 scalar at fp-4 and then at fp-8",
+	.insns = {
+	/* r4 = 4321 */
+	BPF_MOV32_IMM(BPF_REG_4, 4321),
+	/* *(u32 *)(r10 -4) = r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -4),
+	/* *(u32 *)(r10 -8) = r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* r4 = *(u64 *)(r10 -8) */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
diff --git a/tools/testing/selftests/bpf/verifier/var_off.c b/tools/testing/selftests/bpf/verifier/var_off.c
index eab1f7f56e2f..dc92a29f0d74 100644
--- a/tools/testing/selftests/bpf/verifier/var_off.c
+++ b/tools/testing/selftests/bpf/verifier/var_off.c
@@ -212,31 +212,6 @@
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_LWT_IN,
 },
-{
-	"indirect variable-offset stack access, max_off+size > max_initialized",
-	.insns = {
-	/* Fill only the second from top 8 bytes of the stack. */
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0),
-	/* Get an unknown value. */
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
-	/* Make it small and 4-byte aligned. */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 4),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 16),
-	/* Add it to fp.  We now have either fp-12 or fp-16, but we don't know
-	 * which. fp-12 size 8 is partially uninitialized stack.
-	 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
-	/* Dereference it indirectly. */
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.errstr = "invalid indirect read from stack R2 var_off",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_LWT_IN,
-},
 {
 	"indirect variable-offset stack access, min_off < min_initialized",
 	.insns = {
@@ -289,33 +264,6 @@
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
 },
-{
-	"indirect variable-offset stack access, uninitialized",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 6),
-	BPF_MOV64_IMM(BPF_REG_3, 28),
-	/* Fill the top 16 bytes of the stack. */
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -16, 0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	/* Get an unknown value. */
-	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1, 0),
-	/* Make it small and 4-byte aligned. */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_4, 4),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_4, 16),
-	/* Add it to fp.  We now have either fp-12 or fp-16, we don't know
-	 * which, but either way it points to initialized stack.
-	 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_10),
-	BPF_MOV64_IMM(BPF_REG_5, 8),
-	/* Dereference it indirectly. */
-	BPF_EMIT_CALL(BPF_FUNC_getsockopt),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "invalid indirect read from stack R4 var_off",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SOCK_OPS,
-},
 {
 	"indirect variable-offset stack access, ok",
 	.insns = {
-- 
2.45.2


