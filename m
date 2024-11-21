Return-Path: <stable+bounces-94480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5029D455A
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 02:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE861F21E89
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 01:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CBC70817;
	Thu, 21 Nov 2024 01:45:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59464D8C8
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 01:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732153531; cv=none; b=aWunEFvH9LqB5HjgI1EKAqZSetBBaYUMKMM++oGXtXv8M5eGOiZHn4VddZ4BiFBK9U/IhZmw3fBtJFlN0Gl9l05zTRvyFVJJw6fFOU3Ie0THr/rykGBBC/oQSEHjrZHi/T0HqUzcrVTErQ6UTThzTKDuarNPbk+OibMTHYtoEMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732153531; c=relaxed/simple;
	bh=g1kgMEpn4NrInc77plj2A9ftynKw6ec0GbIjoRU82sI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j4c5FjbelPN1ARDNaTwMRIEJ+u0u8apICB10oiLv2RdzgI4s1SLSXkI8OLZk7Lih/wH/PV7Z6qRXrIJqtggRDmd+MI/+f06oVza91mQElsTgs7UsnEfuqXBEBzBe4YwyepTzt7eRSUXqkuyitNG1mD2159U7t1iMfYHZihhKoJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL0Iv4P004357;
	Wed, 20 Nov 2024 17:45:17 -0800
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xqj7vy5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 20 Nov 2024 17:45:17 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 20 Nov 2024 17:45:17 -0800
Received: from pek-blan-cn-d1.wrs.com (128.224.34.185) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Wed, 20 Nov 2024 17:45:16 -0800
From: Bin Lan <bin.lan.cn@windriver.com>
To: <stable@vger.kernel.org>, <jammy_huang@aspeedtech.com>
Subject: [PATCH 6.1] media: aspeed: Fix memory overwrite if timing is 1600x900
Date: Thu, 21 Nov 2024 09:45:36 +0800
Message-ID: <20241121014536.3194104-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Txjqhk4xr2twNhGe5YjO8B39V4dzLOPK
X-Proofpoint-GUID: Txjqhk4xr2twNhGe5YjO8B39V4dzLOPK
X-Authority-Analysis: v=2.4 cv=Sb6ldeRu c=1 sm=1 tr=0 ts=673e90ad cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=VlfZXiiP6vEA:10 a=V2NxCb60AAAA:8 a=xOd6jRPJAAAA:8 a=t7CeM3EgAAAA:8 a=AqD73jItlG_pz5-PNZUA:9 a=3L6qF29SlnrayQqPM2jZ:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-20_22,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411210012

From: Jammy Huang <jammy_huang@aspeedtech.com>

[ Upstream commit c281355068bc258fd619c5aefd978595bede7bfe ]

When capturing 1600x900, system could crash when system memory usage is
tight.

The way to reproduce this issue:
1. Use 1600x900 to display on host
2. Mount ISO through 'Virtual media' on OpenBMC's web
3. Run script as below on host to do sha continuously
  #!/bin/bash
  while [ [1] ];
  do
	find /media -type f -printf '"%h/%f"\n' | xargs sha256sum
  done
4. Open KVM on OpenBMC's web

The size of macro block captured is 8x8. Therefore, we should make sure
the height of src-buf is 8 aligned to fix this issue.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 drivers/media/platform/aspeed/aspeed-video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
index 20f795ccc11b..c5af28bf0e96 100644
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -1047,7 +1047,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 static void aspeed_video_set_resolution(struct aspeed_video *video)
 {
 	struct v4l2_bt_timings *act = &video->active_timings;
-	unsigned int size = act->width * act->height;
+	unsigned int size = act->width * ALIGN(act->height, 8);
 
 	/* Set capture/compression frame sizes */
 	aspeed_video_calc_compressed_size(video, size);
@@ -1064,7 +1064,7 @@ static void aspeed_video_set_resolution(struct aspeed_video *video)
 		u32 width = ALIGN(act->width, 64);
 
 		aspeed_video_write(video, VE_CAP_WINDOW, width << 16 | act->height);
-		size = width * act->height;
+		size = width * ALIGN(act->height, 8);
 	} else {
 		aspeed_video_write(video, VE_CAP_WINDOW,
 				   act->width << 16 | act->height);
-- 
2.43.0


