Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA83B7D9780
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 14:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345689AbjJ0MPE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 08:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjJ0MPD (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 08:15:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1C1C0
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 05:15:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E9EC433C7;
        Fri, 27 Oct 2023 12:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698408901;
        bh=w3bu3EQG36CwrcGDPAvOvk2bFGVaUGbJ3PE2lC79R5Y=;
        h=Subject:To:Cc:From:Date:From;
        b=Otfx73gOUTs+gpnkGqMPY7qg6aY2TUdENdC/eCuk0Y4K29Lo2teR2jiBLReeCezF+
         LxxklH5UYancQYhSiWjWaIHtUwZBfbG2Gz37e0yuzHiwYZ9B5Y5Q3ibdeYu5gPbdyH
         CauhIHyN0Ou6SiokCw4I2BLMXF4r6uStB04ysULo=
Subject: FAILED: patch "[PATCH] mm: zswap: fix pool refcount bug around shrink_worker()" failed to apply to 6.1-stable tree
To:     hannes@cmpxchg.org, akpm@linux-foundation.org,
        cerasuolodomenico@gmail.com, clm@fb.com, nphamcs@gmail.com,
        stable@vger.kernel.org, vitaly.wool@konsulko.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 27 Oct 2023 14:14:54 +0200
Message-ID: <2023102753-progress-creatable-e21d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 969d63e1af3b3abe35a49b08218f3125131ac32f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102753-progress-creatable-e21d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 969d63e1af3b3abe35a49b08218f3125131ac32f Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Fri, 6 Oct 2023 12:00:24 -0400
Subject: [PATCH] mm: zswap: fix pool refcount bug around shrink_worker()

When a zswap store fails due to the limit, it acquires a pool reference
and queues the shrinker.  When the shrinker runs, it drops the reference.
However, there can be multiple store attempts before the shrinker wakes up
and runs once.  This results in reference leaks and eventual saturation
warnings for the pool refcount.

Fix this by dropping the reference again when the shrinker is already
queued.  This ensures one reference per shrinker run.

Link: https://lkml.kernel.org/r/20231006160024.170748-1-hannes@cmpxchg.org
Fixes: 45190f01dd40 ("mm/zswap.c: add allocation hysteresis if pool limit is hit")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reported-by: Chris Mason <clm@fb.com>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>
Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: <stable@vger.kernel.org>	[5.6+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/zswap.c b/mm/zswap.c
index 083c693602b8..37d2b1cb2ecb 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1383,8 +1383,8 @@ bool zswap_store(struct folio *folio)
 
 shrink:
 	pool = zswap_pool_last_get();
-	if (pool)
-		queue_work(shrink_wq, &pool->shrink_work);
+	if (pool && !queue_work(shrink_wq, &pool->shrink_work))
+		zswap_pool_put(pool);
 	goto reject;
 }
 

