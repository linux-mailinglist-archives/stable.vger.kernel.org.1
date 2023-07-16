Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8C8754E41
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 12:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjGPKQE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 06:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGPKQE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 06:16:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3358E46
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 03:16:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FDC160C7A
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 10:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD5DC433C7;
        Sun, 16 Jul 2023 10:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689502562;
        bh=LPtZ/Tha5HUgRnDK0NcrKpO9n2v7lzyEcBtJNNYfGrA=;
        h=Subject:To:Cc:From:Date:From;
        b=sqQE+dvpE/jn1CR/q/zPepIJGHu+a7yt7EfQczoP9QUl19DwYwQEgf/cu0jg0GwXK
         WDkTDh4aMTmv8+AMpLBZmbA2METiMWEejoNiNPcUtfQmrUrRv0WJmxHcGFHHZV659z
         FEO3sP1hqSr058ADfXoN7Q3GmflM5fGaW9d/O4Yg=
Subject: FAILED: patch "[PATCH] btrfs: fix fsverify read error handling in end_page_read" failed to apply to 5.15-stable tree
To:     hch@lst.de, dsterba@suse.com, josef@toxicpanda.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 12:15:49 +0200
Message-ID: <2023071649-pushcart-bobtail-27e7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2c14f0ffdd30bd3d321ad5fe76fcf701746e1df6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071649-pushcart-bobtail-27e7@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

2c14f0ffdd30 ("btrfs: fix fsverify read error handling in end_page_read")
ed9ee98ecb4f ("btrfs: factor out a btrfs_verify_page helper")
0571b6357c5e ("btrfs: remove the io_failure_record infrastructure")
7609afac6775 ("btrfs: handle checksum validation and repair at the storage layer")
7276aa7d3825 ("btrfs: save the bio iter for checksum validation in common code")
d0e5cb2be770 ("btrfs: add a btrfs_inode pointer to struct btrfs_bio")
e0cfbb2ccabb ("btrfs: better document struct btrfs_bio")
bacf60e51586 ("btrfs: move repair_io_failure to bio.c")
103c19723c80 ("btrfs: split the bio submission path into a separate file")
cb3e217bdb39 ("btrfs: use btrfs_dev_name() helper to handle missing devices better")
2c8f5e8cdf0f ("btrfs: remove leftover setting of EXTENT_UPTODATE state in an inode's io_tree")
947a629988f1 ("btrfs: move tree block parentness check into validate_extent_buffer()")
789d6a3a876e ("btrfs: concentrate all tree block parentness check parameters into one structure")
35da5a7edec3 ("btrfs: drop private_data parameter from extent_io_tree_init")
621af94af334 ("btrfs: pass btrfs_inode to btrfs_check_data_csum")
bb41632ea7d2 ("btrfs: pass btrfs_inode to btrfs_submit_dio_bio")
e2884c3d4456 ("btrfs: switch btrfs_dio_private::inode to btrfs_inode")
d8f9268ece91 ("btrfs: pass btrfs_inode to btrfs_repair_one_sector")
d781c1c315ce ("btrfs: pass btrfs_inode to btrfs_submit_dio_repair_bio")
b762041629e7 ("btrfs: pass btrfs_inode to btrfs_submit_data_read_bio")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2c14f0ffdd30bd3d321ad5fe76fcf701746e1df6 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 31 May 2023 08:04:52 +0200
Subject: [PATCH] btrfs: fix fsverify read error handling in end_page_read

Also clear the uptodate bit to make sure the page isn't seen as uptodate
in the page cache if fsverity verification fails.

Fixes: 146054090b08 ("btrfs: initial fsverity support")
CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8e42ce48b52e..a943a6622489 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -497,12 +497,8 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 	ASSERT(page_offset(page) <= start &&
 	       start + len <= page_offset(page) + PAGE_SIZE);
 
-	if (uptodate) {
-		if (!btrfs_verify_page(page, start)) {
-			btrfs_page_set_error(fs_info, page, start, len);
-		} else {
-			btrfs_page_set_uptodate(fs_info, page, start, len);
-		}
+	if (uptodate && btrfs_verify_page(page, start)) {
+		btrfs_page_set_uptodate(fs_info, page, start, len);
 	} else {
 		btrfs_page_clear_uptodate(fs_info, page, start, len);
 		btrfs_page_set_error(fs_info, page, start, len);

