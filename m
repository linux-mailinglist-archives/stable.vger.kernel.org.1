Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFD16FA5E5
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjEHKOP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjEHKN6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:13:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6BC3ACC4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:13:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 760596242B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89233C433D2;
        Mon,  8 May 2023 10:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540836;
        bh=MJGGoQYL848tXA9zQMv9KVHaMkWFWjIsnAnheDaVzW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xT+d+SF4mYzNCClMimj9eMSEDJ0ZhjMSKHJlKU2POpc6+jtpYobGXaUkVFa8AcRE5
         Qz0tYXWs9RYSJYipQxQATpj27KkGDo9C/mKg3D9XsxfYhUgdklU9vXCivqa8B/SRwD
         RNi6AfPGa160/kxiovu0HTZJ4DHe4/rUrYL9LXro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Bloch <mbloch@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 515/611] RDMA/mlx5: Fix flow counter query via DEVX
Date:   Mon,  8 May 2023 11:45:57 +0200
Message-Id: <20230508094438.780183850@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Mark Bloch <mbloch@nvidia.com>

[ Upstream commit 3e358ea8614ddfbc59ca7a3f5dff5dde2b350b2c ]

Commit cited in "fixes" tag added bulk support for flow counters but it
didn't account that's also possible to query a counter using a non-base id
if the counter was allocated as bulk.

When a user performs a query, validate the flow counter id given in the
mailbox is inside the valid range taking bulk value into account.

Fixes: 208d70f562e5 ("IB/mlx5: Support flow counters offset for bulk counters")
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Link: https://lore.kernel.org/r/79d7fbe291690128e44672418934256254d93115.1681377114.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/devx.c | 31 ++++++++++++++++++++++++++-----
 include/linux/mlx5/mlx5_ifc.h     |  3 ++-
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 2211a0be16f36..f8e2baed27a5c 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -666,7 +666,21 @@ static bool devx_is_valid_obj_id(struct uverbs_attr_bundle *attrs,
 				      obj_id;
 
 	case MLX5_IB_OBJECT_DEVX_OBJ:
-		return ((struct devx_obj *)uobj->object)->obj_id == obj_id;
+	{
+		u16 opcode = MLX5_GET(general_obj_in_cmd_hdr, in, opcode);
+		struct devx_obj *devx_uobj = uobj->object;
+
+		if (opcode == MLX5_CMD_OP_QUERY_FLOW_COUNTER &&
+		    devx_uobj->flow_counter_bulk_size) {
+			u64 end;
+
+			end = devx_uobj->obj_id +
+				devx_uobj->flow_counter_bulk_size;
+			return devx_uobj->obj_id <= obj_id && end > obj_id;
+		}
+
+		return devx_uobj->obj_id == obj_id;
+	}
 
 	default:
 		return false;
@@ -1517,10 +1531,17 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_CREATE)(
 		goto obj_free;
 
 	if (opcode == MLX5_CMD_OP_ALLOC_FLOW_COUNTER) {
-		u8 bulk = MLX5_GET(alloc_flow_counter_in,
-				   cmd_in,
-				   flow_counter_bulk);
-		obj->flow_counter_bulk_size = 128UL * bulk;
+		u32 bulk = MLX5_GET(alloc_flow_counter_in,
+				    cmd_in,
+				    flow_counter_bulk_log_size);
+
+		if (bulk)
+			bulk = 1 << bulk;
+		else
+			bulk = 128UL * MLX5_GET(alloc_flow_counter_in,
+						cmd_in,
+						flow_counter_bulk);
+		obj->flow_counter_bulk_size = bulk;
 	}
 
 	uobj->object = obj;
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index e45bdec73baf1..097cbf84c1e05 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -9063,7 +9063,8 @@ struct mlx5_ifc_alloc_flow_counter_in_bits {
 	u8         reserved_at_20[0x10];
 	u8         op_mod[0x10];
 
-	u8         reserved_at_40[0x38];
+	u8         reserved_at_40[0x33];
+	u8         flow_counter_bulk_log_size[0x5];
 	u8         flow_counter_bulk[0x8];
 };
 
-- 
2.39.2



