Return-Path: <stable+bounces-216663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDclINu/kmmnxAEAu9opvQ
	(envelope-from <stable+bounces-216663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 07:57:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC23F141288
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 07:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E6DA3016913
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 06:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549642EAD15;
	Mon, 16 Feb 2026 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n7nHu35x"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99E22C08AB;
	Mon, 16 Feb 2026 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771225029; cv=none; b=rfTX8eJsqjQssesyeFmRvqFvF7B5kItW5/BQBa0GtCKFSK2r+imSmb6cHM/ov1RwDYiU3rACz/xTz8IjpBlDayBpGa1cFksMBzZqguupTvOPqCE+D0poXn7QFYU02oLCXAGDirs0xs+2JrYfwCQSEMGYBba8j3g6E76Kr6Xc+Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771225029; c=relaxed/simple;
	bh=GWtDO8ebIYnpSqaiS2eI3hhO8Tfy3e2PsmYQ7UhhaDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leL/EGZadaIYJEiptnJT4T55lJPlqUk9SXX5eruiG6EXAL+6xtyBXFFMgIgdCKVVeTwu1aAPSnhnYOMUF6cArRCXOhZPrDKTdXFCfRmPD90TW9MdXZ3yVNj8WUMc8IkTkSCWlipBMrhx2T8k9PyxK8F8o4NVbUO5wyA4ltprcxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n7nHu35x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FCZloe2534882;
	Mon, 16 Feb 2026 06:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2XX0R9TtZrIBWJXgK
	I/YKmAKnVgu8iZtTRCdZ43Gui4=; b=n7nHu35xIL5ZnNFc/5bSfc6UbN66tO7eK
	IweFt55+6LEEwtg5NYjkKp20mKSQSQBl0dgUQlYV/SYUDcnvPxq3ftJv2LOEx1XS
	VWgrhmNnA79Y+23nw3mhIcHVEmW0lRprZtS43SUfhZTpqVZTzaJHt1ZYZa2yweP9
	44v4876zeIPMbCZnCQraAqglkJ4tlW6Xv0A2ErIyU2nhaDoqohqaXZJiictgHf+9
	ib5L8ezOhoYjgy+heD02q6KgieJHc3CpyGAY2j3yGb0jVdKu54+zOX/8f3/xFwmm
	tRIRdVuiGh1Oxr/tYZOWPInRAhdkPTrtYQ3zuKCOG61lZ/NpBta7A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj63x3wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 06:56:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61G32vEd002838;
	Mon, 16 Feb 2026 06:56:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cb5kj45h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 06:56:49 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61G6ujHZ38338836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 06:56:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD9A820040;
	Mon, 16 Feb 2026 06:56:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02FA520043;
	Mon, 16 Feb 2026 06:56:44 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.78.106.17])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 06:56:43 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Abhishek Dubey <adubey@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH 2/5] powerpc64/bpf: fix the address returned by bpf_get_func_ip
Date: Mon, 16 Feb 2026 12:26:36 +0530
Message-ID: <20260216065639.1750181-3-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216065639.1750181-1-hbathini@linux.ibm.com>
References: <20260216065639.1750181-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s-Hs2wh5xqKazuuC3CIC-OGV1YGxtEXq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA1NCBTYWx0ZWRfX63se1cveZzgM
 adpG9gnLyx8a1l3IPGVCzPPhPbGd4cuiYT0LV0oUgR819E3PkTD2c0M0Q6cKDUogZ7FIPHh788h
 iTQGQik3kDTKPR7D+hJhbavfJ7rGhy2oBsKOEB+sB4epnzdbHFraTV3zaYRl2KK1bnm2gpYaM55
 si3QErh080PMCdwIqn/JwWUQb27G185ZJIHmLLMMMDUW39YDZHeM8fqTpDMQO5L97+8WXtFKVQ1
 BW6qLQXaBBuXVT5ZulLa0ePG2T3FbNsrRrZ7w/UEJ5/a6kn6vg4HiZHrlcvVbLnJMJenmRvmIv2
 rNuaJBeY1f4WUn8le1RXMjS3b8/9I5gzSGjBpM6/8I6F+6+jIlsjS9q3fQudfnOj2hyzkA1j54Q
 pbvnWivLXH5OxzK+F6iMnr+wkci4CM/7rzHCFaK/gEzIkZ6j7tMc8FTVPZPT7NBXaR6DD+w1/X5
 On6+qgQYb2IEGVgzQ1w==
X-Proofpoint-GUID: s-Hs2wh5xqKazuuC3CIC-OGV1YGxtEXq
X-Authority-Analysis: v=2.4 cv=U+mfzOru c=1 sm=1 tr=0 ts=6992bfb2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=SO5buJ7TJInmnl-hmdUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160054
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216663-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hbathini@linux.ibm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: DC23F141288
X-Rspamd-Action: no action

bpf_get_func_ip() helper function returns the address of the traced
function. It relies on the IP address stored at ctx - 16 by the bpf
trampoline. On 64-bit powerpc, this address is recovered from LR
accounting for OOL trampoline. But the address stored here was off
by 4-bytes. Ensure the address is the actual start of the traced
function.

Reported-by: Abhishek Dubey <adubey@linux.ibm.com>
Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
Cc: stable@vger.kernel.org
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 987cd9fb0f37..fb6cc1f832a8 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -786,8 +786,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 *                              [ reg argN          ]
 	 *                              [ ...               ]
 	 *       regs_off               [ reg_arg1          ] prog ctx context
-	 *       nregs_off              [ args count        ]
-	 *       ip_off                 [ traced function   ]
+	 *       nregs_off              [ args count        ] ((u64 *)prog_ctx)[-1]
+	 *       ip_off                 [ traced function   ] ((u64 *)prog_ctx)[-2]
 	 *                              [ ...               ]
 	 *       run_ctx_off            [ bpf_tramp_run_ctx ]
 	 *                              [ reg argN          ]
@@ -895,7 +895,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	bpf_trampoline_save_args(image, ctx, func_frame_offset, nr_regs, regs_off);
 
-	/* Save our return address */
+	/* Save our LR/return address */
 	EMIT(PPC_RAW_MFLR(_R3));
 	if (IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE))
 		EMIT(PPC_RAW_STL(_R3, _R1, alt_lr_off));
@@ -903,24 +903,29 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		EMIT(PPC_RAW_STL(_R3, _R1, bpf_frame_size + PPC_LR_STKOFF));
 
 	/*
-	 * Save ip address of the traced function.
-	 * We could recover this from LR, but we will need to address for OOL trampoline,
-	 * and optional GEP area.
+	 * Get IP address of the traced function.
+	 * In case of CONFIG_PPC_FTRACE_OUT_OF_LINE or BPF program, LR
+	 * points to the instruction after the 'bl' instruction in the OOL stub.
+	 * Refer to ftrace_init_ool_stub() and bpf_arch_text_poke() for OOL stub
+	 * of kernel functions and bpf programs respectively.
+	 * Recover kernel function/bpf program address from the unconditional
+	 * branch instruction at the end of OOL stub.
 	 */
 	if (IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) || flags & BPF_TRAMP_F_IP_ARG) {
 		EMIT(PPC_RAW_LWZ(_R4, _R3, 4));
 		EMIT(PPC_RAW_SLWI(_R4, _R4, 6));
 		EMIT(PPC_RAW_SRAWI(_R4, _R4, 6));
 		EMIT(PPC_RAW_ADD(_R3, _R3, _R4));
-		EMIT(PPC_RAW_ADDI(_R3, _R3, 4));
 	}
 
 	if (flags & BPF_TRAMP_F_IP_ARG)
 		EMIT(PPC_RAW_STL(_R3, _R1, ip_off));
 
-	if (IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE))
+	if (IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE)) {
 		/* Fake our LR for unwind */
+		EMIT(PPC_RAW_ADDI(_R3, _R3, 4));
 		EMIT(PPC_RAW_STL(_R3, _R1, bpf_frame_size + PPC_LR_STKOFF));
+	}
 
 	/* Save function arg count -- see bpf_get_func_arg_cnt() */
 	EMIT(PPC_RAW_LI(_R3, nr_regs));
-- 
2.53.0


