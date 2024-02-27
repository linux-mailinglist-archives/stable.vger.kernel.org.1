Return-Path: <stable+bounces-23787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F43868614
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 02:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6858C289857
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 01:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C423525E;
	Tue, 27 Feb 2024 01:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOB6KPqo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C319336E;
	Tue, 27 Feb 2024 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997857; cv=none; b=oNgY5wZb/FT0hZ7Vpb69lyp9jPwbD2ORY9YAj6hX/fyoiBIAwxUkkwppL/yTaHi8+8aVeSRDCHxqDJKJZjUOad1BRYOgztO57Tn3lHPoiTz+2gVSWmRg+Yde3+lI70qP2B1LXOlJopaYNh5WX+Mj5D/2wdO4J4BYcgNvvufmPDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997857; c=relaxed/simple;
	bh=szvoCJ8mxzmSPnnj71G5SmTEB2MJk0RIcbyrD348UHc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=BWp680jRVN45IXO/6WNvHzv3f5a/+Q7pIBnGc3l7HQLtMV6OVnWBaWo9HHjWieM9zM5cqAzPG12JPDQb8ERd0ENsLkWp6ECYjhDMiMYTnQI7jK9kmTP2PSxGn0E9ecSjwDz3t5DQyaeQrBp+rk+wCMAscroLON6m2kxchxFvX2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOB6KPqo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc1ff697f9so30413655ad.0;
        Mon, 26 Feb 2024 17:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708997855; x=1709602655; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xf0fD7sfnD+IFHcYsOvjKCBQ0iWeVFP4rLWMLoIWcbc=;
        b=IOB6KPqo4lI2P+AwpCBHJ8/z8xIbOC6sNoiyA43pspTI774Euvd9n85lRB092KrIb3
         wbW2NKY+1mNgJ4P2yp0oCRUED40rvsCqUzZwMNbNuahqL9AUDSg8znpiqQ4pMPgAN4dJ
         0KyBAOmdsUEUPEeYOP2vXuhqohz7XYYRxFocT7qraSW7cizg5UJi0OBkEGufUpuXOn+5
         V3j0DMZIcZOdP1f4iFCf+okhTBOlbZ4tncoqPPQS4ZV+2p5xZ4iZJmcVQgu8NeM1gUN1
         EOM2SclzMqAnqQw/qfv0dedJWaWz4XvOXvldVnjbVggEFQNwYMztxgYu/o1gsQ++PYE5
         qkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708997855; x=1709602655;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xf0fD7sfnD+IFHcYsOvjKCBQ0iWeVFP4rLWMLoIWcbc=;
        b=dRJq8L6/zrtx0zkKmmf98Z+DRqISqg1n9lNNQX1DLeQ0J+f75B3BkIeayyoJF60tWC
         Q1Ku32UoL8d29UqywlE+pyFHxbq2pko60J9maLxfgt1PP1bsmnPqIgNL6l5uejfuGWZ1
         t0qQSGxZQi+F7+S+dKPX7SLH4Pp4pRY5cU+D/d8cJgeXPRz5xoWPPzmjf0JAwR7IDLQv
         k0LFSH1016XL8h+H8Ii68tmWbPggxps8vo1OAcBBY2qjh2imI5xKvlS4Tv06X/xeRotJ
         pj4hIn2Z6vmhvUcnnfehd4V1U6yT4RCx2xSkDSK15xieZ0K+nvg7Sd9u1QadYXgzdAHj
         r1wQ==
X-Gm-Message-State: AOJu0YzupH8qWI/w3+KvIaOg/Kif4RRqE+GriH6I5zaRrALAurPP5agF
	1YHP8dmEC6zduT8rreK5oF3In/oo/Yd5DEoRQ0+G2KnZIxIGySTq
X-Google-Smtp-Source: AGHT+IHJ4N8s1oW71EoIFfSgJ20yx5lMoCPaLqb/kt0rfRNG2vGawk4IPNHTaA/1VU5mlcIIAdkzdQ==
X-Received: by 2002:a17:902:e94f:b0:1db:fad5:26ad with SMTP id b15-20020a170902e94f00b001dbfad526admr3273946pll.51.1708997854993;
        Mon, 26 Feb 2024 17:37:34 -0800 (PST)
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id iz10-20020a170902ef8a00b001dc8e1375e2sm320999plb.104.2024.02.26.17.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:37:34 -0800 (PST)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id 91B6436031A; Tue, 27 Feb 2024 14:37:30 +1300 (NZDT)
From: Michael Schmitz <schmitzmic@gmail.com>
To: stable@vger.kernel.org
Cc: linux-m68k@vger.kernel.org,
	gregkh@linuxfoundation.org,
	geert@linux-m68k.org,
	Michael Schmitz <schmitzmic@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: ataflop: more blk-mq refactoring fixes
Date: Tue, 27 Feb 2024 14:37:28 +1300
Message-Id: <20240227013728.15935-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

[ commit d28e4dff085c5a87025c9a0a85fb798bd8e9ca17 upstream ]

As it turns out, my earlier patch in commit 86d46fdaa12a (block:
ataflop: fix breakage introduced at blk-mq refactoring) was
incomplete. This patch fixes any remaining issues found during
more testing and code review.

Requests exceeding 4 k are handled in 4k segments but
__blk_mq_end_request() is never called on these (still
sectors outstanding on the request). With redo_fd_request()
removed, there is no provision to kick off processing of the
next segment, causing requests exceeding 4k to hang. (By
setting /sys/block/fd0/queue/max_sectors_k <= 4 as workaround,
this behaviour can be avoided).

Instead of reintroducing redo_fd_request(), requeue the remainder
of the request by calling blk_mq_requeue_request() on incomplete
requests (i.e. when blk_update_request() still returns true), and
rely on the block layer to queue the residual as new request.

Both error handling and formatting needs to release the
ST-DMA lock, so call finish_fdc() on these (this was previously
handled by redo_fd_request()). finish_fdc() may be called
legitimately without the ST-DMA lock held - make sure we only
release the lock if we actually held it. In a similar way,
early exit due to errors in ataflop_queue_rq() must release
the lock.

After minor errors, fd_error sets up to recalibrate the drive
but never re-runs the current operation (another task handled by
redo_fd_request() before). Call do_fd_action() to get the next
steps (seek, retry read/write) underway.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Fixes: 6ec3938cff95f (ataflop: convert to blk-mq)
Fixes: 86d46fdaa12a (block: ataflop: fix breakage introduced at blk-mq refactoring)
CC: stable@vger.kernel.org # 5.10.x
Link: https://lore.kernel.org/r/20211024002013.9332-1-schmitzmic@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[MSch: v5.10 backport merge conflict fix]
---
 drivers/block/ataflop.c | 42 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index cd612cd04767..224450c90e45 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -456,10 +456,20 @@ static DEFINE_TIMER(fd_timer, check_change);
 	
 static void fd_end_request_cur(blk_status_t err)
 {
+	DPRINT(("fd_end_request_cur(), bytes %d of %d\n",
+		blk_rq_cur_bytes(fd_request),
+		blk_rq_bytes(fd_request)));
+
 	if (!blk_update_request(fd_request, err,
 				blk_rq_cur_bytes(fd_request))) {
+		DPRINT(("calling __blk_mq_end_request()\n"));
 		__blk_mq_end_request(fd_request, err);
 		fd_request = NULL;
+	} else {
+		/* requeue rest of request */
+		DPRINT(("calling blk_mq_requeue_request()\n"));
+		blk_mq_requeue_request(fd_request, true);
+		fd_request = NULL;
 	}
 }
 
@@ -697,12 +707,21 @@ static void fd_error( void )
 	if (fd_request->error_count >= MAX_ERRORS) {
 		printk(KERN_ERR "fd%d: too many errors.\n", SelectedDrive );
 		fd_end_request_cur(BLK_STS_IOERR);
+		finish_fdc();
+		return;
 	}
 	else if (fd_request->error_count == RECALIBRATE_ERRORS) {
 		printk(KERN_WARNING "fd%d: recalibrating\n", SelectedDrive );
 		if (SelectedDrive != -1)
 			SUD.track = -1;
 	}
+	/* need to re-run request to recalibrate */
+	atari_disable_irq( IRQ_MFP_FDC );
+
+	setup_req_params( SelectedDrive );
+	do_fd_action( SelectedDrive );
+
+	atari_enable_irq( IRQ_MFP_FDC );
 }
 
 
@@ -737,6 +756,7 @@ static int do_format(int drive, int type, struct atari_format_descr *desc)
 	if (type) {
 		if (--type >= NUM_DISK_MINORS ||
 		    minor2disktype[type].drive_types > DriveType) {
+			finish_fdc();
 			ret = -EINVAL;
 			goto out;
 		}
@@ -745,6 +765,7 @@ static int do_format(int drive, int type, struct atari_format_descr *desc)
 	}
 
 	if (!UDT || desc->track >= UDT->blocks/UDT->spt/2 || desc->head >= 2) {
+		finish_fdc();
 		ret = -EINVAL;
 		goto out;
 	}
@@ -785,6 +806,7 @@ static int do_format(int drive, int type, struct atari_format_descr *desc)
 
 	wait_for_completion(&format_wait);
 
+	finish_fdc();
 	ret = FormatError ? -EIO : 0;
 out:
 	blk_mq_unquiesce_queue(q);
@@ -819,6 +841,7 @@ static void do_fd_action( int drive )
 		    else {
 			/* all sectors finished */
 			fd_end_request_cur(BLK_STS_OK);
+			finish_fdc();
 			return;
 		    }
 		}
@@ -1222,8 +1245,8 @@ static void fd_rwsec_done1(int status)
 	}
 	else {
 		/* all sectors finished */
-		finish_fdc();
 		fd_end_request_cur(BLK_STS_OK);
+		finish_fdc();
 	}
 	return;
   
@@ -1345,7 +1368,7 @@ static void fd_times_out(struct timer_list *unused)
 
 static void finish_fdc( void )
 {
-	if (!NeedSeek) {
+	if (!NeedSeek || !stdma_is_locked_by(floppy_irq)) {
 		finish_fdc_done( 0 );
 	}
 	else {
@@ -1380,7 +1403,8 @@ static void finish_fdc_done( int dummy )
 	start_motor_off_timer();
 
 	local_irq_save(flags);
-	stdma_release();
+	if (stdma_is_locked_by(floppy_irq))
+		stdma_release();
 	local_irq_restore(flags);
 
 	DPRINT(("finish_fdc() finished\n"));
@@ -1477,7 +1501,9 @@ static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	int drive = floppy - unit;
 	int type = floppy->type;
 
-	DPRINT(("Queue request: drive %d type %d last %d\n", drive, type, bd->last));
+	DPRINT(("Queue request: drive %d type %d sectors %d of %d last %d\n",
+		drive, type, blk_rq_cur_sectors(bd->rq),
+		blk_rq_sectors(bd->rq), bd->last));
 
 	spin_lock_irq(&ataflop_lock);
 	if (fd_request) {
@@ -1499,6 +1525,7 @@ static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		/* drive not connected */
 		printk(KERN_ERR "Unknown Device: fd%d\n", drive );
 		fd_end_request_cur(BLK_STS_IOERR);
+		stdma_release();
 		goto out;
 	}
 		
@@ -1515,11 +1542,13 @@ static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		if (--type >= NUM_DISK_MINORS) {
 			printk(KERN_WARNING "fd%d: invalid disk format", drive );
 			fd_end_request_cur(BLK_STS_IOERR);
+			stdma_release();
 			goto out;
 		}
 		if (minor2disktype[type].drive_types > DriveType)  {
 			printk(KERN_WARNING "fd%d: unsupported disk format", drive );
 			fd_end_request_cur(BLK_STS_IOERR);
+			stdma_release();
 			goto out;
 		}
 		type = minor2disktype[type].index;
@@ -1620,6 +1649,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 		/* what if type > 0 here? Overwrite specified entry ? */
 		if (type) {
 		        /* refuse to re-set a predefined type for now */
+			finish_fdc();
 			return -EINVAL;
 		}
 
@@ -1687,8 +1717,10 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 
 		/* sanity check */
 		if (setprm.track != dtp->blocks/dtp->spt/2 ||
-		    setprm.head != 2)
+		    setprm.head != 2) {
+			finish_fdc();
 			return -EINVAL;
+		}
 
 		UDT = dtp;
 		set_capacity(floppy->disk, UDT->blocks);
-- 
2.17.1


