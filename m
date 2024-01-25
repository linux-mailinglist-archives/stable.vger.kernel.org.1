Return-Path: <stable+bounces-15751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A3683B5FB
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3234B2451B
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 00:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E557F8;
	Thu, 25 Jan 2024 00:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrO3AkSq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72870385
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141796; cv=none; b=ZVfvPrYndmFc6oAy/vts6Fls3o56CTqfnfQxifMJQBk4SsjHN7PQ/Z9mplPS3d5Df19ZGcXOC9yQQh1o4N5r15aWUyIstu40h30KOogU2FcJuYvOovl3gnD/k/tQvujxogmPC9CqHhAr7tQ2cH1DcwHuvQ9KQZlt3oFmuZy7qIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141796; c=relaxed/simple;
	bh=EKfW7KzKIzCmCGcY753/rB9QVlPxfV8ImUv4NhM+b4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WG1vRJ7wFk1b+o+02L7G1FYk19Mx0Yzgijtuop/omme0A+3nOZMaSvLkn23muSBiL/tx4BFLDAdzKVpmZW2qMVKoWBuLwrcM3XoCMS4tnZpquiz7OiTqqRpx7s9AhzkpShyP5cjoW1297pnPEsReS3rNMPe1suEFixKwfnTxB0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrO3AkSq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a293f2280c7so641284766b.1
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 16:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706141792; x=1706746592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1iS++2dMKPABCug3wsIWVGfz0Gj3QrXBCJ6q/bbJUI=;
        b=ZrO3AkSqwTu6raRN/MIJMt8diUeo5S1aA7YtHhFZbkNM7dfLrdkcpn3pysfWi5S4+Y
         1+IUZuQEymrydlLVQhHuJYsi+4rwvYL9QlY65gb1wS/GqySobCVebydLD6y4lFrX4v30
         QB3VFpxfMDtdhLlBSTQr8yTeNjRDNtH/KzUjTCPNXWPT6d7MLqnAHaaMHxUQ6/1X2h02
         mLQuSvoRWMcbji6qk0guxV1EpeJdLiqDypUt39Mt07KlfeKXFvnbNwib4zIofZ7/hV62
         12lbUS16bukd1P7U5O6Di3UwunIJxoTIrKL/6nv+24F+69ZJrB6lLLLWLoMvQqNVSHEZ
         kQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141792; x=1706746592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1iS++2dMKPABCug3wsIWVGfz0Gj3QrXBCJ6q/bbJUI=;
        b=QyMakCWVqO+8kfXkgAOnAyYBqnSCg90XzcwY36YvS8E/SYlNvyHhfanDkWtLShiCbO
         uQBu+AUTpIjM+/8xi3OP39FkwwDTNGt+JkJZqwaGI2GVqcilG03JLxr5+7hybQ9QgIGf
         X0tyJUFQB6trtbcw8W2uqaD/jvIgd/nMpAUB8G6qBDuFYSIE2rwKnSOwy9+hGNO1Kp3W
         bceLbZtZq6WLXjW63feJffFPwUg07P0PM5gYD80CQXDFFfz3Bu7ZFA5IuLEI8/CeUGl8
         PT84Xfj5SRLCBFJgapLN82POB7yhVOxVG2utXtkLRoIzh1m7Tbx63voY7Mct4HEXMmvi
         M9GA==
X-Gm-Message-State: AOJu0YzP2Z9EF6KTG+nhGjo0WP6DjeKQILKtMVrSXuwLNnZvuKJu/1vC
	vlGU1KzO9OIi+VQ4rrNEeP93o8WDNtVG1nIlK3GLGWoLwgYDj0TXWD1n5Ats
X-Google-Smtp-Source: AGHT+IG+sr5Okk4Mm72FGe+/e1W3NeLBUHsBx67hVffSytfvHpmd0qlBxsWQj82tIh57N0wcgfr5Aw==
X-Received: by 2002:a17:907:88d:b0:a30:6987:636c with SMTP id zt13-20020a170907088d00b00a306987636cmr37529ejb.137.1706141792148;
        Wed, 24 Jan 2024 16:16:32 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090699cb00b00a316896b4aesm217363ejn.80.2024.01.24.16.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:16:31 -0800 (PST)
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
Subject: [PATCH 6.6.y 11/17] bpf: extract setup_func_entry() utility function
Date: Thu, 25 Jan 2024 02:15:48 +0200
Message-ID: <20240125001554.25287-12-eddyz87@gmail.com>
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

[ Upstream commit 58124a98cb8e ]

Move code for simulated stack frame creation to a separate utility
function. This function would be used in the follow-up change for
callbacks handling.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231121020701.26440-6-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 84 ++++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dc03927a8540..9b763424875d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9186,11 +9186,10 @@ static int set_callee_state(struct bpf_verifier_env *env,
 			    struct bpf_func_state *caller,
 			    struct bpf_func_state *callee, int insn_idx);
 
-static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			     int *insn_idx, int subprog,
-			     set_callee_state_fn set_callee_state_cb)
+static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int callsite,
+			    set_callee_state_fn set_callee_state_cb,
+			    struct bpf_verifier_state *state)
 {
-	struct bpf_verifier_state *state = env->cur_state;
 	struct bpf_func_state *caller, *callee;
 	int err;
 
@@ -9200,13 +9199,53 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return -E2BIG;
 	}
 
-	caller = state->frame[state->curframe];
 	if (state->frame[state->curframe + 1]) {
 		verbose(env, "verifier bug. Frame %d already allocated\n",
 			state->curframe + 1);
 		return -EFAULT;
 	}
 
+	caller = state->frame[state->curframe];
+	callee = kzalloc(sizeof(*callee), GFP_KERNEL);
+	if (!callee)
+		return -ENOMEM;
+	state->frame[state->curframe + 1] = callee;
+
+	/* callee cannot access r0, r6 - r9 for reading and has to write
+	 * into its own stack before reading from it.
+	 * callee can read/write into caller's stack
+	 */
+	init_func_state(env, callee,
+			/* remember the callsite, it will be used by bpf_exit */
+			callsite,
+			state->curframe + 1 /* frameno within this callchain */,
+			subprog /* subprog number within this prog */);
+	/* Transfer references to the callee */
+	err = copy_reference_state(callee, caller);
+	err = err ?: set_callee_state_cb(env, caller, callee, callsite);
+	if (err)
+		goto err_out;
+
+	/* only increment it after check_reg_arg() finished */
+	state->curframe++;
+
+	return 0;
+
+err_out:
+	free_func_state(callee);
+	state->frame[state->curframe + 1] = NULL;
+	return err;
+}
+
+static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			     int *insn_idx, int subprog,
+			     set_callee_state_fn set_callee_state_cb)
+{
+	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_func_state *caller, *callee;
+	int err;
+
+	caller = state->frame[state->curframe];
 	err = btf_check_subprog_call(env, subprog, caller->regs);
 	if (err == -EFAULT)
 		return err;
@@ -9275,35 +9314,12 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return 0;
 	}
 
-	callee = kzalloc(sizeof(*callee), GFP_KERNEL);
-	if (!callee)
-		return -ENOMEM;
-	state->frame[state->curframe + 1] = callee;
-
-	/* callee cannot access r0, r6 - r9 for reading and has to write
-	 * into its own stack before reading from it.
-	 * callee can read/write into caller's stack
-	 */
-	init_func_state(env, callee,
-			/* remember the callsite, it will be used by bpf_exit */
-			*insn_idx /* callsite */,
-			state->curframe + 1 /* frameno within this callchain */,
-			subprog /* subprog number within this prog */);
-
-	/* Transfer references to the callee */
-	err = copy_reference_state(callee, caller);
+	err = setup_func_entry(env, subprog, *insn_idx, set_callee_state_cb, state);
 	if (err)
-		goto err_out;
-
-	err = set_callee_state_cb(env, caller, callee, *insn_idx);
-	if (err)
-		goto err_out;
+		return err;
 
 	clear_caller_saved_regs(env, caller->regs);
 
-	/* only increment it after check_reg_arg() finished */
-	state->curframe++;
-
 	/* and go analyze first insn of the callee */
 	*insn_idx = env->subprog_info[subprog].start - 1;
 
@@ -9311,14 +9327,10 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		verbose(env, "caller:\n");
 		print_verifier_state(env, caller, true);
 		verbose(env, "callee:\n");
-		print_verifier_state(env, callee, true);
+		print_verifier_state(env, state->frame[state->curframe], true);
 	}
-	return 0;
 
-err_out:
-	free_func_state(callee);
-	state->frame[state->curframe + 1] = NULL;
-	return err;
+	return 0;
 }
 
 int map_set_for_each_callback_args(struct bpf_verifier_env *env,
-- 
2.43.0


