Return-Path: <stable+bounces-166988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F886B1FEBA
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 07:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CCB47A6B5D
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 05:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1C726E17F;
	Mon, 11 Aug 2025 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KJM/Mtu2"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C7926E6E2
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890832; cv=none; b=Ot/Dr3jJx7c3gOIcOXrFOiW5a6OtbvRZnsGe3nSKN2dIF1Rlw80JgLm8EhTpyObZYv+gs+UJMJ2xTs+TLa82KYD8Raoq1KIyLM0ZGcgzbFUH2ea2vL25o6UcjQHI0WfmfTx5vQRsfBYC+5B7alvztiWEQxbNo8eRxPTZGnbkmc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890832; c=relaxed/simple;
	bh=FB4GGfNmTB0JnryaMLhuZUnFM8olCLkKN5kF/YvLFVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZmjW8k6eHhkW80KOIARVK/kvEizm5UaOrx6oF5Dw80e2MrpoEyNHmpi+Nj0r6ZW6KmXt3SX97UujAz+08lM/tLm2uj+uIBelbQRTJbZt7Ll88f9JrZ/QkbFxJHGD1uwJ82McdO7JHp1Lw0i2O+/UPR3K7DlXJQmxB695wkO7p34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KJM/Mtu2; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-881a20ebf60so160884239f.1
        for <stable@vger.kernel.org>; Sun, 10 Aug 2025 22:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754890830; x=1755495630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2AneEMvlSNWgSK1THzb8ZW0NUGNSj/nc53x2wpbcODQ=;
        b=upmtZkj/uiuKfNwUZmXCWAFBKk8HoFngswr7L1F1z1HcI9SO7/5Qs8satAcKnDpjkQ
         Gf8CLLcC9KZ2BKBvTlPc9qpGL0sV6LVSYFL4dsesYoddYeBkgAYGmHh5tDfcrum4M7sp
         7ruaEpbWbgwXvHbAFCqNh894DTW2lsG7+hBP6Q6u/LU9GbHqTAAaUtVwURDayLKzI+LK
         +f3GeW8pd/crIALxnGl0oZ9rGMNIy2MZ6Z/VRFR7/j3R/oHqHOTTtOVO14Q8V4SBaH8O
         8jiz0cMnV3w0YYvif1UejsPaPL9SaESq83ismoqQFgwO4uP2UIHmBiRbPHvh7hKqiQ02
         PUmw==
X-Gm-Message-State: AOJu0YxrTFEwwzYxr7+My69A4NYNI9RTjuoNxPeAiqzkkm5S3UdFxRhD
	XOQs7NhQCE8bA8jRxwiej72Y/AhTiDAmNBpR0xTFqrl8qu6sbUJ4X2h6C4CJDTKtsDWqF2mWHfu
	lzdUXB0lFOHLVKaW5eeeoHKBpW//Iuc08bBsTahGg2pY/B1Wk0oA4cwEFjP0Stn1uddJl+Q9pIN
	NHTko1ZKOXNgr9v768JERCNpqw3ICG8iNkmDuC/S+zEnUOPWuS9SqwASDtFI7GjUDCTSc8q/YYZ
	P/y8KdU1AoIAZottg==
X-Gm-Gg: ASbGnctuhgtL2Vz7zxfJMXrr5BqR72S86WiWMIoqiZbGWU5/MI2o47EJEESE3EAwyiA
	u7jJKPs2hj97SDIGhesNRcUyLtlWkTIcgHkCzXsJoEAtKu+JqsqjxMErqiws8tgCQiPQrTwdAct
	53tewNWxChKofF5WdDIgZCEttAt0oehaDwbYADqz244yg1vHNmDIHxC1102LPj9xv8k3Wis9Ddb
	Nmu9MfZvkdgpgP3q3wstqwx0erQDfuK7m7riEBlx7wSTdIyYfaEq8H5z3Aoh+2Y2zjxcJjSR8oC
	S1J6jqLA9zcROx+VdwNU1rwO+AcFFwT86z/gbISY//paYG1+uHdHedC9DmBM8wq/DFmHL3a09dc
	bKZET+efd2IlNcFwk/0278sEM9h+eKJ0/FLiSyppOj/vU8s1C71GRsew4jg1a/kgm/MQsT04rgA
	/30Goeog==
X-Google-Smtp-Source: AGHT+IFEPpHehJ7FyV6wo39BhjrEs3PFcjJ0GuZ/gNPeP6oHwritsxVH5sg67dTpT13wMBCDr/2Svq8tVGVX
X-Received: by 2002:a05:6602:2cd6:b0:881:8957:d55e with SMTP id ca18e2360f4ac-883e4b1921amr2456135339f.3.1754890830088;
        Sun, 10 Aug 2025 22:40:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-50ae99b0831sm536408173.9.2025.08.10.22.40.29
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2025 22:40:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7098e7cb2dcso73610426d6.1
        for <stable@vger.kernel.org>; Sun, 10 Aug 2025 22:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754890829; x=1755495629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AneEMvlSNWgSK1THzb8ZW0NUGNSj/nc53x2wpbcODQ=;
        b=KJM/Mtu2K2wv8Czxt6Rga/qj8jWDFpMUaDFEDl5lp444rYCQQ3n4vV3NMtsbEDRvLx
         70O9jKMgjO3i9IzasmCAQTSfRvOaaK+YDnlwIbki/IQjDb7mPxgFSOHlYVFv7uIMXT1K
         RDfBlE044D0GoQoUSDy9ltAEece9S3v9dORuA=
X-Received: by 2002:ad4:5d63:0:b0:6fa:abd2:f2bb with SMTP id 6a1803df08f44-7099b97d506mr154029706d6.8.1754890828685;
        Sun, 10 Aug 2025 22:40:28 -0700 (PDT)
X-Received: by 2002:ad4:5d63:0:b0:6fa:abd2:f2bb with SMTP id 6a1803df08f44-7099b97d506mr154029446d6.8.1754890828047;
        Sun, 10 Aug 2025 22:40:28 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ce44849sm150544766d6.84.2025.08.10.22.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 22:40:27 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Mike Snitzer <snitzer@redhat.com>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 1/2 v5.10] dm: rearrange core declarations for extended use from  dm-zone.c
Date: Sun, 10 Aug 2025 22:27:01 -0700
Message-Id: <20250811052702.145189-2-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250811052702.145189-1-shivani.agarwal@broadcom.com>
References: <20250811052702.145189-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Damien Le Moal <damien.lemoal@wdc.com>

commit e2118b3c3d94289852417f70ec128c25f4833aad upstream.

Move the definitions of struct dm_target_io, struct dm_io and the bits
of the flags field of struct mapped_device from dm.c to dm-core.h to
make them usable from dm-zone.c. For the same reason, declare
dec_pending() in dm-core.h after renaming it to dm_io_dec_pending().
And for symmetry of the function names, introduce the inline helper
dm_io_inc_pending() instead of directly using atomic_inc() calls.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/md/dm-core.h | 52 ++++++++++++++++++++++++++++++++++++++
 drivers/md/dm.c      | 59 ++++++--------------------------------------
 2 files changed, 59 insertions(+), 52 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index ff73b2c17be5..99b2d2e2cf59 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -124,6 +124,19 @@ struct mapped_device {
 	struct srcu_struct io_barrier;
 };
 
+/*
+ * Bits for the flags field of struct mapped_device.
+ */
+#define DMF_BLOCK_IO_FOR_SUSPEND 0
+#define DMF_SUSPENDED 1
+#define DMF_FROZEN 2
+#define DMF_FREEING 3
+#define DMF_DELETING 4
+#define DMF_NOFLUSH_SUSPENDING 5
+#define DMF_DEFERRED_REMOVE 6
+#define DMF_SUSPENDED_INTERNALLY 7
+#define DMF_POST_SUSPENDING 8
+
 void disable_discard(struct mapped_device *md);
 void disable_write_same(struct mapped_device *md);
 void disable_write_zeroes(struct mapped_device *md);
@@ -177,6 +190,45 @@ struct dm_table {
 	struct dm_md_mempools *mempools;
 };
 
+/*
+ * One of these is allocated per clone bio.
+ */
+#define DM_TIO_MAGIC 7282014
+struct dm_target_io {
+	unsigned int magic;
+	struct dm_io *io;
+	struct dm_target *ti;
+	unsigned int target_bio_nr;
+	unsigned int *len_ptr;
+	bool inside_dm_io;
+	struct bio clone;
+};
+
+/*
+ * One of these is allocated per original bio.
+ * It contains the first clone used for that original.
+ */
+#define DM_IO_MAGIC 5191977
+struct dm_io {
+	unsigned int magic;
+	struct mapped_device *md;
+	blk_status_t status;
+	atomic_t io_count;
+	struct bio *orig_bio;
+	unsigned long start_time;
+	spinlock_t endio_lock;
+	struct dm_stats_aux stats_aux;
+	/* last member of dm_target_io is 'struct bio' */
+	struct dm_target_io tio;
+};
+
+static inline void dm_io_inc_pending(struct dm_io *io)
+{
+	atomic_inc(&io->io_count);
+}
+
+void dm_io_dec_pending(struct dm_io *io, blk_status_t error);
+
 static inline struct completion *dm_get_completion_from_kobject(struct kobject *kobj)
 {
 	return &container_of(kobj, struct dm_kobject_holder, kobj)->completion;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 4fdf0e666777..0868358a7a8d 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -73,38 +73,6 @@ struct clone_info {
 	unsigned sector_count;
 };
 
-/*
- * One of these is allocated per clone bio.
- */
-#define DM_TIO_MAGIC 7282014
-struct dm_target_io {
-	unsigned magic;
-	struct dm_io *io;
-	struct dm_target *ti;
-	unsigned target_bio_nr;
-	unsigned *len_ptr;
-	bool inside_dm_io;
-	struct bio clone;
-};
-
-/*
- * One of these is allocated per original bio.
- * It contains the first clone used for that original.
- */
-#define DM_IO_MAGIC 5191977
-struct dm_io {
-	unsigned magic;
-	struct mapped_device *md;
-	blk_status_t status;
-	atomic_t io_count;
-	struct bio *orig_bio;
-	unsigned long start_time;
-	spinlock_t endio_lock;
-	struct dm_stats_aux stats_aux;
-	/* last member of dm_target_io is 'struct bio' */
-	struct dm_target_io tio;
-};
-
 void *dm_per_bio_data(struct bio *bio, size_t data_size)
 {
 	struct dm_target_io *tio = container_of(bio, struct dm_target_io, clone);
@@ -132,19 +100,6 @@ EXPORT_SYMBOL_GPL(dm_bio_get_target_bio_nr);
 
 #define MINOR_ALLOCED ((void *)-1)
 
-/*
- * Bits for the md->flags field.
- */
-#define DMF_BLOCK_IO_FOR_SUSPEND 0
-#define DMF_SUSPENDED 1
-#define DMF_FROZEN 2
-#define DMF_FREEING 3
-#define DMF_DELETING 4
-#define DMF_NOFLUSH_SUSPENDING 5
-#define DMF_DEFERRED_REMOVE 6
-#define DMF_SUSPENDED_INTERNALLY 7
-#define DMF_POST_SUSPENDING 8
-
 #define DM_NUMA_NODE NUMA_NO_NODE
 static int dm_numa_node = DM_NUMA_NODE;
 
@@ -897,7 +852,7 @@ static int __noflush_suspending(struct mapped_device *md)
  * Decrements the number of outstanding ios that a bio has been
  * cloned into, completing the original io if necc.
  */
-static void dec_pending(struct dm_io *io, blk_status_t error)
+void dm_io_dec_pending(struct dm_io *io, blk_status_t error)
 {
 	unsigned long flags;
 	blk_status_t io_error;
@@ -1041,7 +996,7 @@ static void clone_endio(struct bio *bio)
 	}
 
 	free_tio(tio);
-	dec_pending(io, error);
+	dm_io_dec_pending(io, error);
 }
 
 /*
@@ -1309,7 +1264,7 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 	 * anything, the target has assumed ownership of
 	 * this io.
 	 */
-	atomic_inc(&io->io_count);
+	dm_io_inc_pending(io);
 	sector = clone->bi_iter.bi_sector;
 
 	if (unlikely(swap_bios_limit(ti, clone))) {
@@ -1336,7 +1291,7 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 			up(&md->swap_bios_semaphore);
 		}
 		free_tio(tio);
-		dec_pending(io, BLK_STS_IOERR);
+		dm_io_dec_pending(io, BLK_STS_IOERR);
 		break;
 	case DM_MAPIO_REQUEUE:
 		if (unlikely(swap_bios_limit(ti, clone))) {
@@ -1344,7 +1299,7 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 			up(&md->swap_bios_semaphore);
 		}
 		free_tio(tio);
-		dec_pending(io, BLK_STS_DM_REQUEUE);
+		dm_io_dec_pending(io, BLK_STS_DM_REQUEUE);
 		break;
 	default:
 		DMWARN("unimplemented target map return value: %d", r);
@@ -1640,7 +1595,7 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 
 	if (bio->bi_opf & REQ_PREFLUSH) {
 		error = __send_empty_flush(&ci);
-		/* dec_pending submits any data associated with flush */
+		/* dm_io_dec_pending submits any data associated with flush */
 	} else if (op_is_zone_mgmt(bio_op(bio))) {
 		ci.bio = bio;
 		ci.sector_count = 0;
@@ -1684,7 +1639,7 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 	}
 
 	/* drop the extra reference count */
-	dec_pending(ci.io, errno_to_blk_status(error));
+	dm_io_dec_pending(ci.io, errno_to_blk_status(error));
 	return ret;
 }
 
-- 
2.40.4


