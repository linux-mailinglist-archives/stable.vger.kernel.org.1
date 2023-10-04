Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C137B8A4F
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244399AbjJDSeQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244383AbjJDSeP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:34:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30707DD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:34:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE6EC433CA;
        Wed,  4 Oct 2023 18:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444450;
        bh=yG8UkNoYGrOBm3sCAH2yCSqfMO5sMoP9tkvXiWJIvpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aOllZANEpxjFKDBXm7sBG+ESMHEYa6OiTYAumLSG0/rdTAfiaMA+yUt+tSFuMvsNP
         ktxOnVUFYnFn8sqoJR+lpinTbhAdytR0WnIyMFS+WMDHydifGE1GBjeuZGDdMnWglK
         JIUUyXWAtY+Vf/yFAwQo8IIBtVQ59E7LBYt2UDCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pan Bian <bianpan2016@163.com>,
        Ferry Meng <mengferry@linux.alibaba.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.5 255/321] nilfs2: fix potential use after free in nilfs_gccache_submit_read_data()
Date:   Wed,  4 Oct 2023 19:56:40 +0200
Message-ID: <20231004175241.082564220@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pan Bian <bianpan2016@163.com>

commit 7ee29facd8a9c5a26079148e36bcf07141b3a6bc upstream.

In nilfs_gccache_submit_read_data(), brelse(bh) is called to drop the
reference count of bh when the call to nilfs_dat_translate() fails.  If
the reference count hits 0 and its owner page gets unlocked, bh may be
freed.  However, bh->b_page is dereferenced to put the page after that,
which may result in a use-after-free bug.  This patch moves the release
operation after unlocking and putting the page.

NOTE: The function in question is only called in GC, and in combination
with current userland tools, address translation using DAT does not occur
in that function, so the code path that causes this issue will not be
executed.  However, it is possible to run that code path by intentionally
modifying the userland GC library or by calling the GC ioctl directly.

[konishi.ryusuke@gmail.com: NOTE added to the commit log]
Link: https://lkml.kernel.org/r/1543201709-53191-1-git-send-email-bianpan2016@163.com
Link: https://lkml.kernel.org/r/20230921141731.10073-1-konishi.ryusuke@gmail.com
Fixes: a3d93f709e89 ("nilfs2: block cache for garbage collection")
Signed-off-by: Pan Bian <bianpan2016@163.com>
Reported-by: Ferry Meng <mengferry@linux.alibaba.com>
Closes: https://lkml.kernel.org/r/20230818092022.111054-1-mengferry@linux.alibaba.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/gcinode.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -73,10 +73,8 @@ int nilfs_gccache_submit_read_data(struc
 		struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
 
 		err = nilfs_dat_translate(nilfs->ns_dat, vbn, &pbn);
-		if (unlikely(err)) { /* -EIO, -ENOMEM, -ENOENT */
-			brelse(bh);
+		if (unlikely(err)) /* -EIO, -ENOMEM, -ENOENT */
 			goto failed;
-		}
 	}
 
 	lock_buffer(bh);
@@ -102,6 +100,8 @@ int nilfs_gccache_submit_read_data(struc
  failed:
 	unlock_page(bh->b_page);
 	put_page(bh->b_page);
+	if (unlikely(err))
+		brelse(bh);
 	return err;
 }
 


