Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DED7DD4ED
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346974AbjJaRpY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346980AbjJaRpW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:45:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABB992
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:45:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C237CC433C8;
        Tue, 31 Oct 2023 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774320;
        bh=xKK6KD/2R5oRxcZZWswie7IH/kgca451/kw4hgengv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f+FMbapUSqqTiaKm7zxTOH7XyNnr7RmMT/yTPwkQRHlnlTApj2TieBo6oAEjxzLxl
         fWJ2L5f9IKsmWz2KXMWfi3CaeOp5ALTHzfq+ihE8wgbrlLjv5jkn9XaQbKSdTpbppx
         hwvypzp6fJ8U84RgKITmxD0Mwh46i8fI0916bBiU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dragos Tatulea <dtatulea@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 002/112] vdpa/mlx5: Fix firmware error on creation of 1k VQs
Date:   Tue, 31 Oct 2023 18:00:03 +0100
Message-ID: <20231031165901.397100073@linuxfoundation.org>
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

[ Upstream commit abb0dcf9938c93f765abf8cb45567cadef0af6b2 ]

A firmware error is triggered when configuring a 9k MTU on the PF after
switching to switchdev mode and then using a vdpa device with larger
(1k) rings:
mlx5_cmd_out_err: CREATE_GENERAL_OBJECT(0xa00) op_mod(0xd) failed, status bad resource(0x5), syndrome (0xf6db90), err(-22)

This is due to the fact that the hw VQ size parameters are computed
based on the umem_1/2/3_buffer_param_a/b capabilities and all
device capabilities are read only when the driver is moved to switchdev mode.

The problematic configuration flow looks like this:
1) Create VF
2) Unbind VF
3) Switch PF to switchdev mode.
4) Bind VF
5) Set PF MTU to 9k
6) create vDPA device
7) Start VM with vDPA device and 1K queue size

Note that setting the MTU before step 3) doesn't trigger this issue.

This patch reads the forementioned umem parameters at the latest point
possible before the VQs of the device are created.

v2:
- Allocate output with kmalloc to reduce stack frame size.
- Removed stable from cc.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Message-Id: <20230831155702.1080754-1-dtatulea@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 63 ++++++++++++++++++++++++++-----
 drivers/vdpa/mlx5/net/mlx5_vnet.h |  9 +++++
 2 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 37be945a02308..a01d27b7af1b5 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -625,30 +625,70 @@ static void cq_destroy(struct mlx5_vdpa_net *ndev, u16 idx)
 	mlx5_db_free(ndev->mvdev.mdev, &vcq->db);
 }
 
+static int read_umem_params(struct mlx5_vdpa_net *ndev)
+{
+	u32 in[MLX5_ST_SZ_DW(query_hca_cap_in)] = {};
+	u16 opmod = (MLX5_CAP_VDPA_EMULATION << 1) | (HCA_CAP_OPMOD_GET_CUR & 0x01);
+	struct mlx5_core_dev *mdev = ndev->mvdev.mdev;
+	int out_size;
+	void *caps;
+	void *out;
+	int err;
+
+	out_size = MLX5_ST_SZ_BYTES(query_hca_cap_out);
+	out = kzalloc(out_size, GFP_KERNEL);
+	if (!out)
+		return -ENOMEM;
+
+	MLX5_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
+	MLX5_SET(query_hca_cap_in, in, op_mod, opmod);
+	err = mlx5_cmd_exec_inout(mdev, query_hca_cap, in, out);
+	if (err) {
+		mlx5_vdpa_warn(&ndev->mvdev,
+			"Failed reading vdpa umem capabilities with err %d\n", err);
+		goto out;
+	}
+
+	caps =  MLX5_ADDR_OF(query_hca_cap_out, out, capability);
+
+	ndev->umem_1_buffer_param_a = MLX5_GET(virtio_emulation_cap, caps, umem_1_buffer_param_a);
+	ndev->umem_1_buffer_param_b = MLX5_GET(virtio_emulation_cap, caps, umem_1_buffer_param_b);
+
+	ndev->umem_2_buffer_param_a = MLX5_GET(virtio_emulation_cap, caps, umem_2_buffer_param_a);
+	ndev->umem_2_buffer_param_b = MLX5_GET(virtio_emulation_cap, caps, umem_2_buffer_param_b);
+
+	ndev->umem_3_buffer_param_a = MLX5_GET(virtio_emulation_cap, caps, umem_3_buffer_param_a);
+	ndev->umem_3_buffer_param_b = MLX5_GET(virtio_emulation_cap, caps, umem_3_buffer_param_b);
+
+out:
+	kfree(out);
+	return 0;
+}
+
 static void set_umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
 			  struct mlx5_vdpa_umem **umemp)
 {
-	struct mlx5_core_dev *mdev = ndev->mvdev.mdev;
-	int p_a;
-	int p_b;
+	u32 p_a;
+	u32 p_b;
 
 	switch (num) {
 	case 1:
-		p_a = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_1_buffer_param_a);
-		p_b = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_1_buffer_param_b);
+		p_a = ndev->umem_1_buffer_param_a;
+		p_b = ndev->umem_1_buffer_param_b;
 		*umemp = &mvq->umem1;
 		break;
 	case 2:
-		p_a = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_2_buffer_param_a);
-		p_b = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_2_buffer_param_b);
+		p_a = ndev->umem_2_buffer_param_a;
+		p_b = ndev->umem_2_buffer_param_b;
 		*umemp = &mvq->umem2;
 		break;
 	case 3:
-		p_a = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_3_buffer_param_a);
-		p_b = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_3_buffer_param_b);
+		p_a = ndev->umem_3_buffer_param_a;
+		p_b = ndev->umem_3_buffer_param_b;
 		*umemp = &mvq->umem3;
 		break;
 	}
+
 	(*umemp)->size = p_a * mvq->num_ent + p_b;
 }
 
@@ -2679,6 +2719,11 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
 		goto out;
 	}
 	mlx5_vdpa_add_debugfs(ndev);
+
+	err = read_umem_params(ndev);
+	if (err)
+		goto err_setup;
+
 	err = setup_virtqueues(mvdev);
 	if (err) {
 		mlx5_vdpa_warn(mvdev, "setup_virtqueues\n");
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
index 36c44d9fdd166..65ebbba206621 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
@@ -65,6 +65,15 @@ struct mlx5_vdpa_net {
 	struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
 	struct mlx5_vdpa_irq_pool irqp;
 	struct dentry *debugfs;
+
+	u32 umem_1_buffer_param_a;
+	u32 umem_1_buffer_param_b;
+
+	u32 umem_2_buffer_param_a;
+	u32 umem_2_buffer_param_b;
+
+	u32 umem_3_buffer_param_a;
+	u32 umem_3_buffer_param_b;
 };
 
 struct mlx5_vdpa_counter {
-- 
2.42.0



