Return-Path: <stable+bounces-233115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NwWA37UzmkkqgYAu9opvQ
	(envelope-from <stable+bounces-233115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 22:41:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A122538E19C
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 22:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65FDA300B13A
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 20:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741FA3537C8;
	Thu,  2 Apr 2026 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MwmdnD6F"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C705133EB1B;
	Thu,  2 Apr 2026 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775162452; cv=none; b=aePR6uUB3CZki+cxuNpeqJ+7CWCHMrpHmLispjiCDoNtIUc9ypKckjCN/GFkG5E8jWXvEaYIOv2zPpFqli/b2kUlINI77yemYxr4bcZxfFQgIl3H5/6vpShRvGWnXFMlV75/L1pzXERHQ6hQmsYjMYn5Hgvu+xEbZGzXG0sVnH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775162452; c=relaxed/simple;
	bh=7c5AA2Yup/45KAKktxiiuE8bDS1sAavBaEVzZxm/LI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddpV8Dz5fsSp8uYnb+z2CU5uTrZBPUFHc2U7RKUiAVtbQaKnRONefDc7x/z/aV2kDzMMl+iZB2oqfu+Y5aiNLKwSFTtUI8o2EE3Ki+FQ68ayyOy0BsRF7f90MBQmpq6YjqbX+KMk3bfNTVHZWZuIyM/pdwaN7PptCdT1FU5oaZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MwmdnD6F; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632KGfca2411380;
	Thu, 2 Apr 2026 20:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=B1/Neq2m/CTKiuUiX
	s1KrqxKRjM7xfwfRTx73tLTlgE=; b=MwmdnD6FFZ65f3cWJE/nsLoSfK5RPvksD
	NYfRfoAJVnqM6VkJcs8x6NKp7KacYJXUOJSktv8MM1BFISZQjlS2ccefvDPZKHh2
	8AWsVUPKZkuFjD2I4CZpUTxTJvQ+CrSzGz2d1VW0wv0YmE3/evWpPPMDQAZT7WK/
	SJPm3EZl3urgszKMFqojP9PQKcoSLNK/Fbbpnf82XYWHrEsAh4R+sn+1NGsdHylU
	P5BNvB5d+0PNd28Vct4ZlgKL+HFYgOKONBsoayUk3zsKJ4gcNhtTutWJXn0IBoFB
	KevbydR9woSEDnCegwL11lcltn4VHlTVfiNrb+xF2uqVmP9IvmNrw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgwrrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 20:40:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632GtqZ4013922;
	Thu, 2 Apr 2026 20:40:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkuk4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 20:40:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632KeTgo26870042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 20:40:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE62620043;
	Thu,  2 Apr 2026 20:40:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C91F520040;
	Thu,  2 Apr 2026 20:40:27 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 20:40:27 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v2 4/5] selftest/bpf: Enable verifier selftest for powerpc64
Date: Thu,  2 Apr 2026 20:40:10 -0400
Message-ID: <20260403004011.44417-5-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403004011.44417-1-adubey@linux.ibm.com>
References: <20260403004011.44417-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE4MSBTYWx0ZWRfX7vCVFiok5Nkl
 quj7/HbPrGeqw3Y/T+gWpX4T29l5dGGW47fVY01rucGF1GuZuClPcArZ+CviIFzxqyIWPPQl9lC
 ZhBQ+/DLPtyB9ANA6ktbrGwH64/7q5YROf2C61DVdFXMA9eH0Kye1QrVB5ICdDPekTnm9B3oIzx
 /vMePGNy8rDXW49PpyhU+BP9wpnC8vkSK+8ZMTUiMsKrxkVVdLCHpChgL2Agigtz+LYoLBdOnMm
 3fUEXL1jChHqJWE7UBB3ILvz5bNzKAhefzotojftw0MRNyHjHdqG8jjF3OB95Wcca82pJ+Pq7ft
 pXs0uZsUoNNkNlwlQK1dS7r/aw/LciTSOmJSH+8l4Qc9RqCYEgfzg0tKi6ytIbaKR3ViB4GZCmp
 jcpKKGUEAur41SmqjpvZFlNbhm8JQnZELiUsHS4wkG/RKOdoCv55M+3eYDIn8bQOyydGAQf/6/j
 gBQ3uAzfStznPJfsXgw==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69ced442 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=LqUW6rLYXr1P-t3EVGcA:9
X-Proofpoint-GUID: G4EF9MynNtk7xB9kFL25Ufpzwj27hL7L
X-Proofpoint-ORIG-GUID: G4EF9MynNtk7xB9kFL25Ufpzwj27hL7L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020181
X-Spamd-Result: default: False [3.34 / 15.00];
	DATE_IN_FUTURE(4.00)[3];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233115-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: A122538E19C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Abhishek Dubey <adubey@linux.ibm.com>

This patch enables arch specifier "__powerpc64" in verifier
selftest for ppc64. Power 32-bit would require separate
handling. Changes tested for ppc64 only.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 1 +
 tools/testing/selftests/bpf/test_loader.c    | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index c9bfbe1bafc1..dee284c3ddba 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -155,6 +155,7 @@
 #define __arch_arm64		__arch("ARM64")
 #define __arch_riscv64		__arch("RISCV64")
 #define __arch_s390x		__arch("s390x")
+#define __arch_powerpc64	__arch("POWERPC64")
 #define __caps_unpriv(caps)	__attribute__((btf_decl_tag("comment:test_caps_unpriv=" EXPAND_QUOTE(caps))))
 #define __load_if_JITed()	__attribute__((btf_decl_tag("comment:load_mode=jited")))
 #define __load_if_no_JITed()	__attribute__((btf_decl_tag("comment:load_mode=no_jited")))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 338c035c3688..fc8b95316379 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -378,6 +378,7 @@ enum arch {
 	ARCH_ARM64	= 0x4,
 	ARCH_RISCV64	= 0x8,
 	ARCH_S390X	= 0x10,
+	ARCH_POWERPC64	= 0x20,
 };
 
 static int get_current_arch(void)
@@ -390,6 +391,8 @@ static int get_current_arch(void)
 	return ARCH_RISCV64;
 #elif defined(__s390x__)
 	return ARCH_S390X;
+#elif defined(__powerpc64__)
+	return ARCH_POWERPC64;
 #endif
 	return ARCH_UNKNOWN;
 }
@@ -587,6 +590,8 @@ static int parse_test_spec(struct test_loader *tester,
 				arch = ARCH_RISCV64;
 			} else if (strcmp(val, "s390x") == 0) {
 				arch = ARCH_S390X;
+			} else if (strcmp(val, "POWERPC64") == 0) {
+				arch = ARCH_POWERPC64;
 			} else {
 				PRINT_FAIL("bad arch spec: '%s'\n", val);
 				err = -EINVAL;
-- 
2.52.0


