Return-Path: <stable+bounces-217419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EwsCJbilmlbqgIAu9opvQ
	(envelope-from <stable+bounces-217419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 931F815DB07
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91C3130166DC
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12047328635;
	Thu, 19 Feb 2026 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sAgtmnso"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AEE326D5D;
	Thu, 19 Feb 2026 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496038; cv=none; b=hJfSdWBONItiCA/C1pcFEP4DuFwOWJbxGIIZpzruwoZ2um/IJ0Xe+xTUaTUne0Sb6t4i1jCONkrEGAtL1N8jGvlzO0BwV/9ephBA71UteCQq+I8SAiiofO7jTTbOj9l7Hv7nphL87CyI+b0kQF//iyXa/WADbVfcxdItiRyLt3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496038; c=relaxed/simple;
	bh=PiVil3clEVriv9sRqrgsH9d6W6K0+DNijKxC/oMhaSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Stct0usL7+pd0nzG8y64aHAfyuH5i5KiCE9npLySgvLxFXzkcFi3dyuq97M3Iic6SB0YgwR2yqCUiQMODMpS3VZBYC9XjzLXrBNr/1/2+gT9UtLPpRpnSYvqyW0Qvz6LV6fFXxYU4IJIrvKAIAA6Zx14vPvfcysMHb+cid1I5XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sAgtmnso; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J7o6Np026231;
	Thu, 19 Feb 2026 10:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=WHUWa
	L20j4xUFaLNksYrUQEUYHLFc1KWUhtLKX4oVxE=; b=sAgtmnsoaBXOXlXP93Ui1
	0cH4MNMcLFqFKXlab3DW2e6yYTMypt9piVB2BUSBsSDOjH0wlTetInEzSBtnFf5S
	Yc+x8+DUIA4Wj3qZYz2z9HIGeQE5qtuuKnc8QCPOqAoElUrDnw7PqwC8+FYAaxs/
	bUtZ85lLgNzwTgF6O3O2XAhzVp1XHBbYfmBSEnlSmkZn8KlOJVbvnhsdcfTbeGuq
	DsIGcCFIqXsOny5noP2eI9e1ID4lSlV9v7/EmAkerqgDZm0w7AuYbDp3wpZfyts2
	x6+M3PNKkacI5QP1/x0hYnrGC5M7ccM6IhTbrp39C/xqnXItLlOZ2QKAg3XVSu5e
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0rf4xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61JA9ai7033315;
	Thu, 19 Feb 2026 10:13:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb228urb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:51 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61JADUM4037324;
	Thu, 19 Feb 2026 10:13:50 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ccb228uem-11;
	Thu, 19 Feb 2026 10:13:50 +0000
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
Subject: [PATCH 6.12.y 10/14] selftests/mm: remove empty pkey helper definition
Date: Thu, 19 Feb 2026 02:13:14 -0800
Message-ID: <20260219101318.2442406-11-harshit.m.mogalapalli@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=V6RwEOni c=1 sm=1 tr=0 ts=6996e260 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8
 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8 a=JEQEY9TEzYLeO9usSioA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-ORIG-GUID: ILanEg1wfqeuBHFb-P_bAs-UXTfwYsL3
X-Proofpoint-GUID: ILanEg1wfqeuBHFb-P_bAs-UXTfwYsL3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5NCBTYWx0ZWRfX4uRZoPzw7Ew7
 AQeL3DchYkborGN80KCR0KTJ7WlDryldoMBs1RAdwhmucGpiBzru/bgleGaNx8D33JMPVL26A49
 cvhrXzBUcmmaSEQIBOO+3PQYahYf57q1YMj33mJR6JZbwo4J92n6b8pGMdAVGLy5E674JLyuEi2
 qM//V7SrEGNvU5DDMRoc//1v1I2uHJrqwv+fyppGJg8WevoZLO4ho1fMf1CbKTyiDDdBgBttROg
 YbYiK3n1YhZUOGL5/9iLjoL6ScLMP7fBshmLO+K6bC+/5sJ8ajdJtciororwEK7+F3cOBVB4a4M
 fHGm10YxOm9MT9IdnHCukOf8wcv9eHRlYhWI92ZeRP/OquvAS6k5sOCy9gZdGGNJVdh2dw04K35
 Pn0Ygxu9MmBIqahU3sN1t1Y4nCyUB6HAt85fnqGsPatdAUo0KkqgK71AeOFHSRGqQZYfGH1RIte
 OQvP0m/UAhDHFWBk15g==
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
	TAGGED_FROM(0.00)[bounces-217419-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 931F815DB07
X-Rspamd-Action: no action

From: Kevin Brodsky <kevin.brodsky@arm.com>

[ Upstream commit f3f555974c19ede667b1fbe67b3236beea474099 ]

Some of the functions declared in pkey-helpers.h are actually defined in
protections_keys.c, meaning they can only be called from
protections_keys.c.  This is less than ideal, but it is hard to avoid as
these helpers are themselves called from inline functions in
pkey-<arch>.h.  Let's at least add a comment clarifying that.  We can also
remove the empty definition in pkey_sighandler_tests.c:
expected_pkey_fault() is not meant to be called from there.

Link: https://lkml.kernel.org/r/20241209095019.1732120-10-kevin.brodsky@arm.com
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Keith Lucas <keith.lucas@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit f3f555974c19ede667b1fbe67b3236beea474099)
[Harshit: backprot to 6.12.y, clean cherry-pick]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 tools/testing/selftests/mm/pkey-helpers.h          | 6 ++++--
 tools/testing/selftests/mm/pkey_sighandler_tests.c | 2 --
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index bc81275a89d9..7604cc66ef0e 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -84,10 +84,12 @@ extern void abort_hooks(void);
 # define noinline __attribute__((noinline))
 #endif
 
-noinline int read_ptr(int *ptr);
-void expected_pkey_fault(int pkey);
 int sys_pkey_alloc(unsigned long flags, unsigned long init_val);
 int sys_pkey_free(unsigned long pkey);
+
+/* For functions called from protection_keys.c only */
+noinline int read_ptr(int *ptr);
+void expected_pkey_fault(int pkey);
 int mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
 		unsigned long pkey);
 void record_pkey_malloc(void *ptr, long size, int prot);
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index e754cd2fdcfa..d4813af46ebb 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -32,8 +32,6 @@
 
 #define STACK_SIZE PTHREAD_STACK_MIN
 
-void expected_pkey_fault(int pkey) {}
-
 pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
 pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
 siginfo_t siginfo = {0};
-- 
2.47.3


