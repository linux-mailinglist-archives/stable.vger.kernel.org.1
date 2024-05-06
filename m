Return-Path: <stable+bounces-43111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 572BD8BCC7D
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 12:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67D71F219B6
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 10:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86D8142635;
	Mon,  6 May 2024 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X1mcCIgN"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DAC1422C5
	for <stable@vger.kernel.org>; Mon,  6 May 2024 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714993053; cv=none; b=KcJ+q+mKryofkfF7osoFOca67Ad0mwF7prIudh4TDV0FlZt7ZlRZF6K3SmEKVVwFfQ3L4ZBj7MmAaEmLW0qyHmIi741jO4/vzOlFFylQ1PcnE7GY9M4tL4BlXCaNIjy9SK/3sqhFM+JKQdBYDKL7CckQydeW/jVrSP8yRG/FIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714993053; c=relaxed/simple;
	bh=BWTdDi02i6Ihtu+xwYz3aHWha0D2f1z6D+NtRZVh7I0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=meIyiTtVrfUd+GFxYFkWliIHP4hGNfGHC5TM1PZWO67cxBM6jS7GlB6vO71/T/+B0FvYc85ems1y6euR9Jb8QRqRCNe43hy4moNtrUcgSIUohOFbIsCbG/zst4wGTszroq8R8H6EjIA2XPCWyi3xXAyOh+SGg9uU7MB9vhs5QS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X1mcCIgN; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446ApLOg010282;
	Mon, 6 May 2024 10:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=BR5TG0ODuKb8Uoa9lsjUT73fwK8Mls1hiPcfcGKfXJ0=;
 b=X1mcCIgNX4DneABAwtetrQIzzkISqZnEE97BViFXRICauk3/ehZbu6PS2HoUSG/S7LRQ
 BE6RyUJp4esq7Q9xe39fGjdWJUH7s5Bxe2VJ8HXj9I10H5NJ0bdhJsKsWUSkDtVflmh8
 PebAdj8DnlzTgziOr6i2pOTYww/Naew+RF2JI7JVcG5HIpLnuHYLqUiXKB0FEM7F9aTe
 5jwXME7nicxlkpLMr77LXl6vc5Bvny5mK/FA5s7CKnI0/VgRl1IytVSBVVPnxgla+Ywh
 CTUuG84r3DVR99RHOeOBOs6KzIJRKaZWIhdAm3Snl3QZHHSdc4KDHeQj4jbiGIqZ3pcL rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbxctbjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 10:57:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446AtDVs040871;
	Mon, 6 May 2024 10:57:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf5pt07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 10:57:27 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 446AvQTA035243;
	Mon, 6 May 2024 10:57:26 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xwbf5psyk-1;
	Mon, 06 May 2024 10:57:26 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: shuah@kernel.org, sashal@kernel.org, vegard.nossum@oracle.com,
        darren.kenny@oracle.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 4.19.y] Revert "selftests: mm: fix map_hugetlb failure on 64K page size systems"
Date: Mon,  6 May 2024 03:57:24 -0700
Message-ID: <20240506105724.3068232-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2024-05-06_07,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405060075
X-Proofpoint-GUID: ESHpl3kUnFNUtHbpttlqr1zxEgYQY9C1
X-Proofpoint-ORIG-GUID: ESHpl3kUnFNUtHbpttlqr1zxEgYQY9C1

This reverts commit abdbd5f3e8c504d864fdc032dd5a4eb481cb12bf.

map_hugetlb.c:18:10: fatal error: vm_util.h: No such file or directory
   18 | #include "vm_util.h"
      |          ^~~~~~~~~~~
compilation terminated.

vm_util.h is not present in 4.19.y, as commit:642bc52aed9c ("selftests:
vm: bring common functions to a new file") is not present in stable
kernels <=6.1.y

Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This can't be tested on 4.19.y as the selftests for vm/ are not
compiled since 4.19.17. I have bisected it to this one, commit:
7696248f9b5a ("selftests: Fix test errors related to lib.mk khdr
target"), the reason for reverting it on 4.19.y is to keep 4.19.y in
sync with higher stable trees(i.e reverts are sent to 5.4.y, 5.10.y and
5.15.y)
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


