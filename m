Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705CE703ABB
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbjEORzQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241787AbjEORyf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:54:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DEB183FE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76A5A62F92
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AA5C433D2;
        Mon, 15 May 2023 17:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173075;
        bh=Gf5vcxUqVMXCCfZA7pUAKHw/feiI8+HhUqgKVzG2U3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dcb+nCcTaw7w8rZ7dDLFNQn0fiLGO6aopkpGEIGDPlAJONjzUXJVa6MWfP0JsCtMg
         fvlI7y/P8qdc0OMUJ40FleNyrOO0hrjzGWjJHqZVpQ9kycSgOOMDtFkfpq6J8and0c
         SMXbC5arxnPaRgMV7fKgijOf7Y2xH0WLFxyH7x+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        syzbot+4a03518df1e31b537066@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.10 360/381] ext4: fix data races when using cached status extents
Date:   Mon, 15 May 2023 18:30:11 +0200
Message-Id: <20230515161753.165129609@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Jan Kara <jack@suse.cz>

commit 492888df0c7b42fc0843631168b0021bc4caee84 upstream.

When using cached extent stored in extent status tree in tree->cache_es
another process holding ei->i_es_lock for reading can be racing with us
setting new value of tree->cache_es. If the compiler would decide to
refetch tree->cache_es at an unfortunate moment, it could result in a
bogus in_range() check. Fix the possible race by using READ_ONCE() when
using tree->cache_es only under ei->i_es_lock for reading.

Cc: stable@kernel.org
Reported-by: syzbot+4a03518df1e31b537066@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/000000000000d3b33905fa0fd4a6@google.com
Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230504125524.10802-1-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/extents_status.c |   30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -269,14 +269,12 @@ static void __es_find_extent_range(struc
 
 	/* see if the extent has been cached */
 	es->es_lblk = es->es_len = es->es_pblk = 0;
-	if (tree->cache_es) {
-		es1 = tree->cache_es;
-		if (in_range(lblk, es1->es_lblk, es1->es_len)) {
-			es_debug("%u cached by [%u/%u) %llu %x\n",
-				 lblk, es1->es_lblk, es1->es_len,
-				 ext4_es_pblock(es1), ext4_es_status(es1));
-			goto out;
-		}
+	es1 = READ_ONCE(tree->cache_es);
+	if (es1 && in_range(lblk, es1->es_lblk, es1->es_len)) {
+		es_debug("%u cached by [%u/%u) %llu %x\n",
+			 lblk, es1->es_lblk, es1->es_len,
+			 ext4_es_pblock(es1), ext4_es_status(es1));
+		goto out;
 	}
 
 	es1 = __es_tree_search(&tree->root, lblk);
@@ -295,7 +293,7 @@ out:
 	}
 
 	if (es1 && matching_fn(es1)) {
-		tree->cache_es = es1;
+		WRITE_ONCE(tree->cache_es, es1);
 		es->es_lblk = es1->es_lblk;
 		es->es_len = es1->es_len;
 		es->es_pblk = es1->es_pblk;
@@ -934,14 +932,12 @@ int ext4_es_lookup_extent(struct inode *
 
 	/* find extent in cache firstly */
 	es->es_lblk = es->es_len = es->es_pblk = 0;
-	if (tree->cache_es) {
-		es1 = tree->cache_es;
-		if (in_range(lblk, es1->es_lblk, es1->es_len)) {
-			es_debug("%u cached by [%u/%u)\n",
-				 lblk, es1->es_lblk, es1->es_len);
-			found = 1;
-			goto out;
-		}
+	es1 = READ_ONCE(tree->cache_es);
+	if (es1 && in_range(lblk, es1->es_lblk, es1->es_len)) {
+		es_debug("%u cached by [%u/%u)\n",
+			 lblk, es1->es_lblk, es1->es_len);
+		found = 1;
+		goto out;
 	}
 
 	node = tree->root.rb_node;


