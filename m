Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFCE761139
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjGYKs4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjGYKsy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:48:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8A01999
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:48:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E77B86165E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CCDC433C8;
        Tue, 25 Jul 2023 10:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282129;
        bh=AIfa/MlBSHM95jlgeLQiIFZfkQqu6AcjqRgUBlxyrlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CmaUw8UInIt9OGrzzX2omzeRlb9MegTVDZyZv2Y5nSy+cqaTj4jsUkyUzYUHH2qjs
         QRLCnSqznkepLt2FXqIZyVBIybLGdsstSbDr5Iqr4FLhMFwNSKcGg1ChCkjpU0PO8w
         seodU1b3Axh14b8PDyuhbigowg3HL2i2yprT7dSk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.4 019/227] btrfs: raid56: always verify the P/Q contents for scrub
Date:   Tue, 25 Jul 2023 12:43:06 +0200
Message-ID: <20230725104515.595590138@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

commit 486c737f7fdc0c3f6464cf27ede811daec2769a1 upstream.

[REGRESSION]
Commit 75b470332965 ("btrfs: raid56: migrate recovery and scrub recovery
path to use error_bitmap") changed the behavior of scrub_rbio().

Initially if we have no error reading the raid bio, we will assign
@need_check to true, then finish_parity_scrub() would later verify the
content of P/Q stripes before writeback.

But after that commit we never verify the content of P/Q stripes and
just writeback them.

This can lead to unrepaired P/Q stripes during scrub, or already
corrupted P/Q copied to the dev-replace target.

[FIX]
The situation is more complex than the regression, in fact the initial
behavior is not 100% correct either.

If we have the following rare case, it can still lead to the same
problem using the old behavior:

		0	16K	32K	48K	64K
	Data 1:	|IIIIIII|                       |
	Data 2:	|				|
	Parity:	|	|CCCCCCC|		|

Where "I" means IO error, "C" means corruption.

In the above case, we're scrubbing the parity stripe, then read out all
the contents of Data 1, Data 2, Parity stripes.

But found IO error in Data 1, which leads to rebuild using Data 2 and
Parity and got the correct data.

In that case, we would not verify if the Parity is correct for range
[16K, 32K).

So here we have to always verify the content of Parity no matter if we
did recovery or not.

This patch would remove the @need_check parameter of
finish_parity_scrub() completely, and would always do the P/Q
verification before writeback.

Fixes: 75b470332965 ("btrfs: raid56: migrate recovery and scrub recovery path to use error_bitmap")
CC: stable@vger.kernel.org # 6.2+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/raid56.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -71,7 +71,7 @@ static void rmw_rbio_work_locked(struct
 static void index_rbio_pages(struct btrfs_raid_bio *rbio);
 static int alloc_rbio_pages(struct btrfs_raid_bio *rbio);
 
-static int finish_parity_scrub(struct btrfs_raid_bio *rbio, int need_check);
+static int finish_parity_scrub(struct btrfs_raid_bio *rbio);
 static void scrub_rbio_work_locked(struct work_struct *work);
 
 static void free_raid_bio_pointers(struct btrfs_raid_bio *rbio)
@@ -2404,7 +2404,7 @@ static int alloc_rbio_essential_pages(st
 	return 0;
 }
 
-static int finish_parity_scrub(struct btrfs_raid_bio *rbio, int need_check)
+static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 {
 	struct btrfs_io_context *bioc = rbio->bioc;
 	const u32 sectorsize = bioc->fs_info->sectorsize;
@@ -2445,9 +2445,6 @@ static int finish_parity_scrub(struct bt
 	 */
 	clear_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
 
-	if (!need_check)
-		goto writeback;
-
 	p_sector.page = alloc_page(GFP_NOFS);
 	if (!p_sector.page)
 		return -ENOMEM;
@@ -2516,7 +2513,6 @@ static int finish_parity_scrub(struct bt
 		q_sector.page = NULL;
 	}
 
-writeback:
 	/*
 	 * time to start writing.  Make bios for everything from the
 	 * higher layers (the bio_list in our rbio) and our p/q.  Ignore
@@ -2699,7 +2695,6 @@ static int scrub_assemble_read_bios(stru
 
 static void scrub_rbio(struct btrfs_raid_bio *rbio)
 {
-	bool need_check = false;
 	int sector_nr;
 	int ret;
 
@@ -2722,7 +2717,7 @@ static void scrub_rbio(struct btrfs_raid
 	 * We have every sector properly prepared. Can finish the scrub
 	 * and writeback the good content.
 	 */
-	ret = finish_parity_scrub(rbio, need_check);
+	ret = finish_parity_scrub(rbio);
 	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
 	for (sector_nr = 0; sector_nr < rbio->stripe_nsectors; sector_nr++) {
 		int found_errors;


