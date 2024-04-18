Return-Path: <stable+bounces-40224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3135C8AA5B6
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 01:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF981F21E25
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 23:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0103C7D40D;
	Thu, 18 Apr 2024 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wn1cqSZY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742A97C6C8
	for <stable@vger.kernel.org>; Thu, 18 Apr 2024 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713482435; cv=none; b=aF51HdwS0ApwF9IVrLuBg0EcX1NZiMtocWACBQdcoDRsaGoqiluV6LccXlyP4G8kwBYhbn1LtM+Ci3KQG2Fo4GkJ5WcQdfiep1sOZEvDn9oeIXs63JmNhPrfGsEmRx70w3dbbAwSeJQ7mI1zKeyMMdfHsqIpJQXqNQ0eRKlXmDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713482435; c=relaxed/simple;
	bh=7WAgsmWa8I2nRXxoayOV0F/ehsyZq3cQzYa0hL40wdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DcGF+v3fX8hvy1nm7tst+BQQ0lHCRrjxR81tndsugb334hcOAK/1Klp/J/0balBLtk4D5/bfzqbfKuHOldjoUX5PxCC0oXDiav6Q8+B6vLYFEJkn5AlS0ntnDJJbqKfNxlrIj5vTlGBZ18kUejJ4asaSoZ5XtU/YQ7suxNzwnrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wn1cqSZY; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a482a2360aso2221469a91.0
        for <stable@vger.kernel.org>; Thu, 18 Apr 2024 16:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713482434; x=1714087234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PJWz1uvQTzKPjGuvX+wqPQBpUoIACARU5eow85W6RVU=;
        b=Wn1cqSZYBLfNCNqOAINIlHUAdbOOGyhXkGHgl9cLvQxViuUYaGr06tM6wUhcLiMX3i
         4Pk8mHpvenqB1RGADv76uCX0suHgtTENJoR99j2dCq3PXoCqgSYcURorldPGIoVt0LVj
         Tt1SqmXd1v6GMYIVLvzOR7oKwL6e6mj5kwCfDClCI1WU02LKXOdxQ755aTGePCuMtmQO
         i1HtVOVrQqa+epa8W9rwmkMeU4Te0pZ8mgGrs4hPbT2CIRzIwho5XWQR9WIdotswiQqI
         4hBB0a8GC4aLHXKLMSC2wGuN/4lBaY4BQaiiBBNd2uWzKebHjJvYQTgcUwa3Gy1mjC9q
         JRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713482434; x=1714087234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJWz1uvQTzKPjGuvX+wqPQBpUoIACARU5eow85W6RVU=;
        b=CKZSErQmcfjcsynyI+1OcBX0EySnh2yC9Us4fbFEgGC28OPFDw7Bxe1fUV7tDmQUZp
         Yei55uDLSvFagKRD2tBm7/pdv3D8S60LvsODzYJGytWDm16nSUJxn54l0mFLAdIbPCaz
         fdxDX0eawrwimj+WpQilb7dN91pIeWcRpr3q6N0/hCI7jloFDuzIi1nNIBsDZG6xZSRk
         fQEcGOp6YVNskh62CEaak5kZN5ygJTjardUEdCv1P5XzPnvpd1eOH9m2OqJ4PFfeE3xe
         u680EfPtvnN2lbBORadqb61b15QWCWW2fHBqy0TIcxJdLRimq9Nnkuz+eECxY/3GO6Bj
         MjkA==
X-Gm-Message-State: AOJu0Yy5iA2aLjGQ7L2Pk86s9Hlly+6+YPB/Xpm8oNvf/cmSIjDlaDPG
	rz1BsRx+ZGfZjDKnjyEVqCK7MSaL4XajtFNmFfBk62jz+7JeNB7+qtPD57hkvsUWCsbJfiJxLFb
	ZYzLIZjcymuhqo88Z8jb9AYFdEcAbRsKJaGiAPSDILAEU/D7cTys8Vg0yubJqzqOQpHSIBGY0tv
	6iHkIMborU/K7UnGOMygigW44DUaoeSYeE
X-Google-Smtp-Source: AGHT+IGZvpipb458KhuKNr2lT6l2L7v8w6uv6b7TY6/fKUTAKy1KSarqOpYJWvLTO6PRPcEY1aRIn/XdgRg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:3d4f:b0:2a2:bcae:83c1 with SMTP id
 o15-20020a17090a3d4f00b002a2bcae83c1mr28422pjf.3.1713482432421; Thu, 18 Apr
 2024 16:20:32 -0700 (PDT)
Date: Thu, 18 Apr 2024 23:19:48 +0000
In-Reply-To: <20240418232005.34244-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com> <20240418232005.34244-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418232005.34244-3-edliaw@google.com>
Subject: [PATCH 5.15.y v3 2/5] bpf: Generalize check_ctx_reg for reuse with
 other types
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

Generalize the check_ctx_reg() helper function into a more generic named one
so that it can be reused for other register types as well to check whether
their offset is non-zero. No functional change.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
(cherry picked from commit be80a1d3f9dbe5aee79a325964f7037fe2d92f30)
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 include/linux/bpf_verifier.h |  4 ++--
 kernel/bpf/btf.c             |  2 +-
 kernel/bpf/verifier.c        | 21 +++++++++++----------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3d04b48e502d..c0993b079ab5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -541,8 +541,8 @@ bpf_prog_offload_replace_insn(struct bpf_verifier_env *env, u32 off,
 void
 bpf_prog_offload_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt);
 
-int check_ctx_reg(struct bpf_verifier_env *env,
-		  const struct bpf_reg_state *reg, int regno);
+int check_ptr_off_reg(struct bpf_verifier_env *env,
+		      const struct bpf_reg_state *reg, int regno);
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		   u32 regno, u32 mem_size);
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 77929fd7bcef..a0c7e13e0ab4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5558,7 +5558,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 					i, btf_type_str(t));
 				return -EINVAL;
 			}
-			if (check_ctx_reg(env, reg, regno))
+			if (check_ptr_off_reg(env, reg, regno))
 				return -EINVAL;
 		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID ||
 			   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type)))) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 008ddb694c8a..6fe805b559c0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3980,16 +3980,16 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 }
 #endif
 
-int check_ctx_reg(struct bpf_verifier_env *env,
-		  const struct bpf_reg_state *reg, int regno)
+int check_ptr_off_reg(struct bpf_verifier_env *env,
+		      const struct bpf_reg_state *reg, int regno)
 {
-	/* Access to ctx or passing it to a helper is only allowed in
-	 * its original, unmodified form.
+	/* Access to this pointer-typed register or passing it to a helper
+	 * is only allowed in its original, unmodified form.
 	 */
 
 	if (reg->off) {
-		verbose(env, "dereference of modified ctx ptr R%d off=%d disallowed\n",
-			regno, reg->off);
+		verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
+			reg_type_str(env, reg->type), regno, reg->off);
 		return -EACCES;
 	}
 
@@ -3997,7 +3997,8 @@ int check_ctx_reg(struct bpf_verifier_env *env,
 		char tn_buf[48];
 
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-		verbose(env, "variable ctx access var_off=%s disallowed\n", tn_buf);
+		verbose(env, "variable %s access var_off=%s disallowed\n",
+			reg_type_str(env, reg->type), tn_buf);
 		return -EACCES;
 	}
 
@@ -4447,7 +4448,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return -EACCES;
 		}
 
-		err = check_ctx_reg(env, reg, regno);
+		err = check_ptr_off_reg(env, reg, regno);
 		if (err < 0)
 			return err;
 
@@ -5327,7 +5328,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return err;
 
 	if (type == PTR_TO_CTX) {
-		err = check_ctx_reg(env, reg, regno);
+		err = check_ptr_off_reg(env, reg, regno);
 		if (err < 0)
 			return err;
 	}
@@ -9561,7 +9562,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			return err;
 	}
 
-	err = check_ctx_reg(env, &regs[ctx_reg], ctx_reg);
+	err = check_ptr_off_reg(env, &regs[ctx_reg], ctx_reg);
 	if (err < 0)
 		return err;
 
-- 
2.44.0.769.g3c40516874-goog


