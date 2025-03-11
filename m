Return-Path: <stable+bounces-123946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B4EA5C82D
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F04F188842C
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45773C0B;
	Tue, 11 Mar 2025 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SxYzS+WW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A20237701;
	Tue, 11 Mar 2025 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707418; cv=none; b=XEpy1dVbqONLZSPqUrNnkQRIuwH+jLYX1CN8hx6SvziRAhu5ubjkuj7Wpm3KH2n4hygFhib5GzXcatTJbG8rR5r4Tb5DkGySo0kiUoaoqJekxiUEHPZvU9kFQKrtv0fK29UWMbg3RLDekmA8Tz6JChUSTYFAnfLSvImlwZL8kzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707418; c=relaxed/simple;
	bh=spSyPLyA21dveQV/ep1lLC0GHP4hh0w3VmLU9PySzKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMN6fVAvTO+PeRCm+YuT9ehxuCxJTGbXmY2ms0TnV7LRS4lLpBpP8r0jOITl2eOBfJwBAYTcoMGQyXvOqwtLIzXtWl+iIPZwDdfSAbqzI8sKbl43CrBllxkOXkJzksQ+7WRBNMdrrdbim2+sllyz2D9bQWhtT06N7b3513mn+DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SxYzS+WW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A137C4CEEC;
	Tue, 11 Mar 2025 15:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741707418;
	bh=spSyPLyA21dveQV/ep1lLC0GHP4hh0w3VmLU9PySzKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SxYzS+WWf9Wha2nTuIV81TNChy5hOMGFX/uR/MuMX+XJ6Kk3noOsLgNrGq97TtcH+
	 Vmav/1LTw0JaSLcTqL9FJ3MM86zYcl0J+WCW8T/CxZu2KevDRljB1GCoFuAb+Mpjsu
	 FB4yGGN95j9v0Gw4BED+6tO7lVTp1Z2Kba18dXKg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Zhang <markzhang@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 351/462] IB/mlx5: Set and get correct qp_num for a DCT QP
Date: Tue, 11 Mar 2025 16:00:17 +0100
Message-ID: <20250311145812.224631920@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
References: <20250311145758.343076290@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index e0db91d1e7492..a00dde2f3fd39 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4219,6 +4219,8 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 		set_id = mlx5_ib_get_counters_id(dev, attr->port_num - 1);
 		MLX5_SET(dctc, dctc, counter_set_id, set_id);
+
+		qp->port = attr->port_num;
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_RTR) {
 		struct mlx5_ib_modify_qp_resp resp = {};
 		u32 out[MLX5_ST_SZ_DW(create_dct_out)] = {};
@@ -4714,7 +4716,7 @@ static int mlx5_ib_dct_query_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *mqp,
 	}
 
 	if (qp_attr_mask & IB_QP_PORT)
-		qp_attr->port_num = MLX5_GET(dctc, dctc, port);
+		qp_attr->port_num = mqp->port;
 	if (qp_attr_mask & IB_QP_MIN_RNR_TIMER)
 		qp_attr->min_rnr_timer = MLX5_GET(dctc, dctc, min_rnr_nak);
 	if (qp_attr_mask & IB_QP_AV) {
-- 
2.39.5




