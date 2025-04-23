Return-Path: <stable+bounces-135230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC1DA97E61
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 07:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A54189E699
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 05:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F30265619;
	Wed, 23 Apr 2025 05:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xw2hQ+cT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83514EAFA
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 05:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387660; cv=none; b=SuD02yg2SIdTsCDJBfvi+6rXOMa0V16RSnYsH7rpVaMfraDyjpUdOLRL1UGyba66UlS2u7kyiuEMJyxI41Jm6LN+i9jkMRSzbxyUpEGlrY7YJX7DmX0fFzc5MhI96pzs1QT1KFBntaupd6xbefn4r07mVw+QPqWJR6wNxjPXGqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387660; c=relaxed/simple;
	bh=pw/OAP4yZ3TduNwn/K8ErLRK2WGaV6XFdPLMmyRxr9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUadb/uA7PoETfkSgqWFYgT+/cBv+R/M0fUvaDtqboxCgrlIfW6hisTcAqp7wSJp2sd9DHKt4UUCJZP0Q1MAYx57olcQi3cx/UQb8C5lWcmQF78dWINgRXDRWJLRYOILqkUQrajjrOHbeJGCQ4QuUxxgm7EwvvKWdffPgbji3p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xw2hQ+cT; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-39c0dfba946so4065903f8f.3
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 22:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745387653; x=1745992453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kohRAZjh3e0FRY3Y6ZFiHQKkX9c7sXshCIyA/CWmkCc=;
        b=Xw2hQ+cTptP9xsM/o5cm+O4XKxd6d8lahu/JOkTTnfodE0lScgxtv5J1Q227wR7TzM
         7iAOcvRpVnj1UubT/MoW7oNBWajl8Jqy83Lu4lCOLhWmJp0ynJrnqCyQ7dmNa6ldY/WI
         GwfOqnuq02ZViyxVTzSYQGDoftKJl36QIKWN+o4L/OFrQw6NEs8z6sY42QSy4vkJ3YRI
         JMdHHJXOKqNMxs2Tq41gQE/DKlSBx0sOPYQezu53Ltiy4+el5IfvTyV5/Y/ebCzJfQ/w
         Tf+3HIAK/vcFoauvPJNszwAt1rNfw3NTNEA7ty8bJduG7iU2c6Le97cB4sMGM/rrmFbk
         +5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745387653; x=1745992453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kohRAZjh3e0FRY3Y6ZFiHQKkX9c7sXshCIyA/CWmkCc=;
        b=JLE8Kjyn/92eXDloCLCS3T99X2z3mJY7Bw3Qj1kv/D38s2L+b/meal3j4MGpVXdB/v
         M8MJD6a3cv/4LZxLT1usvSVjZoOF3t9qAjFdSqV89srX8sm0CZGtaWOMK4WOXbJkmINV
         tBQ+LB9p/wfrznu3vQsb//QrCvgN/Cwl2Wpa8+P96xfgz3FIvlIlbPD1NhuRG6CxnqZn
         DUfer4Q6VLpBtWKqPhe3qBxXEQZ7G88z94l/yH4OolnUNC83w5dcFFavWbdjPWqk5+bf
         xE+FWkQDxLnICG8S6wVTOqpuwlUj2Opm1DwayySzgxTPHxy9VULmTdWOb9lPHGJCbXKy
         aEJA==
X-Gm-Message-State: AOJu0YwL6wfwLv2+qZ7b907dUfU0GDB1s5MhXKnZocBAVEQssxOcTpKK
	1ylFLhg/owLpSLlEbVeHufTvSp6740AieMCHLuSqAIUiCYM4Y0YHPEqhotkqhvxVHHuXqEu77S4
	nrJEm/Q==
X-Gm-Gg: ASbGncuwUQzeMfoGBT3Y8Hp7jTCIULk6oau/rljCs/I05Kr6d/0SqC4HiVoRRfY27Zz
	8ltdatYG02GZ0LjKaLMfCSE+QV9x/Q6Sm0JNuekPa+rvLz2hA0LmBm+CrjiYSPZ45gTxmng6vqv
	mPtox2dGkK2IQq4gK1D7VCUM3ZB3VwVfdhCqOwcmDcSs53AY9rKwv1tS28Ey5EmQ5PftO+yqLlX
	Fofmm/BiQZsgVETns85tAqoriedVt0/toyhtbcFtCrxvo9CkNg97kMITtUDddiOt3LtEbSTy1sH
	Re3DUtLjfN3y3kJ/WwLgxVWl2NJDyCv0Z0gB4B2MssKuevE0FGVN/PpNnRdOA+TEPE46tRZJ2jz
	M700/
X-Google-Smtp-Source: AGHT+IHzi4R71Lk7evpzMtUSTlmL/2NpXvwNXQn9LgLveBc4fcN1/DW9rg9MyZdkydlfGNw3XyV2qg==
X-Received: by 2002:a5d:59ac:0:b0:39c:1404:312f with SMTP id ffacd0b85a97d-39efba2cb94mr14277090f8f.1.1745387653201;
        Tue, 22 Apr 2025 22:54:13 -0700 (PDT)
Received: from localhost (27-240-233-37.adsl.fetnet.net. [27.240.233.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50bd99d6sm95559845ad.41.2025.04.22.22.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 22:54:12 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH stable 6.12 4/8] bpf: check changes_pkt_data property for extension programs
Date: Wed, 23 Apr 2025 13:53:25 +0800
Message-ID: <20250423055334.52791-5-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423055334.52791-1-shung-hsi.yu@suse.com>
References: <20250423055334.52791-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

commit 81f6d0530ba031b5f038a091619bf2ff29568852 upstream.

When processing calls to global sub-programs, verifier decides whether
to invalidate all packet pointers in current state depending on the
changes_pkt_data property of the global sub-program.

Because of this, an extension program replacing a global sub-program
must be compatible with changes_pkt_data property of the sub-program
being replaced.

This commit:
- adds changes_pkt_data flag to struct bpf_prog_aux:
  - this flag is set in check_cfg() for main sub-program;
  - in jit_subprogs() for other sub-programs;
- modifies bpf_check_attach_btf_id() to check changes_pkt_data flag;
- moves call to check_attach_btf_id() after the call to check_cfg(),
  because it needs changes_pkt_data flag to be set:

    bpf_check:
      ...                             ...
    - check_attach_btf_id             resolve_pseudo_ldimm64
      resolve_pseudo_ldimm64   -->    bpf_prog_is_offloaded
      bpf_prog_is_offloaded           check_cfg
      check_cfg                     + check_attach_btf_id
      ...                             ...

The following fields are set by check_attach_btf_id():
- env->ops
- prog->aux->attach_btf_trace
- prog->aux->attach_func_name
- prog->aux->attach_func_proto
- prog->aux->dst_trampoline
- prog->aux->mod
- prog->aux->saved_dst_attach_type
- prog->aux->saved_dst_prog_type
- prog->expected_attach_type

Neither of these fields are used by resolve_pseudo_ldimm64() or
bpf_prog_offload_verifier_prep() (for netronome and netdevsim
drivers), so the reordering is safe.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20241210041100.1898468-6-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ shung-hsi.yu: both jits_use_priv_stack and priv_stack_requested fields are
missing from context because "bpf: Support private stack for bpf progs" series
is not present.]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/verifier.c | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a7af13f550e0..1150a595aa54 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1499,6 +1499,7 @@ struct bpf_prog_aux {
 	bool exception_cb;
 	bool exception_boundary;
 	bool is_extended; /* true if extended by freplace program */
+	bool changes_pkt_data;
 	u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
 	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
 	struct bpf_arena *arena;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fe180cf085fc..e2e16349ae3f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16650,6 +16650,7 @@ static int check_cfg(struct bpf_verifier_env *env)
 		}
 	}
 	ret = 0; /* cfg looks good */
+	env->prog->aux->changes_pkt_data = env->subprog_info[0].changes_pkt_data;
 
 err_free:
 	kvfree(insn_state);
@@ -20152,6 +20153,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->num_exentries = num_exentries;
 		func[i]->aux->tail_call_reachable = env->subprog_info[i].tail_call_reachable;
 		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
+		func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
 		func[i] = bpf_int_jit_compile(func[i]);
@@ -22022,6 +22024,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 					"Extension programs should be JITed\n");
 				return -EINVAL;
 			}
+			if (prog->aux->changes_pkt_data &&
+			    !aux->func[subprog]->aux->changes_pkt_data) {
+				bpf_log(log,
+					"Extension program changes packet data, while original does not\n");
+				return -EINVAL;
+			}
 		}
 		if (!tgt_prog->jited) {
 			bpf_log(log, "Can attach to only JITed progs\n");
@@ -22487,10 +22495,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
-	ret = check_attach_btf_id(env);
-	if (ret)
-		goto skip_full_check;
-
 	ret = resolve_pseudo_ldimm64(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -22505,6 +22509,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = check_attach_btf_id(env);
+	if (ret)
+		goto skip_full_check;
+
 	ret = mark_fastcall_patterns(env);
 	if (ret < 0)
 		goto skip_full_check;
-- 
2.49.0


