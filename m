Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9BE779D65
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 07:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjHLF4x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 01:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjHLF4w (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 01:56:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD22D2D52
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 22:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71E6064326
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 05:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E106C433C8;
        Sat, 12 Aug 2023 05:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691819810;
        bh=8iZHhEdjq/QBOovffAWLpEByCkdsXCGH7VI+LOPwnmY=;
        h=Subject:To:Cc:From:Date:From;
        b=vnjkeAoX8+BM6w3Ap0OmK4T/w7aWMiqji4XKhQ84QWbKeDaJkZ1DTfnO+4kkc4qCb
         8gUgNyqtCvJfPHVRkkW73AGEcBG56F3H1LIzOOOxRflYP9VVWp/RgYIfFHZkYz7ki6
         5UmdrclawP+ZoKf0ot2TmphUvGChKb7/jIOLZtEM=
Subject: FAILED: patch "[PATCH] nvme-rdma: fix potential unbalanced freeze & unfreeze" failed to apply to 5.10-stable tree
To:     ming.lei@redhat.com, kbusch@kernel.org, sagi@grimberg.me,
        yi.zhang@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 07:56:43 +0200
Message-ID: <2023081243-sleet-native-6d03@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 29b434d1e49252b3ad56ad3197e47fafff5356a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081243-sleet-native-6d03@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

29b434d1e492 ("nvme-rdma: fix potential unbalanced freeze & unfreeze")
9f27bd701d18 ("nvme: rename the queue quiescing helpers")
91c11d5f3254 ("nvme-rdma: stop auth work after tearing down queues in error recovery")
1f1a4f89562d ("nvme-tcp: stop auth work after tearing down queues in error recovery")
eac3ef262941 ("nvme-pci: split the initial probe from the rest path")
a6ee7f19ebfd ("nvme-pci: call nvme_pci_configure_admin_queue from nvme_pci_enable")
3f30a79c2e2c ("nvme-pci: set constant paramters in nvme_pci_alloc_ctrl")
2e87570be9d2 ("nvme-pci: factor out a nvme_pci_alloc_dev helper")
081a7d958ce4 ("nvme-pci: factor the iod mempool creation into a helper")
94cc781f69f4 ("nvme: move OPAL setup from PCIe to core")
cd50f9b24726 ("nvme: split nvme_kill_queues")
6bcd5089ee13 ("nvme: don't unquiesce the admin queue in nvme_kill_queues")
0ffc7e98bfaa ("nvme-pci: refactor the tagset handling in nvme_reset_work")
71b26083d59c ("block: set the disk capacity to 0 in blk_mark_disk_dead")
6dfba1c09c10 ("nvme-fc: use the tagset alloc/free helpers")
1864ea46155c ("nvme-fc: store the generic nvme_ctrl in set->driver_data")
cefa1032f111 ("nvme-rdma: use the tagset alloc/free helpers")
2d60738c8f80 ("nvme-rdma: store the generic nvme_ctrl in set->driver_data")
fe60e8c53411 ("nvme: add common helpers to allocate and free tagsets")
61ce339f19fa ("nvme-pci: set min_align_mask before calculating max_hw_sectors")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 29b434d1e49252b3ad56ad3197e47fafff5356a1 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 11 Jul 2023 17:40:41 +0800
Subject: [PATCH] nvme-rdma: fix potential unbalanced freeze & unfreeze

Move start_freeze into nvme_rdma_configure_io_queues(), and there is
at least two benefits:

1) fix unbalanced freeze and unfreeze, since re-connection work may
fail or be broken by removal

2) IO during error recovery can be failfast quickly because nvme fabrics
unquiesces queues after teardown.

One side-effect is that !mpath request may timeout during connecting
because of queue topo change, but that looks not one big deal:

1) same problem exists with current code base

2) compared with !mpath, mpath use case is dominant

Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d433b2ec07a6..337a624a537c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -883,6 +883,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		goto out_cleanup_tagset;
 
 	if (!new) {
+		nvme_start_freeze(&ctrl->ctrl);
 		nvme_unquiesce_io_queues(&ctrl->ctrl);
 		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -891,6 +892,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			 * to be safe.
 			 */
 			ret = -ENODEV;
+			nvme_unfreeze(&ctrl->ctrl);
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
@@ -940,7 +942,6 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
 	if (ctrl->ctrl.queue_count > 1) {
-		nvme_start_freeze(&ctrl->ctrl);
 		nvme_quiesce_io_queues(&ctrl->ctrl);
 		nvme_sync_io_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);

