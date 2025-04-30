Return-Path: <stable+bounces-139112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A070AA4518
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 10:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5991750D1
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 08:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076EE1EF388;
	Wed, 30 Apr 2025 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cFzv9aVY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEF77FBA2
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001226; cv=none; b=EV6UV61YwRoDCovUoVRrYbS80VC15d/AgGyENvHOoPAApXol+MX8zEO3BeAFkipm6jzKUJxf5L/2UXLVdLy8nrYuBQOfGSTMY9SGzi7I8BkvTBPZ89CIZkoFQYpVLJyVje4dD+2TofVCFO93GzmmaUGyLdufkRlUDJlX6dRxDZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001226; c=relaxed/simple;
	bh=TU5rEHfVaYDRVBr+rzrcbWiKIdmkuxMcmhdAjwH4wXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEVa+UJUcTpDyKmhNGbK5osCObA9/wF6JO7ysgVqQ1wuW3ABNZtbOhIiy8XB5IBAiDSddIkHm4NmYvZPqXkuwQwF3DkIM3GWaVaZ7Ce8QlxGazKSWsMmAORKkk/WvHquYNyCHuEI1lCOPxFNdJ6PO9VOdH6T2YopRECeJWbtZN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cFzv9aVY; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-aca99fc253bso1071202666b.0
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 01:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746001223; x=1746606023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuHsjvtkYykesN9khEUsKHRzqoIGJMTI6mizR3x17+8=;
        b=cFzv9aVY8M1gpsJP/v25mUaVfcPy0h8kgXtT/5CBfwB5RLsDNgHodUHN08Rtb0WPQ7
         l+P4IhWiF5nKVuEC2yKqysC8EWOzjUWgLMH1qFpAvGByaoEIb+YqiGEfJJbm777Z2iVx
         2i57XTey3tYnGWnkDwT//3MGS6PwUVohUfx7AVd1XjtuBzx93IN4oyw5CdEUMVbBNphs
         JUk73rcfNz+LouI2xkx8awRoYeXS0jwTOYG/Hr58kUO/8hnKNyOT1BwJgottEyKyH218
         Nbt3hLAlGWhR0J6BNbTx0B/u/wpX30e/IdbN6vANQiQYwOud6D5K3HL9oUp7hhnb4rA5
         uTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746001223; x=1746606023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuHsjvtkYykesN9khEUsKHRzqoIGJMTI6mizR3x17+8=;
        b=AYM+H1TXldrWOILs/lgOlJLlTyTRGfgVevAuRY1H1H5kVa/0eP5pg4shBL9PvXfQXe
         hIfFv0vtwUrB+Cbu9IzxXHWmQG3SnI9BADoY2e3RqBuys0jG0Wv2aeLJKHD4Ui3Syxz0
         qlLKiToILWagaCnNaR4/mdzRUv41UZAyKU5x7MA5icDP8yVegTjQ2qJStX8cS7VPDY8M
         ZJykoWmj1Kie9JOMOrynGlC2N6Rb+Irxy0NoxyfNLpHzb3WnLxHfiZ89OcVTxD95BgWq
         RzBnwb7OphkI0G1uE9MRlirUDy8Gyo6uxUr558rKP1ZmRhqhZ4VmHT+aCiUgwJMHCbKQ
         mXng==
X-Gm-Message-State: AOJu0YzE+2KrBYx8fzWT0PrJRPOrv7Y/TIzYu2rTbRvAhwH/TXKOUaYK
	4Pn+8BL69eIpyO4Rxffs5HR9kG6MFCpzOtZrfTUiLWMXUjVpw6x9+NsI74NF8yojr7Nc6NylMu1
	bOBRa2A==
X-Gm-Gg: ASbGncuY2oNfwky2jDg9WAOHCvnqNMTcvK4GTFhobF0iTLVmkAiqvbKFsFp9C2NHBgg
	HtWAyOMpCb996akBnuFY9NN4t+lqciSX5PFf/kwuE8hAOuIgisUn2xFb1OEFhvCXnUNz553X3lO
	gW7OFwioUcUoI20Mq82Z2/p+1yAWXwxSREEhj72kQmBxA80dVvEH82V/HH+B8DW8UBVLbJJ3ZWR
	WF0b6MLwKZy/8TXlOpdLMOJRfJFZcelIaTYN7vqjsgA3KZTj2hMuEStQMVhFHXScEbTvxl+WaKD
	ViLLx7vlZFMPvWlxdmvXCXFYM+yodOuubzUxdEec5jk=
X-Google-Smtp-Source: AGHT+IH/9/8U5roIHMRtXsaQiD6+/qrkMO8JWiSuXCxHH1IacRm93d2ZEFbzfm0XSQxCbA0wwfTfvg==
X-Received: by 2002:a17:907:2da2:b0:ac4:169:3664 with SMTP id a640c23a62f3a-acee21ec1e1mr130474666b.33.1746001222725;
        Wed, 30 Apr 2025 01:20:22 -0700 (PDT)
Received: from localhost ([2401:e180:8d24:65b3:be00:91e5:d591:161f])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b15f76f48a7sm10265907a12.9.2025.04.30.01.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:20:22 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH stable 6.6 05/10] bpf: check changes_pkt_data property for extension programs
Date: Wed, 30 Apr 2025 16:19:47 +0800
Message-ID: <20250430081955.49927-6-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430081955.49927-1-shung-hsi.yu@suse.com>
References: <20250430081955.49927-1-shung-hsi.yu@suse.com>
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
[ shung-hsi.yu: adapt to missing fields in "struct bpf_prog_aux". Context
difference in jit_subprogs() because BPF Exception is not supported. Context
difference in bpf_check() because commit 5b5f51bff1b6 "bpf:
no_caller_saved_registers attribute for helper calls" is not present. ]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/verifier.c | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 035e627f94f6..17de12a98f85 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1430,6 +1430,7 @@ struct bpf_prog_aux {
 	bool sleepable;
 	bool tail_call_reachable;
 	bool xdp_has_frags;
+	bool changes_pkt_data;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
 	/* function name for valid attach_btf_id */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 154513999e03..d9cf75b765f0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15462,6 +15462,7 @@ static int check_cfg(struct bpf_verifier_env *env)
 		}
 	}
 	ret = 0; /* cfg looks good */
+	env->prog->aux->changes_pkt_data = env->subprog_info[0].changes_pkt_data;
 
 err_free:
 	kvfree(insn_state);
@@ -18622,6 +18623,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		}
 		func[i]->aux->num_exentries = num_exentries;
 		func[i]->aux->tail_call_reachable = env->subprog_info[i].tail_call_reachable;
+		func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
 		func[i] = bpf_int_jit_compile(func[i]);
 		if (!func[i]->jited) {
 			err = -ENOTSUPP;
@@ -19934,6 +19936,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
@@ -20361,10 +20369,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
-	ret = check_attach_btf_id(env);
-	if (ret)
-		goto skip_full_check;
-
 	ret = resolve_pseudo_ldimm64(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -20379,6 +20383,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = check_attach_btf_id(env);
+	if (ret)
+		goto skip_full_check;
+
 	ret = do_check_subprogs(env);
 	ret = ret ?: do_check_main(env);
 
-- 
2.49.0


