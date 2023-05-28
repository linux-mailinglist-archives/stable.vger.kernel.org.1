Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC8C713AC2
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 18:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjE1Qvg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 12:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjE1Qvg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 12:51:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669B4AD
        for <stable@vger.kernel.org>; Sun, 28 May 2023 09:51:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFCCA617BB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 16:51:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A035C433EF;
        Sun, 28 May 2023 16:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685292693;
        bh=sc2VnFNqUNS2xaHC39IVukXE2oUWh4TJOg/+yP9ZiiY=;
        h=Subject:To:Cc:From:Date:From;
        b=PKFd7Pj8C55whdep3u+OdnesmocZyn1xq+vTgzcOakBU1KVH7AlqPD3VSJlGKXUqN
         vE4BPq1dOJCImRWIHxhkyp80VAvyFFPEXXyvuW/UParCGMfc/ET/nrHimyNwqUECUu
         2CLXTOCcFvFxLhVPc1+uMSh3/Q7VGKt88Ext53TY=
Subject: FAILED: patch "[PATCH] net/mlx5: Handle pairing of E-switch via uplink un/load APIs" failed to apply to 5.10-stable tree
To:     shayd@nvidia.com, roid@nvidia.com, saeedm@nvidia.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 17:51:28 +0100
Message-ID: <2023052828-hatchet-drier-8e0e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2be5bd42a5bba1a05daedc86cf0e248210009669
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052828-hatchet-drier-8e0e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

2be5bd42a5bb ("net/mlx5: Handle pairing of E-switch via uplink un/load APIs")
c9668f0b1d28 ("net/mlx5e: Fix cleanup null-ptr deref on encap lock")
d13674b1d14c ("net/mlx5e: TC, map tc action cookie to a hw counter")
0e414518d6d8 ("net/mlx5e: Add hairpin debugfs files")
1a8034720f38 ("net/mlx5e: Add hairpin params structure")
8facc02f22f1 ("net/mlx5e: TC, reuse flow attribute post parser processing")
f2bb566f5c97 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2be5bd42a5bba1a05daedc86cf0e248210009669 Mon Sep 17 00:00:00 2001
From: Shay Drory <shayd@nvidia.com>
Date: Mon, 20 Mar 2023 13:07:53 +0200
Subject: [PATCH] net/mlx5: Handle pairing of E-switch via uplink un/load APIs

In case user switch a device from switchdev mode to legacy mode, mlx5
first unpair the E-switch and afterwards unload the uplink vport.
From the other hand, in case user remove or reload a device, mlx5
first unload the uplink vport and afterwards unpair the E-switch.

The latter is causing a bug[1], hence, handle pairing of E-switch as
part of uplink un/load APIs.

[1]
In case VF_LAG is used, every tc fdb flow is duplicated to the peer
esw. However, the original esw keeps a pointer to this duplicated
flow, not the peer esw.
e.g.: if user create tc fdb flow over esw0, the flow is duplicated
over esw1, in FW/HW, but in SW, esw0 keeps a pointer to the duplicated
flow.
During module unload while a peer tc fdb flow is still offloaded, in
case the first device to be removed is the peer device (esw1 in the
example above), the peer net-dev is destroyed, and so the mlx5e_priv
is memset to 0.
Afterwards, the peer device is trying to unpair himself from the
original device (esw0 in the example above). Unpair API invoke the
original device to clear peer flow from its eswitch (esw0), but the
peer flow, which is stored over the original eswitch (esw0), is
trying to use the peer mlx5e_priv, which is memset to 0 and result in
bellow kernel-oops.

[  157.964081 ] BUG: unable to handle page fault for address: 000000000002ce60
[  157.964662 ] #PF: supervisor read access in kernel mode
[  157.965123 ] #PF: error_code(0x0000) - not-present page
[  157.965582 ] PGD 0 P4D 0
[  157.965866 ] Oops: 0000 [#1] SMP
[  157.967670 ] RIP: 0010:mlx5e_tc_del_fdb_flow+0x48/0x460 [mlx5_core]
[  157.976164 ] Call Trace:
[  157.976437 ]  <TASK>
[  157.976690 ]  __mlx5e_tc_del_fdb_peer_flow+0xe6/0x100 [mlx5_core]
[  157.977230 ]  mlx5e_tc_clean_fdb_peer_flows+0x67/0x90 [mlx5_core]
[  157.977767 ]  mlx5_esw_offloads_unpair+0x2d/0x1e0 [mlx5_core]
[  157.984653 ]  mlx5_esw_offloads_devcom_event+0xbf/0x130 [mlx5_core]
[  157.985212 ]  mlx5_devcom_send_event+0xa3/0xb0 [mlx5_core]
[  157.985714 ]  esw_offloads_disable+0x5a/0x110 [mlx5_core]
[  157.986209 ]  mlx5_eswitch_disable_locked+0x152/0x170 [mlx5_core]
[  157.986757 ]  mlx5_eswitch_disable+0x51/0x80 [mlx5_core]
[  157.987248 ]  mlx5_unload+0x2a/0xb0 [mlx5_core]
[  157.987678 ]  mlx5_uninit_one+0x5f/0xd0 [mlx5_core]
[  157.988127 ]  remove_one+0x64/0xe0 [mlx5_core]
[  157.988549 ]  pci_device_remove+0x31/0xa0
[  157.988933 ]  device_release_driver_internal+0x18f/0x1f0
[  157.989402 ]  driver_detach+0x3f/0x80
[  157.989754 ]  bus_remove_driver+0x70/0xf0
[  157.990129 ]  pci_unregister_driver+0x34/0x90
[  157.990537 ]  mlx5_cleanup+0xc/0x1c [mlx5_core]
[  157.990972 ]  __x64_sys_delete_module+0x15a/0x250
[  157.991398 ]  ? exit_to_user_mode_prepare+0xea/0x110
[  157.991840 ]  do_syscall_64+0x3d/0x90
[  157.992198 ]  entry_SYSCALL_64_after_hwframe+0x46/0xb0

Fixes: 04de7dda7394 ("net/mlx5e: Infrastructure for duplicated offloading of TC flows")
Fixes: 1418ddd96afd ("net/mlx5e: Duplicate offloaded TC eswitch rules under uplink LAG")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 728b82ce4031..65fe40f55d84 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -5301,6 +5301,8 @@ int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
 		goto err_action_counter;
 	}
 
+	mlx5_esw_offloads_devcom_init(esw);
+
 	return 0;
 
 err_action_counter:
@@ -5329,7 +5331,7 @@ void mlx5e_tc_esw_cleanup(struct mlx5_rep_uplink_priv *uplink_priv)
 	priv = netdev_priv(rpriv->netdev);
 	esw = priv->mdev->priv.eswitch;
 
-	mlx5e_tc_clean_fdb_peer_flows(esw);
+	mlx5_esw_offloads_devcom_cleanup(esw);
 
 	mlx5e_tc_tun_cleanup(uplink_priv->encap);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 1a042c981713..9f007c5438ee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -369,6 +369,8 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs);
 void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf);
 void mlx5_eswitch_disable_locked(struct mlx5_eswitch *esw);
 void mlx5_eswitch_disable(struct mlx5_eswitch *esw);
+void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw);
+void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw);
 int mlx5_eswitch_set_vport_mac(struct mlx5_eswitch *esw,
 			       u16 vport, const u8 *mac);
 int mlx5_eswitch_set_vport_state(struct mlx5_eswitch *esw,
@@ -767,6 +769,8 @@ static inline void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw) {}
 static inline int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs) { return 0; }
 static inline void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf) {}
 static inline void mlx5_eswitch_disable(struct mlx5_eswitch *esw) {}
+static inline void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw) {}
+static inline void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw) {}
 static inline bool mlx5_eswitch_is_funcs_handler(struct mlx5_core_dev *dev) { return false; }
 static inline
 int mlx5_eswitch_set_vport_state(struct mlx5_eswitch *esw, u16 vport, int link_state) { return 0; }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 69215ffb9999..7c34c7cf506f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2779,7 +2779,7 @@ static int mlx5_esw_offloads_devcom_event(int event,
 	return err;
 }
 
-static void esw_offloads_devcom_init(struct mlx5_eswitch *esw)
+void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw)
 {
 	struct mlx5_devcom *devcom = esw->dev->priv.devcom;
 
@@ -2802,7 +2802,7 @@ static void esw_offloads_devcom_init(struct mlx5_eswitch *esw)
 			       ESW_OFFLOADS_DEVCOM_PAIR, esw);
 }
 
-static void esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw)
+void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw)
 {
 	struct mlx5_devcom *devcom = esw->dev->priv.devcom;
 
@@ -3250,8 +3250,6 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	if (err)
 		goto err_vports;
 
-	esw_offloads_devcom_init(esw);
-
 	return 0;
 
 err_vports:
@@ -3292,7 +3290,6 @@ static int esw_offloads_stop(struct mlx5_eswitch *esw,
 
 void esw_offloads_disable(struct mlx5_eswitch *esw)
 {
-	esw_offloads_devcom_cleanup(esw);
 	mlx5_eswitch_disable_pf_vf_vports(esw);
 	esw_offloads_unload_rep(esw, MLX5_VPORT_UPLINK);
 	esw_set_passing_vport_metadata(esw, false);

