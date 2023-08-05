Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9B17710CF
	for <lists+stable@lfdr.de>; Sat,  5 Aug 2023 19:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjHEROW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 5 Aug 2023 13:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEROV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 5 Aug 2023 13:14:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60B94206;
        Sat,  5 Aug 2023 10:14:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50C1C60C5F;
        Sat,  5 Aug 2023 17:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA94C433C8;
        Sat,  5 Aug 2023 17:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691255659;
        bh=xwg0fbSYrmj04Vpj4s7dPOBn3AlYHNis+aZqErz6pnk=;
        h=Date:To:From:Subject:From;
        b=lG5AOjoI/ixur9NzmDV4WCtZ7AeFIUJpGvNT3+wq3Qo+ZOa0xGxMsXkpCeN9BQfSY
         SHizs/nurwou0MamVEgSbOznd4l5+pgzNNJCAKwKC8fbvR4WP0xo51j4YXXBB1z6Vp
         HCdD6mxue7qG5xh+sYHUTcxJP8pcl69b1toheP0M=
Date:   Sat, 05 Aug 2023 10:14:17 -0700
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org,
        konishi.ryusuke@gmail.com, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + nilfs2-fix-general-protection-fault-in-nilfs_lookup_dirty_data_buffers.patch added to mm-hotfixes-unstable branch
Message-Id: <20230805171419.9EA94C433C8@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: nilfs2: fix general protection fault in nilfs_lookup_dirty_data_buffers()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     nilfs2-fix-general-protection-fault-in-nilfs_lookup_dirty_data_buffers.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/nilfs2-fix-general-protection-fault-in-nilfs_lookup_dirty_data_buffers.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: nilfs2: fix general protection fault in nilfs_lookup_dirty_data_buffers()
Date: Sat, 5 Aug 2023 22:20:38 +0900

A syzbot stress test reported that create_empty_buffers() called from
nilfs_lookup_dirty_data_buffers() can cause a general protection fault.

Analysis using its reproducer revealed that the back reference "mapping"
from a page/folio has been changed to NULL after dirty page/folio gang
lookup in nilfs_lookup_dirty_data_buffers().

Fix this issue by excluding pages/folios from being collected if, after
acquiring a lock on each page/folio, its back reference "mapping" differs
from the pointer to the address space struct that held the page/folio.

Link: https://lkml.kernel.org/r/20230805132038.6435-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+0ad741797f4565e7e2d2@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/0000000000002930a705fc32b231@google.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/nilfs2/segment.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/nilfs2/segment.c~nilfs2-fix-general-protection-fault-in-nilfs_lookup_dirty_data_buffers
+++ a/fs/nilfs2/segment.c
@@ -725,6 +725,11 @@ static size_t nilfs_lookup_dirty_data_bu
 		struct folio *folio = fbatch.folios[i];
 
 		folio_lock(folio);
+		if (unlikely(folio->mapping != mapping)) {
+			/* Exclude folios removed from the address space */
+			folio_unlock(folio);
+			continue;
+		}
 		head = folio_buffers(folio);
 		if (!head) {
 			create_empty_buffers(&folio->page, i_blocksize(inode), 0);
_

Patches currently in -mm which might be from konishi.ryusuke@gmail.com are

nilfs2-fix-general-protection-fault-in-nilfs_lookup_dirty_data_buffers.patch

