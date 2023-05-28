Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBB6713AC8
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 18:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjE1Qwe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 12:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1Qwd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 12:52:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEA2BD
        for <stable@vger.kernel.org>; Sun, 28 May 2023 09:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3FC8617C3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 16:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AF9C433D2;
        Sun, 28 May 2023 16:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685292751;
        bh=Ddi8uTzOwiSoOVXPmXQ8+N2Sm5iz+vf37GpWv0uympA=;
        h=Subject:To:Cc:From:Date:From;
        b=HX2qPg9l087Q08glqcmp6X8xeJyggSkKfoqaq0XaJ8sJAAYAravqj/JXJeeUmgs28
         HqX2M5uN5nSWew8Il8gBjVGIzlYsiJj/VitwqFS6iIfDI6Kd5zkjWdoClP+IK8Ax6t
         ZYOkUNmTzDO/+sNskNgvEsx87t3KX1ekuGsFQglk=
Subject: FAILED: patch "[PATCH] net/mlx5: Devcom, serialize devcom registration" failed to apply to 5.10-stable tree
To:     shayd@nvidia.com, mbloch@nvidia.com, saeedm@nvidia.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 17:52:20 +0100
Message-ID: <2023052820-childcare-gumminess-835c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
git cherry-pick -x 1f893f57a3bf9fe1f4bcb25b55aea7f7f9712fe7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052820-childcare-gumminess-835c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

1f893f57a3bf ("net/mlx5: Devcom, serialize devcom registration")
af87194352ca ("net/mlx5: Devcom, fix error flow in mlx5_devcom_register_device")
8a6e75e5f57e ("net/mlx5: devcom only supports 2 ports")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1f893f57a3bf9fe1f4bcb25b55aea7f7f9712fe7 Mon Sep 17 00:00:00 2001
From: Shay Drory <shayd@nvidia.com>
Date: Tue, 2 May 2023 13:36:42 +0300
Subject: [PATCH] net/mlx5: Devcom, serialize devcom registration

From one hand, mlx5 driver is allowing to probe PFs in parallel.
From the other hand, devcom, which is a share resource between PFs, is
registered without any lock. This might resulted in memory problems.

Hence, use the global mlx5_dev_list_lock in order to serialize devcom
registration.

Fixes: fadd59fc50d0 ("net/mlx5: Introduce inter-device communication mechanism")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index 8f978491dd32..b7d779d08d83 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -3,6 +3,7 @@
 
 #include <linux/mlx5/vport.h>
 #include "lib/devcom.h"
+#include "mlx5_core.h"
 
 static LIST_HEAD(devcom_list);
 
@@ -77,6 +78,7 @@ struct mlx5_devcom *mlx5_devcom_register_device(struct mlx5_core_dev *dev)
 	if (MLX5_CAP_GEN(dev, num_lag_ports) != MLX5_DEVCOM_PORTS_SUPPORTED)
 		return NULL;
 
+	mlx5_dev_list_lock();
 	sguid0 = mlx5_query_nic_system_image_guid(dev);
 	list_for_each_entry(iter, &devcom_list, list) {
 		struct mlx5_core_dev *tmp_dev = NULL;
@@ -102,8 +104,10 @@ struct mlx5_devcom *mlx5_devcom_register_device(struct mlx5_core_dev *dev)
 
 	if (!priv) {
 		priv = mlx5_devcom_list_alloc();
-		if (!priv)
-			return ERR_PTR(-ENOMEM);
+		if (!priv) {
+			devcom = ERR_PTR(-ENOMEM);
+			goto out;
+		}
 
 		idx = 0;
 		new_priv = true;
@@ -114,12 +118,14 @@ struct mlx5_devcom *mlx5_devcom_register_device(struct mlx5_core_dev *dev)
 	if (!devcom) {
 		if (new_priv)
 			kfree(priv);
-		return ERR_PTR(-ENOMEM);
+		devcom = ERR_PTR(-ENOMEM);
+		goto out;
 	}
 
 	if (new_priv)
 		list_add(&priv->list, &devcom_list);
-
+out:
+	mlx5_dev_list_unlock();
 	return devcom;
 }
 
@@ -132,6 +138,7 @@ void mlx5_devcom_unregister_device(struct mlx5_devcom *devcom)
 	if (IS_ERR_OR_NULL(devcom))
 		return;
 
+	mlx5_dev_list_lock();
 	priv = devcom->priv;
 	priv->devs[devcom->idx] = NULL;
 
@@ -142,10 +149,12 @@ void mlx5_devcom_unregister_device(struct mlx5_devcom *devcom)
 			break;
 
 	if (i != MLX5_DEVCOM_PORTS_SUPPORTED)
-		return;
+		goto out;
 
 	list_del(&priv->list);
 	kfree(priv);
+out:
+	mlx5_dev_list_unlock();
 }
 
 void mlx5_devcom_register_component(struct mlx5_devcom *devcom,

