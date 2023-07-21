Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C5675D494
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjGUTWo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjGUTWn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:22:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7C81727
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:22:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7083F61D6D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831F4C433C8;
        Fri, 21 Jul 2023 19:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967360;
        bh=nOeD4hQSPR+l5fTQnpz2Wat5fKmRHM6ZUc2LrwDoQ1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMFsJUjFxN0KZtOQy5OOHf1Ny0+zSUZzInMT61zyqNSpzymO9/vk2tS6r29gceZXY
         jHfGVaP4962CQo9PUB7oka/Jb9Q5U650ceivO60xosaq6YRWpTZuO3Tolqm4CqDmhv
         7itk55oOetS5mn2C/NHvL7m/tvKBa+CCYLjMMIDg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, NeilBrown <neilb@suse.de>,
        Song Liu <song@kernel.org>, Jason Baron <jbaron@akamai.com>
Subject: [PATCH 6.1 135/223] md/raid0: add discard support for the original layout
Date:   Fri, 21 Jul 2023 18:06:28 +0200
Message-ID: <20230721160526.632144311@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jason Baron <jbaron@akamai.com>

commit e836007089ba8fdf24e636ef2b007651fb4582e6 upstream.

We've found that using raid0 with the 'original' layout and discard
enabled with different disk sizes (such that at least two zones are
created) can result in data corruption. This is due to the fact that
the discard handling in 'raid0_handle_discard()' assumes the 'alternate'
layout. We've seen this corruption using ext4 but other filesystems are
likely susceptible as well.

More specifically, while multiple zones are necessary to create the
corruption, the corruption may not occur with multiple zones if they
layout in such a way the layout matches what the 'alternate' layout
would have produced. Thus, not all raid0 devices with the 'original'
layout, different size disks and discard enabled will encounter this
corruption.

The 3.14 kernel inadvertently changed the raid0 disk layout for different
size disks. Thus, running a pre-3.14 kernel and post-3.14 kernel on the
same raid0 array could corrupt data. This lead to the creation of the
'original' layout (to match the pre-3.14 layout) and the 'alternate' layout
(to match the post 3.14 layout) in the 5.4 kernel time frame and an option
to tell the kernel which layout to use (since it couldn't be autodetected).
However, when the 'original' layout was added back to 5.4 discard support
for the 'original' layout was not added leading this issue.

I've been able to reliably reproduce the corruption with the following
test case:

1. create raid0 array with different size disks using original layout
2. mkfs
3. mount -o discard
4. create lots of files
5. remove 1/2 the files
6. fstrim -a (or just the mount point for the raid0 array)
7. umount
8. fsck -fn /dev/md0 (spews all sorts of corruptions)

Let's fix this by adding proper discard support to the 'original' layout.
The fix 'maps' the 'original' layout disks to the order in which they are
read/written such that we can compare the disks in the same way that the
current 'alternate' layout does. A 'disk_shift' field is added to
'struct strip_zone'. This could be computed on the fly in
raid0_handle_discard() but by adding this field, we save some computation
in the discard path.

Note we could also potentially fix this by re-ordering the disks in the
zones that follow the first one, and then always read/writing them using
the 'alternate' layout. However, that is seen as a more substantial change,
and we are attempting the least invasive fix at this time to remedy the
corruption.

I've verified the change using the reproducer mentioned above. Typically,
the corruption is seen after less than 3 iterations, while the patch has
run 500+ iterations.

Cc: NeilBrown <neilb@suse.de>
Cc: Song Liu <song@kernel.org>
Fixes: c84a1372df92 ("md/raid0: avoid RAID0 data corruption due to layout confusion.")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230623180523.1901230-1-jbaron@akamai.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid0.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++-------
 drivers/md/raid0.h |    1 
 2 files changed, 55 insertions(+), 8 deletions(-)

--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -270,6 +270,18 @@ static int create_strip_zones(struct mdd
 		goto abort;
 	}
 
+	if (conf->layout == RAID0_ORIG_LAYOUT) {
+		for (i = 1; i < conf->nr_strip_zones; i++) {
+			sector_t first_sector = conf->strip_zone[i-1].zone_end;
+
+			sector_div(first_sector, mddev->chunk_sectors);
+			zone = conf->strip_zone + i;
+			/* disk_shift is first disk index used in the zone */
+			zone->disk_shift = sector_div(first_sector,
+						      zone->nb_dev);
+		}
+	}
+
 	pr_debug("md/raid0:%s: done.\n", mdname(mddev));
 	*private_conf = conf;
 
@@ -431,6 +443,20 @@ exit_acct_set:
 	return ret;
 }
 
+/*
+ * Convert disk_index to the disk order in which it is read/written.
+ *  For example, if we have 4 disks, they are numbered 0,1,2,3. If we
+ *  write the disks starting at disk 3, then the read/write order would
+ *  be disk 3, then 0, then 1, and then disk 2 and we want map_disk_shift()
+ *  to map the disks as follows 0,1,2,3 => 1,2,3,0. So disk 0 would map
+ *  to 1, 1 to 2, 2 to 3, and 3 to 0. That way we can compare disks in
+ *  that 'output' space to understand the read/write disk ordering.
+ */
+static int map_disk_shift(int disk_index, int num_disks, int disk_shift)
+{
+	return ((disk_index + num_disks - disk_shift) % num_disks);
+}
+
 static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 {
 	struct r0conf *conf = mddev->private;
@@ -444,7 +470,9 @@ static void raid0_handle_discard(struct
 	sector_t end_disk_offset;
 	unsigned int end_disk_index;
 	unsigned int disk;
+	sector_t orig_start, orig_end;
 
+	orig_start = start;
 	zone = find_zone(conf, &start);
 
 	if (bio_end_sector(bio) > zone->zone_end) {
@@ -458,6 +486,7 @@ static void raid0_handle_discard(struct
 	} else
 		end = bio_end_sector(bio);
 
+	orig_end = end;
 	if (zone != conf->strip_zone)
 		end = end - zone[-1].zone_end;
 
@@ -469,13 +498,26 @@ static void raid0_handle_discard(struct
 	last_stripe_index = end;
 	sector_div(last_stripe_index, stripe_size);
 
-	start_disk_index = (int)(start - first_stripe_index * stripe_size) /
-		mddev->chunk_sectors;
+	/* In the first zone the original and alternate layouts are the same */
+	if ((conf->layout == RAID0_ORIG_LAYOUT) && (zone != conf->strip_zone)) {
+		sector_div(orig_start, mddev->chunk_sectors);
+		start_disk_index = sector_div(orig_start, zone->nb_dev);
+		start_disk_index = map_disk_shift(start_disk_index,
+						  zone->nb_dev,
+						  zone->disk_shift);
+		sector_div(orig_end, mddev->chunk_sectors);
+		end_disk_index = sector_div(orig_end, zone->nb_dev);
+		end_disk_index = map_disk_shift(end_disk_index,
+						zone->nb_dev, zone->disk_shift);
+	} else {
+		start_disk_index = (int)(start - first_stripe_index * stripe_size) /
+			mddev->chunk_sectors;
+		end_disk_index = (int)(end - last_stripe_index * stripe_size) /
+			mddev->chunk_sectors;
+	}
 	start_disk_offset = ((int)(start - first_stripe_index * stripe_size) %
 		mddev->chunk_sectors) +
 		first_stripe_index * mddev->chunk_sectors;
-	end_disk_index = (int)(end - last_stripe_index * stripe_size) /
-		mddev->chunk_sectors;
 	end_disk_offset = ((int)(end - last_stripe_index * stripe_size) %
 		mddev->chunk_sectors) +
 		last_stripe_index * mddev->chunk_sectors;
@@ -483,18 +525,22 @@ static void raid0_handle_discard(struct
 	for (disk = 0; disk < zone->nb_dev; disk++) {
 		sector_t dev_start, dev_end;
 		struct md_rdev *rdev;
+		int compare_disk;
+
+		compare_disk = map_disk_shift(disk, zone->nb_dev,
+					      zone->disk_shift);
 
-		if (disk < start_disk_index)
+		if (compare_disk < start_disk_index)
 			dev_start = (first_stripe_index + 1) *
 				mddev->chunk_sectors;
-		else if (disk > start_disk_index)
+		else if (compare_disk > start_disk_index)
 			dev_start = first_stripe_index * mddev->chunk_sectors;
 		else
 			dev_start = start_disk_offset;
 
-		if (disk < end_disk_index)
+		if (compare_disk < end_disk_index)
 			dev_end = (last_stripe_index + 1) * mddev->chunk_sectors;
-		else if (disk > end_disk_index)
+		else if (compare_disk > end_disk_index)
 			dev_end = last_stripe_index * mddev->chunk_sectors;
 		else
 			dev_end = end_disk_offset;
--- a/drivers/md/raid0.h
+++ b/drivers/md/raid0.h
@@ -6,6 +6,7 @@ struct strip_zone {
 	sector_t zone_end;	/* Start of the next zone (in sectors) */
 	sector_t dev_start;	/* Zone offset in real dev (in sectors) */
 	int	 nb_dev;	/* # of devices attached to the zone */
+	int	 disk_shift;	/* start disk for the original layout */
 };
 
 /* Linux 3.14 (20d0189b101) made an unintended change to


