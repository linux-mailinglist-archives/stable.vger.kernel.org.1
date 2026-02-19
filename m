Return-Path: <stable+bounces-217421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Yr6jAnLilmlbqgIAu9opvQ
	(envelope-from <stable+bounces-217421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD7115DAA7
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C064130055CF
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C69531BCB7;
	Thu, 19 Feb 2026 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bigZG9uH"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D98E326927;
	Thu, 19 Feb 2026 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496045; cv=none; b=cU+K6bVCPLxlkvt/2ds8i+TrrALB+HdLEAwUiLpJr5Tor+EIy+oOHUnPR3ALBdp9xSK0RAWR6EgNgdA23ryKwn7c84FIy8SCyiHTM/3k+YpfWGkwcnnHk26YISUzSEyxCN0QfTqA8BSNhF3S4nsXMaMy7WGNwI0UYg45gnmId8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496045; c=relaxed/simple;
	bh=p6jhCGrX2cLu0aUiZX9hh8Ui7dIEQl7GjVE2M6uSxKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btHwntSSTKFNhTeGb+pZHOStJvwswHm7NtMEBh9ZfJVPfua3sQCcX9rLgdTfpaesXoDKWz+sq88vRCcF08i2TRJSoXX/lPRoLUg3TqQv9iutSLVJfcqCDyvbGchSOPISvpsTRvJWTBrWCxRXJo7pqiZtIOfeTI98RFVxD2CKu8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bigZG9uH; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J5EmT4390075;
	Thu, 19 Feb 2026 10:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=pfDtg
	dq39Nrhr1WRFz/7Tr0u+GFQ0oWxthmYJRPcFtY=; b=bigZG9uHFgAGQa6O9kETl
	ZR4oXjLjJKTYKuhxgA/UNWMrpFZ7TysasGRh2hAoifkX9m/rlOY+3l085qDxKPbF
	7g6DBZbPCwhoDYRzq6Of9AVxqXtGf9mly5TThg3R2ub5xSxn6kIVcGdnSmwOkqzd
	wsbfhd1swhCJK1L5vvEnfz5pVYQmTdw1WiRqPc/8TAPiHFYHSNzDV9VS5qNaGp6r
	9hgA0UglzcLLDGMvdMbRm66JzSDqRjkRFBhD171bTZuQ7RSiF/3g1qTkM82gdGBa
	sesMspRY/woy1Wt3k3yKDTrYksW/UgFZWNcTohxzmCdh2OPJnsmB7CxVce2tRbsR
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj4ay3hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61J8Dmvp033196;
	Thu, 19 Feb 2026 10:13:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb228usv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:54 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61JADUM6037324;
	Thu, 19 Feb 2026 10:13:53 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ccb228uem-12;
	Thu, 19 Feb 2026 10:13:53 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: kevin.brodsky@arm.com, linux-kselftest@vger.kernel.org,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joey Gouly <joey.gouly@arm.com>, Keith Lucas <keith.lucas@oracle.com>,
        Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 11/14] selftests/mm: ensure non-global pkey symbols are marked static
Date: Thu, 19 Feb 2026 02:13:15 -0800
Message-ID: <20260219101318.2442406-12-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-ORIG-GUID: aKBGkgPFl-bWF2vGNExTRQrkW1lQymW_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5NCBTYWx0ZWRfX74YkMGU3x0jD
 ceHpN7a+wHY+dbrK0trfQ2Ixfshl1pgbrucCH0KkSaxQ+sLIqp+9LGOVn1knwNr9TxtDK+WACKm
 fzKNCDcAXMH2kgg5Rbu1/+R64Q6RIrR7aspMs6S+XI2HNtKUg0KhVGsXgNwO7p2bzvL52H515da
 PwTAW0EEGR+OYSw+uDdDUcFuTBcVUNuXqgpRxixilZ+dE08BQKc6aXl6gPGnLICCdgOH6w/Fzpf
 v86VYwNv+40CERLC4NcFwpplm6lG347jyxBj0RLOxQp15SBzAzzTouH3N9yyxOQ/ewx6ndNUka1
 H1tJ37+bWb0Saze3PFh75isgx6xxrSuZDFQEkrAFhJ0FwMXUvvBbyEFbgHn928rK34r0+lD+Yck
 mQ2jPOg45kHK8s7faN9A8PePPPU8Z0ACTzB5ceQe9h5DVIXFpjOFNqV4DamVLPVRfsTPF6GufjR
 4HatDMG9zaJGMqGJjyQ==
X-Authority-Analysis: v=2.4 cv=SI9PlevH c=1 sm=1 tr=0 ts=6996e263 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8
 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8 a=Laxp7bmH531BIUOGem0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: aKBGkgPFl-bWF2vGNExTRQrkW1lQymW_
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217421-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux-foundation.org:email,oracle.com:mid,oracle.com:dkim,oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arm.com:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2DD7115DAA7
X-Rspamd-Action: no action

From: Kevin Brodsky <kevin.brodsky@arm.com>

[ Upstream commit b0cc298487d9fa61fb3198b2d1bd0839b3c4c95d ]

The pkey tests define a whole lot of functions and some global variables.
A few are truly global (declared in pkey-helpers.h), but the majority are
file-scoped.  Make sure those are labelled static.

Some of the pkey_{access,write}_{allow,deny} helpers are not called, or
only called when building for some architectures.  Mark them
__maybe_unused to suppress compiler warnings.

Link: https://lkml.kernel.org/r/20241209095019.1732120-11-kevin.brodsky@arm.com
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Keith Lucas <keith.lucas@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit b0cc298487d9fa61fb3198b2d1bd0839b3c4c95d)
[Harshit: backport to 6.12.y, clean cherry-pick]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 tools/testing/selftests/mm/pkey-helpers.h     |   3 +
 .../selftests/mm/pkey_sighandler_tests.c      |   6 +-
 tools/testing/selftests/mm/protection_keys.c  | 132 +++++++++---------
 3 files changed, 72 insertions(+), 69 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index 7604cc66ef0e..6f0ab7b42738 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -83,6 +83,9 @@ extern void abort_hooks(void);
 #ifndef noinline
 # define noinline __attribute__((noinline))
 #endif
+#ifndef __maybe_unused
+# define __maybe_unused __attribute__((__unused__))
+#endif
 
 int sys_pkey_alloc(unsigned long flags, unsigned long init_val);
 int sys_pkey_free(unsigned long pkey);
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index d4813af46ebb..3abc9777efa2 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -32,9 +32,9 @@
 
 #define STACK_SIZE PTHREAD_STACK_MIN
 
-pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
-pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
-siginfo_t siginfo = {0};
+static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
+static siginfo_t siginfo = {0};
 
 /*
  * We need to use inline assembly instead of glibc's syscall because glibc's
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index e01e854dcd87..2d42489888d2 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -61,7 +61,7 @@ noinline int read_ptr(int *ptr)
 	return *ptr;
 }
 
-void cat_into_file(char *str, char *file)
+static void cat_into_file(char *str, char *file)
 {
 	int fd = open(file, O_RDWR);
 	int ret;
@@ -88,7 +88,7 @@ void cat_into_file(char *str, char *file)
 
 #if CONTROL_TRACING > 0
 static int warned_tracing;
-int tracing_root_ok(void)
+static int tracing_root_ok(void)
 {
 	if (geteuid() != 0) {
 		if (!warned_tracing)
@@ -101,7 +101,7 @@ int tracing_root_ok(void)
 }
 #endif
 
-void tracing_on(void)
+static void tracing_on(void)
 {
 #if CONTROL_TRACING > 0
 #define TRACEDIR "/sys/kernel/tracing"
@@ -125,7 +125,7 @@ void tracing_on(void)
 #endif
 }
 
-void tracing_off(void)
+static void tracing_off(void)
 {
 #if CONTROL_TRACING > 0
 	if (!tracing_root_ok())
@@ -159,7 +159,7 @@ __attribute__((__aligned__(65536)))
 #else
 __attribute__((__aligned__(PAGE_SIZE)))
 #endif
-void lots_o_noops_around_write(int *write_to_me)
+static void lots_o_noops_around_write(int *write_to_me)
 {
 	dprintf3("running %s()\n", __func__);
 	__page_o_noops();
@@ -170,7 +170,7 @@ void lots_o_noops_around_write(int *write_to_me)
 	dprintf3("%s() done\n", __func__);
 }
 
-void dump_mem(void *dumpme, int len_bytes)
+static void dump_mem(void *dumpme, int len_bytes)
 {
 	char *c = (void *)dumpme;
 	int i;
@@ -213,7 +213,7 @@ static int hw_pkey_set(int pkey, unsigned long rights, unsigned long flags)
 	return 0;
 }
 
-void pkey_disable_set(int pkey, int flags)
+static void pkey_disable_set(int pkey, int flags)
 {
 	unsigned long syscall_flags = 0;
 	int ret;
@@ -251,7 +251,7 @@ void pkey_disable_set(int pkey, int flags)
 		pkey, flags);
 }
 
-void pkey_disable_clear(int pkey, int flags)
+static void pkey_disable_clear(int pkey, int flags)
 {
 	unsigned long syscall_flags = 0;
 	int ret;
@@ -277,19 +277,19 @@ void pkey_disable_clear(int pkey, int flags)
 			pkey, read_pkey_reg());
 }
 
-void pkey_write_allow(int pkey)
+__maybe_unused static void pkey_write_allow(int pkey)
 {
 	pkey_disable_clear(pkey, PKEY_DISABLE_WRITE);
 }
-void pkey_write_deny(int pkey)
+__maybe_unused static void pkey_write_deny(int pkey)
 {
 	pkey_disable_set(pkey, PKEY_DISABLE_WRITE);
 }
-void pkey_access_allow(int pkey)
+__maybe_unused static void pkey_access_allow(int pkey)
 {
 	pkey_disable_clear(pkey, PKEY_DISABLE_ACCESS);
 }
-void pkey_access_deny(int pkey)
+__maybe_unused static void pkey_access_deny(int pkey)
 {
 	pkey_disable_set(pkey, PKEY_DISABLE_ACCESS);
 }
@@ -307,9 +307,9 @@ static char *si_code_str(int si_code)
 	return "UNKNOWN";
 }
 
-int pkey_faults;
-int last_si_pkey = -1;
-void signal_handler(int signum, siginfo_t *si, void *vucontext)
+static int pkey_faults;
+static int last_si_pkey = -1;
+static void signal_handler(int signum, siginfo_t *si, void *vucontext)
 {
 	ucontext_t *uctxt = vucontext;
 	int trapno;
@@ -403,14 +403,14 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 	dprint_in_signal = 0;
 }
 
-void sig_chld(int x)
+static void sig_chld(int x)
 {
 	dprint_in_signal = 1;
 	dprintf2("[%d] SIGCHLD: %d\n", getpid(), x);
 	dprint_in_signal = 0;
 }
 
-void setup_sigsegv_handler(void)
+static void setup_sigsegv_handler(void)
 {
 	int r, rs;
 	struct sigaction newact;
@@ -436,13 +436,13 @@ void setup_sigsegv_handler(void)
 	pkey_assert(r == 0);
 }
 
-void setup_handlers(void)
+static void setup_handlers(void)
 {
 	signal(SIGCHLD, &sig_chld);
 	setup_sigsegv_handler();
 }
 
-pid_t fork_lazy_child(void)
+static pid_t fork_lazy_child(void)
 {
 	pid_t forkret;
 
@@ -488,7 +488,7 @@ int sys_pkey_alloc(unsigned long flags, unsigned long init_val)
 	return ret;
 }
 
-int alloc_pkey(void)
+static int alloc_pkey(void)
 {
 	int ret;
 	unsigned long init_val = 0x0;
@@ -546,7 +546,7 @@ int sys_pkey_free(unsigned long pkey)
  * not cleared.  This ensures we get lots of random bit sets
  * and clears on the vma and pte pkey bits.
  */
-int alloc_random_pkey(void)
+static int alloc_random_pkey(void)
 {
 	int max_nr_pkey_allocs;
 	int ret;
@@ -629,7 +629,7 @@ struct pkey_malloc_record {
 };
 struct pkey_malloc_record *pkey_malloc_records;
 struct pkey_malloc_record *pkey_last_malloc_record;
-long nr_pkey_malloc_records;
+static long nr_pkey_malloc_records;
 void record_pkey_malloc(void *ptr, long size, int prot)
 {
 	long i;
@@ -667,7 +667,7 @@ void record_pkey_malloc(void *ptr, long size, int prot)
 	nr_pkey_malloc_records++;
 }
 
-void free_pkey_malloc(void *ptr)
+static void free_pkey_malloc(void *ptr)
 {
 	long i;
 	int ret;
@@ -694,8 +694,7 @@ void free_pkey_malloc(void *ptr)
 	pkey_assert(false);
 }
 
-
-void *malloc_pkey_with_mprotect(long size, int prot, u16 pkey)
+static void *malloc_pkey_with_mprotect(long size, int prot, u16 pkey)
 {
 	void *ptr;
 	int ret;
@@ -715,7 +714,7 @@ void *malloc_pkey_with_mprotect(long size, int prot, u16 pkey)
 	return ptr;
 }
 
-void *malloc_pkey_anon_huge(long size, int prot, u16 pkey)
+static void *malloc_pkey_anon_huge(long size, int prot, u16 pkey)
 {
 	int ret;
 	void *ptr;
@@ -745,10 +744,10 @@ void *malloc_pkey_anon_huge(long size, int prot, u16 pkey)
 	return ptr;
 }
 
-int hugetlb_setup_ok;
+static int hugetlb_setup_ok;
 #define SYSFS_FMT_NR_HUGE_PAGES "/sys/kernel/mm/hugepages/hugepages-%ldkB/nr_hugepages"
 #define GET_NR_HUGE_PAGES 10
-void setup_hugetlbfs(void)
+static void setup_hugetlbfs(void)
 {
 	int err;
 	int fd;
@@ -796,7 +795,7 @@ void setup_hugetlbfs(void)
 	hugetlb_setup_ok = 1;
 }
 
-void *malloc_pkey_hugetlb(long size, int prot, u16 pkey)
+static void *malloc_pkey_hugetlb(long size, int prot, u16 pkey)
 {
 	void *ptr;
 	int flags = MAP_ANONYMOUS|MAP_PRIVATE|MAP_HUGETLB;
@@ -817,7 +816,7 @@ void *malloc_pkey_hugetlb(long size, int prot, u16 pkey)
 	return ptr;
 }
 
-void *(*pkey_malloc[])(long size, int prot, u16 pkey) = {
+static void *(*pkey_malloc[])(long size, int prot, u16 pkey) = {
 
 	malloc_pkey_with_mprotect,
 	malloc_pkey_with_mprotect_subpage,
@@ -825,7 +824,7 @@ void *(*pkey_malloc[])(long size, int prot, u16 pkey) = {
 	malloc_pkey_hugetlb
 };
 
-void *malloc_pkey(long size, int prot, u16 pkey)
+static void *malloc_pkey(long size, int prot, u16 pkey)
 {
 	void *ret;
 	static int malloc_type;
@@ -855,7 +854,7 @@ void *malloc_pkey(long size, int prot, u16 pkey)
 	return ret;
 }
 
-int last_pkey_faults;
+static int last_pkey_faults;
 #define UNKNOWN_PKEY -2
 void expected_pkey_fault(int pkey)
 {
@@ -897,9 +896,9 @@ void expected_pkey_fault(int pkey)
 	pkey_assert(last_pkey_faults == pkey_faults);		\
 } while (0)
 
-int test_fds[10] = { -1 };
-int nr_test_fds;
-void __save_test_fd(int fd)
+static int test_fds[10] = { -1 };
+static int nr_test_fds;
+static void __save_test_fd(int fd)
 {
 	pkey_assert(fd >= 0);
 	pkey_assert(nr_test_fds < ARRAY_SIZE(test_fds));
@@ -907,14 +906,14 @@ void __save_test_fd(int fd)
 	nr_test_fds++;
 }
 
-int get_test_read_fd(void)
+static int get_test_read_fd(void)
 {
 	int test_fd = open("/etc/passwd", O_RDONLY);
 	__save_test_fd(test_fd);
 	return test_fd;
 }
 
-void close_test_fds(void)
+static void close_test_fds(void)
 {
 	int i;
 
@@ -927,7 +926,7 @@ void close_test_fds(void)
 	nr_test_fds = 0;
 }
 
-void test_pkey_alloc_free_attach_pkey0(int *ptr, u16 pkey)
+static void test_pkey_alloc_free_attach_pkey0(int *ptr, u16 pkey)
 {
 	int i, err;
 	int max_nr_pkey_allocs;
@@ -979,7 +978,7 @@ void test_pkey_alloc_free_attach_pkey0(int *ptr, u16 pkey)
 	pkey_assert(!err);
 }
 
-void test_read_of_write_disabled_region(int *ptr, u16 pkey)
+static void test_read_of_write_disabled_region(int *ptr, u16 pkey)
 {
 	int ptr_contents;
 
@@ -989,7 +988,7 @@ void test_read_of_write_disabled_region(int *ptr, u16 pkey)
 	dprintf1("*ptr: %d\n", ptr_contents);
 	dprintf1("\n");
 }
-void test_read_of_access_disabled_region(int *ptr, u16 pkey)
+static void test_read_of_access_disabled_region(int *ptr, u16 pkey)
 {
 	int ptr_contents;
 
@@ -1001,7 +1000,7 @@ void test_read_of_access_disabled_region(int *ptr, u16 pkey)
 	expected_pkey_fault(pkey);
 }
 
-void test_read_of_access_disabled_region_with_page_already_mapped(int *ptr,
+static void test_read_of_access_disabled_region_with_page_already_mapped(int *ptr,
 		u16 pkey)
 {
 	int ptr_contents;
@@ -1018,7 +1017,7 @@ void test_read_of_access_disabled_region_with_page_already_mapped(int *ptr,
 	expected_pkey_fault(pkey);
 }
 
-void test_write_of_write_disabled_region_with_page_already_mapped(int *ptr,
+static void test_write_of_write_disabled_region_with_page_already_mapped(int *ptr,
 		u16 pkey)
 {
 	*ptr = __LINE__;
@@ -1029,14 +1028,14 @@ void test_write_of_write_disabled_region_with_page_already_mapped(int *ptr,
 	expected_pkey_fault(pkey);
 }
 
-void test_write_of_write_disabled_region(int *ptr, u16 pkey)
+static void test_write_of_write_disabled_region(int *ptr, u16 pkey)
 {
 	dprintf1("disabling write access to PKEY[%02d], doing write\n", pkey);
 	pkey_write_deny(pkey);
 	*ptr = __LINE__;
 	expected_pkey_fault(pkey);
 }
-void test_write_of_access_disabled_region(int *ptr, u16 pkey)
+static void test_write_of_access_disabled_region(int *ptr, u16 pkey)
 {
 	dprintf1("disabling access to PKEY[%02d], doing write\n", pkey);
 	pkey_access_deny(pkey);
@@ -1044,7 +1043,7 @@ void test_write_of_access_disabled_region(int *ptr, u16 pkey)
 	expected_pkey_fault(pkey);
 }
 
-void test_write_of_access_disabled_region_with_page_already_mapped(int *ptr,
+static void test_write_of_access_disabled_region_with_page_already_mapped(int *ptr,
 			u16 pkey)
 {
 	*ptr = __LINE__;
@@ -1055,7 +1054,7 @@ void test_write_of_access_disabled_region_with_page_already_mapped(int *ptr,
 	expected_pkey_fault(pkey);
 }
 
-void test_kernel_write_of_access_disabled_region(int *ptr, u16 pkey)
+static void test_kernel_write_of_access_disabled_region(int *ptr, u16 pkey)
 {
 	int ret;
 	int test_fd = get_test_read_fd();
@@ -1067,7 +1066,8 @@ void test_kernel_write_of_access_disabled_region(int *ptr, u16 pkey)
 	dprintf1("read ret: %d\n", ret);
 	pkey_assert(ret);
 }
-void test_kernel_write_of_write_disabled_region(int *ptr, u16 pkey)
+
+static void test_kernel_write_of_write_disabled_region(int *ptr, u16 pkey)
 {
 	int ret;
 	int test_fd = get_test_read_fd();
@@ -1080,7 +1080,7 @@ void test_kernel_write_of_write_disabled_region(int *ptr, u16 pkey)
 	pkey_assert(ret);
 }
 
-void test_kernel_gup_of_access_disabled_region(int *ptr, u16 pkey)
+static void test_kernel_gup_of_access_disabled_region(int *ptr, u16 pkey)
 {
 	int pipe_ret, vmsplice_ret;
 	struct iovec iov;
@@ -1102,7 +1102,7 @@ void test_kernel_gup_of_access_disabled_region(int *ptr, u16 pkey)
 	close(pipe_fds[1]);
 }
 
-void test_kernel_gup_write_to_write_disabled_region(int *ptr, u16 pkey)
+static void test_kernel_gup_write_to_write_disabled_region(int *ptr, u16 pkey)
 {
 	int ignored = 0xdada;
 	int futex_ret;
@@ -1120,7 +1120,7 @@ void test_kernel_gup_write_to_write_disabled_region(int *ptr, u16 pkey)
 }
 
 /* Assumes that all pkeys other than 'pkey' are unallocated */
-void test_pkey_syscalls_on_non_allocated_pkey(int *ptr, u16 pkey)
+static void test_pkey_syscalls_on_non_allocated_pkey(int *ptr, u16 pkey)
 {
 	int err;
 	int i;
@@ -1143,7 +1143,7 @@ void test_pkey_syscalls_on_non_allocated_pkey(int *ptr, u16 pkey)
 }
 
 /* Assumes that all pkeys other than 'pkey' are unallocated */
-void test_pkey_syscalls_bad_args(int *ptr, u16 pkey)
+static void test_pkey_syscalls_bad_args(int *ptr, u16 pkey)
 {
 	int err;
 	int bad_pkey = NR_PKEYS+99;
@@ -1153,7 +1153,7 @@ void test_pkey_syscalls_bad_args(int *ptr, u16 pkey)
 	pkey_assert(err);
 }
 
-void become_child(void)
+static void become_child(void)
 {
 	pid_t forkret;
 
@@ -1169,7 +1169,7 @@ void become_child(void)
 }
 
 /* Assumes that all pkeys other than 'pkey' are unallocated */
-void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
+static void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 {
 	int err;
 	int allocated_pkeys[NR_PKEYS] = {0};
@@ -1236,7 +1236,7 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 	}
 }
 
-void arch_force_pkey_reg_init(void)
+static void arch_force_pkey_reg_init(void)
 {
 #if defined(__i386__) || defined(__x86_64__) /* arch */
 	u64 *buf;
@@ -1275,7 +1275,7 @@ void arch_force_pkey_reg_init(void)
  * a long-running test that continually checks the pkey
  * register.
  */
-void test_pkey_init_state(int *ptr, u16 pkey)
+static void test_pkey_init_state(int *ptr, u16 pkey)
 {
 	int err;
 	int allocated_pkeys[NR_PKEYS] = {0};
@@ -1313,7 +1313,7 @@ void test_pkey_init_state(int *ptr, u16 pkey)
  * have to call pkey_alloc() to use it first.  Make sure that it
  * is usable.
  */
-void test_mprotect_with_pkey_0(int *ptr, u16 pkey)
+static void test_mprotect_with_pkey_0(int *ptr, u16 pkey)
 {
 	long size;
 	int prot;
@@ -1337,7 +1337,7 @@ void test_mprotect_with_pkey_0(int *ptr, u16 pkey)
 	mprotect_pkey(ptr, size, prot, pkey);
 }
 
-void test_ptrace_of_child(int *ptr, u16 pkey)
+static void test_ptrace_of_child(int *ptr, u16 pkey)
 {
 	__attribute__((__unused__)) int peek_result;
 	pid_t child_pid;
@@ -1413,7 +1413,7 @@ void test_ptrace_of_child(int *ptr, u16 pkey)
 	free(plain_ptr_unaligned);
 }
 
-void *get_pointer_to_instructions(void)
+static void *get_pointer_to_instructions(void)
 {
 	void *p1;
 
@@ -1434,7 +1434,7 @@ void *get_pointer_to_instructions(void)
 	return p1;
 }
 
-void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
+static void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
 {
 	void *p1;
 	int scratch;
@@ -1466,7 +1466,7 @@ void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
 	pkey_assert(!ret);
 }
 
-void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
+static void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
 {
 	void *p1;
 	int scratch;
@@ -1515,7 +1515,7 @@ void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
 }
 
 #if defined(__i386__) || defined(__x86_64__)
-void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
+static void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
 {
 	u32 new_pkru;
 	pid_t child;
@@ -1638,7 +1638,7 @@ void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
 #endif
 
 #if defined(__aarch64__)
-void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
+static void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
 {
 	pid_t child;
 	int status, ret;
@@ -1715,7 +1715,7 @@ void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
 }
 #endif
 
-void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
+static void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 {
 	int size = PAGE_SIZE;
 	int sret;
@@ -1729,7 +1729,7 @@ void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 	pkey_assert(sret < 0);
 }
 
-void (*pkey_tests[])(int *ptr, u16 pkey) = {
+static void (*pkey_tests[])(int *ptr, u16 pkey) = {
 	test_read_of_write_disabled_region,
 	test_read_of_access_disabled_region,
 	test_read_of_access_disabled_region_with_page_already_mapped,
@@ -1755,7 +1755,7 @@ void (*pkey_tests[])(int *ptr, u16 pkey) = {
 #endif
 };
 
-void run_tests_once(void)
+static void run_tests_once(void)
 {
 	int *ptr;
 	int prot = PROT_READ|PROT_WRITE;
@@ -1789,7 +1789,7 @@ void run_tests_once(void)
 	iteration_nr++;
 }
 
-void pkey_setup_shadow(void)
+static void pkey_setup_shadow(void)
 {
 	shadow_pkey_reg = __read_pkey_reg();
 }
-- 
2.47.3


