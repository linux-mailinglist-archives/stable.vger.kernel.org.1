Return-Path: <stable+bounces-95585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BB79DA1F6
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 07:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAC7284E0B
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 06:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E11F13D89D;
	Wed, 27 Nov 2024 06:04:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161E313AA3F
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732687444; cv=none; b=JfdyvbtAi6RLMKgOTPMuercValTGjygKN7i3VUiUkpcpROp6uSE/nPV6iO6OCWpneiuq8irfFYsvla4xS8RAAEVEOH0lud4e7n+kAxCsA22OCGm58U/RzsZKnhsCd/aHvX1UcoFz9G1nUs2Bn9I43T4WU6VcOe5rAzsKl606Kd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732687444; c=relaxed/simple;
	bh=oanSEIZoU8KDBdDbLDDNAqJFoFCBlU2vVQE5V0ZrFKI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s4A9oFS+5upaXWkfshey+JkT83wocMhgy4stOWRoDVmaWiEbu35KvTl520USoFpp/YmG4z6FKOpWqBLsi57plAn9DTvQltKdU+VG1XiGbAZbb86511DcS67GsZF7EmY/XO9ui6tYELxrLt6qdpkmlkcFGGZnyNSEa/ZRtlGNzts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR5gYAc015490;
	Wed, 27 Nov 2024 06:03:58 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433618c56e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 27 Nov 2024 06:03:58 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 26 Nov 2024 22:03:57 -0800
Received: from pek-lpg-core3.wrs.com (128.224.153.43) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 26 Nov 2024 22:03:55 -0800
From: Bin Lan <bin.lan.cn@windriver.com>
To: <stable@vger.kernel.org>, <mpatocka@redhat.com>
CC: <bin.lan.cn@windriver.com>
Subject: [PATCH 6.6] dm: fix a crash if blk_alloc_disk fails
Date: Wed, 27 Nov 2024 14:03:54 +0800
Message-ID: <20241127060354.2695746-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Rq00x67pU1E3-qNW55kHPxIqm77zELyB
X-Proofpoint-GUID: Rq00x67pU1E3-qNW55kHPxIqm77zELyB
X-Authority-Analysis: v=2.4 cv=O65rvw9W c=1 sm=1 tr=0 ts=6746b64e cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VlfZXiiP6vEA:10 a=gu6fZOg2AAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=t7CeM3EgAAAA:8
 a=CznjUHFP9-Q3qCXQxMMA:9 a=-FEs8UIgK8oA:10 a=2RSlZUUhi9gRBrsHwhhZ:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-27_02,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411270049

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit fed13a5478680614ba97fc87e71f16e2e197912e ]

If blk_alloc_disk fails, the variable md->disk is set to an error value.
cleanup_mapped_device will see that md->disk is non-NULL and it will
attempt to access it, causing a crash on this statement
"md->disk->private_data = NULL;".

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
Closes: https://marc.info/?l=dm-devel&m=172824125004329&w=2
Cc: stable@vger.kernel.org
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 drivers/md/dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 5dd0a42463a2..f45427291ea6 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2077,8 +2077,10 @@ static struct mapped_device *alloc_dev(int minor)
 	 * override accordingly.
 	 */
 	md->disk = blk_alloc_disk(md->numa_node_id);
-	if (!md->disk)
+	if (!md->disk){
+		md->disk = NULL;
 		goto bad;
+	}
 	md->queue = md->disk->queue;
 
 	init_waitqueue_head(&md->wait);
-- 
2.34.1


