Return-Path: <stable+bounces-104264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD829F22BC
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 09:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DD11886A07
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C6F13E043;
	Sun, 15 Dec 2024 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NN1DdSTt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D822513D28F
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734252974; cv=none; b=APHmcXSKyThwp2t8mBlKRW+O2yhuMAcMRGn/zdAa9cLP/5IJBER5OiEjMR/IKoXp+YETWoarbXkSaIuTes5EjMWGb3UrYaoWUHFtPZ+cvjXq9wmGDOHpmNCCr1AayzZ0OW4g8opKebQLETvERqW0dtuYCNCIFqacvRFY4ezVFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734252974; c=relaxed/simple;
	bh=Bbu42lAp2O9ApW8+BWF/Bum5jh6JUGYEd4ljtSkqxac=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fi1B4CPh7C6XJJAq8vrinUSgtJ9xuFzMwUAJbsV8dRQALk9rF7iSqtxC4t9ob3dF2AgM11zuJaBAExWT8TCXXamDaNplPKA8tcH+0ySdQ906gJUgrplPNpKAdCdD0KJfyE8hD27jjr6NOpcabB9VfNIkpgXvfaUh0WizBK0zyuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NN1DdSTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A3AC4CECE;
	Sun, 15 Dec 2024 08:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734252974;
	bh=Bbu42lAp2O9ApW8+BWF/Bum5jh6JUGYEd4ljtSkqxac=;
	h=Subject:To:Cc:From:Date:From;
	b=NN1DdSTtES6WlizxSkJgGjOldg5apMhL5IxQUiZi7BSUC96ozfTsCTaVCzzCcNSXQ
	 Ivy3NGPqGROokfi64uRLg2j1ZL3o/AHssRML692TtJxEecPXoRLlLif2zSCoDw1/+H
	 pchr3J5ag/vEyi7R5zQ/voGK3T28I4UiE0T2iaW8=
Subject: FAILED: patch "[PATCH] bpf: Check size for BTF-based ctx access of pointer members" failed to apply to 5.15-stable tree
To: memxor@gmail.com,ast@kernel.org,rtm@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 09:56:03 +0100
Message-ID: <2024121503-footwork-harness-0128@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 659b9ba7cb2d7adb64618b87ddfaa528a143766e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121503-footwork-harness-0128@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 659b9ba7cb2d7adb64618b87ddfaa528a143766e Mon Sep 17 00:00:00 2001
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 12 Dec 2024 01:20:49 -0800
Subject: [PATCH] bpf: Check size for BTF-based ctx access of pointer members

Robert Morris reported the following program type which passes the
verifier in [0]:

SEC("struct_ops/bpf_cubic_init")
void BPF_PROG(bpf_cubic_init, struct sock *sk)
{
	asm volatile("r2 = *(u16*)(r1 + 0)");     // verifier should demand u64
	asm volatile("*(u32 *)(r2 +1504) = 0");   // 1280 in some configs
}

The second line may or may not work, but the first instruction shouldn't
pass, as it's a narrow load into the context structure of the struct ops
callback. The code falls back to btf_ctx_access to ensure correctness
and obtaining the types of pointers. Ensure that the size of the access
is correctly checked to be 8 bytes, otherwise the verifier thinks the
narrow load obtained a trusted BTF pointer and will permit loads/stores
as it sees fit.

Perform the check on size after we've verified that the load is for a
pointer field, as for scalar values narrow loads are fine. Access to
structs passed as arguments to a BPF program are also treated as
scalars, therefore no adjustment is needed in their case.

Existing verifier selftests are broken by this change, but because they
were incorrect. Verifier tests for d_path were performing narrow load
into context to obtain path pointer, had this program actually run it
would cause a crash. The same holds for verifier_btf_ctx_access tests.

  [0]: https://lore.kernel.org/bpf/51338.1732985814@localhost

Fixes: 9e15db66136a ("bpf: Implement accurate raw_tp context access via BTF")
Reported-by: Robert Morris <rtm@mit.edu>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20241212092050.3204165-2-memxor@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e7a59e6462a9..a63a03582f02 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6543,6 +6543,12 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		return false;
 	}
 
+	if (size != sizeof(u64)) {
+		bpf_log(log, "func '%s' size %d must be 8\n",
+			tname, size);
+		return false;
+	}
+
 	/* check for PTR_TO_RDONLY_BUF_OR_NULL or PTR_TO_RDWR_BUF_OR_NULL */
 	for (i = 0; i < prog->aux->ctx_arg_info_size; i++) {
 		const struct bpf_ctx_arg_aux *ctx_arg_info = &prog->aux->ctx_arg_info[i];
diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c b/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
index a570e48b917a..bfc3bf18fed4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
@@ -11,7 +11,7 @@ __success __retval(0)
 __naked void btf_ctx_access_accept(void)
 {
 	asm volatile ("					\
-	r2 = *(u32*)(r1 + 8);		/* load 2nd argument value (int pointer) */\
+	r2 = *(u64 *)(r1 + 8);		/* load 2nd argument value (int pointer) */\
 	r0 = 0;						\
 	exit;						\
 "	::: __clobber_all);
@@ -23,7 +23,7 @@ __success __retval(0)
 __naked void ctx_access_u32_pointer_accept(void)
 {
 	asm volatile ("					\
-	r2 = *(u32*)(r1 + 0);		/* load 1nd argument value (u32 pointer) */\
+	r2 = *(u64 *)(r1 + 0);		/* load 1nd argument value (u32 pointer) */\
 	r0 = 0;						\
 	exit;						\
 "	::: __clobber_all);
diff --git a/tools/testing/selftests/bpf/progs/verifier_d_path.c b/tools/testing/selftests/bpf/progs/verifier_d_path.c
index ec79cbcfde91..87e51a215558 100644
--- a/tools/testing/selftests/bpf/progs/verifier_d_path.c
+++ b/tools/testing/selftests/bpf/progs/verifier_d_path.c
@@ -11,7 +11,7 @@ __success __retval(0)
 __naked void d_path_accept(void)
 {
 	asm volatile ("					\
-	r1 = *(u32*)(r1 + 0);				\
+	r1 = *(u64 *)(r1 + 0);				\
 	r2 = r10;					\
 	r2 += -8;					\
 	r6 = 0;						\
@@ -31,7 +31,7 @@ __failure __msg("helper call is not allowed in probe")
 __naked void d_path_reject(void)
 {
 	asm volatile ("					\
-	r1 = *(u32*)(r1 + 0);				\
+	r1 = *(u64 *)(r1 + 0);				\
 	r2 = r10;					\
 	r2 += -8;					\
 	r6 = 0;						\


