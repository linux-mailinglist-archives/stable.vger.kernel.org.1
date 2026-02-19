Return-Path: <stable+bounces-217411-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC9CLHPilmlbqgIAu9opvQ
	(envelope-from <stable+bounces-217411-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F9D15DAB4
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C361E3018D53
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A729331AF2D;
	Thu, 19 Feb 2026 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RZYDlXqo"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E0830F94E;
	Thu, 19 Feb 2026 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496022; cv=none; b=gWNfBk8fN6ehePh2PcTpAlfKGQHB5r94m8MlXCuLWC5xJ33rdT5octmQXqV0NaNcZfZn+ZkABctT9AEgYF7mQRPU/HA5wEW3vyotcXZCVCCwITi/CIgDvohGK5VmD5mYcJpadqy3CIYnd4vjtvyvu4+GzV5pgDUulUFl2fsMHYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496022; c=relaxed/simple;
	bh=ugFwz3YqerSFU5Me0t918rE5plOpNSwNfSs6/Vyrxqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhygSm3na4f1t6RsEOSqcqpkbNvuYCzkc5diw+7QX6KyJL1JxQcFU/qF9iZWDdHcDi+e4NhqdwhSJDyw9wfwPVZm6rj4vgqG2Xz5NbLLfT8SKW8k0jGac0kYlCKy/PPUC456q7DInr3taozc0q1Nc5gwPUIThetJMftMljq/hDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RZYDlXqo; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J7csoe066038;
	Thu, 19 Feb 2026 10:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ybBTF
	lWkpz91q4NHodTf4KoSDaF4ZCbuuf09oNkkt+8=; b=RZYDlXqoWGNIfV9PU2dxq
	SE1rbOLveQxmDw6Xt1TDSvFAY2X5MDg5ja8LwXvOYPq1oBXX2YMu3PAVMtRZoyeA
	BsJRZKZKdaK8GUnG999ODeQWTKV+Ga9fbglyNi36JfAlg5RIafycIUhtDn5um80Y
	3bBZ91haqZHo8VmWEPcFOzRNG5QJSTl73Jf3uddw/vcf0dEfBmFMKMA6EYMkhN/Y
	f9wMge61qc9l6Vo5PqYEDi9N81v2HmOJMZ+j8NrXj9cRjAtS789Bb+FBEeFTIdnL
	HE5/AUVbvIxuw7MJG2ViEjHTgTHN36rK3R4l2h1lUtEFXX1Xip2PEgtKzcO5zsgC
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0473sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61J9d0kP033190;
	Thu, 19 Feb 2026 10:13:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb228ug8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:33 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61JADULk037324;
	Thu, 19 Feb 2026 10:13:33 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ccb228uem-2;
	Thu, 19 Feb 2026 10:13:32 +0000
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
Subject: [PATCH 6.12.y 01/14] selftests/mm: fix condition in uffd_move_test_common()
Date: Thu, 19 Feb 2026 02:13:05 -0800
Message-ID: <20260219101318.2442406-2-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5NCBTYWx0ZWRfX9W9Sf8bwTqyV
 BA0YL06HcW7OxSpiiKI1SMn3WE7Gi4qN2azNxQOGD5A17tN7n4dcBn9t6xfZWEKtkhgbdyG7RTN
 dYqqDGDfNwiyW6ZHpAOTSlpEcEVAbLdmSkhXgA4s45EcegL6pUe2RqQtxu6GSf0m3CHQ6UoVwtD
 fEc09jRF7GO0OhDjPdmkZypxbK2HTMuG5aEp2zISAFXdH0qYWge45Lzm8lTsi4fJ2ZT+gRyl93Z
 0Y+VpILcJ8JNmKfYvtE8yl1cjDmv8/ccR0OFr6qcKFtHkP7Yw7tLQsNTLPwlH0BuOtECTFrNR8M
 Hw+YXrcCFDbg5NQj9vzOImuC4yvivdPCupZh6wWSM/BvfTgXAtx30vyPc5t5HvC8W6fQwHrGBXI
 LbxSKe8FlaxwUbF5GOIyOLqwWb/y1hHVleeMXgvSwZ6hdZ+l2GJXT3nsiALqrtTavCRe4Opi9WU
 6bCyG6GCSJCv1YURoiw==
X-Authority-Analysis: v=2.4 cv=O+w0fR9W c=1 sm=1 tr=0 ts=6996e24e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8
 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8 a=y4vWUWjtOYaGftmJ-g4A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: 1SaiQmHq2-ZUGKyk_RPHazZmLD6hW0xx
X-Proofpoint-ORIG-GUID: 1SaiQmHq2-ZUGKyk_RPHazZmLD6hW0xx
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
	TAGGED_FROM(0.00)[bounces-217411-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 53F9D15DAB4
X-Rspamd-Action: no action

From: Kevin Brodsky <kevin.brodsky@arm.com>

[ Upstream commit 8e36b2945e7057d956b5eb4a91cbf42eb5b26148 ]

Patch series "pkeys kselftests improvements".

This series brings various cleanups and fixes for the mm (mostly pkeys)
kselftests.  The original goal was to make the pkeys tests work out of the
box and without build warning - it turned out to be more involved than
expected.

The most important change is enabling -O2 when building all mm kselftests
(patch 5).  This is actually needed for the pkeys tests to run
successfully (see gcc command line at the top of protection_keys.c and
pkey_sighandler_tests.c), and seems to have no negative impact on the
other tests.  It certainly can't hurt performance!

The following patches address a few obvious issues in the pkeys tests
(unused code, bad scope for functions/variables, etc.) and finally make a
couple of small improvements.

There is one ugliness that this series does not fix: some functions in
pkey-<arch>.h call functions that are actually defined in
protection_keys.c.  For instance, expect_fault_on_read_execonly_key() in
pkey-x86.h calls expected_pkey_fault().  This means that other test
programs that use pkey-helpers.h (namely pkey_sighandler_tests) would fail
to link if they called such functions defined in pkey-<arch>.h.  Fixing
this would require a more comprehensive reorganisation of the pkey-*
headers, which doesn't seem worth it (patch 9 adds a comment to
pkey-helpers.h to clarify the situation).

Some more details on the patches:

- Patch 1 is an unrelated fix that was revealed by inspecting a warning.
  It seems fairly harmless though, so I thought I'd just post it as part
  of this series.

- Patch 2-5 fix various warnings that come up by building the mm tests
  at -O2 and finally enable -O2.

- Patch 6-12 are various cleanups for the pkeys tests. Patch 11 in
  particular enables is_pkeys_supported() to be called from outside
  protection_keys.c (patch 13 relies on this).

- Patch 13-14 are small improvements to pkey_sighandler_tests.c.

Many thanks to Ryan Roberts for checking that the mm tests still run fine
on arm64 with those patches applied.  I've also checked that the pkeys
tests run fine on arm64 and x86.

This patch (of 14):

area_src and area_dst are saved at the beginning of the function if
chunk_size > page_size.  The intention is quite clearly to restore them at
the end based on the same condition, but step_size is considered instead
of chunk_size.  Considering that step_size is a number of pages, the
condition is likely to be false.

Use the same condition as when saving so that the globals are restored as
intended.

Link: https://lkml.kernel.org/r/20241209095019.1732120-1-kevin.brodsky@arm.com
Link: https://lkml.kernel.org/r/20241209095019.1732120-2-kevin.brodsky@arm.com
Fixes: a2bf6a9ca805 ("selftests/mm: add UFFDIO_MOVE ioctl test")
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Keith Lucas <keith.lucas@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 8e36b2945e7057d956b5eb4a91cbf42eb5b26148)
[Harshit: Backport to 6.12.y, clean backport]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 3ddbb0a71b9c..52d6979ebf99 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1191,7 +1191,7 @@ uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
 				    nr, count, count_verify[src_offs + nr + i]);
 		}
 	}
-	if (step_size > page_size) {
+	if (chunk_size > page_size) {
 		area_src = orig_area_src;
 		area_dst = orig_area_dst;
 	}
-- 
2.47.3


