Return-Path: <stable+bounces-120939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BCCA5092B
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DE718852C1
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970D4253352;
	Wed,  5 Mar 2025 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZfMcT6N0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F9225334A;
	Wed,  5 Mar 2025 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198413; cv=none; b=CeODvFIvAExqHQ16ALrcpI2WUDQWO6+OfJF8c3mUnEKNv5WncvGPukwtN4fUHAJYq4v4WXFGC9Vbpkt3kbf76sAXWWwCUzaqzf5pcWl21L+M5MnflSMnfXZB0/Eru7Lo7xavSr+bTM3XX2m+peTuElCnzxN5zk384tyUBpZHRXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198413; c=relaxed/simple;
	bh=eYy4ih9yuMHV6pTD62qjeR1HgOO/roA1K/r39vFiuOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOQhv8ALtXSy7WFkxABIR+zAXT3rcDbUlph+dv9g7MEaZYQcwU/sBaPO6dMRGvsCYxVfsi2mQuxyO7R14tvuVBamoRgOGhKfi/DpVLeXm25jDzsRFFuJ/aNm5xPVjL4JlpyHllLgP0cDfWzbRzHLpWrgA0fH+yN9OyAIa1oC14s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZfMcT6N0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DCFC4CED1;
	Wed,  5 Mar 2025 18:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741198413;
	bh=eYy4ih9yuMHV6pTD62qjeR1HgOO/roA1K/r39vFiuOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZfMcT6N07HeYDY5oZUqXGhXTOGZg31UGSgAsZQvEiIvN8lUEaDgZPcCsJdLyFdUPV
	 ay0vL0twulZEwKFaPd4tolTbCnnusXQrr5OM0bjqNoO8vELaa1g8X117TBBXzFO6mJ
	 WRfEllgTNK1LkrafsKEUI+K6gzY0/OR7mciVzRaQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Zhang <markzhang@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 002/157] IB/mlx5: Set and get correct qp_num for a DCT QP
Date: Wed,  5 Mar 2025 18:47:18 +0100
Message-ID: <20250305174505.374449955@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
References: <20250305174505.268725418@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Zhang <markzhang@nvidia.com>

[ Upstream commit 12d044770e12c4205fa69535b4fa8a9981fea98f ]

When a DCT QP is created on an active lag, it's dctc.port is assigned
in a round-robin way, which is from 1 to dev->lag_port. In this case
when querying this QP, we may get qp_attr.port_num > 2.
Fix this by setting qp->port when modifying a DCT QP, and read port_num
from qp->port instead of dctc.port when querying it.

Fixes: 7c4b1ab9f167 ("IB/mlx5: Add DCT RoCE LAG support")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Link: https://patch.msgid.link/94c76bf0adbea997f87ffa27674e0a7118ad92a9.1737290358.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/qp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index a43eba9d3572c..08d22db8dca91 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4579,6 +4579,8 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 		set_id = mlx5_ib_get_counters_id(dev, attr->port_num - 1);
 		MLX5_SET(dctc, dctc, counter_set_id, set_id);
+
+		qp->port = attr->port_num;
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_RTR) {
 		struct mlx5_ib_modify_qp_resp resp = {};
 		u32 out[MLX5_ST_SZ_DW(create_dct_out)] = {};
@@ -5074,7 +5076,7 @@ static int mlx5_ib_dct_query_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *mqp,
 	}
 
 	if (qp_attr_mask & IB_QP_PORT)
-		qp_attr->port_num = MLX5_GET(dctc, dctc, port);
+		qp_attr->port_num = mqp->port;
 	if (qp_attr_mask & IB_QP_MIN_RNR_TIMER)
 		qp_attr->min_rnr_timer = MLX5_GET(dctc, dctc, min_rnr_nak);
 	if (qp_attr_mask & IB_QP_AV) {
-- 
2.39.5




