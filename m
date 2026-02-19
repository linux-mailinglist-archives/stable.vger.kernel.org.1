Return-Path: <stable+bounces-217424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCS7HqvilmnkqQIAu9opvQ
	(envelope-from <stable+bounces-217424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:15:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 242FC15DB3C
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DBEE304CEAA
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBF532BF42;
	Thu, 19 Feb 2026 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eTwQQrPG"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDA130F94E;
	Thu, 19 Feb 2026 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496049; cv=none; b=Thm8fjv7Fa6/8dfuYzYXu+j1j07fNE9XOrBdQuhxrphBOTaKZ+NBQZeUqYMmDsIXxII5wmbUejyXiAL+L9HGUoTVa70UT2pp66wuHXST+Id0w75t8Ace5l9IJaY+PBC56yJepS6BLk3GsIqs5Bzy4esrebaq9dtbvcsMtlLs+30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496049; c=relaxed/simple;
	bh=VdMVRN0gRuDbQQd7+nAQWeXZX8+mmYxSxDCbnkYF+r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdpjcbYN2x9aigIIw/KxqG/2XDVgejWkdck6DB7ws7aDwGghKOfHrf5AIai8mseDL7FXrEHDfoyDrna3vWR5mP0G5/vfJgU4H2OHVPO60/cdbMBexnL0BtFHfIhYSUy2OftwrDpNHr+YG9IBKASLBd5tctQCa6aBFxUnkggSuiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eTwQQrPG; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J67INT250938;
	Thu, 19 Feb 2026 10:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=rXfXe
	6Oa2N1nMzbl7xizi2Xz0AZv3IkrqUhkQkNqCjs=; b=eTwQQrPG86dVG+wjA3t8v
	AztSADn/TeuVL7I8QDSNDaXng2xj1Wnc1WAxIIv+7CN9BXnUEJKePJdv7KzwYVZc
	GIDK8POhI08oGBNMsdp2iroZeT32Q6BhWfrjkLCs9TMc+t98dvyPY8f9iHnowSyK
	DNWy3B34GpaOCfjaFlIkN0yX3jMDTRvtO7OJ6IZdhNpgdSIEyUAI5vblLglNLJKa
	j4vq7zcq1UXyHh3xMy2yLnw2XWW50qezQYQjFd8H2UMUUCOT/u8hDdr9yczMGrup
	1JgV4HdGW8XVTBQKssDLopCVJdVfKiCv7WF7wAvg6gnBa/pTBIq2qCJhVTx2mAjN
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0wq4wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61J81ec9033203;
	Thu, 19 Feb 2026 10:13:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb228uur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:58 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61JADUMA037324;
	Thu, 19 Feb 2026 10:13:58 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ccb228uem-14;
	Thu, 19 Feb 2026 10:13:57 +0000
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
Subject: [PATCH 6.12.y 13/14] selftests/mm: rename pkey register macro
Date: Thu, 19 Feb 2026 02:13:17 -0800
Message-ID: <20260219101318.2442406-14-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5NCBTYWx0ZWRfX7IaVSd6K56wi
 4/QgCl58LM6EXeeN1RLvH7UyDy/vDpZsKOR768wy6aa+PAoWDBG9nETJyVs237rg8zCFt9j1ZA/
 dOjXUM1wjGgG2dviALsvcZD0dqoQe43CXThQfdpFdjzbkauhGDNB8cd2OLo3vBNCFYZYvlARZXk
 TMhcW3/VSDtuyupz/kueNZpRyKuMbuZeQ7XVlAgGz4ekIuItxRxSNMCuBEv17sxDChx0DUlu6dj
 yhXv4AUUgCyhVdvPkmWtiyQmUW1v5oIn1Rf8mcE3uhqtNO12Q9iCzYQEy6IU/ymhgHiex6fzk2S
 P0VUmEL9R33UmOCs44DmX+xp2p5LM6viD78azPD4FBbrQDt7ARUP3nP9PTUZ3WB1iRUdfvMqiS6
 7qkdeNLVb/vjWoBU1ppG29qEDP7T7mCngE2dMmS7nedbe5qZP7QMXpxhkNnbTuNSRUxGqa4quhF
 8ysxSbBpubPJyXb89PA==
X-Authority-Analysis: v=2.4 cv=ZMfaWH7b c=1 sm=1 tr=0 ts=6996e267 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8
 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8 a=AFsvoTy3hIXoo9AhgmUA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-ORIG-GUID: jkZm006SWI0QwuMmHNCWo9EFUA7R9fE0
X-Proofpoint-GUID: jkZm006SWI0QwuMmHNCWo9EFUA7R9fE0
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
	TAGGED_FROM(0.00)[bounces-217424-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 242FC15DB3C
X-Rspamd-Action: no action

From: Kevin Brodsky <kevin.brodsky@arm.com>

[ Upstream commit 28501aa13acd8376b09a87dc5e3da02462bb0702 ]

PKEY_ALLOW_ALL is meant to represent the pkey register value that allows
all accesses (enables all pkeys).  However its current naming suggests
that the value applies to *one* key only (like PKEY_DISABLE_ACCESS for
instance).

Rename PKEY_ALLOW_ALL to PKEY_REG_ALLOW_ALL to avoid such
misunderstanding.  This is consistent with the PKEY_REG_ALLOW_NONE macro
introduced by commit 6e182dc9f268 ("selftests/mm: Use generic pkey
register manipulation").

Link: https://lkml.kernel.org/r/20241209095019.1732120-13-kevin.brodsky@arm.com
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Keith Lucas <keith.lucas@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 28501aa13acd8376b09a87dc5e3da02462bb0702)
[Harshit: clean cherry-pick, backport to 6.12.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 tools/testing/selftests/mm/pkey-arm64.h      | 2 +-
 tools/testing/selftests/mm/protection_keys.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey-arm64.h b/tools/testing/selftests/mm/pkey-arm64.h
index 41013065fb5e..588286b25a61 100644
--- a/tools/testing/selftests/mm/pkey-arm64.h
+++ b/tools/testing/selftests/mm/pkey-arm64.h
@@ -30,7 +30,7 @@
 #define NR_PKEYS		8
 #define NR_RESERVED_PKEYS	1 /* pkey-0 */
 
-#define PKEY_ALLOW_ALL		0x77777777
+#define PKEY_REG_ALLOW_ALL	0x77777777
 #define PKEY_REG_ALLOW_NONE	0x0
 
 #define PKEY_BITS_PER_PKEY	4
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index bb26a07fe206..35565af308af 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -396,7 +396,7 @@ static void signal_handler(int signum, siginfo_t *si, void *vucontext)
 	/* restore access and let the faulting instruction continue */
 	pkey_access_allow(siginfo_pkey);
 #elif defined(__aarch64__)
-	aarch64_write_signal_pkey(uctxt, PKEY_ALLOW_ALL);
+	aarch64_write_signal_pkey(uctxt, PKEY_REG_ALLOW_ALL);
 #endif /* arch */
 	pkey_faults++;
 	dprintf1("<<<<==================================================\n");
@@ -842,7 +842,7 @@ void expected_pkey_fault(int pkey)
 	 */
 	if (__read_pkey_reg() != 0)
 #elif defined(__aarch64__)
-	if (__read_pkey_reg() != PKEY_ALLOW_ALL)
+	if (__read_pkey_reg() != PKEY_REG_ALLOW_ALL)
 #else
 	if (__read_pkey_reg() != shadow_pkey_reg)
 #endif /* arch */
-- 
2.47.3


