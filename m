Return-Path: <stable+bounces-217415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE/FKoTilmlbqgIAu9opvQ
	(envelope-from <stable+bounces-217415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF0015DAE1
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB8A9302AD13
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D0132693C;
	Thu, 19 Feb 2026 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FMBDNnNA"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A406311C37;
	Thu, 19 Feb 2026 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496028; cv=none; b=GUhu27w5Jnw4CEDpTwuskf3oZJTls3pMCjqCs3zWdgCpdljEWrVufK3gaUpgg9OvthClVB7um8tdc7Oc98vS8mvjlrN8/Ev0hxmTdlDavuVlv6QrFcAHG8bBBOxEOpVy8TwjFWtHDD038EIXV+/UV7jQvfsmbS7zfDyXftGkbmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496028; c=relaxed/simple;
	bh=/CTREIm8zelgHRGRUphY7BvA0EjwJAkCIZZn4fSgdIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFVRiw3K0+x8CuMeK6YRE7xdxEumlE6NfrwlgEg2cHG/OK8TUK+moCZs9mg6rqkCihZl2TygKlS+LWNjIveiCWFfXz2MW01i4ZZed0hBTP+WAXrMYurXdyUok/k+e53hgtnoThS6kxWD1ARza/FGtEuSVE4tdXeNwq9//4iPWEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FMBDNnNA; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J6vTM2495512;
	Thu, 19 Feb 2026 10:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=7M8oX
	CsOvaRK5aQWnSisCw29Qe92a+WbeDUGmaryLAA=; b=FMBDNnNAfI3Qq70O0++4L
	GWZKatsnR1zryIyAXhAM9qfy9btFIrvDcyJUIGSBYH0c2coRyM22LWk4bh337Wa7
	6wXirg3snTBATxkw6xMLOUcza3kUtvKWeqZe7f+y5o03GRM1YJqzTBI36Ts3pmxf
	X3O1rF5QU0qTSJD27dH7459d/xp2bPDVghoeEsQd4b8y2FzUzQ22192Z0auCz2iP
	+y2OaCOiIog68fccxo9/iytafQPklR00lktyJoCqxX7qNf/Wxpe9pzH81TwmiSd6
	Wj43rUZgJt05xA+lz2n3UapShAQVvMPXmr9np9HTWTij+UGBUFaEN8s4wqg4P3dm
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj6mf3q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61J9wHKm033224;
	Thu, 19 Feb 2026 10:13:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb228um0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:41 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61JADULs037324;
	Thu, 19 Feb 2026 10:13:40 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ccb228uem-6;
	Thu, 19 Feb 2026 10:13:40 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: kevin.brodsky@arm.com, linux-kselftest@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 05/14] selftests/mm: Use generic pkey register manipulation
Date: Thu, 19 Feb 2026 02:13:09 -0800
Message-ID: <20260219101318.2442406-6-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: 3TOGNJ7dAZLtCSa-YGrte7DrLRkeZL7S
X-Proofpoint-ORIG-GUID: 3TOGNJ7dAZLtCSa-YGrte7DrLRkeZL7S
X-Authority-Analysis: v=2.4 cv=JO82csKb c=1 sm=1 tr=0 ts=6996e256 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=QyXUC8HyAAAA:8
 a=yPCof4ZbAAAA:8 a=SOGHglbLdzkZnkCj1hYA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5NCBTYWx0ZWRfXyTMHJss6b7HV
 Ps9o0TvjXaHdeJLgZa7Ui3SjPbXQGUMW4qTF2LpAxouix9mldFy0Hdmzq7rJM+lO1MYkrWzpGKx
 6kbh/ugLk3f06H5mjmkaX0IkvGcDX1aNRfXt/9iCICoHp4nj9cecI6+O7h83XfQOPVKtn/e18JS
 r9lQhR9tR5eDTfKDEnTNMFJBf+GSOhv5o99l4cS4NbTknAuCS7X97mP0nMY6WbktQoCZFl74Yll
 k0FbEDDMR+oQ5SQ77UyoAtZnUycNR5/tDPyHSsyXefYsscZB1uDmW2IkXBmVyLcM1Y5GZ14UFIe
 pmTGxp9oqAlvuwD02HNuIJ8cMaxq4O4ieY1HEg8dk6ySYCNtYCQTM38P0b1qXx+5BYzXqNSiFXE
 UDwmmuutgKCky0aECBxT0gYcaaQa3Xebj5rPBVv0Cm8oGoOhtWi0CDEjQh32o9iDUalZp0pam/O
 09ibpri3W6KlqsXvIsg==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217415-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.com:email,intel.com:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4DF0015DAE1
X-Rspamd-Action: no action

From: Kevin Brodsky <kevin.brodsky@arm.com>

[ Upstream commit 6e182dc9f2680681ffb0b6d9757927f1bd321b38 ]

pkey_sighandler_tests.c currently hardcodes x86 PKRU encodings. The
first step towards running those tests on arm64 is to abstract away
the pkey register values.

Since those tests want to deny access to all keys except a few,
we have each arch define PKEY_REG_ALLOW_NONE, the pkey register value
denying access to all keys. We then use the existing set_pkey_bits()
helper to grant access to specific keys.

Because pkeys may also remove the execute permission on arm64, we
need to be a little careful: all code is mapped with pkey 0, and we
need it to remain executable. pkey_reg_restrictive_default() is
introduced for that purpose: the value it returns prevents RW access
to all pkeys, but retains X permission for pkey 0.

test_pkru_preserved_after_sigusr1() only checks that the pkey
register value remains unchanged after a signal is delivered, so the
particular value is irrelevant. We enable pkey 0 and a few more
arbitrary keys in the smallest range available on all architectures
(8 keys on arm64).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20241029144539.111155-5-kevin.brodsky@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
(cherry picked from commit 6e182dc9f2680681ffb0b6d9757927f1bd321b38)
[Harshit: backport to 6.12.y, clean cherrypick]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 tools/testing/selftests/mm/pkey-arm64.h       |  1 +
 tools/testing/selftests/mm/pkey-x86.h         |  2 +
 .../selftests/mm/pkey_sighandler_tests.c      | 53 +++++++++++++++----
 3 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey-arm64.h b/tools/testing/selftests/mm/pkey-arm64.h
index 580e1b0bb38e..d57fbeace38f 100644
--- a/tools/testing/selftests/mm/pkey-arm64.h
+++ b/tools/testing/selftests/mm/pkey-arm64.h
@@ -31,6 +31,7 @@
 #define NR_RESERVED_PKEYS	1 /* pkey-0 */
 
 #define PKEY_ALLOW_ALL		0x77777777
+#define PKEY_REG_ALLOW_NONE	0x0
 
 #define PKEY_BITS_PER_PKEY	4
 #define PAGE_SIZE		sysconf(_SC_PAGESIZE)
diff --git a/tools/testing/selftests/mm/pkey-x86.h b/tools/testing/selftests/mm/pkey-x86.h
index 5f28e26a2511..ac91777c8917 100644
--- a/tools/testing/selftests/mm/pkey-x86.h
+++ b/tools/testing/selftests/mm/pkey-x86.h
@@ -34,6 +34,8 @@
 #define PAGE_SIZE		4096
 #define MB			(1<<20)
 
+#define PKEY_REG_ALLOW_NONE	0x55555555
+
 static inline void __page_o_noops(void)
 {
 	/* 8-bytes of instruction * 512 bytes = 1 page */
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index a8088b645ad6..501880dbdc37 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -11,6 +11,7 @@
  */
 #define _GNU_SOURCE
 #define __SANE_USERSPACE_TYPES__
+#include <linux/mman.h>
 #include <errno.h>
 #include <sys/syscall.h>
 #include <string.h>
@@ -65,6 +66,20 @@ long syscall_raw(long n, long a1, long a2, long a3, long a4, long a5, long a6)
 	return ret;
 }
 
+/*
+ * Returns the most restrictive pkey register value that can be used by the
+ * tests.
+ */
+static inline u64 pkey_reg_restrictive_default(void)
+{
+	/*
+	 * Disallow everything except execution on pkey 0, so that each caller
+	 * doesn't need to enable it explicitly (the selftest code runs with
+	 * its code mapped with pkey 0).
+	 */
+	return set_pkey_bits(PKEY_REG_ALLOW_NONE, 0, PKEY_DISABLE_ACCESS);
+}
+
 static void sigsegv_handler(int signo, siginfo_t *info, void *ucontext)
 {
 	pthread_mutex_lock(&mutex);
@@ -113,7 +128,7 @@ static void raise_sigusr2(void)
 static void *thread_segv_with_pkey0_disabled(void *ptr)
 {
 	/* Disable MPK 0 (and all others too) */
-	__write_pkey_reg(0x55555555);
+	__write_pkey_reg(pkey_reg_restrictive_default());
 
 	/* Segfault (with SEGV_MAPERR) */
 	*(int *) (0x1) = 1;
@@ -123,7 +138,7 @@ static void *thread_segv_with_pkey0_disabled(void *ptr)
 static void *thread_segv_pkuerr_stack(void *ptr)
 {
 	/* Disable MPK 0 (and all others too) */
-	__write_pkey_reg(0x55555555);
+	__write_pkey_reg(pkey_reg_restrictive_default());
 
 	/* After we disable MPK 0, we can't access the stack to return */
 	return NULL;
@@ -133,6 +148,7 @@ static void *thread_segv_maperr_ptr(void *ptr)
 {
 	stack_t *stack = ptr;
 	int *bad = (int *)1;
+	u64 pkey_reg;
 
 	/*
 	 * Setup alternate signal stack, which should be pkey_mprotect()ed by
@@ -142,7 +158,9 @@ static void *thread_segv_maperr_ptr(void *ptr)
 	syscall_raw(SYS_sigaltstack, (long)stack, 0, 0, 0, 0, 0);
 
 	/* Disable MPK 0.  Only MPK 1 is enabled. */
-	__write_pkey_reg(0x55555551);
+	pkey_reg = pkey_reg_restrictive_default();
+	pkey_reg = set_pkey_bits(pkey_reg, 1, PKEY_UNRESTRICTED);
+	__write_pkey_reg(pkey_reg);
 
 	/* Segfault */
 	*bad = 1;
@@ -240,6 +258,7 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
 	int pkey;
 	int parent_pid = 0;
 	int child_pid = 0;
+	u64 pkey_reg;
 
 	sa.sa_flags = SA_SIGINFO | SA_ONSTACK;
 
@@ -257,7 +276,10 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
 	assert(stack != MAP_FAILED);
 
 	/* Allow access to MPK 0 and MPK 1 */
-	__write_pkey_reg(0x55555550);
+	pkey_reg = pkey_reg_restrictive_default();
+	pkey_reg = set_pkey_bits(pkey_reg, 0, PKEY_UNRESTRICTED);
+	pkey_reg = set_pkey_bits(pkey_reg, 1, PKEY_UNRESTRICTED);
+	__write_pkey_reg(pkey_reg);
 
 	/* Protect the new stack with MPK 1 */
 	pkey = pkey_alloc(0, 0);
@@ -307,7 +329,13 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
 static void test_pkru_preserved_after_sigusr1(void)
 {
 	struct sigaction sa;
-	unsigned long pkru = 0x45454544;
+	u64 pkey_reg;
+
+	/* Allow access to MPK 0 and an arbitrary set of keys */
+	pkey_reg = pkey_reg_restrictive_default();
+	pkey_reg = set_pkey_bits(pkey_reg, 0, PKEY_UNRESTRICTED);
+	pkey_reg = set_pkey_bits(pkey_reg, 3, PKEY_UNRESTRICTED);
+	pkey_reg = set_pkey_bits(pkey_reg, 7, PKEY_UNRESTRICTED);
 
 	sa.sa_flags = SA_SIGINFO;
 
@@ -320,7 +348,7 @@ static void test_pkru_preserved_after_sigusr1(void)
 
 	memset(&siginfo, 0, sizeof(siginfo));
 
-	__write_pkey_reg(pkru);
+	__write_pkey_reg(pkey_reg);
 
 	raise(SIGUSR1);
 
@@ -330,7 +358,7 @@ static void test_pkru_preserved_after_sigusr1(void)
 	pthread_mutex_unlock(&mutex);
 
 	/* Ensure the pkru value is the same after returning from signal. */
-	ksft_test_result(pkru == __read_pkey_reg() &&
+	ksft_test_result(pkey_reg == __read_pkey_reg() &&
 			 siginfo.si_signo == SIGUSR1,
 			 "%s\n", __func__);
 }
@@ -347,6 +375,7 @@ static noinline void *thread_sigusr2_self(void *ptr)
 		'S', 'I', 'G', 'U', 'S', 'R', '2',
 		'.', '.', '.', '\n', '\0'};
 	stack_t *stack = ptr;
+	u64 pkey_reg;
 
 	/*
 	 * Setup alternate signal stack, which should be pkey_mprotect()ed by
@@ -356,7 +385,9 @@ static noinline void *thread_sigusr2_self(void *ptr)
 	syscall(SYS_sigaltstack, (long)stack, 0, 0, 0, 0, 0);
 
 	/* Disable MPK 0.  Only MPK 2 is enabled. */
-	__write_pkey_reg(0x55555545);
+	pkey_reg = pkey_reg_restrictive_default();
+	pkey_reg = set_pkey_bits(pkey_reg, 2, PKEY_UNRESTRICTED);
+	__write_pkey_reg(pkey_reg);
 
 	raise_sigusr2();
 
@@ -384,6 +415,7 @@ static void test_pkru_sigreturn(void)
 	int pkey;
 	int parent_pid = 0;
 	int child_pid = 0;
+	u64 pkey_reg;
 
 	sa.sa_handler = SIG_DFL;
 	sa.sa_flags = 0;
@@ -418,7 +450,10 @@ static void test_pkru_sigreturn(void)
 	 * the current thread's stack is protected by the default MPK 0. Hence
 	 * both need to be enabled.
 	 */
-	__write_pkey_reg(0x55555544);
+	pkey_reg = pkey_reg_restrictive_default();
+	pkey_reg = set_pkey_bits(pkey_reg, 0, PKEY_UNRESTRICTED);
+	pkey_reg = set_pkey_bits(pkey_reg, 2, PKEY_UNRESTRICTED);
+	__write_pkey_reg(pkey_reg);
 
 	/* Protect the stack with MPK 2 */
 	pkey = pkey_alloc(0, 0);
-- 
2.47.3


