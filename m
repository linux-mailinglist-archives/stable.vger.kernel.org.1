Return-Path: <stable+bounces-126451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E060A700EA
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26CF03BDFCC
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A8326B2B2;
	Tue, 25 Mar 2025 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w+U8DYB5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FE026B2AA;
	Tue, 25 Mar 2025 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906249; cv=none; b=e/TGiW+NUKUcvd2BqzflB32OwcvyYo7Oko6bRYFsazWJEoSgOIr9QxSajXyFryosuuE32+YbBJF1FQA4nzNidCO0Scar+K3lQ9wIu/+XPNzvNULnvfVAPz0wgz0FKG9mslfdA91TVBF2O3jG0nGgDXUJn1YWSU9V7arloFXwViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906249; c=relaxed/simple;
	bh=HOEh4NGdZ/HkWXfCJYUs+V2xbWN67cCB+ZtxO/xvak4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3cY6JlVuRL03aQX6R1SczQ+ke5DKWHyls5EBmC3QPfasMgdDLNERAOOYYaRJNfKUqlvmRBu1yAIBIfmLNq/MR2e1tsI6AkY+1EiUQNzjJGlYlBxfMVqM2idTIv13fFtiIHc1sEIZRJYUq38PD0iWHn0gRlPdg9tlOZrv2CBrLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w+U8DYB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD2FC4CEE4;
	Tue, 25 Mar 2025 12:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742906249;
	bh=HOEh4NGdZ/HkWXfCJYUs+V2xbWN67cCB+ZtxO/xvak4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w+U8DYB5soK6a/C2mdUWLO7PNVclgpUd0+D0qC9m8Jj7gnEPY/A5jdY0twj7hQg9r
	 brqJYC9kcchuUOn9tL4mhDND9zK0Z+PbQZ0BMJsSR/zeAEIbM0ZwRIQAPCJ9X2TTG8
	 NPJBs+eq6teYk4SgDFRp9DzzLri9IQP/r1nz6W+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qasim Ijaz <qasdev00@gmail.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 017/116] RDMA/mlx5: Handle errors returned from mlx5r_ib_rate()
Date: Tue, 25 Mar 2025 08:21:44 -0400
Message-ID: <20250325122149.661753749@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122149.207086105@linuxfoundation.org>
References: <20250325122149.207086105@linuxfoundation.org>
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

From: Qasim Ijaz <qasdev00@gmail.com>

[ Upstream commit 556f93b90c1872ad85e216e613c0b33803e621cb ]

In function create_ib_ah() the following line attempts
to left shift the return value of mlx5r_ib_rate() by 4
and store it in the stat_rate_sl member of av:

However the code overlooks the fact that mlx5r_ib_rate()
may return -EINVAL if the rate passed to it is less than
IB_RATE_2_5_GBPS or greater than IB_RATE_800_GBPS.

Because of this, the code may invoke undefined behaviour when
shifting a signed negative value when doing "-EINVAL << 4".

To fix this check for errors before assigning stat_rate_sl and
propagate any error value to the callers.

Fixes: c534ffda781f ("RDMA/mlx5: Fix AH static rate parsing")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Link: https://patch.msgid.link/20250304140246.205919-1-qasdev00@gmail.com
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/ah.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/ah.c b/drivers/infiniband/hw/mlx5/ah.c
index 99036afb3aef0..531a57f9ee7e8 100644
--- a/drivers/infiniband/hw/mlx5/ah.c
+++ b/drivers/infiniband/hw/mlx5/ah.c
@@ -50,11 +50,12 @@ static __be16 mlx5_ah_get_udp_sport(const struct mlx5_ib_dev *dev,
 	return sport;
 }
 
-static void create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
+static int create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
 			 struct rdma_ah_init_attr *init_attr)
 {
 	struct rdma_ah_attr *ah_attr = init_attr->ah_attr;
 	enum ib_gid_type gid_type;
+	int rate_val;
 
 	if (rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH) {
 		const struct ib_global_route *grh = rdma_ah_read_grh(ah_attr);
@@ -67,8 +68,10 @@ static void create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
 		ah->av.tclass = grh->traffic_class;
 	}
 
-	ah->av.stat_rate_sl =
-		(mlx5r_ib_rate(dev, rdma_ah_get_static_rate(ah_attr)) << 4);
+	rate_val = mlx5r_ib_rate(dev, rdma_ah_get_static_rate(ah_attr));
+	if (rate_val < 0)
+		return rate_val;
+	ah->av.stat_rate_sl = rate_val << 4;
 
 	if (ah_attr->type == RDMA_AH_ATTR_TYPE_ROCE) {
 		if (init_attr->xmit_slave)
@@ -89,6 +92,8 @@ static void create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
 		ah->av.fl_mlid = rdma_ah_get_path_bits(ah_attr) & 0x7f;
 		ah->av.stat_rate_sl |= (rdma_ah_get_sl(ah_attr) & 0xf);
 	}
+
+	return 0;
 }
 
 int mlx5_ib_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
@@ -121,8 +126,7 @@ int mlx5_ib_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 			return err;
 	}
 
-	create_ib_ah(dev, ah, init_attr);
-	return 0;
+	return create_ib_ah(dev, ah, init_attr);
 }
 
 int mlx5_ib_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr)
-- 
2.39.5




