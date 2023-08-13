Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A64C77ABB3
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjHMVYq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjHMVYq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:24:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E79710D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A26D62901
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE872C433C8;
        Sun, 13 Aug 2023 21:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961887;
        bh=SxsEya9kUcl2yirQXYpk4xrz84SrBFJe0cqmKjwZj6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p4nMkSzjYp06k8GIdCCJnPx8o4EPS3n0RlICDloyz49wXdJ4guyrsFhrg2Ruwux7/
         5FRBWTTNTg5aetEwk2vwmlYNt6IoHNIBMzciESkFmLJAUYTexE23bABY4216YttHns
         rbGkWY6uX03N9oIu+liNOAwGB3rOTSWvFFU/xySY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chunguang Xu <brookxu.cn@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6.4 035/206] nvme: fix possible hang when removing a controller during error recovery
Date:   Sun, 13 Aug 2023 23:16:45 +0200
Message-ID: <20230813211726.006453005@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

commit 1b95e817916069ec45a7f259d088fd1c091a8cc6 upstream.

Error recovery can be interrupted by controller removal, then the
controller is left as quiesced, and IO hang can be caused.

Fix the issue by unquiescing controller unconditionally when removing
namespaces.

This way is reasonable and safe given forward progress can be made
when removing namespaces.

Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reported-by: Chunguang Xu <brookxu.cn@gmail.com>
Closes: https://lore.kernel.org/linux-nvme/cover.1685350577.git.chunguang.xu@shopee.com/
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/core.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4728,6 +4728,12 @@ void nvme_remove_namespaces(struct nvme_
 	 */
 	nvme_mpath_clear_ctrl_paths(ctrl);
 
+	/*
+	 * Unquiesce io queues so any pending IO won't hang, especially
+	 * those submitted from scan work
+	 */
+	nvme_unquiesce_io_queues(ctrl);
+
 	/* prevent racing with ns scanning */
 	flush_work(&ctrl->scan_work);
 
@@ -4737,10 +4743,8 @@ void nvme_remove_namespaces(struct nvme_
 	 * removing the namespaces' disks; fail all the queues now to avoid
 	 * potentially having to clean up the failed sync later.
 	 */
-	if (ctrl->state == NVME_CTRL_DEAD) {
+	if (ctrl->state == NVME_CTRL_DEAD)
 		nvme_mark_namespaces_dead(ctrl);
-		nvme_unquiesce_io_queues(ctrl);
-	}
 
 	/* this is a no-op when called from the controller reset handler */
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);


