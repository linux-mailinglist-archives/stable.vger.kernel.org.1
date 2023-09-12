Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E77679B503
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353933AbjIKVvh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbjIKOaT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:30:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B402F0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:30:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97706C433C8;
        Mon, 11 Sep 2023 14:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442614;
        bh=AOdd3BkDwF3JSM4FGZVHHZ+9wHLz3JJ0xrm0pARvO3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b58YHbrxUxKK0MUfRKa5LapwMtKqXA75eTIrhijr6lmr7cT5frk3HHy10e85bcrYx
         tkCA/O6iH7Mwm0mx61c5XelEvEtVy8ni06E4y2Nc7uAK7xSpVwVSKolkWGb7KeQB0s
         UPPtm5em94uB/BsT0vdHppldAbnwbHW3qZ2KVltA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kemeng Shi <shikemeng@huaweicloud.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Jan Kara <jack@suse.cz>, David Jeffery <djeffery@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.4 086/737] sbitmap: fix batching wakeup
Date:   Mon, 11 Sep 2023 15:39:05 +0200
Message-ID: <20230911134652.907130519@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Jeffery <djeffery@redhat.com>

commit 106397376c0369fcc01c58dd189ff925a2724a57 upstream.

Current code supposes that it is enough to provide forward progress by
just waking up one wait queue after one completion batch is done.

Unfortunately this way isn't enough, cause waiter can be added to wait
queue just after it is woken up.

Follows one example(64 depth, wake_batch is 8)

1) all 64 tags are active

2) in each wait queue, there is only one single waiter

3) each time one completion batch(8 completions) wakes up just one
   waiter in each wait queue, then immediately one new sleeper is added
   to this wait queue

4) after 64 completions, 8 waiters are wakeup, and there are still 8
   waiters in each wait queue

5) after another 8 active tags are completed, only one waiter can be
   wakeup, and the other 7 can't be waken up anymore.

Turns out it isn't easy to fix this problem, so simply wakeup enough
waiters for single batch.

Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Link: https://lore.kernel.org/r/20230721095715.232728-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/sbitmap.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -550,7 +550,7 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_min_shal
 
 static void __sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
 {
-	int i, wake_index;
+	int i, wake_index, woken;
 
 	if (!atomic_read(&sbq->ws_active))
 		return;
@@ -567,13 +567,12 @@ static void __sbitmap_queue_wake_up(stru
 		 */
 		wake_index = sbq_index_inc(wake_index);
 
-		/*
-		 * It is sufficient to wake up at least one waiter to
-		 * guarantee forward progress.
-		 */
-		if (waitqueue_active(&ws->wait) &&
-		    wake_up_nr(&ws->wait, nr))
-			break;
+		if (waitqueue_active(&ws->wait)) {
+			woken = wake_up_nr(&ws->wait, nr);
+			if (woken == nr)
+				break;
+			nr -= woken;
+		}
 	}
 
 	if (wake_index != atomic_read(&sbq->wake_index))


