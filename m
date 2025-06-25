Return-Path: <stable+bounces-158608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975E0AE88A7
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 17:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC6B3B9BA4
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F1F289823;
	Wed, 25 Jun 2025 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I1oH90op"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2CF27FD74
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866534; cv=none; b=pK1l8ODsFuZup8pTb9kZr9kdOAtDEy4qoy6EyczYqoSJYeZPkF3qL65kzJwxHFFnupdVLDKBTs3HtfHd8jlEn8uHu1HKBjVgRxtGAJcMUYZb0VJjWtGBE6xn6YQDeKgVCxao+axfS+RlkdeYOD4XeHt1OKOYvIt4HECczS6M6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866534; c=relaxed/simple;
	bh=2Uu0G2IjQDe3WvTMTwQQJJjicpv/lENTVFtvF9UWwmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HntQlED2RPWFfogrKdOvt0RGkXQQaqH9qpV7F5fTLYXlAAfp0P24dbnyPyzX5liDxWcSo36ALpVOOF5pWKZFX2yTBSy2f0foFmwDAsJwkVDMrmycAxJeZH9H4encZoSDqVzGefPoULWja8ouUBobXVu65Syo1twaLQsK/Y3xfpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I1oH90op; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PFC0cl020128;
	Wed, 25 Jun 2025 15:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=0cHp5Xws7m9IOlYpC+Khy2pFAIev3
	jcvmbM6kBaSOnE=; b=I1oH90opc0KOpHUPP2nOYb7yRUbx1VvmI8DmIVdnQyTZr
	6nca8lHc87dq8DSR129d854Mdijk3XufynK/O2x6rw238Ova96ACH+3LS6u82vR7
	WXpEbynQnneDDS6NBPA1m+y1z8QhA6aof4OjAegFbtAtdgMyTSadKoUZybnrro9V
	d3rJxOr6ft+kQedkr1qLpZlVCg9fIs1caEZ2iWcE7mU5hZWKj1D+PT8ZTmw96r+a
	2MmVXOnofJYaKSdg/7gLJN9sSJfDq2AcKxn2+4jAam9JgYRZrCYZwGIkwI6GDkCw
	A2Tg8PIvWduC77+In/ouMAxBP5KM7oQzTmvMILIeg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt7epxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 15:48:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55PEcZ8T012831;
	Wed, 25 Jun 2025 15:48:47 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ehvxrqb5-1;
	Wed, 25 Jun 2025 15:48:47 +0000
From: Larry Bassel <larry.bassel@oracle.com>
To: stable@vger.kernel.org
Cc: bigunclemax@gmail.com, hch@lst.de, axboe@kernel.dk
Subject: [PATCH 5.15.y] aoe: avoid potential deadlock at set_capacity
Date: Wed, 25 Jun 2025 08:48:18 -0700
Message-ID: <20250625154818.215991-1-larry.bassel@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_05,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506250117
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDExNiBTYWx0ZWRfX7gnpz41dUqvv m0PW7uFb0zSK4esZjS/RY1Wveu6Grcg4W1AQg09zp7obHLwmYFAAunl0nhbODIRF0lg2UnTMHQK 8rJ69RmB/sdCpexoB3SuRp3nI6yEZVdKMEo4SPrl1M4WSOdDEXYskxsJ2TyCmxn49uFgWmJjTuF
 h02BJDx9KAz6tGMboUUxiP2q8mEjDhKKRKoiYmBjSj0xrp+Q6iHQHgPMYUmARtCQ+TloQKVjp6L bsUwLzsWPvPoFm7JO7UyO1GG/mhWxEv13bIF8eet4xbKC8Cb5YEHYUg5dLK4hqYeKLkmO70kd3N 4jDrfnCDMyGu5qoq8NtywEv/dToQ6WXhodG9VG5EieXUmkkwwBU+Z63pgUrYuQdDmABYqha2iw8
 8xgYamuSavD2nLLuNCsg/fq61aaOpO43Bp2pYK8bQfkVn4Y6Ti5h9fZIy3lVu6wTqhG5HCMX
X-Proofpoint-GUID: rVQ-_x7XuJwC02EGiyL1C9AMH0jwULvJ
X-Authority-Analysis: v=2.4 cv=QNpoRhLL c=1 sm=1 tr=0 ts=685c1a5f b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=0jkyOMBtfAB3wNEroywA:9 cc=ntf awl=host:14723
X-Proofpoint-ORIG-GUID: rVQ-_x7XuJwC02EGiyL1C9AMH0jwULvJ

From: Maksim Kiselev <bigunclemax@gmail.com>

[ Upstream commit e169bd4fb2b36c4b2bee63c35c740c85daeb2e86 ]

Move set_capacity() outside of the section procected by (&d->lock).
To avoid possible interrupt unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
[1] lock(&bdev->bd_size_lock);
                                local_irq_disable();
                            [2] lock(&d->lock);
                            [3] lock(&bdev->bd_size_lock);
   <Interrupt>
[4]  lock(&d->lock);

  *** DEADLOCK ***

Where [1](&bdev->bd_size_lock) hold by zram_add()->set_capacity().
[2]lock(&d->lock) hold by aoeblk_gdalloc(). And aoeblk_gdalloc()
is trying to acquire [3](&bdev->bd_size_lock) at set_capacity() call.
In this situation an attempt to acquire [4]lock(&d->lock) from
aoecmd_cfg_rsp() will lead to deadlock.

So the simplest solution is breaking lock dependency
[2](&d->lock) -> [3](&bdev->bd_size_lock) by moving set_capacity()
outside.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20240124072436.3745720-2-bigunclemax@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
(cherry picked from commit e169bd4fb2b36c4b2bee63c35c740c85daeb2e86)
[Larry: backport to 5.15.y. Minor conflict resolved due to missing commit d9c2bd252a457
aoe: add error handling support for add_disk()]
Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
---
 drivers/block/aoe/aoeblk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 06b360f7123a..4bbb540f26b9 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -346,6 +346,7 @@ aoeblk_gdalloc(void *vp)
 	struct gendisk *gd;
 	mempool_t *mp;
 	struct blk_mq_tag_set *set;
+	sector_t ssize;
 	ulong flags;
 	int late = 0;
 	int err;
@@ -408,7 +409,7 @@ aoeblk_gdalloc(void *vp)
 	gd->minors = AOE_PARTITIONS;
 	gd->fops = &aoe_bdops;
 	gd->private_data = d;
-	set_capacity(gd, d->ssize);
+	ssize = d->ssize;
 	snprintf(gd->disk_name, sizeof gd->disk_name, "etherd/e%ld.%d",
 		d->aoemajor, d->aoeminor);
 
@@ -417,6 +418,8 @@ aoeblk_gdalloc(void *vp)
 
 	spin_unlock_irqrestore(&d->lock, flags);
 
+	set_capacity(gd, ssize);
+
 	device_add_disk(NULL, gd, aoe_attr_groups);
 	aoedisk_add_debugfs(d);
 
-- 
2.46.0


