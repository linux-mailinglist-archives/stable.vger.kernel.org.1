Return-Path: <stable+bounces-154622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E721AADE315
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 07:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D9B3BC32A
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 05:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B789155382;
	Wed, 18 Jun 2025 05:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oympuFKC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D242814F98;
	Wed, 18 Jun 2025 05:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750225120; cv=none; b=Q4owTUsN26TCbFMvy5JAe3NtV9vatTpo7BXJiimfPsGcRgGWCBXiWhMFTsuP1HO+u/tmQnR2jEhT+7h+IyIHsDjiiUfr84HIdnNPrQjq9TFblnXPw5t3mqjjEm7SRqHGxzIAMwXhgU2lQQx8G40On3c1svUWllRDyyA1Loe7PW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750225120; c=relaxed/simple;
	bh=E+qK/J0ZbeQglBsWcNjoMkpYnxmhAeIgwUwHhtsgACI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j06saT2KGIq1hglvYVDpXrYjdpZYVrRWQiwid085qdWNKj8gXgr2U7hQzHLCDUrxhXtawfA58lPzxl/Attv7TT3T07t4WCv4hy52ehN3R0z5qMcb5ss0mQWix1hl7IZpt34aV7igB2lWW4qQPxPghDDkQld3koDoinrvH7WoZbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oympuFKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B7FC4CEE7;
	Wed, 18 Jun 2025 05:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750225119;
	bh=E+qK/J0ZbeQglBsWcNjoMkpYnxmhAeIgwUwHhtsgACI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oympuFKCbJIU0YSTqcy0hXf3TWGu2/YlNnH9mspIdwcltT3Heyyh9gm2TnAeoN9B7
	 zqHQH4Nncctuo1iHfxXgEx4QttQUWTxndaTFGFITRp+fbOFe1fCKIKvTl5qzWVJXsZ
	 NokqQzNJUyXcZlWSeXwlBVhSghYWEC/ee+4fIvP8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 280/512] dm: fix dm_blk_report_zones
Date: Tue, 17 Jun 2025 17:24:06 +0200
Message-ID: <20250617152430.943780190@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Marzinski <bmarzins@redhat.com>

[ Upstream commit 37f53a2c60d03743e0eacf7a0c01c279776fef4e ]

If dm_get_live_table() returned NULL, dm_put_live_table() was never
called. Also, it is possible that md->zone_revalidate_map will change
while calling this function. Only read it once, so that we are always
using the same value. Otherwise we might miss a call to
dm_put_live_table().

Finally, while md->zone_revalidate_map is set and a process is calling
blk_revalidate_disk_zones() to set up the zone append emulation
resources, it is possible that another process, perhaps triggered by
blkdev_report_zones_ioctl(), will call dm_blk_report_zones(). If
blk_revalidate_disk_zones() fails, these resources can be freed while
the other process is still using them, causing a use-after-free error.

blk_revalidate_disk_zones() will only ever be called when initially
setting up the zone append emulation resources, such as when setting up
a zoned dm-crypt table for the first time. Further table swaps will not
set md->zone_revalidate_map or call blk_revalidate_disk_zones().
However it must be called using the new table (referenced by
md->zone_revalidate_map) and the new queue limits while the DM device is
suspended. dm_blk_report_zones() needs some way to distinguish between a
call from blk_revalidate_disk_zones(), which must be allowed to use
md->zone_revalidate_map to access this not yet activated table, and all
other calls to dm_blk_report_zones(), which should not be allowed while
the device is suspended and cannot use md->zone_revalidate_map, since
the zone resources might be freed by the process currently calling
blk_revalidate_disk_zones().

Solve this by tracking the process that sets md->zone_revalidate_map in
dm_revalidate_zones() and only allowing that process to make use of it
in dm_blk_report_zones().

Fixes: f211268ed1f9b ("dm: Use the block layer zone append emulation")
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Tested-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-core.h |  1 +
 drivers/md/dm-zone.c | 25 +++++++++++++++++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 3637761f35853..f3a3f2ef63226 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -141,6 +141,7 @@ struct mapped_device {
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int nr_zones;
 	void *zone_revalidate_map;
+	struct task_struct *revalidate_map_task;
 #endif
 
 #ifdef CONFIG_IMA
diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index c0d41c36e06eb..04cc36a9d5ca4 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -56,24 +56,31 @@ int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
 {
 	struct mapped_device *md = disk->private_data;
 	struct dm_table *map;
-	int srcu_idx, ret;
+	struct dm_table *zone_revalidate_map = md->zone_revalidate_map;
+	int srcu_idx, ret = -EIO;
+	bool put_table = false;
 
-	if (!md->zone_revalidate_map) {
-		/* Regular user context */
+	if (!zone_revalidate_map || md->revalidate_map_task != current) {
+		/*
+		 * Regular user context or
+		 * Zone revalidation during __bind() is in progress, but this
+		 * call is from a different process
+		 */
 		if (dm_suspended_md(md))
 			return -EAGAIN;
 
 		map = dm_get_live_table(md, &srcu_idx);
-		if (!map)
-			return -EIO;
+		put_table = true;
 	} else {
 		/* Zone revalidation during __bind() */
-		map = md->zone_revalidate_map;
+		map = zone_revalidate_map;
 	}
 
-	ret = dm_blk_do_report_zones(md, map, sector, nr_zones, cb, data);
+	if (map)
+		ret = dm_blk_do_report_zones(md, map, sector, nr_zones, cb,
+					     data);
 
-	if (!md->zone_revalidate_map)
+	if (put_table)
 		dm_put_live_table(md, srcu_idx);
 
 	return ret;
@@ -175,7 +182,9 @@ int dm_revalidate_zones(struct dm_table *t, struct request_queue *q)
 	 * our table for dm_blk_report_zones() to use directly.
 	 */
 	md->zone_revalidate_map = t;
+	md->revalidate_map_task = current;
 	ret = blk_revalidate_disk_zones(disk);
+	md->revalidate_map_task = NULL;
 	md->zone_revalidate_map = NULL;
 
 	if (ret) {
-- 
2.39.5




