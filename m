Return-Path: <stable+bounces-177804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCDFB455A7
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 13:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA11A5A6025
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F317340D91;
	Fri,  5 Sep 2025 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K8v0Crhz"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDBF321422
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070274; cv=none; b=K0EN6T4GCCVEmfg2oqplnJdc+1m0msmhv/57eZdFW3d7PAh9wURg3gtELyguQX5md744/WqbB0iTFe+JvOaQuIjxixShznKkpXpKWUcEn8KyE9lzxCzpIVvQUTBEdktc3zC9g7qSUJHJHG6FIvX+YiSy2Wvl4qQLQPsU0Qx5UAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070274; c=relaxed/simple;
	bh=VBN1i8qp9lnbHwHlajwsKMzR97lar5FO+VCDfhD/eIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDYTYVTwYg7d6b8zmlOchlxxiv5nPs68TpiC8oerattWWjeROTeQmlqLf007ucVQ4jW8hH6ZKChhVosmhI4ybuHrHkFmt6GEZoEYeHZo0VKWAzaQQcejTgRGpMpthudCvSmMDksmAyURrBxwpIj12EJjlNivn5cTxu6xgLwhq7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K8v0Crhz; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585AtqNR006200;
	Fri, 5 Sep 2025 11:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=P1U3t
	sus9RHMN4Iq4I9/IlSvMAs1HAlTDWzgeA0Dfqo=; b=K8v0CrhzYHbbnrJ1yyUBf
	efgq+ALaMC1JQ4XgxQ43b65zH+sftFqbsofThJAFAyv7RK7nNP+gupxPcYpQBNDK
	83pqPQH943f9bmBvzysr42gzIPYYay1khh/NsPO1VjTGlfiws0nxryL8PE1zKY0d
	yfp2n4GKSwZpUnNZWFkw5DYyP2qXhGLOFnOw7kvg+C74T5h0LchMxxgHyzGXIohu
	K+uq+qt7A4gydXqL2qvYWrhBq9GpP0shDcgBzU3siH715QZEkNKyXspqYdTUhOVM
	n3J5xwnDksVLcuhjcKLWaTV+tz5bYUX5NlR0E5mwDX6kzFa+G07CdzwWfCBnJVbM
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yxa5812c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5859Ja41019624;
	Fri, 5 Sep 2025 11:04:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrcqr8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:23 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585B49hO030057;
	Fri, 5 Sep 2025 11:04:22 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrcqqux-8;
	Fri, 05 Sep 2025 11:04:22 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com, Yu Kuai <yukuai3@huawei.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 07/15] md/raid1,raid10: don't handle IO error for REQ_RAHEAD and REQ_NOWAIT
Date: Fri,  5 Sep 2025 04:03:58 -0700
Message-ID: <20250905110406.3021567-8-harshit.m.mogalapalli@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=eJgTjGp1 c=1 sm=1 tr=0 ts=68bac3b8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=AiHppB-aAAAA:8
 a=i0EeH86SAAAA:8 a=yPCof4ZbAAAA:8 a=5su-0cyT5CHGojXRLjEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDEwNCBTYWx0ZWRfX6Up+LrWu+aXr
 knXGgBWWPS9WMK1KJFzGy9sbu1Ch1d8mAIE0sooRaHzZsISp8aAoLsN1N9nJItI/LYdjGtLtqya
 2sooZ8Ybcn/N34h6kbLvAzfrvBSHysZPX3uZtUQA2QwsOMbScKOTzHqeZ7igsWzd7s67dIOPtI/
 dc/c7u7WuA3OKOQOH5w6TnFJkJVQcrGOo8GYaAHtAvxg4vtLKAIW74lE0jZy+WGhPQ6+BsGxyQC
 uDG0haJ7HRX/KZn1F3q30zovRvCvtHXXG72q/MUfVNa3nhfZzFKQqcMOyAscvJhZK7RvaZj1hKc
 3nxoesLGLNF+kj4qnb9S9tqAkwVK/rHg/bUmarLl34/i08xxrHS/AdAf+2nNihlnPfTV44XCcAI
 aEZgmeUc
X-Proofpoint-ORIG-GUID: blfmnCUI4Vvw5dF5ORD8g_g6qM2RkScS
X-Proofpoint-GUID: blfmnCUI4Vvw5dF5ORD8g_g6qM2RkScS

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 9f346f7d4ea73692b82f5102ca8698e4040469ea ]

IO with REQ_RAHEAD or REQ_NOWAIT can fail early, even if the storage medium
is fine, hence record badblocks or remove the disk from array does not
make sense.

This problem if found by lvm2 test lvcreate-large-raid, where dm-zero
will fail read ahead IO directly.

Fixes: e879a0d9cb08 ("md/raid1,raid10: don't ignore IO flags")
Reported-and-tested-by: Mikulas Patocka <mpatocka@redhat.com>
Closes: https://lore.kernel.org/all/34fa755d-62c8-4588-8ee1-33cb1249bdf2@redhat.com/
Link: https://lore.kernel.org/linux-raid/20250527081407.3004055-1-yukuai1@huaweicloud.com
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
(cherry picked from commit 9f346f7d4ea73692b82f5102ca8698e4040469ea)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/md/raid1-10.c | 10 ++++++++++
 drivers/md/raid1.c    | 19 ++++++++++---------
 drivers/md/raid10.c   | 11 ++++++-----
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 4378d3250bd7..f3750ceaa582 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -293,3 +293,13 @@ static inline bool raid1_should_read_first(struct mddev *mddev,
 
 	return false;
 }
+
+/*
+ * bio with REQ_RAHEAD or REQ_NOWAIT can fail at anytime, before such IO is
+ * submitted to the underlying disks, hence don't record badblocks or retry
+ * in this case.
+ */
+static inline bool raid1_should_handle_error(struct bio *bio)
+{
+	return !(bio->bi_opf & (REQ_RAHEAD | REQ_NOWAIT));
+}
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 6e93e3b6bd8c..9581c94450a4 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -371,14 +371,16 @@ static void raid1_end_read_request(struct bio *bio)
 	 */
 	update_head_pos(r1_bio->read_disk, r1_bio);
 
-	if (uptodate)
+	if (uptodate) {
 		set_bit(R1BIO_Uptodate, &r1_bio->state);
-	else if (test_bit(FailFast, &rdev->flags) &&
-		 test_bit(R1BIO_FailFast, &r1_bio->state))
+	} else if (test_bit(FailFast, &rdev->flags) &&
+		 test_bit(R1BIO_FailFast, &r1_bio->state)) {
 		/* This was a fail-fast read so we definitely
 		 * want to retry */
 		;
-	else {
+	} else if (!raid1_should_handle_error(bio)) {
+		uptodate = 1;
+	} else {
 		/* If all other devices have failed, we want to return
 		 * the error upwards rather than fail the last device.
 		 * Here we redefine "uptodate" to mean "Don't want to retry"
@@ -449,16 +451,15 @@ static void raid1_end_write_request(struct bio *bio)
 	struct bio *to_put = NULL;
 	int mirror = find_bio_disk(r1_bio, bio);
 	struct md_rdev *rdev = conf->mirrors[mirror].rdev;
-	bool discard_error;
 	sector_t lo = r1_bio->sector;
 	sector_t hi = r1_bio->sector + r1_bio->sectors;
-
-	discard_error = bio->bi_status && bio_op(bio) == REQ_OP_DISCARD;
+	bool ignore_error = !raid1_should_handle_error(bio) ||
+		(bio->bi_status && bio_op(bio) == REQ_OP_DISCARD);
 
 	/*
 	 * 'one mirror IO has finished' event handler:
 	 */
-	if (bio->bi_status && !discard_error) {
+	if (bio->bi_status && !ignore_error) {
 		set_bit(WriteErrorSeen,	&rdev->flags);
 		if (!test_and_set_bit(WantReplacement, &rdev->flags))
 			set_bit(MD_RECOVERY_NEEDED, &
@@ -509,7 +510,7 @@ static void raid1_end_write_request(struct bio *bio)
 
 		/* Maybe we can clear some bad blocks. */
 		if (rdev_has_badblock(rdev, r1_bio->sector, r1_bio->sectors) &&
-		    !discard_error) {
+		    !ignore_error) {
 			r1_bio->bios[mirror] = IO_MADE_GOOD;
 			set_bit(R1BIO_MadeGood, &r1_bio->state);
 		}
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 8bb9ec39dc4f..0d475bb2a732 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -398,6 +398,8 @@ static void raid10_end_read_request(struct bio *bio)
 		 * wait for the 'master' bio.
 		 */
 		set_bit(R10BIO_Uptodate, &r10_bio->state);
+	} else if (!raid1_should_handle_error(bio)) {
+		uptodate = 1;
 	} else {
 		/* If all other devices that store this block have
 		 * failed, we want to return the error upwards rather
@@ -455,9 +457,8 @@ static void raid10_end_write_request(struct bio *bio)
 	int slot, repl;
 	struct md_rdev *rdev = NULL;
 	struct bio *to_put = NULL;
-	bool discard_error;
-
-	discard_error = bio->bi_status && bio_op(bio) == REQ_OP_DISCARD;
+	bool ignore_error = !raid1_should_handle_error(bio) ||
+		(bio->bi_status && bio_op(bio) == REQ_OP_DISCARD);
 
 	dev = find_bio_disk(conf, r10_bio, bio, &slot, &repl);
 
@@ -471,7 +472,7 @@ static void raid10_end_write_request(struct bio *bio)
 	/*
 	 * this branch is our 'one mirror IO has finished' event handler:
 	 */
-	if (bio->bi_status && !discard_error) {
+	if (bio->bi_status && !ignore_error) {
 		if (repl)
 			/* Never record new bad blocks to replacement,
 			 * just fail it.
@@ -526,7 +527,7 @@ static void raid10_end_write_request(struct bio *bio)
 		/* Maybe we can clear some bad blocks. */
 		if (rdev_has_badblock(rdev, r10_bio->devs[slot].addr,
 				      r10_bio->sectors) &&
-		    !discard_error) {
+		    !ignore_error) {
 			bio_put(bio);
 			if (repl)
 				r10_bio->devs[slot].repl_bio = IO_MADE_GOOD;
-- 
2.50.1


