Return-Path: <stable+bounces-95929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C40F9DFB8A
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 08:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5B1163BA3
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 07:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC4A1F9ABE;
	Mon,  2 Dec 2024 07:56:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E613D1F943D
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126204; cv=none; b=Y6zbgfu2NePn5TUzaEgpjyhdohnVKmDuclEuC4WvfDepxH08AsaSS0sdllAO5IosPYaMHDuQuqzsFDFBb9WjrbNAo//cIf/H/khjaCAaQo+8zoShblKMkRIB7ZnG4lUg4d0a7tEPE3wj3eY1NtvhD2SxJ8+vxwvtsEuR9IMO7yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126204; c=relaxed/simple;
	bh=NMwi5a7CHZjL22gQHcOPrQSBL+zkSlm1VcpsJZU9Or0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UeoBOJb3edb5KdMEFfIYMPdIRmUgDLWBS9R3zROlI8rrZI9P23ynDLpcRY+ZTvV8khB4V4AiL42gscjcahDyhL9PtwN6srargKwaWMxL/4i5egieXKlvGyGP1J4WvFFLOSf7GqaFaR0TZDLe1UryDL22pVr6HivxMnKmR7MMGA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B27ABI9019916
	for <stable@vger.kernel.org>; Mon, 2 Dec 2024 07:56:35 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 437qx11s0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Dec 2024 07:56:34 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Sun, 1 Dec 2024 23:56:33 -0800
Received: from pek-lpg-core4.wrs.com (128.224.153.44) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Sun, 1 Dec 2024 23:56:33 -0800
From: <mingli.yu@eng.windriver.com>
To: <stable@vger.kernel.org>
Subject: [PATCH 5.15] parisc: fix a possible DMA corruption
Date: Mon, 2 Dec 2024 15:56:32 +0800
Message-ID: <20241202075632.2442890-1-mingli.yu@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: MHYUdsUYDVZLcSHd8DTie4OXJqAXg58H
X-Authority-Analysis: v=2.4 cv=EuYorTcA c=1 sm=1 tr=0 ts=674d6832 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=RZcAm9yDv7YA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=YlDBPuehlc0bO2GpeZkA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: MHYUdsUYDVZLcSHd8DTie4OXJqAXg58H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_04,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 adultscore=0 mlxscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412020069

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 7ae04ba36b381bffe2471eff3a93edced843240f]

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
Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
---
 arch/parisc/Kconfig             |  1 +
 arch/parisc/include/asm/cache.h | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 6ac0c4b98e28..9888e0b3f675 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -15,6 +15,7 @@ config PARISC
 	select ARCH_SPLIT_ARG64 if !64BIT
 	select ARCH_SUPPORTS_HUGETLBFS if PA20
 	select ARCH_SUPPORTS_MEMORY_FAILURE
+	select ARCH_HAS_CACHE_LINE_SIZE
 	select DMA_OPS
 	select RTC_CLASS
 	select RTC_DRV_GENERIC
diff --git a/arch/parisc/include/asm/cache.h b/arch/parisc/include/asm/cache.h
index d53e9e27dba0..99e26c686f7f 100644
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
2.34.1


