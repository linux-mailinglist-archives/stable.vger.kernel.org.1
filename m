Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F97E6FAEAC
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbjEHLqn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbjEHLq3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:46:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD7D3F570
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:46:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6A2A637FD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C42C433EF;
        Mon,  8 May 2023 11:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546376;
        bh=LQpPxz336d3/UAH0yBAQ+cpt6pas4oy/AMZdR09vzSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LG/JMt/Yc/u4FwP88MY63Hoj6DOInZ2/Q6GHKfhhEgS5RWOSGdoUFBFiJ6y/KDQU1
         DffZJE00uWKsv/Eb+HrzUEWfWXzBDXwGZCn/tKVg+EV2F1hCT2tQ48/Fm7GevRPi5v
         jmAPQEmxUSdMg3ACk8v8bhnniBKCC6JZ6Ef8c8fE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        syzbot+2af3bc9585be7f23f290@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15 347/371] nilfs2: do not write dirty data after degenerating to read-only
Date:   Mon,  8 May 2023 11:49:08 +0200
Message-Id: <20230508094825.911206355@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit 28a65b49eb53e172d23567005465019658bfdb4d upstream.

According to syzbot's report, mark_buffer_dirty() called from
nilfs_segctor_do_construct() outputs a warning with some patterns after
nilfs2 detects metadata corruption and degrades to read-only mode.

After such read-only degeneration, page cache data may be cleared through
nilfs_clear_dirty_page() which may also clear the uptodate flag for their
buffer heads.  However, even after the degeneration, log writes are still
performed by unmount processing etc., which causes mark_buffer_dirty() to
be called for buffer heads without the "uptodate" flag and causes the
warning.

Since any writes should not be done to a read-only file system in the
first place, this fixes the warning in mark_buffer_dirty() by letting
nilfs_segctor_do_construct() abort early if in read-only mode.

This also changes the retry check of nilfs_segctor_write_out() to avoid
unnecessary log write retries if it detects -EROFS that
nilfs_segctor_do_construct() returned.

Link: https://lkml.kernel.org/r/20230427011526.13457-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+2af3bc9585be7f23f290@syzkaller.appspotmail.com
  Link: https://syzkaller.appspot.com/bug?extid=2af3bc9585be7f23f290
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/segment.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2039,6 +2039,9 @@ static int nilfs_segctor_do_construct(st
 	struct the_nilfs *nilfs = sci->sc_super->s_fs_info;
 	int err;
 
+	if (sb_rdonly(sci->sc_super))
+		return -EROFS;
+
 	nilfs_sc_cstage_set(sci, NILFS_ST_INIT);
 	sci->sc_cno = nilfs->ns_cno;
 
@@ -2724,7 +2727,7 @@ static void nilfs_segctor_write_out(stru
 
 		flush_work(&sci->sc_iput_work);
 
-	} while (ret && retrycount-- > 0);
+	} while (ret && ret != -EROFS && retrycount-- > 0);
 }
 
 /**


