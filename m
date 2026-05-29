Return-Path: <stable+bounces-256428-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIKaOPG6GGrbmggAu9opvQ
	(envelope-from <stable+bounces-256428-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 00:00:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2B35FAB14
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 00:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47A68302E2C1
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EBF367B8C;
	Thu, 28 May 2026 21:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ftX5Kq8N"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF651367B6E;
	Thu, 28 May 2026 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005566; cv=none; b=dt44JR1gEGgAP08q16ymMB3qCR2X6u4I6moz20+PLa/Xx5H/qjJtlMWUBhpTnlBRPk8R7GZlC7rAelT2s2ymR5Azlr9QAn1U+UpWEa6p1Wlep/PURdC3ks4J5GiiEDWDKQpOUE+MO4686ZmYt2Zs56f+MNgQomZVTEYkaNW3exo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005566; c=relaxed/simple;
	bh=A4H35fie0VvB/GeCzZsmatNMifRW26auYfYXyZExmww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmQk6g45CiMFjhhrM9pvky6czKOMXlu6V3+PAVobCB+gpNC3ttXNxmVtmKsLsxL5y5BGyUDSqmBGFoNW36sJEBwH6aS18498ZNiX4+xKPIktQ1myqmSp5jVX7WiU+6bnhJuna7W1YYlXmSXETm5SW+oj9+KUCMmCckvxUbp88EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ftX5Kq8N; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLlhDN2418040;
	Thu, 28 May 2026 21:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TIct3NHUYaBH36Fj/
	LbbJuo0SwZOr7xZ34JrF6Ab3dM=; b=ftX5Kq8Nx5d78F8f4MrRuidt9LoTpg+Sq
	Y5l2hhK+o/NV9BQlqt1+kMppvFACSvWqOuRnER82qIHFlGHEUzOgvd1cNs/6PipV
	zIoQsHSrTD+rlAK9XvaTu/9c0KaTvub5seLvTEm2Fj+6sRbXhu1R/aOxI2EMvLTx
	nC7C+pOBxIjCqQ0WWwtn2inhwMBBK5E2Zfjenm3mLpiDGZ6CvFPNV2d1DLobh/Xh
	8mrp74GdZqNTqVwpnQmajWDatC9IshUJPSVnIgZT/TvmuZNRhSjFANuPKeUG6BR+
	pRJX4J41UC74Co/Yow9RxMBgHsO9dbbWcuXCzZdT8GjVR7gpqfWpQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884nepb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 21:59:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SLdDg6002725;
	Thu, 28 May 2026 21:59:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrba8js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 21:59:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SLx7R729950358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 21:59:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D91F20043;
	Thu, 28 May 2026 21:59:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3369520040;
	Thu, 28 May 2026 21:59:05 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 21:59:05 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v6 4/6] selftest/bpf: Enable verifier selftest for powerpc64
Date: Thu, 28 May 2026 21:58:53 -0400
Message-ID: <20260529015855.364704-5-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529015855.364704-1-adubey@linux.ibm.com>
References: <20260529015855.364704-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a18baaf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=DRl-xmwt84w-93Xc4WMA:9
X-Proofpoint-ORIG-GUID: Xrklcd6sZOJKxBD_6Xpnn3TBbJZMvsHo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDIxOCBTYWx0ZWRfXxHzoGvJV2wvz
 oxK/0O3K2NncimQOKciefBHy8H9n3Rhvqej3dsRM1x+p5g1jFIf5LUIGv/jDgxcqlWiGmHN7vjv
 wF4ZM0RIjoWRu0kxF7RgwABl2TGhQSSVxSuduqSJnInopj787Ixl0nN2iTzSEX5pfrmUuEBTibx
 aD1kQ2Yt3a3euTmkxooiHf9tKTjVp9rum2IgtxDWErv/zG34Jst8HKrH2yosAoqmP6mIO+w4VyR
 d8b0q+CHP/TBWaLfV89PDHz0HKkxrIKYvLtjNs7ZkXzPaNnuN27sasgPIFk4vhd49XOPICgAsNE
 7cfvTlfzZdnRxWHeiDjOV7v73L9hju0rpG8NL5hobsIyv09BYK3y/g71ArY2MJ66+Vr5VAokDMx
 ztfNocAC3C6OKKXsg5yYHics35Jm7D8lVIzA9MmKQsXtrdkrCYCENxybZVAOLPLyzgWLhUshhdB
 qY226U7Bt6BHYblszYg==
X-Proofpoint-GUID: Xrklcd6sZOJKxBD_6Xpnn3TBbJZMvsHo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280218
X-Spamd-Result: default: False [3.34 / 15.00];
	DATE_IN_FUTURE(4.00)[3];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256428-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adubey@linux.ibm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: EA2B35FAB14
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


