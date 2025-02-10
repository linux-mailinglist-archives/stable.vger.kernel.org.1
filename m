Return-Path: <stable+bounces-114478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FE7A2E58B
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 08:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F77E3A3536
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 07:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493881B425A;
	Mon, 10 Feb 2025 07:40:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BC01AF0AF;
	Mon, 10 Feb 2025 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739173229; cv=none; b=Epne1cQ8cLPPNHT+UV+6XdEcesEOTOiQejPE4nW/j0CrgeMrM3UsajT5CB3J7NeCHgZrMjDG1pXROsuYw/6QSHoIvtQF+iqCy+NvuMVGfcQx5X8NXupP0U4qzDS48ajzB8RwY4Pfl9PKA15OX9MuQmekBsgwyy79WLr+zlTKR5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739173229; c=relaxed/simple;
	bh=OA+/sgVfTJ1w7MxjfvDpB7whIo6eI4MWkPx6peilQxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kipSVmMbZO8ljaEptRATbKXV++PjkOqUsAbWCQvZv74hrfTYiIQseqFvPJEryWwlGfgcs6fKXdW8FTCAhPuU7UuaOkOu/qf3f3cXfIImZEbOaI33Qmag9sh5kWnLaajP0fbJ2T9oeMviD4GhHk9bntSICSpSOx+/FYwNhkl8dAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YrxLN3mWzz4f3jY3;
	Mon, 10 Feb 2025 15:39:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C43531A1765;
	Mon, 10 Feb 2025 15:40:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAHa19cralnS0S5DQ--.28027S5;
	Mon, 10 Feb 2025 15:40:17 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	song@kernel.org,
	yukuai3@huawei.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 6.6 v2 1/6] md/raid5: recheck if reshape has finished with device_lock held
Date: Mon, 10 Feb 2025 15:33:17 +0800
Message-Id: <20250210073322.3315094-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250210073322.3315094-1-yukuai1@huaweicloud.com>
References: <20250210073322.3315094-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHa19cralnS0S5DQ--.28027S5
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4xJw15ur17GFWxKrWDCFg_yoW7XF4rpa
	yayasIqr4kZr9agrsxJw1vgryFkrWkKrW5KwsrJ348Aws5J3s3uF18GryqgF1jvr9xXr4Y
	qw1jyFyUCr1q9a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUtVW8Zw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqkskUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Benjamin Marzinski <bmarzins@redhat.com>

commit 25b3a8237a03ec0b67b965b52d74862e77ef7115 upstream.

When handling an IO request, MD checks if a reshape is currently
happening, and if so, where the IO sector is in relation to the reshape
progress. MD uses conf->reshape_progress for both of these tasks.  When
the reshape finishes, conf->reshape_progress is set to MaxSector.  If
this occurs after MD checks if the reshape is currently happening but
before it calls ahead_of_reshape(), then ahead_of_reshape() will end up
comparing the IO sector against MaxSector. During a backwards reshape,
this will make MD think the IO sector is in the area not yet reshaped,
causing it to use the previous configuration, and map the IO to the
sector where that data was before the reshape.

This bug can be triggered by running the lvm2
lvconvert-raid-reshape-linear_to_raid6-single-type.sh test in a loop,
although it's very hard to reproduce.

Fix this by factoring the code that checks where the IO sector is in
relation to the reshape out to a helper called get_reshape_loc(),
which reads reshape_progress and reshape_safe while holding the
device_lock, and then rechecks if the reshape has finished before
calling ahead_of_reshape with the saved values.

Also use the helper during the REQ_NOWAIT check to see if the location
is inside of the reshape region.

Fixes: fef9c61fdfabf ("md/raid5: change reshape-progress measurement to cope with reshaping backwards.")
Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240702151802.1632010-1-bmarzins@redhat.com
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid5.c | 64 +++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 2c7f11e57667..3923063eada9 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5972,6 +5972,39 @@ static bool reshape_disabled(struct mddev *mddev)
 	return is_md_suspended(mddev) || !md_is_rdwr(mddev);
 }
 
+enum reshape_loc {
+	LOC_NO_RESHAPE,
+	LOC_AHEAD_OF_RESHAPE,
+	LOC_INSIDE_RESHAPE,
+	LOC_BEHIND_RESHAPE,
+};
+
+static enum reshape_loc get_reshape_loc(struct mddev *mddev,
+		struct r5conf *conf, sector_t logical_sector)
+{
+	sector_t reshape_progress, reshape_safe;
+	/*
+	 * Spinlock is needed as reshape_progress may be
+	 * 64bit on a 32bit platform, and so it might be
+	 * possible to see a half-updated value
+	 * Of course reshape_progress could change after
+	 * the lock is dropped, so once we get a reference
+	 * to the stripe that we think it is, we will have
+	 * to check again.
+	 */
+	spin_lock_irq(&conf->device_lock);
+	reshape_progress = conf->reshape_progress;
+	reshape_safe = conf->reshape_safe;
+	spin_unlock_irq(&conf->device_lock);
+	if (reshape_progress == MaxSector)
+		return LOC_NO_RESHAPE;
+	if (ahead_of_reshape(mddev, logical_sector, reshape_progress))
+		return LOC_AHEAD_OF_RESHAPE;
+	if (ahead_of_reshape(mddev, logical_sector, reshape_safe))
+		return LOC_INSIDE_RESHAPE;
+	return LOC_BEHIND_RESHAPE;
+}
+
 static enum stripe_result make_stripe_request(struct mddev *mddev,
 		struct r5conf *conf, struct stripe_request_ctx *ctx,
 		sector_t logical_sector, struct bio *bi)
@@ -5986,28 +6019,14 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 	seq = read_seqcount_begin(&conf->gen_lock);
 
 	if (unlikely(conf->reshape_progress != MaxSector)) {
-		/*
-		 * Spinlock is needed as reshape_progress may be
-		 * 64bit on a 32bit platform, and so it might be
-		 * possible to see a half-updated value
-		 * Of course reshape_progress could change after
-		 * the lock is dropped, so once we get a reference
-		 * to the stripe that we think it is, we will have
-		 * to check again.
-		 */
-		spin_lock_irq(&conf->device_lock);
-		if (ahead_of_reshape(mddev, logical_sector,
-				     conf->reshape_progress)) {
-			previous = 1;
-		} else {
-			if (ahead_of_reshape(mddev, logical_sector,
-					     conf->reshape_safe)) {
-				spin_unlock_irq(&conf->device_lock);
-				ret = STRIPE_SCHEDULE_AND_RETRY;
-				goto out;
-			}
+		enum reshape_loc loc = get_reshape_loc(mddev, conf,
+						       logical_sector);
+		if (loc == LOC_INSIDE_RESHAPE) {
+			ret = STRIPE_SCHEDULE_AND_RETRY;
+			goto out;
 		}
-		spin_unlock_irq(&conf->device_lock);
+		if (loc == LOC_AHEAD_OF_RESHAPE)
+			previous = 1;
 	}
 
 	new_sector = raid5_compute_sector(conf, logical_sector, previous,
@@ -6189,8 +6208,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	/* Bail out if conflicts with reshape and REQ_NOWAIT is set */
 	if ((bi->bi_opf & REQ_NOWAIT) &&
 	    (conf->reshape_progress != MaxSector) &&
-	    !ahead_of_reshape(mddev, logical_sector, conf->reshape_progress) &&
-	    ahead_of_reshape(mddev, logical_sector, conf->reshape_safe)) {
+	    get_reshape_loc(mddev, conf, logical_sector) == LOC_INSIDE_RESHAPE) {
 		bio_wouldblock_error(bi);
 		if (rw == WRITE)
 			md_write_end(mddev);
-- 
2.39.2


