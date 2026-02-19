Return-Path: <stable+bounces-217420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K4WNZnilmnkqQIAu9opvQ
	(envelope-from <stable+bounces-217420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0D715DB0E
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E74F7304A175
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD0E328B4B;
	Thu, 19 Feb 2026 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KTS1Kwmu"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBE0311C37;
	Thu, 19 Feb 2026 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496040; cv=none; b=ntx92sEgHjAFT+1LDaDOdv2UijjtZjXtrrDiri+JoPKFQxs33TFi5ee0gPrteXA4WHBON/rGBzW/pmQgNbvJ4HKPkxhPAdCfyY8M5iECq0SUSK5UNSiBs1bH9V4KkArg1fDKpQZcFObwJuBl7Iwe9yo/t0FoVYKPYp0X4CGIqE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496040; c=relaxed/simple;
	bh=2wdgnU3Cjt1GyyMeQ2gO9CDuJj5I6QHgcDNtAjcjxvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzyPXO4QxpImNdhnovXeGJMmBkoHmlmRIxEXMA7ycqzGWZHfuBsZRuPlDLK5TAteZw8tNu3eAR7G7/uJ/CMx2VO4Li84bDnp4cuG8wsuQ4Ap3ycZo/EDEpqhCTT/I41ZDTw6ghHahDYx7kBckLX3lLLbSU/LJ6wNNt9W3G2agJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KTS1Kwmu; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J7Skeg026220;
	Thu, 19 Feb 2026 10:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Rc2cZ
	kRCpFEfQn28akz68JDMVWM9m9zEHheo67dWelQ=; b=KTS1KwmuoCcBA7uHu0/YC
	3UkZW8xDkR9NNqpLSslU3OT0ESyvDVsU/zkrdXl7+Kjn9WP71y/hWDHJHuoGeniQ
	LAOzqvIs7G2B/JabTGpvl59788Mkj1VB8KM4fqiqVklYmM4T2dYlS9dy/ydXc8OX
	nSgtUNPvmLyvJrS1Umz9tNJ4KhSu6C0NS3Vep27P0n+LmPghDxbNrhBXc3GLZP/9
	4UkzqLkZXzr9W9vFlm0bX7xtBs9W52mMfaDKJLA4LuzsD+5e9OjyHGQ0vp7B3j7v
	YHDcxdtQQYCiMV8ds3Q82gVHUVMuBfLIHZj6T9wAMtUyNjhso5bGhpMnd0MQbKhe
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0rf4xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61JA2JCE033174;
	Thu, 19 Feb 2026 10:13:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb228uq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:49 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61JADUM2037324;
	Thu, 19 Feb 2026 10:13:48 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ccb228uem-10;
	Thu, 19 Feb 2026 10:13:48 +0000
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
Subject: [PATCH 6.12.y 09/14] selftests/mm: ensure pkey-*.h define inline functions only
Date: Thu, 19 Feb 2026 02:13:13 -0800
Message-ID: <20260219101318.2442406-10-harshit.m.mogalapalli@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=V6RwEOni c=1 sm=1 tr=0 ts=6996e25e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8
 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8 a=Kg4TyyTVP51hokRWqfQA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-ORIG-GUID: yB9FzTdKsfSQmrFGOIUokDTy4MUds5Gp
X-Proofpoint-GUID: yB9FzTdKsfSQmrFGOIUokDTy4MUds5Gp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5NCBTYWx0ZWRfX8/cKdTLiz6C2
 kAH9TFn4iOMY2ooCGMYVlCBagnf85dEXdArsoMBRHob1trMi6Kl8QqpsyTiqd8ISeURYMwe6MFC
 dAP0wJtj0p1bAsxligfyoPT6d9Pf5mvDbUS1pLYvNmZFGqLWjkeJ3OAn5DkPh0HVOHqq+DWf1sx
 7Xz8kCkDytU1cHVVZNGQaqa9bLsYrYtEkl5JJ6TtverCoLLZDZZ2AL3wacn3I2m+rm8uksWKJ/x
 5fFI0Mi612jKkXb3Gx2l/emUI38NPtJL8yIcdtQ4XbJqMpZ2XjCY8q4UjjCKIccew6QiMjws4+3
 Q85/QoJ9jEdBQ0YqZQsiiMjBhx3mJWI9GvZ6B5XuUksWy24OkqxOC2PCXXK2ej1fQBB3IvAS1fw
 LV/xPFp+OXGJu2xWTtoLzggnor4vHtSJph0wxgmbNU15H9bJ1PhzESsUHWs+R3omhC62JNpyuMO
 OkwDfl6BX/zQUZcdG1w==
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
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217420-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.com:email,linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,arm.com:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5E0D715DB0E
X-Rspamd-Action: no action

From: Kevin Brodsky <kevin.brodsky@arm.com>

[ Upstream commit 21309ac2652068f45ebb78a2e7a7cd3d5417350e ]

Headers should not define non-inline functions, as this prevents them from
being included more than once in a given program.  pkey-helpers.h and the
arch-specific headers it includes currently define multiple such
non-inline functions.

In most cases those functions can simply be made inline - this patch does
just that.  read_ptr() is an exception as it must not be inlined.  Since
it is only called from protection_keys.c, we just move it there.

Link: https://lkml.kernel.org/r/20241209095019.1732120-9-kevin.brodsky@arm.com
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Keith Lucas <keith.lucas@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 21309ac2652068f45ebb78a2e7a7cd3d5417350e)
[Harshit: backport to 6.12.y, clean cherry-pick]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 tools/testing/selftests/mm/pkey-arm64.h      | 4 ++--
 tools/testing/selftests/mm/pkey-helpers.h    | 8 +-------
 tools/testing/selftests/mm/pkey-powerpc.h    | 4 ++--
 tools/testing/selftests/mm/pkey-x86.h        | 6 +++---
 tools/testing/selftests/mm/protection_keys.c | 7 +++++++
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey-arm64.h b/tools/testing/selftests/mm/pkey-arm64.h
index d57fbeace38f..41013065fb5e 100644
--- a/tools/testing/selftests/mm/pkey-arm64.h
+++ b/tools/testing/selftests/mm/pkey-arm64.h
@@ -81,11 +81,11 @@ static inline int get_arch_reserved_keys(void)
 	return NR_RESERVED_PKEYS;
 }
 
-void expect_fault_on_read_execonly_key(void *p1, int pkey)
+static inline void expect_fault_on_read_execonly_key(void *p1, int pkey)
 {
 }
 
-void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
+static inline void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
 {
 	return PTR_ERR_ENOTSUP;
 }
diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index 84376ab09545..bc81275a89d9 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -84,13 +84,7 @@ extern void abort_hooks(void);
 # define noinline __attribute__((noinline))
 #endif
 
-noinline int read_ptr(int *ptr)
-{
-	/* Keep GCC from optimizing this away somehow */
-	barrier();
-	return *ptr;
-}
-
+noinline int read_ptr(int *ptr);
 void expected_pkey_fault(int pkey);
 int sys_pkey_alloc(unsigned long flags, unsigned long init_val);
 int sys_pkey_free(unsigned long pkey);
diff --git a/tools/testing/selftests/mm/pkey-powerpc.h b/tools/testing/selftests/mm/pkey-powerpc.h
index e90af82f8688..59262ee6c634 100644
--- a/tools/testing/selftests/mm/pkey-powerpc.h
+++ b/tools/testing/selftests/mm/pkey-powerpc.h
@@ -91,7 +91,7 @@ static inline int get_arch_reserved_keys(void)
 			return NR_RESERVED_PKEYS_64K_3KEYS;
 }
 
-void expect_fault_on_read_execonly_key(void *p1, int pkey)
+static inline void expect_fault_on_read_execonly_key(void *p1, int pkey)
 {
 	/*
 	 * powerpc does not allow userspace to change permissions of exec-only
@@ -115,7 +115,7 @@ void expect_fault_on_read_execonly_key(void *p1, int pkey)
 /* 4-byte instructions * 16384 = 64K page */
 #define __page_o_noops() asm(REPEAT_16384("nop\n"))
 
-void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
+static inline void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
 {
 	void *ptr;
 	int ret;
diff --git a/tools/testing/selftests/mm/pkey-x86.h b/tools/testing/selftests/mm/pkey-x86.h
index ac91777c8917..f7ecd335df1e 100644
--- a/tools/testing/selftests/mm/pkey-x86.h
+++ b/tools/testing/selftests/mm/pkey-x86.h
@@ -113,7 +113,7 @@ static inline u32 pkey_bit_position(int pkey)
 #define XSTATE_PKEY	0x200
 #define XSTATE_BV_OFFSET	512
 
-int pkey_reg_xstate_offset(void)
+static inline int pkey_reg_xstate_offset(void)
 {
 	unsigned int eax;
 	unsigned int ebx;
@@ -148,7 +148,7 @@ static inline int get_arch_reserved_keys(void)
 	return NR_RESERVED_PKEYS;
 }
 
-void expect_fault_on_read_execonly_key(void *p1, int pkey)
+static inline void expect_fault_on_read_execonly_key(void *p1, int pkey)
 {
 	int ptr_contents;
 
@@ -157,7 +157,7 @@ void expect_fault_on_read_execonly_key(void *p1, int pkey)
 	expected_pkey_fault(pkey);
 }
 
-void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
+static inline void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
 {
 	return PTR_ERR_ENOTSUP;
 }
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index c7c1af7ed2fb..e01e854dcd87 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -54,6 +54,13 @@ int test_nr;
 u64 shadow_pkey_reg;
 int dprint_in_signal;
 
+noinline int read_ptr(int *ptr)
+{
+	/* Keep GCC from optimizing this away somehow */
+	barrier();
+	return *ptr;
+}
+
 void cat_into_file(char *str, char *file)
 {
 	int fd = open(file, O_RDWR);
-- 
2.47.3


