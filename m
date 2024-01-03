Return-Path: <stable+bounces-9493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE648232A3
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63B4EB233FC
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B8B1C294;
	Wed,  3 Jan 2024 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bbDRK3Qf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224F21C292;
	Wed,  3 Jan 2024 17:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C06AC433C7;
	Wed,  3 Jan 2024 17:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301772;
	bh=zkQZq91K7PDQ2FBVHIhPRQG4x6iCYvLgYLemB/pWHWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bbDRK3QfP4P2eLzkL0NKiSaZwEFJROiCzPZrfdGGNRGmbPMBBFUSc5EGnxo66MWvy
	 TLCU6WYgQxz4diSvFkpKfSfuPOIc3l45QVZYR1O+MQvicBrVA4jAUhrIaWMpuJtSuw
	 +xsqzq5aMe3+kAuuPciX/78V8e+74m8lle4UCLI8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vlad Buslov <vladbu@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 07/75] Revert "net/mlx5e: fix double free of encap_header"
Date: Wed,  3 Jan 2024 17:54:48 +0100
Message-ID: <20240103164844.060005711@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164842.953224409@linuxfoundation.org>
References: <20240103164842.953224409@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlad Buslov <vladbu@nvidia.com>

[ Upstream commit 5d089684dc434a31e08d32f0530066d0025c52e4 ]

This reverts commit 6f9b1a0731662648949a1c0587f6acb3b7f8acf1.

This patch is causing a null ptr issue, the proper fix is in the next
patch.

Fixes: 6f9b1a073166 ("net/mlx5e: fix double free of encap_header")
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index 05bcd69994eca..90930e54b6f28 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -267,6 +267,9 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
 	if (err)
 		goto destroy_neigh_entry;
 
+	e->encap_size = ipv4_encap_size;
+	e->encap_header = encap_header;
+
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(n, NULL);
 		/* the encap entry will be made valid on neigh update event
@@ -283,8 +286,6 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
 		goto destroy_neigh_entry;
 	}
 
-	e->encap_size = ipv4_encap_size;
-	e->encap_header = encap_header;
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(out_dev));
 	mlx5e_route_lookup_ipv4_put(route_dev, n);
@@ -430,6 +431,9 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 	if (err)
 		goto destroy_neigh_entry;
 
+	e->encap_size = ipv6_encap_size;
+	e->encap_header = encap_header;
+
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(n, NULL);
 		/* the encap entry will be made valid on neigh update event
@@ -447,8 +451,6 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 		goto destroy_neigh_entry;
 	}
 
-	e->encap_size = ipv6_encap_size;
-	e->encap_header = encap_header;
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(out_dev));
 	mlx5e_route_lookup_ipv6_put(route_dev, n);
-- 
2.43.0




