Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970A278320F
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjHUUDU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjHUUDT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:03:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1790E3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:03:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 880C964859
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DDCC433C7;
        Mon, 21 Aug 2023 20:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648197;
        bh=0nR+7BRlzOPo7HjiT8tZI7bNwX7bph8AKmeAw3XfxcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XhP9Rt4bm9/gdL83DzryRPxIwZXKeQiW6cjG9I5WHMZ0b39B1L9Gnvxmw4BaYDChI
         ZwinqKrjed50t4XJfy+xB1qievdxY8zXyTDFlO/zBGcBLFSKr/WhohOlhAohV8Cldv
         v1JCS8vxzsuEabFEZ5ZX88DB+MpPc0ppmGogxjRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dragos Tatulea <dtatulea@nvidia.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Gal Pressman <gal@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 089/234] vdpa/mlx5: Fix mr->initialized semantics
Date:   Mon, 21 Aug 2023 21:40:52 +0200
Message-ID: <20230821194132.725209979@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dragos Tatulea <dtatulea@nvidia.com>

[ Upstream commit 9ee811009ad8f87982b69e61d07447d12233ad01 ]

The mr->initialized flag is shared between the control vq and data vq
part of the mr init/uninit. But if the control vq and data vq get placed
in different ASIDs, it can happen that initializing the control vq will
prevent the data vq mr from being initialized.

This patch consolidates the control and data vq init parts into their
own init functions. The mr->initialized will now be used for the data vq
only. The control vq currently doesn't need a flag.

The uninitializing part is also taken care of: mlx5_vdpa_destroy_mr got
split into data and control vq functions which are now also ASID aware.

Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address spaces for control and data")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Message-Id: <20230802171231.11001-3-dtatulea@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
 drivers/vdpa/mlx5/core/mr.c        | 97 +++++++++++++++++++++---------
 2 files changed, 71 insertions(+), 27 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index 25fc4120b618d..a0420be5059f4 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -31,6 +31,7 @@ struct mlx5_vdpa_mr {
 	struct list_head head;
 	unsigned long num_directs;
 	unsigned long num_klms;
+	/* state of dvq mr */
 	bool initialized;
 
 	/* serialize mkey creation and destruction */
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 03e5432297912..4ae14a248a4bc 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -489,60 +489,103 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr
 	}
 }
 
-void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
+static void _mlx5_vdpa_destroy_cvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
+{
+	if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
+		return;
+
+	prune_iotlb(mvdev);
+}
+
+static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
 {
 	struct mlx5_vdpa_mr *mr = &mvdev->mr;
 
-	mutex_lock(&mr->mkey_mtx);
+	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
+		return;
+
 	if (!mr->initialized)
-		goto out;
+		return;
 
-	prune_iotlb(mvdev);
 	if (mr->user_mr)
 		destroy_user_mr(mvdev, mr);
 	else
 		destroy_dma_mr(mvdev, mr);
 
 	mr->initialized = false;
-out:
+}
+
+static void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
+{
+	struct mlx5_vdpa_mr *mr = &mvdev->mr;
+
+	mutex_lock(&mr->mkey_mtx);
+
+	_mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
+	_mlx5_vdpa_destroy_cvq_mr(mvdev, asid);
+
 	mutex_unlock(&mr->mkey_mtx);
 }
 
-static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
-				struct vhost_iotlb *iotlb, unsigned int asid)
+void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
+{
+	mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_CVQ_GROUP]);
+	mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]);
+}
+
+static int _mlx5_vdpa_create_cvq_mr(struct mlx5_vdpa_dev *mvdev,
+				    struct vhost_iotlb *iotlb,
+				    unsigned int asid)
+{
+	if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
+		return 0;
+
+	return dup_iotlb(mvdev, iotlb);
+}
+
+static int _mlx5_vdpa_create_dvq_mr(struct mlx5_vdpa_dev *mvdev,
+				    struct vhost_iotlb *iotlb,
+				    unsigned int asid)
 {
 	struct mlx5_vdpa_mr *mr = &mvdev->mr;
 	int err;
 
-	if (mr->initialized)
+	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
 		return 0;
 
-	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
-		if (iotlb)
-			err = create_user_mr(mvdev, iotlb);
-		else
-			err = create_dma_mr(mvdev, mr);
+	if (mr->initialized)
+		return 0;
 
-		if (err)
-			return err;
-	}
+	if (iotlb)
+		err = create_user_mr(mvdev, iotlb);
+	else
+		err = create_dma_mr(mvdev, mr);
 
-	if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid) {
-		err = dup_iotlb(mvdev, iotlb);
-		if (err)
-			goto out_err;
-	}
+	if (err)
+		return err;
 
 	mr->initialized = true;
+
+	return 0;
+}
+
+static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
+				struct vhost_iotlb *iotlb, unsigned int asid)
+{
+	int err;
+
+	err = _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
+	if (err)
+		return err;
+
+	err = _mlx5_vdpa_create_cvq_mr(mvdev, iotlb, asid);
+	if (err)
+		goto out_err;
+
 	return 0;
 
 out_err:
-	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
-		if (iotlb)
-			destroy_user_mr(mvdev, mr);
-		else
-			destroy_dma_mr(mvdev, mr);
-	}
+	_mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
 
 	return err;
 }
-- 
2.40.1



