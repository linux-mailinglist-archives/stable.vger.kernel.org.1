Return-Path: <stable+bounces-227285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDlsAkXyu2nkqQIAu9opvQ
	(envelope-from <stable+bounces-227285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:55:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9960D2CB762
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19994319076B
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225423C3C01;
	Thu, 19 Mar 2026 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQLk0W8+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE23BE15D
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773924701; cv=none; b=f/7//9d9SMLUEtV8Mv3D+PQEv0tXpftuZnIF//QuQkobKXDC7fukRmjkDkIQTuaQ6RYN5nuNY4AmAWl7AdDNIVLjynH/1mKCKioBUla6aYJT1InftoTOW+z3bg4DivNXITj8gvu7aItdMP+dchiPouDNVv+CtC07KFO5lh6l4uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773924701; c=relaxed/simple;
	bh=9HEz2B1n+mABVvZ8QnFSlY34ddb04WpPxUdw/whWxG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXpweiVF8UVW1H4lPxOfeRisJxXSlCljQWv5R2yOgkAqQ9Y3ONcTwcj6wT5jLfyAsEuZeawxkelJYUqzsqzw3z3BpxApMf0WUzTVG72eYGA6Y0deAT7aK5hdhKRU0vSp7lfK3oq9aMzK0EAzGgCL+6xpEaC9jLs1Mu1Bwc7y+pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQLk0W8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CF9C2BC9E;
	Thu, 19 Mar 2026 12:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773924701;
	bh=9HEz2B1n+mABVvZ8QnFSlY34ddb04WpPxUdw/whWxG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lQLk0W8+NZiy+Mnf0eVkDjPwLdGVJTMOGI673NZCJdFQ7FOfv8qfgtJBeWnZNEOSF
	 Kmx1Sp+1k6cFvf+nzRi6oo71HsVpI0anBIOzNBjy2tkwl9Dqe8B/ooo9mcxusx9hrG
	 OVNYAO+RoRX/5DnqetfVk5xhmu9aUBOXILlzC+LeEUsKONUkTPD/rPIZ0CKcUROWGK
	 klfkqJ0CYN2cYAA0luMz1HmTVstoYFwvPM0o5zre7Q8XWCcsCMJjDcg7mt8jm9i1fs
	 ZUJaClmTQC8x4TXVlpNXryzL5JOKU4YRzZUi/Ob304MEt+v2Ky+cDquf07i1kHXi4C
	 /n/awVTqHoHJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hari Bathini <hbathini@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] powerpc64/bpf: fix kfunc call support
Date: Thu, 19 Mar 2026 08:51:38 -0400
Message-ID: <20260319125138.2389388-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319125138.2389388-1-sashal@kernel.org>
References: <2026031723-runner-capable-b815@gregkh>
 <20260319125138.2389388-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227285-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.974];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9960D2CB762
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hari Bathini <hbathini@linux.ibm.com>

[ Upstream commit 01b6ac72729610ae732ca2a66e3a642e23f6cd60 ]

Commit 61688a82e047 ("powerpc/bpf: enable kfunc call") inadvertently
enabled kfunc call support for 32-bit powerpc but that support will
not be possible until ABI mismatch between 32-bit powerpc and eBPF is
handled in 32-bit powerpc JIT code. Till then, advertise support only
for 64-bit powerpc. Also, in powerpc ABI, caller needs to extend the
arguments properly based on signedness. The JIT code is responsible
for handling this explicitly for kfunc calls as verifier can't handle
this for each architecture-specific ABI needs. But this was not taken
care of while kfunc call support was enabled for powerpc. Fix it by
handling this with bpf_jit_find_kfunc_model() and using zero_extend()
& sign_extend() helper functions.

Fixes: 61688a82e047 ("powerpc/bpf: enable kfunc call")
Cc: stable@vger.kernel.org
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20260303181031.390073-7-hbathini@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/net/bpf_jit_comp.c   |   2 +-
 arch/powerpc/net/bpf_jit_comp64.c | 101 +++++++++++++++++++++++++++---
 2 files changed, 94 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 2a36cc2e7e9e2..55c3b64a5f3a4 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -362,7 +362,7 @@ void bpf_jit_free(struct bpf_prog *fp)
 
 bool bpf_jit_supports_kfunc_call(void)
 {
-	return true;
+	return IS_ENABLED(CONFIG_PPC64);
 }
 
 bool bpf_jit_supports_far_kfunc_call(void)
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index f3be024fc6854..ce9d946fe3c19 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -293,6 +293,83 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
 	return 0;
 }
 
+static int zero_extend(u32 *image, struct codegen_context *ctx, u32 src_reg, u32 dst_reg, u32 size)
+{
+	switch (size) {
+	case 1:
+		 /* zero-extend 8 bits into 64 bits */
+		EMIT(PPC_RAW_RLDICL(dst_reg, src_reg, 0, 56));
+		return 0;
+	case 2:
+		 /* zero-extend 16 bits into 64 bits */
+		EMIT(PPC_RAW_RLDICL(dst_reg, src_reg, 0, 48));
+		return 0;
+	case 4:
+		 /* zero-extend 32 bits into 64 bits */
+		EMIT(PPC_RAW_RLDICL(dst_reg, src_reg, 0, 32));
+		fallthrough;
+	case 8:
+		/* Nothing to do */
+		return 0;
+	default:
+		return -1;
+	}
+}
+
+static int sign_extend(u32 *image, struct codegen_context *ctx, u32 src_reg, u32 dst_reg, u32 size)
+{
+	switch (size) {
+	case 1:
+		 /* sign-extend 8 bits into 64 bits */
+		EMIT(PPC_RAW_EXTSB(dst_reg, src_reg));
+		return 0;
+	case 2:
+		 /* sign-extend 16 bits into 64 bits */
+		EMIT(PPC_RAW_EXTSH(dst_reg, src_reg));
+		return 0;
+	case 4:
+		 /* sign-extend 32 bits into 64 bits */
+		EMIT(PPC_RAW_EXTSW(dst_reg, src_reg));
+		fallthrough;
+	case 8:
+		/* Nothing to do */
+		return 0;
+	default:
+		return -1;
+	}
+}
+
+/*
+ * Handle powerpc ABI expectations from caller:
+ *   - Unsigned arguments are zero-extended.
+ *   - Signed arguments are sign-extended.
+ */
+static int prepare_for_kfunc_call(const struct bpf_prog *fp, u32 *image,
+				  struct codegen_context *ctx,
+				  const struct bpf_insn *insn)
+{
+	const struct btf_func_model *m = bpf_jit_find_kfunc_model(fp, insn);
+	int i;
+
+	if (!m)
+		return -1;
+
+	for (i = 0; i < m->nr_args; i++) {
+		/* Note that BPF ABI only allows up to 5 args for kfuncs */
+		u32 reg = bpf_to_ppc(BPF_REG_1 + i), size = m->arg_size[i];
+
+		if (!(m->arg_flags[i] & BTF_FMODEL_SIGNED_ARG)) {
+			if (zero_extend(image, ctx, reg, reg, size))
+				return -1;
+		} else {
+			if (sign_extend(image, ctx, reg, reg, size))
+				return -1;
+		}
+	}
+
+	return 0;
+}
+
 static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 out)
 {
 	/*
@@ -678,14 +755,16 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 				/* special mov32 for zext */
 				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 0, 31));
 				break;
-			} else if (off == 8) {
-				EMIT(PPC_RAW_EXTSB(dst_reg, src_reg));
-			} else if (off == 16) {
-				EMIT(PPC_RAW_EXTSH(dst_reg, src_reg));
-			} else if (off == 32) {
-				EMIT(PPC_RAW_EXTSW(dst_reg, src_reg));
-			} else if (dst_reg != src_reg)
-				EMIT(PPC_RAW_MR(dst_reg, src_reg));
+			}
+			if (off == 0) {
+				/* MOV */
+				if (dst_reg != src_reg)
+					EMIT(PPC_RAW_MR(dst_reg, src_reg));
+			} else {
+				/* MOVSX: dst = (s8,s16,s32)src (off = 8,16,32) */
+				if (sign_extend(image, ctx, src_reg, dst_reg, off / 8))
+					return -1;
+			}
 			goto bpf_alu32_trunc;
 		case BPF_ALU | BPF_MOV | BPF_K: /* (u32) dst = imm */
 		case BPF_ALU64 | BPF_MOV | BPF_K: /* dst = (s64) imm */
@@ -1079,6 +1158,12 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			if (ret < 0)
 				return ret;
 
+			/* Take care of powerpc ABI requirements before kfunc call */
+			if (insn[i].src_reg == BPF_PSEUDO_KFUNC_CALL) {
+				if (prepare_for_kfunc_call(fp, image, ctx, &insn[i]))
+					return -1;
+			}
+
 			ret = bpf_jit_emit_func_call_rel(image, fimage, ctx, func_addr);
 			if (ret)
 				return ret;
-- 
2.51.0


