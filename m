Return-Path: <stable+bounces-104265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4199F22BD
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 09:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40554165FE7
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4351411C8;
	Sun, 15 Dec 2024 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EwvBZnIp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B26B13D28F
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734252978; cv=none; b=Hb1Ed/KGq2lBT3E5ExcKy9Qd/bSk/obORdDlQn7vEu428iHFnCSJ20iiAYeWjGYYQjGdtnDwnDyD/OwzTDUeRh4Gm/BGx92wtVced6brmR/OiDPJWa1NiDZ8WNYzO5Ky4q/P72OhARlP6YKn/5XePGT2k2fOjdtzk34dntMpWVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734252978; c=relaxed/simple;
	bh=g2CMIfFdYAa1cnq3SSw4msA6oc7Q4EK7HCgG65C6Gv4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hG/ag/Vkk/QDV+i3ogQQdbZb3vWfuHjza/JE0poUAZR1LB4X5NKAOIcAtIoh5hi/NFNXpmsYkjx6MOKPCpp888SsxNQyoJ0gyEjn+ev/76oCh0/i2aJLLELQ/GVNeSqsKqn5LBOJIneEqI6Jc4bTolDW6OzZX+ZLX90A6zswhPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EwvBZnIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1492C4CECE;
	Sun, 15 Dec 2024 08:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734252978;
	bh=g2CMIfFdYAa1cnq3SSw4msA6oc7Q4EK7HCgG65C6Gv4=;
	h=Subject:To:Cc:From:Date:From;
	b=EwvBZnIpstEZBWChd3h1qT6wc+016XtPfGRjZFFNUM7fs6Y8OeDE5vZzhZ0QDrGUl
	 94QbhM9sFbYH5TOC2VJJtyMbY7H9o5Q8gobaz/9vbJPVdJkd9+EA6rGAbyo1OP3A5z
	 +ubjxMo6AtV5cajE4plyC1cxahk4+rb5kEjN6GzM=
Subject: FAILED: patch "[PATCH] bpf: Check size for BTF-based ctx access of pointer members" failed to apply to 5.10-stable tree
To: memxor@gmail.com,ast@kernel.org,rtm@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 09:56:04 +0100
Message-ID: <2024121504-cloak-campfire-b8a9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 659b9ba7cb2d7adb64618b87ddfaa528a143766e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121504-cloak-campfire-b8a9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


