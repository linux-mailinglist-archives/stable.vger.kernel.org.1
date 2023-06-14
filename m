Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2700726B0B
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjFGUWJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjFGUVz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:21:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F94270D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:21:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85477643E3
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97484C4339B;
        Wed,  7 Jun 2023 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169290;
        bh=6DXz/ecHY7fJTbfYNIpI8YRmJJaotOG8gNooPZIp51U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rEm1CCmOPl5pox3esQH5OhBZAsxhhWM3fxgujpwkAw+P0oO6LlNVsJ6PFs6xQrd5m
         ukAaUWC+dUjVXSHeS8mgnIbIKqXn6ZmTz0s0GpS1AHm7FjVPQK/GX/TzLz52UdlDmx
         oy3BMDp5roTNeDD9IuOuVgKXk6ZjhwOhcq9XusE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maher Sanalla <msanalla@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 024/286] net/mlx5e: Consider internal buffers size in port buffer calculations
Date:   Wed,  7 Jun 2023 22:12:03 +0200
Message-ID: <20230607200923.809545905@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Maher Sanalla <msanalla@nvidia.com>

[ Upstream commit 81fe2be062915e2a2fdc494c3cd90e946e946c25 ]

Currently, when a user triggers a change in port buffer headroom
(buffers 0-7), the driver checks that the requested headroom does
not exceed the total port buffer size. However, this check does not
take into account the internal buffers (buffers 8-9), which are also
part of the total port buffer. This can result in treating invalid port
buffer change requests as valid, causing unintended changes to the shared
buffer.

To address this, include the internal buffers size in the calculation of
available port buffer space which ensures that port buffer requests do not
exceed the correct limit.

Furthermore, remove internal buffers (8-9) size from the total_size
calculation as these buffers are reserved for internal use and are not
exposed to the user.

While at it, add verbosity to the debug prints in
mlx5e_port_query_buffer() function to ease future debugging.

Fixes: ecdf2dadee8e ("net/mlx5e: Receive buffer support for DCBX")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlx5/core/en/port_buffer.c       | 42 ++++++++++++-------
 .../mellanox/mlx5/core/en/port_buffer.h       |  8 ++--
 .../ethernet/mellanox/mlx5/core/en_dcbnl.c    |  7 ++--
 3 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
index 7ac1ad9c46de0..0d78527451bca 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
@@ -51,7 +51,7 @@ int mlx5e_port_query_buffer(struct mlx5e_priv *priv,
 	if (err)
 		goto out;
 
-	for (i = 0; i < MLX5E_MAX_BUFFER; i++) {
+	for (i = 0; i < MLX5E_MAX_NETWORK_BUFFER; i++) {
 		buffer = MLX5_ADDR_OF(pbmc_reg, out, buffer[i]);
 		port_buffer->buffer[i].lossy =
 			MLX5_GET(bufferx_reg, buffer, lossy);
@@ -73,14 +73,24 @@ int mlx5e_port_query_buffer(struct mlx5e_priv *priv,
 			  port_buffer->buffer[i].lossy);
 	}
 
-	port_buffer->headroom_size = total_used;
+	port_buffer->internal_buffers_size = 0;
+	for (i = MLX5E_MAX_NETWORK_BUFFER; i < MLX5E_TOTAL_BUFFERS; i++) {
+		buffer = MLX5_ADDR_OF(pbmc_reg, out, buffer[i]);
+		port_buffer->internal_buffers_size +=
+			MLX5_GET(bufferx_reg, buffer, size) * port_buff_cell_sz;
+	}
+
 	port_buffer->port_buffer_size =
 		MLX5_GET(pbmc_reg, out, port_buffer_size) * port_buff_cell_sz;
-	port_buffer->spare_buffer_size =
-		port_buffer->port_buffer_size - total_used;
-
-	mlx5e_dbg(HW, priv, "total buffer size=%d, spare buffer size=%d\n",
-		  port_buffer->port_buffer_size,
+	port_buffer->headroom_size = total_used;
+	port_buffer->spare_buffer_size = port_buffer->port_buffer_size -
+					 port_buffer->internal_buffers_size -
+					 port_buffer->headroom_size;
+
+	mlx5e_dbg(HW, priv,
+		  "total buffer size=%u, headroom buffer size=%u, internal buffers size=%u, spare buffer size=%u\n",
+		  port_buffer->port_buffer_size, port_buffer->headroom_size,
+		  port_buffer->internal_buffers_size,
 		  port_buffer->spare_buffer_size);
 out:
 	kfree(out);
@@ -206,11 +216,11 @@ static int port_update_pool_cfg(struct mlx5_core_dev *mdev,
 	if (!MLX5_CAP_GEN(mdev, sbcam_reg))
 		return 0;
 
-	for (i = 0; i < MLX5E_MAX_BUFFER; i++)
+	for (i = 0; i < MLX5E_MAX_NETWORK_BUFFER; i++)
 		lossless_buff_count += ((port_buffer->buffer[i].size) &&
 				       (!(port_buffer->buffer[i].lossy)));
 
-	for (i = 0; i < MLX5E_MAX_BUFFER; i++) {
+	for (i = 0; i < MLX5E_MAX_NETWORK_BUFFER; i++) {
 		p = select_sbcm_params(&port_buffer->buffer[i], lossless_buff_count);
 		err = mlx5e_port_set_sbcm(mdev, 0, i,
 					  MLX5_INGRESS_DIR,
@@ -293,7 +303,7 @@ static int port_set_buffer(struct mlx5e_priv *priv,
 	if (err)
 		goto out;
 
-	for (i = 0; i < MLX5E_MAX_BUFFER; i++) {
+	for (i = 0; i < MLX5E_MAX_NETWORK_BUFFER; i++) {
 		void *buffer = MLX5_ADDR_OF(pbmc_reg, in, buffer[i]);
 		u64 size = port_buffer->buffer[i].size;
 		u64 xoff = port_buffer->buffer[i].xoff;
@@ -351,7 +361,7 @@ static int update_xoff_threshold(struct mlx5e_port_buffer *port_buffer,
 {
 	int i;
 
-	for (i = 0; i < MLX5E_MAX_BUFFER; i++) {
+	for (i = 0; i < MLX5E_MAX_NETWORK_BUFFER; i++) {
 		if (port_buffer->buffer[i].lossy) {
 			port_buffer->buffer[i].xoff = 0;
 			port_buffer->buffer[i].xon  = 0;
@@ -408,7 +418,7 @@ static int update_buffer_lossy(struct mlx5_core_dev *mdev,
 	int err;
 	int i;
 
-	for (i = 0; i < MLX5E_MAX_BUFFER; i++) {
+	for (i = 0; i < MLX5E_MAX_NETWORK_BUFFER; i++) {
 		prio_count = 0;
 		lossy_count = 0;
 
@@ -515,7 +525,7 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 
 	if (change & MLX5E_PORT_BUFFER_PRIO2BUFFER) {
 		update_prio2buffer = true;
-		for (i = 0; i < MLX5E_MAX_BUFFER; i++)
+		for (i = 0; i < MLX5E_MAX_NETWORK_BUFFER; i++)
 			mlx5e_dbg(HW, priv, "%s: requested to map prio[%d] to buffer %d\n",
 				  __func__, i, prio2buffer[i]);
 
@@ -530,7 +540,7 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 	}
 
 	if (change & MLX5E_PORT_BUFFER_SIZE) {
-		for (i = 0; i < MLX5E_MAX_BUFFER; i++) {
+		for (i = 0; i < MLX5E_MAX_NETWORK_BUFFER; i++) {
 			mlx5e_dbg(HW, priv, "%s: buffer[%d]=%d\n", __func__, i, buffer_size[i]);
 			if (!port_buffer.buffer[i].lossy && !buffer_size[i]) {
 				mlx5e_dbg(HW, priv, "%s: lossless buffer[%d] size cannot be zero\n",
@@ -544,7 +554,9 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 
 		mlx5e_dbg(HW, priv, "%s: total buffer requested=%d\n", __func__, total_used);
 
-		if (total_used > port_buffer.port_buffer_size)
+		if (total_used > port_buffer.headroom_size &&
+		    (total_used - port_buffer.headroom_size) >
+			    port_buffer.spare_buffer_size)
 			return -EINVAL;
 
 		update_buffer = true;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
index a6ef118de758f..f4a19ffbb641c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
@@ -35,7 +35,8 @@
 #include "en.h"
 #include "port.h"
 
-#define MLX5E_MAX_BUFFER 8
+#define MLX5E_MAX_NETWORK_BUFFER 8
+#define MLX5E_TOTAL_BUFFERS 10
 #define MLX5E_DEFAULT_CABLE_LEN 7 /* 7 meters */
 
 #define MLX5_BUFFER_SUPPORTED(mdev) (MLX5_CAP_GEN(mdev, pcam_reg) && \
@@ -60,8 +61,9 @@ struct mlx5e_bufferx_reg {
 struct mlx5e_port_buffer {
 	u32                       port_buffer_size;
 	u32                       spare_buffer_size;
-	u32                       headroom_size;
-	struct mlx5e_bufferx_reg  buffer[MLX5E_MAX_BUFFER];
+	u32                       headroom_size;	  /* Buffers 0-7 */
+	u32                       internal_buffers_size;  /* Buffers 8-9 */
+	struct mlx5e_bufferx_reg  buffer[MLX5E_MAX_NETWORK_BUFFER];
 };
 
 int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index 89de92d064836..ebee52a8361aa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -926,9 +926,10 @@ static int mlx5e_dcbnl_getbuffer(struct net_device *dev,
 	if (err)
 		return err;
 
-	for (i = 0; i < MLX5E_MAX_BUFFER; i++)
+	for (i = 0; i < MLX5E_MAX_NETWORK_BUFFER; i++)
 		dcb_buffer->buffer_size[i] = port_buffer.buffer[i].size;
-	dcb_buffer->total_size = port_buffer.port_buffer_size;
+	dcb_buffer->total_size = port_buffer.port_buffer_size -
+				 port_buffer.internal_buffers_size;
 
 	return 0;
 }
@@ -970,7 +971,7 @@ static int mlx5e_dcbnl_setbuffer(struct net_device *dev,
 	if (err)
 		return err;
 
-	for (i = 0; i < MLX5E_MAX_BUFFER; i++) {
+	for (i = 0; i < MLX5E_MAX_NETWORK_BUFFER; i++) {
 		if (port_buffer.buffer[i].size != dcb_buffer->buffer_size[i]) {
 			changed |= MLX5E_PORT_BUFFER_SIZE;
 			buffer_size = dcb_buffer->buffer_size;
-- 
2.39.2



