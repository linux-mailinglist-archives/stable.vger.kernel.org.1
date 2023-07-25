Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03BA761439
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjGYLRZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbjGYLRM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:17:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B885E1FFC
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4078861691
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548C5C433C7;
        Tue, 25 Jul 2023 11:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283824;
        bh=8vqg6hHVUsZuPITtjbU732XgTPRiwShHXxBgGBOn4s4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eUiU8i/A8rAnavEvzMfjH7A//rc/kCFnmb972zR2eU24y0A6UGKLjx6SyeFSGdOwn
         cmkO5Qfe8NgobjeYvc5e0wNyrMNyjz6AT2ZxmbYcNXJIZyOGTyTzBBwc3ctjCh/UbE
         eSg2T6Q6rz2A/K8ALNxSVg4vYQYq4f29mYhRf+I4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 136/509] RDMA: Remove uverbs_ex_cmd_mask values that are linked to functions
Date:   Tue, 25 Jul 2023 12:41:15 +0200
Message-ID: <20230725104559.967881345@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit b8e3130dd96b7b2d6d92e62dcd1515af30212fe2 ]

Since a while now the uverbs layer checks if the driver implements a
function before allowing the ucmd to proceed. This largely obsoletes the
cmd_mask stuff, but there is some tricky bits in drivers preventing it
from being removed.

Remove the easy elements of uverbs_ex_cmd_mask by pre-setting them in the
core code. These are triggered soley based on the related ops function
pointer.

query_device_ex is not triggered based on an op, but all drivers already
implement something compatible with the extension, so enable it globally
too.

Link: https://lore.kernel.org/r/2-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Stable-dep-of: cf5b608fb0e3 ("RDMA/hns: Fix hns_roce_table_get return value")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/device.c           | 11 +++++++++++
 drivers/infiniband/core/uverbs_cmd.c       |  2 +-
 drivers/infiniband/hw/efa/efa_main.c       |  3 ---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c |  7 -------
 drivers/infiniband/hw/hns/hns_roce_main.c  |  2 --
 drivers/infiniband/hw/mlx4/main.c          | 14 +-------------
 drivers/infiniband/hw/mlx5/main.c          | 14 ++------------
 7 files changed, 15 insertions(+), 38 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 5b7abcf102fe9..3c29fd04b3016 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -600,6 +600,17 @@ struct ib_device *_ib_alloc_device(size_t size)
 	init_completion(&device->unreg_completion);
 	INIT_WORK(&device->unregistration_work, ib_unregister_work);
 
+	device->uverbs_ex_cmd_mask =
+		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_FLOW) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_RWQ_IND_TBL) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_WQ) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_DESTROY_FLOW) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_DESTROY_WQ) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_CQ) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_WQ) |
+		BIT_ULL(IB_USER_VERBS_EX_CMD_QUERY_DEVICE);
+
 	return device;
 }
 EXPORT_SYMBOL(_ib_alloc_device);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 09cf470c08d65..158f9eadc4e95 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3778,7 +3778,7 @@ const struct uapi_definition uverbs_def_write_intf[] = {
 			IB_USER_VERBS_EX_CMD_MODIFY_CQ,
 			ib_uverbs_ex_modify_cq,
 			UAPI_DEF_WRITE_I(struct ib_uverbs_ex_modify_cq),
-			UAPI_DEF_METHOD_NEEDS_FN(create_cq))),
+			UAPI_DEF_METHOD_NEEDS_FN(modify_cq))),
 
 	DECLARE_UVERBS_OBJECT(
 		UVERBS_OBJECT_DEVICE,
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index ffdd18f4217f5..cd41cd114ab63 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -326,9 +326,6 @@ static int efa_ib_device_add(struct efa_dev *dev)
 		(1ull << IB_USER_VERBS_CMD_CREATE_AH) |
 		(1ull << IB_USER_VERBS_CMD_DESTROY_AH);
 
-	dev->ibdev.uverbs_ex_cmd_mask =
-		(1ull << IB_USER_VERBS_EX_CMD_QUERY_DEVICE);
-
 	ib_set_device_ops(&dev->ibdev, &efa_dev_ops);
 
 	err = ib_register_device(&dev->ibdev, "efa_%d", &pdev->dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 5f4d8a32ed6d9..b3d5ba8ef439a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -2062,11 +2062,6 @@ static void hns_roce_v1_write_cqc(struct hns_roce_dev *hr_dev,
 		       CQ_CONTEXT_CQC_BYTE_32_CQ_CONS_IDX_S, 0);
 }
 
-static int hns_roce_v1_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
-{
-	return -EOPNOTSUPP;
-}
-
 static int hns_roce_v1_req_notify_cq(struct ib_cq *ibcq,
 				     enum ib_cq_notify_flags flags)
 {
@@ -4347,7 +4342,6 @@ static void hns_roce_v1_cleanup_eq_table(struct hns_roce_dev *hr_dev)
 
 static const struct ib_device_ops hns_roce_v1_dev_ops = {
 	.destroy_qp = hns_roce_v1_destroy_qp,
-	.modify_cq = hns_roce_v1_modify_cq,
 	.poll_cq = hns_roce_v1_poll_cq,
 	.post_recv = hns_roce_v1_post_recv,
 	.post_send = hns_roce_v1_post_send,
@@ -4367,7 +4361,6 @@ static const struct hns_roce_hw hns_roce_hw_v1 = {
 	.set_mtu = hns_roce_v1_set_mtu,
 	.write_mtpt = hns_roce_v1_write_mtpt,
 	.write_cqc = hns_roce_v1_write_cqc,
-	.modify_cq = hns_roce_v1_modify_cq,
 	.clear_hem = hns_roce_v1_clear_hem,
 	.modify_qp = hns_roce_v1_modify_qp,
 	.query_qp = hns_roce_v1_query_qp,
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 1e8b3e4ef1b17..8cc2dae269aff 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -511,8 +511,6 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 		(1ULL << IB_USER_VERBS_CMD_QUERY_QP) |
 		(1ULL << IB_USER_VERBS_CMD_DESTROY_QP);
 
-	ib_dev->uverbs_ex_cmd_mask |= (1ULL << IB_USER_VERBS_EX_CMD_MODIFY_CQ);
-
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_REREG_MR) {
 		ib_dev->uverbs_cmd_mask |= (1ULL << IB_USER_VERBS_CMD_REREG_MR);
 		ib_set_device_ops(ib_dev, &hns_roce_dev_mr_ops);
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 05c7200751e50..c62cdd6456962 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2682,8 +2682,6 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 
 	ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_ops);
 	ibdev->ib_dev.uverbs_ex_cmd_mask |=
-		(1ull << IB_USER_VERBS_EX_CMD_MODIFY_CQ) |
-		(1ull << IB_USER_VERBS_EX_CMD_QUERY_DEVICE) |
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_CQ) |
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_QP);
 
@@ -2691,15 +2689,8 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	    ((mlx4_ib_port_link_layer(&ibdev->ib_dev, 1) ==
 	    IB_LINK_LAYER_ETHERNET) ||
 	    (mlx4_ib_port_link_layer(&ibdev->ib_dev, 2) ==
-	    IB_LINK_LAYER_ETHERNET))) {
-		ibdev->ib_dev.uverbs_ex_cmd_mask |=
-			(1ull << IB_USER_VERBS_EX_CMD_CREATE_WQ)	  |
-			(1ull << IB_USER_VERBS_EX_CMD_MODIFY_WQ)	  |
-			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_WQ)	  |
-			(1ull << IB_USER_VERBS_EX_CMD_CREATE_RWQ_IND_TBL) |
-			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL);
+	    IB_LINK_LAYER_ETHERNET)))
 		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_wq_ops);
-	}
 
 	if (dev->caps.flags & MLX4_DEV_CAP_FLAG_MEM_WINDOW ||
 	    dev->caps.bmme_flags & MLX4_BMME_FLAG_TYPE_2_WIN) {
@@ -2718,9 +2709,6 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 
 	if (check_flow_steering_support(dev)) {
 		ibdev->steering_support = MLX4_STEERING_MODE_DEVICE_MANAGED;
-		ibdev->ib_dev.uverbs_ex_cmd_mask	|=
-			(1ull << IB_USER_VERBS_EX_CMD_CREATE_FLOW) |
-			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_FLOW);
 		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_fs_ops);
 	}
 
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 39ba7005f2c4c..215d6618839be 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4180,14 +4180,10 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 		(1ull << IB_USER_VERBS_CMD_DESTROY_SRQ)		|
 		(1ull << IB_USER_VERBS_CMD_CREATE_XSRQ)		|
 		(1ull << IB_USER_VERBS_CMD_OPEN_QP);
-	dev->ib_dev.uverbs_ex_cmd_mask =
-		(1ull << IB_USER_VERBS_EX_CMD_QUERY_DEVICE)	|
+	dev->ib_dev.uverbs_ex_cmd_mask |=
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_CQ)	|
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_QP)	|
-		(1ull << IB_USER_VERBS_EX_CMD_MODIFY_QP)	|
-		(1ull << IB_USER_VERBS_EX_CMD_MODIFY_CQ)	|
-		(1ull << IB_USER_VERBS_EX_CMD_CREATE_FLOW)	|
-		(1ull << IB_USER_VERBS_EX_CMD_DESTROY_FLOW);
+		(1ull << IB_USER_VERBS_EX_CMD_MODIFY_QP);
 
 	if (MLX5_CAP_GEN(mdev, ipoib_enhanced_offloads) &&
 	    IS_ENABLED(CONFIG_MLX5_CORE_IPOIB))
@@ -4290,12 +4286,6 @@ static int mlx5_ib_roce_init(struct mlx5_ib_dev *dev)
 	ll = mlx5_port_type_cap_to_rdma_ll(port_type_cap);
 
 	if (ll == IB_LINK_LAYER_ETHERNET) {
-		dev->ib_dev.uverbs_ex_cmd_mask |=
-			(1ull << IB_USER_VERBS_EX_CMD_CREATE_WQ) |
-			(1ull << IB_USER_VERBS_EX_CMD_MODIFY_WQ) |
-			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_WQ) |
-			(1ull << IB_USER_VERBS_EX_CMD_CREATE_RWQ_IND_TBL) |
-			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL);
 		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_common_roce_ops);
 
 		port_num = mlx5_core_native_port_num(dev->mdev) - 1;
-- 
2.39.2



