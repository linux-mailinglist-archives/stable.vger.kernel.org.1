Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA8177A1CE
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 20:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjHLSeu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 14:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHLSet (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 14:34:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7BE10C0
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 11:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C51361E12
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 18:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372DCC433C7;
        Sat, 12 Aug 2023 18:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691865291;
        bh=KWFdPRMKjvirZcNqleeYwNzFd5RS0de+vEqiMKm0F/U=;
        h=Subject:To:Cc:From:Date:From;
        b=he7JGzDJ7cJBYufdKQYU14PLgFdAX7fkIcqXQmen1IMTnHtAZoivM2BKV7hLPHq14
         nnIDNRFpNqrxN2WH7P+ShfdYhUQARUvLZXxEiudx9ZDrz8OzmJtRuhbZynyOXH5SAa
         VDg/ARYRitkZd32r7szlXHLB0lakyrBnR2BcojEQ=
Subject: FAILED: patch "[PATCH] net/mlx5e: TC, Fix internal port memory leak" failed to apply to 6.1-stable tree
To:     jianbol@nvidia.com, saeedm@nvidia.com, vladbu@nvidia.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 20:34:49 +0200
Message-ID: <2023081248-landowner-faceless-db5a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ac5da544a3c2047cbfd715acd9cec8380d7fe5c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081248-landowner-faceless-db5a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

ac5da544a3c2 ("net/mlx5e: TC, Fix internal port memory leak")
08fe94ec5f77 ("net/mlx5e: TC, Remove special handling of CT action")
a830ec485e83 ("net/mlx5e: TC, Move main flow attribute cleanup to helper func")
7195d9a0c8df ("net/mlx5e: TC, Remove unused vf_tun variable")
6702782845a5 ("net/mlx5e: TC, Set CT miss to the specific ct action instance")
235ff07da7ec ("net/mlx5e: Rename CHAIN_TO_REG to MAPPED_OBJ_TO_REG")
93a1ab2c545b ("net/mlx5: Refactor tc miss handling to a single function")
03a283cdc8c8 ("net/mlx5: Kconfig: Make tc offload depend on tc skb extension")
2b68d659a704 ("net/mlx5e: TC, support per action stats")
d13674b1d14c ("net/mlx5e: TC, map tc action cookie to a hw counter")
e9d1061d8727 ("net/mlx5e: TC, add hw counter to branching actions")
ef78b8d5d6f1 ("net/mlx5e: TC, Use common function allocating flow mod hdr or encap mod hdr")
c43182e6db32 ("net/mlx5e: TC, Add tc prefix to attach/detach hdr functions")
82b564802661 ("net/mlx5e: TC, Pass flow attr to attach/detach mod hdr functions")
a99da46ac01a ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ac5da544a3c2047cbfd715acd9cec8380d7fe5c6 Mon Sep 17 00:00:00 2001
From: Jianbo Liu <jianbol@nvidia.com>
Date: Fri, 14 Apr 2023 08:48:20 +0000
Subject: [PATCH] net/mlx5e: TC, Fix internal port memory leak

The flow rule can be splited, and the extra post_act rules are added
to post_act table. It's possible to trigger memleak when the rule
forwards packets from internal port and over tunnel, in the case that,
for example, CT 'new' state offload is allowed. As int_port object is
assigned to the flow attribute of post_act rule, and its refcnt is
incremented by mlx5e_tc_int_port_get(), but mlx5e_tc_int_port_put() is
not called, the refcnt is never decremented, then int_port is never
freed.

The kmemleak reports the following error:
unreferenced object 0xffff888128204b80 (size 64):
  comm "handler20", pid 50121, jiffies 4296973009 (age 642.932s)
  hex dump (first 32 bytes):
    01 00 00 00 19 00 00 00 03 f0 00 00 04 00 00 00  ................
    98 77 67 41 81 88 ff ff 98 77 67 41 81 88 ff ff  .wgA.....wgA....
  backtrace:
    [<00000000e992680d>] kmalloc_trace+0x27/0x120
    [<000000009e945a98>] mlx5e_tc_int_port_get+0x3f3/0xe20 [mlx5_core]
    [<0000000035a537f0>] mlx5e_tc_add_fdb_flow+0x473/0xcf0 [mlx5_core]
    [<0000000070c2cec6>] __mlx5e_add_fdb_flow+0x7cf/0xe90 [mlx5_core]
    [<000000005cc84048>] mlx5e_configure_flower+0xd40/0x4c40 [mlx5_core]
    [<000000004f8a2031>] mlx5e_rep_indr_offload.isra.0+0x10e/0x1c0 [mlx5_core]
    [<000000007df797dc>] mlx5e_rep_indr_setup_tc_cb+0x90/0x130 [mlx5_core]
    [<0000000016c15cc3>] tc_setup_cb_add+0x1cf/0x410
    [<00000000a63305b4>] fl_hw_replace_filter+0x38f/0x670 [cls_flower]
    [<000000008bc9e77c>] fl_change+0x1fd5/0x4430 [cls_flower]
    [<00000000e7f766e4>] tc_new_tfilter+0x867/0x2010
    [<00000000e101c0ef>] rtnetlink_rcv_msg+0x6fc/0x9f0
    [<00000000e1111d44>] netlink_rcv_skb+0x12c/0x360
    [<0000000082dd6c8b>] netlink_unicast+0x438/0x710
    [<00000000fc568f70>] netlink_sendmsg+0x794/0xc50
    [<0000000016e92590>] sock_sendmsg+0xc5/0x190

So fix this by moving int_port cleanup code to the flow attribute
free helper, which is used by all the attribute free cases.

Fixes: 8300f225268b ("net/mlx5e: Create new flow attr for multi table actions")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 92377632f9e0..31708d5aa608 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1943,9 +1943,7 @@ static void mlx5e_tc_del_fdb_flow(struct mlx5e_priv *priv,
 {
 	struct mlx5_eswitch *esw = priv->mdev->priv.eswitch;
 	struct mlx5_flow_attr *attr = flow->attr;
-	struct mlx5_esw_flow_attr *esw_attr;
 
-	esw_attr = attr->esw_attr;
 	mlx5e_put_flow_tunnel_id(flow);
 
 	remove_unready_flow(flow);
@@ -1966,12 +1964,6 @@ static void mlx5e_tc_del_fdb_flow(struct mlx5e_priv *priv,
 
 	mlx5_tc_ct_match_del(get_ct_priv(priv), &flow->attr->ct_attr);
 
-	if (esw_attr->int_port)
-		mlx5e_tc_int_port_put(mlx5e_get_int_port_priv(priv), esw_attr->int_port);
-
-	if (esw_attr->dest_int_port)
-		mlx5e_tc_int_port_put(mlx5e_get_int_port_priv(priv), esw_attr->dest_int_port);
-
 	if (flow_flag_test(flow, L3_TO_L2_DECAP))
 		mlx5e_detach_decap(priv, flow);
 
@@ -4268,6 +4260,7 @@ static void
 mlx5_free_flow_attr_actions(struct mlx5e_tc_flow *flow, struct mlx5_flow_attr *attr)
 {
 	struct mlx5_core_dev *counter_dev = get_flow_counter_dev(flow);
+	struct mlx5_esw_flow_attr *esw_attr;
 
 	if (!attr)
 		return;
@@ -4285,6 +4278,18 @@ mlx5_free_flow_attr_actions(struct mlx5e_tc_flow *flow, struct mlx5_flow_attr *a
 		mlx5e_tc_detach_mod_hdr(flow->priv, flow, attr);
 	}
 
+	if (mlx5e_is_eswitch_flow(flow)) {
+		esw_attr = attr->esw_attr;
+
+		if (esw_attr->int_port)
+			mlx5e_tc_int_port_put(mlx5e_get_int_port_priv(flow->priv),
+					      esw_attr->int_port);
+
+		if (esw_attr->dest_int_port)
+			mlx5e_tc_int_port_put(mlx5e_get_int_port_priv(flow->priv),
+					      esw_attr->dest_int_port);
+	}
+
 	mlx5_tc_ct_delete_flow(get_ct_priv(flow->priv), attr);
 
 	free_branch_attr(flow, attr->branch_true);

