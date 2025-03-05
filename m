Return-Path: <stable+bounces-120636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D832A507A6
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1E63A652E
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA20514884C;
	Wed,  5 Mar 2025 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d8zIF0Kf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3A9250C07;
	Wed,  5 Mar 2025 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197534; cv=none; b=IQPtTib9worexC+3UYl/0NdVJRHkRURfP/LV6grDZPVNV6qpnPwSvg2+ba8/+FFkvVFmLw3MNUG+1/XV3pyYIwg5k5paj82Lfv56WFoJQP2gxFCLLomOS+LFnanHz9xVJSHtUoOImJsvDSM100/NGlYC6HrSOfPOWFLZ7HTrmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197534; c=relaxed/simple;
	bh=blGe8XwU7y2AYcMBGkZ2L0lPwgyE/mXxKB+iPk5/Mns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdKOM5KEmGSJ25bp7tpyGhZPIK60aWXAnnMBgV3CkFIX4PgULwqPRMHKgtF89Zkud/EkYt5N0UppPDJhe0NHjnv9tmHv3VQPFQEqjnDm3VgB1h8QPKqjOw/poHr12XcMUpCTwZO0WKNoqkK71ts4OZSy91wtVwcRC4dpe1doTUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d8zIF0Kf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA723C4CEE2;
	Wed,  5 Mar 2025 17:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197534;
	bh=blGe8XwU7y2AYcMBGkZ2L0lPwgyE/mXxKB+iPk5/Mns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d8zIF0KfX7lJkeE+O75pb9gF8wyQiRXP3yVcUxtBnl0U/nILE2z8Moq9YKs3Jino2
	 10fQxUoKL78r9DAUGmCTVycHci7eB7hQh9bo3Z4SqTcqxGxNnYR/Si4qNFifyzX9nq
	 JXAYN2LKEX3jIYz0hSgL/S/WQpHn0KZ/S+mNngoE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Patrisious Haddad <phaddad@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 013/142] RDMA/mlx5: Fix AH static rate parsing
Date: Wed,  5 Mar 2025 18:47:12 +0100
Message-ID: <20250305174500.871472573@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174500.327985489@linuxfoundation.org>
References: <20250305174500.327985489@linuxfoundation.org>
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

From: Patrisious Haddad <phaddad@nvidia.com>

[ Upstream commit c534ffda781f44a1c6ac25ef6e0e444da38ca8af ]

Previously static rate wasn't translated according to our PRM but simply
used the 4 lower bytes.

Correctly translate static rate value passed in AH creation attribute
according to our PRM expected values.

In addition change 800GB mapping to zero, which is the PRM
specified value.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Link: https://patch.msgid.link/18ef4cc5396caf80728341eb74738cd777596f60.1739187089.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/ah.c | 3 ++-
 drivers/infiniband/hw/mlx5/qp.c | 6 +++---
 drivers/infiniband/hw/mlx5/qp.h | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/ah.c b/drivers/infiniband/hw/mlx5/ah.c
index 505bc47fd575d..99036afb3aef0 100644
--- a/drivers/infiniband/hw/mlx5/ah.c
+++ b/drivers/infiniband/hw/mlx5/ah.c
@@ -67,7 +67,8 @@ static void create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
 		ah->av.tclass = grh->traffic_class;
 	}
 
-	ah->av.stat_rate_sl = (rdma_ah_get_static_rate(ah_attr) << 4);
+	ah->av.stat_rate_sl =
+		(mlx5r_ib_rate(dev, rdma_ah_get_static_rate(ah_attr)) << 4);
 
 	if (ah_attr->type == RDMA_AH_ATTR_TYPE_ROCE) {
 		if (init_attr->xmit_slave)
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 3df863c88b31d..0a9ae84600b20 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3433,11 +3433,11 @@ static int ib_to_mlx5_rate_map(u8 rate)
 	return 0;
 }
 
-static int ib_rate_to_mlx5(struct mlx5_ib_dev *dev, u8 rate)
+int mlx5r_ib_rate(struct mlx5_ib_dev *dev, u8 rate)
 {
 	u32 stat_rate_support;
 
-	if (rate == IB_RATE_PORT_CURRENT)
+	if (rate == IB_RATE_PORT_CURRENT || rate == IB_RATE_800_GBPS)
 		return 0;
 
 	if (rate < IB_RATE_2_5_GBPS || rate > IB_RATE_600_GBPS)
@@ -3582,7 +3582,7 @@ static int mlx5_set_path(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 		       sizeof(grh->dgid.raw));
 	}
 
-	err = ib_rate_to_mlx5(dev, rdma_ah_get_static_rate(ah));
+	err = mlx5r_ib_rate(dev, rdma_ah_get_static_rate(ah));
 	if (err < 0)
 		return err;
 	MLX5_SET(ads, path, stat_rate, err);
diff --git a/drivers/infiniband/hw/mlx5/qp.h b/drivers/infiniband/hw/mlx5/qp.h
index b6ee7c3ee1ca1..2530e7730635f 100644
--- a/drivers/infiniband/hw/mlx5/qp.h
+++ b/drivers/infiniband/hw/mlx5/qp.h
@@ -56,4 +56,5 @@ int mlx5_core_xrcd_dealloc(struct mlx5_ib_dev *dev, u32 xrcdn);
 int mlx5_ib_qp_set_counter(struct ib_qp *qp, struct rdma_counter *counter);
 int mlx5_ib_qp_event_init(void);
 void mlx5_ib_qp_event_cleanup(void);
+int mlx5r_ib_rate(struct mlx5_ib_dev *dev, u8 rate);
 #endif /* _MLX5_IB_QP_H */
-- 
2.39.5




