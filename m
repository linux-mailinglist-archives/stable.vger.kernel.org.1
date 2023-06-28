Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419F97408D8
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 05:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjF1DNh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 27 Jun 2023 23:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjF1DNg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Jun 2023 23:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4735A2D54
        for <stable@vger.kernel.org>; Tue, 27 Jun 2023 20:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687921972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DVsWegYjQWBK//10guVuuDzuiAXpy0fbkXve8qAAlEc=;
        b=IuaNgkxPPonMBbG5mhxVz/n2PMptSdiNQgqLwvG3i7kc8LbkzSp3ggcTYgCQs3QdSypWWV
        qDnxAMOdLcNUE6b5rBPr5rUlYLP9NgnezWYGkng4sMJL5ipCm0kJpCCaRaA2nE6/0td7M6
        pXaHu5EukL8VioluHHOSHBrD4/O6eDQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-0H5x98pnMT2Xg8oz0TzGBg-1; Tue, 27 Jun 2023 23:12:48 -0400
X-MC-Unique: 0H5x98pnMT2Xg8oz0TzGBg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 945161C05151;
        Wed, 28 Jun 2023 03:12:45 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA840401061;
        Wed, 28 Jun 2023 03:12:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        Chunguang Xu <brookxu.cn@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org
Subject: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Date:   Wed, 28 Jun 2023 11:12:34 +0800
Message-Id: <20230628031234.1916897-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

namespace's request queue is frozen and quiesced during error recovering,
writeback IO is blocked in bio_queue_enter(), so fsync_bdev() <- del_gendisk()
can't move on, and causes IO hang. Removal could be from sysfs, hard
unplug or error handling.

Fix this kind of issue by marking controller as DEAD if removal breaks
error recovery.

This ways is reasonable too, because controller can't be recovered any
more after being removed.

Cc: stable@vger.kernel.org
Reported-by: Chunguang Xu <brookxu.cn@gmail.com>
Closes: https://lore.kernel.org/linux-nvme/cover.1685350577.git.chunguang.xu@shopee.com/
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 4 +++-
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fdfcf2781c85..b4cebc01cc00 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -567,6 +567,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	}
 
 	if (changed) {
+		ctrl->old_state = ctrl->state;
 		ctrl->state = new_state;
 		wake_up_all(&ctrl->state_wq);
 	}
@@ -4055,7 +4056,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 * removing the namespaces' disks; fail all the queues now to avoid
 	 * potentially having to clean up the failed sync later.
 	 */
-	if (ctrl->state == NVME_CTRL_DEAD) {
+	if (ctrl->state == NVME_CTRL_DEAD ||
+			ctrl->old_state != NVME_CTRL_LIVE) {
 		nvme_mark_namespaces_dead(ctrl);
 		nvme_unquiesce_io_queues(ctrl);
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9a98c14c552a..ce67856d4d4f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -254,6 +254,7 @@ struct nvme_ctrl {
 	bool comp_seen;
 	bool identified;
 	enum nvme_ctrl_state state;
+	enum nvme_ctrl_state old_state;
 	spinlock_t lock;
 	struct mutex scan_lock;
 	const struct nvme_ctrl_ops *ops;
-- 
2.40.1

