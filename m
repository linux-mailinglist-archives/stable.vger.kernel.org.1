Return-Path: <stable+bounces-161028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE9AAFD301
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D993ADD07
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453C2225414;
	Tue,  8 Jul 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vRRnm4tF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D9F18EAB;
	Tue,  8 Jul 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993390; cv=none; b=pbjHXRUm+q4Pc8STQcASlcY4B1P0ASHu45tiAw5UgWUJbWDDSJwuBlmAfUvI5TVmFI1T/4oAacTrjGjnw9Ux9Oz5a4SYxBpqUuktzmvXYsaIOzZt6u5QkMHbo2rpm4XoI5uYANjmPXlx8yTMvvQpEuDubUWwWQAxdWDAZC+6ghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993390; c=relaxed/simple;
	bh=oahXISvbq6Q8RUF2iH6/qALfoTR0G55SDQNR+1v08E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieo3PuiR8UHhXkS810nwo+N8x7gFlzIMMyHJz+PoWLmq77Bjx5LSfUjVCL1xfJBkfleLljUNI3f0XLgk6GFrvXDED44eqkkaPOXb/nIlB25oJJ99jzOqhemqs05f81Br3F+F2qj3DeXSeJjYsowBRbLgjYhPlyWNJuM1qTs4VK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vRRnm4tF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50728C4CEED;
	Tue,  8 Jul 2025 16:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993389;
	bh=oahXISvbq6Q8RUF2iH6/qALfoTR0G55SDQNR+1v08E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vRRnm4tFukP+pZXgiDcN3SD6zrayc4WPh2RWy+wjsuyTzXHgZIDTYnl1inXDTVSno
	 6aSBLrR0euzVX/Pw/PyF+o4MUqqPOYTLcGisOqmBt+t9A6dZnSs+PC6o/yyZsHQJL/
	 iryA1jxk0/TTzMGNo2z1MF2/jcwG4TtxLwn5rpYw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Patrisious Haddad <phaddad@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 057/178] RDMA/mlx5: Fix vport loopback for MPV device
Date: Tue,  8 Jul 2025 18:21:34 +0200
Message-ID: <20250708162238.169484990@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrisious Haddad <phaddad@nvidia.com>

[ Upstream commit a9a9e68954f29b1e197663f76289db4879fd51bb ]

Always enable vport loopback for both MPV devices on driver start.

Previously in some cases related to MPV RoCE, packets weren't correctly
executing loopback check at vport in FW, since it was disabled.
Due to complexity of identifying such cases for MPV always enable vport
loopback for both GVMIs when binding the slave to the master port.

Fixes: 0042f9e458a5 ("RDMA/mlx5: Enable vport loopback when user context or QP mandate")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Link: https://patch.msgid.link/d4298f5ebb2197459e9e7221c51ecd6a34699847.1750064969.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/main.c | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index d07cacaa0abd0..4ffe3afb560c9 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1779,6 +1779,33 @@ static void deallocate_uars(struct mlx5_ib_dev *dev,
 					     context->devx_uid);
 }
 
+static int mlx5_ib_enable_lb_mp(struct mlx5_core_dev *master,
+				struct mlx5_core_dev *slave)
+{
+	int err;
+
+	err = mlx5_nic_vport_update_local_lb(master, true);
+	if (err)
+		return err;
+
+	err = mlx5_nic_vport_update_local_lb(slave, true);
+	if (err)
+		goto out;
+
+	return 0;
+
+out:
+	mlx5_nic_vport_update_local_lb(master, false);
+	return err;
+}
+
+static void mlx5_ib_disable_lb_mp(struct mlx5_core_dev *master,
+				  struct mlx5_core_dev *slave)
+{
+	mlx5_nic_vport_update_local_lb(slave, false);
+	mlx5_nic_vport_update_local_lb(master, false);
+}
+
 int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 {
 	int err = 0;
@@ -3483,6 +3510,8 @@ static void mlx5_ib_unbind_slave_port(struct mlx5_ib_dev *ibdev,
 
 	lockdep_assert_held(&mlx5_ib_multiport_mutex);
 
+	mlx5_ib_disable_lb_mp(ibdev->mdev, mpi->mdev);
+
 	mlx5_core_mp_event_replay(ibdev->mdev,
 				  MLX5_DRIVER_EVENT_AFFILIATION_REMOVED,
 				  NULL);
@@ -3578,6 +3607,10 @@ static bool mlx5_ib_bind_slave_port(struct mlx5_ib_dev *ibdev,
 				  MLX5_DRIVER_EVENT_AFFILIATION_DONE,
 				  &key);
 
+	err = mlx5_ib_enable_lb_mp(ibdev->mdev, mpi->mdev);
+	if (err)
+		goto unbind;
+
 	return true;
 
 unbind:
-- 
2.39.5




