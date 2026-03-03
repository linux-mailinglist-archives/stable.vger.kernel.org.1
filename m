Return-Path: <stable+bounces-222920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AExjHlglp2mrewAAu9opvQ
	(envelope-from <stable+bounces-222920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 19:15:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1E61F51F9
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 19:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB292316BE5A
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 18:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FE1351C0F;
	Tue,  3 Mar 2026 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tgfTUa+R"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D7B3264C8;
	Tue,  3 Mar 2026 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561471; cv=none; b=RYM6lN6wrnOEM5mIdajx6rBUP22HkN/Wpeen4L7hi6iCFUDOhI3hianXj4Pi+RUgibJzcXY4BKrW3z9Ef+2+gJcAVJQn9X28PKp+ZUR1lEdnp16XmNZtgzi1LUq1sd8Z4gml72AbSJciw4oLUnpPd+dcby6HBGd8N7HANmLGMgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561471; c=relaxed/simple;
	bh=cLFpKVMNiz8kbm4YFP7VjWVb2/WR6GxtEe2LThCTYaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqfeUanQqiee6EQCOksBA+J/Kqs9kd+wGZ9doQR9HYgzkNuGo3amL+R14fBj18fYdPAdqj1NBXMQxWkWbnpl3lkyACkCJ/zaNJc6eqmJKiUm8oBaDGctqSJ2NnksKnqyBdzcec0RJUM0EG6+Tx62Ps+e/xs/C7JAD3CdXVKia/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tgfTUa+R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623H5Ffu2060996;
	Tue, 3 Mar 2026 18:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KoqA0eQ6AV3ndyHYi
	ApU6L60lsiOT32TWmcerkEGRxs=; b=tgfTUa+R0wbx0sKyoF8o2DCU0ojDUdkT2
	vJzVzOLQ7Z5YPQl7LDERx3YOtdzsDU6hJGoTcMtpL8yw5efLaR1BcvEfMqdl0tLx
	U2gT7yPUxai58S0DUIt6Wv/m3R73lHuDg3amjcstIDQyIC/fT2g5itImH1fn3N9b
	nGbQJoRMLK0zd3/0EIWRBkPL9En6huATKG4Acwq3VwME2eZNWS5h5uXiud/Y6cc3
	ehJEIYrVPcNpHRKz5MbAi7xy2xmOTU3yeRBoZinWyIL9CRSAdnNifbx7qFELA5eF
	GANdiE3FlEBAIIBMAoxHST43nXkPvceWtB2IH4fsewhsJV6KOrfeQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrj49qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 18:10:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623Et6Z8010299;
	Tue, 3 Mar 2026 18:10:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6k3dft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 18:10:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 623IAnYx16449872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 18:10:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8325D20040;
	Tue,  3 Mar 2026 18:10:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BC8420043;
	Tue,  3 Mar 2026 18:10:47 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.53.81])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Mar 2026 18:10:47 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: bpf@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Abhishek Dubey <adubey@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v4 6/6] powerpc64/bpf: fix kfunc call support
Date: Tue,  3 Mar 2026 23:40:30 +0530
Message-ID: <20260303181031.390073-7-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303181031.390073-1-hbathini@linux.ibm.com>
References: <20260303181031.390073-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a7242e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=cgMUl_j-H115-_3Hw7UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE0NiBTYWx0ZWRfX5xrwatiaCXnT
 3huUZcjM8NcL7Ju/kluSm6C/XcsEotx+uLYffcGgH6hAR5QdYPygo25D4V3T73GbmLvL6CnTPa4
 nFXCI+Gn30TGHIksPOWaX7zlsvYY867CYuaTV0FSEfVRqHCfhUw4ImC8SsNhE/DVsJU+kkM9wtt
 Q7SNe8m1Kplc1nSwi899znI9mEU2c//F2yaF+VoS0ZhqQ0TTbEf5WiEBsNnedh2/wuJhksv5EUd
 xvQaQJLedFHy4N4yEk0EeRSWSdeQz3io81oDRib8G2ztw5/FcvYBFcnACp8oOJUIXxwP9J3wPuJ
 W/BLewlCjyH+HdACNnFu/cGqsocRCvC/wp6GxSgkMB1BfoXvRy8YJ2R1nk0voMgi57trVnoYm1l
 3+erjx/mn4L9kkCOaYu5CM+Ux547kPXVld1V1adQ4MtgHidmv5eId+N29kfskPk32tFKbN7hEvl
 cgOFs9V9B9WLRVmm8+w==
X-Proofpoint-GUID: 7o_4C3H4WFgCekNUSbaUyE3zeEx9T8Lq
X-Proofpoint-ORIG-GUID: 7o_4C3H4WFgCekNUSbaUyE3zeEx9T8Lq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030146
X-Rspamd-Queue-Id: EE1E61F51F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222920-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hbathini@linux.ibm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

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
---

Changes in v4:
- Fixed src_reg usage in zero_extend() helper - reported by
  bot+bpf-ci@kernel.org.

Changes in v3:
- New patch to fix kfunc call ABI issue on powerpc while passing arguments.


 arch/powerpc/net/bpf_jit_comp.c   |   2 +-
 arch/powerpc/net/bpf_jit_comp64.c | 101 +++++++++++++++++++++++++++---
 2 files changed, 94 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 85457bcb2040..a62a9a92b7b5 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -450,7 +450,7 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 
 bool bpf_jit_supports_kfunc_call(void)
 {
-	return true;
+	return IS_ENABLED(CONFIG_PPC64);
 }
 
 bool bpf_jit_supports_arena(void)
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 04e76440d1ad..c5e26d231cd5 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -499,6 +499,83 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
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
@@ -1143,14 +1220,16 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
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
@@ -1618,6 +1697,12 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
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
2.53.0


