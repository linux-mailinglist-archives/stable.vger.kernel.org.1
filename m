Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E26F79B548
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbjIKV4s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239818AbjIKO31 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:29:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F66F0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:29:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D654C433C8;
        Mon, 11 Sep 2023 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442562;
        bh=uvQBcK4dYfILcfYzT5vCV8ogBVvGlpCy82gPKzXMKOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QtEgWuROp51ZWsAEIzJcnXK1IVwfxF2HQhji5c0JkWhsqg7L5GYujz6fFurS7TbUP
         FcG5CAkXxkV8g/HoOvOEPXmKLkhD9Guj035sg7eOhodv116QhWIeHBV5lknAyw4gJR
         WB5pgfd2Pd4cxP3OImmaqWyBWJ66AY2d7eeTlo1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dragos Tatulea <dtatulea@nvidia.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Lei Yang <leiyang@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 069/737] vdpa/mlx5: Correct default number of queues when MQ is on
Date:   Mon, 11 Sep 2023 15:38:48 +0200
Message-ID: <20230911134652.443240219@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dragos Tatulea <dtatulea@nvidia.com>

[ Upstream commit 3fe024193340b225d1fd410d78c495434a9d68e0 ]

The standard specifies that the initial number of queues is the
default, which is 1 (1 tx, 1 rx).

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20230727172354.68243-2-dtatulea@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index f18a9301ab94e..6b79ae746ab93 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2447,7 +2447,15 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 	else
 		ndev->rqt_size = 1;
 
-	ndev->cur_num_vqs = 2 * ndev->rqt_size;
+	/* Device must start with 1 queue pair, as per VIRTIO v1.2 spec, section
+	 * 5.1.6.5.5 "Device operation in multiqueue mode":
+	 *
+	 * Multiqueue is disabled by default.
+	 * The driver enables multiqueue by sending a command using class
+	 * VIRTIO_NET_CTRL_MQ. The command selects the mode of multiqueue
+	 * operation, as follows: ...
+	 */
+	ndev->cur_num_vqs = 2;
 
 	update_cvq_info(mvdev);
 	return err;
-- 
2.40.1



