Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853E2799B65
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 23:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbjIIV0z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 9 Sep 2023 17:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjIIV0y (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 9 Sep 2023 17:26:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC077195
        for <stable@vger.kernel.org>; Sat,  9 Sep 2023 14:26:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0833BC433C8;
        Sat,  9 Sep 2023 21:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694294809;
        bh=PgrTxfqnsCojmEomQEvMRldNYSuQwH3IW0kDlxOuckA=;
        h=Subject:To:Cc:From:Date:From;
        b=yDBtVRYZMD7MNxYw57H49Jipk9CTKQj2MG+c/wKNP66XWNtzf4IMuwH/qC7cyLEO8
         VWzwBWZC3tMEGrFAE5mWrpp4FRBOcjzzS+XKaQw6pgBASOD6hgbm1B/oC1oU2WggJb
         eYZpihpgdsjBCwqB0hptx2OEnNObu7IIkKBbrWLM=
Subject: FAILED: patch "[PATCH] bpf: fix bpf_probe_read_kernel prototype mismatch" failed to apply to 6.1-stable tree
To:     arnd@arndb.de, ast@kernel.org, yonghong.song@linux.dev
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 09 Sep 2023 22:26:42 +0100
Message-ID: <2023090942-raging-premiere-af0c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6a5a148aaf14747570cc634f9cdfcb0393f5617f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090942-raging-premiere-af0c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

6a5a148aaf14 ("bpf: fix bpf_probe_read_kernel prototype mismatch")
1f9a1ea821ff ("bpf: Support new sign-extension load insns")
06accc8779c1 ("bpf: add support for open-coded iterator loops")
215bf4962f6c ("bpf: add iterator kfuncs registration and validation logic")
a461f5adf177 ("bpf: generalize dynptr_get_spi to be usable for iters")
d0e1ac227945 ("bpf: move kfunc_call_arg_meta higher in the file")
653ae3a874ac ("bpf: clean up visit_insn()'s instruction processing")
98ddcf389d1b ("bpf: honor env->test_state_freq flag in is_state_visited()")
d54e0f6c1adf ("bpf: improve stack slot state printing")
0d80a619c113 ("bpf: allow ctx writes using BPF_ST_MEM instruction")
6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
20c09d92faee ("bpf: Introduce kptr_rcu.")
8d093b4e95a2 ("bpf: Mark cgroups and dfl_cgrp fields as trusted.")
66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr")
05421aecd4ed ("bpf: Add xdp dynptrs")
b5964b968ac6 ("bpf: Add skb dynptrs")
d96d937d7c5c ("bpf: Add __uninit kfunc annotation")
485ec51ef976 ("bpf: Refactor verifier dynptr into get_dynptr_arg_reg")
8357b366cbb0 ("bpf: Define no-ops for externally called bpf dynptr functions")
1d18feb2c915 ("bpf: Allow initializing dynptrs in kfuncs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6a5a148aaf14747570cc634f9cdfcb0393f5617f Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 1 Aug 2023 13:13:58 +0200
Subject: [PATCH] bpf: fix bpf_probe_read_kernel prototype mismatch

bpf_probe_read_kernel() has a __weak definition in core.c and another
definition with an incompatible prototype in kernel/trace/bpf_trace.c,
when CONFIG_BPF_EVENTS is enabled.

Since the two are incompatible, there cannot be a shared declaration in
a header file, but the lack of a prototype causes a W=1 warning:

kernel/bpf/core.c:1638:12: error: no previous prototype for 'bpf_probe_read_kernel' [-Werror=missing-prototypes]

On 32-bit architectures, the local prototype

u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)

passes arguments in other registers as the one in bpf_trace.c

BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size,
            const void *, unsafe_ptr)

which uses 64-bit arguments in pairs of registers.

As both versions of the function are fairly simple and only really
differ in one line, just move them into a header file as an inline
function that does not add any overhead for the bpf_trace.c callers
and actually avoids a function call for the other one.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/ac25cb0f-b804-1649-3afb-1dc6138c2716@iogearbox.net/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20230801111449.185301-1-arnd@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ceaa8c23287f..abe75063630b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2661,6 +2661,18 @@ static inline void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr)
 }
 #endif /* CONFIG_BPF_SYSCALL */
 
+static __always_inline int
+bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
+{
+	int ret = -EFAULT;
+
+	if (IS_ENABLED(CONFIG_BPF_EVENTS))
+		ret = copy_from_kernel_nofault(dst, unsafe_ptr, size);
+	if (unlikely(ret < 0))
+		memset(dst, 0, size);
+	return ret;
+}
+
 void __bpf_free_used_btfs(struct bpf_prog_aux *aux,
 			  struct btf_mod_pair *used_btfs, u32 len);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index baccdec22f19..0f8f036d8bd1 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1650,12 +1650,6 @@ bool bpf_opcode_in_insntable(u8 code)
 }
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
-u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
-{
-	memset(dst, 0, size);
-	return -EFAULT;
-}
-
 /**
  *	___bpf_prog_run - run eBPF program on a given context
  *	@regs: is the array of MAX_BPF_EXT_REG eBPF pseudo-registers
@@ -2066,8 +2060,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 		DST = *(SIZE *)(unsigned long) (SRC + insn->off);	\
 		CONT;							\
 	LDX_PROBE_MEM_##SIZEOP:						\
-		bpf_probe_read_kernel(&DST, sizeof(SIZE),		\
-				      (const void *)(long) (SRC + insn->off));	\
+		bpf_probe_read_kernel_common(&DST, sizeof(SIZE),	\
+			      (const void *)(long) (SRC + insn->off));	\
 		DST = *((SIZE *)&DST);					\
 		CONT;
 
@@ -2082,7 +2076,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 		DST = *(SIZE *)(unsigned long) (SRC + insn->off);	\
 		CONT;							\
 	LDX_PROBE_MEMSX_##SIZEOP:					\
-		bpf_probe_read_kernel(&DST, sizeof(SIZE),		\
+		bpf_probe_read_kernel_common(&DST, sizeof(SIZE),		\
 				      (const void *)(long) (SRC + insn->off));	\
 		DST = *((SIZE *)&DST);					\
 		CONT;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index c92eb8c6ff08..83bde2475ae5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -223,17 +223,6 @@ const struct bpf_func_proto bpf_probe_read_user_str_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-static __always_inline int
-bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
-{
-	int ret;
-
-	ret = copy_from_kernel_nofault(dst, unsafe_ptr, size);
-	if (unlikely(ret < 0))
-		memset(dst, 0, size);
-	return ret;
-}
-
 BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size,
 	   const void *, unsafe_ptr)
 {

