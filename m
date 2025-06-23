Return-Path: <stable+bounces-156028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98153AE44BE
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7231BC2CAB
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDEA253356;
	Mon, 23 Jun 2025 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mkLcD9PY"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5F1E480
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685961; cv=none; b=lpsONOWuslMKJYwaTL6adQmbAHHJwnkzqf1Zd8t6WN57qVuTXG45jce8MzDl3KZeG2mw8J1ydC53So17nZWbGITVSIB6cMUHerzmH/5nvKgcn65h3dkrznpNGTa9U6oQpTEbJFF7qbW17OYRWpv7BPz+fgZI7am+ITv8eGHn7Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685961; c=relaxed/simple;
	bh=zu8NyWEn6tTWYPtK2JZRbX260ibp5p21L9edfacxA78=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=U1MJBGqCj+Gz6zBKo2sKxGZiP3/8rgZcdDvzCWFzowi6CpfZWD67VTY2LBBKAYsWUa9mEYzAQMzDgQUq/bCUqU+ppcDiwPK4AJNJJGSb3hqNGlmpeA2CPwB4v5Qvcu6MC3F5Ini16PATUBCe4VTdFjjLBCKHzSMZO56payJ4LYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mkLcD9PY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9VMhF003740
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=SJDEL+Mmp21TPaskptod7rry1JXsPQ15StcS7gqhj
	4Q=; b=mkLcD9PYEmPKP4sxMhcbUx4K5AuyiVQ5wY9npSrpKMIX9ooG8+DFb4xUJ
	xwsY6ervxLkHqTcgNDS25illus0eJU/yHhoYmkHF8k26vH5WC5m/+meycE18cic8
	fhMQWdPdD18ssPtUbc2VwK/LBnHCVLXti+c2BpOZfLwbTYMYUgpWmWuvVu78aqkA
	ygO/iXsBgv1kZkdjM5wq+2M2tdlgtKp1W7yK/JGXNDhkornOxhS7J4VnrllRxw2Z
	NejjLWaDwjMdERMhCMxFXitpL4xpG5YuFk/PEkW122pZwbVYYUBT9rfqkeFJB5jD
	BXqCwaErVDNxOAUdwlvNotv6i4LBg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf2t2sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:39:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NDUpPM030487
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:39:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e7eyq37a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:39:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55NDdFkQ56099256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:39:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35BA92004E
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:39:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B2CC2004D
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:39:15 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:39:15 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y] s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS
Date: Mon, 23 Jun 2025 15:39:14 +0200
Message-ID: <20250623133914.1024961-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=68595905 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=O4dmbfcdmyx46WCdPC8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4MCBTYWx0ZWRfX4ifU7waDaNxY vwac9Y5VcKKjiyEXsc35fzNi0XbQZylpdWbd+KVABDQGQQBsKPTx1wCjuvSa+TVkXoTafpG6ZIJ BU1QMKsMtzA0qOaom/AOWWPReV4WC+UTvv9it7F3no6jwcNqCW5uMaSVWoRfA49FzwIPeFo2Me+
 Ebi8BfjFBSw6FtDzVlyhapzyDBbH8jj0bGS7LWQAf6JgtyxKtIxxaKvU57SZ0SLxGPuctj9lzY4 XpvMCDdYtKTp8NsczwP8Aib75QziJ3Kj2CzIVPa+LC0sQzlaHglg/Ogrh5M53NERttOK1wJAZdK kdGCuwDp5NxYO+v1vdY95KuuR0UfbK/3hz/P56FuF6yhEvqnB0+EZSAT3RyX471gX0AgnlLQIM3
 DmZ62t1itEmeNA6a6lZ2Lg5yq67zz99EB/BRWb14WIsvQrW/AtImtp/7II3DFbQzbljZBD4A
X-Proofpoint-GUID: koF5_k2QHbnZI_CHkm3P8rl1AnmQYYTe
X-Proofpoint-ORIG-GUID: koF5_k2QHbnZI_CHkm3P8rl1AnmQYYTe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 mlxlogscore=851 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
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
index dc840ba0b016..c8071eb82e2e 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -23,7 +23,7 @@ endif
 aflags_dwarf	:= -Wa,-gdwarf-2
 KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
 KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
-KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2
+KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -std=gnu11
 KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float -mbackchain
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index d22ec8acb13c..677cbb654024 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -21,7 +21,7 @@ UBSAN_SANITIZE := n
 KASAN_SANITIZE := n
 KCSAN_SANITIZE := n
 
-KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
+KBUILD_CFLAGS := -std=gnu11 -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
-- 
2.48.1


