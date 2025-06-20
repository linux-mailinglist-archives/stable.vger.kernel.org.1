Return-Path: <stable+bounces-154915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C12AE1336
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B1A17E373
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D174C1F09BF;
	Fri, 20 Jun 2025 05:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I98RrufB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913631DED53
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398195; cv=none; b=YYpCxoRoIwGYbzhBE1WWR2L/IBXEwmxbXxoDiYvp91o3ucIRXSc1Hy7v7FQQVSa3gWH5rMBTN9alSIMGRFcs6U+V+JBU8n+zh9HtXBMn7aAIbnm2W9ZOEHJGdk/dIzutHPOsFkt66aVEW5UXHsPYR/A7MO5j9C5U+QnPh70GU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398195; c=relaxed/simple;
	bh=L+uP4yMJqHGZQFCe4cKNLxveaArx/qH1ejiLbctLOxY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VbCBj7tTkUT6FzLxjEJe1ALsVigQvgXpQ1vevST6wEb+tZja80lr0KZR7yJF6H/sKoUCv/PnG6WQG1OPQ0BnnmiUMa3oUSWVIHYj5inYLfUuVavFSQ+RtYhDUW9ZzTaVI9NQ72xmkj1H1Z7Gc6X0y7nkek1lIgAwW8dLisTVte0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I98RrufB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95B1C4CEE3;
	Fri, 20 Jun 2025 05:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750398195;
	bh=L+uP4yMJqHGZQFCe4cKNLxveaArx/qH1ejiLbctLOxY=;
	h=Subject:To:Cc:From:Date:From;
	b=I98RrufBVIVVFX4R7F6sZ8Uraa3n/IY4b5/AFQ0UM5dfZU+fSbez92Tmk1vhcqB+O
	 wWNNZyL4jB4GMxCuKg1/Xxg3rMLWG7ekz4FteWBuTUAOAehGOAbvvqILEoifG786pI
	 KWTl++htg/wCzw5I1ayk1tad9J0LlqgVRu4yEs9g=
Subject: FAILED: patch "[PATCH] net/mlx5: Add error handling in" failed to apply to 5.4-stable tree
To: vulab@iscas.ac.cn,kuba@kernel.org,tariqt@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:43:12 +0200
Message-ID: <2025062012-sassy-perm-01be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x c6bb8a21cdad8c975a3a646b9e5c8df01ad29783
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062012-sassy-perm-01be@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c6bb8a21cdad8c975a3a646b9e5c8df01ad29783 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Sun, 25 May 2025 00:34:25 +0800
Subject: [PATCH] net/mlx5: Add error handling in
 mlx5_query_nic_vport_node_guid()

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

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index a3c57bb8b521..da5c24fc7b30 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -465,19 +465,22 @@ int mlx5_query_nic_vport_node_guid(struct mlx5_core_dev *mdev, u64 *node_guid)
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
 


