Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1EC7611AE
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjGYKyj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbjGYKyC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:54:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53661421D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CF3D6166F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397E8C433C8;
        Tue, 25 Jul 2023 10:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282332;
        bh=BKTqJouS8yPK9eFZoLcOwHKr19TEjAMyG0eagwvqU4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UrhrSXny9tRD8And1a8SS7VxbdrJImlClS8IQBQ2Z7TWSCWvfZm1lSBCjm8CuQZjn
         Cvah9nCjwxJgyTCmWHXHOS7lp3lE5gT7lFmdo2HDdfGlsWjiWUvWLjTd5aKjY/HHlV
         qWJdOjFHiIQhydK2GaDQQ0dWVPHktEu2gc3fpu5E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guangwu Zhang <guazhang@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 091/227] blk-mq: fix NULL dereference on q->elevator in blk_mq_elv_switch_none
Date:   Tue, 25 Jul 2023 12:44:18 +0200
Message-ID: <20230725104518.490601273@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 245165658e1c9f95c0fecfe02b9b1ebd30a1198a ]

After grabbing q->sysfs_lock, q->elevator may become NULL because of
elevator switch.

Fix the NULL dereference on q->elevator by checking it with lock.

Reported-by: Guangwu Zhang <guazhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20230616132354.415109-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b9f4546139894..73ed8ccb09ce8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4617,9 +4617,6 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 {
 	struct blk_mq_qe_pair *qe;
 
-	if (!q->elevator)
-		return true;
-
 	qe = kmalloc(sizeof(*qe), GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);
 	if (!qe)
 		return false;
@@ -4627,6 +4624,12 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	/* q->elevator needs protection from ->sysfs_lock */
 	mutex_lock(&q->sysfs_lock);
 
+	/* the check has to be done with holding sysfs_lock */
+	if (!q->elevator) {
+		kfree(qe);
+		goto unlock;
+	}
+
 	INIT_LIST_HEAD(&qe->node);
 	qe->q = q;
 	qe->type = q->elevator->type;
@@ -4634,6 +4637,7 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	__elevator_get(qe->type);
 	list_add(&qe->node, head);
 	elevator_disable(q);
+unlock:
 	mutex_unlock(&q->sysfs_lock);
 
 	return true;
-- 
2.39.2



