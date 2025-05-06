Return-Path: <stable+bounces-139950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEE2AAA2C9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0919716C578
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684E2220F35;
	Mon,  5 May 2025 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPDKwOib"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221D9220F29;
	Mon,  5 May 2025 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483759; cv=none; b=YhWQojrl9E4sYcPjVZ1eTqLI2CDUopwOIJo8sPFrmI0raIJZgWJ4pez5o8Ecjbvq3biZkkWKMSK7NgekEsJR7m4AT3LdIjWFmA23LQzMZSrk5UaM2VhIxIQL5lQSJtYTp6ETvo4rdSVVdHz3GCC98Hct4u5ohjvcA3BpOqRgkWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483759; c=relaxed/simple;
	bh=pECH7zCh5bhBBGcKnR+6MAK6gLOYTt+WEK+1ewAaryA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oG9h31XC655M1AKefRWQzIbmOLax3temNPshh7cn8lyxr9DoZI3yBFZzrMkgZm28YisTXuQV7Ujzs/DwgFvHig5nYuTcqHJYicueEzEbGHsFw9J8e7JKlE5iiYShdQcYaFgdLj2y+GJNA+0sepCVJrxVgTth54joDSEw2PQ6YNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPDKwOib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E850DC4CEE4;
	Mon,  5 May 2025 22:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483759;
	bh=pECH7zCh5bhBBGcKnR+6MAK6gLOYTt+WEK+1ewAaryA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vPDKwOibYA5MvIWj4stCLeg29eObiIhLEH8o4xhHj4Gy22elgqZp5DUgxZbrdGfPw
	 nV6zZa4glW0eWjPdc/oPqZsgeLJs7ft3LxFIb9osepFmhOtZphcphlvBc9PRBnygHw
	 GQSrnTvm/3tqGUTR3rfDTplH16dGLgpKgIZdfzguT51f+1OKvUpyiuusyzlXEy7PY5
	 ixz5ad1bPBn9He6CSIaWQpofaq2Ko13z3+DVRx4FZFVwqPH/OtWsN4YdFe+Y7yteVm
	 5kuN80XSWhq/13T8tSDVet0SOwqSuF/qGwnFLXdguWE3m1p+QwGbWsKhCxaj2jsJKX
	 I9ngAf7k+bSyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 203/642] block: acquire q->limits_lock while reading sysfs attributes
Date: Mon,  5 May 2025 18:06:59 -0400
Message-Id: <20250505221419.2672473-203-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Nilay Shroff <nilay@linux.ibm.com>

[ Upstream commit 6e51a1279cd60cb93e3379ff140d8fa6c39ecf20 ]

There're few sysfs attributes(RW) whose store method is protected
with q->limits_lock, however the corresponding show method of these
attributes run holding q->sysfs_lock and that doesn't make sense
as ideally the show method of these attributes should also run
holding q->limits_lock instead of q->sysfs_lock. Hence update the
show method of these sysfs attributes so that reading of these
attributes acquire q->limits_lock instead of q->sysfs_lock.

Similarly, there're few sysfs attributes(RO) whose show method is
currently protected with q->sysfs_lock however updates to these
attributes could occur using atomic limit update APIs such as queue_
limits_start_update() and queue_limits_commit_update() which run
holding q->limits_lock. So that means that reading these attributes
holding q->sysfs_lock doesn't make sense. Hence update the show method
of these sysfs attributes(RO) such that they run with holding q->
limits_lock instead of q->sysfs_lock.

We have defined a new macro QUEUE_LIM_RO_ENTRY() which uses new ->show_
limit() method and it runs holding q->limits_lock. All existing sysfs
attributes(RO) which needs protection using q->limits_lock while
reading have been now updated to use this new macro for initialization.

Also, the existing QUEUE_LIM_RW_ENTRY() is updated to use new ->show_
limit() method for reading attributes instead of existing ->show()
method. As ->show_limit() runs holding q->limits_lock, the existing
sysfs attributes(RW) requiring protection are now inherently protected
using q->limits_lock instead of q->sysfs_lock.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Link: https://lore.kernel.org/r/20250304102551.2533767-2-nilay@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-sysfs.c | 102 +++++++++++++++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 37 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 7802186849074..dc4037e27e36e 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -23,9 +23,12 @@
 struct queue_sysfs_entry {
 	struct attribute attr;
 	ssize_t (*show)(struct gendisk *disk, char *page);
+	ssize_t (*show_limit)(struct gendisk *disk, char *page);
+
 	ssize_t (*store)(struct gendisk *disk, const char *page, size_t count);
 	int (*store_limit)(struct gendisk *disk, const char *page,
 			size_t count, struct queue_limits *lim);
+
 	void (*load_module)(struct gendisk *disk, const char *page, size_t count);
 };
 
@@ -412,10 +415,16 @@ static struct queue_sysfs_entry _prefix##_entry = {	\
 	.store	= _prefix##_store,			\
 };
 
+#define QUEUE_LIM_RO_ENTRY(_prefix, _name)			\
+static struct queue_sysfs_entry _prefix##_entry = {	\
+	.attr		= { .name = _name, .mode = 0444 },	\
+	.show_limit	= _prefix##_show,			\
+}
+
 #define QUEUE_LIM_RW_ENTRY(_prefix, _name)			\
 static struct queue_sysfs_entry _prefix##_entry = {	\
 	.attr		= { .name = _name, .mode = 0644 },	\
-	.show		= _prefix##_show,			\
+	.show_limit	= _prefix##_show,			\
 	.store_limit	= _prefix##_store,			\
 }
 
@@ -430,39 +439,39 @@ static struct queue_sysfs_entry _prefix##_entry = {		\
 QUEUE_RW_ENTRY(queue_requests, "nr_requests");
 QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
 QUEUE_LIM_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
-QUEUE_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
-QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
-QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
-QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
+QUEUE_LIM_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
+QUEUE_LIM_RO_ENTRY(queue_max_segments, "max_segments");
+QUEUE_LIM_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
+QUEUE_LIM_RO_ENTRY(queue_max_segment_size, "max_segment_size");
 QUEUE_RW_LOAD_MODULE_ENTRY(elv_iosched, "scheduler");
 
-QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
-QUEUE_RO_ENTRY(queue_physical_block_size, "physical_block_size");
-QUEUE_RO_ENTRY(queue_chunk_sectors, "chunk_sectors");
-QUEUE_RO_ENTRY(queue_io_min, "minimum_io_size");
-QUEUE_RO_ENTRY(queue_io_opt, "optimal_io_size");
+QUEUE_LIM_RO_ENTRY(queue_logical_block_size, "logical_block_size");
+QUEUE_LIM_RO_ENTRY(queue_physical_block_size, "physical_block_size");
+QUEUE_LIM_RO_ENTRY(queue_chunk_sectors, "chunk_sectors");
+QUEUE_LIM_RO_ENTRY(queue_io_min, "minimum_io_size");
+QUEUE_LIM_RO_ENTRY(queue_io_opt, "optimal_io_size");
 
-QUEUE_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
-QUEUE_RO_ENTRY(queue_discard_granularity, "discard_granularity");
-QUEUE_RO_ENTRY(queue_max_hw_discard_sectors, "discard_max_hw_bytes");
+QUEUE_LIM_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
+QUEUE_LIM_RO_ENTRY(queue_discard_granularity, "discard_granularity");
+QUEUE_LIM_RO_ENTRY(queue_max_hw_discard_sectors, "discard_max_hw_bytes");
 QUEUE_LIM_RW_ENTRY(queue_max_discard_sectors, "discard_max_bytes");
 QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 
-QUEUE_RO_ENTRY(queue_atomic_write_max_sectors, "atomic_write_max_bytes");
-QUEUE_RO_ENTRY(queue_atomic_write_boundary_sectors,
+QUEUE_LIM_RO_ENTRY(queue_atomic_write_max_sectors, "atomic_write_max_bytes");
+QUEUE_LIM_RO_ENTRY(queue_atomic_write_boundary_sectors,
 		"atomic_write_boundary_bytes");
-QUEUE_RO_ENTRY(queue_atomic_write_unit_max, "atomic_write_unit_max_bytes");
-QUEUE_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min_bytes");
+QUEUE_LIM_RO_ENTRY(queue_atomic_write_unit_max, "atomic_write_unit_max_bytes");
+QUEUE_LIM_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min_bytes");
 
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
-QUEUE_RO_ENTRY(queue_max_write_zeroes_sectors, "write_zeroes_max_bytes");
-QUEUE_RO_ENTRY(queue_max_zone_append_sectors, "zone_append_max_bytes");
-QUEUE_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
+QUEUE_LIM_RO_ENTRY(queue_max_write_zeroes_sectors, "write_zeroes_max_bytes");
+QUEUE_LIM_RO_ENTRY(queue_max_zone_append_sectors, "zone_append_max_bytes");
+QUEUE_LIM_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
 
-QUEUE_RO_ENTRY(queue_zoned, "zoned");
+QUEUE_LIM_RO_ENTRY(queue_zoned, "zoned");
 QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
-QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
-QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
+QUEUE_LIM_RO_ENTRY(queue_max_open_zones, "max_open_zones");
+QUEUE_LIM_RO_ENTRY(queue_max_active_zones, "max_active_zones");
 
 QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
 QUEUE_LIM_RW_ENTRY(queue_iostats_passthrough, "iostats_passthrough");
@@ -470,16 +479,16 @@ QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
 QUEUE_RW_ENTRY(queue_poll, "io_poll");
 QUEUE_RW_ENTRY(queue_poll_delay, "io_poll_delay");
 QUEUE_LIM_RW_ENTRY(queue_wc, "write_cache");
-QUEUE_RO_ENTRY(queue_fua, "fua");
-QUEUE_RO_ENTRY(queue_dax, "dax");
+QUEUE_LIM_RO_ENTRY(queue_fua, "fua");
+QUEUE_LIM_RO_ENTRY(queue_dax, "dax");
 QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
-QUEUE_RO_ENTRY(queue_virt_boundary_mask, "virt_boundary_mask");
-QUEUE_RO_ENTRY(queue_dma_alignment, "dma_alignment");
+QUEUE_LIM_RO_ENTRY(queue_virt_boundary_mask, "virt_boundary_mask");
+QUEUE_LIM_RO_ENTRY(queue_dma_alignment, "dma_alignment");
 
 /* legacy alias for logical_block_size: */
 static struct queue_sysfs_entry queue_hw_sector_size_entry = {
-	.attr = {.name = "hw_sector_size", .mode = 0444 },
-	.show = queue_logical_block_size_show,
+	.attr		= {.name = "hw_sector_size", .mode = 0444 },
+	.show_limit	= queue_logical_block_size_show,
 };
 
 QUEUE_LIM_RW_ENTRY(queue_rotational, "rotational");
@@ -561,7 +570,9 @@ QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
 
 /* Common attributes for bio-based and request-based queues. */
 static struct attribute *queue_attrs[] = {
-	&queue_ra_entry.attr,
+	/*
+	 * Attributes which are protected with q->limits_lock.
+	 */
 	&queue_max_hw_sectors_entry.attr,
 	&queue_max_sectors_entry.attr,
 	&queue_max_segments_entry.attr,
@@ -577,37 +588,46 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_granularity_entry.attr,
 	&queue_max_discard_sectors_entry.attr,
 	&queue_max_hw_discard_sectors_entry.attr,
-	&queue_discard_zeroes_data_entry.attr,
 	&queue_atomic_write_max_sectors_entry.attr,
 	&queue_atomic_write_boundary_sectors_entry.attr,
 	&queue_atomic_write_unit_min_entry.attr,
 	&queue_atomic_write_unit_max_entry.attr,
-	&queue_write_same_max_entry.attr,
 	&queue_max_write_zeroes_sectors_entry.attr,
 	&queue_max_zone_append_sectors_entry.attr,
 	&queue_zone_write_granularity_entry.attr,
 	&queue_rotational_entry.attr,
 	&queue_zoned_entry.attr,
-	&queue_nr_zones_entry.attr,
 	&queue_max_open_zones_entry.attr,
 	&queue_max_active_zones_entry.attr,
-	&queue_nomerges_entry.attr,
 	&queue_iostats_passthrough_entry.attr,
 	&queue_iostats_entry.attr,
 	&queue_stable_writes_entry.attr,
 	&queue_add_random_entry.attr,
-	&queue_poll_entry.attr,
 	&queue_wc_entry.attr,
 	&queue_fua_entry.attr,
 	&queue_dax_entry.attr,
-	&queue_poll_delay_entry.attr,
 	&queue_virt_boundary_mask_entry.attr,
 	&queue_dma_alignment_entry.attr,
+
+	/*
+	 * Attributes which are protected with q->sysfs_lock.
+	 */
+	&queue_ra_entry.attr,
+	&queue_discard_zeroes_data_entry.attr,
+	&queue_write_same_max_entry.attr,
+	&queue_nr_zones_entry.attr,
+	&queue_nomerges_entry.attr,
+	&queue_poll_entry.attr,
+	&queue_poll_delay_entry.attr,
+
 	NULL,
 };
 
 /* Request-based queue attributes that are not relevant for bio-based queues. */
 static struct attribute *blk_mq_queue_attrs[] = {
+	/*
+	 * Attributes which are protected with q->sysfs_lock.
+	 */
 	&queue_requests_entry.attr,
 	&elv_iosched_entry.attr,
 	&queue_rq_affinity_entry.attr,
@@ -666,8 +686,16 @@ queue_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
 	ssize_t res;
 
-	if (!entry->show)
+	if (!entry->show && !entry->show_limit)
 		return -EIO;
+
+	if (entry->show_limit) {
+		mutex_lock(&disk->queue->limits_lock);
+		res = entry->show_limit(disk, page);
+		mutex_unlock(&disk->queue->limits_lock);
+		return res;
+	}
+
 	mutex_lock(&disk->queue->sysfs_lock);
 	res = entry->show(disk, page);
 	mutex_unlock(&disk->queue->sysfs_lock);
-- 
2.39.5


