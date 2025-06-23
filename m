Return-Path: <stable+bounces-156265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A37AE4EDA
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF573BE917
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804BB1F582A;
	Mon, 23 Jun 2025 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oi2apokd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0A170838;
	Mon, 23 Jun 2025 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712990; cv=none; b=Bm93HRJyj9HjFyjpWDBKfERCuYGAQh9mjdL9qp5EnKZ7tAfw8VNJ1q3/ewfDiCluRfYsE1M2eXs6gLMvrFDcpYx5q9JEtZ8xDpEU7r5tczfTqjxl9ym0MKAqZ895RldnaEOq1P+sPHbTd0JLxafCKFTpymY0bHpvoa1FbK0Sb58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712990; c=relaxed/simple;
	bh=0SIzzhX7a/h8Bw3BKn1CwP3pGJ2i8SImg7RVqN31r20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTvnoLBSwX/1Jn83WDU963pz8/sA4CeVt8ifj5HLZ7S4rmc5ixkHf3+Kusg+pybOpV3ASYTS6gbyCsginLLXiG475MtajxEmEWCc4eUtlOmLGsU5X8hXi3DGSZOgvFElaMBC5bQ336GGNhmIxagFyb82bwjImP1lJAOLSEHwN1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oi2apokd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA129C4CEEA;
	Mon, 23 Jun 2025 21:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750712990;
	bh=0SIzzhX7a/h8Bw3BKn1CwP3pGJ2i8SImg7RVqN31r20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oi2apokdW5Rgv9kLl85b4NbQlffod0Rm25o0lhCQZegZZ+Zv/jCFDmD2dfZo5x497
	 +Iamvtx4EjBvprqOZkO33yJrB6V4oUP0TUcJkQy5kjYfkBGOuRyYqKXa9LKMz73ylj
	 aPUEntbJphHy10MjNu0CVCLRkUzC0UgLk9Pn0Mps=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 022/414] net/mlx5: Add error handling in mlx5_query_nic_vport_node_guid()
Date: Mon, 23 Jun 2025 15:02:39 +0200
Message-ID: <20250623130642.580850795@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Liang <vulab@iscas.ac.cn>

commit c6bb8a21cdad8c975a3a646b9e5c8df01ad29783 upstream.

The function mlx5_query_nic_vport_node_guid() calls the function
mlx5_query_nic_vport_context() but does not check its return value.
A proper implementation can be found in mlx5_nic_vport_query_local_lb().

Add error handling for mlx5_query_nic_vport_context(). If it fails, free
the out buffer via kvfree() and return error code.

Fixes: 9efa75254593 ("net/mlx5_core: Introduce access functions to query vport RoCE fields")
Cc: stable@vger.kernel.org # v4.5
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20250524163425.1695-1-vulab@iscas.ac.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/vport.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -465,19 +465,22 @@ int mlx5_query_nic_vport_node_guid(struc
 {
 	u32 *out;
 	int outlen = MLX5_ST_SZ_BYTES(query_nic_vport_context_out);
+	int err;
 
 	out = kvzalloc(outlen, GFP_KERNEL);
 	if (!out)
 		return -ENOMEM;
 
-	mlx5_query_nic_vport_context(mdev, 0, out);
+	err = mlx5_query_nic_vport_context(mdev, 0, out);
+	if (err)
+		goto out;
 
 	*node_guid = MLX5_GET64(query_nic_vport_context_out, out,
 				nic_vport_context.node_guid);
-
+out:
 	kvfree(out);
 
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(mlx5_query_nic_vport_node_guid);
 



