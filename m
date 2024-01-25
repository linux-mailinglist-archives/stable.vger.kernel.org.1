Return-Path: <stable+bounces-15744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF8183B5F3
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617A31C21C9D
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 00:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855067F;
	Thu, 25 Jan 2024 00:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUHMq4hI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A9A7EC
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141787; cv=none; b=Z1W7pcqEgtj1aEEYTBt6qgxJ+cKMnRI5ZnkGegsfX9UllRkfzIx74rXy2LgE6QX3qyknPr0ISZ1A4XbyvuiNeHjGakSHQT1z5HgsLBQBjbs010WGBVJy4ttEno1wsL7O3PUxoIzm4BhUHJJbvgsp9LZH7PEKnv6K/pzyG21Pu9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141787; c=relaxed/simple;
	bh=6IcZhIahxj5q/VQdMPlrGR7rScWCbcuT7K2paVvFWe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dH/5TLGqvLlDlcXuBzE9T06hdmeJ4pgE8xYzXb9mvcLgn5o/pzpRSrTwqVGdHWLi4PAbWFx3S1MaGZNvhdHmfZRtejZtopNZfOYC+iyuISpq26KjBpGodMPVv9KIiGlxypQxX6l2B6e+wbgOSO8iOi2XLyg8eV16KRz7gdppiWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUHMq4hI; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so686993266b.2
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 16:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706141783; x=1706746583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NlGCy1TAJ/krH2Gvh1RUMyS5UNIbU3B4nbDbkyBXOg=;
        b=jUHMq4hIjD/fV7R/0LjHdkBGIp7zn1ZM+OHa9WwYwajf/8evcyxlzDEsdVRHlsy5+/
         Rp0aAJtuXAvtopWVYdOmHi3uxC8bwTX0B8clE6gfGoFIUxerKHpEm7+TjOhKeIxS1oXv
         daqN/7f6oKmSQZbja9+RYk9DywQce4SpR+YABsIoYbDQSKfQPW05Z3h3rSRI2ORK2nAt
         wZ4IfAVcXe+zOKq0vzzNjUCnuspojNf3pqjrFArzG60XE27ZYj4HtVx8qs7HR3omexgZ
         QaZ7WxzSWsG8LrgdNKZ+/hZbll0lWe9ExhLoyUwr/Ea+mb8drkA6ncCqfl/t/4mX+bfC
         BBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141783; x=1706746583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NlGCy1TAJ/krH2Gvh1RUMyS5UNIbU3B4nbDbkyBXOg=;
        b=K/lY/fbuJl+NnFKTD+/yel1i+Rnj1wLFwZxs475jpJjuI4ZQrVCs7gKelXIqI7Z+8A
         sKKH33J138nacVzKjgXiFCo/F+KMbsnhbobwpE1SSY/4eO8+5XXQK4cEtgayGiM66zJu
         R0DOC1caszVK7Jgy7rIyEx+N64+ELsCappNZqnzEyY+zQhIxvaGMAXkB6I5wsBSI3NE8
         J6BEuklRXrgou/mv0qrLk8ST84XuzJLwztBLU9YJaIGy2asg4Uh7VeNz2zKPoQi2uoE/
         /fPN8WosdOoAHS4wWZnFeDfPCqcm2I7Tz6MZ8TxTaf9k/DcH3hyxjmzixldKHPp2rJvU
         0UAA==
X-Gm-Message-State: AOJu0Yz5GIwA5Jl5oGk8ZOh1ywAJVIHgdz/SpwgzpQ93w5mBKjmllbnZ
	6XZ0BQQ6iw1p0cr6g88wa7R89vs1jvxpAbLt3cNMPsdqfKRt1fvgnfV4P3+n
X-Google-Smtp-Source: AGHT+IHjuPq9zzWKgCvEDsDh8iibfyAV+NaIFPAugiJtxSpCmQcrJXo4g8JORR5b1SC5/cypvmjenA==
X-Received: by 2002:a17:907:93c3:b0:a31:1c05:9887 with SMTP id cp3-20020a17090793c300b00a311c059887mr31033ejc.193.1706141782731;
        Wed, 24 Jan 2024 16:16:22 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090699cb00b00a316896b4aesm217363ejn.80.2024.01.24.16.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:16:22 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: stable@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	mykolal@fb.com,
	gregkh@linuxfoundation.org,
	mat.gienieczko@tum.de,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH 6.6.y 04/17] selftests/bpf: tests with delayed read/precision makrs in loop body
Date: Thu, 25 Jan 2024 02:15:41 +0200
Message-ID: <20240125001554.25287-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125001554.25287-1-eddyz87@gmail.com>
References: <20240125001554.25287-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 389ede06c297 ]

These test cases try to hide read and precision marks from loop
convergence logic: marks would only be assigned on subsequent loop
iterations or after exploring states pushed to env->head stack first.
Without verifier fix to use exact states comparison logic for
iterators convergence these tests (except 'triple_continue') would be
errorneously marked as safe.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231024000917.12153-5-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/iters.c | 518 ++++++++++++++++++++++
 1 file changed, 518 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 6b9b3c56f009..764a68420c3e 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -14,6 +14,13 @@ int my_pid;
 int arr[256];
 int small_arr[16] SEC(".data.small_arr");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 10);
+	__type(key, int);
+	__type(value, int);
+} amap SEC(".maps");
+
 #ifdef REAL_TEST
 #define MY_PID_GUARD() if (my_pid != (bpf_get_current_pid_tgid() >> 32)) return 0
 #else
@@ -716,4 +723,515 @@ int iter_pass_iter_ptr_to_subprog(const void *ctx)
 	return 0;
 }
 
+SEC("?raw_tp")
+__failure
+__msg("R1 type=scalar expected=fp")
+__naked int delayed_read_mark(void)
+{
+	/* This is equivalent to C program below.
+	 * The call to bpf_iter_num_next() is reachable with r7 values &fp[-16] and 0xdead.
+	 * State with r7=&fp[-16] is visited first and follows r6 != 42 ... continue branch.
+	 * At this point iterator next() call is reached with r7 that has no read mark.
+	 * Loop body with r7=0xdead would only be visited if verifier would decide to continue
+	 * with second loop iteration. Absence of read mark on r7 might affect state
+	 * equivalent logic used for iterator convergence tracking.
+	 *
+	 * r7 = &fp[-16]
+	 * fp[-16] = 0
+	 * r6 = bpf_get_prandom_u32()
+	 * bpf_iter_num_new(&fp[-8], 0, 10)
+	 * while (bpf_iter_num_next(&fp[-8])) {
+	 *   r6++
+	 *   if (r6 != 42) {
+	 *     r7 = 0xdead
+	 *     continue;
+	 *   }
+	 *   bpf_probe_read_user(r7, 8, 0xdeadbeef); // this is not safe
+	 * }
+	 * bpf_iter_num_destroy(&fp[-8])
+	 * return 0
+	 */
+	asm volatile (
+		"r7 = r10;"
+		"r7 += -16;"
+		"r0 = 0;"
+		"*(u64 *)(r7 + 0) = r0;"
+		"call %[bpf_get_prandom_u32];"
+		"r6 = r0;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+	"1:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto 2f;"
+		"r6 += 1;"
+		"if r6 != 42 goto 3f;"
+		"r7 = 0xdead;"
+		"goto 1b;"
+	"3:"
+		"r1 = r7;"
+		"r2 = 8;"
+		"r3 = 0xdeadbeef;"
+		"call %[bpf_probe_read_user];"
+		"goto 1b;"
+	"2:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32),
+		  __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy),
+		  __imm(bpf_probe_read_user)
+		: __clobber_all
+	);
+}
+
+SEC("?raw_tp")
+__failure
+__msg("math between fp pointer and register with unbounded")
+__naked int delayed_precision_mark(void)
+{
+	/* This is equivalent to C program below.
+	 * The test is similar to delayed_iter_mark but verifies that incomplete
+	 * precision don't fool verifier.
+	 * The call to bpf_iter_num_next() is reachable with r7 values -16 and -32.
+	 * State with r7=-16 is visited first and follows r6 != 42 ... continue branch.
+	 * At this point iterator next() call is reached with r7 that has no read
+	 * and precision marks.
+	 * Loop body with r7=-32 would only be visited if verifier would decide to continue
+	 * with second loop iteration. Absence of precision mark on r7 might affect state
+	 * equivalent logic used for iterator convergence tracking.
+	 *
+	 * r8 = 0
+	 * fp[-16] = 0
+	 * r7 = -16
+	 * r6 = bpf_get_prandom_u32()
+	 * bpf_iter_num_new(&fp[-8], 0, 10)
+	 * while (bpf_iter_num_next(&fp[-8])) {
+	 *   if (r6 != 42) {
+	 *     r7 = -32
+	 *     r6 = bpf_get_prandom_u32()
+	 *     continue;
+	 *   }
+	 *   r0 = r10
+	 *   r0 += r7
+	 *   r8 = *(u64 *)(r0 + 0)           // this is not safe
+	 *   r6 = bpf_get_prandom_u32()
+	 * }
+	 * bpf_iter_num_destroy(&fp[-8])
+	 * return r8
+	 */
+	asm volatile (
+		"r8 = 0;"
+		"*(u64 *)(r10 - 16) = r8;"
+		"r7 = -16;"
+		"call %[bpf_get_prandom_u32];"
+		"r6 = r0;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+	"1:"
+		"r1 = r10;"
+		"r1 += -8;\n"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto 2f;"
+		"if r6 != 42 goto 3f;"
+		"r7 = -32;"
+		"call %[bpf_get_prandom_u32];"
+		"r6 = r0;"
+		"goto 1b;\n"
+	"3:"
+		"r0 = r10;"
+		"r0 += r7;"
+		"r8 = *(u64 *)(r0 + 0);"
+		"call %[bpf_get_prandom_u32];"
+		"r6 = r0;"
+		"goto 1b;\n"
+	"2:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = r8;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32),
+		  __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy),
+		  __imm(bpf_probe_read_user)
+		: __clobber_all
+	);
+}
+
+SEC("?raw_tp")
+__failure
+__msg("math between fp pointer and register with unbounded")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked int loop_state_deps1(void)
+{
+	/* This is equivalent to C program below.
+	 *
+	 * The case turns out to be tricky in a sense that:
+	 * - states with c=-25 are explored only on a second iteration
+	 *   of the outer loop;
+	 * - states with read+precise mark on c are explored only on
+	 *   second iteration of the inner loop and in a state which
+	 *   is pushed to states stack first.
+	 *
+	 * Depending on the details of iterator convergence logic
+	 * verifier might stop states traversal too early and miss
+	 * unsafe c=-25 memory access.
+	 *
+	 *   j = iter_new();		 // fp[-16]
+	 *   a = 0;			 // r6
+	 *   b = 0;			 // r7
+	 *   c = -24;			 // r8
+	 *   while (iter_next(j)) {
+	 *     i = iter_new();		 // fp[-8]
+	 *     a = 0;			 // r6
+	 *     b = 0;			 // r7
+	 *     while (iter_next(i)) {
+	 *	 if (a == 1) {
+	 *	   a = 0;
+	 *	   b = 1;
+	 *	 } else if (a == 0) {
+	 *	   a = 1;
+	 *	   if (random() == 42)
+	 *	     continue;
+	 *	   if (b == 1) {
+	 *	     *(r10 + c) = 7;  // this is not safe
+	 *	     iter_destroy(i);
+	 *	     iter_destroy(j);
+	 *	     return;
+	 *	   }
+	 *	 }
+	 *     }
+	 *     iter_destroy(i);
+	 *     a = 0;
+	 *     b = 0;
+	 *     c = -25;
+	 *   }
+	 *   iter_destroy(j);
+	 *   return;
+	 */
+	asm volatile (
+		"r1 = r10;"
+		"r1 += -16;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+		"r6 = 0;"
+		"r7 = 0;"
+		"r8 = -24;"
+	"j_loop_%=:"
+		"r1 = r10;"
+		"r1 += -16;"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto j_loop_end_%=;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+		"r6 = 0;"
+		"r7 = 0;"
+	"i_loop_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto i_loop_end_%=;"
+	"check_one_r6_%=:"
+		"if r6 != 1 goto check_zero_r6_%=;"
+		"r6 = 0;"
+		"r7 = 1;"
+		"goto i_loop_%=;"
+	"check_zero_r6_%=:"
+		"if r6 != 0 goto i_loop_%=;"
+		"r6 = 1;"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 != 42 goto check_one_r7_%=;"
+		"goto i_loop_%=;"
+	"check_one_r7_%=:"
+		"if r7 != 1 goto i_loop_%=;"
+		"r0 = r10;"
+		"r0 += r8;"
+		"r1 = 7;"
+		"*(u64 *)(r0 + 0) = r1;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		"r1 = r10;"
+		"r1 += -16;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+	"i_loop_end_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		"r6 = 0;"
+		"r7 = 0;"
+		"r8 = -25;"
+		"goto j_loop_%=;"
+	"j_loop_end_%=:"
+		"r1 = r10;"
+		"r1 += -16;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32),
+		  __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy)
+		: __clobber_all
+	);
+}
+
+SEC("?raw_tp")
+__success
+__naked int triple_continue(void)
+{
+	/* This is equivalent to C program below.
+	 * High branching factor of the loop body turned out to be
+	 * problematic for one of the iterator convergence tracking
+	 * algorithms explored.
+	 *
+	 * r6 = bpf_get_prandom_u32()
+	 * bpf_iter_num_new(&fp[-8], 0, 10)
+	 * while (bpf_iter_num_next(&fp[-8])) {
+	 *   if (bpf_get_prandom_u32() != 42)
+	 *     continue;
+	 *   if (bpf_get_prandom_u32() != 42)
+	 *     continue;
+	 *   if (bpf_get_prandom_u32() != 42)
+	 *     continue;
+	 *   r0 += 0;
+	 * }
+	 * bpf_iter_num_destroy(&fp[-8])
+	 * return 0
+	 */
+	asm volatile (
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+	"loop_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto loop_end_%=;"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 != 42 goto loop_%=;"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 != 42 goto loop_%=;"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 != 42 goto loop_%=;"
+		"r0 += 0;"
+		"goto loop_%=;"
+	"loop_end_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32),
+		  __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy)
+		: __clobber_all
+	);
+}
+
+SEC("?raw_tp")
+__success
+__naked int widen_spill(void)
+{
+	/* This is equivalent to C program below.
+	 * The counter is stored in fp[-16], if this counter is not widened
+	 * verifier states representing loop iterations would never converge.
+	 *
+	 * fp[-16] = 0
+	 * bpf_iter_num_new(&fp[-8], 0, 10)
+	 * while (bpf_iter_num_next(&fp[-8])) {
+	 *   r0 = fp[-16];
+	 *   r0 += 1;
+	 *   fp[-16] = r0;
+	 * }
+	 * bpf_iter_num_destroy(&fp[-8])
+	 * return 0
+	 */
+	asm volatile (
+		"r0 = 0;"
+		"*(u64 *)(r10 - 16) = r0;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+	"loop_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto loop_end_%=;"
+		"r0 = *(u64 *)(r10 - 16);"
+		"r0 += 1;"
+		"*(u64 *)(r10 - 16) = r0;"
+		"goto loop_%=;"
+	"loop_end_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy)
+		: __clobber_all
+	);
+}
+
+SEC("raw_tp")
+__success
+__naked int checkpoint_states_deletion(void)
+{
+	/* This is equivalent to C program below.
+	 *
+	 *   int *a, *b, *c, *d, *e, *f;
+	 *   int i, sum = 0;
+	 *   bpf_for(i, 0, 10) {
+	 *     a = bpf_map_lookup_elem(&amap, &i);
+	 *     b = bpf_map_lookup_elem(&amap, &i);
+	 *     c = bpf_map_lookup_elem(&amap, &i);
+	 *     d = bpf_map_lookup_elem(&amap, &i);
+	 *     e = bpf_map_lookup_elem(&amap, &i);
+	 *     f = bpf_map_lookup_elem(&amap, &i);
+	 *     if (a) sum += 1;
+	 *     if (b) sum += 1;
+	 *     if (c) sum += 1;
+	 *     if (d) sum += 1;
+	 *     if (e) sum += 1;
+	 *     if (f) sum += 1;
+	 *   }
+	 *   return 0;
+	 *
+	 * The body of the loop spawns multiple simulation paths
+	 * with different combination of NULL/non-NULL information for a/b/c/d/e/f.
+	 * Each combination is unique from states_equal() point of view.
+	 * Explored states checkpoint is created after each iterator next call.
+	 * Iterator convergence logic expects that eventually current state
+	 * would get equal to one of the explored states and thus loop
+	 * exploration would be finished (at-least for a specific path).
+	 * Verifier evicts explored states with high miss to hit ratio
+	 * to to avoid comparing current state with too many explored
+	 * states per instruction.
+	 * This test is designed to "stress test" eviction policy defined using formula:
+	 *
+	 *    sl->miss_cnt > sl->hit_cnt * N + N // if true sl->state is evicted
+	 *
+	 * Currently N is set to 64, which allows for 6 variables in this test.
+	 */
+	asm volatile (
+		"r6 = 0;"                  /* a */
+		"r7 = 0;"                  /* b */
+		"r8 = 0;"                  /* c */
+		"*(u64 *)(r10 - 24) = r6;" /* d */
+		"*(u64 *)(r10 - 32) = r6;" /* e */
+		"*(u64 *)(r10 - 40) = r6;" /* f */
+		"r9 = 0;"                  /* sum */
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+	"loop_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto loop_end_%=;"
+
+		"*(u64 *)(r10 - 16) = r0;"
+
+		"r1 = %[amap] ll;"
+		"r2 = r10;"
+		"r2 += -16;"
+		"call %[bpf_map_lookup_elem];"
+		"r6 = r0;"
+
+		"r1 = %[amap] ll;"
+		"r2 = r10;"
+		"r2 += -16;"
+		"call %[bpf_map_lookup_elem];"
+		"r7 = r0;"
+
+		"r1 = %[amap] ll;"
+		"r2 = r10;"
+		"r2 += -16;"
+		"call %[bpf_map_lookup_elem];"
+		"r8 = r0;"
+
+		"r1 = %[amap] ll;"
+		"r2 = r10;"
+		"r2 += -16;"
+		"call %[bpf_map_lookup_elem];"
+		"*(u64 *)(r10 - 24) = r0;"
+
+		"r1 = %[amap] ll;"
+		"r2 = r10;"
+		"r2 += -16;"
+		"call %[bpf_map_lookup_elem];"
+		"*(u64 *)(r10 - 32) = r0;"
+
+		"r1 = %[amap] ll;"
+		"r2 = r10;"
+		"r2 += -16;"
+		"call %[bpf_map_lookup_elem];"
+		"*(u64 *)(r10 - 40) = r0;"
+
+		"if r6 == 0 goto +1;"
+		"r9 += 1;"
+		"if r7 == 0 goto +1;"
+		"r9 += 1;"
+		"if r8 == 0 goto +1;"
+		"r9 += 1;"
+		"r0 = *(u64 *)(r10 - 24);"
+		"if r0 == 0 goto +1;"
+		"r9 += 1;"
+		"r0 = *(u64 *)(r10 - 32);"
+		"if r0 == 0 goto +1;"
+		"r9 += 1;"
+		"r0 = *(u64 *)(r10 - 40);"
+		"if r0 == 0 goto +1;"
+		"r9 += 1;"
+
+		"goto loop_%=;"
+	"loop_end_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_map_lookup_elem),
+		  __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy),
+		  __imm_addr(amap)
+		: __clobber_all
+	);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


