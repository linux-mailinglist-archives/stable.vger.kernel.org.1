Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1C973E82A
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjFZSXj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjFZSXW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:23:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F38B10FD
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF01960F77
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD04C433C8;
        Mon, 26 Jun 2023 18:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803744;
        bh=0OmFUpu7eAp8pqaNNHD0BmXOB2AO5JBwYeTRQSxykMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkBgh35h+dSfoDm3NPEFl2vNQh8BMP95XnRHX2blfF0AAIYmyqlRIKQ/CjdDJ1qOH
         2NLQ/tUlCjImASeVAbZEnO6OS2S3VE3iotIck9tiw2yQMkgKRp+8TLIFTP5ITMc9DU
         8ZJi9jSPLgq6CvozJ8B6srJauZDQEgdKa9zY7baE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Costa Sapuntzakis <costa@purestorage.com>,
        Randy Jennings <randyj@purestorage.com>,
        Uday Shankar <ushankar@purestorage.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 163/199] nvme: check IO start time when deciding to defer KA
Date:   Mon, 26 Jun 2023 20:11:09 +0200
Message-ID: <20230626180812.825562181@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: Uday Shankar <ushankar@purestorage.com>

[ Upstream commit 774a9636514764ddc0d072ae0d1d1c01a47e6ddd ]

When a command completes, we set a flag which will skip sending a
keep alive at the next run of nvme_keep_alive_work when TBKAS is on.
However, if the command was submitted long ago, it's possible that
the controller may have also restarted its keep alive timer (as a
result of receiving the command) long ago. The following trace
demonstrates the issue, assuming TBKAS is on and KATO = 8 for
simplicity:

1. t = 0: submit I/O commands A, B, C, D, E
2. t = 0.5: commands A, B, C, D, E reach controller, restart its keep
            alive timer
3. t = 1: A completes
4. t = 2: run nvme_keep_alive_work, see recent completion, do nothing
5. t = 3: B completes
6. t = 4: run nvme_keep_alive_work, see recent completion, do nothing
7. t = 5: C completes
8. t = 6: run nvme_keep_alive_work, see recent completion, do nothing
9. t = 7: D completes
10. t = 8: run nvme_keep_alive_work, see recent completion, do nothing
11. t = 9: E completes

At this point, 8.5 seconds have passed without restarting the
controller's keep alive timer, so the controller will detect a keep
alive timeout.

Fix this by checking the IO start time when deciding to defer sending a
keep alive command. Only set comp_seen if the command started after the
most recent run of nvme_keep_alive_work. With this change, the
completions of B, C, and D will not set comp_seen and the run of
nvme_keep_alive_work at t = 4 will send a keep alive.

Reported-by: Costa Sapuntzakis <costa@purestorage.com>
Reported-by: Randy Jennings <randyj@purestorage.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 14 +++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3838a6622c34b..d87b8dfda622a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -397,7 +397,16 @@ void nvme_complete_rq(struct request *req)
 	trace_nvme_complete_rq(req);
 	nvme_cleanup_cmd(req);
 
-	if (ctrl->kas)
+	/*
+	 * Completions of long-running commands should not be able to
+	 * defer sending of periodic keep alives, since the controller
+	 * may have completed processing such commands a long time ago
+	 * (arbitrarily close to command submission time).
+	 * req->deadline - req->timeout is the command submission time
+	 * in jiffies.
+	 */
+	if (ctrl->kas &&
+	    req->deadline - req->timeout >= ctrl->ka_last_check_time)
 		ctrl->comp_seen = true;
 
 	switch (nvme_decide_disposition(req)) {
@@ -1200,6 +1209,7 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		return RQ_END_IO_NONE;
 	}
 
+	ctrl->ka_last_check_time = jiffies;
 	ctrl->comp_seen = false;
 	spin_lock_irqsave(&ctrl->lock, flags);
 	if (ctrl->state == NVME_CTRL_LIVE ||
@@ -1218,6 +1228,8 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	bool comp_seen = ctrl->comp_seen;
 	struct request *rq;
 
+	ctrl->ka_last_check_time = jiffies;
+
 	if ((ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) && comp_seen) {
 		dev_dbg(ctrl->device,
 			"reschedule traffic based keep-alive timer\n");
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2dd52739236e1..8657811f8b887 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -328,6 +328,7 @@ struct nvme_ctrl {
 	struct delayed_work ka_work;
 	struct delayed_work failfast_work;
 	struct nvme_command ka_cmd;
+	unsigned long ka_last_check_time;
 	struct work_struct fw_act_work;
 	unsigned long events;
 
-- 
2.39.2



