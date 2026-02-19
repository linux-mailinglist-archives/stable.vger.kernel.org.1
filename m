Return-Path: <stable+bounces-217417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PX0HY3ilmlbqgIAu9opvQ
	(envelope-from <stable+bounces-217417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 205F415DAF7
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E0EA30480BB
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F41A328B5C;
	Thu, 19 Feb 2026 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YZ4HmDFg"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24468311C37;
	Thu, 19 Feb 2026 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496033; cv=none; b=d5/uXDRaTMznYbsagSwA29jXDYr1Qz5aV5VpGd6RTCE2jefh2DBRvXHjphE+NUNoml6Zduad4ajf4NevEbXWC5UO5abfl2WmZ+Ak0T/LbgxU0MJQDihxXX7KKQkLTOvLmHyH7MKT7SNA739bf2myFhjWP7qduvVcy2l5WtH/cro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496033; c=relaxed/simple;
	bh=t1iUZiyP8vXfuCp/iasJT1WQiO9QCyQ0llMPLrX1apQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAsPkCYzIHnSr7gLTwNI6baKCnAi1WsPBzBUwZanAk3QqFzuOllp0ltUwS7N7iynfafJWKjZyovTWoxMGFNEGKzFlD9PJfLwoUrdhk+AZDpKaOCqy0OrDVkUObgSIbyqxZ1b9L8niADCHoqR8592iN1pX8OHrpI6dK7+aB2LH5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YZ4HmDFg; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J89QSx3675464;
	Thu, 19 Feb 2026 10:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=gWtI+
	ka/cXykotr0eWxjd4fKKwslqTOAO7X4kbOtjws=; b=YZ4HmDFgWKNI+qoeicny+
	nNHf24asJnyIuj5C7QBo3TYy+SrnagbYDb+oEYc4/AJJ/MTGu3dPZlPhDwECrCSv
	zDCYTna1Zvc6pWks+G2N8X880c/tp4rzfExcjHKzMG9W0GqWVA7pd1jvekLZdn8s
	o2JQWhTyUf8O9W0rzpUKc7OCa9UvhCZJHQXMrbA+cuLT9v7YtARtuCvEvIVFiudK
	hwbShmHjrf3AtnK52zT01Id0w9I52TgYBd2pZxSNSzNWLwn5BPRbvmmZG7M5VmSc
	nBbwfL59nNOKrYzxjSfilcXUD8CPOhpy4sGHQzppWx7JoOxH06I9yZZCN2AACeBI
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0ay4fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61J8GbS0033231;
	Thu, 19 Feb 2026 10:13:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb228unt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:45 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61JADULw037324;
	Thu, 19 Feb 2026 10:13:45 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ccb228uem-8;
	Thu, 19 Feb 2026 10:13:44 +0000
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
Subject: [PATCH 6.12.y 07/14] selftests/mm: remove unused pkey helpers
Date: Thu, 19 Feb 2026 02:13:11 -0800
Message-ID: <20260219101318.2442406-8-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: 8DR9viy5Pf7iLoiaDWIW0soJFCrVu6TZ
X-Proofpoint-ORIG-GUID: 8DR9viy5Pf7iLoiaDWIW0soJFCrVu6TZ
X-Authority-Analysis: v=2.4 cv=UsVu9uwB c=1 sm=1 tr=0 ts=6996e25a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8
 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8 a=FN0Gei73HV1jO-_99HYA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5NCBTYWx0ZWRfX/U46oYx8OvXM
 q5OqXvvE+H/fjfvP93wDiH1zgNGXBs9+DFshb4WlvpoUadTXd/XqvAyEpHeBiR9T3rpFBNz2WOS
 tFOKZiw0ev/ZMiYiHth++B0so3qH26FNWitSOIp7AC8Je8OipCsp0SclhIlrxPQo4jMlEJk7m2B
 sv9IFvrwmCwD1TQc9FWXAJRRncnkUUNAfTK5OL33RitC55C1VnWwhMi+UmgIo4l3NeeEGt9GfnG
 6qJH5gWQ9yZsQmuwilo7o3BOR91/uGxv/RkvvXMd5w2kWahffJnwm+8EOBC5hyjL1Cf0UCrd8Xq
 xP5qlOWyNOKQV3zKZWtl+KfP60uNhdJT2kpoUJ15tTr8XzDnwZ88hkj2BbP6BP+kJUdhr/g2jU7
 bFT3hRTfbPn+jWoFIg+Tou0kA6M/7f8aD6DKpRFw1pA1UmhH58LcgRL/pLkUGk97j3DRPz0K26Q
 dGaYCN2Nq9T8PENOnlQ==
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
	TAGGED_FROM(0.00)[bounces-217417-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 205F415DAF7
X-Rspamd-Action: no action

From: Kevin Brodsky <kevin.brodsky@arm.com>

[ Upstream commit 31fdc9657bbc9a3245bce4cd8b51bcc243b6cb97 ]

Commit 5f23f6d082a9 ("x86/pkeys: Add self-tests") introduced a
number of helpers and functions that don't seem to have ever been
used. Let's remove them.

Link: https://lkml.kernel.org/r/20241209095019.1732120-7-kevin.brodsky@arm.com
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Keith Lucas <keith.lucas@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 31fdc9657bbc9a3245bce4cd8b51bcc243b6cb97)
[Harshit: backport to 6.12.y, clean cherry-pick]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 tools/testing/selftests/mm/pkey-helpers.h    | 34 --------------------
 tools/testing/selftests/mm/protection_keys.c | 34 --------------------
 2 files changed, 68 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index f7cfe163b0ff..472febd992eb 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -26,9 +26,7 @@
 #ifndef DEBUG_LEVEL
 #define DEBUG_LEVEL 0
 #endif
-#define DPRINT_IN_SIGNAL_BUF_SIZE 4096
 extern int dprint_in_signal;
-extern char dprint_in_signal_buffer[DPRINT_IN_SIGNAL_BUF_SIZE];
 
 extern int test_nr;
 extern int iteration_nr;
@@ -171,38 +169,6 @@ static inline void write_pkey_reg(u64 pkey_reg)
 			pkey_reg, __read_pkey_reg());
 }
 
-/*
- * These are technically racy. since something could
- * change PKEY register between the read and the write.
- */
-static inline void __pkey_access_allow(int pkey, int do_allow)
-{
-	u64 pkey_reg = read_pkey_reg();
-	int bit = pkey * 2;
-
-	if (do_allow)
-		pkey_reg &= (1<<bit);
-	else
-		pkey_reg |= (1<<bit);
-
-	dprintf4("pkey_reg now: %016llx\n", read_pkey_reg());
-	write_pkey_reg(pkey_reg);
-}
-
-static inline void __pkey_write_allow(int pkey, int do_allow_write)
-{
-	u64 pkey_reg = read_pkey_reg();
-	int bit = pkey * 2 + 1;
-
-	if (do_allow_write)
-		pkey_reg &= (1<<bit);
-	else
-		pkey_reg |= (1<<bit);
-
-	write_pkey_reg(pkey_reg);
-	dprintf4("pkey_reg now: %016llx\n", read_pkey_reg());
-}
-
 #define ALIGN_UP(x, align_to)	(((x) + ((align_to)-1)) & ~((align_to)-1))
 #define ALIGN_DOWN(x, align_to) ((x) & ~((align_to)-1))
 #define ALIGN_PTR_UP(p, ptr_align_to)	\
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 4fcecfb7b189..c7c1af7ed2fb 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -53,7 +53,6 @@ int test_nr;
 
 u64 shadow_pkey_reg;
 int dprint_in_signal;
-char dprint_in_signal_buffer[DPRINT_IN_SIGNAL_BUF_SIZE];
 
 void cat_into_file(char *str, char *file)
 {
@@ -397,12 +396,6 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 	dprint_in_signal = 0;
 }
 
-int wait_all_children(void)
-{
-	int status;
-	return waitpid(-1, &status, 0);
-}
-
 void sig_chld(int x)
 {
 	dprint_in_signal = 1;
@@ -817,39 +810,12 @@ void *malloc_pkey_hugetlb(long size, int prot, u16 pkey)
 	return ptr;
 }
 
-void *malloc_pkey_mmap_dax(long size, int prot, u16 pkey)
-{
-	void *ptr;
-	int fd;
-
-	dprintf1("doing %s(size=%ld, prot=0x%x, pkey=%d)\n", __func__,
-			size, prot, pkey);
-	pkey_assert(pkey < NR_PKEYS);
-	fd = open("/dax/foo", O_RDWR);
-	pkey_assert(fd >= 0);
-
-	ptr = mmap(0, size, prot, MAP_SHARED, fd, 0);
-	pkey_assert(ptr != (void *)-1);
-
-	mprotect_pkey(ptr, size, prot, pkey);
-
-	record_pkey_malloc(ptr, size, prot);
-
-	dprintf1("mmap()'d for pkey %d @ %p\n", pkey, ptr);
-	close(fd);
-	return ptr;
-}
-
 void *(*pkey_malloc[])(long size, int prot, u16 pkey) = {
 
 	malloc_pkey_with_mprotect,
 	malloc_pkey_with_mprotect_subpage,
 	malloc_pkey_anon_huge,
 	malloc_pkey_hugetlb
-/* can not do direct with the pkey_mprotect() API:
-	malloc_pkey_mmap_direct,
-	malloc_pkey_mmap_dax,
-*/
 };
 
 void *malloc_pkey(long size, int prot, u16 pkey)
-- 
2.47.3


