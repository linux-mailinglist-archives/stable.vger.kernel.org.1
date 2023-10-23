Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F4E7D31D9
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjJWLOA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjJWLN6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:13:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC95992
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:13:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4E6C433C7;
        Mon, 23 Oct 2023 11:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059636;
        bh=njRFGyS93TGa1Mz2HyxNq0zslWZy4nk8t/0rvFYPv1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J0KflVvlB7GE+RWPKU0YH46dBy73/ha74534dVNqq7BEMmN/1eAGGUYBoCeK4MHNd
         21V9a5S7P6aba5xJpRY2glmLw/Hjkux6EWsLwufVviLmQPTi9G4vSseHFaHPmyHxs+
         7LY2bFeKWuHQQ2FFclQdNIT7T1NMjF4SzKKbP1z0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+509238e523e032442b80@syzkaller.appspotmail.com,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.5 236/241] net: rfkill: reduce data->mtx scope in rfkill_fop_open
Date:   Mon, 23 Oct 2023 12:57:02 +0200
Message-ID: <20231023104839.626830775@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit f2ac54ebf85615a6d78f5eb213a8bbeeb17ebe5d upstream.

In syzbot runs, lockdep reports that there's a (potential)
deadlock here of data->mtx being locked recursively. This
isn't really a deadlock since they are different instances,
but lockdep cannot know, and teaching it would be far more
difficult than other fixes.

At the same time we don't even really _need_ the mutex to
be locked in rfkill_fop_open(), since we're modifying only
a completely fresh instance of 'data' (struct rfkill_data)
that's not yet added to the global list.

However, to avoid any reordering etc. within the globally
locked section, and to make the code look more symmetric,
we should still lock the data->events list manipulation,
but also need to lock _only_ that. So do that.

Reported-by: syzbot+509238e523e032442b80@syzkaller.appspotmail.com
Fixes: 2c3dfba4cf84 ("rfkill: sync before userspace visibility/changes")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rfkill/core.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -1180,7 +1180,6 @@ static int rfkill_fop_open(struct inode
 	init_waitqueue_head(&data->read_wait);
 
 	mutex_lock(&rfkill_global_mutex);
-	mutex_lock(&data->mtx);
 	/*
 	 * start getting events from elsewhere but hold mtx to get
 	 * startup events added first
@@ -1192,10 +1191,11 @@ static int rfkill_fop_open(struct inode
 			goto free;
 		rfkill_sync(rfkill);
 		rfkill_fill_event(&ev->ev, rfkill, RFKILL_OP_ADD);
+		mutex_lock(&data->mtx);
 		list_add_tail(&ev->list, &data->events);
+		mutex_unlock(&data->mtx);
 	}
 	list_add(&data->list, &rfkill_fds);
-	mutex_unlock(&data->mtx);
 	mutex_unlock(&rfkill_global_mutex);
 
 	file->private_data = data;
@@ -1203,7 +1203,6 @@ static int rfkill_fop_open(struct inode
 	return stream_open(inode, file);
 
  free:
-	mutex_unlock(&data->mtx);
 	mutex_unlock(&rfkill_global_mutex);
 	mutex_destroy(&data->mtx);
 	list_for_each_entry_safe(ev, tmp, &data->events, list)


