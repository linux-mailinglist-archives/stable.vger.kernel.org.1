Return-Path: <stable+bounces-150442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F78BACB663
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 657D57A6DCD
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5DD226D0A;
	Mon,  2 Jun 2025 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H8zzTL1J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B900221F1E;
	Mon,  2 Jun 2025 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877136; cv=none; b=ZptSIrCvXdaLqOJcQ+L9LUWLFly6EdyfcQxTVNiF+7Z6k+fZpKr86rI4U64ianvuSc8M+7CHvjGelYtp6TZZRCbK56FYQnGdYtO1nfLlH1OI6FsY6Od0281ZDUxVMubxIuEplNzUSnOqNjUMecgEPH/TU2s8n8m3e+HJQBfaWys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877136; c=relaxed/simple;
	bh=UjdVVXcX7Xdmh0Yr2nojjgUlYLjIu2VIsr/eQb6cdRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eATfZRG978H2wCRsKqK0qMiwR+WC0mhYJv8Vxk01OCXxR445TnE+RLSC7RlI+Wsy65onbIE9ebk+Ch6Dgf7YmVA/m0YqH2ZTvv1rRGDOmAYvvldxA5dLL08Frn9imn2Nx8HhnL+WGHNlzh+AwurbRpcbeaP4kRsTapR7eK0DOD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H8zzTL1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFA7C4CEEB;
	Mon,  2 Jun 2025 15:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748877136;
	bh=UjdVVXcX7Xdmh0Yr2nojjgUlYLjIu2VIsr/eQb6cdRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H8zzTL1JZ+8XHa+wxL5+Av19IyAQq+qrWqVkiXhEp/Duqy7ZazIIsJZ7MFfd/EbUd
	 SSnp617ZtGWxP+CCqF8YbfLo9Tda0JpcpPyDv4fqvUiPynlkv2QgCkTL39wSmlXJKg
	 h6abYjcSDT07N5/tS94zsQ3mWoTP+Ur5476NDyEA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	William Tu <witu@nvidia.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 184/325] net/mlx5e: set the tx_queue_len for pfifo_fast
Date: Mon,  2 Jun 2025 15:47:40 +0200
Message-ID: <20250602134327.285610949@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: William Tu <witu@nvidia.com>

[ Upstream commit a38cc5706fb9f7dc4ee3a443f61de13ce1e410ed ]

By default, the mq netdev creates a pfifo_fast qdisc. On a
system with 16 core, the pfifo_fast with 3 bands consumes
16 * 3 * 8 (size of pointer) * 1024 (default tx queue len)
= 393KB. The patch sets the tx qlen to representor default
value, 128 (1<<MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE), which
consumes 16 * 3 * 8 * 128 = 49KB, saving 344KB for each
representor at ECPF.

Signed-off-by: William Tu <witu@nvidia.com>
Reviewed-by: Daniel Jurgens <danielj@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Link: https://patch.msgid.link/20250209101716.112774-9-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 5aeca9534f15a..837524d1d2258 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -726,6 +726,8 @@ static void mlx5e_build_rep_netdev(struct net_device *netdev,
 	netdev->ethtool_ops = &mlx5e_rep_ethtool_ops;
 
 	netdev->watchdog_timeo    = 15 * HZ;
+	if (mlx5_core_is_ecpf(mdev))
+		netdev->tx_queue_len = 1 << MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE;
 
 #if IS_ENABLED(CONFIG_MLX5_CLS_ACT)
 	netdev->hw_features    |= NETIF_F_HW_TC;
-- 
2.39.5




