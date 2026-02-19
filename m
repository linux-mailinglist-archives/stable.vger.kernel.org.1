Return-Path: <stable+bounces-217422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LrjLKPilmnkqQIAu9opvQ
	(envelope-from <stable+bounces-217422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5023B15DB1C
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95830303D32E
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E7632AAA2;
	Thu, 19 Feb 2026 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p47+L58Q"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC36A8D2;
	Thu, 19 Feb 2026 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496045; cv=none; b=AsaEwtUyhguglc87GpwwhgSaDFNCRn7aghYOl06lQZvVPNJNi2rhA+cdeoq2tQzC2w0ikVJQova02Qk80y+9AuhmiBYu2Nvhx4bGDePFZsnrJSA7fqPsNIKiM6OXgvYLW7ZO7myAURAdNQcqklKwAhmBBCU6RclRvINjqf41dbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496045; c=relaxed/simple;
	bh=A/JMDfVwHXJaOEq01wcpNmP3ZTXLmJ1JJX/UcCOOugo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTeI35z9XvhROQBtme4REYGigo3dHCrqJ11gSUXcKDhIm9wGJ4SN+6SXkx/rSP7GfaZrEAg+BBMl4+gyXqzNSS4VSWD5MBtflFV5envtrrFdVvduY2D6h4i73xuhRfbiEmajSDpI7M+n5qnn16V+nt8vWWTJay7tXOTi2plCaGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p47+L58Q; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J58jFg1535448;
	Thu, 19 Feb 2026 10:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=lGH/0
	oy5aA3AeMnnsTW/WTtPTl0+Khp47OfXWqx3CeE=; b=p47+L58QtHuTCMtC+yAcG
	BF6uF6D3j4Vk7qhyuPB0vyHDAbtCLx2PQOyVvuT7bSqjKUkdpnWMMHBaanTyfMjg
	jy35MA4qxisDJEZX6jSXgFpxZY8Kp3NKgBMblcp3DzSZgE/CwHK04ynp9zDVGJwu
	CDbNQlyBN+NSStxsjpyW53eUnBC4/7foHDZTu1SexZ3AlvkxupH7OkeEqyE0LUfW
	nk/m3LDGpnIOYOsCsd6G8dTQZhLP/IkvA+gg8oXSx8SYrg3wX+CQ285rwVJ1RNM2
	9Y3y7ioHtClwLNeSrFJ5syFqD5m0NzHYRorFPLkvSOQ8HahpUe31DRKqV0LaRpnX
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj3t76ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61J9d0kV033190;
	Thu, 19 Feb 2026 10:13:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb228utk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:56 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61JADUM8037324;
	Thu, 19 Feb 2026 10:13:56 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ccb228uem-13;
	Thu, 19 Feb 2026 10:13:55 +0000
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
Subject: [PATCH 6.12.y 12/14] selftests/mm: use sys_pkey helpers consistently
Date: Thu, 19 Feb 2026 02:13:16 -0800
Message-ID: <20260219101318.2442406-13-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5NCBTYWx0ZWRfX7kjkuFbaqP5O
 MEoRiAyM4ZU6N738CC83ptvhMRoYYI4QHFiuI6YSflwVT2fcjf32V2S0V8cs6WhKFOi0Wli6zcA
 YirzpD77sSXjW2HjCfTn+hBtrHKtyN+LibyvqEhLLYLDksoQOV/Z3MKLeCK4SKuWee053QL3CMn
 /5W4SF0CIgzDEgXvblmcpSp01Ya/ibQxDowXs3Svu+FvYiNqIxwA3ib93+NwTUazXF1au4DCAUz
 eYz9Of/+zE762bdX0wKzjFy6XXGqefgxX5ILO9owC/fjsYHkLfAql8nCwkN8CxqcI6xdEOYhYqn
 yH1W1y+ICdmQhGLHC4A2Ijc4NSEqexkDsQyteQLL6EuZ7VhrcWjCZ2Ux6yBcAxjfT2yJy/uFpI1
 GXl7OdXKaPQbRTvE86v5A76n+9fYlSofYGCqPxWfTFFJnOSMNmllwPWD4Zt0k5Bj/RXm4Yv7cG4
 1+yLgMZfyYiOoJWVE0w==
X-Proofpoint-ORIG-GUID: RfjgeudVJKNxHTr9I_9HbRrw9CI6E1iT
X-Authority-Analysis: v=2.4 cv=b/S/I9Gx c=1 sm=1 tr=0 ts=6996e265 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8
 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8 a=8klsPLqMBwNQdvZafDUA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: RfjgeudVJKNxHTr9I_9HbRrw9CI6E1iT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217422-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.com:email,linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,arm.com:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5023B15DB1C
X-Rspamd-Action: no action

From: Kevin Brodsky <kevin.brodsky@arm.com>

[ Upstream commit 50910acd6f61573ac23d468f221fa06178f2bd29 ]

sys_pkey_alloc, sys_pkey_free and sys_mprotect_pkey are currently used in
protections_keys.c, while pkey_sighandler_tests.c calls the libc wrappers
directly (e.g.  pkey_mprotect()).  This is probably ok when using glibc
(those symbols appeared a while ago), but Musl does not currently provide
them.  The logging in the helpers from pkey-helpers.h can also come in
handy.

Make things more consistent by using the sys_pkey helpers in
pkey_sighandler_tests.c too.  To that end their implementation is moved to
a common .c file (pkey_util.c).  This also enables calling
is_pkeys_supported() outside of protections_keys.c, since it relies on
sys_pkey_{alloc,free}.

[kevin.brodsky@arm.com: fix dependency on pkey_util.c]
  Link: https://lkml.kernel.org/r/20241216092849.2140850-1-kevin.brodsky@arm.com
Link: https://lkml.kernel.org/r/20241209095019.1732120-12-kevin.brodsky@arm.com
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Keith Lucas <keith.lucas@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 50910acd6f61573ac23d468f221fa06178f2bd29)
[Harshit: Backport to 6.12.y, clean cherry-pick]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 tools/testing/selftests/mm/Makefile           |  4 ++
 tools/testing/selftests/mm/pkey-helpers.h     |  2 +
 .../selftests/mm/pkey_sighandler_tests.c      |  8 ++--
 tools/testing/selftests/mm/pkey_util.c        | 40 +++++++++++++++++++
 tools/testing/selftests/mm/protection_keys.c  | 35 ----------------
 5 files changed, 50 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/mm/pkey_util.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index c0138cb19705..b4315971d031 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -144,11 +144,15 @@ $(TEST_GEN_FILES): vm_util.c thp_settings.c
 
 $(OUTPUT)/uffd-stress: uffd-common.c
 $(OUTPUT)/uffd-unit-tests: uffd-common.c
+$(OUTPUT)/protection_keys: pkey_util.c
+$(OUTPUT)/pkey_sighandler_tests: pkey_util.c
 
 ifeq ($(ARCH),x86_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
 BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
 
+$(BINARIES_32) $(BINARIES_64): pkey_util.c
+
 define gen-target-rule-32
 $(1) $(1)_32: $(OUTPUT)/$(1)_32
 .PHONY: $(1) $(1)_32
diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index 6f0ab7b42738..f080e97b39be 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -89,6 +89,8 @@ extern void abort_hooks(void);
 
 int sys_pkey_alloc(unsigned long flags, unsigned long init_val);
 int sys_pkey_free(unsigned long pkey);
+int sys_mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
+		unsigned long pkey);
 
 /* For functions called from protection_keys.c only */
 noinline int read_ptr(int *ptr);
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index 3abc9777efa2..6d1a521d6936 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -279,8 +279,8 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
 	__write_pkey_reg(pkey_reg);
 
 	/* Protect the new stack with MPK 1 */
-	pkey = pkey_alloc(0, 0);
-	pkey_mprotect(stack, STACK_SIZE, PROT_READ | PROT_WRITE, pkey);
+	pkey = sys_pkey_alloc(0, 0);
+	sys_mprotect_pkey(stack, STACK_SIZE, PROT_READ | PROT_WRITE, pkey);
 
 	/* Set up alternate signal stack that will use the default MPK */
 	sigstack.ss_sp = mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
@@ -453,8 +453,8 @@ static void test_pkru_sigreturn(void)
 	__write_pkey_reg(pkey_reg);
 
 	/* Protect the stack with MPK 2 */
-	pkey = pkey_alloc(0, 0);
-	pkey_mprotect(stack, STACK_SIZE, PROT_READ | PROT_WRITE, pkey);
+	pkey = sys_pkey_alloc(0, 0);
+	sys_mprotect_pkey(stack, STACK_SIZE, PROT_READ | PROT_WRITE, pkey);
 
 	/* Set up alternate signal stack that will use the default MPK */
 	sigstack.ss_sp = mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
diff --git a/tools/testing/selftests/mm/pkey_util.c b/tools/testing/selftests/mm/pkey_util.c
new file mode 100644
index 000000000000..ca4ad0d44ab2
--- /dev/null
+++ b/tools/testing/selftests/mm/pkey_util.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "pkey-helpers.h"
+
+int sys_pkey_alloc(unsigned long flags, unsigned long init_val)
+{
+	int ret = syscall(SYS_pkey_alloc, flags, init_val);
+	dprintf1("%s(flags=%lx, init_val=%lx) syscall ret: %d errno: %d\n",
+			__func__, flags, init_val, ret, errno);
+	return ret;
+}
+
+int sys_pkey_free(unsigned long pkey)
+{
+	int ret = syscall(SYS_pkey_free, pkey);
+	dprintf1("%s(pkey=%ld) syscall ret: %d\n", __func__, pkey, ret);
+	return ret;
+}
+
+int sys_mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
+		unsigned long pkey)
+{
+	int sret;
+
+	dprintf2("%s(0x%p, %zx, prot=%lx, pkey=%lx)\n", __func__,
+			ptr, size, orig_prot, pkey);
+
+	errno = 0;
+	sret = syscall(__NR_pkey_mprotect, ptr, size, orig_prot, pkey);
+	if (errno) {
+		dprintf2("SYS_mprotect_key sret: %d\n", sret);
+		dprintf2("SYS_mprotect_key prot: 0x%lx\n", orig_prot);
+		dprintf2("SYS_mprotect_key failed, errno: %d\n", errno);
+		if (DEBUG_LEVEL >= 2)
+			perror("SYS_mprotect_pkey");
+	}
+	return sret;
+}
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 2d42489888d2..bb26a07fe206 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -460,34 +460,6 @@ static pid_t fork_lazy_child(void)
 	return forkret;
 }
 
-int sys_mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
-		unsigned long pkey)
-{
-	int sret;
-
-	dprintf2("%s(0x%p, %zx, prot=%lx, pkey=%lx)\n", __func__,
-			ptr, size, orig_prot, pkey);
-
-	errno = 0;
-	sret = syscall(__NR_pkey_mprotect, ptr, size, orig_prot, pkey);
-	if (errno) {
-		dprintf2("SYS_mprotect_key sret: %d\n", sret);
-		dprintf2("SYS_mprotect_key prot: 0x%lx\n", orig_prot);
-		dprintf2("SYS_mprotect_key failed, errno: %d\n", errno);
-		if (DEBUG_LEVEL >= 2)
-			perror("SYS_mprotect_pkey");
-	}
-	return sret;
-}
-
-int sys_pkey_alloc(unsigned long flags, unsigned long init_val)
-{
-	int ret = syscall(SYS_pkey_alloc, flags, init_val);
-	dprintf1("%s(flags=%lx, init_val=%lx) syscall ret: %d errno: %d\n",
-			__func__, flags, init_val, ret, errno);
-	return ret;
-}
-
 static int alloc_pkey(void)
 {
 	int ret;
@@ -534,13 +506,6 @@ static int alloc_pkey(void)
 	return ret;
 }
 
-int sys_pkey_free(unsigned long pkey)
-{
-	int ret = syscall(SYS_pkey_free, pkey);
-	dprintf1("%s(pkey=%ld) syscall ret: %d\n", __func__, pkey, ret);
-	return ret;
-}
-
 /*
  * I had a bug where pkey bits could be set by mprotect() but
  * not cleared.  This ensures we get lots of random bit sets
-- 
2.47.3


