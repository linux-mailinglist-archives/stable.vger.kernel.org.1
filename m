Return-Path: <stable+bounces-15756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD34B83B5FF
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3C2289502
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 00:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6BF385;
	Thu, 25 Jan 2024 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvTXqoq8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E25399
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141802; cv=none; b=q9SuFbyi9n8pPTw8rvpdjCOwf2IbLy5iJ0tl0ZHnDK41v26cb0pflsr3XBK4nWfZR1xhKynUWqcz60xY0F6Maqd5HvZ0hkGN6H5qTzlMlE1r+iO9zb6E/ZJMOctid6LADcTbS0TeN1/WedQnmWlhAuUEtbTnAcw5PFbSaVlOcgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141802; c=relaxed/simple;
	bh=yGGMijxGp6wjOK1XZ9Rs+V3b+2JdVT+ekZ1FzvueMyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfFraykmsnlSPjhVyLB2skK1HAZ9uyAmQQaoltf6AROqEk5okHLdm72dkPdHp/zxDf+QI3l7er3KGKCXPYCg4Be/rOv++3q1j4TR5ABeCJuuNpzsEjuOURRIa7YaAIBi6Uk7/Fsv+uukmgTYNzri9SIb4c7sgNXWKLZh1VryHEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvTXqoq8; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a314ca7852cso71127666b.3
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 16:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706141798; x=1706746598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXPrN0YVTmvymQe/xXinFbJWSiwdzZazWEtBc6D1qr8=;
        b=VvTXqoq8ny+qkk75x/UOKEFitapq5+Fq/1u6gpcoqWGlCgQdPhpVyOJgMBTSUiCdNi
         dZD8lcU9ji/x2DfknmZB5B3MQdWXHve5cwXwuZo1GZuVA6cMAX23t/CKfmZ5bXzHye9h
         LJ09DG3V//iteysTF8Nz54fcXg6PChHr7sDvQii5G4c7E3GRUcvw1CwDD/fUe8vGLj1y
         3HuNwub0SKQbOEPWwSxGUc0m7Nkjh/Qs/dLHTxqVxCSByKWo02AOY/w+3nhbZ2CeZ1Tp
         f5IGVbKpjpjsyonaG8hsFkScEE19zyDeajuH5nL1aV0Eb+HogQL+0tSvt/S3V1tLvDQT
         ExYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141798; x=1706746598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXPrN0YVTmvymQe/xXinFbJWSiwdzZazWEtBc6D1qr8=;
        b=NpkqLlJ42zmsTOJmlFi5cynnJQLQIm0nSDSEU1kPEDMn4fYxClOEKioIAOBMcOnVj5
         oUvqpS8eyuvgILyFOVPYV1xLYrsxporSDpRRI+Dk+zUbhRyYwHTWLzmsn3LTUAPPeCma
         BF19NSQHT6lV7yxcoT5x41niCf5YRMd4W86lmerfWCVGVUIN7oGIS5WYjzmFvTtGkayC
         R/k1y9kVcwyFrDLOljyzqWSz4YYWfTS78IqpE6lTxHvnc9PFCEFItUeN/VIQscSeGKZ1
         SFOozGlu70srsxQmLBOGA3w5j/Lc2/3+bBHlxLB4hOPpjz4JS52+4yIgfee39pUFu3MX
         7htA==
X-Gm-Message-State: AOJu0YworUW52Wj0CYYFmkG5JWbjoupysllARQYLoUEPAttEuH9uHobN
	bXKIqj3pxzwobORIkswOziMw5IKsbsvD2iE43+NB5MFYlns01+fnumIKZ/ti
X-Google-Smtp-Source: AGHT+IHfFNiq2BQR+CnagFNkV0JilCyOCaRVesVmTD46FyT/xbW1VRNED07p0pQ9W/JG/C9Zv7JAmw==
X-Received: by 2002:a17:907:6d13:b0:a31:3d88:296d with SMTP id sa19-20020a1709076d1300b00a313d88296dmr57548ejc.49.1706141797983;
        Wed, 24 Jan 2024 16:16:37 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090699cb00b00a316896b4aesm217363ejn.80.2024.01.24.16.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:16:37 -0800 (PST)
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
Subject: [PATCH 6.6.y 16/17] bpf: keep track of max number of bpf_loop callback iterations
Date: Thu, 25 Jan 2024 02:15:53 +0200
Message-ID: <20240125001554.25287-17-eddyz87@gmail.com>
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

[ Upstream commit bb124da69c47 ]

In some cases verifier can't infer convergence of the bpf_loop()
iteration. E.g. for the following program:

    static int cb(__u32 idx, struct num_context* ctx)
    {
        ctx->i++;
        return 0;
    }

    SEC("?raw_tp")
    int prog(void *_)
    {
        struct num_context ctx = { .i = 0 };
        __u8 choice_arr[2] = { 0, 1 };

        bpf_loop(2, cb, &ctx, 0);
        return choice_arr[ctx.i];
    }

Each 'cb' simulation would eventually return to 'prog' and reach
'return choice_arr[ctx.i]' statement. At which point ctx.i would be
marked precise, thus forcing verifier to track multitude of separate
states with {.i=0}, {.i=1}, ... at bpf_loop() callback entry.

This commit allows "brute force" handling for such cases by limiting
number of callback body simulations using 'umax' value of the first
bpf_loop() parameter.

For this, extend bpf_func_state with 'callback_depth' field.
Increment this field when callback visiting state is pushed to states
traversal stack. For frame #N it's 'callback_depth' field counts how
many times callback with frame depth N+1 had been executed.
Use bpf_func_state specifically to allow independent tracking of
callback depths when multiple nested bpf_loop() calls are present.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231121020701.26440-11-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>

[ Summary of the conflicts and their resolutions ]

There was one conflict with this patch, related to implementation of
BPF exceptions: the upstream series was developed after BPF exceptions
landed in bpf-next and BPF exceptions are not selected for porting to
6.6.y at the moment.

Conflict was resolved by excluding exceptions related part.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h                  | 11 ++++++
 kernel/bpf/verifier.c                         | 19 ++++++++--
 .../bpf/progs/verifier_subprog_precision.c    | 35 +++++++++++++------
 3 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f3b9550e8ef9..2d84d820a7ba 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -300,6 +300,17 @@ struct bpf_func_state {
 	bool in_callback_fn;
 	struct tnum callback_ret_range;
 	bool in_async_callback_fn;
+	/* For callback calling functions that limit number of possible
+	 * callback executions (e.g. bpf_loop) keeps track of current
+	 * simulated iteration number.
+	 * Value in frame N refers to number of times callback with frame
+	 * N+1 was simulated, e.g. for the following call:
+	 *
+	 *   bpf_loop(..., fn, ...); | suppose current frame is N
+	 *                           | fn would be simulated in frame N+1
+	 *                           | number of simulations is tracked in frame N
+	 */
+	u32 callback_depth;
 
 	/* The following fields should be last. See copy_func_state() */
 	int acquired_refs;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 638ab1fdf214..da029fc79df1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9320,6 +9320,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		return err;
 
 	callback_state->callback_unroll_depth++;
+	callback_state->frame[callback_state->curframe - 1]->callback_depth++;
+	caller->callback_depth = 0;
 	return 0;
 }
 
@@ -10102,8 +10104,21 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		break;
 	case BPF_FUNC_loop:
 		update_loop_inline_state(env, meta.subprogno);
-		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
-					 set_loop_callback_state);
+		/* Verifier relies on R1 value to determine if bpf_loop() iteration
+		 * is finished, thus mark it precise.
+		 */
+		err = mark_chain_precision(env, BPF_REG_1);
+		if (err)
+			return err;
+		if (cur_func(env)->callback_depth < regs[BPF_REG_1].umax_value) {
+			err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+						 set_loop_callback_state);
+		} else {
+			cur_func(env)->callback_depth = 0;
+			if (env->log.level & BPF_LOG_LEVEL2)
+				verbose(env, "frame%d bpf_loop iteration limit reached\n",
+					env->cur_state->curframe);
+		}
 		break;
 	case BPF_FUNC_dynptr_from_mem:
 		if (regs[BPF_REG_1].type != PTR_TO_MAP_VALUE) {
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index da803cffb5ef..f61d623b1ce8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -119,7 +119,23 @@ __naked int global_subprog_result_precise(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-/* First simulated path does not include callback body */
+/* First simulated path does not include callback body,
+ * r1 and r4 are always precise for bpf_loop() calls.
+ */
+__msg("9: (85) call bpf_loop#181")
+__msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
+__msg("mark_precise: frame0: parent state regs=r4 stack=:")
+__msg("mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx 9")
+__msg("mark_precise: frame0: regs=r4 stack= before 8: (b7) r4 = 0")
+__msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
+__msg("mark_precise: frame0: parent state regs=r1 stack=:")
+__msg("mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx 9")
+__msg("mark_precise: frame0: regs=r1 stack= before 8: (b7) r4 = 0")
+__msg("mark_precise: frame0: regs=r1 stack= before 7: (b7) r3 = 0")
+__msg("mark_precise: frame0: regs=r1 stack= before 6: (bf) r2 = r8")
+__msg("mark_precise: frame0: regs=r1 stack= before 5: (bf) r1 = r6")
+__msg("mark_precise: frame0: regs=r6 stack= before 4: (b7) r6 = 3")
+/* r6 precision propagation */
 __msg("14: (0f) r1 += r6")
 __msg("mark_precise: frame0: last_idx 14 first_idx 9")
 __msg("mark_precise: frame0: regs=r6 stack= before 13: (bf) r1 = r7")
@@ -134,10 +150,9 @@ __msg("17: (b7) r0 = 0")
 __msg("18: (95) exit")
 __msg("returning from callee:")
 __msg("to caller at 9:")
-/* r4 (flags) is always precise for bpf_loop() */
-__msg("frame 0: propagating r4")
+__msg("frame 0: propagating r1,r4")
 __msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r4 stack= before 18: (95) exit")
+__msg("mark_precise: frame0: regs=r1,r4 stack= before 18: (95) exit")
 __msg("from 18 to 9: safe")
 __naked int callback_result_precise(void)
 {
@@ -264,12 +279,12 @@ __msg("15: (b7) r0 = 0")
 __msg("16: (95) exit")
 __msg("returning from callee:")
 __msg("to caller at 9:")
-/* r4 (flags) is always precise for bpf_loop(),
+/* r1, r4 are always precise for bpf_loop(),
  * r6 was marked before backtracking to callback body.
  */
-__msg("frame 0: propagating r4,r6")
+__msg("frame 0: propagating r1,r4,r6")
 __msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r4,r6 stack= before 16: (95) exit")
+__msg("mark_precise: frame0: regs=r1,r4,r6 stack= before 16: (95) exit")
 __msg("mark_precise: frame1: regs= stack= before 15: (b7) r0 = 0")
 __msg("mark_precise: frame1: regs= stack= before 9: (85) call bpf_loop")
 __msg("mark_precise: frame0: parent state regs= stack=:")
@@ -422,12 +437,12 @@ __msg("17: (b7) r0 = 0")
 __msg("18: (95) exit")
 __msg("returning from callee:")
 __msg("to caller at 10:")
-/* r4 (flags) is always precise for bpf_loop(),
+/* r1, r4 are always precise for bpf_loop(),
  * fp-8 was marked before backtracking to callback body.
  */
-__msg("frame 0: propagating r4,fp-8")
+__msg("frame 0: propagating r1,r4,fp-8")
 __msg("mark_precise: frame0: last_idx 10 first_idx 10 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r4 stack=-8 before 18: (95) exit")
+__msg("mark_precise: frame0: regs=r1,r4 stack=-8 before 18: (95) exit")
 __msg("mark_precise: frame1: regs= stack= before 17: (b7) r0 = 0")
 __msg("mark_precise: frame1: regs= stack= before 10: (85) call bpf_loop#181")
 __msg("mark_precise: frame0: parent state regs= stack=:")
-- 
2.43.0


