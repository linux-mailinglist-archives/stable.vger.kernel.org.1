Return-Path: <stable+bounces-156107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CB6AE451B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D688189C4DE
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153902475E3;
	Mon, 23 Jun 2025 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VEw91Ptb"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B412472A2
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686165; cv=none; b=E6QbM1Agm/x7Kkx+KYQipdFEpl9j8/YF3nR/7EkhLbHQPYutEHk+LwPb0kL+hJNxQ9nFDBAmHQdtSf/jPUKSpxMQkGlQwHGCI6fdXTZUezmuOHOaMEPMmOU0leE1bOjD2zWe2tjl/uswvv6iKJZoNibJeL/kgg7ZevFy7s3SB40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686165; c=relaxed/simple;
	bh=qdg+EM3mbIekM+thba+QaUCgMAyoog061H5vK+udLrY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=M0+QrSofsf9pE7+wckjeYukYCzi7e8s1VCbNKuE+acXhBDRXs2FGrVmrJFDFRxSxaUKcGCjrOSU2jcKzY0niIRXcUbIXgbXafQ0iIvWtnMuzI40GiB8CjwhJbHH8buCe5h7OG6bxIK4BdwvIvBIDmxX1tYG0OumKCbvKGz60UlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VEw91Ptb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NBJV1B010884
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qOUb6rVnC9PRVGI3ps4c4HopqKEHYZGdgSEqxlR3k
	OM=; b=VEw91PtbVdPtsCmiq8iuovP4UM+RcZftTZYPDtiJNXHU6BpncksUzfzCL
	/Wh3RSV2qizi0koQvonly6YZyvF9Z9h/lem+Rq19KSl2QULIo36Yr+F5BVkhL+Aj
	m62iXLW60Eo3aBIGI6dU/6zagG4JJV3mgt7qrbwqQ1SswJdo96CMn1jWR1zxBIQa
	n8Nk50PfO0vYVFjotY5m/mYCvBGVeU1xOChruoYNhmoha9VVJMJ1a+jXA20oEAkR
	3faSBeA9+gOEiIWQ5gcUgBYDQrU5b+fkjJtyN/i98Wr3/cLnZO11iRCZgZDIu76/
	fVtYD4Szc/Hh0AFafnMkxJ2MAOBgw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dme12a9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:42:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NCb9Tc014748
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:42:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s26p0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:42:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55NDgeH758392878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:42:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A2382004B
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:42:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D77B20043
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:42:40 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:42:40 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y] s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS
Date: Mon, 23 Jun 2025 15:42:40 +0200
Message-ID: <20250623134240.1107347-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Tc6WtQQh c=1 sm=1 tr=0 ts=685959d3 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=O4dmbfcdmyx46WCdPC8A:9
X-Proofpoint-GUID: N7Og9YBi4hwsWg7lMrIj-aoEkotGBrH8
X-Proofpoint-ORIG-GUID: N7Og9YBi4hwsWg7lMrIj-aoEkotGBrH8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4MCBTYWx0ZWRfX5D0MnKcmkeZC A0li4bGmfJCszyNAqRGT1qqCj3oWG+92Le0WNbwj0NRqc2Nn/PuM5ED2/6qURMs7+WGIcHsjeJR scqyqsyJaV+wHqyHUs8IpyvdzG8vdwebfjSHksGSAawaSN8yZJEkp3chsF47BpHDG27qub9PNt8
 czgv6XkcXZkrNI6kl14NpN1bwzoyBDhQtDTBZqRVgQsm6nPr0j58wlX/7MsTPOvTlIELGh6EZ7a pGQF85rlQT9ksl/KAXfeFn/wYlYEuTx6d0fkcPSkVxJuRTv77MJuLN1Tsc941NR7Wtph0FiK5H6 23j3o1up7Mo6eQfi6xonM7EWNDY4Qyf6+YOkXwjy/6AF7BnKemvRJhS8PLZraSbTfG4Fpte5oQQ
 QzONrNvcPr4WvnB1QKnzHxMy1366P/VtREGB1W3VQQZZzmrc9LoiiX4jlmAuqvAqe+IyI2Q6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=839 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230080

From: Nathan Chancellor <nathan@kernel.org>

commit 3b8b80e993766dc96d1a1c01c62f5d15fafc79b9 upstream.

GCC changed the default C standard dialect from gnu17 to gnu23,
which should not have impacted the kernel because it explicitly requests
the gnu11 standard in the main Makefile. However, there are certain
places in the s390 code that use their own CFLAGS without a '-std='
value, which break with this dialect change because of the kernel's own
definitions of bool, false, and true conflicting with the C23 reserved
keywords.

  include/linux/stddef.h:11:9: error: cannot use keyword 'false' as enumeration constant
     11 |         false   = 0,
        |         ^~~~~
  include/linux/stddef.h:11:9: note: 'false' is a keyword with '-std=c23' onwards
  include/linux/types.h:35:33: error: 'bool' cannot be defined via 'typedef'
     35 | typedef _Bool                   bool;
        |                                 ^~~~
  include/linux/types.h:35:33: note: 'bool' is a keyword with '-std=c23' onwards

Add '-std=gnu11' to the decompressor and purgatory CFLAGS to eliminate
these errors and make the C standard version of these areas match the
rest of the kernel.

Cc: stable@vger.kernel.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/r/20250122-s390-fix-std-for-gcc-15-v1-1-8b00cadee083@kernel.org
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Makefile           | 2 +-
 arch/s390/purgatory/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 39ffcd4389f1..92f2426d8797 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -23,7 +23,7 @@ endif
 aflags_dwarf	:= -Wa,-gdwarf-2
 KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
 KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
-KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2
+KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -std=gnu11
 KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index a93c9aba834b..955f113cf320 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -20,7 +20,7 @@ GCOV_PROFILE := n
 UBSAN_SANITIZE := n
 KASAN_SANITIZE := n
 
-KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
+KBUILD_CFLAGS := -std=gnu11 -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
-- 
2.48.1


