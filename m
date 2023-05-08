Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1C56FAC26
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjEHLVZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbjEHLVY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:21:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1B138F2F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:21:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F23962C94
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CAFC433EF;
        Mon,  8 May 2023 11:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544878;
        bh=EkHW+S+Y35CGxTwkL16Qslx3O6ilEi77b9z4EV3eEO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIKuN4uTZxc9S5nQfYOcr09JPlxbCKxGEbYFqSHvNb9jq5wj6i2TXlsYdwKMojjaB
         zJkpSV3uZYsFKAt00soN18YAifdDGaQH0FmznsznLMNVZAkqPrgtZ8D/uWynCR1Ole
         KQQzsSqrFhaqMSyHAXDZsEh1Dk4kD6lJ6WTWTTBY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
        Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 553/694] vdpa/mlx5: Avoid losing link state updates
Date:   Mon,  8 May 2023 11:46:28 +0200
Message-Id: <20230508094452.516958932@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Eli Cohen <elic@nvidia.com>

[ Upstream commit c384c2401eed99a2e1f84191e573f15b898babe6 ]

Current code ignores link state updates if VIRTIO_NET_F_STATUS was not
negotiated. However, link state updates could be received before feature
negotiation was completed , therefore causing link state events to be
lost, possibly leaving the link state down.

Modify the code so link state notifier is registered after DRIVER_OK was
negotiated and carry the registration only if
VIRTIO_NET_F_STATUS was negotiated.  Unregister the notifier when the
device is reset.

Fixes: 033779a708f0 ("vdpa/mlx5: make MTU/STATUS presence conditional on feature bits")
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eli Cohen <elic@nvidia.com>
Message-Id: <20230417110343.138319-1-elic@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 203 +++++++++++++++++-------------
 1 file changed, 114 insertions(+), 89 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 195963b82b636..97a16f7eb8941 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2298,6 +2298,113 @@ static void update_cvq_info(struct mlx5_vdpa_dev *mvdev)
 	}
 }
 
+static u8 query_vport_state(struct mlx5_core_dev *mdev, u8 opmod, u16 vport)
+{
+	u32 out[MLX5_ST_SZ_DW(query_vport_state_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(query_vport_state_in)] = {};
+	int err;
+
+	MLX5_SET(query_vport_state_in, in, opcode, MLX5_CMD_OP_QUERY_VPORT_STATE);
+	MLX5_SET(query_vport_state_in, in, op_mod, opmod);
+	MLX5_SET(query_vport_state_in, in, vport_number, vport);
+	if (vport)
+		MLX5_SET(query_vport_state_in, in, other_vport, 1);
+
+	err = mlx5_cmd_exec_inout(mdev, query_vport_state, in, out);
+	if (err)
+		return 0;
+
+	return MLX5_GET(query_vport_state_out, out, state);
+}
+
+static bool get_link_state(struct mlx5_vdpa_dev *mvdev)
+{
+	if (query_vport_state(mvdev->mdev, MLX5_VPORT_STATE_OP_MOD_VNIC_VPORT, 0) ==
+	    VPORT_STATE_UP)
+		return true;
+
+	return false;
+}
+
+static void update_carrier(struct work_struct *work)
+{
+	struct mlx5_vdpa_wq_ent *wqent;
+	struct mlx5_vdpa_dev *mvdev;
+	struct mlx5_vdpa_net *ndev;
+
+	wqent = container_of(work, struct mlx5_vdpa_wq_ent, work);
+	mvdev = wqent->mvdev;
+	ndev = to_mlx5_vdpa_ndev(mvdev);
+	if (get_link_state(mvdev))
+		ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
+	else
+		ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
+
+	if (ndev->config_cb.callback)
+		ndev->config_cb.callback(ndev->config_cb.private);
+
+	kfree(wqent);
+}
+
+static int queue_link_work(struct mlx5_vdpa_net *ndev)
+{
+	struct mlx5_vdpa_wq_ent *wqent;
+
+	wqent = kzalloc(sizeof(*wqent), GFP_ATOMIC);
+	if (!wqent)
+		return -ENOMEM;
+
+	wqent->mvdev = &ndev->mvdev;
+	INIT_WORK(&wqent->work, update_carrier);
+	queue_work(ndev->mvdev.wq, &wqent->work);
+	return 0;
+}
+
+static int event_handler(struct notifier_block *nb, unsigned long event, void *param)
+{
+	struct mlx5_vdpa_net *ndev = container_of(nb, struct mlx5_vdpa_net, nb);
+	struct mlx5_eqe *eqe = param;
+	int ret = NOTIFY_DONE;
+
+	if (event == MLX5_EVENT_TYPE_PORT_CHANGE) {
+		switch (eqe->sub_type) {
+		case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
+		case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
+			if (queue_link_work(ndev))
+				return NOTIFY_DONE;
+
+			ret = NOTIFY_OK;
+			break;
+		default:
+			return NOTIFY_DONE;
+		}
+		return ret;
+	}
+	return ret;
+}
+
+static void register_link_notifier(struct mlx5_vdpa_net *ndev)
+{
+	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_STATUS)))
+		return;
+
+	ndev->nb.notifier_call = event_handler;
+	mlx5_notifier_register(ndev->mvdev.mdev, &ndev->nb);
+	ndev->nb_registered = true;
+	queue_link_work(ndev);
+}
+
+static void unregister_link_notifier(struct mlx5_vdpa_net *ndev)
+{
+	if (!ndev->nb_registered)
+		return;
+
+	ndev->nb_registered = false;
+	mlx5_notifier_unregister(ndev->mvdev.mdev, &ndev->nb);
+	if (ndev->mvdev.wq)
+		flush_workqueue(ndev->mvdev.wq);
+}
+
 static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
@@ -2567,10 +2674,11 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 				mlx5_vdpa_warn(mvdev, "failed to setup control VQ vring\n");
 				goto err_setup;
 			}
+			register_link_notifier(ndev);
 			err = setup_driver(mvdev);
 			if (err) {
 				mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
-				goto err_setup;
+				goto err_driver;
 			}
 		} else {
 			mlx5_vdpa_warn(mvdev, "did not expect DRIVER_OK to be cleared\n");
@@ -2582,6 +2690,8 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 	up_write(&ndev->reslock);
 	return;
 
+err_driver:
+	unregister_link_notifier(ndev);
 err_setup:
 	mlx5_vdpa_destroy_mr(&ndev->mvdev);
 	ndev->mvdev.status |= VIRTIO_CONFIG_S_FAILED;
@@ -2607,6 +2717,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	mlx5_vdpa_info(mvdev, "performing device reset\n");
 
 	down_write(&ndev->reslock);
+	unregister_link_notifier(ndev);
 	teardown_driver(ndev);
 	clear_vqs_ready(ndev);
 	mlx5_vdpa_destroy_mr(&ndev->mvdev);
@@ -2861,9 +2972,7 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
 	mlx5_vdpa_info(mvdev, "suspending device\n");
 
 	down_write(&ndev->reslock);
-	ndev->nb_registered = false;
-	mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
-	flush_workqueue(ndev->mvdev.wq);
+	unregister_link_notifier(ndev);
 	for (i = 0; i < ndev->cur_num_vqs; i++) {
 		mvq = &ndev->vqs[i];
 		suspend_vq(ndev, mvq);
@@ -3000,84 +3109,6 @@ struct mlx5_vdpa_mgmtdev {
 	struct mlx5_vdpa_net *ndev;
 };
 
-static u8 query_vport_state(struct mlx5_core_dev *mdev, u8 opmod, u16 vport)
-{
-	u32 out[MLX5_ST_SZ_DW(query_vport_state_out)] = {};
-	u32 in[MLX5_ST_SZ_DW(query_vport_state_in)] = {};
-	int err;
-
-	MLX5_SET(query_vport_state_in, in, opcode, MLX5_CMD_OP_QUERY_VPORT_STATE);
-	MLX5_SET(query_vport_state_in, in, op_mod, opmod);
-	MLX5_SET(query_vport_state_in, in, vport_number, vport);
-	if (vport)
-		MLX5_SET(query_vport_state_in, in, other_vport, 1);
-
-	err = mlx5_cmd_exec_inout(mdev, query_vport_state, in, out);
-	if (err)
-		return 0;
-
-	return MLX5_GET(query_vport_state_out, out, state);
-}
-
-static bool get_link_state(struct mlx5_vdpa_dev *mvdev)
-{
-	if (query_vport_state(mvdev->mdev, MLX5_VPORT_STATE_OP_MOD_VNIC_VPORT, 0) ==
-	    VPORT_STATE_UP)
-		return true;
-
-	return false;
-}
-
-static void update_carrier(struct work_struct *work)
-{
-	struct mlx5_vdpa_wq_ent *wqent;
-	struct mlx5_vdpa_dev *mvdev;
-	struct mlx5_vdpa_net *ndev;
-
-	wqent = container_of(work, struct mlx5_vdpa_wq_ent, work);
-	mvdev = wqent->mvdev;
-	ndev = to_mlx5_vdpa_ndev(mvdev);
-	if (get_link_state(mvdev))
-		ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
-	else
-		ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
-
-	if (ndev->nb_registered && ndev->config_cb.callback)
-		ndev->config_cb.callback(ndev->config_cb.private);
-
-	kfree(wqent);
-}
-
-static int event_handler(struct notifier_block *nb, unsigned long event, void *param)
-{
-	struct mlx5_vdpa_net *ndev = container_of(nb, struct mlx5_vdpa_net, nb);
-	struct mlx5_eqe *eqe = param;
-	int ret = NOTIFY_DONE;
-	struct mlx5_vdpa_wq_ent *wqent;
-
-	if (event == MLX5_EVENT_TYPE_PORT_CHANGE) {
-		if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_STATUS)))
-			return NOTIFY_DONE;
-		switch (eqe->sub_type) {
-		case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
-		case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
-			wqent = kzalloc(sizeof(*wqent), GFP_ATOMIC);
-			if (!wqent)
-				return NOTIFY_DONE;
-
-			wqent->mvdev = &ndev->mvdev;
-			INIT_WORK(&wqent->work, update_carrier);
-			queue_work(ndev->mvdev.wq, &wqent->work);
-			ret = NOTIFY_OK;
-			break;
-		default:
-			return NOTIFY_DONE;
-		}
-		return ret;
-	}
-	return ret;
-}
-
 static int config_func_mtu(struct mlx5_core_dev *mdev, u16 mtu)
 {
 	int inlen = MLX5_ST_SZ_BYTES(modify_nic_vport_context_in);
@@ -3258,9 +3289,6 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		goto err_res2;
 	}
 
-	ndev->nb.notifier_call = event_handler;
-	mlx5_notifier_register(mdev, &ndev->nb);
-	ndev->nb_registered = true;
 	mvdev->vdev.mdev = &mgtdev->mgtdev;
 	err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
 	if (err)
@@ -3294,10 +3322,7 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 
 	mlx5_vdpa_remove_debugfs(ndev->debugfs);
 	ndev->debugfs = NULL;
-	if (ndev->nb_registered) {
-		ndev->nb_registered = false;
-		mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
-	}
+	unregister_link_notifier(ndev);
 	wq = mvdev->wq;
 	mvdev->wq = NULL;
 	destroy_workqueue(wq);
-- 
2.39.2



