Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9157E713ECE
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjE1TjE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjE1TjD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:39:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383A7A8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98F1961E8E
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F6BC433EF;
        Sun, 28 May 2023 19:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302741;
        bh=bJa+UHuade9NO11kwo7A0zB+9PT/Hg5v/yFsvl1j1SY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SzLboQBHfTsK78+XW9X9kpDJG7lrgCNX+Et8sL7JaENXpRsRlmCWsAUFeBXvQQAKp
         SYGaywB0kS5t9ytEU8IZL0gIUZxE3atbQ4HgJ7QvaLWI0gnscMTSsSCOqhmIlz05s4
         rGeGXrwb52E585um0PALiXEbE25jhZFw8ATDuVe0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shay Drory <shayd@nvidia.com>,
        Roi Dayan <roid@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 6.1 108/119] net/mlx5: Handle pairing of E-switch via uplink un/load APIs
Date:   Sun, 28 May 2023 20:11:48 +0100
Message-Id: <20230528190839.073166659@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shay Drory <shayd@nvidia.com>

commit 2be5bd42a5bba1a05daedc86cf0e248210009669 upstream.

In case user switch a device from switchdev mode to legacy mode, mlx5
first unpair the E-switch and afterwards unload the uplink vport.
>From the other hand, in case user remove or reload a device, mlx5
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c            |    4 +++-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h          |    4 ++++
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c |    7 ++-----
 3 files changed, 9 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -5143,6 +5143,8 @@ int mlx5e_tc_esw_init(struct mlx5_rep_up
 		goto err_register_fib_notifier;
 	}
 
+	mlx5_esw_offloads_devcom_init(esw);
+
 	return 0;
 
 err_register_fib_notifier:
@@ -5169,7 +5171,7 @@ void mlx5e_tc_esw_cleanup(struct mlx5_re
 	priv = netdev_priv(rpriv->netdev);
 	esw = priv->mdev->priv.eswitch;
 
-	mlx5e_tc_clean_fdb_peer_flows(esw);
+	mlx5_esw_offloads_devcom_cleanup(esw);
 
 	mlx5e_tc_tun_cleanup(uplink_priv->encap);
 
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -368,6 +368,8 @@ int mlx5_eswitch_enable(struct mlx5_eswi
 void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf);
 void mlx5_eswitch_disable_locked(struct mlx5_eswitch *esw);
 void mlx5_eswitch_disable(struct mlx5_eswitch *esw);
+void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw);
+void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw);
 int mlx5_eswitch_set_vport_mac(struct mlx5_eswitch *esw,
 			       u16 vport, const u8 *mac);
 int mlx5_eswitch_set_vport_state(struct mlx5_eswitch *esw,
@@ -757,6 +759,8 @@ static inline void mlx5_eswitch_cleanup(
 static inline int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs) { return 0; }
 static inline void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf) {}
 static inline void mlx5_eswitch_disable(struct mlx5_eswitch *esw) {}
+static inline void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw) {}
+static inline void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw) {}
 static inline bool mlx5_eswitch_is_funcs_handler(struct mlx5_core_dev *dev) { return false; }
 static inline
 int mlx5_eswitch_set_vport_state(struct mlx5_eswitch *esw, u16 vport, int link_state) { return 0; }
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2864,7 +2864,7 @@ err_out:
 	return err;
 }
 
-static void esw_offloads_devcom_init(struct mlx5_eswitch *esw)
+void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw)
 {
 	struct mlx5_devcom *devcom = esw->dev->priv.devcom;
 
@@ -2887,7 +2887,7 @@ static void esw_offloads_devcom_init(str
 			       ESW_OFFLOADS_DEVCOM_PAIR, esw);
 }
 
-static void esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw)
+void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw)
 {
 	struct mlx5_devcom *devcom = esw->dev->priv.devcom;
 
@@ -3357,8 +3357,6 @@ int esw_offloads_enable(struct mlx5_eswi
 	if (err)
 		goto err_vports;
 
-	esw_offloads_devcom_init(esw);
-
 	return 0;
 
 err_vports:
@@ -3399,7 +3397,6 @@ static int esw_offloads_stop(struct mlx5
 
 void esw_offloads_disable(struct mlx5_eswitch *esw)
 {
-	esw_offloads_devcom_cleanup(esw);
 	mlx5_eswitch_disable_pf_vf_vports(esw);
 	esw_offloads_unload_rep(esw, MLX5_VPORT_UPLINK);
 	esw_set_passing_vport_metadata(esw, false);


