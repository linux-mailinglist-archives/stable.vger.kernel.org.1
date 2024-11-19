Return-Path: <stable+bounces-94002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA009D270C
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC727B28EDC
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAC61CCED6;
	Tue, 19 Nov 2024 13:32:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AC21CC8B7
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023160; cv=none; b=MU/DKjS7Da/+9xfm30BdW91fpHG1ElskSMxtGHlyqRRqKjpopUYsv/NmrLdGi0EM8Wz/hhF7z8OM5viloWDPqNIGDULVcVmlskLcSn12t28Z+03/g4QWuna8L9c7ZgSDMgfuiA0kydqU8h+ltKGAfBh4zfEiF6oCmj4aKu1v6r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023160; c=relaxed/simple;
	bh=meTm0e9zHRMEvptKORXh4IgkGfk/4gRKv0HppgiZmsk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hMsjkNcAAn5StXsP9ugeDVZXTbNHILmhYYwerAjth3K66v3lZjEy5V4HAd3LbBZM2vSKVr1BxdJ/7tui4taLNs4/JYx3p3CV6mEbZBXKXFg8MB1uvidk+UbU/EjoCfVV3H08oPRdHv3x5Kcf+taUGIoZjTfsFRzhyk8Nrtk01Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJBrg19025170;
	Tue, 19 Nov 2024 05:32:35 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xqj7tvfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 19 Nov 2024 05:32:35 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 19 Nov 2024 05:32:35 -0800
Received: from pek-blan-cn-d1.wrs.com (128.224.34.185) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 19 Nov 2024 05:32:34 -0800
From: Bin Lan <bin.lan.cn@windriver.com>
To: <mpatocka@redhat.com>, <stable@vger.kernel.org>
Subject: [PATCH 6.1 v2] parisc: fix a possible DMA corruption
Date: Tue, 19 Nov 2024 21:32:55 +0800
Message-ID: <20241119133255.2573917-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ek82LG5P3LqolLR2vlIaANrocHQerDGp
X-Proofpoint-GUID: ek82LG5P3LqolLR2vlIaANrocHQerDGp
X-Authority-Analysis: v=2.4 cv=Sb6ldeRu c=1 sm=1 tr=0 ts=673c9373 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VlfZXiiP6vEA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=YlDBPuehlc0bO2GpeZkA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_05,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411190098

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 7ae04ba36b381bffe2471eff3a93edced843240f ]

ARCH_DMA_MINALIGN was defined as 16 - this is too small - it may be
possible that two unrelated 16-byte allocations share a cache line. If
one of these allocations is written using DMA and the other is written
using cached write, the value that was written with DMA may be
corrupted.

This commit changes ARCH_DMA_MINALIGN to be 128 on PA20 and 32 on PA1.1 -
that's the largest possible cache line size.

As different parisc microarchitectures have different cache line size, we
define arch_slab_minalign(), cache_line_size() and
dma_get_cache_alignment() so that the kernel may tune slab cache
parameters dynamically, based on the detected cache line size.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 arch/parisc/Kconfig             |  1 +
 arch/parisc/include/asm/cache.h | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 3341d4a42199..3a32b49d7ad0 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -18,6 +18,7 @@ config PARISC
 	select ARCH_SUPPORTS_HUGETLBFS if PA20
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_STACKWALK
+	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select HAVE_RELIABLE_STACKTRACE
 	select DMA_OPS
diff --git a/arch/parisc/include/asm/cache.h b/arch/parisc/include/asm/cache.h
index e23d06b51a20..91e753f08eaa 100644
--- a/arch/parisc/include/asm/cache.h
+++ b/arch/parisc/include/asm/cache.h
@@ -20,7 +20,16 @@
 
 #define SMP_CACHE_BYTES L1_CACHE_BYTES
 
-#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
+#ifdef CONFIG_PA20
+#define ARCH_DMA_MINALIGN	128
+#else
+#define ARCH_DMA_MINALIGN	32
+#endif
+#define ARCH_KMALLOC_MINALIGN	16	/* ldcw requires 16-byte alignment */
+
+#define arch_slab_minalign()	((unsigned)dcache_stride)
+#define cache_line_size()	dcache_stride
+#define dma_get_cache_alignment cache_line_size
 
 #define __read_mostly __section(".data..read_mostly")
 
-- 
2.43.0


