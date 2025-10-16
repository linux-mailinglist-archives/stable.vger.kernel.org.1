Return-Path: <stable+bounces-186212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D9476BE59EC
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 23:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3A004F51DF
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 21:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E3F2DE6F4;
	Thu, 16 Oct 2025 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b4tURawA"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA12E3B11
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651731; cv=none; b=UG/okzIxYoU43iRfuEqRkn+u0qHRpCQYCRRX87bedcfS+0BTosauPaJQgv0GGTBp+D6qOtVFLrPRCJiC9TaAZvzdM6cIIGKizvy4XOlIESBc8oWgx0YftE/7Cui04vIg9juoF0hlp77MH0ObmeuLrDQ+k1b51qBlLjzFacfwyrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651731; c=relaxed/simple;
	bh=9bdPOPGf4o0GjD1y6LDPNUBC7f4fEg7rKwQjxiizuz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AajAN9m+tKQj5azfeSiCmrs1NTjWvb3GWbVxFR29BgSGVVPembuVhsUuRPa01dcQGLqe9L4yFZ5GwYozllCTd0uUR/hTbqDAqMNszrqtAD/eE1lBPMYhgtxjqfAMCWOswrkPEBD1q7K6snZQ9rZC9nXTAZ1nqYKhVcSwhUVS1dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b4tURawA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GGUG00010109;
	Thu, 16 Oct 2025 21:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Vnd+B9T3yQ3HbkLY3
	N15OAhv4wgLSXQGf0Tf2YvhZVw=; b=b4tURawAlKxSAjt3fgJIgfCII/6rO0z5z
	iGWs6h37E9Zoe8ReHPN98ufzDl2TsiWwGaXecj5jUTbU4joZZOOq3rFEgn1D5hiH
	GUz+lZlVAtn0RyBeYGgBbe9+AOpQkdofuvd5OOnrTi4Hycink7O/zO+xk5lEG895
	gifNxPS6FUmXt9yRN6fu0hO3gKYfFuAK7s75f63x0x8yt9AUfJDFa4hGI8HGaNIz
	ARNWD9IhWHDlZv0lI0MbpsWixiSJxK8cx13bQ1bkyZDFHl4XbJmgOYC0e5LpQ0iH
	wGtyZQ3/gv8sOSq71rmCT+IUVdG3nU8XgN+pFp5D5hDpNMgq3OEsw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewudduq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 21:55:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GINbaB014981;
	Thu, 16 Oct 2025 21:55:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjqtbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 21:55:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GLtCQO33751458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 21:55:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE60C20174;
	Thu, 16 Oct 2025 21:55:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A94520173;
	Thu, 16 Oct 2025 21:55:12 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.58.138])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 21:55:12 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.6.y 5/5] s390/bpf: Write back tail call counter for BPF_TRAMP_F_CALL_ORIG
Date: Thu, 16 Oct 2025 23:51:28 +0200
Message-ID: <20251016215450.53494-6-iii@linux.ibm.com>
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
X-Proofpoint-GUID: Md0HeZckuN_UAoo1znghaJSRIFUxE_KK
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68f169c5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=hWMQpYRtAAAA:8 a=PzRsl5-gkreILLghS_IA:9 a=KCsI-UfzjElwHeZNREa_:22
X-Proofpoint-ORIG-GUID: Md0HeZckuN_UAoo1znghaJSRIFUxE_KK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX/O/WFspc4NJ0
 Wg0Pys5C6A8pWJNYZmZi1T5f8syM8TsJWLMcm1nlaDMMw/CGQBodx94Dp7BdePEnHMEt7M4ET5R
 E6xELBZ+4ldAyYKzp79eF7VgmvezFdxu904P+BTesl5X85x7VUGiHfY2G4JUHAqOLQhzm+joAgX
 kdsxPKxNUBL05Ca/Q1LsUvDS262rY2zZC08FViRCA950jsazw/tHKHhvJExkp0LGEr6IF13R4/u
 Ifb0JAlnFaDpanzeH2XyGsZx0HANI6QBQunWEsQIsL389SHLPb7smha67XT58QDnCEJgRxN7vru
 6Mt+SmS4Vqb/abKGOoC0luAVmGYtvvyGtR8CiuPXWDEknFVxdSd+hJjXVyIIw8wh2v631ykxW8z
 YE2fBtwO+SrFqUuXp7zukwBvJidKJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014

commit bc3905a71f02511607d3ccf732360580209cac4c upstream.

The tailcall_bpf2bpf_hierarchy_fentry test hangs on s390. Its call
graph is as follows:

  entry()
    subprog_tail()
      trampoline()
        fentry()
        the rest of subprog_tail()  # via BPF_TRAMP_F_CALL_ORIG
        return to entry()

The problem is that the rest of subprog_tail() increments the tail call
counter, but the trampoline discards the incremented value. This
results in an astronomically large number of tail calls.

Fix by making the trampoline write the incremented tail call counter
back.

Fixes: 528eb2cb87bc ("s390/bpf: Implement arch_prepare_bpf_trampoline()")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20250813121016.163375-4-iii@linux.ibm.com
---
 arch/s390/net/bpf_jit_comp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 15c6ab660a5ba..5a64d34a37482 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2462,6 +2462,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		/* stg %r2,retval_off(%r15) */
 		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_2, REG_0, REG_15,
 			      tjit->retval_off);
+		/* mvc tccnt_off(%r15),tail_call_cnt(4,%r15) */
+		_EMIT6(0xd203f000 | tjit->tccnt_off,
+		       0xf000 | offsetof(struct prog_frame, tail_call_cnt));
 
 		im->ip_after_call = jit->prg_buf + jit->prg;
 
-- 
2.51.0


