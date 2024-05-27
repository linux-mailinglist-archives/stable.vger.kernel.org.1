Return-Path: <stable+bounces-47425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 390D68D0DEC
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C942FB20CDE
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFE615FCFB;
	Mon, 27 May 2024 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AQz6tCYh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB73262BE;
	Mon, 27 May 2024 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838517; cv=none; b=bNm00vALqA/4/sP1VDkLQe8f+7MSpmbzECe1tVQaiOLyg646lWa4tueW/ojoxRV2P5SmomSzIzC/oIC6HjvG0JKo0Ek99tkdA665OnaExqHOBvJbiql4PGG8H3K7NyeMec1RZi0z1G/VrLxLs+1lm4ZD+25hFHO8DeV6j6oyDSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838517; c=relaxed/simple;
	bh=OAeQbCFK3AOq37dwitME1o3GruZTLcg62NVUjxT1dHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsvxfHl8W+5V/XZh6GNUIovZgpG+XiV+r5J9OiJAlNPc0ZuweWitUId6VSxtEP2jxtRNY5KlTqbwYKVHOMYChLUrDuCXiHeUfTJQ/pvJ7+CY6NXghn3v1nQjZz81o2AXsD0dB4Z2n+fx+ElNPDeuAj71PLL7MxaMIS9OREGmQZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AQz6tCYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B85EC2BBFC;
	Mon, 27 May 2024 19:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716838516;
	bh=OAeQbCFK3AOq37dwitME1o3GruZTLcg62NVUjxT1dHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AQz6tCYhaEGE7hkno/M3pH4xdoCAZTbmhZCb2dRhrUfmLt3WfYDGek3ViWgH29tMB
	 SvFdSQZ2o87A/5zaVe80WcB4plh6adeQQZXSw9lnSsb/jdUj7xEmK2Vmdo38GTSF6h
	 0uoCRB1fhT0rXHbGqsuVVsBZDPVasWK7gbbXyDd8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Or Har-Toov <ohartoov@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 422/493] RDMA/mlx5: Change check for cacheable mkeys
Date: Mon, 27 May 2024 20:57:04 +0200
Message-ID: <20240527185644.103659157@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Or Har-Toov <ohartoov@nvidia.com>

[ Upstream commit 8c1185fef68cc603b954fece2a434c9f851d6a86 ]

umem can be NULL for user application mkeys in some cases. Therefore
umem can't be used for checking if the mkey is cacheable and it is
changed for checking a flag that indicates it. Also make sure that
all mkeys which are not returned to the cache will be destroyed.

Fixes: dd1b913fb0d0 ("RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow")
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Link: https://lore.kernel.org/r/2690bc5c6896bcb937f89af16a1ff0343a7ab3d0.1712140377.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
 drivers/infiniband/hw/mlx5/mr.c      | 32 +++++++++++++++++++---------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 989968ba74153..79ebafecca22a 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -646,6 +646,7 @@ struct mlx5_ib_mkey {
 	/* Cacheable user Mkey must hold either a rb_key or a cache_ent. */
 	struct mlx5r_cache_rb_key rb_key;
 	struct mlx5_cache_ent *cache_ent;
+	u8 cacheable : 1;
 };
 
 #define MLX5_IB_MTT_PRESENT (MLX5_IB_MTT_READ | MLX5_IB_MTT_WRITE)
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index a8ee2ca1f4a17..7f7b1f59b5f05 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1158,6 +1158,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 		if (IS_ERR(mr))
 			return mr;
 		mr->mmkey.rb_key = rb_key;
+		mr->mmkey.cacheable = true;
 		return mr;
 	}
 
@@ -1168,6 +1169,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	mr->ibmr.pd = pd;
 	mr->umem = umem;
 	mr->page_shift = order_base_2(page_size);
+	mr->mmkey.cacheable = true;
 	set_mr_fields(dev, mr, umem->length, access_flags, iova);
 
 	return mr;
@@ -1835,6 +1837,23 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
 	return ret;
 }
 
+static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
+{
+	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
+	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
+
+	if (mr->mmkey.cacheable && !mlx5r_umr_revoke_mr(mr) && !cache_ent_find_and_store(dev, mr))
+		return 0;
+
+	if (ent) {
+		spin_lock_irq(&ent->mkeys_queue.lock);
+		ent->in_use--;
+		mr->mmkey.cache_ent = NULL;
+		spin_unlock_irq(&ent->mkeys_queue.lock);
+	}
+	return destroy_mkey(dev, mr);
+}
+
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct mlx5_ib_mr *mr = to_mmr(ibmr);
@@ -1880,16 +1899,9 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	}
 
 	/* Stop DMA */
-	if (mr->umem && mlx5r_umr_can_load_pas(dev, mr->umem->length))
-		if (mlx5r_umr_revoke_mr(mr) ||
-		    cache_ent_find_and_store(dev, mr))
-			mr->mmkey.cache_ent = NULL;
-
-	if (!mr->mmkey.cache_ent) {
-		rc = destroy_mkey(to_mdev(mr->ibmr.device), mr);
-		if (rc)
-			return rc;
-	}
+	rc = mlx5_revoke_mr(mr);
+	if (rc)
+		return rc;
 
 	if (mr->umem) {
 		bool is_odp = is_odp_mr(mr);
-- 
2.43.0




