Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B2476AEFF
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjHAJoA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjHAJnl (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:43:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C825254
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:41:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBA7461514
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9F5C433C7;
        Tue,  1 Aug 2023 09:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882877;
        bh=w+avc87IUA49qshDebpm+os9gnuFYcn9IGfIZQlT+qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mO9+p5l0VrYjiZtOPY0Wv1A0n/4SxuWGK+KRKsavTHBzO23fK8lQMbBaqiJpHK65F
         RSAPJn9JHCWt47k6COBfhvtAc9W6vWzyaR93oydlrh6WJ1ORbwvZtHNf6pVTKcz8tz
         2juic8KhHyyhLjcuFUWIeT7qTYovFh4PlHDHPY6o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 008/239] blk-mq: Fix stall due to recursive flush plug
Date:   Tue,  1 Aug 2023 11:17:52 +0200
Message-ID: <20230801091925.947372651@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit 70904263512a74a3b8941dd9e6e515ca6fc57821 ]

We have seen rare IO stalls as follows:

* blk_mq_plug_issue_direct() is entered with an mq_list containing two
requests.
* For the first request, it sets last == false and enters the driver's
queue_rq callback.
* The driver queue_rq callback indirectly calls schedule() which calls
blk_flush_plug(). This may happen if the driver has the
BLK_MQ_F_BLOCKING flag set and is allowed to sleep in ->queue_rq.
* blk_flush_plug() handles the remaining request in the mq_list. mq_list
is now empty.
* The original call to queue_rq resumes (with last == false).
* The loop in blk_mq_plug_issue_direct() terminates because there are no
remaining requests in mq_list.

The IO is now stalled because the last request submitted to the driver
had last == false and there was no subsequent call to commit_rqs().

Fix this by returning early in blk_mq_flush_plug_list() if rq_count is 0
which it will be in the recursive case, rather than checking if the
mq_list is empty. At the same time, adjust one of the callers to skip
the mq_list empty check as it is not necessary.

Fixes: dc5fc361d891 ("block: attempt direct issue of plug list")
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20230714101106.3635611-1-ross.lagerwall@citrix.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-core.c | 3 +--
 block/blk-mq.c   | 9 ++++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 3fc68b9444791..0434f5a8151fe 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1141,8 +1141,7 @@ void __blk_flush_plug(struct blk_plug *plug, bool from_schedule)
 {
 	if (!list_empty(&plug->cb_list))
 		flush_plug_callbacks(plug, from_schedule);
-	if (!rq_list_empty(plug->mq_list))
-		blk_mq_flush_plug_list(plug, from_schedule);
+	blk_mq_flush_plug_list(plug, from_schedule);
 	/*
 	 * Unconditionally flush out cached requests, even if the unplug
 	 * event came from schedule. Since we know hold references to the
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 73ed8ccb09ce8..58bf41e8e66c7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2754,7 +2754,14 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	struct request *rq;
 
-	if (rq_list_empty(plug->mq_list))
+	/*
+	 * We may have been called recursively midway through handling
+	 * plug->mq_list via a schedule() in the driver's queue_rq() callback.
+	 * To avoid mq_list changing under our feet, clear rq_count early and
+	 * bail out specifically if rq_count is 0 rather than checking
+	 * whether the mq_list is empty.
+	 */
+	if (plug->rq_count == 0)
 		return;
 	plug->rq_count = 0;
 
-- 
2.39.2



