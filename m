Return-Path: <stable+bounces-217543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK5kFscBmGnC/AIAu9opvQ
	(envelope-from <stable+bounces-217543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 07:40:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A525C165019
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 07:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A073301E3EA
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 06:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B876732BF55;
	Fri, 20 Feb 2026 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KeAnWPsx"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA6C32D7C7;
	Fri, 20 Feb 2026 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771569602; cv=none; b=qmKXJKjYZaPt+n3gAjHbinPSmnki15w+OnEwL2skCxg9+IFShh176w4Mqr6z1Hx/rhFMmOlvnTL40pxzDnuZDxhsjvb3iaorhaCjAOD0mFx52pf1IaBRCphhe4t7bHPuCSLbcYjjlchfz3WKcjFhSPV65t+m1QyW6yrEiRq5Tck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771569602; c=relaxed/simple;
	bh=czq/WhYQhznJnUBhUac7YT6XptqTpHunXpw0DbP5qYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYz5NHzFsgjhH5Vbt4eNMO+3qi4/3OghOZpiP5QIzfN7VKc6BRl6k6p6chP+HhgJLHtWSPLdMG/yMJ0ewhEtY/KlvRZcPiobiJdL94Jpc94Kqr/SVf0W34i1YYe0+s7OTxWWmf9PbdjYiBA+M9nyXFpyjFA7+KGGA0LvGZZbC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KeAnWPsx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JLTUKG1602913;
	Fri, 20 Feb 2026 06:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9Kq+P3eQEUGPqwqTN
	Ra/cU0HyhaL26LgjAFLR49K2pQ=; b=KeAnWPsx1QDzAUIzqPW6tL22Ju++PZqb+
	tOeZDsx7bMmZIcpWDB2bl15KnEC/efyuYJhP5cT8HEmxKQ0xbfCrb8swtoRSSmxM
	3x9pABwGRD76OKwpa7FfdhJRUIJGQaWXYPWrWaZ0xGIfp3ptfNOpTY8tQnBWdKpI
	sR8iuFcD7cYYzGgemtXj6//cYdCUH5FIAy3xxaovaSz/0FgfacJeTbb9qWXcP/sx
	nf6oWqYJww/eb6lzWpGm89hcr5DiYA5IACJY21jAQZAh52YOiEjv/I1/nMgb3mhk
	NSltaJHRLek+funsKC7QroSVc4p6+LjXcNMyAa8qZkan4I7PE31xA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcr9smw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 06:39:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61K3iU2T001883;
	Fri, 20 Feb 2026 06:39:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb2bqcc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 06:39:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61K6ddD514287122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 06:39:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA79A20043;
	Fri, 20 Feb 2026 06:39:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 690E120040;
	Fri, 20 Feb 2026 06:39:37 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.64.63])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 06:39:37 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: bpf@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Abhishek Dubey <adubey@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v2 1/5] powerpc64/bpf: do not increment tailcall count when prog is NULL
Date: Fri, 20 Feb 2026 12:09:29 +0530
Message-ID: <20260220063933.196141-2-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220063933.196141-1-hbathini@linux.ibm.com>
References: <20260220063933.196141-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n3eqZyLFEupI0apHTqcVIuRJaEeZnuhn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA1MiBTYWx0ZWRfXx4NhlhKOXBXf
 xYy+stktl/opxoksbTYyw3jgolHPfqjSViIgua+Y/CeamsK1LdOY2arO3ZRSJelbTeol9U9yuzS
 l1iQAKfKRGCVlgF4DBhQNt4WzaiKVUav8oK+c2H6ZT8Xcg8hANHhNgK6kgS5rWLpLuNRR2tVY9B
 EWvSYWKEe5qifER12H9ZqxbqCbLlnKW+o0NgFAfMv7rLoDEXC5iOpLRcsbz7DlXIsKbDILIW/3p
 5BHwToMh4IjW/Je/JhMrnQA08JrQv8vJvVJY67sfEHLiwvfCnLzxt1Zdl7zDwA16CBTPAN+HA1s
 jHV6UFTwjbEYn15jNzseK46CjiQKvQxb+mvFur6SGXNLhvotGOzfdsCabWWLJJk1Qtvxpn8gLZs
 XWOCiWE8sZJ3Po5hI5ksMW8HydhjXNXLodk1bQsEyHKH4Pr2+RFi1qvLwPtA9kDkKeqhQuoxCDW
 4xHbdtp3KVzikIFwj/Q==
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=699801b0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=JWpHT1DDrkih_aSkpakA:9
X-Proofpoint-ORIG-GUID: n3eqZyLFEupI0apHTqcVIuRJaEeZnuhn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200052
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217543-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hbathini@linux.ibm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: A525C165019
X-Rspamd-Action: no action

Do not increment tailcall count, if tailcall did not succeed due to
missing BPF program.

Fixes: ce0761419fae ("powerpc/bpf: Implement support for tail calls")
Cc: stable@vger.kernel.org
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

* No changes since v1.


 arch/powerpc/net/bpf_jit_comp64.c | 39 +++++++++++++++++--------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index b1a3945ccc9f..44ce8a8783f9 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -522,9 +522,30 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 
 	/*
 	 * tail_call_info++; <- Actual value of tcc here
+	 * Writeback this updated value only if tailcall succeeds.
 	 */
 	EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), 1));
 
+	/* prog = array->ptrs[index]; */
+	EMIT(PPC_RAW_MULI(bpf_to_ppc(TMP_REG_2), b2p_index, 8));
+	EMIT(PPC_RAW_ADD(bpf_to_ppc(TMP_REG_2), bpf_to_ppc(TMP_REG_2), b2p_bpf_array));
+	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), bpf_to_ppc(TMP_REG_2),
+			offsetof(struct bpf_array, ptrs)));
+
+	/*
+	 * if (prog == NULL)
+	 *   goto out;
+	 */
+	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_2), 0));
+	PPC_BCC_SHORT(COND_EQ, out);
+
+	/* goto *(prog->bpf_func + prologue_size); */
+	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), bpf_to_ppc(TMP_REG_2),
+			offsetof(struct bpf_prog, bpf_func)));
+	EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_2), bpf_to_ppc(TMP_REG_2),
+			  FUNCTION_DESCR_SIZE + bpf_tailcall_prologue_size));
+	EMIT(PPC_RAW_MTCTR(bpf_to_ppc(TMP_REG_2)));
+
 	/*
 	 * Before writing updated tail_call_info, distinguish if current frame
 	 * is storing a reference to tail_call_info or actual tcc value in
@@ -539,24 +560,6 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	/* Writeback updated value to tail_call_info */
 	EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2), 0));
 
-	/* prog = array->ptrs[index]; */
-	EMIT(PPC_RAW_MULI(bpf_to_ppc(TMP_REG_1), b2p_index, 8));
-	EMIT(PPC_RAW_ADD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), b2p_bpf_array));
-	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), offsetof(struct bpf_array, ptrs)));
-
-	/*
-	 * if (prog == NULL)
-	 *   goto out;
-	 */
-	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), 0));
-	PPC_BCC_SHORT(COND_EQ, out);
-
-	/* goto *(prog->bpf_func + prologue_size); */
-	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), offsetof(struct bpf_prog, bpf_func)));
-	EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1),
-			FUNCTION_DESCR_SIZE + bpf_tailcall_prologue_size));
-	EMIT(PPC_RAW_MTCTR(bpf_to_ppc(TMP_REG_1)));
-
 	/* tear down stack, restore NVRs, ... */
 	bpf_jit_emit_common_epilogue(image, ctx);
 
-- 
2.53.0


