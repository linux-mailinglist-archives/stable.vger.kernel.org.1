Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BF9703BA6
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244714AbjEOSFM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244989AbjEOSEx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:04:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232A4189BE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:02:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABBD163071
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA60C433EF;
        Mon, 15 May 2023 18:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173749;
        bh=/psOibmtnnkcz1+tirmhsBiDgkCvd5+0ZG4x9ICNoaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fMxH3WjntnpakiB8lCqvWWm3OFnGsdF1ikdHSJl0+h4WFL3haVTT1H/6tpgTloKUK
         YfY0BDXhFk4UDqqYNw/Fdxubg88LNMZ2P84Uv1YUF88gX/PMHWCec04Rb0CYfRva/9
         ZkBDpZ/kAihI5W1cdTgurYuxQj3HP5iMB0wgJtqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        syzbot+221d75710bde87fa0e97@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4 194/282] nilfs2: fix infinite loop in nilfs_mdt_get_block()
Date:   Mon, 15 May 2023 18:29:32 +0200
Message-Id: <20230515161728.076559485@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

commit a6a491c048882e7e424d407d32cba0b52d9ef2bf upstream.

If the disk image that nilfs2 mounts is corrupted and a virtual block
address obtained by block lookup for a metadata file is invalid,
nilfs_bmap_lookup_at_level() may return the same internal return code as
-ENOENT, meaning the block does not exist in the metadata file.

This duplication of return codes confuses nilfs_mdt_get_block(), causing
it to read and create a metadata block indefinitely.

In particular, if this happens to the inode metadata file, ifile,
semaphore i_rwsem can be left held, causing task hangs in lock_mount.

Fix this issue by making nilfs_bmap_lookup_at_level() treat virtual block
address translation failures with -ENOENT as metadata corruption instead
of returning the error code.

Link: https://lkml.kernel.org/r/20230430193046.6769-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+221d75710bde87fa0e97@syzkaller.appspotmail.com
  Link: https://syzkaller.appspot.com/bug?extid=221d75710bde87fa0e97
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/bmap.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/fs/nilfs2/bmap.c
+++ b/fs/nilfs2/bmap.c
@@ -67,20 +67,28 @@ int nilfs_bmap_lookup_at_level(struct ni
 
 	down_read(&bmap->b_sem);
 	ret = bmap->b_ops->bop_lookup(bmap, key, level, ptrp);
-	if (ret < 0) {
-		ret = nilfs_bmap_convert_error(bmap, __func__, ret);
+	if (ret < 0)
 		goto out;
-	}
+
 	if (NILFS_BMAP_USE_VBN(bmap)) {
 		ret = nilfs_dat_translate(nilfs_bmap_get_dat(bmap), *ptrp,
 					  &blocknr);
 		if (!ret)
 			*ptrp = blocknr;
+		else if (ret == -ENOENT) {
+			/*
+			 * If there was no valid entry in DAT for the block
+			 * address obtained by b_ops->bop_lookup, then pass
+			 * internal code -EINVAL to nilfs_bmap_convert_error
+			 * to treat it as metadata corruption.
+			 */
+			ret = -EINVAL;
+		}
 	}
 
  out:
 	up_read(&bmap->b_sem);
-	return ret;
+	return nilfs_bmap_convert_error(bmap, __func__, ret);
 }
 
 int nilfs_bmap_lookup_contig(struct nilfs_bmap *bmap, __u64 key, __u64 *ptrp,


