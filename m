Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4C377A318
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 23:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjHLVl5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 17:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjHLVl4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 17:41:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF5D1706
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 14:41:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02C0662038
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 21:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B51C433C8;
        Sat, 12 Aug 2023 21:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691876518;
        bh=fu5XyikItwz86Fk2RzuJQmhoYdCfWTb1Z+d+ZVNNV90=;
        h=Subject:To:Cc:From:Date:From;
        b=LA0eU0vV/SRCO09ED/N+7nZzxYMOxjM5e7byEUV+dHzm2bhOJFUZ3CAGKZ3SWSCBd
         GVBNsNLrLCRikXisMs68PVuaX1PTY9tVR58DkJm9Xth0rt9NOkUap7fhazyScIlPt4
         OBkLl7+kaFvE6ZdpFlAqEIVZC3TWoIqc+xDH2oN4=
Subject: FAILED: patch "[PATCH] btrfs: don't wait for writeback on clean pages in" failed to apply to 4.19-stable tree
To:     hch@lst.de, dsterba@suse.com, josef@toxicpanda.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 23:41:47 +0200
Message-ID: <2023081247-fiddling-guise-6829@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 5c25699871112853f231e52d51c576d5c759a020
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081247-fiddling-guise-6829@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5c25699871112853f231e52d51c576d5c759a020 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 24 Jul 2023 06:26:54 -0700
Subject: [PATCH] btrfs: don't wait for writeback on clean pages in
 extent_write_cache_pages

__extent_writepage could have started on more pages than the one it was
called for.  This happens regularly for zoned file systems, and in theory
could happen for compressed I/O if the worker thread was executed very
quickly. For such pages extent_write_cache_pages waits for writeback
to complete before moving on to the next page, which is highly inefficient
as it blocks the flusher thread.

Port over the PageDirty check that was added to write_cache_pages in
commit 515f4a037fb ("mm: write_cache_pages optimise page cleaning") to
fix this.

CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c36eb4956f81..ca765d62324f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2145,6 +2145,12 @@ static int extent_write_cache_pages(struct address_space *mapping,
 				continue;
 			}
 
+			if (!folio_test_dirty(folio)) {
+				/* Someone wrote it for us. */
+				folio_unlock(folio);
+				continue;
+			}
+
 			if (wbc->sync_mode != WB_SYNC_NONE) {
 				if (folio_test_writeback(folio))
 					submit_write_bio(bio_ctrl, 0);

