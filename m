Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66EE72C1CC
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbjFLLAt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237111AbjFLLAX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF7A49D2
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:47:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B1E46246A
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E74BC4339B;
        Mon, 12 Jun 2023 10:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566829;
        bh=AuaguCctI90FO0aGOFMYzdYt3RaFcGrzvcwifpDBOyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E5IQe5FppWYXQnddd+HoS7/5RkruRd1nDFxS8NclAeCL53zpjNimLBJOJDHXO9k2l
         oC/BwHKk5GcR26Odd2jiGM2X+bJLN736Ae5A2K61hqNt8yVBYYfGRxJlBpfQ8Nuecw
         6C+MbncdMK+6F7huvPOKM1BOR78o5XhKdqD+dezs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vasily Khoruzhick <anarsoul@gmail.com>,
        Erico Nunes <nunes.erico@gmail.com>,
        Qiang Yu <yuq825@gmail.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 046/160] drm/lima: fix sched context destroy
Date:   Mon, 12 Jun 2023 12:26:18 +0200
Message-ID: <20230612101717.142087555@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
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

From: Erico Nunes <nunes.erico@gmail.com>

[ Upstream commit 6eea63c7090b20ee41032d3e478e617b219d69aa ]

The drm sched entity must be flushed before finishing, to account for
jobs potentially still in flight at that time.
Lima did not do this flush until now, so switch the destroy call to the
drm_sched_entity_destroy() wrapper which will take care of that.

This fixes a regression on lima which started since the rework in
commit 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and fini")
where some specific types of applications may hang indefinitely.

Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and fini")
Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
Signed-off-by: Qiang Yu <yuq825@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230606143247.433018-1-nunes.erico@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/lima/lima_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index ff003403fbbc7..ffd91a5ee2990 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -165,7 +165,7 @@ int lima_sched_context_init(struct lima_sched_pipe *pipe,
 void lima_sched_context_fini(struct lima_sched_pipe *pipe,
 			     struct lima_sched_context *context)
 {
-	drm_sched_entity_fini(&context->base);
+	drm_sched_entity_destroy(&context->base);
 }
 
 struct dma_fence *lima_sched_context_queue_task(struct lima_sched_task *task)
-- 
2.39.2



