Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FD9735322
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjFSKmG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjFSKlm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:41:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00D6100
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:41:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6288060B80
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7365AC433C0;
        Mon, 19 Jun 2023 10:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171300;
        bh=HGowgLVCc9rXBMtm3tcVpOnG4GSmiIoE/D2kpZzDGHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMrbEi1E0wLA79Kla8RqgWtDdxqB04CZDO6BjTsVvVPqUTW/Y4aFYmZa/hjdasnVH
         MfIE9PcRwWA3VN5iN67a7edmpBFkQ6+xDOgxSQzAPPpkj5BU2NDQ66imyhQvybfWPO
         qE7+KbJlI7fPTtTW3knUSQTelrzDKJQTiYFssmbE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maor Gottlieb <maorg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 32/49] IB/uverbs: Fix to consider event queue closing also upon non-blocking mode
Date:   Mon, 19 Jun 2023 12:30:10 +0200
Message-ID: <20230619102131.550646975@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102129.856988902@linuxfoundation.org>
References: <20230619102129.856988902@linuxfoundation.org>
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

From: Yishai Hadas <yishaih@nvidia.com>

[ Upstream commit 62fab312fa1683e812e605db20d4f22de3e3fb2f ]

Fix ib_uverbs_event_read() to consider event queue closing also upon
non-blocking mode.

Once the queue is closed (e.g. hot-plug flow) all the existing events
are cleaned-up as part of ib_uverbs_free_event_queue().

An application that uses the non-blocking FD mode should get -EIO in
that case to let it knows that the device was removed already.

Otherwise, it can loose the indication that the device was removed and
won't recover.

As part of that, refactor the code to have a single flow with regards to
'is_closed' for both blocking and non-blocking modes.

Fixes: 14e23bd6d221 ("RDMA/core: Fix locking in ib_uverbs_event_read")
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Link: https://lore.kernel.org/r/97b00116a1e1e13f8dc4ec38a5ea81cf8c030210.1685960567.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/uverbs_main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index fc4b46258c756..6d8925432d6a7 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -283,8 +283,12 @@ static ssize_t ib_uverbs_event_read(struct ib_uverbs_event_queue *ev_queue,
 	spin_lock_irq(&ev_queue->lock);
 
 	while (list_empty(&ev_queue->event_list)) {
-		spin_unlock_irq(&ev_queue->lock);
+		if (ev_queue->is_closed) {
+			spin_unlock_irq(&ev_queue->lock);
+			return -EIO;
+		}
 
+		spin_unlock_irq(&ev_queue->lock);
 		if (filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 
@@ -294,12 +298,6 @@ static ssize_t ib_uverbs_event_read(struct ib_uverbs_event_queue *ev_queue,
 			return -ERESTARTSYS;
 
 		spin_lock_irq(&ev_queue->lock);
-
-		/* If device was disassociated and no event exists set an error */
-		if (list_empty(&ev_queue->event_list) && ev_queue->is_closed) {
-			spin_unlock_irq(&ev_queue->lock);
-			return -EIO;
-		}
 	}
 
 	event = list_entry(ev_queue->event_list.next, struct ib_uverbs_event, list);
-- 
2.39.2



