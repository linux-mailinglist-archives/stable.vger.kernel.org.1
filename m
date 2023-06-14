Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3544F726B04
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjFGUVy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjFGUVp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:21:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800E426AE
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:21:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD6A0643C6
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30FCC433D2;
        Wed,  7 Jun 2023 20:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169287;
        bh=qJPvvcsODxvbUerKFC0YMyRQDNuDY2sM4i3q6ac9O9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FyKm4hkORGDESO1rjYAwbcMiXDFnnfa0tWfhMt5HDguCpHtnbB68wbrUm64hV/ipa
         hCjCYK3S0Op6YPsYTvHv8LgPzl+S7ANHRpiLhiiHG8LIA1AUiR3awmoxSdPjEPVrCq
         zS61V8s8bg0qzdJamAod8ligwM41CgWGMqU0VIgk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chris Mi <cmi@nvidia.com>,
        Roi Dayan <roid@nvidia.com>, Vlad Buslov <vladbu@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 023/286] net/mlx5e: Prevent encap offload when neigh update is running
Date:   Wed,  7 Jun 2023 22:12:02 +0200
Message-ID: <20230607200923.772443770@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chris Mi <cmi@nvidia.com>

[ Upstream commit 37c3b9fa7ccf5caad6d87ba4d42bf00be46be1cf ]

The cited commit adds a compeletion to remove dependency on rtnl
lock. But it causes a deadlock for multiple encapsulations:

 crash> bt ffff8aece8a64000
 PID: 1514557  TASK: ffff8aece8a64000  CPU: 3    COMMAND: "tc"
  #0 [ffffa6d14183f368] __schedule at ffffffffb8ba7f45
  #1 [ffffa6d14183f3f8] schedule at ffffffffb8ba8418
  #2 [ffffa6d14183f418] schedule_preempt_disabled at ffffffffb8ba8898
  #3 [ffffa6d14183f428] __mutex_lock at ffffffffb8baa7f8
  #4 [ffffa6d14183f4d0] mutex_lock_nested at ffffffffb8baabeb
  #5 [ffffa6d14183f4e0] mlx5e_attach_encap at ffffffffc0f48c17 [mlx5_core]
  #6 [ffffa6d14183f628] mlx5e_tc_add_fdb_flow at ffffffffc0f39680 [mlx5_core]
  #7 [ffffa6d14183f688] __mlx5e_add_fdb_flow at ffffffffc0f3b636 [mlx5_core]
  #8 [ffffa6d14183f6f0] mlx5e_tc_add_flow at ffffffffc0f3bcdf [mlx5_core]
  #9 [ffffa6d14183f728] mlx5e_configure_flower at ffffffffc0f3c1d1 [mlx5_core]
 #10 [ffffa6d14183f790] mlx5e_rep_setup_tc_cls_flower at ffffffffc0f3d529 [mlx5_core]
 #11 [ffffa6d14183f7a0] mlx5e_rep_setup_tc_cb at ffffffffc0f3d714 [mlx5_core]
 #12 [ffffa6d14183f7b0] tc_setup_cb_add at ffffffffb8931bb8
 #13 [ffffa6d14183f810] fl_hw_replace_filter at ffffffffc0dae901 [cls_flower]
 #14 [ffffa6d14183f8d8] fl_change at ffffffffc0db5c57 [cls_flower]
 #15 [ffffa6d14183f970] tc_new_tfilter at ffffffffb8936047
 #16 [ffffa6d14183fac8] rtnetlink_rcv_msg at ffffffffb88c7c31
 #17 [ffffa6d14183fb50] netlink_rcv_skb at ffffffffb8942853
 #18 [ffffa6d14183fbc0] rtnetlink_rcv at ffffffffb88c1835
 #19 [ffffa6d14183fbd0] netlink_unicast at ffffffffb8941f27
 #20 [ffffa6d14183fc18] netlink_sendmsg at ffffffffb8942245
 #21 [ffffa6d14183fc98] sock_sendmsg at ffffffffb887d482
 #22 [ffffa6d14183fcb8] ____sys_sendmsg at ffffffffb887d81a
 #23 [ffffa6d14183fd38] ___sys_sendmsg at ffffffffb88806e2
 #24 [ffffa6d14183fe90] __sys_sendmsg at ffffffffb88807a2
 #25 [ffffa6d14183ff28] __x64_sys_sendmsg at ffffffffb888080f
 #26 [ffffa6d14183ff38] do_syscall_64 at ffffffffb8b9b6a8
 #27 [ffffa6d14183ff50] entry_SYSCALL_64_after_hwframe at ffffffffb8c0007c
 crash> bt 0xffff8aeb07544000
 PID: 1110766  TASK: ffff8aeb07544000  CPU: 0    COMMAND: "kworker/u20:9"
  #0 [ffffa6d14e6b7bd8] __schedule at ffffffffb8ba7f45
  #1 [ffffa6d14e6b7c68] schedule at ffffffffb8ba8418
  #2 [ffffa6d14e6b7c88] schedule_timeout at ffffffffb8baef88
  #3 [ffffa6d14e6b7d10] wait_for_completion at ffffffffb8ba968b
  #4 [ffffa6d14e6b7d60] mlx5e_take_all_encap_flows at ffffffffc0f47ec4 [mlx5_core]
  #5 [ffffa6d14e6b7da0] mlx5e_rep_update_flows at ffffffffc0f3e734 [mlx5_core]
  #6 [ffffa6d14e6b7df8] mlx5e_rep_neigh_update at ffffffffc0f400bb [mlx5_core]
  #7 [ffffa6d14e6b7e50] process_one_work at ffffffffb80acc9c
  #8 [ffffa6d14e6b7ed0] worker_thread at ffffffffb80ad012
  #9 [ffffa6d14e6b7f10] kthread at ffffffffb80b615d
 #10 [ffffa6d14e6b7f50] ret_from_fork at ffffffffb8001b2f

After the first encap is attached, flow will be added to encap
entry's flows list. If neigh update is running at this time, the
following encaps of the flow can't hold the encap_tbl_lock and
sleep. If neigh update thread is waiting for that flow's init_done,
deadlock happens.

Fix it by holding lock outside of the for loop. If neigh update is
running, prevent encap flows from offloading. Since the lock is held
outside of the for loop, concurrent creation of encap entries is not
allowed. So remove unnecessary wait_for_completion call for res_ready.

Fixes: 95435ad7999b ("net/mlx5e: Only access fully initialized flows in neigh update")
Signed-off-by: Chris Mi <cmi@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlx5/core/en/tc_tun_encap.c      | 37 ++++++++++---------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
index 7655526222570..bbab164eab546 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -492,6 +492,19 @@ void mlx5e_encap_put(struct mlx5e_priv *priv, struct mlx5e_encap_entry *e)
 	mlx5e_encap_dealloc(priv, e);
 }
 
+static void mlx5e_encap_put_locked(struct mlx5e_priv *priv, struct mlx5e_encap_entry *e)
+{
+	struct mlx5_eswitch *esw = priv->mdev->priv.eswitch;
+
+	lockdep_assert_held(&esw->offloads.encap_tbl_lock);
+
+	if (!refcount_dec_and_test(&e->refcnt))
+		return;
+	list_del(&e->route_list);
+	hash_del_rcu(&e->encap_hlist);
+	mlx5e_encap_dealloc(priv, e);
+}
+
 static void mlx5e_decap_put(struct mlx5e_priv *priv, struct mlx5e_decap_entry *d)
 {
 	struct mlx5_eswitch *esw = priv->mdev->priv.eswitch;
@@ -785,6 +798,8 @@ int mlx5e_attach_encap(struct mlx5e_priv *priv,
 	uintptr_t hash_key;
 	int err = 0;
 
+	lockdep_assert_held(&esw->offloads.encap_tbl_lock);
+
 	parse_attr = attr->parse_attr;
 	tun_info = parse_attr->tun_info[out_index];
 	mpls_info = &parse_attr->mpls_info[out_index];
@@ -798,7 +813,6 @@ int mlx5e_attach_encap(struct mlx5e_priv *priv,
 
 	hash_key = hash_encap_info(&key);
 
-	mutex_lock(&esw->offloads.encap_tbl_lock);
 	e = mlx5e_encap_get(priv, &key, hash_key);
 
 	/* must verify if encap is valid or not */
@@ -809,15 +823,6 @@ int mlx5e_attach_encap(struct mlx5e_priv *priv,
 			goto out_err;
 		}
 
-		mutex_unlock(&esw->offloads.encap_tbl_lock);
-		wait_for_completion(&e->res_ready);
-
-		/* Protect against concurrent neigh update. */
-		mutex_lock(&esw->offloads.encap_tbl_lock);
-		if (e->compl_result < 0) {
-			err = -EREMOTEIO;
-			goto out_err;
-		}
 		goto attach_flow;
 	}
 
@@ -846,15 +851,12 @@ int mlx5e_attach_encap(struct mlx5e_priv *priv,
 	INIT_LIST_HEAD(&e->flows);
 	hash_add_rcu(esw->offloads.encap_tbl, &e->encap_hlist, hash_key);
 	tbl_time_before = mlx5e_route_tbl_get_last_update(priv);
-	mutex_unlock(&esw->offloads.encap_tbl_lock);
 
 	if (family == AF_INET)
 		err = mlx5e_tc_tun_create_header_ipv4(priv, mirred_dev, e);
 	else if (family == AF_INET6)
 		err = mlx5e_tc_tun_create_header_ipv6(priv, mirred_dev, e);
 
-	/* Protect against concurrent neigh update. */
-	mutex_lock(&esw->offloads.encap_tbl_lock);
 	complete_all(&e->res_ready);
 	if (err) {
 		e->compl_result = err;
@@ -889,18 +891,15 @@ int mlx5e_attach_encap(struct mlx5e_priv *priv,
 	} else {
 		flow_flag_set(flow, SLOW);
 	}
-	mutex_unlock(&esw->offloads.encap_tbl_lock);
 
 	return err;
 
 out_err:
-	mutex_unlock(&esw->offloads.encap_tbl_lock);
 	if (e)
-		mlx5e_encap_put(priv, e);
+		mlx5e_encap_put_locked(priv, e);
 	return err;
 
 out_err_init:
-	mutex_unlock(&esw->offloads.encap_tbl_lock);
 	kfree(tun_info);
 	kfree(e);
 	return err;
@@ -996,6 +995,7 @@ int mlx5e_tc_tun_encap_dests_set(struct mlx5e_priv *priv,
 	struct net_device *encap_dev = NULL;
 	struct mlx5e_rep_priv *rpriv;
 	struct mlx5e_priv *out_priv;
+	struct mlx5_eswitch *esw;
 	int out_index;
 	int err = 0;
 
@@ -1006,6 +1006,8 @@ int mlx5e_tc_tun_encap_dests_set(struct mlx5e_priv *priv,
 	esw_attr = attr->esw_attr;
 	*vf_tun = false;
 
+	esw = priv->mdev->priv.eswitch;
+	mutex_lock(&esw->offloads.encap_tbl_lock);
 	for (out_index = 0; out_index < MLX5_MAX_FLOW_FWD_VPORTS; out_index++) {
 		struct net_device *out_dev;
 		int mirred_ifindex;
@@ -1044,6 +1046,7 @@ int mlx5e_tc_tun_encap_dests_set(struct mlx5e_priv *priv,
 	}
 
 out:
+	mutex_unlock(&esw->offloads.encap_tbl_lock);
 	return err;
 }
 
-- 
2.39.2



