Return-Path: <stable+bounces-43108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C09B8BC9FA
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 10:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA961C20298
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 08:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A694A1419BC;
	Mon,  6 May 2024 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n2D/QBvC"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DDB1D547
	for <stable@vger.kernel.org>; Mon,  6 May 2024 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985375; cv=none; b=UCnTwcvQsSqFwFmJ/h+DTYIDo/jPSySWyBfdtD9KJV2Fuq7X0jVFZYLd+zx4zKq7bi/RwBtlVC/ezvTKqrUgY6/E0AkgMnlT/2I8MpFz8V9j0oVReFGgOltILHs47DjqOGH4ewUBDFb5u0Sym5vpQbY2OSoj91vXL6S2RcLSnOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985375; c=relaxed/simple;
	bh=Gjuf3Zks61I9fiysnOcxB8RjMcKDEAsWjfiTt7GUVTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=talWY3A1TTSaI1XYqZMlTXC6ZRikxurOhxbx6Xo3o1OYhwdtugolA8xOHN9a5/aw1TV+hCqfxGWWfGPpZPRvL749DtVk1bxvRR7+ZPhO0m/x++BbL1qB79dAkahIWGvBGVbop1gmT5x4vCgAiyAMR5Hv7/T4sosCHT2CBvB36Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n2D/QBvC; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4460lcTd016247;
	Mon, 6 May 2024 08:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=HYV+ATKCn3h+Y8dJ7DBlYY5T86jDMx9r6ZmFNQfmSdU=;
 b=n2D/QBvCzgyM0jRyQkfCtvjQULewXFJdiVYDpEuk+gGQxVd6gnlEL7DbzCqEczrPWd2t
 peZI8DI9/+YrIuqiWDVKKSxUaR+IADg/BJ6jd5+SR3UXcBcVwQWtCuCauqIY4U5ZxOCq
 B/3lh0UBcpRJ8b0dXzv4cTX4SAjvQhcpIF8Hhh0tq3z274ArUHq855jR3n7SD7Ox2lVk
 akbvoZGP445tAnJuY7SOEXsryFZ9QGc+PcyUOrISgMrXP6NpxxPa6Rtieo/oG/uprFsh
 jM/PqbzHT4JxHJZnylUnMdpIvFh7acpHbxqc5bGnPVfQ+KWMWZ69xw9VVAS74GTsY237 kw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwdjut35p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 08:49:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4467viqR039432;
	Mon, 6 May 2024 08:49:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf5b7su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 08:49:30 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4468klb1026968;
	Mon, 6 May 2024 08:49:30 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xwbf5b7sj-1;
	Mon, 06 May 2024 08:49:30 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org, vegard.nossum@oracle.com, darren.kenny@oracle.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.10.y] Revert "selftests: mm: fix map_hugetlb failure on 64K page size systems"
Date: Mon,  6 May 2024 01:49:26 -0700
Message-ID: <20240506084926.2943076-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2024-05-06_04,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060058
X-Proofpoint-ORIG-GUID: HybPrFMvFGtJ6qUAn5kpkQzAxLtLqrmF
X-Proofpoint-GUID: HybPrFMvFGtJ6qUAn5kpkQzAxLtLqrmF

This reverts commit c9c3cc6a13bddc76bb533ad8147a5528cac5ba5a.

map_hugetlb.c:18:10: fatal error: vm_util.h: No such file or directory
   18 | #include "vm_util.h"
      |          ^~~~~~~~~~~
compilation terminated.

vm_util.h is not present in 5.10.y, as commit:642bc52aed9c ("selftests:
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


