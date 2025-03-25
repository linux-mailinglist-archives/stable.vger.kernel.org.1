Return-Path: <stable+bounces-126015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CDEA6F41F
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC041891A6E
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8CD255E47;
	Tue, 25 Mar 2025 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxytEmUx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02B11F0E31
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902411; cv=none; b=uEs8vGdE0y4vahkekNM5wPQh55+4BWxzMNlCuINxvm886PZbPe26L4Wg3TE82gZwSWnPC5c/jK+kOoBbSUTEf1oR5N4XUv6behAZLWngorEf6pElkLWVMruX5jcbMMooYVVE+q6gTvoDUtejLrNw7+kbt6lmIeL792v/yh++wHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902411; c=relaxed/simple;
	bh=D94TP3tgXUOrYZwnV2HtdDPltU1maTeFugIwDePttR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9e99eSR5D5cx5yWJOYmkrvy7npBiWzbMLIfrE7Kotw4rVboQgBaGWOyH840z8el45fZhFhFKGGV0pp/hnwA77egZx69G4mSwWkdM9ssWjdimrd42sQ1FaKBG0fhQo1TbS1Cva4EitrnM28zxJQbae7xWBwNk6cHkJBCoKFEtL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxytEmUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606CAC4CEE4;
	Tue, 25 Mar 2025 11:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902410;
	bh=D94TP3tgXUOrYZwnV2HtdDPltU1maTeFugIwDePttR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IxytEmUxSz7tmhCtTXNKzu5alXEOX52P/dza5jrNX9HyMlRx8jN6JZCQKkT8pvdas
	 qhmVoW/n1gtKky4yVUnxm3mmAeHlXrokKdx4C5LY43hBUnZhXzXnwd8ZA45V7DFP33
	 zDUwCokQKn6+HNgzf1IEngJAkbmJyFMLjCw62W6d0m0kkWB+SFyGBKHafKQccQblDW
	 yiXOYfjIIWqcLYRdGg9FrrdDPQ2eet5GDBwhLOzKcxJkVqJT6NCMdQNtGFA+KXrZaF
	 sB7MdemHeANb7NXp6L0jAL2yPyJK+4Li0FNkrcgah0edGu8x24F03McQEugfm9wBYy
	 BiW83rD1crorA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 1/1] net/mlx5e: Fix use-after-free of encap entry in neigh update handler
Date: Tue, 25 Mar 2025 07:33:29 -0400
Message-Id: <20250324201907-924af0de427421fc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324092933.1008166-2-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: fb1a3132ee1ac968316e45d21a48703a6db0b6c3

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: Vlad Buslov<vladbu@nvidia.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  fb1a3132ee1ac ! 1:  3bc3763a234af net/mlx5e: Fix use-after-free of encap entry in neigh update handler
    @@ Metadata
      ## Commit message ##
         net/mlx5e: Fix use-after-free of encap entry in neigh update handler
     
    +    [ Upstream commit fb1a3132ee1ac968316e45d21a48703a6db0b6c3 ]
    +
         Function mlx5e_rep_neigh_update() wasn't updated to accommodate rtnl lock
         removal from TC filter update path and properly handle concurrent encap
         entry insertion/deletion which can lead to following use-after-free:
    @@ Commit message
         Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
         Reviewed-by: Roi Dayan <roid@nvidia.com>
         Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
    +    [ since kernel 5.10 doesn't have commit 0d9f96471493
    +    ("net/mlx5e: Extract tc tunnel encap/decap code to dedicated file")
    +    which moved encap/decap from en_tc.c to tc_tun_encap.c, so backport and
    +    move the additional functions to en_tc.c instead of tc_tun_encap.c ]
    +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c ##
     @@ drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c: static void mlx5e_rep_neigh_update(struct work_struct *work)
      							     work);
      	struct mlx5e_neigh_hash_entry *nhe = update_work->nhe;
      	struct neighbour *n = update_work->n;
    -+	struct mlx5e_encap_entry *e = NULL;
    - 	bool neigh_connected, same_dev;
     -	struct mlx5e_encap_entry *e;
    ++	struct mlx5e_encap_entry *e = NULL;
      	unsigned char ha[ETH_ALEN];
     -	struct mlx5e_priv *priv;
    + 	bool neigh_connected;
      	u8 nud_state, dead;
      
    - 	rtnl_lock();
     @@ drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c: static void mlx5e_rep_neigh_update(struct work_struct *work)
    - 	if (!same_dev)
    - 		goto out;
    + 
    + 	trace_mlx5e_rep_neigh_update(nhe, ha, neigh_connected);
      
     -	list_for_each_entry(e, &nhe->encap_list, encap_list) {
     -		if (!mlx5e_encap_take(e))
    @@ drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c: static void mlx5e_rep_ne
     -		mlx5e_rep_update_flows(priv, e, neigh_connected, ha);
     -		mlx5e_encap_put(priv, e);
     -	}
    - out:
      	rtnl_unlock();
      	mlx5e_release_neigh_update_work(update_work);
    + }
     
      ## drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c ##
     @@ drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c: void mlx5e_rep_update_flows(struct mlx5e_priv *priv,
    @@ drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c: void mlx5e_rep_update_flows
      
      	mlx5e_take_all_encap_flows(e, &flow_list);
     
    - ## drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c ##
    -@@ drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c: static void mlx5e_take_all_route_decap_flows(struct mlx5e_route_entry *r,
    - 		mlx5e_take_tmp_flow(flow, flow_list, 0);
    + ## drivers/net/ethernet/mellanox/mlx5/core/en_tc.c ##
    +@@ drivers/net/ethernet/mellanox/mlx5/core/en_tc.c: void mlx5e_put_encap_flow_list(struct mlx5e_priv *priv, struct list_head *flow_l
    + 		mlx5e_flow_put(priv, flow);
      }
      
     +typedef bool (match_cb)(struct mlx5e_encap_entry *);
    @@ drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c: static void mlx5e_tak
     -mlx5e_get_next_valid_encap(struct mlx5e_neigh_hash_entry *nhe,
     -			   struct mlx5e_encap_entry *e)
     +mlx5e_get_next_matching_encap(struct mlx5e_neigh_hash_entry *nhe,
    -+			      struct mlx5e_encap_entry *e,
    -+			      match_cb match)
    ++			   struct mlx5e_encap_entry *e,
    ++			   match_cb match)
      {
      	struct mlx5e_encap_entry *next = NULL;
      
    -@@ drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c: mlx5e_get_next_valid_encap(struct mlx5e_neigh_hash_entry *nhe,
    +@@ drivers/net/ethernet/mellanox/mlx5/core/en_tc.c: mlx5e_get_next_valid_encap(struct mlx5e_neigh_hash_entry *nhe,
      	/* wait for encap to be fully initialized */
      	wait_for_completion(&next->res_ready);
      	/* continue searching if encap entry is not in valid state after completion */
    @@ drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c: mlx5e_get_next_valid_
      		e = next;
      		goto retry;
      	}
    -@@ drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c: mlx5e_get_next_valid_encap(struct mlx5e_neigh_hash_entry *nhe,
    +@@ drivers/net/ethernet/mellanox/mlx5/core/en_tc.c: mlx5e_get_next_valid_encap(struct mlx5e_neigh_hash_entry *nhe,
      	return next;
      }
      
    @@ drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c: mlx5e_get_next_valid_
     
      ## drivers/net/ethernet/mellanox/mlx5/core/en_tc.h ##
     @@ drivers/net/ethernet/mellanox/mlx5/core/en_tc.h: void mlx5e_take_all_encap_flows(struct mlx5e_encap_entry *e, struct list_head *f
    - void mlx5e_put_flow_list(struct mlx5e_priv *priv, struct list_head *flow_list);
    + void mlx5e_put_encap_flow_list(struct mlx5e_priv *priv, struct list_head *flow_list);
      
      struct mlx5e_neigh_hash_entry;
     +struct mlx5e_encap_entry *
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

