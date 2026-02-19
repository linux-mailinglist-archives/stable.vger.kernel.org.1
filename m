Return-Path: <stable+bounces-217416-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC1bGmPilmnkqQIAu9opvQ
	(envelope-from <stable+bounces-217416-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:13:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0877C15DA73
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56E48300C009
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26736327C05;
	Thu, 19 Feb 2026 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EJyYdq/S"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7AC6A8D2;
	Thu, 19 Feb 2026 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496032; cv=none; b=Xv+bLYS5eNklZZcwemYUtjdtgSo+S74laiiWlRg2e9uo8jv2Ma6iU6+5Ryd9a/zqOCe915eQrQnnNCiSnZL5INNmFliM/ggjJv3j8f2vIzoUeDs7lv/+5R366rWa8NgO2NIgRvIp0JdJb39rgrTHpMo5ydzGtzljzeLw284FiBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496032; c=relaxed/simple;
	bh=nZvcXElQhVlqemAfFqvW/kj8sce5MbDojuy8jIFUuY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JATjPH2r2J4Pbwzt5pAHxratVob6DBpsWpWseEmYe6nfA5CHdVrKFaFN4/UCGDHnBYB7th9SoQUJON6aB5kQnhEQrNDJUmW7XZRjdUQHPb26smqMbwgs4egVD5dXUeNJwi+Kv0YLVCYovohjdBL4jfZWlTgETCXgExeknAzeVag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EJyYdq/S; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J2jvmj3863420;
	Thu, 19 Feb 2026 10:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=jnqzi
	5J/sz4EjlXuz6FppAXGfl+Dm8mdH4bI9vemSfk=; b=EJyYdq/S9n97HeiMCkI4I
	LYRhoPP9zC3LhiSv/h0QmatbUy+pqO3UcCsCfyCaSiyfrfTThmt+jBVbUCOeArED
	BYjnNWcXq91MtQ0GlgnsPDZh57uYrxng6c6S9/+2PR4PSwW1TYn/RQc02OuS8yNZ
	Y9zFcuqwrFRTThiqsInf5gEgHRMyK/lDeTcNSFHfuN0/ZNaflzVbraMRencHfU01
	5K3VjrUMZ0jgY64QaDqYRKgtQTWPTI8zGvOFPssP5YS4Fujo9D6uNVENRXhRkzsV
	jaCV2SOhn2ZFaRJ0zvYd1tCh2S3K/2NLaSyR/Z+k6xTmmPXz0bkCp6TZiFkE1ym2
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0rf4xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61JADPHk033458;
	Thu, 19 Feb 2026 10:13:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb228un7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:43 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61JADULu037324;
	Thu, 19 Feb 2026 10:13:42 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ccb228uem-7;
	Thu, 19 Feb 2026 10:13:42 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: kevin.brodsky@arm.com, linux-kselftest@vger.kernel.org,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joey Gouly <joey.gouly@arm.com>, Keith Lucas <keith.lucas@oracle.com>,
        Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 06/14] selftests/mm: fix -Warray-bounds warnings in pkey_sighandler_tests
Date: Thu, 19 Feb 2026 02:13:10 -0800
Message-ID: <20260219101318.2442406-7-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260219101318.2442406-1-harshit.m.mogalapalli@oracle.com>
References: <20260219101318.2442406-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602190094
X-Authority-Analysis: v=2.4 cv=V6RwEOni c=1 sm=1 tr=0 ts=6996e258 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8
 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8 a=9IaFFv3mtrRlyJKcAuEA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-ORIG-GUID: 5iQgs_VxuQdyDYzW1EXsO1vhRF1mpiwA
X-Proofpoint-GUID: 5iQgs_VxuQdyDYzW1EXsO1vhRF1mpiwA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5NCBTYWx0ZWRfXxAXWlChY0sPL
 atXR3sX4mprkNbbemGg5Y150ZN5f1Pz6C3jmG5SW3RtIEa8GmIZhZQf7O31ZPWMIjg2xmmJalTU
 Gyv/5JD6OW/SeLV1UE51vrZSSIC+Mndqaae/u5GfJ3IvCMmuVrVhg700z/9uk+fEbbqWFmThiBj
 jFtOxj7+qpa2xQw5IQk/sQCfVSfzOO1H2ZsJAQX2BIz4HDRoEVVvndXE4U+fsiGSPQ7HCWlj2ea
 /ZJn36CH3UYcJyhvvUsH/gf8lcyBxaI8M5/kDIrH5VPHAHZYb8bjfs3Z4PMi42nrlDUPceq2iFm
 tMU/lzCxSoXxRvvz9OCVRsTtf5Hrjib8YdlEBLib5b7ibCiqh9peA9i4tqWbU03BgllJIVuMQYL
 J/bYwdkuzsNNeRtbtxyRTHZBusXEWGZp46NW8gqlN2NyBJia05tbWKxwFtMwdcE0QX97EFs9s2w
 p1TEBsl+aPztPOiWomg==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217416-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.com:email,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0877C15DA73
X-Rspamd-Action: no action

From: Kevin Brodsky <kevin.brodsky@arm.com>

[ Upstream commit 71384f84cbbe7660023b01c1a0fa9cc7dbc487a7 ]

GCC doesn't like dereferencing a pointer set to 0x1 (when building
at -O2):

pkey_sighandler_tests.c:166:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds=]
  166 |         *(int *) (0x1) = 1;
      |         ^~~~~~~~~~~~~~
cc1: note: source object is likely at address zero

Using NULL instead seems to make it happy.  This should make no difference
in practice (SIGSEGV with SEGV_MAPERR will be the outcome regardless), we
just need to update the expected si_addr.

[kevin.brodsky@arm.com: fix clang dereferencing-null issue]
  Link: https://lkml.kernel.org/r/20241218153615.2267571-1-kevin.brodsky@arm.com
Link: https://lkml.kernel.org/r/20241209095019.1732120-5-kevin.brodsky@arm.com
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Keith Lucas <keith.lucas@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: kernel test robot <lkp@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 71384f84cbbe7660023b01c1a0fa9cc7dbc487a7)
[Harshit: backport to 6.12.y, clean cherry-pick]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 tools/testing/selftests/mm/pkey_sighandler_tests.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index 501880dbdc37..e754cd2fdcfa 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -131,7 +131,7 @@ static void *thread_segv_with_pkey0_disabled(void *ptr)
 	__write_pkey_reg(pkey_reg_restrictive_default());
 
 	/* Segfault (with SEGV_MAPERR) */
-	*(int *) (0x1) = 1;
+	*(volatile int *)NULL = 1;
 	return NULL;
 }
 
@@ -147,7 +147,6 @@ static void *thread_segv_pkuerr_stack(void *ptr)
 static void *thread_segv_maperr_ptr(void *ptr)
 {
 	stack_t *stack = ptr;
-	int *bad = (int *)1;
 	u64 pkey_reg;
 
 	/*
@@ -163,7 +162,7 @@ static void *thread_segv_maperr_ptr(void *ptr)
 	__write_pkey_reg(pkey_reg);
 
 	/* Segfault */
-	*bad = 1;
+	*(volatile int *)NULL = 1;
 	syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
 	return NULL;
 }
@@ -202,7 +201,7 @@ static void test_sigsegv_handler_with_pkey0_disabled(void)
 
 	ksft_test_result(siginfo.si_signo == SIGSEGV &&
 			 siginfo.si_code == SEGV_MAPERR &&
-			 siginfo.si_addr == (void *)1,
+			 siginfo.si_addr == NULL,
 			 "%s\n", __func__);
 }
 
@@ -318,7 +317,7 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
 
 	ksft_test_result(siginfo.si_signo == SIGSEGV &&
 			 siginfo.si_code == SEGV_MAPERR &&
-			 siginfo.si_addr == (void *)1,
+			 siginfo.si_addr == NULL,
 			 "%s\n", __func__);
 }
 
-- 
2.47.3


