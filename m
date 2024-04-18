Return-Path: <stable+bounces-40223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621E08AA5B1
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 01:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C351C213C5
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 23:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9A37C081;
	Thu, 18 Apr 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FzIZJXBF"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06767BAFF
	for <stable@vger.kernel.org>; Thu, 18 Apr 2024 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713482431; cv=none; b=A43faipV19+mI2mn+XMTbcxZyIRfSYqN12er1t2+ZpJYIsmCAewUN3L4Y1lhaK4nMJqVUGp6o2RJYF+1qGN7Ne46V3qEnDpVcfve71GZ3T6YmncI23Z3GfzgGQT9DYTYb7Zu85cMWyBbTNI0GQVA4RdPlOALWnmPxIVYJewfLvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713482431; c=relaxed/simple;
	bh=NcUgjEVg58kGwkb+Jw41HUS9kEgKKWzCNIba4ZWXv2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=evyaYOWlUsIGSGtENZCopxCVufgnY/xnWYTXxWmYUay0xKkXThPI4nfnxqMUco1JbPFSWP8MWKaYnxVmtO3qtcfvn+PIMhvkNTcnB0aljSABipJRTUwUo+MMtiJ55Z3MmQeDstk0t6FWGKPu8dmCRnCaOcwfyq5Ggkjv/cbcHNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FzIZJXBF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de465062289so2911534276.2
        for <stable@vger.kernel.org>; Thu, 18 Apr 2024 16:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713482429; x=1714087229; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q/YC6vY8cZ2knPVqCxWC6lAFUPFp69AYOLfV73QO6KQ=;
        b=FzIZJXBFyFmrcer/bdMc2JFypVvw1YB7ttspdMZ0+nN2wlKZlgO8oWgc5VE9Agp30a
         F9Sp6yEgM1Isja9bBomapgvRaobhdJXN6BSL71uSoDvoIbV4pJsucI7lB9VM//G7e5fj
         gR/JhXJUfo7phUwMgrOvLF99SWKJgGJVcnyL5JIO6tU++r/5HuY1jIGRyh0HkLT/UGZG
         PjUwtD9B3yAmUgs1j/lfweJHacCcX5XSuWjt3vGHaikRM6pMWAviBhXYPOLrR+trOHII
         niIL/HHqLw7Isf+09fA3SE2sVCa2Xdd4s3iEzTluGQrAxvhp+yTw/ewPw3MxU7k5ZfY+
         Knkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713482429; x=1714087229;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/YC6vY8cZ2knPVqCxWC6lAFUPFp69AYOLfV73QO6KQ=;
        b=IOy87ZCtJsrjG38WT2BcvVFZ4pHC/DzR39+zyIK0oLhtUD05E0sU8tckgb8KedqwiD
         CWdRjk4HWLtsMQW05swmys8DnZoiUHlrBzsBF5XFXIetFv5X9hozX8OxZjVviJiiTSef
         sAdATqjpq8yt2P7SnR9ARkY0cMzpi5nCnK8qiDdMXLfzyqDwmjdB2OBh6Q2Dw3pErKzN
         YSoOUjG8MBRJVKuLfzoIVXBhxqvbyxD0hcx2EeHJSXR1md7lByL3eY9dJ3l4Ew+1imSw
         qUXyoEM1gjX6eMEagkKylAzZTx+7jUzZeOvxKlnfE8lH0as0IaZCnB7LMlPIPOi31bRp
         f5Vw==
X-Gm-Message-State: AOJu0Yyr7jjcl1pCqtO2/WhERlRBfyUolp+l8HEZRO1XePmrW6rWyIZG
	QX9eB0hw5hAgEhhz86yGqXrE3xWuDElzYnxR/SqCcfnv0SjNK16aCFh1+tgbBkmp0/k15f0BDAz
	o8A5MM1SnpZAz999rcuJHWJfhKxtE1ruKccL2+edHjdWaSyFSFTkeVmyZiktXtG9Xb9ct169U39
	UiGiWKUrzw+WktsvrYXgxxfFMU449qJ57a
X-Google-Smtp-Source: AGHT+IHrxrrNUKm29ldT/oIgtUJU7kmFT8cDAHOqQdXSx4NR3b72oYNNm2fwp/UDMHZjPkZRE+Y5djysHRQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:fc04:0:b0:dc6:cafd:dce5 with SMTP id
 v4-20020a25fc04000000b00dc6cafddce5mr91879ybd.12.1713482428464; Thu, 18 Apr
 2024 16:20:28 -0700 (PDT)
Date: Thu, 18 Apr 2024 23:19:47 +0000
In-Reply-To: <20240418232005.34244-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com> <20240418232005.34244-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418232005.34244-2-edliaw@google.com>
Subject: [PATCH 5.15.y v3 1/5] bpf: Extend kfunc with PTR_TO_CTX, PTR_TO_MEM
 argument support
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, Yonghong Song <yhs@fb.com>, linux-kernel@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Allow passing PTR_TO_CTX, if the kfunc expects a matching struct type,
and punt to PTR_TO_MEM block if reg->type does not fall in one of
PTR_TO_BTF_ID or PTR_TO_SOCK* types. This will be used by future commits
to get access to XDP and TC PTR_TO_CTX, and pass various data (flags,
l4proto, netns_id, etc.) encoded in opts struct passed as pointer to
kfunc.

For PTR_TO_MEM support, arguments are currently limited to pointer to
scalar, or pointer to struct composed of scalars. This is done so that
unsafe scenarios (like passing PTR_TO_MEM where PTR_TO_BTF_ID of
in-kernel valid structure is expected, which may have pointers) are
avoided. Since the argument checking happens basd on argument register
type, it is not easy to ascertain what the expected type is. In the
future, support for PTR_TO_MEM for kfunc can be extended to serve other
usecases. The struct type whose pointer is passed in may have maximum
nesting depth of 4, all recursively composed of scalars or struct with
scalars.

Future commits will add negative tests that check whether these
restrictions imposed for kfunc arguments are duly rejected by BPF
verifier or not.

[edliaw: merged with changes from 45ce4b4f90091 ("bpf: Fix crash due to
 out of bounds access into reg2btf_ids.") and f858c2b2ca04 ("bpf: Fix
 calling global functions from BPF_PROG_TYPE_EXT programs")]

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20211217015031.1278167-4-memxor@gmail.com
(cherry picked from commit 3363bd0cfbb80dfcd25003cd3815b0ad8b68d0ff)
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 kernel/bpf/btf.c | 93 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5d4bea53ac1f..77929fd7bcef 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5447,6 +5447,46 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 #endif
 };

+/* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
+static bool __btf_type_is_scalar_struct(struct bpf_verifier_log *log,
+					const struct btf *btf,
+					const struct btf_type *t, int rec)
+{
+	const struct btf_type *member_type;
+	const struct btf_member *member;
+	u32 i;
+
+	if (!btf_type_is_struct(t))
+		return false;
+
+	for_each_member(i, t, member) {
+		const struct btf_array *array;
+
+		member_type = btf_type_skip_modifiers(btf, member->type, NULL);
+		if (btf_type_is_struct(member_type)) {
+			if (rec >= 3) {
+				bpf_log(log, "max struct nesting depth exceeded\n");
+				return false;
+			}
+			if (!__btf_type_is_scalar_struct(log, btf, member_type, rec + 1))
+				return false;
+			continue;
+		}
+		if (btf_type_is_array(member_type)) {
+			array = btf_type_array(member_type);
+			if (!array->nelems)
+				return false;
+			member_type = btf_type_skip_modifiers(btf, array->type, NULL);
+			if (!btf_type_is_scalar(member_type))
+				return false;
+			continue;
+		}
+		if (!btf_type_is_scalar(member_type))
+			return false;
+	}
+	return true;
+}
+
 static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				    const struct btf *btf, u32 func_id,
 				    struct bpf_reg_state *regs,
@@ -5455,6 +5495,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 	enum bpf_prog_type prog_type = env->prog->type == BPF_PROG_TYPE_EXT ?
 		env->prog->aux->dst_prog->type : env->prog->type;
 	struct bpf_verifier_log *log = &env->log;
+	bool is_kfunc = btf_is_kernel(btf);
 	const char *func_name, *ref_tname;
 	const struct btf_type *t, *ref_t;
 	const struct btf_param *args;
@@ -5507,7 +5548,20 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,

 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
-		if (btf_is_kernel(btf)) {
+		if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
+			/* If function expects ctx type in BTF check that caller
+			 * is passing PTR_TO_CTX.
+			 */
+			if (reg->type != PTR_TO_CTX) {
+				bpf_log(log,
+					"arg#%d expected pointer to ctx, but got %s\n",
+					i, btf_type_str(t));
+				return -EINVAL;
+			}
+			if (check_ctx_reg(env, reg, regno))
+				return -EINVAL;
+		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID ||
+			   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type)))) {
 			const struct btf_type *reg_ref_t;
 			const struct btf *reg_btf;
 			const char *reg_ref_tname;
@@ -5523,14 +5577,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			if (reg->type == PTR_TO_BTF_ID) {
 				reg_btf = reg->btf;
 				reg_ref_id = reg->btf_id;
-			} else if (reg2btf_ids[base_type(reg->type)]) {
+			} else {
 				reg_btf = btf_vmlinux;
 				reg_ref_id = *reg2btf_ids[base_type(reg->type)];
-			} else {
-				bpf_log(log, "kernel function %s args#%d expected pointer to %s %s but R%d is not a pointer to btf_id\n",
-					func_name, i,
-					btf_type_str(ref_t), ref_tname, regno);
-				return -EINVAL;
 			}

 			reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id,
@@ -5546,22 +5595,24 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 					reg_ref_tname);
 				return -EINVAL;
 			}
-		} else if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
-			/* If function expects ctx type in BTF check that caller
-			 * is passing PTR_TO_CTX.
-			 */
-			if (reg->type != PTR_TO_CTX) {
-				bpf_log(log,
-					"arg#%d expected pointer to ctx, but got %s\n",
-					i, btf_type_str(t));
-				return -EINVAL;
-			}
-			if (check_ctx_reg(env, reg, regno))
-				return -EINVAL;
 		} else if (ptr_to_mem_ok) {
 			const struct btf_type *resolve_ret;
 			u32 type_size;

+			if (is_kfunc) {
+				/* Permit pointer to mem, but only when argument
+				 * type is pointer to scalar, or struct composed
+				 * (recursively) of scalars.
+				 */
+				if (!btf_type_is_scalar(ref_t) &&
+				    !__btf_type_is_scalar_struct(log, btf, ref_t, 0)) {
+					bpf_log(log,
+						"arg#%d pointer type %s %s must point to scalar or struct with scalar\n",
+						i, btf_type_str(ref_t), ref_tname);
+					return -EINVAL;
+				}
+			}
+
 			resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
 			if (IS_ERR(resolve_ret)) {
 				bpf_log(log,
@@ -5574,6 +5625,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			if (check_mem_reg(env, reg, regno, type_size))
 				return -EINVAL;
 		} else {
+			bpf_log(log, "reg type unsupported for arg#%d %sfunction %s#%d\n", i,
+				is_kfunc ? "kernel " : "", func_name, func_id);
 			return -EINVAL;
 		}
 	}
@@ -5623,7 +5676,7 @@ int btf_check_kfunc_arg_match(struct bpf_verifier_env *env,
 			      const struct btf *btf, u32 func_id,
 			      struct bpf_reg_state *regs)
 {
-	return btf_check_func_arg_match(env, btf, func_id, regs, false);
+	return btf_check_func_arg_match(env, btf, func_id, regs, true);
 }

 /* Convert BTF of a function into bpf_reg_state if possible
--
2.44.0.769.g3c40516874-goog


