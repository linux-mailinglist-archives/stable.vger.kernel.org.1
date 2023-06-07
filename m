Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0B4726A45
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjFGUAW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjFGUAL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:00:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A81D213C;
        Wed,  7 Jun 2023 13:00:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27F8D64212;
        Wed,  7 Jun 2023 20:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81345C433EF;
        Wed,  7 Jun 2023 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686168006;
        bh=/tI9xtvOXHdkAmavmI2GAMQjDBprkaMZPhxk4MW1OrQ=;
        h=Date:To:From:Subject:From;
        b=S77wm29MRWok/1FKo88ZsSF7AzPrYGbSFhFsTBf5lgD+UPvlcRDBMrG//X1CMIlF4
         Uex/Y7i8kgFcr3Ms9wczQ0Ubap97FaZg0h33TZ+UrBHrz2cE3miWgfiHtmT8NwJ4wO
         d3UZUASJYEGAuEXfn4vuOaqSctdqsk7blY14zKzY=
Date:   Wed, 07 Jun 2023 13:00:05 -0700
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org,
        konishi.ryusuke@gmail.com, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] nilfs2-fix-possible-out-of-bounds-segment-allocation-in-resize-ioctl.patch removed from -mm tree
Message-Id: <20230607200006.81345C433EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The quilt patch titled
     Subject: nilfs2: fix possible out-of-bounds segment allocation in resize ioctl
has been removed from the -mm tree.  Its filename was
     nilfs2-fix-possible-out-of-bounds-segment-allocation-in-resize-ioctl.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: nilfs2: fix possible out-of-bounds segment allocation in resize ioctl
Date: Wed, 24 May 2023 18:43:48 +0900

Syzbot reports that in its stress test for resize ioctl, the log writing
function nilfs_segctor_do_construct hits a WARN_ON in
nilfs_segctor_truncate_segments().

It turned out that there is a problem with the current implementation of
the resize ioctl, which changes the writable range on the device (the
range of allocatable segments) at the end of the resize process.

This order is necessary for file system expansion to avoid corrupting the
superblock at trailing edge.  However, in the case of a file system
shrink, if log writes occur after truncating out-of-bounds trailing
segments and before the resize is complete, segments may be allocated from
the truncated space.

The userspace resize tool was fine as it limits the range of allocatable
segments before performing the resize, but it can run into this issue if
the resize ioctl is called alone.

Fix this issue by changing nilfs_sufile_resize() to update the range of
allocatable segments immediately after successful truncation of segment
space in case of file system shrink.

Link: https://lkml.kernel.org/r/20230524094348.3784-1-konishi.ryusuke@gmail.com
Fixes: 4e33f9eab07e ("nilfs2: implement resize ioctl")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+33494cd0df2ec2931851@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/0000000000005434c405fbbafdc5@google.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/nilfs2/sufile.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/nilfs2/sufile.c~nilfs2-fix-possible-out-of-bounds-segment-allocation-in-resize-ioctl
+++ a/fs/nilfs2/sufile.c
@@ -779,6 +779,15 @@ int nilfs_sufile_resize(struct inode *su
 			goto out_header;
 
 		sui->ncleansegs -= nsegs - newnsegs;
+
+		/*
+		 * If the sufile is successfully truncated, immediately adjust
+		 * the segment allocation space while locking the semaphore
+		 * "mi_sem" so that nilfs_sufile_alloc() never allocates
+		 * segments in the truncated space.
+		 */
+		sui->allocmax = newnsegs - 1;
+		sui->allocmin = 0;
 	}
 
 	kaddr = kmap_atomic(header_bh->b_page);
_

Patches currently in -mm which might be from konishi.ryusuke@gmail.com are


