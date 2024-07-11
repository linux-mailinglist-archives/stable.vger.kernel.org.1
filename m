Return-Path: <stable+bounces-59153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2A492EF0C
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 20:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AAC283D6D
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 18:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD07916E876;
	Thu, 11 Jul 2024 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPt4ANk4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412EB38398
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720723431; cv=none; b=nTJAYOoA7wAAV7Uu58fOxmfxZCu8/LAkOYMOM3D/3eoBML+OyNLx4tFWPjyKT4k3v39DjLvqRRmRR2YW6xzAdTpauuecaHvNAk4kd6PCL4MvpeLkllFW3IlzCHMAjpLqpdohR+SS0AdGmFWEOcVPFh0Y+a5OyHH422dJm36ZOZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720723431; c=relaxed/simple;
	bh=UA4mniQdFmXSfDtO7btIqECMHWbIBNAimwGK6JSMGPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhH0JquBG9ZAYvYWpTtfQzFlKUDtb7zCBzudcjPDrkPIhsc9xGBTg5Uy3520+gUejN4bD3oW1yWo1z/HogiwfIJICaPyuAZ3jCcPankYg0wzm7sDD5tQG5/eWA+9vA4nldHWFQvIM8E55gkG1z/LgxaoGDk0CHNTY7rqLEIkyFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPt4ANk4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42662d80138so7418785e9.1
        for <stable@vger.kernel.org>; Thu, 11 Jul 2024 11:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720723427; x=1721328227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSRQv9kK5BM4l9bADR/LZxF6wo0nZb1+KIiOXFMIB/c=;
        b=bPt4ANk4kVE5Eobn+d51AqRWI9tt06WOpNBzSva+uYuMMp1G6mQpNbFQvFdhyEhycp
         jAgsWtQvi6pY4GloMDVILRU7Bz2kgMfDCAkEvBZW1JALy+h/0z9ySygx48+Hmx0QU0F2
         zVTb8OkWtod1xwwvuc16sWTXljFmtx3rK57RALPLpxbq82YIR2O2uTbQd4umgm9v/y1C
         XBVpF3fB9ZRzHUoSwsKk3n69PE73G2FuKwWt/ea3jo9ZAZ29ZpPobVW1EmMpwz9zRMqf
         yT5IKMzQONcl1zr52l1812iL2iFOdgG3nTdcn7fsmVoDECNJfb3wOAVrl5z5y3TXDwX5
         v3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720723427; x=1721328227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSRQv9kK5BM4l9bADR/LZxF6wo0nZb1+KIiOXFMIB/c=;
        b=TaY0AX99TQ+KriXFujWqP+duKOmV9vdMbVhmN2wsuDzTTH9CRdh/lnP2SqmB8g6L8a
         VLnfEBF0z3rDf5iVfZF6etJx+qyRXgOy3jwiroY2w9yGBUyy16X0pxdjJLdiSOlyXe0U
         5vxs5meJruxg6C/QAs8R9c97bp2XCVjuvun4HDOLyN+vbxnMOufy5/gofByXiXxSpSZj
         YDapdHYw+yscY52CBm/mXEyvPM30xB49OtfKRQwz4HleJnGNmdkI/Bp/7djtcjo/5kYq
         hfFpeuV49nk1etf5ClAgRNBwStrZzzNV5YSnRu0gXGnFui9EIRvVq+G87oKm70RILVGU
         R3Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUEQtg3q7gZlgPPINO2sQWINIGzfROZ8uGrzdPMhxt7Mwov5PLa3x6qBIYXLNwWp+ylMuKKlDLfB+BJPw7vfewAlKjyzQ29
X-Gm-Message-State: AOJu0Yz+wdy/hHK0B9sB+jnBH+8Z59b1f9Fwf+B9oSRPeDZqwCQA2J9i
	ckL66iwWzHwTdhYQ6SkeTKo2XdSqqGMTLvCEIyj2BdH3u/FbnonW
X-Google-Smtp-Source: AGHT+IEmIUgAEUwbTaGPJG5tPqbkrRvYzkmPWzjfk3klSK8vUAqMj6tSKUTmiNAvw2sUZrX7Yy1SIw==
X-Received: by 2002:a05:600c:1d9e:b0:426:61ef:ec36 with SMTP id 5b1f17b1804b1-42670197e61mr75891695e9.0.1720723427423;
        Thu, 11 Jul 2024 11:43:47 -0700 (PDT)
Received: from localhost (algrothendieck.nos-oignons.net. [80.67.172.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-426725597bdsm68122245e9.0.2024.07.11.11.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 11:43:47 -0700 (PDT)
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
Subject: [PATCH stable 6.1] bpf: Allow reads from uninit stack
Date: Thu, 11 Jul 2024 21:43:23 +0300
Message-ID: <20240711184323.2355017-3-maxtram95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711184323.2355017-1-maxtram95@gmail.com>
References: <20240711184323.2355017-1-maxtram95@gmail.com>
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
 .../selftests/bpf/progs/test_global_func10.c  |   9 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  13 ++-
 .../bpf/verifier/helper_access_var_len.c      | 104 ++++++++++++------
 .../testing/selftests/bpf/verifier/int_ptr.c  |   9 +-
 .../selftests/bpf/verifier/search_pruning.c   |  13 ++-
 tools/testing/selftests/bpf/verifier/sock.c   |  27 -----
 .../selftests/bpf/verifier/spill_fill.c       |   7 +-
 .../testing/selftests/bpf/verifier/var_off.c  |  52 ---------
 9 files changed, 109 insertions(+), 136 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 56a5c8beb553..8973d3c9597c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3599,6 +3599,8 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 						continue;
 					if (type == STACK_MISC)
 						continue;
+					if (type == STACK_INVALID && env->allow_uninit_stack)
+						continue;
 					verbose(env, "invalid read from stack off %d+%d size %d\n",
 						off, i, size);
 					return -EACCES;
@@ -3636,6 +3638,8 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				continue;
 			if (type == STACK_ZERO)
 				continue;
+			if (type == STACK_INVALID && env->allow_uninit_stack)
+				continue;
 			verbose(env, "invalid read from stack off %d+%d size %d\n",
 				off, i, size);
 			return -EACCES;
@@ -5426,7 +5430,8 @@ static int check_stack_range_initialized(
 		stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
 		if (*stype == STACK_MISC)
 			goto mark;
-		if (*stype == STACK_ZERO) {
+		if ((*stype == STACK_ZERO) ||
+		    (*stype == STACK_INVALID && env->allow_uninit_stack)) {
 			if (clobber) {
 				/* helper can write anything into the stack */
 				*stype = STACK_MISC;
@@ -11967,6 +11972,10 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
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
index 97b7031d0e22..d361eba167f6 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func10.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func10.c
@@ -4,12 +4,12 @@
 #include <bpf/bpf_helpers.h>
 
 struct Small {
-	int x;
+	long x;
 };
 
 struct Big {
-	int x;
-	int y;
+	long x;
+	long y;
 };
 
 __noinline int foo(const struct Big *big)
@@ -21,7 +21,8 @@ __noinline int foo(const struct Big *big)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("invalid indirect access to stack")
+int global_func10(struct __sk_buff *skb)
 {
 	const struct Small small = {.x = skb->len };
 
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index e1a937277b54..a201d2871bfb 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -2221,19 +2221,22 @@
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
index a6c869a7319c..9c4885885aba 100644
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
index d63fd8991b03..745d6b5842fd 100644
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
 	"precision tracking for u32 spill/fill",
@@ -258,6 +259,8 @@
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
index d11d0b28be41..108dd3ee1edd 100644
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
index e23f07175e1b..53286a7b49aa 100644
--- a/tools/testing/selftests/bpf/verifier/spill_fill.c
+++ b/tools/testing/selftests/bpf/verifier/spill_fill.c
@@ -171,9 +171,10 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.result = REJECT,
-	.errstr = "invalid read from stack off -4+0 size 4",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "invalid read from stack off -4+0 size 4",
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"Spill a u32 const scalar.  Refill as u16.  Offset to skb->data",
diff --git a/tools/testing/selftests/bpf/verifier/var_off.c b/tools/testing/selftests/bpf/verifier/var_off.c
index d37f512fad16..b183e26c03f1 100644
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


