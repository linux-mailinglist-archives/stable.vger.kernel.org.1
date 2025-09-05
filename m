Return-Path: <stable+bounces-177812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E94B455C2
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 13:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF58D3A1F56
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6CC341AB6;
	Fri,  5 Sep 2025 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SvaUZh5B"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF4F2F1FF3
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070598; cv=none; b=njhbkgRt2NKnRSOnGYG0afuBgpLfnqYq178Lm7MOVLofSGqCFWryJ1rHaxPOmHe88hemHNnFW7Q38Vuu1L4auooD1J3pbT+UuK3lYgyfapvZ8iMC+r6dUKqyruFOcZWQtSKRAcfR3ORdOcQ45qwLuC//HSq8pWji4RVeCdMyRtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070598; c=relaxed/simple;
	bh=ovB3FVSoVgKzi4G6t4tihz1CiYrV9B3YG4HTEo9QuGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ty68zIYpy7lgfD4Crfj+/3z8SYacm4Bnt3ZPhZfHrCuM31SM2n9JZJuwfE3lLWxUpMp+S7Ay6Darzafj9dvcpecYUm6a2BzGPkG87LWphJ+ZecofiYcizYe4dhjjj6m31K72irkM8iqFz/joeK7W8hl2/UNFkTKHMYZwmnrWakM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SvaUZh5B; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585AtwG3002819;
	Fri, 5 Sep 2025 11:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Cu7b9
	H78tVh702KyAf5geuvi9MVqtR3/6cBNH6iXRSg=; b=SvaUZh5BXp7MX5mMQQLyD
	SnxB2Sqj/OZh7IC+10qNfK4t/lEUeziRiEh0w/wXPw9fIZOLdaY5EjkhMB+vX2fB
	oth1HDm0CfxEpkGukkeaJ0+rDp6hVJ8kI6hcVe1TpLC44Xm5u+iTbS2zs/umFER1
	/Bpkb4bkziy+rxAkJIUoRCAosCkmlWKdpQ+TSx3Qrpo+ZN4zxI7nY9JnpVSdo9lW
	cb6Yhd4J86N4nMbmbJVFJM59fbztOfCt0bveXEvVhkv5P5QiywLelRtMepwcPSXx
	tHwG/M+P7xS7HzgdX5dUs+ekd5x+2aCDI+otFODr3QXk8ntB+3jP8P0vQhDKymRD
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ywqd8340-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:09:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5859JZKi019601;
	Fri, 5 Sep 2025 11:04:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrcqra8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:24 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585B49hQ030057;
	Fri, 5 Sep 2025 11:04:24 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrcqqux-9;
	Fri, 05 Sep 2025 11:04:23 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com, Zheng Qixing <zhengqixing@huawei.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 08/15] md/raid1,raid10: strip REQ_NOWAIT from member bios
Date: Fri,  5 Sep 2025 04:03:59 -0700
Message-ID: <20250905110406.3021567-9-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
References: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=962 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050108
X-Proofpoint-ORIG-GUID: QhBaSRlf9J6VzvHmmMpTP-0XBCocw_Mb
X-Authority-Analysis: v=2.4 cv=HuZ2G1TS c=1 sm=1 tr=0 ts=68bac4fc b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8
 a=yPCof4ZbAAAA:8 a=m0Z92-tOlLWyqIn2J5MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDA5NyBTYWx0ZWRfX07bnLaTou82I
 8Zy+8Wq5pfAG9puR0F6U2j0TDhS4kZ+Fvjvx5mhG2YexScYnjbZXE228Vax08NVjhGQcJr8b6+O
 DycpGLgar4uIixQ2+qNBEegd7fNMolliVGzJTyl4STnSQhpkAoNffKJkKNOodJSitYbExNAdNRO
 qq1qFrwdF1PjrBI1AL1+cd7SoHnKDwjNXgFlvyybMKibUnYoBSHGHbRwvXuCKmAMKHwZVd4Ar//
 voPQ00K09ciRqwFdBHsmvjbZKu4P5TJHO6x5s7PGiTKp2Vg9Oj8X8onha00mK2nCd47N0AlbVl4
 Isvn1hRQ2u+BK6qMceFNlfNQa84EpYsxs6IrIRI3aPANYDXIivyGwjD8X33UEmNisvecSNZzdxp
 eGy3dp4u
X-Proofpoint-GUID: QhBaSRlf9J6VzvHmmMpTP-0XBCocw_Mb

From: Zheng Qixing <zhengqixing@huawei.com>

[ Upstream commit 5fa31c49928139fa948f078b094d80f12ed83f5f ]

RAID layers don't implement proper non-blocking semantics for
REQ_NOWAIT, making the flag potentially misleading when propagated
to member disks.

This patch clear REQ_NOWAIT from cloned bios in raid1/raid10. Retain
original bio's REQ_NOWAIT flag for upper layer error handling.

Maybe we can implement non-blocking I/O handling mechanisms within
RAID in future work.

Fixes: 9f346f7d4ea7 ("md/raid1,raid10: don't handle IO error for
REQ_RAHEAD and REQ_NOWAIT")
Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
Link: https://lore.kernel.org/linux-raid/20250702102341.1969154-1-zhengqixing@huaweicloud.com
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
(cherry picked from commit 5fa31c49928139fa948f078b094d80f12ed83f5f)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/md/raid1.c  | 3 ++-
 drivers/md/raid10.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 9581c94450a4..772486d70718 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1392,7 +1392,7 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	}
 	read_bio = bio_alloc_clone(mirror->rdev->bdev, bio, gfp,
 				   &mddev->bio_set);
-
+	read_bio->bi_opf &= ~REQ_NOWAIT;
 	r1_bio->bios[rdisk] = read_bio;
 
 	read_bio->bi_iter.bi_sector = r1_bio->sector +
@@ -1613,6 +1613,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 				wait_for_serialization(rdev, r1_bio);
 		}
 
+		mbio->bi_opf &= ~REQ_NOWAIT;
 		r1_bio->bios[i] = mbio;
 
 		mbio->bi_iter.bi_sector	= (r1_bio->sector + rdev->data_offset);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 0d475bb2a732..6579bbb6a39a 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1218,6 +1218,7 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 		r10_bio->master_bio = bio;
 	}
 	read_bio = bio_alloc_clone(rdev->bdev, bio, gfp, &mddev->bio_set);
+	read_bio->bi_opf &= ~REQ_NOWAIT;
 
 	r10_bio->devs[slot].bio = read_bio;
 	r10_bio->devs[slot].rdev = rdev;
@@ -1248,6 +1249,7 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 			     conf->mirrors[devnum].rdev;
 
 	mbio = bio_alloc_clone(rdev->bdev, bio, GFP_NOIO, &mddev->bio_set);
+	mbio->bi_opf &= ~REQ_NOWAIT;
 	if (replacement)
 		r10_bio->devs[n_copy].repl_bio = mbio;
 	else
-- 
2.50.1


