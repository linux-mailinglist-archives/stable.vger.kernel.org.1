Return-Path: <stable+bounces-249130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNowJ23+CWqqvwQAu9opvQ
	(envelope-from <stable+bounces-249130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:44:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CD0562B9B
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 958EF3007F61
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5863C7E13;
	Sun, 17 May 2026 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D5Csm0So"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDCB263C9F;
	Sun, 17 May 2026 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039666; cv=none; b=G5+x370tZ1UlO0fxk2F6jRtP/p7AkRc16SDt/SQ6bij2GlTlha5ga1gE5vtYhZ/vVWykHW8ZOabkBVOiXssocKLkVXYaLHpzfx3YzpzupcrGPaBNO9Hiyn7W5O+nci/EAqb/vg+7+7RemDeP/tPQNAskbgFkJVJZw+sesPWACLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039666; c=relaxed/simple;
	bh=aHXQgY7hxlJ/GOb+TvX1ukp7628IwZXN0Mgad7IInfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kv9ZKDeMwu1BMwIT32IDdb82TLykUqq1Es258fMRmpDLANYdiZvPXtEGJoIWkhqXXgC4rGTQcL8aU0BclUbhYYqhCxQMNtAs0i2gwNmLuh0w8fqk4iQDMMDbF576hGQeaWsHlTK99tGLK9LUJ2JPANSJ1zKAiKUOSzbmDoPuEiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D5Csm0So; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64GMf9Oi2415670;
	Sun, 17 May 2026 17:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0yx8o1vLrB65vCCuG
	PvOK4QUoLEyCAyYVHQNpTUGhjI=; b=D5Csm0SonxsdKRUxH5MqWTG2SDNdap32N
	jfuHruhed3AY0yFOYDeSiz4kV2WfKrGHiovU5/p6zwDmYihNnB8pKwBGXVUKHTmQ
	Mh9KieVqfewvjiiVsLxyixi6g+iR1YMLx8pbYVHzj8iTpNSVevuaxlo8eorz5kof
	8q4hl7bffBnZ3AbRBjEumVdrsK95l92bQlOvZcBREusSQfRH0DPUF20ckiTQNAb0
	t0Dh/srLtY9XovPDS1QW0MrmNJIerAkeX69NDbDG+7DYzQ0k7w9bwvfAQSYW9vbg
	tlAliEFaKWXHkbrVFKI/x04oVEpSudSRWPWSzGh2FxlcxAthPLP6Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6havvb9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 May 2026 17:40:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64HHdJ88021758;
	Sun, 17 May 2026 17:40:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vjj9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 May 2026 17:40:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64HHec3u49742122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 May 2026 17:40:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC81120043;
	Sun, 17 May 2026 17:40:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4C4F20040;
	Sun, 17 May 2026 17:40:36 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 17 May 2026 17:40:36 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v4 3/5] selftest/bpf: Fixing powerpc JIT disassembly failure
Date: Sun, 17 May 2026 17:40:41 -0400
Message-ID: <20260517214043.12975-4-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260517214043.12975-1-adubey@linux.ibm.com>
References: <20260517214043.12975-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE5MCBTYWx0ZWRfX7LXA5tvW/ONG
 GDIlAZKnQpkNpNyapHlXqhZ2y8ah8MwLP7bj2KNt2NCDzYoGycn3Glbsxgo16ib/0QE/VdgDhG1
 yean4CgZV7IYKXYhzI4dbRaQ9pXTUb7HPPosG5ZbwbwHl264ldEv1DjA+FsV2OWR/4PeJV8VkuY
 md0dax/0asoXy0j2+Ays9V8IuQP6Hq0IfbUZY2CjpKncSBqf6W2aG6EDcgBVc2bUKai/kbANk/t
 NFc4R2Erqh6zWsWw8dLMWglRCl4EREas+q61SlQBpvl0r9ErWru8RbxJolFhcEhMMcOwxxgNWlm
 ceHwUEhhnK7n4lR/pGIm4vJQej8bB8kDaZTLirNW21Ur57jPBpYL1sSRpes50iXff5QjuOXfY4y
 hPai46lk7D0w9r9wFpEQGCdiUSh0mE4q9fLNy7hLejjUrsu/dp02uwS5YaMQf2PfZrfB8SFaaMO
 uZPbgE700RScEf4eE8A==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a09fd9b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=kVjrMc9Is9WrAmO39HcA:9
X-Proofpoint-ORIG-GUID: oaZr3eb76Dx-fOZN6lsuHLJiq7LrOTXc
X-Proofpoint-GUID: oaZr3eb76Dx-fOZN6lsuHLJiq7LrOTXc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170190
X-Rspamd-Queue-Id: 45CD0562B9B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	DATE_IN_FUTURE(4.00)[3];
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249130-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adubey@linux.ibm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

From: Abhishek Dubey <adubey@linux.ibm.com>

Ensure that the trampoline stubs JITed at the tail of the
epilogue do not expose the dummy trampoline address stored
in the last 8 bytes (for both 64-bit and 32-bit PowerPC)
to the disassembly flow. Prevent the disassembler from
ingesting this memory address, as it may occasionally decode
into a seemingly valid but incorrect instruction. Fix this
issue by truncating the last 8 bytes from JITed buffers
before supplying them for disassembly.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 tools/testing/selftests/bpf/jit_disasm_helpers.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
index 364c557c5115..4c6bcbe08491 100644
--- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
+++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
@@ -170,9 +170,11 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
 	__u32 jited_funcs, len, pc;
+	__u32 trunc_len = 0;
 	__u32 *func_lens = NULL;
 	FILE *text_out = NULL;
 	uint8_t *image = NULL;
+	char *triple = NULL;
 	int i, err = 0;
 
 	if (!llvm_initialized) {
@@ -216,9 +218,18 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
 	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #2"))
 		goto out;
 
+	/*
+	 * last 8 bytes contains dummy_trampoline address in JIT
+	 * output for 64-bit and 32-bit powerpc, which can't
+	 * disassemble a to valid instruction.
+	 */
+	triple = LLVMGetDefaultTargetTriple();
+	if (strstr(triple, "powerpc"))
+		trunc_len = 8;
+
 	for (pc = 0, i = 0; i < jited_funcs; ++i) {
 		fprintf(text_out, "func #%d:\n", i);
-		disasm_one_func(text_out, image + pc, func_lens[i]);
+		disasm_one_func(text_out, image + pc, func_lens[i] - trunc_len);
 		fprintf(text_out, "\n");
 		pc += func_lens[i];
 	}
-- 
2.52.0


