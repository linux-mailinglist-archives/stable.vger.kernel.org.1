Return-Path: <stable+bounces-43109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C168BCA0A
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 10:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22361F210BA
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 08:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF2C1420BB;
	Mon,  6 May 2024 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n35NfX03"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B161D547
	for <stable@vger.kernel.org>; Mon,  6 May 2024 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985452; cv=none; b=sEyNn2xrpwmYpqHKfWRisdB7IuQRnjMrbbEcJF+yUhNPWWvvS/GIi6oC3f57Azv7yA6UvirYj0yfnKt1ZSDteO0RgbbCuUM//ygPSDKZiZe69RxB7nETq7QP+gMXpyxGVCDNDsHOHlvljiHTBQpFAe4p9R0Wgq5AJTgVLn4Ta5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985452; c=relaxed/simple;
	bh=KPkHaBOS5vasTOfgCqs2m6mq/CztVpVk2FaYadw8hEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NwkIaMqeJDPMktTUmyQpSdVNKOzZlROsOu3PbVK9TI4OXOuH5jA0Jo71K8BVt/Geie06e1Vz6XJx9PuRzVehXesHGxnzOcnOY6XYnmT9Mh85Adxu+ZYkBOSYQkB+LUOq8mr6YMQovuHZiLcP3TIeZDO81vlX/U05HzQVnaeHUEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n35NfX03; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4460B4JC008141;
	Mon, 6 May 2024 08:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=lpwRwa3YPPETvSFvwvrh2KXhBzU2NZA9Hn9HQb3k9Q4=;
 b=n35NfX03aoF+fHVhBDbcRcPz4Kpj6xrHmc2/kUd7yvrh68icexvRnnmq/44IpttlRm2a
 2DHOsecMATMzleb33+aiLSpoofgrpXYtg597jhzjGBvEjCGtMtGG0k3PslU/n72cg75t
 06ZhftgOIjF7vRPrrEOHIhSSqO42K8XwRjPqQdqgtumqaB56WSqduc9rJYOwDJyxWhBK
 FmZkZXf73+lDN7U+C52ElsE7P/AtyBHWZss0w1OPa3VX6m2JFrnR0d3kr1l+niyfxXIK
 40hYbfzjIO1e/1PupHbcZDT3wAYZRx7dmqnHbs3mTMWSjcItWBov/qGR3PAH601i8Jpj XQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwdjut377-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 08:50:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44671MLl014066;
	Mon, 6 May 2024 08:50:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf5p27y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 08:50:47 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4468m1mG010047;
	Mon, 6 May 2024 08:50:46 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xwbf5p27m-1;
	Mon, 06 May 2024 08:50:46 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org, vegard.nossum@oracle.com, darren.kenny@oracle.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.4.y] Revert "selftests: mm: fix map_hugetlb failure on 64K page size systems"
Date: Mon,  6 May 2024 01:50:44 -0700
Message-ID: <20240506085044.2943648-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_05,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060059
X-Proofpoint-ORIG-GUID: p66S61sR3q6eKghQ6LNkwoYHcHPpx58N
X-Proofpoint-GUID: p66S61sR3q6eKghQ6LNkwoYHcHPpx58N

This reverts commit 47c68edecca26f0e29b25d26500afd62279951b0.

map_hugetlb.c:18:10: fatal error: vm_util.h: No such file or directory
   18 | #include "vm_util.h"
      |          ^~~~~~~~~~~
compilation terminated.

vm_util.h is not present in 5.4.y, as commit:642bc52aed9c ("selftests:
vm: bring common functions to a new file") is not present in stable
kernels <=6.1.y

Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 tools/testing/selftests/vm/map_hugetlb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/selftests/vm/map_hugetlb.c
index c65c55b7a789..312889edb84a 100644
--- a/tools/testing/selftests/vm/map_hugetlb.c
+++ b/tools/testing/selftests/vm/map_hugetlb.c
@@ -15,7 +15,6 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <fcntl.h>
-#include "vm_util.h"
 
 #define LENGTH (256UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
@@ -71,16 +70,10 @@ int main(int argc, char **argv)
 {
 	void *addr;
 	int ret;
-	size_t hugepage_size;
 	size_t length = LENGTH;
 	int flags = FLAGS;
 	int shift = 0;
 
-	hugepage_size = default_huge_page_size();
-	/* munmap with fail if the length is not page aligned */
-	if (hugepage_size > length)
-		length = hugepage_size;
-
 	if (argc > 1)
 		length = atol(argv[1]) << 20;
 	if (argc > 2) {
-- 
2.34.1


