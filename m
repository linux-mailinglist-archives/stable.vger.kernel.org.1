Return-Path: <stable+bounces-86676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDBB9A2C1F
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 20:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F3F283C17
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 18:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4081DFE25;
	Thu, 17 Oct 2024 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JKt7cyUS"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1321D31B8;
	Thu, 17 Oct 2024 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189586; cv=none; b=biE1gAKSkfxJGA5T2f4yBK867XfxLXJ/8gwVtTRV+k37L5A4Mz6NJnKCJB9YA8tvV+44efC6rNuqW8Xyk2/kViluDdf3BJP8NLbx5OElAhw5i4MhuIcduszDFmWiM6HUs6L4v9Rp18c/55Jo7bInurd87tsrZlQeN1Vcbe4iSfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189586; c=relaxed/simple;
	bh=w/Dgu9o7SlfhJAtPg0nuc7bjd6Jh+zhUqS2RN9TXNMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eojry6tvpTqIfY/AHEmR8SNVBnuL/vcJDag1vzdHXbwqeOETRwFaNd6du0YcMnwvK1dpHx2KJ6J47zZ0y+UYOoxqiYxLdo+q67UjfoiRWfx8dQyI8PSQw3Xb58Re6KErQBBVeql6yrvLPugMHxmR6/J2yLS+wUzHN5nJ1qdMn9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JKt7cyUS; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBvLG024516;
	Thu, 17 Oct 2024 18:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=fWhCJkkh43jAIW4BYl88J+uvVKlUU
	73T3cJn6QFcM9Y=; b=JKt7cyUSc+tOxKzK0r3I0fBP8NtTWyL+eFkmaPlC5Nfln
	AUCnKhDwiJNY6ZO4vvJOpD8m1egjoUIeg3MGM5RUhj+8Sphy2rjF0T3vFIROFXkr
	qcCVEHfvOAZNCJuoVIeqWf82bkN6YuhAyMnlwFoj4ZVuaQJ3UuCMMZLLRqW2gj3Z
	GtgTvRxB3nt/q5SRtK2gAFwr4CD4P2M1KSWku6KAbfrZsASThoniaM37wmS3IQpI
	XgRNodh3/+JlZE6blxXCviIUAGiO9t76x8+X9jMYyGqZ0zy5OL5x3KadLRdrDuXt
	sH4My1IYSNhrS3Bp3mVj4MrxqRmeCWwnQfMCKNK8A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcpqgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 18:26:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HI05fv013876;
	Thu, 17 Oct 2024 18:26:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjakuan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 18:26:11 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49HIQAdl037718;
	Thu, 17 Oct 2024 18:26:10 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 427fjaku9n-1;
	Thu, 17 Oct 2024 18:26:10 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To: 
Cc: saeed.mirzamohammadi@oracle.com, Mikulas Patocka <mpatocka@redhat.com>,
        stable@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 5.15 1/1] dm-crypt, dm-verity: disable tasklets
Date: Thu, 17 Oct 2024 11:26:02 -0700
Message-ID: <20241017182605.2049765-1-saeed.mirzamohammadi@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_20,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170125
X-Proofpoint-GUID: i5OHYiGkQHTIONtX5ZQYxPk8wUsgj40a
X-Proofpoint-ORIG-GUID: i5OHYiGkQHTIONtX5ZQYxPk8wUsgj40a

From: Mikulas Patocka <mpatocka@redhat.com>

commit 0a9bab391e336489169b95cb0d4553d921302189 upstream.

Tasklets have an inherent problem with memory corruption. The function
tasklet_action_common calls tasklet_trylock, then it calls the tasklet
callback and then it calls tasklet_unlock. If the tasklet callback frees
the structure that contains the tasklet or if it calls some code that may
free it, tasklet_unlock will write into free memory.

The commits 8e14f610159d and d9a02e016aaf try to fix it for dm-crypt, but
it is not a sufficient fix and the data corruption can still happen [1].
There is no fix for dm-verity and dm-verity will write into free memory
with every tasklet-processed bio.

There will be atomic workqueues implemented in the kernel 6.9 [2]. They
will have better interface and they will not suffer from the memory
corruption problem.

But we need something that stops the memory corruption now and that can be
backported to the stable kernels. So, I'm proposing this commit that
disables tasklets in both dm-crypt and dm-verity. This commit doesn't
remove the tasklet support, because the tasklet code will be reused when
atomic workqueues will be implemented.

[1] https://lore.kernel.org/all/d390d7ee-f142-44d3-822a-87949e14608b@suse.de/T/
[2] https://lore.kernel.org/lkml/20240130091300.2968534-1-tj@kernel.org/

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 39d42fa96ba1b ("dm crypt: add flags to optionally bypass kcryptd workqueues")
Fixes: 5721d4e5a9cdb ("dm verity: Add optional "try_verify_in_tasklet" feature")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 30884a44e0cedc3dfda8c22432f3ba4078ec2d94)
Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
---
 drivers/md/dm-crypt.c | 37 ++-----------------------------------
 1 file changed, 2 insertions(+), 35 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 9889035c343e3..95b3b69a5e3c4 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -69,10 +69,8 @@ struct dm_crypt_io {
 	struct bio *base_bio;
 	u8 *integrity_metadata;
 	bool integrity_metadata_from_pool:1;
-	bool in_tasklet:1;
 
 	struct work_struct work;
-	struct tasklet_struct tasklet;
 
 	struct convert_context ctx;
 
@@ -1769,7 +1767,6 @@ static void crypt_io_init(struct dm_crypt_io *io, struct crypt_config *cc,
 	io->ctx.r.req = NULL;
 	io->integrity_metadata = NULL;
 	io->integrity_metadata_from_pool = false;
-	io->in_tasklet = false;
 	atomic_set(&io->io_pending, 0);
 }
 
@@ -1778,12 +1775,6 @@ static void crypt_inc_pending(struct dm_crypt_io *io)
 	atomic_inc(&io->io_pending);
 }
 
-static void kcryptd_io_bio_endio(struct work_struct *work)
-{
-	struct dm_crypt_io *io = container_of(work, struct dm_crypt_io, work);
-	bio_endio(io->base_bio);
-}
-
 /*
  * One of the bios was finished. Check for completion of
  * the whole request and correctly clean up the buffer.
@@ -1807,20 +1798,6 @@ static void crypt_dec_pending(struct dm_crypt_io *io)
 
 	base_bio->bi_status = error;
 
-	/*
-	 * If we are running this function from our tasklet,
-	 * we can't call bio_endio() here, because it will call
-	 * clone_endio() from dm.c, which in turn will
-	 * free the current struct dm_crypt_io structure with
-	 * our tasklet. In this case we need to delay bio_endio()
-	 * execution to after the tasklet is done and dequeued.
-	 */
-	if (io->in_tasklet) {
-		INIT_WORK(&io->work, kcryptd_io_bio_endio);
-		queue_work(cc->io_queue, &io->work);
-		return;
-	}
-
 	bio_endio(base_bio);
 }
 
@@ -2264,11 +2241,6 @@ static void kcryptd_crypt(struct work_struct *work)
 		kcryptd_crypt_write_convert(io);
 }
 
-static void kcryptd_crypt_tasklet(unsigned long work)
-{
-	kcryptd_crypt((struct work_struct *)work);
-}
-
 static void kcryptd_queue_crypt(struct dm_crypt_io *io)
 {
 	struct crypt_config *cc = io->cc;
@@ -2280,15 +2252,10 @@ static void kcryptd_queue_crypt(struct dm_crypt_io *io)
 		 * irqs_disabled(): the kernel may run some IO completion from the idle thread, but
 		 * it is being executed with irqs disabled.
 		 */
-		if (in_hardirq() || irqs_disabled()) {
-			io->in_tasklet = true;
-			tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
-			tasklet_schedule(&io->tasklet);
+		if (!(in_hardirq() || irqs_disabled())) {
+			kcryptd_crypt(&io->work);
 			return;
 		}
-
-		kcryptd_crypt(&io->work);
-		return;
 	}
 
 	INIT_WORK(&io->work, kcryptd_crypt);
-- 
2.46.0


