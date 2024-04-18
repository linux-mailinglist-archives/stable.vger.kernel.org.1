Return-Path: <stable+bounces-40225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A238AA5B8
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 01:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220A71C21311
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 23:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC187E572;
	Thu, 18 Apr 2024 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bOP8PL3X"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7497C0A9
	for <stable@vger.kernel.org>; Thu, 18 Apr 2024 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713482439; cv=none; b=iHYNjUGTFwQyepY5dZX4VmF7XUn80LBe4usex9FY/aTZiFFXVokqUcEJhnAFF1vOcRUc2+gkFiuuzwurTIAK8mT9wJcgbhoTXWOSBHILA98Jt1eOw8RV/n7H9x8j0bDzkfkZeeUqOXTqht0H3O06Kq8ngbFwxm6JZ3Z3+plmTVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713482439; c=relaxed/simple;
	bh=YScO9mwjaHbzHT2vhYW5LqoeHviUzo+lvVpjgG9XQ3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pU+Kt5vka++u2urGTIaWRBK+M/VbCf6JUrHqUfBc9oP9+TvjE0ApDnHY1Ytkxl923Ht3Ze0l8eJmAdbACpgyxCOGNQkUdkLxlLfSfLjwmNVwK9Y/M4i+3WCo3ADGGE7UoUF+FgtmOpKgmU2f5v+5kITgHiaHWZATfg7URpoJTvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bOP8PL3X; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5f7c0bb1b95so407800a12.0
        for <stable@vger.kernel.org>; Thu, 18 Apr 2024 16:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713482437; x=1714087237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ntuKGIhl78pmHpDhVuljrWxMFgXG8nBQtJyZ9nYPDms=;
        b=bOP8PL3XR0DC/rTW78tXLGR6vqh7Veh92D6h8d+08KYFmIRuD1iQkxjLpZmfwSSkVY
         kvyjtEBfnXMf7abGl3KkiQPUbO4MVSApnm9b2NVV3SlI108G8B0xxZlDV6eePaeDH3/V
         5gf41+Np+CsZVEoWLpEZcyRgv655Ubx7asor4IYhWdu+BTNv7iB0I60f8yzKuwdPkj6l
         PrmZsmPgeirjoNqGJxDcqad2zDD7OaGCm1l3g2jBBDwz7jrf467cWp1E/nn9K5altEBH
         /jyHq5n0odgbEGvmedpJGeV21BzPywK0QyI43Mk6ekB4Q2BNi+M2Rg+BmfdJ9RBPjU5Q
         p4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713482437; x=1714087237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntuKGIhl78pmHpDhVuljrWxMFgXG8nBQtJyZ9nYPDms=;
        b=Si8TmnDn7tK1nxCThAldcPjKxR2HdnBUeepZKXWmL0Uhj8x/y8tzi+zDxBFHfKJysM
         KcNZ1J2oKDyrB+IynjGa/rVFBbqIk5OAy6QQ49+m/v0aEKfi5cqZQUfkZKNZFn/rDVa0
         O3iStGKXbU/Ex8AeHuAGPpOjEmpJHye/LaafQZdQfoeTu7BQ4D4fe8ArgKYgyD+nwhvn
         7s0F3Zi4x7MFdaxyCp4Z8XOaeCSOcUzTsJpk9Hwz7V82kH4YCCaMTT79KuaiR7c1C9NZ
         XfavFY3eHdMdXmG3+bIQDYoFOzuHpoJloqGaL8luheE7FxyPaoZuTD6VghU8BsO11UNp
         +85g==
X-Gm-Message-State: AOJu0YzIQ3gPw6TCRZW2tiVErvygWnJmi4Trhv96Xcco1c8NoQyzC25y
	IOqfKu5lISFhpaYNG+VWIGt+zJIT7YkBwOg1JBN27R/UA8EZI2FcuXjfKybGA0lV+XJopsvHgbR
	JzPIHD4JMz3QSWGS3MoxC1BRtZ0i8bJgbOlWYX/iTB/+mfODRWPyWg0IgSOInklR0Hi19TCCoKA
	jeHy4ntoLlONPQhJ/y++OAbNmNKnyISZOg
X-Google-Smtp-Source: AGHT+IGX3+sK2ZbRibyfYYT7GKwhF6+fOJueP20+WYShxN73szU+fckNs7zUrZwu4bQuzEjoGpGQlExREJI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:8a96:b0:2aa:ab39:fcb6 with SMTP id
 x22-20020a17090a8a9600b002aaab39fcb6mr8739pjn.1.1713482436246; Thu, 18 Apr
 2024 16:20:36 -0700 (PDT)
Date: Thu, 18 Apr 2024 23:19:49 +0000
In-Reply-To: <20240418232005.34244-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com> <20240418232005.34244-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418232005.34244-4-edliaw@google.com>
Subject: [PATCH 5.15.y v3 3/5] bpf: Generally fix helper register offset check
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, Yonghong Song <yhs@fb.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Daniel Borkmann <daniel@iogearbox.net>

Right now the assertion on check_ptr_off_reg() is only enforced for register
types PTR_TO_CTX (and open coded also for PTR_TO_BTF_ID), however, this is
insufficient since many other PTR_TO_* register types such as PTR_TO_FUNC do
not handle/expect register offsets when passed to helper functions.

Given this can slip-through easily when adding new types, make this an explicit
allow-list and reject all other current and future types by default if this is
encountered.

Also, extend check_ptr_off_reg() to handle PTR_TO_BTF_ID as well instead of
duplicating it. For PTR_TO_BTF_ID, reg->off is used for BTF to match expected
BTF ids if struct offset is used. This part still needs to be allowed, but the
dynamic off from the tnum must be rejected.

Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
Fixes: eaa6bcb71ef6 ("bpf: Introduce bpf_per_cpu_ptr()")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
(cherry picked from commit 6788ab23508bddb0a9d88e104284922cb2c22b77)
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 kernel/bpf/verifier.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6fe805b559c0..8cd265d1df34 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3980,14 +3980,15 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 }
 #endif
 
-int check_ptr_off_reg(struct bpf_verifier_env *env,
-		      const struct bpf_reg_state *reg, int regno)
+static int __check_ptr_off_reg(struct bpf_verifier_env *env,
+			       const struct bpf_reg_state *reg, int regno,
+			       bool fixed_off_ok)
 {
 	/* Access to this pointer-typed register or passing it to a helper
 	 * is only allowed in its original, unmodified form.
 	 */
 
-	if (reg->off) {
+	if (!fixed_off_ok && reg->off) {
 		verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
 			reg_type_str(env, reg->type), regno, reg->off);
 		return -EACCES;
@@ -4005,6 +4006,12 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
 	return 0;
 }
 
+int check_ptr_off_reg(struct bpf_verifier_env *env,
+		      const struct bpf_reg_state *reg, int regno)
+{
+	return __check_ptr_off_reg(env, reg, regno, false);
+}
+
 static int __check_buffer_access(struct bpf_verifier_env *env,
 				 const char *buf_info,
 				 const struct bpf_reg_state *reg,
@@ -5267,12 +5274,6 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 				kernel_type_name(btf_vmlinux, *arg_btf_id));
 			return -EACCES;
 		}
-
-		if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
-			verbose(env, "R%d is a pointer to in-kernel struct with non-zero offset\n",
-				regno);
-			return -EACCES;
-		}
 	}
 
 	return 0;
@@ -5327,10 +5328,26 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	if (err)
 		return err;
 
-	if (type == PTR_TO_CTX) {
-		err = check_ptr_off_reg(env, reg, regno);
+	switch ((u32)type) {
+	case SCALAR_VALUE:
+	/* Pointer types where reg offset is explicitly allowed: */
+	case PTR_TO_PACKET:
+	case PTR_TO_PACKET_META:
+	case PTR_TO_MAP_KEY:
+	case PTR_TO_MAP_VALUE:
+	case PTR_TO_MEM:
+	case PTR_TO_MEM | MEM_RDONLY:
+	case PTR_TO_BUF:
+	case PTR_TO_BUF | MEM_RDONLY:
+	case PTR_TO_STACK:
+		break;
+	/* All the rest must be rejected: */
+	default:
+		err = __check_ptr_off_reg(env, reg, regno,
+					  type == PTR_TO_BTF_ID);
 		if (err < 0)
 			return err;
+		break;
 	}
 
 skip_type_check:
-- 
2.44.0.769.g3c40516874-goog


