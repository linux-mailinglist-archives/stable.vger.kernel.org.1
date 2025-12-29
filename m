Return-Path: <stable+bounces-203476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CC9CE6396
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 09:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7100330173B9
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 08:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834F923EAB4;
	Mon, 29 Dec 2025 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cigaM4vD"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDED1A9F84;
	Mon, 29 Dec 2025 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766996170; cv=none; b=tFRaLrCGlBnuMnRl7Y519yF4FERfyRufrABaoIKhuzFWEr0erq7JODWRLbbnTjZMTI9x40Q8HmE4fw6VBbz+eMDCJPHiCvVAzG9yMLvhfGnOmKYgERLCJqMeawHySv6l3Ys9i3kXXrwFKZ5uZnxTCu2ZWfC/Vd0kvX80hqlstZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766996170; c=relaxed/simple;
	bh=nCB/vq9GHemJ7H8kGdbP7b8VUFuOb3hndzc+d2kgi3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1B8J36BXigFFIZBY/g2ShV1+Eq6Z+YEZ7zgBtULCQJubhPIfbIrY9DckJNoHTsqdV4/+oiT1OfY8zki0WHVOU6VKOGjbXHfh1M4Kv8CTdOABtHvKbHJtiOFJom+PBJZhF9nokWCXk0AWtEyPo4FFAlBemYVeLCmVg6wi6xZSZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cigaM4vD; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BT4U3v91134126;
	Mon, 29 Dec 2025 08:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=T9FEo
	sqsn3CPvPl9QYE9L03k4E3xg3U5lG0eXv+pu6E=; b=cigaM4vDU+1HnfctNh1uZ
	O80M/IHq87scJvX4/Qbf2+DqWSL8UcVxHWPf781uatocx4idcLWks2xvAfrSIET7
	SX0mcjr85hOmvAY94uYbBvdmphFiq3yLnSUYOoqLLTFkMMfn9NGmGgoeYcVSIxsM
	dmEUR0e3nfGry2QzDV+jD/0ZpmgLzmboV2BVH3BSFWvt5tJMnUgXC6URgsRDTVSG
	fLTucwxyVCOcBMgAFxQjCp1LszU738C0xTBdKAKf5weGm98WHHgCNL9Bz6PHToFe
	YFYTA24Pm0/X2TuNqPJu6WMM5/J+j/aoGibU6yEG26RNUzfGDkhfD3j/NFduDJ+Z
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba6c8scg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Dec 2025 08:15:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BT5hO90038371;
	Mon, 29 Dec 2025 08:15:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5w6xkev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Dec 2025 08:15:30 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BT8FReh007295;
	Mon, 29 Dec 2025 08:15:29 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ba5w6xkd1-2;
	Mon, 29 Dec 2025 08:15:29 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: zohar@linux.ibm.com
Cc: akpm@linux-foundation.org, ardb@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, graf@amazon.com,
        guoweikang.kernel@gmail.com, harshit.m.mogalapalli@oracle.com,
        henry.willard@oracle.com, hpa@zytor.com, jbohac@suse.cz,
        joel.granados@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, noodles@fb.com, paul.x.webb@oracle.com,
        rppt@kernel.org, sohil.mehta@intel.com, sourabhjain@linux.ibm.com,
        stable@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
        yifei.l.liu@oracle.com
Subject: [PATCH v2 1/3] ima: Add ima_validate_range() for previous kernel IMA buffer
Date: Mon, 29 Dec 2025 00:15:21 -0800
Message-ID: <20251229081523.622515-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251229081523.622515-1-harshit.m.mogalapalli@oracle.com>
References: <20251229081523.622515-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_02,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512290075
X-Authority-Analysis: v=2.4 cv=a4E9NESF c=1 sm=1 tr=0 ts=695238a3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=jkZM71ibJ-iyurowFaMA:9
X-Proofpoint-GUID: nuMDW7gWI9PBPqcyP_vtEXxKuHGNN8Yn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDA3NiBTYWx0ZWRfX51trV2daeV5H
 ugTnAP+AJM9y29it+riyzP91/0uD9q/DWPA4OdVV0Fv1zzx3a8YyAfZ0HmmfmLmqn0wXDF5xEUF
 CTXibOrtp3xceQnQB1njyZVII8ssrZRcA7csL/Os4T7pdJitg/M8gKHmu6eQrBKXth7H6JSUc3d
 l5Dl7VRwDCZpGn+PG7eVeyv8maSjAUV/0OOc7g6hhP9gL6mvK8+CAsNUmh/jP0sMSWGTUWjJaTO
 yg1+GhymgcA6FAzP5iWf8a4CBczZDPReJZTxOLv50Lnq3S86ymN1EiC6X9rK0lh0kHn/PH9ojb/
 RFbSBqKu/YFLKwW+aSrjxmONwWmzFTntqxQeQ9N0juk3d0YK8aoKkKSr2YFlZkosdNkkSCtx34X
 5DGB4qkzvzfg12DJtqr46vY6K6qLa2PnlQJp/1RuK8c7A3hLrTdOdkKCtxV09itCMG4y902kzlw
 +ajJ0FnmJ+R1dNX5D+g==
X-Proofpoint-ORIG-GUID: nuMDW7gWI9PBPqcyP_vtEXxKuHGNN8Yn

When the second-stage kernel is booted with a limiting command line
(e.g. "mem=<size>"), the IMA measurement buffer handed over from the
previous kernel may fall outside the addressable RAM of the new kernel.
Accessing such a buffer can fault during early restore.

Introduce a small generic helper, ima_validate_range(), which verifies
that a physical [start, end] range for the previous-kernel IMA buffer
lies within addressable memory:
	- On x86, use pfn_range_is_mapped().
	- On OF based architectures, use page_is_ram().

Cc: stable@vger.kernel.org
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 include/linux/ima.h                |  1 +
 security/integrity/ima/ima_kexec.c | 35 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 8e29cb4e6a01..abf8923f8fc5 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -69,6 +69,7 @@ static inline int ima_measure_critical_data(const char *event_label,
 #ifdef CONFIG_HAVE_IMA_KEXEC
 int __init ima_free_kexec_buffer(void);
 int __init ima_get_kexec_buffer(void **addr, size_t *size);
+int ima_validate_range(phys_addr_t phys, size_t size);
 #endif
 
 #ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 7362f68f2d8b..8b24e3312ea0 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -12,6 +12,8 @@
 #include <linux/kexec.h>
 #include <linux/of.h>
 #include <linux/ima.h>
+#include <linux/mm.h>
+#include <linux/overflow.h>
 #include <linux/reboot.h>
 #include <asm/page.h>
 #include "ima.h"
@@ -296,3 +298,36 @@ void __init ima_load_kexec_buffer(void)
 		pr_debug("Error restoring the measurement list: %d\n", rc);
 	}
 }
+
+/*
+ * ima_validate_range - verify a physical buffer lies in addressable RAM
+ * @phys: physical start address of the buffer from previous kernel
+ * @size: size of the buffer
+ *
+ * On success return 0. On failure returns -EINVAL so callers can skip
+ * restoring.
+ */
+int ima_validate_range(phys_addr_t phys, size_t size)
+{
+	unsigned long start_pfn, end_pfn;
+	phys_addr_t end_phys;
+
+	if (check_add_overflow(phys, (phys_addr_t)size - 1, &end_phys))
+		return -EINVAL;
+
+	start_pfn = PHYS_PFN(phys);
+	end_pfn = PHYS_PFN(end_phys);
+
+#ifdef CONFIG_X86
+	if (!pfn_range_is_mapped(start_pfn, end_pfn))
+#else
+	if (!page_is_ram(start_pfn) || !page_is_ram(end_pfn))
+#endif
+	{
+		pr_warn("IMA: previous kernel measurement buffer %pa (size 0x%zx) lies outside available memory\n",
+			&phys, size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
-- 
2.50.1


