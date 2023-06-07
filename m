Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30F7726FC5
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbjFGVBK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbjFGVAq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:00:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A852121
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:00:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF870648D3
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 21:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBF0C433D2;
        Wed,  7 Jun 2023 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171624;
        bh=olsUV6eDcmHnx/fL5hia89UDW05rIxgTusM4aF0wg/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y78FTGh4mAPBe/qgWL/SDVvIxXO4gqThQg0B8ynvF9ONuzoY2lwdj12ZB9bkwc9lN
         +5cUzDmkZtk3SJy9EoabQfaokGm4oTATSyC0TISP4bu/SiJl7GFi620JyXkUgW13HN
         dWgkr7auJgDMmEBWtfLfe29Vq05x69XgKUbHYVYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 089/159] nvme-multipath: dont call blk_mark_disk_dead in nvme_mpath_remove_disk
Date:   Wed,  7 Jun 2023 22:16:32 +0200
Message-ID: <20230607200906.611816454@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 1743e5f6000901a11f4e1cd741bfa9136f3ec9b1 ]

nvme_mpath_remove_disk is called after del_gendisk, at which point a
blk_mark_disk_dead call doesn't make any sense.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 8d97b942de01f..73eddb67f0d24 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -821,7 +821,6 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
-	blk_mark_disk_dead(head->disk);
 	/* make sure all pending bios are cleaned up */
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
-- 
2.39.2



