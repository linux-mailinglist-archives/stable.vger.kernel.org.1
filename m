Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089497832CE
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjHUUDZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjHUUDZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:03:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFF0DF
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:03:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A65E64865
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B74C433C8;
        Mon, 21 Aug 2023 20:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648202;
        bh=mVVRXhi8pSi4tM/8sPW1Zu8yz2by0J5hc1cHVplP3tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nyrvjyf/38/420+FWMQFSqKoFQw9yigaSzT/yfIEkEdThKsvXoeLHPrOnFEeufITK
         zxtAnzrpHuBp1JPWjKG4Nzr52pwto/seoG8w7nbR1eU/HWi+eSrZUwhXzEn9wJkuLf
         2W7j3+zZPqKHl+K3ZyjSkY/n8tpZ3bjQgkIRz7Fo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Gal Pressman <gal@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 090/234] vdpa/mlx5: Delete control vq iotlb in destroy_mr only when necessary
Date:   Mon, 21 Aug 2023 21:40:53 +0200
Message-ID: <20230821194132.774705463@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eugenio Pérez <eperezma@redhat.com>

[ Upstream commit ad03a0f44cdb97b46e5c84ed353dac9b8ae2c276 ]

mlx5_vdpa_destroy_mr can be called from .set_map with data ASID after
the control virtqueue ASID iotlb has been populated. The control vq
iotlb must not be cleared, since it will not be populated again.

So call the ASID aware destroy function which makes sure that the
right vq resource is destroyed.

Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address spaces for control and data")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Message-Id: <20230802171231.11001-5-dtatulea@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h | 1 +
 drivers/vdpa/mlx5/core/mr.c        | 2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index a0420be5059f4..b53420e874acb 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -122,6 +122,7 @@ int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *io
 int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 			unsigned int asid);
 void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev);
+void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid);
 
 #define mlx5_vdpa_warn(__dev, format, ...)                                                         \
 	dev_warn((__dev)->mdev->device, "%s:%d:(pid %d) warning: " format, __func__, __LINE__,     \
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 4ae14a248a4bc..5a1971fcd87b1 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -515,7 +515,7 @@ static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned int
 	mr->initialized = false;
 }
 
-static void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
+void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
 {
 	struct mlx5_vdpa_mr *mr = &mvdev->mr;
 
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 279ac6a558d29..f18a9301ab94e 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2564,7 +2564,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 		goto err_mr;
 
 	teardown_driver(ndev);
-	mlx5_vdpa_destroy_mr(mvdev);
+	mlx5_vdpa_destroy_mr_asid(mvdev, asid);
 	err = mlx5_vdpa_create_mr(mvdev, iotlb, asid);
 	if (err)
 		goto err_mr;
@@ -2580,7 +2580,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 	return 0;
 
 err_setup:
-	mlx5_vdpa_destroy_mr(mvdev);
+	mlx5_vdpa_destroy_mr_asid(mvdev, asid);
 err_mr:
 	return err;
 }
-- 
2.40.1



