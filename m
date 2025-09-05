Return-Path: <stable+bounces-177803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB4AB455A9
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 13:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDCEA03FB1
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D728D342CA5;
	Fri,  5 Sep 2025 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YzIg7hTj"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7798341AB6
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070271; cv=none; b=hZN8hPGWlDZ7tVHePjL4RJVTYWfwifEJEb6oq0bY8Gc7A6tYeRXD/2Pe+YU4wWmSSJngzBNxYnT+hsR5hcHpaMh39BjeS5GBDzH7BZaaXnE+7+4J3tzgiWvIzG0VlYIh7cz4KSUc2TCp7ZJHTFQUCDPiaDdW6AmxKKoGm2T4Kvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070271; c=relaxed/simple;
	bh=kiAjhSe/bXACyfZrlH8LBgK4XV8SqNpULF2+2MrVvx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFnnjgs9c3d1n5svmWMj7nYfQlcRVM/jr5E+nAT6vTHFY0cBMo41b3Wyw9q8dmo0Q6EeJiWGyZ7sCqznkDjBU9hQ1mwuA3p9mKkdWRZNQMNs0qMdSGiMT+OSW4FKt2iwrsMnBlsk5T+1yrIu3BVH6xiDCLpR27vJm5NwowJBGYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YzIg7hTj; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585AtjSg010278;
	Fri, 5 Sep 2025 11:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=hOQrX
	AS8/hR0NOvps1tfI9PYDYNuN8J4ZWu/3VVC45Q=; b=YzIg7hTjCT4Z4BFeZrSoK
	+G9tQzXNHlck0XBoEH7Xzvt9Q6+NXiio/75o5iv1KRq+AJaosADoCA9N83NAGZeZ
	uX82nA5gMvO6uvndaOs2gO3GigDjIQBZnb6LK6rxlSum/yJ4YlcZ/TzlsxllZ0LT
	iv/U7XlEeCso1PaOk4VUpFpM1po53ichlodO/YGbGAjsko7npSIzo2EdJ1U9eq6P
	yuXCdoyCg3FJw9n5GKYdyEkwCrC1EzGW4PmSJVJts54YqMBNt0pLzUjbOsvDbS0a
	1zoapgOjYLvdkLVqcQRg4lz3xvCy8dZ1/4n4zahhSh+/eFdTQekyBInBlD3x2Zg3
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yx0u8224-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5859JaYV019633;
	Fri, 5 Sep 2025 11:04:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrcqr70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:21 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585B49hM030057;
	Fri, 5 Sep 2025 11:04:20 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrcqqux-7;
	Fri, 05 Sep 2025 11:04:20 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com, Yu Kuai <yukuai3@huawei.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 06/15] md/raid1,raid10: don't ignore IO flags
Date: Fri,  5 Sep 2025 04:03:57 -0700
Message-ID: <20250905110406.3021567-7-harshit.m.mogalapalli@oracle.com>
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
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDA5OSBTYWx0ZWRfX5wYz3EsODizm
 D6iBxn1Uiek2wqv1QAd3EaoGFqUQb4iB7/Qfsn1GWl9ypULICMFhSERn6CRmQpqXMN5jFLbs3mk
 dcsE/Zus3PCZCMEGXgtahJpVHOt41rVaSldwBPgVSV5Ssh1gcrgBd7WC1RizfSUqHTVMWZDWHtZ
 zv2QXYSfKGmgHSipfA4K4qMsqnGutrPlLfScB3RO59d16vPcJ0TnKnww6r8U3P0fETR3WoJI7a/
 NTcyAAmk45xVqUJOWbBoQHG+9+kTgcj/zOMHZaAI99tJfd7T6rAr6MHSDRKB07Pv+01BlYeUmsP
 3fUGGvkpKD4mT9a03moPq58ol25y4/d5IZzkWTVEb3TzOPRd5zQ2k1iWHrclfYh6S4qCi5OKl3F
 RBJN0VrD
X-Proofpoint-ORIG-GUID: l_T87hgEpRc8IZungWxerzgPFJNgZtNB
X-Authority-Analysis: v=2.4 cv=KIxaDEFo c=1 sm=1 tr=0 ts=68bac3b6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8
 a=yPCof4ZbAAAA:8 a=PtrhTkZuUpEr0TmlEGwA:9
X-Proofpoint-GUID: l_T87hgEpRc8IZungWxerzgPFJNgZtNB

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit e879a0d9cb086c8e52ce6c04e5bfa63825a6213c ]

If blk-wbt is enabled by default, it's found that raid write performance
is quite bad because all IO are throttled by wbt of underlying disks,
due to flag REQ_IDLE is ignored. And turns out this behaviour exist since
blk-wbt is introduced.

Other than REQ_IDLE, other flags should not be ignored as well, for
example REQ_META can be set for filesystems, clearing it can cause priority
reverse problems; And REQ_NOWAIT should not be cleared as well, because
io will wait instead of failing directly in underlying disks.

Fix those problems by keep IO flags from master bio.

Fises: f51d46d0e7cb ("md: add support for REQ_NOWAIT")
Fixes: e34cbd307477 ("blk-wbt: add general throttling mechanism")
Fixes: 5404bc7a87b9 ("[PATCH] Allow file systems to differentiate between data and meta reads")
Link: https://lore.kernel.org/linux-raid/20250227121657.832356-1-yukuai1@huaweicloud.com
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
(cherry picked from commit e879a0d9cb086c8e52ce6c04e5bfa63825a6213c)
[Harshit: Resolve conflicts due to missing commit: f2a38abf5f1c
("md/raid1: Atomic write support") and  commit: a1d9b4fd42d9
("md/raid10: Atomic write support") in 6.12.y, we don't have Atomic
writes feature in 6.12.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/md/raid1.c  | 4 ----
 drivers/md/raid10.c | 7 -------
 2 files changed, 11 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index fe1599db69c8..6e93e3b6bd8c 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1315,8 +1315,6 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	struct r1conf *conf = mddev->private;
 	struct raid1_info *mirror;
 	struct bio *read_bio;
-	const enum req_op op = bio_op(bio);
-	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
 	int max_sectors;
 	int rdisk;
 	bool r1bio_existed = !!r1_bio;
@@ -1399,7 +1397,6 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	read_bio->bi_iter.bi_sector = r1_bio->sector +
 		mirror->rdev->data_offset;
 	read_bio->bi_end_io = raid1_end_read_request;
-	read_bio->bi_opf = op | do_sync;
 	if (test_bit(FailFast, &mirror->rdev->flags) &&
 	    test_bit(R1BIO_FailFast, &r1_bio->state))
 	        read_bio->bi_opf |= MD_FAILFAST;
@@ -1619,7 +1616,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 
 		mbio->bi_iter.bi_sector	= (r1_bio->sector + rdev->data_offset);
 		mbio->bi_end_io	= raid1_end_write_request;
-		mbio->bi_opf = bio_op(bio) | (bio->bi_opf & (REQ_SYNC | REQ_FUA));
 		if (test_bit(FailFast, &rdev->flags) &&
 		    !test_bit(WriteMostly, &rdev->flags) &&
 		    conf->raid_disks - mddev->degraded > 1)
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 7515a98001ca..8bb9ec39dc4f 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1146,8 +1146,6 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 {
 	struct r10conf *conf = mddev->private;
 	struct bio *read_bio;
-	const enum req_op op = bio_op(bio);
-	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
 	int max_sectors;
 	struct md_rdev *rdev;
 	char b[BDEVNAME_SIZE];
@@ -1226,7 +1224,6 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 	read_bio->bi_iter.bi_sector = r10_bio->devs[slot].addr +
 		choose_data_offset(r10_bio, rdev);
 	read_bio->bi_end_io = raid10_end_read_request;
-	read_bio->bi_opf = op | do_sync;
 	if (test_bit(FailFast, &rdev->flags) &&
 	    test_bit(R10BIO_FailFast, &r10_bio->state))
 	        read_bio->bi_opf |= MD_FAILFAST;
@@ -1240,9 +1237,6 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 				  struct bio *bio, bool replacement,
 				  int n_copy)
 {
-	const enum req_op op = bio_op(bio);
-	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
-	const blk_opf_t do_fua = bio->bi_opf & REQ_FUA;
 	unsigned long flags;
 	struct r10conf *conf = mddev->private;
 	struct md_rdev *rdev;
@@ -1261,7 +1255,6 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 	mbio->bi_iter.bi_sector	= (r10_bio->devs[n_copy].addr +
 				   choose_data_offset(r10_bio, rdev));
 	mbio->bi_end_io	= raid10_end_write_request;
-	mbio->bi_opf = op | do_sync | do_fua;
 	if (!replacement && test_bit(FailFast,
 				     &conf->mirrors[devnum].rdev->flags)
 			 && enough(conf, devnum))
-- 
2.50.1


