Return-Path: <stable+bounces-55535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0CC916407
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 330CCB254E4
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831CF149C41;
	Tue, 25 Jun 2024 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yO4AcWXS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A6824B34;
	Tue, 25 Jun 2024 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309189; cv=none; b=Uv3rL953S++x0anwWEkZeeUxmey+LymXhgsnlyrISbeQvavC2KdiUGpvry1p6irYNLqujfKMpnvRJsGdPnz77ZCF6+YqYSf978E7atj0GCQfaDIU7fKkge5TZMZO0ae8PaIRDkN3H/6g0tQ8FeDS9d54gIRP5V6XD8sY24oGqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309189; c=relaxed/simple;
	bh=+XfPgsVZL10YbX/TVX5xvqwTowUwJO0YDRyKtwvjhWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swPxklBVPX82yaxWAjZN30Ye57xeqiVkTx7f2R/TClJj8ALtrzFvPqum0g6Vi3HZKnWORyg5ARRfiBi1FMqEqfWdSbfUpwukLcfdYjkJqjubU/XwiV26vcl22LEnaIdxzogZkjHQuqA1KwCZy5yOoqhYRoQ14FVl3eyyvGVEHuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yO4AcWXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DA3C32781;
	Tue, 25 Jun 2024 09:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719309189;
	bh=+XfPgsVZL10YbX/TVX5xvqwTowUwJO0YDRyKtwvjhWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yO4AcWXStW3jmMeO0Owm1uo8PJeQivq4Bh5zFXfrwFVCmkaIm8n2KLFPso1rFUV9F
	 +GuJMgLKT74SI5FtN9TnYDBp4MJYIEmOVpxwx78d7PHL8+sf5Hl7YtLz+CSUz1DgrN
	 KWw2fAOTTGS7KC0BS4PZL1C0D2QpgzxE3u+hRKBE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Patrisious Haddad <phaddad@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 126/192] RDMA/mlx5: Add check for srq max_sge attribute
Date: Tue, 25 Jun 2024 11:33:18 +0200
Message-ID: <20240625085542.002765656@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
References: <20240625085537.150087723@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrisious Haddad <phaddad@nvidia.com>

[ Upstream commit 36ab7ada64caf08f10ee5a114d39964d1f91e81d ]

max_sge attribute is passed by the user, and is inserted and used
unchecked, so verify that the value doesn't exceed maximum allowed value
before using it.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Link: https://lore.kernel.org/r/277ccc29e8d57bfd53ddeb2ac633f2760cf8cdd0.1716900410.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/srq.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index a056ea835da54..84be0c3d56995 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -199,17 +199,20 @@ int mlx5_ib_create_srq(struct ib_srq *ib_srq,
 	int err;
 	struct mlx5_srq_attr in = {};
 	__u32 max_srq_wqes = 1 << MLX5_CAP_GEN(dev->mdev, log_max_srq_sz);
+	__u32 max_sge_sz =  MLX5_CAP_GEN(dev->mdev, max_wqe_sz_rq) /
+			    sizeof(struct mlx5_wqe_data_seg);
 
 	if (init_attr->srq_type != IB_SRQT_BASIC &&
 	    init_attr->srq_type != IB_SRQT_XRC &&
 	    init_attr->srq_type != IB_SRQT_TM)
 		return -EOPNOTSUPP;
 
-	/* Sanity check SRQ size before proceeding */
-	if (init_attr->attr.max_wr >= max_srq_wqes) {
-		mlx5_ib_dbg(dev, "max_wr %d, cap %d\n",
-			    init_attr->attr.max_wr,
-			    max_srq_wqes);
+	/* Sanity check SRQ and sge size before proceeding */
+	if (init_attr->attr.max_wr >= max_srq_wqes ||
+	    init_attr->attr.max_sge > max_sge_sz) {
+		mlx5_ib_dbg(dev, "max_wr %d,wr_cap %d,max_sge %d, sge_cap:%d\n",
+			    init_attr->attr.max_wr, max_srq_wqes,
+			    init_attr->attr.max_sge, max_sge_sz);
 		return -EINVAL;
 	}
 
-- 
2.43.0




