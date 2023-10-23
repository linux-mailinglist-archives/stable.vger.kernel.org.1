Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051937D31A4
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjJWLL2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjJWLL2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:11:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864E099
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:11:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4862C433C8;
        Mon, 23 Oct 2023 11:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059486;
        bh=t5qLN3MxYJfBbwxP3YNL+cG5kXg1B8z6xBvmRZOG5Dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RqGi9Su5YfjrSYHiMoPsKdJf2dvmInAWIYJx1HoPIs12k4FRSLnzthjVsuM6K3fP/
         a/6shWg5ZL+3OEnO2Z1lPL6sim1MzTmN+HnCYjslLreazI9G1FjE6u6lb4sku37PYL
         aqkolknd6SVTzxCKgAVoqaD4qY2t3hIVoycmJuhg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maurizio Lombardi <mlombard@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6.5 193/241] nvme-rdma: do not try to stop unallocated queues
Date:   Mon, 23 Oct 2023 12:56:19 +0200
Message-ID: <20231023104838.579160459@linuxfoundation.org>
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

From: Maurizio Lombardi <mlombard@redhat.com>

commit 3820c4fdc247b6f0a4162733bdb8ddf8f2e8a1e4 upstream.

Trying to stop a queue which hasn't been allocated will result
in a warning due to calling mutex_lock() against an uninitialized mutex.

 DEBUG_LOCKS_WARN_ON(lock->magic != lock)
 WARNING: CPU: 4 PID: 104150 at kernel/locking/mutex.c:579

 Call trace:
  RIP: 0010:__mutex_lock+0x1173/0x14a0
  nvme_rdma_stop_queue+0x1b/0xa0 [nvme_rdma]
  nvme_rdma_teardown_io_queues.part.0+0xb0/0x1d0 [nvme_rdma]
  nvme_rdma_delete_ctrl+0x50/0x100 [nvme_rdma]
  nvme_do_delete_ctrl+0x149/0x158 [nvme_core]

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/rdma.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -638,6 +638,9 @@ static void __nvme_rdma_stop_queue(struc
 
 static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 {
+	if (!test_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
+		return;
+
 	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags))
 		__nvme_rdma_stop_queue(queue);


