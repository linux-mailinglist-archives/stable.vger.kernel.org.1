Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2AA735266
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjFSKeT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjFSKeJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:34:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA85CE77
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F54460B5E
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7732BC433C0;
        Mon, 19 Jun 2023 10:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170843;
        bh=yYRZOfSY4K/fBcSUl6kbFY/O8J+kUVfRISDeqiFaAuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wMImtDBbPWFwPO+jXqI0KrP7nsnl3tAgALWH+LSCIz7JqCl5HPTIxrnA5MPnjEYIZ
         mhtkIBojAnchu5Zybbrq//BI0TkMtwPw76rngMcIZ/qx3Gm2cOcJ+7151Fpf26j2Bu
         A2JcEFUQf2aqO0IG49lDl24dx/c7jOKjb8xq1YFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        syzbot+33494cd0df2ec2931851@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.3 055/187] nilfs2: fix possible out-of-bounds segment allocation in resize ioctl
Date:   Mon, 19 Jun 2023 12:27:53 +0200
Message-ID: <20230619102200.327737863@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit fee5eaecca86afa544355569b831c1f90f334b85 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/sufile.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
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


