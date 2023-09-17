Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7677A374B
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjIQTRT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjIQTQ4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:16:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B67FA
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:16:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A316C433C8;
        Sun, 17 Sep 2023 19:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978211;
        bh=KjthWBSq7kZJR/jHwLNf/TetOHTDBWeUd/NSz8mBZbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdxPx8ChdFshZtxRYuclCU+T/xWsZTg/Zpv6vjQ+416seEpLYt3MV61IBNFiL2W4H
         LjXS1w/771XMFDOd2e621x4rap9LsBYDzFEv47ZQa2bRASH6ey+K5bHrcVv5XiOaDW
         cHyrmjrkWTP/cuQvYaEQOE0COHWfCz7Q+I6gsOps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sishuai Gong <sishuai@purdue.edu>,
        Christoph Hellwig <hch@lst.de>,
        Kyle Zeng <zengyhkyle@gmail.com>
Subject: [PATCH 5.10 014/406] configfs: fix a race in configfs_lookup()
Date:   Sun, 17 Sep 2023 21:07:48 +0200
Message-ID: <20230917191101.511939651@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sishuai Gong <sishuai@purdue.edu>

commit c42dd069be8dfc9b2239a5c89e73bbd08ab35de0 upstream.

When configfs_lookup() is executing list_for_each_entry(),
it is possible that configfs_dir_lseek() is calling list_del().
Some unfortunate interleavings of them can cause a kernel NULL
pointer dereference error

Thread 1                  Thread 2
//configfs_dir_lseek()    //configfs_lookup()
list_del(&cursor->s_sibling);
                         list_for_each_entry(sd, ...)

Fix this by grabbing configfs_dirent_lock in configfs_lookup()
while iterating ->s_children.

Signed-off-by: Sishuai Gong <sishuai@purdue.edu>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/configfs/dir.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -479,6 +479,7 @@ static struct dentry * configfs_lookup(s
 	if (!configfs_dirent_is_ready(parent_sd))
 		goto out;
 
+	spin_lock(&configfs_dirent_lock);
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
 		if (sd->s_type & CONFIGFS_NOT_PINNED) {
 			const unsigned char * name = configfs_get_name(sd);
@@ -491,6 +492,7 @@ static struct dentry * configfs_lookup(s
 			break;
 		}
 	}
+	spin_unlock(&configfs_dirent_lock);
 
 	if (!found) {
 		/*


