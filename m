Return-Path: <stable+bounces-715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E847F7C3D
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0122C1C2115E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126243A8C2;
	Fri, 24 Nov 2023 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XjgsSfIb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4539FF8;
	Fri, 24 Nov 2023 18:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4910DC433C8;
	Fri, 24 Nov 2023 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849593;
	bh=BQT5AJQJxfKrHKyauCOEgLf/DVIuah64y/bitbfHsjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XjgsSfIbHK0PYlPvbAa+W12sOuh5ubHnmUfFyBlB35Rl3p/cZITqLQ/mJla/luQLw
	 yhkDoG9usvSWHotAk3miVDJfgtLRB5soE7/VI5K25806ejOT2Iprqiya2wgt1fMUqv
	 qTrgKiAfNrFjgyQ/a0D4kBI7o5L4sLW1FFRl9ICU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gavin Li <gavinl@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 219/530] net/mlx5e: fix double free of encap_header in update funcs
Date: Fri, 24 Nov 2023 17:46:25 +0000
Message-ID: <20231124172034.727208936@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

From: Gavin Li <gavinl@nvidia.com>

[ Upstream commit 3a4aa3cb83563df942be49d145ee3b7ddf17d6bb ]

Follow up to the previous patch to fix the same issue for
mlx5e_tc_tun_update_header_ipv4{6} when mlx5_packet_reformat_alloc()
fails.

When mlx5_packet_reformat_alloc() fails, the encap_header allocated in
mlx5e_tc_tun_update_header_ipv4{6} will be released within it. However,
e->encap_header is already set to the previously freed encap_header
before mlx5_packet_reformat_alloc(). As a result, the later
mlx5e_encap_put() will free e->encap_header again, causing a double free
issue.

mlx5e_encap_put()
     --> mlx5e_encap_dealloc()
         --> kfree(e->encap_header)

This patch fix it by not setting e->encap_header until
mlx5_packet_reformat_alloc() success.

Fixes: a54e20b4fcae ("net/mlx5e: Add basic TC tunnel set action for SRIOV offloads")
Signed-off-by: Gavin Li <gavinl@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Link: https://lore.kernel.org/r/20231114215846.5902-7-saeed@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/mellanox/mlx5/core/en/tc_tun.c   | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index 8bca696b6658c..668da5c70e63d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -403,16 +403,12 @@ int mlx5e_tc_tun_update_header_ipv4(struct mlx5e_priv *priv,
 	if (err)
 		goto free_encap;
 
-	e->encap_size = ipv4_encap_size;
-	kfree(e->encap_header);
-	e->encap_header = encap_header;
-
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
 		/* the encap entry will be made valid on neigh update event
 		 * and not used before that.
 		 */
-		goto release_neigh;
+		goto free_encap;
 	}
 
 	memset(&reformat_params, 0, sizeof(reformat_params));
@@ -426,6 +422,10 @@ int mlx5e_tc_tun_update_header_ipv4(struct mlx5e_priv *priv,
 		goto free_encap;
 	}
 
+	e->encap_size = ipv4_encap_size;
+	kfree(e->encap_header);
+	e->encap_header = encap_header;
+
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
 	mlx5e_route_lookup_ipv4_put(&attr);
@@ -669,16 +669,12 @@ int mlx5e_tc_tun_update_header_ipv6(struct mlx5e_priv *priv,
 	if (err)
 		goto free_encap;
 
-	e->encap_size = ipv6_encap_size;
-	kfree(e->encap_header);
-	e->encap_header = encap_header;
-
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
 		/* the encap entry will be made valid on neigh update event
 		 * and not used before that.
 		 */
-		goto release_neigh;
+		goto free_encap;
 	}
 
 	memset(&reformat_params, 0, sizeof(reformat_params));
@@ -692,6 +688,10 @@ int mlx5e_tc_tun_update_header_ipv6(struct mlx5e_priv *priv,
 		goto free_encap;
 	}
 
+	e->encap_size = ipv6_encap_size;
+	kfree(e->encap_header);
+	e->encap_header = encap_header;
+
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
 	mlx5e_route_lookup_ipv6_put(&attr);
-- 
2.42.0




