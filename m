Return-Path: <stable+bounces-139109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9861AA4515
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 10:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9B23BE888
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 08:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720F7214223;
	Wed, 30 Apr 2025 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P63W5mdK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216CB6AD3
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001214; cv=none; b=QvXKMu08R3WaehVA7LnbbCGlNEFyKfYjOYp9RcVKhLaZqfV7pvLX0TGdKubJm3bY130NVfgXMKm2Tnf3qUEiAL1az/Eypa38LJKPJpNzsigFAQmtBAT0/lMU7Fjl6EUdCkipc6mIUM8GU9T71d1Kvn+8i5Y7wBpsMjbBl+WRsaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001214; c=relaxed/simple;
	bh=sUbD/L0VfgiSmr8e0CGHojgN981EQlCExHlI6odjHyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTVFn5r0memClkET30eS7J/qkenxVb+pQmAJudcgtMru6Me5FzqgPuOUIsHU21WZrEPVK7A27Nrd8Ck0RBd2jAsz2qIv+4k+Zgg7neheJ+2o/80xeRzh8tZIrCKcLGljndWfC+6SK8kFbkAFoIPpA2+bavnlD7AKRWzJ07NsbHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P63W5mdK; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ace3b03c043so1103564566b.2
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 01:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746001209; x=1746606009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nowJ8etYPyw2ZrFwmpT8RYEBr+2VvwO2lncghkZK2g=;
        b=P63W5mdKHJR4x+a+NPgiPMLWw2d14SufIIZNC+ztzo0hP3zMdI1qUQfAY0jZpynxBL
         xJrAu9VgkYglsbgt6v1AwvQvJzglC8B2stVLbx0vjAFUo/TVeDZi8ZfstIfHdK+I1pTd
         LocGKBfLfdpJbcokvWAOEQIs9XLOmvQKlDBw0umvn4ef6ZnX3DztZ/GnYtmoIY+IVVhp
         zSfpx80fNyH9TYcG5643iugNEQnLMeUedMZ3s9XjLHsO4hgfSUHHbhQZmf5HHB4XKOr+
         ccU0NOSkmirEuGPNk7msJKPFzpnNX6G+sCsxX3rK2I+32HUwxWgyz5WPZ4/zr3jO42Q1
         JX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746001209; x=1746606009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nowJ8etYPyw2ZrFwmpT8RYEBr+2VvwO2lncghkZK2g=;
        b=p3cAH78ROnUxS3vwR9xk7yHvWhvLV4S8nNQJ0+Pnv52EAoBipAM2heC5kSlzjr2HeE
         O9P0GL3p4uWJLB0Zg3t5FcX8IRQrOC1EKsmwitcj4KneCWxLiB4iWsp1wje8bjp8LY9I
         M0HE3zqhliRMGBNycOEUYyiLA5A6lhgmmW9ZbYLkGGIN8juoDBH02M3F9M4iInX4V0fb
         bqNFZLhPisq8vUT5RWxkS7+DsSUjae7jvl0joYFLoSQVNvY6/VTG0s66nvBY2V+gO0eq
         7O1ZLn4q9V2OBPAG8sobgk6UWM06xDKDHjRzb/Mh8BGTGf4oJ4sBW2XvPO5yqMXwK1/4
         50rA==
X-Gm-Message-State: AOJu0YyAlE63WBYRm3I6QCLFEAASbhJtyzPhLnfhIleMdpM31Ao8OeDz
	k+RxnRCX/oqrOVkWs6vjT7K6o8dgSxWRQRu593plhYIrLAab+RemWm50mtEuj21RZmz1qCThSiU
	T+GXD6w==
X-Gm-Gg: ASbGnctyyA+5BW0tJz3jIU9GAioYRpuM0nH2jf4qzURBxK7IVldpAIDLgIcWHUqaF+8
	WFEwvD7D2KlMYQSPga2l+QMgUK2gpnYpMVP+4kv0ubCfL2Wsdd1rd1RDJhpLnH5GxI+GeDM0JOc
	yByjco/dOzayG2uIvBrGVULVPQ1/IZgxjq591HrsLKiIzz6mVu78pTXks16YfFfM41/IrlVt8ji
	vk10w/ZW3F4Jb/abvFhTZ1Kc1nQafNnR3MsASpTfitMApqEmZeHtYYgTDaD5tceXKL8bvZmQJoQ
	AdD7edr7Co6I9ntbV11tqlJL8BoY0T5Y3DITcIS52T+FRBDYw878hQ==
X-Google-Smtp-Source: AGHT+IFkECROleTrCLeYZbkY+ygOgvxxpB5A4cKRvNYVnGAn3qGWafJ8P0g0puWqTTPS2fklmMASNQ==
X-Received: by 2002:a17:907:94ce:b0:ace:c540:ffda with SMTP id a640c23a62f3a-acedc612727mr229463166b.26.1746001209180;
        Wed, 30 Apr 2025 01:20:09 -0700 (PDT)
Received: from localhost ([2401:e180:8d24:65b3:be00:91e5:d591:161f])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30a3471ee7esm996972a91.4.2025.04.30.01.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:20:08 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 02/10] bpf: refactor bpf_helper_changes_pkt_data to use helper number
Date: Wed, 30 Apr 2025 16:19:44 +0800
Message-ID: <20250430081955.49927-3-shung-hsi.yu@suse.com>
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

commit b238e187b4a2d3b54d80aec05a9cab6466b79dde upstream.

Use BPF helper number instead of function pointer in
bpf_helper_changes_pkt_data(). This would simplify usage of this
function in verifier.c:check_cfg() (in a follow-up patch),
where only helper number is easily available and there is no real need
to lookup helper proto.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20241210041100.1898468-3-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 include/linux/filter.h |  2 +-
 kernel/bpf/core.c      |  2 +-
 kernel/bpf/verifier.c  |  2 +-
 net/core/filter.c      | 61 +++++++++++++++++++-----------------------
 4 files changed, 30 insertions(+), 37 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 5090e940ba3e..adf65eacade0 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -915,7 +915,7 @@ bool bpf_jit_needs_zext(void);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_far_kfunc_call(void);
-bool bpf_helper_changes_pkt_data(void *func);
+bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id);
 
 static inline bool bpf_dump_raw_ok(const struct cred *cred)
 {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 02f327f05fd6..81fd1bb99416 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2893,7 +2893,7 @@ void __weak bpf_jit_compile(struct bpf_prog *prog)
 {
 }
 
-bool __weak bpf_helper_changes_pkt_data(void *func)
+bool __weak bpf_helper_changes_pkt_data(enum bpf_func_id func_id)
 {
 	return false;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7322ac0c69ed..329b66516a85 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10007,7 +10007,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	}
 
 	/* With LD_ABS/IND some JITs save/restore skb from r1. */
-	changes_data = bpf_helper_changes_pkt_data(fn->func);
+	changes_data = bpf_helper_changes_pkt_data(func_id);
 	if (changes_data && fn->arg1_type != ARG_PTR_TO_CTX) {
 		verbose(env, "kernel subsystem misconfigured func %s#%d: r1 != ctx\n",
 			func_id_name(func_id), func_id);
diff --git a/net/core/filter.c b/net/core/filter.c
index 84992279f4b1..c44754ff4abe 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7860,42 +7860,35 @@ static const struct bpf_func_proto bpf_tcp_raw_check_syncookie_ipv6_proto = {
 
 #endif /* CONFIG_INET */
 
-bool bpf_helper_changes_pkt_data(void *func)
+bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id)
 {
-	if (func == bpf_skb_vlan_push ||
-	    func == bpf_skb_vlan_pop ||
-	    func == bpf_skb_store_bytes ||
-	    func == bpf_skb_change_proto ||
-	    func == bpf_skb_change_head ||
-	    func == sk_skb_change_head ||
-	    func == bpf_skb_change_tail ||
-	    func == sk_skb_change_tail ||
-	    func == bpf_skb_adjust_room ||
-	    func == sk_skb_adjust_room ||
-	    func == bpf_skb_pull_data ||
-	    func == sk_skb_pull_data ||
-	    func == bpf_clone_redirect ||
-	    func == bpf_l3_csum_replace ||
-	    func == bpf_l4_csum_replace ||
-	    func == bpf_xdp_adjust_head ||
-	    func == bpf_xdp_adjust_meta ||
-	    func == bpf_msg_pull_data ||
-	    func == bpf_msg_push_data ||
-	    func == bpf_msg_pop_data ||
-	    func == bpf_xdp_adjust_tail ||
-#if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
-	    func == bpf_lwt_seg6_store_bytes ||
-	    func == bpf_lwt_seg6_adjust_srh ||
-	    func == bpf_lwt_seg6_action ||
-#endif
-#ifdef CONFIG_INET
-	    func == bpf_sock_ops_store_hdr_opt ||
-#endif
-	    func == bpf_lwt_in_push_encap ||
-	    func == bpf_lwt_xmit_push_encap)
+	switch (func_id) {
+	case BPF_FUNC_clone_redirect:
+	case BPF_FUNC_l3_csum_replace:
+	case BPF_FUNC_l4_csum_replace:
+	case BPF_FUNC_lwt_push_encap:
+	case BPF_FUNC_lwt_seg6_action:
+	case BPF_FUNC_lwt_seg6_adjust_srh:
+	case BPF_FUNC_lwt_seg6_store_bytes:
+	case BPF_FUNC_msg_pop_data:
+	case BPF_FUNC_msg_pull_data:
+	case BPF_FUNC_msg_push_data:
+	case BPF_FUNC_skb_adjust_room:
+	case BPF_FUNC_skb_change_head:
+	case BPF_FUNC_skb_change_proto:
+	case BPF_FUNC_skb_change_tail:
+	case BPF_FUNC_skb_pull_data:
+	case BPF_FUNC_skb_store_bytes:
+	case BPF_FUNC_skb_vlan_pop:
+	case BPF_FUNC_skb_vlan_push:
+	case BPF_FUNC_store_hdr_opt:
+	case BPF_FUNC_xdp_adjust_head:
+	case BPF_FUNC_xdp_adjust_meta:
+	case BPF_FUNC_xdp_adjust_tail:
 		return true;
-
-	return false;
+	default:
+		return false;
+	}
 }
 
 const struct bpf_func_proto bpf_event_output_data_proto __weak;
-- 
2.49.0


