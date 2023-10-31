Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4616C7DD50E
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376372AbjJaRqp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376365AbjJaRql (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:46:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55817107
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:46:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA75C433B8;
        Tue, 31 Oct 2023 17:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774398;
        bh=+KbJd353BbpInZsqPm/UMRy+J8/q3WcWmoxwpHcVzuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFvxBrHvh/FT52Vces9j4hM5C58C1qhz/fCC+hi0VwP4iuIaHuspOSa0fURUHANRk
         6mCVeFLYmdbcPo0orvfnfmD4B2qM4PHQdyFcd6GjTiKxEctqgiXsnoJbjM2pjH30ze
         L7JB8GI1ELiEt6Sg8AmGyBMo1Akic5oLTAaGKbp8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dragos Tatulea <dtatulea@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH 6.5 033/112] vdpa/mlx5: Fix double release of debugfs entry
Date:   Tue, 31 Oct 2023 18:00:34 +0100
Message-ID: <20231031165902.369955895@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dragos Tatulea <dtatulea@nvidia.com>

commit f8a3db47d944a33eac1f37358db560e5aabbfbca upstream.

The error path in setup_driver deletes the debugfs entry but doesn't
clear the pointer. During .dev_del the invalid pointer will be released
again causing a crash.

This patch fixes the issue by always clearing the debugfs entry in
mlx5_vdpa_remove_debugfs. Also, stop removing the debugfs entry in
.dev_del op: the debugfs entry is already handled within the
setup_driver/teardown_driver scope.

Cc: stable@vger.kernel.org
Fixes: f0417e72add5 ("vdpa/mlx5: Add and remove debugfs in setup/teardown driver")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Message-Id: <20230829174014.928189-2-dtatulea@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vdpa/mlx5/net/debug.c     |    5 +++--
 drivers/vdpa/mlx5/net/mlx5_vnet.c |    7 ++-----
 drivers/vdpa/mlx5/net/mlx5_vnet.h |    2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

--- a/drivers/vdpa/mlx5/net/debug.c
+++ b/drivers/vdpa/mlx5/net/debug.c
@@ -146,7 +146,8 @@ void mlx5_vdpa_add_debugfs(struct mlx5_v
 		ndev->rx_dent = debugfs_create_dir("rx", ndev->debugfs);
 }
 
-void mlx5_vdpa_remove_debugfs(struct dentry *dbg)
+void mlx5_vdpa_remove_debugfs(struct mlx5_vdpa_net *ndev)
 {
-	debugfs_remove_recursive(dbg);
+	debugfs_remove_recursive(ndev->debugfs);
+	ndev->debugfs = NULL;
 }
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2758,7 +2758,7 @@ err_tir:
 err_rqt:
 	teardown_virtqueues(ndev);
 err_setup:
-	mlx5_vdpa_remove_debugfs(ndev->debugfs);
+	mlx5_vdpa_remove_debugfs(ndev);
 out:
 	return err;
 }
@@ -2772,8 +2772,7 @@ static void teardown_driver(struct mlx5_
 	if (!ndev->setup)
 		return;
 
-	mlx5_vdpa_remove_debugfs(ndev->debugfs);
-	ndev->debugfs = NULL;
+	mlx5_vdpa_remove_debugfs(ndev);
 	teardown_steering(ndev);
 	destroy_tir(ndev);
 	destroy_rqt(ndev);
@@ -3534,8 +3533,6 @@ static void mlx5_vdpa_dev_del(struct vdp
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	struct workqueue_struct *wq;
 
-	mlx5_vdpa_remove_debugfs(ndev->debugfs);
-	ndev->debugfs = NULL;
 	unregister_link_notifier(ndev);
 	_vdpa_unregister_device(dev);
 	wq = mvdev->wq;
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
@@ -97,7 +97,7 @@ struct macvlan_node {
 };
 
 void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev);
-void mlx5_vdpa_remove_debugfs(struct dentry *dbg);
+void mlx5_vdpa_remove_debugfs(struct mlx5_vdpa_net *ndev);
 void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev);
 void mlx5_vdpa_remove_rx_flow_table(struct mlx5_vdpa_net *ndev);
 void mlx5_vdpa_add_tirn(struct mlx5_vdpa_net *ndev);


