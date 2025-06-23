Return-Path: <stable+bounces-155353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 069B7AE3EAC
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88521188B39E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3661E24113C;
	Mon, 23 Jun 2025 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RvnXZ0R9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89520188CC9
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679668; cv=none; b=Rsc/ohc+XyBkNfn/wG1sH4iwthLQUSDuL86llFN/Nb5kmxQyOFne+NZ/h6+VzlR8JLw9Sw8Z7vboybHG9ITeKoHtYLUnVOUuiamF5YYf1c4kPyyyZRrAT2+UZIdByZ/9We1HtN9I8ZIPcIJDaahGD0OtVvTVKmyNJN/29DUCcxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679668; c=relaxed/simple;
	bh=KeP9liCp3imk3Tj14AFdHv5PAQCRRV3r6p9SHwqYU/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IMoOC+1eCvjm7iT267p5T48eKQtVsGZqU9546xVmM0twPYevN5KMXZaoyIWXBDwIa5P1MsYxf/e1xu1An44ZtTyjU/TiqAiLBzX/LHP3erVyqjNTDr4t/jGZ89mLZQlrtFr9QC+ApqbvQSwmHJkgsSSjdtorFifoQTHigq9//5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RvnXZ0R9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-747c2cc3419so2752475b3a.2
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 04:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750679666; x=1751284466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyBpGH5C+Pee3RznfjMA8JxIbrUi1h7FPsXKVt/5m4E=;
        b=RvnXZ0R9IpHLlHi0W/6PxGcRedw50pQayu8dStn2jqFumqjn9zG7ECDXvpgjeVSySm
         C9iY2znbrfziLQ5Xg7acnqLtps6cwifxY6yJz5St744x/rscCn5nppnQW8E8/JlLRbY/
         mZLHrn0I3g0k5VaYq1rh8VjpjFKt0lIGbv7CqocjzHUeHuHopNHKF1aekP+p3ZBjZKIa
         QnqoqgKiOjus4on98GGWKTvBvKXWsxOPX/H0rCWGeZQUzIkD1VhhIy0WFOW89zaGeeY/
         LrCiMa+iWXn8Zq4zl+YafuDED7YtQXf7wMifBtc3PEGqT7W0drb0gzcaIOcrlQeMKOA8
         2lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750679666; x=1751284466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyBpGH5C+Pee3RznfjMA8JxIbrUi1h7FPsXKVt/5m4E=;
        b=QGH1gZrHIQF6AaGS+VZhOZc+k7u0L1uTHjSksAvJV+oG8mukBRTjfRXMFNWsIbBhVA
         CBZOh6SSvnzSONEd4ZtceQsmD82M64bC0zYFODpEhGPJfmIt/aX+RyvEwWU/wZK+YHIW
         MqMQTWFmspZuMvgsUJuzRv/XFNrt8C8wbXqJTPCVKyVDEWhRrX7K9GzLHmGQUhpTanPh
         vW6pXXQfeIA+QDR7ZDZzPvsfqhw0XLgAelF1J9yMIE9w++fpjxJi6uRQt2+w4kSskybt
         sj41AX5UntFM1GA9HGYD+mtZYIqgyE1JYammoJZWOrl6WfsQz04Ah+Jnl2LaXBzbV4T/
         C4WA==
X-Gm-Message-State: AOJu0Yzx12TlFKGLU2ks3GALdWNz8HZhcXzjeATrgvfoGZ57uEW/aKsU
	luQPT/QAU5t25iSvK2nFBVPZA4VqXQPw2rii2Sp9ceemoYvYFFiAMnxY9pfTNG4vHw==
X-Gm-Gg: ASbGncvCHkU6UGzsKHM9VPY9xLOcQhlpOiXA9W7+pi7xrOk6tJZeS31FbALVAEfjl3N
	vEu96DQZEqRzgNr36b7Z3Qhmr7aW3FF/1v10v2xNlN2nwjtOZ5yzMKG4thbbgJC7xMnMyC+RL3R
	0xy5FSAj03ne5SW9uv7PqEVDnTjKwtjSI81VZeIt9mS94GGaSmv8hcZDBIqn+n+4s49AzZRwTCZ
	NgYeqLxBiBTjXBcTU4jmd9XcnLW06gMtxu5Amchmbd9pVYBW8hcmTgTTwqQCplsqZJQxWFYKx36
	GGlXWcyXeCJfwAdjUFj971WMAnKwJLNtvR9kUe20TAG7uX6zkk8d0J7Meka4ypX1McbyVaHThWB
	qGFjiLFAUkm0+y7WvGaTUyQ8lbOtys2Wo
X-Google-Smtp-Source: AGHT+IFkymzGzalnUpJAKrDtfTWqfxr9cUv/OA1cC1QIOwc4SZuKx47GKig6WY079dAnCpLI+SyM0Q==
X-Received: by 2002:a05:6300:6a06:b0:220:631c:e090 with SMTP id adf61e73a8af0-220631ce382mr1227273637.0.1750679665762;
        Mon, 23 Jun 2025 04:54:25 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f12427b7sm6597716a12.40.2025.06.23.04.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 04:54:25 -0700 (PDT)
From: Aaron Lu <ziqianlu@bytedance.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Luiz Capitulino <luizcap@amazon.com>,
	Wei Wei <weiwei.danny@bytedance.com>,
	Yuchen Zhang <zhangyuchen.lcr@bytedance.com>
Subject: [PATCH 2/4] Revert "bpf: aggressively forget precise markings during state checkpointing"
Date: Mon, 23 Jun 2025 19:54:01 +0800
Message-Id: <20250623115403.299-3-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250623115403.299-1-ziqianlu@bytedance.com>
References: <20250623115403.299-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 1952a4d5e4cf610336b9c9ab52b1fc4e42721cf3.

The backport of bpf precision tracking related changes has caused bpf
verifier to panic while loading some certain bpf prog so revert them.

Link: https://lkml.kernel.org/r/20250605070921.GA3795@bytedance/
Reported-by: Wei Wei <weiwei.danny@bytedance.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/bpf/verifier.c | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e6d50e371a2b8..b3cbfda41d9cf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2053,31 +2053,6 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 	}
 }
 
-static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
-{
-	struct bpf_func_state *func;
-	struct bpf_reg_state *reg;
-	int i, j;
-
-	for (i = 0; i <= st->curframe; i++) {
-		func = st->frame[i];
-		for (j = 0; j < BPF_REG_FP; j++) {
-			reg = &func->regs[j];
-			if (reg->type != SCALAR_VALUE)
-				continue;
-			reg->precise = false;
-		}
-		for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
-			if (!is_spilled_reg(&func->stack[j]))
-				continue;
-			reg = &func->stack[j].spilled_ptr;
-			if (reg->type != SCALAR_VALUE)
-				continue;
-			reg->precise = false;
-		}
-	}
-}
-
 /*
  * __mark_chain_precision() backtracks BPF program instruction sequence and
  * chain of verifier states making sure that register *regno* (if regno >= 0)
@@ -2156,14 +2131,6 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
  * be imprecise. If any child state does require this register to be precise,
  * we'll mark it precise later retroactively during precise markings
  * propagation from child state to parent states.
- *
- * Skipping precise marking setting in current state is a mild version of
- * relying on the above observation. But we can utilize this property even
- * more aggressively by proactively forgetting any precise marking in the
- * current state (which we inherited from the parent state), right before we
- * checkpoint it and branch off into new child state. This is done by
- * mark_all_scalars_imprecise() to hopefully get more permissive and generic
- * finalized states which help in short circuiting more future states.
  */
 static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int regno,
 				  int spi)
@@ -9928,10 +9895,6 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	env->prev_jmps_processed = env->jmps_processed;
 	env->prev_insn_processed = env->insn_processed;
 
-	/* forget precise markings we inherited, see __mark_chain_precision */
-	if (env->bpf_capable)
-		mark_all_scalars_imprecise(env, cur);
-
 	/* add new state to the head of linked list */
 	new = &new_sl->state;
 	err = copy_verifier_state(new, cur);
-- 
2.39.5


