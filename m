Return-Path: <stable+bounces-249682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNJ4DZu8DGpdlgUAu9opvQ
	(envelope-from <stable+bounces-249682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:40:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B9A584455
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54959303FF97
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952993B47CF;
	Tue, 19 May 2026 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RU2ftkLU"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E3036D9E7;
	Tue, 19 May 2026 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219513; cv=none; b=L2+bWLCQaJwbnDaPw/sAQh3XVPzR2AxGpDIZzRZUpa4wMlaK5GLs6/LYqqBdyvzJwhL9p2bhnDCAJ5O2M6Af8lHbESJfymqxnXepSHeEntusBobBHNconCXCYcLSqKvWo7CQ4eWKs7qhcXtbdg3lfmBQ0ziJ5+K3wwl+9QyPgEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219513; c=relaxed/simple;
	bh=A4H35fie0VvB/GeCzZsmatNMifRW26auYfYXyZExmww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbm9QeEyA5wSM/cUByz/tYJtPjQeueL9axCgG8z/UVdmxA2a//Q/LGzSbDMNvevxTLSrurLega8RP01dPjD7XMV5K5DMslYwKs1D5YQc4yAA62j6bz23F3XQQLRWNvRI4LFO1sOutOrSqajdRxfm1kfKjMwApS0eOric1+1gmFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RU2ftkLU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JGPw8H2166376;
	Tue, 19 May 2026 19:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TIct3NHUYaBH36Fj/
	LbbJuo0SwZOr7xZ34JrF6Ab3dM=; b=RU2ftkLUqRJUtpA+SqV42DyF+VuNeOUQ9
	PNZXDBxtgdgI/b6kAahrGVaFB32cWBv/1hmGMUvYiJJM7FPsz0m8y7x1h4EA9qoN
	mG3dy9FshA+Xu1o75xnn0mLiC+QOeRGqeJJ4A9RA+Wbmn5/oWpPwQjyBSNaOnl/n
	ng2A3UuyiUE2pVQUosTYxXRkO1JadRPTa8+YR0Bf/pCyNSCfFggOZbrtTiDosItG
	JOOfD6DnAoqAY64gwmPLX58B9KP7UY/EijExoUem50DdQfRVUsBtzI5MHSS8dR42
	vEboO+5NulFsx5i4+uXkp3ZaBtoXZH0UHr7NpteZutGEC/revsGFQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h74xu0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 19:38:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JJOGjh020218;
	Tue, 19 May 2026 19:38:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vvbyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 19:38:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JJc91847448356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 19:38:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6D0D20043;
	Tue, 19 May 2026 19:38:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7E7320040;
	Tue, 19 May 2026 19:38:07 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 19:38:07 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v5 4/6] selftest/bpf: Enable verifier selftest for powerpc64
Date: Tue, 19 May 2026 19:38:10 -0400
Message-ID: <20260519233812.18787-5-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519233812.18787-1-adubey@linux.ibm.com>
References: <20260519233812.18787-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0cbc26 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=DRl-xmwt84w-93Xc4WMA:9
X-Proofpoint-ORIG-GUID: K_Agw9Vj91cSoma71GlcH_wsRXA8pbGP
X-Proofpoint-GUID: K_Agw9Vj91cSoma71GlcH_wsRXA8pbGP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE5NiBTYWx0ZWRfX8a1DskaLjdhr
 VGGB8eSR65JmbEktInWdczCDHfWnnMsV+BR2/bnJg9vC/EXjPN+BM7QoOoSH2tomdk/w14BB3Z1
 1qGtITNxTPYODo2+VtP2uWYqGp7FYCvAtBGzd6aUX55BysC78lS2IXmhDY5XB+Q8OKqTtYJgtll
 ddNgzudMeprm7tBgOJ3A8LqF4f/pclf9Ie2W2FTJzlyAhi3x7ri7qHpdlq27T4Z7o//aRWVctv3
 NStHxw1Z5+VwFQk9PVQ4yuQyMV+nvDJL2wmUGrKb5BGjpwIB1cOKjXYuNyo8I4KIuXr+54igqVE
 SEDA7N7AYtspJeTqZYne216afXTn5UrBuvVoISam3UAMBE1x3lUAuBhuh0LHUyXUNBP39nj56L7
 3JI6qZI+hBS75byLIF5kTNvZCEiSTf1lVspbzB3wVUdaKgsr76WvPLs9VrDXUEnr4hXX0oLfeuj
 PslSP9csXymhhGKH2Aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190196
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
	TAGGED_FROM(0.00)[bounces-249682-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adubey@linux.ibm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D7B9A584455
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Abhishek Dubey <adubey@linux.ibm.com>

This patch enables arch specifier "__powerpc64" in verifier
selftest for ppc64. Power 32-bit would require separate
handling. Changes tested for 64-bit only.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 1 +
 tools/testing/selftests/bpf/test_loader.c    | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 9eeb5b0b63d6..cdc2a3de3054 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -158,6 +158,7 @@
 #define __arch_arm64		__arch("ARM64")
 #define __arch_riscv64		__arch("RISCV64")
 #define __arch_s390x		__arch("s390x")
+#define __arch_powerpc64	__arch("POWERPC64")
 #define __caps_unpriv(caps)	__test_tag("test_caps_unpriv=" EXPAND_QUOTE(caps))
 #define __load_if_JITed()	__test_tag("load_mode=jited")
 #define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index abdb9e6e3713..d5589355ed9e 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -377,6 +377,7 @@ enum arch {
 	ARCH_ARM64	= 0x4,
 	ARCH_RISCV64	= 0x8,
 	ARCH_S390X	= 0x10,
+	ARCH_POWERPC64	= 0x20,
 };
 
 static int get_current_arch(void)
@@ -389,6 +390,8 @@ static int get_current_arch(void)
 	return ARCH_RISCV64;
 #elif defined(__s390x__)
 	return ARCH_S390X;
+#elif defined(__powerpc64__)
+	return ARCH_POWERPC64;
 #endif
 	return ARCH_UNKNOWN;
 }
@@ -580,6 +583,8 @@ static int parse_test_spec(struct test_loader *tester,
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


