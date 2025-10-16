Return-Path: <stable+bounces-186211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48484BE59F1
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 23:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F85A54416A
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 21:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858EA2E426A;
	Thu, 16 Oct 2025 21:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G5+nmSZM"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFD62E2DD8
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651730; cv=none; b=WJ2+JoN5uYYhVvVohgWwxiRp22EnJ3KMcKz8+EPrvN2UQxwcg06KNg3WlkSIj1FyETPt0QsHIPpWs0iYBLHyJ3WuchV7LqvLoB8UmYSw12B6DWjkWH6Oi7eNxuboK79YtYtSnp/ExdaX+IN3ausAE9BPAWozkOFH8XdiiB0vs28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651730; c=relaxed/simple;
	bh=UBfqZuKSgLJgf+zdtqj0FP3V3fsfG3jQrNBt/N9fIGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1RU1CDYwE4/Fv2eBFoGoG3O4M/u+sBDBWRMzceViTyJEQmF+wvaxr1Y7xizdqYGKKyYDZXdnTr6kJJDSs5hTsF18ZuNQouR5JZFKgzS41YKvGmddD+/arh5ZkrcRfmuRNqGVY5oHiyaLCbN/ZCjpH+dWKcYh6Kl0P9NDT/Seno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G5+nmSZM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKvqmE023883;
	Thu, 16 Oct 2025 21:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tLnj04gaBeVRS4u9g
	AoDR0HG6O5nNmDILghq+MBPhb4=; b=G5+nmSZMvdk3Wz2u8cv00ZaPLNq6PlxMO
	KNMH+VlP9ZM8woMGbXM3vjcmcG+j3WDD0x3cBE2KAhcyPgFJmCkrBN+bv3mTroHB
	ZYN4p6+gvea0gJzKrQ9AV3Gn004sV5vJ+zFcLMX1O1AE62iXwAXUMryycim9qsC7
	2zRj1hp/JqXYRMLAiygNY/A+RdbutM7U9AZGotC22HPHMDl9XXCvmptfD9fCNC0C
	OQzIHnwgz6FZQhSdxttevkT69unSMyFcE2XSYF1Ss8EP+5+8HIjz1sym5exLbJaD
	14g+CBjn4gq4vcRx6Ffc/Sik5wTLYrLBiC8I2aFrgrymYgD4vNUVQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49tfxpq236-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 21:55:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GJUJrR015259;
	Thu, 16 Oct 2025 21:55:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r1jsg9wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 21:55:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GLtCpk33751456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 21:55:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A01220174;
	Thu, 16 Oct 2025 21:55:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5711D20175;
	Thu, 16 Oct 2025 21:55:12 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.58.138])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 21:55:12 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.6.y 4/5] s390/bpf: Write back tail call counter for BPF_PSEUDO_CALL
Date: Thu, 16 Oct 2025 23:51:27 +0200
Message-ID: <20251016215450.53494-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016215450.53494-1-iii@linux.ibm.com>
References: <20251016215450.53494-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H6_l5DEn3NijapG8CS9dOuuGTPrN3sX_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDEyNSBTYWx0ZWRfXz2DczeE3j0rV
 rzuSSCv7TRX2Or/jn2nx7Cm6et4CGktya/6tF+0nrcRU0yxKXjLTl45kUk3qQJAs2VqISDyUhYF
 vZYm+SaxujORqiK6gl2ScJgaBP0GULmO4ZEcfxWLQF7DSV/ZKckTpzSnl9srt9GFDWPUjbu5gxM
 hG86TajEwfLK7/er9xU4OTvwzicIWpf/XnVEk5d/Th9uWlgK4MxqjPDw/Vzg9X0hWmslBK4Q+58
 MwmQNoggFDCihJeR8v2YZ/BGoEi0kpWi9Rp3xPFeG8gyFjlr+D7JDooG5+GXkd04mhKXwkMCtsf
 vGzaMsegbE/XJvhFxnC/fCVKL1jyUfZX4n1+NBZ34z/61c1MXzPPBjHTD2h/XbFVwXLNlVipCTC
 0GWC+Zv+FiIvsH58DohM7anx7HIxzg==
X-Authority-Analysis: v=2.4 cv=R+wO2NRX c=1 sm=1 tr=0 ts=68f169c5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=hWMQpYRtAAAA:8 a=pAWVCH5PS7jakKlMGnsA:9 a=KCsI-UfzjElwHeZNREa_:22
X-Proofpoint-ORIG-GUID: H6_l5DEn3NijapG8CS9dOuuGTPrN3sX_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510150125

commit c861a6b147137d10b5ff88a2c492ba376cd1b8b0 upstream.

The tailcall_bpf2bpf_hierarchy_1 test hangs on s390. Its call graph is
as follows:

  entry()
    subprog_tail()
      bpf_tail_call_static(0) -> entry + tail_call_start
    subprog_tail()
      bpf_tail_call_static(0) -> entry + tail_call_start

entry() copies its tail call counter to the subprog_tail()'s frame,
which then increments it. However, the incremented result is discarded,
leading to an astronomically large number of tail calls.

Fix by writing the incremented counter back to the entry()'s frame.

Fixes: dd691e847d28 ("s390/bpf: Implement bpf_jit_supports_subprog_tailcalls()")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20250813121016.163375-3-iii@linux.ibm.com
---
 arch/s390/net/bpf_jit_comp.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index cfcf2ee960944..15c6ab660a5ba 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1439,13 +1439,6 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		jit->seen |= SEEN_FUNC;
 		/*
 		 * Copy the tail call counter to where the callee expects it.
-		 *
-		 * Note 1: The callee can increment the tail call counter, but
-		 * we do not load it back, since the x86 JIT does not do this
-		 * either.
-		 *
-		 * Note 2: We assume that the verifier does not let us call the
-		 * main program, which clears the tail call counter on entry.
 		 */
 		/* mvc tail_call_cnt(4,%r15),frame_off+tail_call_cnt(%r15) */
 		_EMIT6(0xd203f000 | offsetof(struct prog_frame, tail_call_cnt),
@@ -1472,6 +1465,22 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		call_r1(jit);
 		/* lgr %b0,%r2: load return value into %b0 */
 		EMIT4(0xb9040000, BPF_REG_0, REG_2);
+
+		/*
+		 * Copy the potentially updated tail call counter back.
+		 */
+
+		if (insn->src_reg == BPF_PSEUDO_CALL)
+			/*
+			 * mvc frame_off+tail_call_cnt(%r15),
+			 *     tail_call_cnt(4,%r15)
+			 */
+			_EMIT6(0xd203f000 | (jit->frame_off +
+					     offsetof(struct prog_frame,
+						      tail_call_cnt)),
+			       0xf000 | offsetof(struct prog_frame,
+						 tail_call_cnt));
+
 		break;
 	}
 	case BPF_JMP | BPF_TAIL_CALL: {
-- 
2.51.0


