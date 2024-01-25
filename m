Return-Path: <stable+bounces-15754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F65683B5FD
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E439728945C
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 00:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1442F23DE;
	Thu, 25 Jan 2024 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyIoMkIz"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B54380B
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141799; cv=none; b=Od9phEtqjuuOtoo/hufSQcU60WC3ABfykvDhVmknLNwsrwV9Dc09izYpMIneT99LI3RPhx071Pz+LLafmcxTFZgyr9ijLIyLSKPyrG4cUqakNri7dS5fXgNoQ2NDrCpv/oJZhnwT+MR412g5DOVJ30xf8QlhiLIKznhqQ7eSHbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141799; c=relaxed/simple;
	bh=H5xeDwBewxypBPDJEiJla7OreEEBWJBzoutHQsVMWo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kodpD9asbmVZU3qozUcYpmW8OvIINK7EaxIDzkirDGEGU8nIJKa90vlNQXP8ECoY2M9gEIxfhur7/qfD/duEoANpni9A/qrdZntVw+gj9uv9hHDA1awZy/oZDiSUCMp32J4amkLadErSBxKR/9Bd+UZvilBIGhOdO9YTTyeu4xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyIoMkIz; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so6872032e87.3
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 16:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706141796; x=1706746596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6mvjxAsJYZREY38ksXXp6hYALjLlejCbiKbOGggEE8=;
        b=MyIoMkIztM63ZM1CH5QKw+BbF4SywPlRdtutsSKnrXcxwNCF2N7FImhwPpt0l1W+UO
         rNjoHTKq714q+XwhTnyh6GzGeO/w3DrBdK3eJotlXeucZCUDNu7NYcBGV4yocoGSPiEx
         4T4w1Km4tuXdXFZl3NkMhlVFtmz52wxfevATgtR63NHZieBiI3w3+InW1l3waDRvXz39
         UTTvtMDf+1mBME7XXIs4GZal/kEE3Ydz2cBLklUQpYswi/Ap05t5CSowlIU3D+TEOifV
         EAYMRhwPXGgl0j3hpvGlNj2tG/SswqmLcbwTtwE1QdIgurHwWWUMNn8UVz1qd+Y33Qsk
         1QRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141796; x=1706746596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6mvjxAsJYZREY38ksXXp6hYALjLlejCbiKbOGggEE8=;
        b=s8odk/vflp1HUCw9iGf8GzvfYX1JthhofNnahrmTneUDwY+NpbYjscuv1/bIJ/+OZx
         +/vcJEUS6INNGJS3MRC4GQLksc2FpcRDNUkROZDrhJl5HU62gEMWsdt4T0cMQwtBTibw
         HB4yEfW0oIpWficeY7OLvbrmGvUzzVhxkq2KNzxrf/bOK/tJOV83h4c1GXYQQjQ+ZcQR
         mOp1OhN1pxMHYLzI0OUmL0VJpuirzUgkBgsS+UxX8HHwH7R6BAUs7vilD9NvLJT5yu0I
         IgLN6k9nfHwEp93siIe9juzid5RSgnlZwDEJHrwKUvPEDOn0vvJdbvc+gh8ek/arG6Kq
         LYaw==
X-Gm-Message-State: AOJu0YwgzYjtekUfGPyrPUJcJ+VqZjrkdu0q1CmjXe36BMdTFhP0mlQR
	XFOPuOBmZm9aFRzVr+yJ8UvQVgjCkrb4egBQVVqk7/3QlWsR7fH82AkgYY0x
X-Google-Smtp-Source: AGHT+IHZuBVJ1Gk0Hj94cb2/6aKPL9Rm+GMr/aT/gQB3rZeXrxGm3nnRvoI/8jfCGLHv69Y2astm/g==
X-Received: by 2002:ac2:59c3:0:b0:510:c87:887f with SMTP id x3-20020ac259c3000000b005100c87887fmr26615lfn.128.1706141795748;
        Wed, 24 Jan 2024 16:16:35 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090699cb00b00a316896b4aesm217363ejn.80.2024.01.24.16.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:16:35 -0800 (PST)
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
Subject: [PATCH 6.6.y 14/17] bpf: widening for callback iterators
Date: Thu, 25 Jan 2024 02:15:51 +0200
Message-ID: <20240125001554.25287-15-eddyz87@gmail.com>
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

[ Upstream commit cafe2c21508a ]

Callbacks are similar to open coded iterators, so add imprecise
widening logic for callback body processing. This makes callback based
loops behave identically to open coded iterators, e.g. allowing to
verify programs like below:

  struct ctx { u32 i; };
  int cb(u32 idx, struct ctx* ctx)
  {
          ++ctx->i;
          return 0;
  }
  ...
  struct ctx ctx = { .i = 0 };
  bpf_loop(100, cb, &ctx, 0);
  ...

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231121020701.26440-9-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0eb0de55a443..638ab1fdf214 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9614,9 +9614,10 @@ static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
 
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 {
-	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_verifier_state *state = env->cur_state, *prev_st;
 	struct bpf_func_state *caller, *callee;
 	struct bpf_reg_state *r0;
+	bool in_callback_fn;
 	int err;
 
 	callee = state->frame[state->curframe];
@@ -9671,7 +9672,8 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	 * there function call logic would reschedule callback visit. If iteration
 	 * converges is_state_visited() would prune that visit eventually.
 	 */
-	if (callee->in_callback_fn)
+	in_callback_fn = callee->in_callback_fn;
+	if (in_callback_fn)
 		*insn_idx = callee->callsite;
 	else
 		*insn_idx = callee->callsite + 1;
@@ -9685,6 +9687,24 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	/* clear everything in the callee */
 	free_func_state(callee);
 	state->frame[state->curframe--] = NULL;
+
+	/* for callbacks widen imprecise scalars to make programs like below verify:
+	 *
+	 *   struct ctx { int i; }
+	 *   void cb(int idx, struct ctx *ctx) { ctx->i++; ... }
+	 *   ...
+	 *   struct ctx = { .i = 0; }
+	 *   bpf_loop(100, cb, &ctx, 0);
+	 *
+	 * This is similar to what is done in process_iter_next_call() for open
+	 * coded iterators.
+	 */
+	prev_st = in_callback_fn ? find_prev_entry(env, state, *insn_idx) : NULL;
+	if (prev_st) {
+		err = widen_imprecise_scalars(env, prev_st, state);
+		if (err)
+			return err;
+	}
 	return 0;
 }
 
-- 
2.43.0


