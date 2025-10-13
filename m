Return-Path: <stable+bounces-185201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECE3BD50F2
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961323E74F2
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A31D30BF66;
	Mon, 13 Oct 2025 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mTe+Di6W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA630B515;
	Mon, 13 Oct 2025 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369620; cv=none; b=RDc15t/K0JhI5bky4Gy7rDFn6+JfNtr4nL0KyKTKB0a9woTKJDtvxJyKBcbDT1WvcSh6ZDdCHxKMggU9asPSlcyRb80DU+BE/lJa+V6gosZUg19K9zhwYl1IWrVel5IP9Vl4XKOtDaAOCzrpXJ63xv1vhCnOOkeWWx9GuUb/p90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369620; c=relaxed/simple;
	bh=PwCgI6XJKixlskNEe/FnpKt0nnyoaH51I7C24W8XejY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j97+/f6FZ1swGxf3T5vUPjGbVGVmZehV0IB1KkLsl6BtPihuAC0yxks2UXmulk81AJhyUx8A9oaUNNgeve623T78tISGQ7pMxkrBrpzYXXZehNoNXt43cv2OdxBZqRR+z0QOOAJ0oWD6NYAwiopgy1rExDFTHb2yN0O9fskPU8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mTe+Di6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA11C4CEE7;
	Mon, 13 Oct 2025 15:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760369619;
	bh=PwCgI6XJKixlskNEe/FnpKt0nnyoaH51I7C24W8XejY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mTe+Di6WVJQfacyUFrLfE9bRy7X6gO4uWev3B6O2WTEm3BYSMquazDFFchMDyk/KX
	 vi0z1D2EsBYXji1V6zJIMxZrqEElbxEL58sEAV//oZd0fr+n0TaQbMuRWFjhXRfSZe
	 7Uoej/gmjvjN3fUk8UflUWZBJkwQgpb02wFQ5B0Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Patrisious Haddad <phaddad@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 267/563] RDMA/mlx5: Fix vport loopback forcing for MPV device
Date: Mon, 13 Oct 2025 16:42:08 +0200
Message-ID: <20251013144420.949799935@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrisious Haddad <phaddad@nvidia.com>

[ Upstream commit 08aae7860450c89eebbc6fd4d38416e53c7a33d2 ]

Previously loopback for MPV was supposed to be permanently enabled,
however other driver flows were able to over-ride that configuration and
disable it.

Add force_lb parameter that indicates that loopback should always be
enabled which prevents all other driver flows from disabling it.

Fixes: a9a9e68954f2 ("RDMA/mlx5: Fix vport loopback for MPV device")
Link: https://patch.msgid.link/r/cfc6b1f0f99f8100b087483cc14da6025317f901.1755088808.git.leon@kernel.org
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/main.c    | 19 +++++++++++++++----
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 20d15207a5f1f..5fabd39b7492a 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1839,7 +1839,8 @@ static void deallocate_uars(struct mlx5_ib_dev *dev,
 }
 
 static int mlx5_ib_enable_lb_mp(struct mlx5_core_dev *master,
-				struct mlx5_core_dev *slave)
+				struct mlx5_core_dev *slave,
+				struct mlx5_ib_lb_state *lb_state)
 {
 	int err;
 
@@ -1851,6 +1852,7 @@ static int mlx5_ib_enable_lb_mp(struct mlx5_core_dev *master,
 	if (err)
 		goto out;
 
+	lb_state->force_enable = true;
 	return 0;
 
 out:
@@ -1859,16 +1861,22 @@ static int mlx5_ib_enable_lb_mp(struct mlx5_core_dev *master,
 }
 
 static void mlx5_ib_disable_lb_mp(struct mlx5_core_dev *master,
-				  struct mlx5_core_dev *slave)
+				  struct mlx5_core_dev *slave,
+				  struct mlx5_ib_lb_state *lb_state)
 {
 	mlx5_nic_vport_update_local_lb(slave, false);
 	mlx5_nic_vport_update_local_lb(master, false);
+
+	lb_state->force_enable = false;
 }
 
 int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 {
 	int err = 0;
 
+	if (dev->lb.force_enable)
+		return 0;
+
 	mutex_lock(&dev->lb.mutex);
 	if (td)
 		dev->lb.user_td++;
@@ -1890,6 +1898,9 @@ int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 
 void mlx5_ib_disable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 {
+	if (dev->lb.force_enable)
+		return;
+
 	mutex_lock(&dev->lb.mutex);
 	if (td)
 		dev->lb.user_td--;
@@ -3569,7 +3580,7 @@ static void mlx5_ib_unbind_slave_port(struct mlx5_ib_dev *ibdev,
 
 	lockdep_assert_held(&mlx5_ib_multiport_mutex);
 
-	mlx5_ib_disable_lb_mp(ibdev->mdev, mpi->mdev);
+	mlx5_ib_disable_lb_mp(ibdev->mdev, mpi->mdev, &ibdev->lb);
 
 	mlx5_core_mp_event_replay(ibdev->mdev,
 				  MLX5_DRIVER_EVENT_AFFILIATION_REMOVED,
@@ -3666,7 +3677,7 @@ static bool mlx5_ib_bind_slave_port(struct mlx5_ib_dev *ibdev,
 				  MLX5_DRIVER_EVENT_AFFILIATION_DONE,
 				  &key);
 
-	err = mlx5_ib_enable_lb_mp(ibdev->mdev, mpi->mdev);
+	err = mlx5_ib_enable_lb_mp(ibdev->mdev, mpi->mdev, &ibdev->lb);
 	if (err)
 		goto unbind;
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 7ffc7ee92cf03..8d21ecf8a996f 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1109,6 +1109,7 @@ struct mlx5_ib_lb_state {
 	u32			user_td;
 	int			qps;
 	bool			enabled;
+	bool			force_enable;
 };
 
 struct mlx5_ib_pf_eq {
-- 
2.51.0




