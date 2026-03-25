Return-Path: <stable+bounces-230380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH1/IIYxxGkAxQQAu9opvQ
	(envelope-from <stable+bounces-230380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 20:03:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6FD32AF7B
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 20:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28DF330A79E7
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 19:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C233351C3A;
	Wed, 25 Mar 2026 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dHn0lFQ0"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F183034EF12
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465253; cv=none; b=ZnzmRS/vAZhAQBC6XxRKSHAIx2HQligfg5RFla+YRBmYRGRnB22K/tWEj0o3kcZgQDEPBTEwOfvQ9gv/npc5Gu+a7//3sxZq2MClpGC8WeS2YQSYAV4972XZFBO/0FLPXE1x6iBg8Uzs6dY19pCKXIXePN1eGHtFPWnKa7XEMcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465253; c=relaxed/simple;
	bh=T+UwMxNPQNCLCDH28WOpTer5zcWqKwQHlGmFSmGq0rY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ta5K7jwOwIG0U9NJavQtTR35QFwR6kRWfudx79R0XuP9yS8zs7eEQn47sb8bU6rNk0N+wcsiQCZuqE2Rc00U4HZE1q9d5do6m0ZA9hIIBQqt4pF5bmsNTwNSMieNGIrkyC+lMV99i89O+4N0sE53eU229Qg9qJZh3KKso+DSExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dHn0lFQ0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P8Pt2N3835878;
	Wed, 25 Mar 2026 19:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=K5cFNRMjWs8epAbwx1tZqLih6ZD01PT0KnC9e+vRK
	tk=; b=dHn0lFQ0hfo95LHvINuDvdvUDVJwO4ku1HrY96fizhX2vIFgp5KCHmjOQ
	2Xn84ngGJPfv1zK78VP6z7sbwxo1LaV669kgtvLBOLONNZwqiWgs9C7ggIcDmRfb
	rYdm4/KnsWrLc2SpeK5RwPyJXX4+YLNo5P+aI1aUXgMS24vTXdPxzxCQESS9UPic
	pvkyVDPdb186tPnbn0ePoY+tvt9kP4axSrXsDkYW0pv8b+50EuNcTv5c6kggIS7O
	ytoK5hInQ6vIqILOfZJKq+68Pug83ks6yzPXlfp4IJdhB9kp2KVpVU30CmR3ePhj
	jjbSZhEgwB8bIWfH5JuJcGd6Xblqw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky093xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 19:00:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PGfEJ9012185;
	Wed, 25 Mar 2026 19:00:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk7p8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 19:00:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PJ0Z9b44171560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 19:00:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA5F02004B;
	Wed, 25 Mar 2026 19:00:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68EFB20040;
	Wed, 25 Mar 2026 19:00:34 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.124.223.34])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 19:00:34 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 5.15-5.10] powerpc64/bpf: do not increment tailcall count when prog is NULL
Date: Thu, 26 Mar 2026 00:30:33 +0530
Message-ID: <20260325190033.1293192-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEzNyBTYWx0ZWRfX3RK0EOwXngFp
 phA9lAvrfCVLvcyZ1ANRCRRVvB1SV38E88d9qQ/5Ja/02mrF49Un2psMgJj6u+dP//z94EaKEeZ
 alvimXl5HMz+13oUgV/Gcui0kScmu29uD6OWtF0diYYn2Cx61Z0mtG3+cqssitfkY4rr9tj/9rI
 83iBpQdUKy742hP7opfVr80QPK4/h9VodTTIzpDhggjtL5nudTJLTRYb+P7uxWFKBIqp+ibp8hW
 shltlYSAEJbn3ViPg7y7HN+DreAma7pnUdIaR39xiiKAW/iBDcHNuHbvbKDfDkw8ur0u/QzMjGs
 hLV1A4Cq4k4cCykL0pcgOia7XMkZhP+IKi3L+N2SKIWlhBw3dS52hivGstucb6jGaL1zD89PUNm
 GHJARyZPx0/EwhvtZBM4RqUE6H+r9TOoSqFR+slVPMaI2BgUSn5TlqDPpHgXI5Aoun6dRBoi9BY
 428huHu8CK6qRfhxZVw==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c430d8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=bC-a23v3AAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=XpWiXUAiTzI7VDA3ZbkA:9 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: d3WgRtvMF9iZJ_0gI1IsjeKevXmqyw8_
X-Proofpoint-GUID: d3WgRtvMF9iZJ_0gI1IsjeKevXmqyw8_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250137
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230380-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hbathini@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: EE6FD32AF7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit 521bd39d9d28ce54cbfec7f9b89c94ad4fdb8350 ]

Do not increment tailcall count, if tailcall did not succeed due to
missing BPF program.

Fixes: ce0761419fae ("powerpc/bpf: Implement support for tail calls")
Cc: stable@vger.kernel.org
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20260303181031.390073-2-hbathini@linux.ibm.com
[ Conflicts due to missing clean up commits
    b10cb163c4b3 ("powerpc64/bpf elfv2: Setup kernel TOC in r2 on entry")
    49c3af43e65f ("powerpc/bpf:   Simplify bpf_to_ppc() and adopt it for powerpc64")
    036d559c0bde ("powerpc/bpf: Use _Rn macros for GPRs")
  and missing feature commit 2ed2d8f6fb38 ("powerpc64/bpf: Support
  tailcalls with subprogs") resolved accordingly. ]
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 57e1b6680365..6f4a7bcf53aa 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -239,30 +239,32 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	 * tail_call_cnt++;
 	 */
 	EMIT(PPC_RAW_ADDI(b2p[TMP_REG_1], b2p[TMP_REG_1], 1));
-	PPC_BPF_STL(b2p[TMP_REG_1], 1, bpf_jit_stack_tailcallcnt(ctx));
 
 	/* prog = array->ptrs[index]; */
-	EMIT(PPC_RAW_MULI(b2p[TMP_REG_1], b2p_index, 8));
-	EMIT(PPC_RAW_ADD(b2p[TMP_REG_1], b2p[TMP_REG_1], b2p_bpf_array));
-	PPC_BPF_LL(b2p[TMP_REG_1], b2p[TMP_REG_1], offsetof(struct bpf_array, ptrs));
+	EMIT(PPC_RAW_MULI(b2p[TMP_REG_2], b2p_index, 8));
+	EMIT(PPC_RAW_ADD(b2p[TMP_REG_2], b2p[TMP_REG_2], b2p_bpf_array));
+	PPC_BPF_LL(b2p[TMP_REG_2], b2p[TMP_REG_2], offsetof(struct bpf_array, ptrs));
 
 	/*
 	 * if (prog == NULL)
 	 *   goto out;
 	 */
-	EMIT(PPC_RAW_CMPLDI(b2p[TMP_REG_1], 0));
+	EMIT(PPC_RAW_CMPLDI(b2p[TMP_REG_2], 0));
 	PPC_BCC(COND_EQ, out);
 
 	/* goto *(prog->bpf_func + prologue_size); */
-	PPC_BPF_LL(b2p[TMP_REG_1], b2p[TMP_REG_1], offsetof(struct bpf_prog, bpf_func));
+	PPC_BPF_LL(b2p[TMP_REG_2], b2p[TMP_REG_2], offsetof(struct bpf_prog, bpf_func));
 #ifdef PPC64_ELF_ABI_v1
 	/* skip past the function descriptor */
-	EMIT(PPC_RAW_ADDI(b2p[TMP_REG_1], b2p[TMP_REG_1],
+	EMIT(PPC_RAW_ADDI(b2p[TMP_REG_2], b2p[TMP_REG_2],
 			FUNCTION_DESCR_SIZE + BPF_TAILCALL_PROLOGUE_SIZE));
 #else
-	EMIT(PPC_RAW_ADDI(b2p[TMP_REG_1], b2p[TMP_REG_1], BPF_TAILCALL_PROLOGUE_SIZE));
+	EMIT(PPC_RAW_ADDI(b2p[TMP_REG_2], b2p[TMP_REG_2], BPF_TAILCALL_PROLOGUE_SIZE));
 #endif
-	EMIT(PPC_RAW_MTCTR(b2p[TMP_REG_1]));
+	EMIT(PPC_RAW_MTCTR(b2p[TMP_REG_2]));
+
+	/* Writeback updated tailcall count */
+	PPC_BPF_STL(b2p[TMP_REG_1], 1, bpf_jit_stack_tailcallcnt(ctx));
 
 	/* tear down stack, restore NVRs, ... */
 	bpf_jit_emit_common_epilogue(image, ctx);
-- 
2.53.0


