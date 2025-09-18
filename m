Return-Path: <stable+bounces-174322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B654B36282
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6C218972B9
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C551338F24;
	Tue, 26 Aug 2025 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jrnw0NaX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD3A2459F3;
	Tue, 26 Aug 2025 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214084; cv=none; b=iBDwheVg0rqrIOu7ZS9NaZ0A+8vuBZj6K/0KVUdt48hZR2OBW0r+FpEy2XvJcOL2pHXORi7K55tggxVFqivU9uk5pJYxpjD2CagXfY5ZBtpZ7Qv0vRD/kRhY6cjxbvF9Ba/j2HnmGtwWfjsZ4vmYprY1xIR4PakT5JWd1l9wRZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214084; c=relaxed/simple;
	bh=oBRo2Z5aCMb9bkzwUgFjr5UEib8M7MNpVmRw2U++fzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yez4Yx7oSmNn9WhhTL3+ZVih9mUr8fcKOPEvY5c2Bg5W3pvp5FNwHBi38euOF3MFdWbh0xkTc2YV3s0rG0Q4D4P+MyL+nH6kQx2C+exFgjrx1g1tuTIV5GeiFIjusx4pEwFHe/sBuidcvGOxfZiQWfM79Id3ICpqb6FkEtEjNVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jrnw0NaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A76DC4CEF1;
	Tue, 26 Aug 2025 13:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214083;
	bh=oBRo2Z5aCMb9bkzwUgFjr5UEib8M7MNpVmRw2U++fzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jrnw0NaXFj+dJqqBcT94sAqRf5F+iLRqHOzajewcCBtUYIYQS7zS6giL+ne+JPxXb
	 qrVHZ3rGTKWK5+Uusw8KaUS8X5K8RBsKNFi1yduzprmf3h639EFc6KaQvelsqjC/xk
	 E2tH5VNjT7jvSmfYshoko03DKnz6WqpnziiNDtEA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Armen Ratner <armeng@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Alexei Lazar <alazar@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 583/587] net/mlx5e: Preserve shared buffer capacity during headroom updates
Date: Tue, 26 Aug 2025 13:12:12 +0200
Message-ID: <20250826111007.867647946@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Armen Ratner <armeng@nvidia.com>

[ Upstream commit 8b0587a885fdb34fd6090a3f8625cb7ac1444826 ]

When port buffer headroom changes, port_update_shared_buffer()
recalculates the shared buffer size and splits it in a 3:1 ratio
(lossy:lossless) - Currently, the calculation is:
lossless = shared / 4;
lossy = (shared / 4) * 3;

Meaning, the calculation dropped the remainder of shared % 4 due to
integer division, unintentionally reducing the total shared buffer
by up to three cells on each update. Over time, this could shrink
the buffer below usable size.

Fix it by changing the calculation to:
lossless = shared / 4;
lossy = shared - lossless;

This retains all buffer cells while still approximating the
intended 3:1 split, preventing capacity loss over time.

While at it, perform headroom calculations in units of cells rather than
in bytes for more accurate calculations avoiding extra divisions.

Fixes: a440030d8946 ("net/mlx5e: Update shared buffer along with device buffer changes")
Signed-off-by: Armen Ratner <armeng@nvidia.com>
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Link: https://patch.msgid.link/20250820133209.389065-9-mbloch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlx5/core/en/port_buffer.c        | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
index 5ae787656a7c..3efa8bf1d14e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
@@ -272,8 +272,8 @@ static int port_update_shared_buffer(struct mlx5_core_dev *mdev,
 	/* Total shared buffer size is split in a ratio of 3:1 between
 	 * lossy and lossless pools respectively.
 	 */
-	lossy_epool_size = (shared_buffer_size / 4) * 3;
 	lossless_ipool_size = shared_buffer_size / 4;
+	lossy_epool_size    = shared_buffer_size - lossless_ipool_size;
 
 	mlx5e_port_set_sbpr(mdev, 0, MLX5_EGRESS_DIR, MLX5_LOSSY_POOL, 0,
 			    lossy_epool_size);
@@ -288,14 +288,12 @@ static int port_set_buffer(struct mlx5e_priv *priv,
 	u16 port_buff_cell_sz = priv->dcbx.port_buff_cell_sz;
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int sz = MLX5_ST_SZ_BYTES(pbmc_reg);
-	u32 new_headroom_size = 0;
-	u32 current_headroom_size;
+	u32 current_headroom_cells = 0;
+	u32 new_headroom_cells = 0;
 	void *in;
 	int err;
 	int i;
 
-	current_headroom_size = port_buffer->headroom_size;
-
 	in = kzalloc(sz, GFP_KERNEL);
 	if (!in)
 		return -ENOMEM;
@@ -306,12 +304,14 @@ static int port_set_buffer(struct mlx5e_priv *priv,
 
 	for (i = 0; i < MLX5E_MAX_NETWORK_BUFFER; i++) {
 		void *buffer = MLX5_ADDR_OF(pbmc_reg, in, buffer[i]);
+		current_headroom_cells += MLX5_GET(bufferx_reg, buffer, size);
+
 		u64 size = port_buffer->buffer[i].size;
 		u64 xoff = port_buffer->buffer[i].xoff;
 		u64 xon = port_buffer->buffer[i].xon;
 
-		new_headroom_size += size;
 		do_div(size, port_buff_cell_sz);
+		new_headroom_cells += size;
 		do_div(xoff, port_buff_cell_sz);
 		do_div(xon, port_buff_cell_sz);
 		MLX5_SET(bufferx_reg, buffer, size, size);
@@ -320,10 +320,8 @@ static int port_set_buffer(struct mlx5e_priv *priv,
 		MLX5_SET(bufferx_reg, buffer, xon_threshold, xon);
 	}
 
-	new_headroom_size /= port_buff_cell_sz;
-	current_headroom_size /= port_buff_cell_sz;
-	err = port_update_shared_buffer(priv->mdev, current_headroom_size,
-					new_headroom_size);
+	err = port_update_shared_buffer(priv->mdev, current_headroom_cells,
+					new_headroom_cells);
 	if (err)
 		goto out;
 
-- 
2.50.1




