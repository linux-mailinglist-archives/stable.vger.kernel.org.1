Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C180A72C077
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbjFLKwu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbjFLKwW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:52:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55945A274
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:36:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 281B1623CE
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDF8C433EF;
        Mon, 12 Jun 2023 10:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566215;
        bh=BTt9CYCRnTGSNG4jXQ6cjiL6QI/d1/JbsRUR0gWrOrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u0l5GuWNeOs8NiZeNVmCajcfcB2l01vYx2UalA3N1X77x230Sh558eZ+i+ei8rzdq
         1v6uTe6V39t0p5PfM7I6ZfDlB8kwGA7icot/G2kyYc6r0v/zqg3QalHHxn+x6rW0w6
         p7lh22fS2jchtuhb0BAdv/8yhIcCUmBj6Xj6VRRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 11/91] platform/surface: aggregator: Allow completion work-items to be executed in parallel
Date:   Mon, 12 Jun 2023 12:26:00 +0200
Message-ID: <20230612101702.555611397@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
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

From: Maximilian Luz <luzmaximilian@gmail.com>

[ Upstream commit 539e0a7f9105d19c00629c3f4da00330488e8c60 ]

Currently, event completion work-items are restricted to be run strictly
in non-parallel fashion by the respective workqueue. However, this has
lead to some problems:

In some instances, the event notifier function called inside this
completion workqueue takes a non-negligible amount of time to execute.
One such example is the battery event handling code (surface_battery.c),
which can result in a full battery information refresh, involving
further synchronous communication with the EC inside the event handler.
This is made worse if the communication fails spuriously, generally
incurring a multi-second timeout.

Since the event completions are run strictly non-parallel, this blocks
other events from being propagated to the respective subsystems. This
becomes especially noticeable for keyboard and touchpad input, which
also funnel their events through this system. Here, users have reported
occasional multi-second "freezes".

Note, however, that the event handling system was never intended to run
purely sequentially. Instead, we have one work struct per EC/SAM
subsystem, processing the event queue for that subsystem. These work
structs were intended to run in parallel, allowing sequential processing
of work items for each subsystem but parallel processing of work items
across subsystems.

The only restriction to this is the way the workqueue is created.
Therefore, replace create_workqueue() with alloc_workqueue() and do not
restrict the maximum number of parallel work items to be executed on
that queue, resolving any cross-subsystem blockage.

Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
Link: https://github.com/linux-surface/linux-surface/issues/1026
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Link: https://lore.kernel.org/r/20230525210110.2785470-1-luzmaximilian@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/surface/aggregator/controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index f23f7128cf2b4..5542b768890c9 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -825,7 +825,7 @@ static int ssam_cplt_init(struct ssam_cplt *cplt, struct device *dev)
 
 	cplt->dev = dev;
 
-	cplt->wq = create_workqueue(SSAM_CPLT_WQ_NAME);
+	cplt->wq = alloc_workqueue(SSAM_CPLT_WQ_NAME, WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
 	if (!cplt->wq)
 		return -ENOMEM;
 
-- 
2.39.2



