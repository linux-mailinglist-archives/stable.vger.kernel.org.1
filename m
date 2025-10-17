Return-Path: <stable+bounces-186299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FBABE7E1A
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 11:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95291562510
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 09:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A0A2BEC41;
	Fri, 17 Oct 2025 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IPdHAK+z"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3322D543A
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694239; cv=none; b=OYd2XhTWe6w83rsG+1wvdLLlm2gdtAL2lkTnif0A+4igFQgBxW9IJnjw0CZBn74LJa6Q+P8OW6zZqu1kMhFwQpFDf4vEgYhou2SjnEfw/19EeOjyyGt6n+1LW72iA9UJo8Dng8m6s7HvGZrS//i546F5AuDPmSslKs4BjsmlmG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694239; c=relaxed/simple;
	bh=6PkDFxe8zKXwy0VI2jBrzAFnpqbybRSK21U6OveUuI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hv1HD8PXAhYOJp2YkHFhUOXQp1bSTqFb8dis5HYCuclPKz2+PrhieNNGNdCIz3uoCDyBf5vKrdFQFrZ1AMQ2TFYV3kr6Kv43bK3Oxg7uLXJZ+deH9Ik5YRqnWQVzlrifnKGN2soyXRW8jaGe+vHD8F455Kpl9SNcE1W8TiLJfSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IPdHAK+z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7xd9q010057;
	Fri, 17 Oct 2025 09:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vAyAFnCsM1FfSZHDd
	N7i+ce8i8HQuiJ08xgY6DxSPYE=; b=IPdHAK+zKGsQyBgrzujA1PT2/QdFCUsb6
	UaoqMZvc80RAOIgrpZlggoayvZMF9z+SbflLDLPaw95LpK+I2xACXAK1+pKiocMm
	Mbad0KDkgsFBZGd7gQS2gdvsksmEFvP4/AJVrdwBQNXQLBdmdLXQQU5H81tOGP0t
	gdYKkFhlOlaBO5J4vFtHCynRzja1YRaups/G0nzmBS0syBoNfvvGz+Oxb2EyMvGc
	NuzUvMZZRriAizjE0qD0vjisGFSciOMz/qQJdcb9niTYOYfH3hjDyGz35IKN7yBz
	9DEV0vbV0MR8IXmWgqisQ+Fx2ubANcvfwNk/ilUzuSbn1rLy3Z44A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewuhvhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 09:43:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H9CRBV015178;
	Fri, 17 Oct 2025 09:43:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r1jsmu2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 09:43:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59H9heVi40960446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 09:43:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F11D32023B;
	Fri, 17 Oct 2025 09:25:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4D252023C;
	Fri, 17 Oct 2025 09:25:52 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.58.138])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Oct 2025 09:25:52 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.12.y 3/4] s390/bpf: Write back tail call counter for BPF_PSEUDO_CALL
Date: Fri, 17 Oct 2025 11:19:06 +0200
Message-ID: <20251017092550.88640-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017092550.88640-1-iii@linux.ibm.com>
References: <20251017092550.88640-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L_QEla509dS6WzR6VwN4Wj_BcKjnWbg2
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68f20fd2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=hWMQpYRtAAAA:8 a=pAWVCH5PS7jakKlMGnsA:9 a=KCsI-UfzjElwHeZNREa_:22
X-Proofpoint-ORIG-GUID: L_QEla509dS6WzR6VwN4Wj_BcKjnWbg2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfXzqKPtSwMEWKq
 ktB0WS0Mu/PFab4TEY9F2fAgFaKm3rV9uf8AaePRTP3sFZ8tH7Z15NDYlWbBZXlCWfVatyVuZvB
 rt/5FZmuo33DfMxpqHS/4g9+AC8nKhUh2TsDRKjYT0/s1Kc+Wh1UOH9JRXqXulgXUqwljQr3ial
 9KDVTuG6HK0JSKRPnqpgsRlHiWj3vwxADRTGx7JPq3xL8PWlbMkcKkTnwIo1r3bVLRK1kcH94ds
 eijG/HfF3eGKqwS3VnwWwe4XpN19knzCKgf97xC1tQRU0tAX1hUZGwhiptl3vqUyWwQ9a+CtEIE
 CZxtGi9U+1nFF8kB5sIUzvSGUGg3HeN2zaiU2TztxZrV0CHK8PbS3fLMmsFz35gJtLJr+6gwsJ0
 Kv5Q3c6/os2NkgVtb4iEjNvr3Dg9oA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014

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
index 7907c3f9b59ab..2526a3d53fadb 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1789,13 +1789,6 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
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
@@ -1822,6 +1815,22 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
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


