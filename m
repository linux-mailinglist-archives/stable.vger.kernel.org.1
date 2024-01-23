Return-Path: <stable+bounces-15471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D185283856D
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF98B25824
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7980B1EEEA;
	Tue, 23 Jan 2024 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D+uCnG10"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376A61FB4;
	Tue, 23 Jan 2024 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975809; cv=none; b=OHnHsKyDUCUjIcIw4QsONz2nQ5x9WyzmuNFAlcD3RCc6vxPOF3XiO8T/oCPKQhnY2GBxOBm1fyp5LgtriCElQm0AkH6WT8wDGe+Vkk+8/uVS3PEGPculVqZx7u+VpnKw6b49JCOwTg4++6AT5eOFRz06wvvXfFO4Y4XV3PZNm6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975809; c=relaxed/simple;
	bh=yVYCv0ziVSxgmf1wD1KSHvZ4AXsTxtrh6TiKc7gmHr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b23NZqldOBYhLj5SHIDHKlNYWa8nUp7yYJ36hApmVxtRDrcwjRAEO6ggY0WRJxWFAN5VrWuSDmOxxX17Gkm1inBudVAhBzIlQbSq0Mu3tjyQZhK+UbuYEiTaRxQE+maDLmEasZXr3oInWdpRKXfJ3ZPvR7drCZ2oYECwij8mCMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D+uCnG10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1639C433F1;
	Tue, 23 Jan 2024 02:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975809;
	bh=yVYCv0ziVSxgmf1wD1KSHvZ4AXsTxtrh6TiKc7gmHr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D+uCnG10HPbIX80TQtgZAyL/zu/TkqWhpVRSSE+O/FifkyFJujg81JBEDc6K23X4f
	 s0/oHTkDB4omHX+1Ul32i+jKb1gl1sYUeR3M1+fcyolFxZt/8rFEWc6aRL2ekd4vlt
	 O3e1BZl4QMPFHSoj71vzYM++Hvy6yC8O/HSlN8xo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maksym Yaremchuk <maksymy@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 578/583] mlxsw: spectrum_router: Register netdevice notifier before nexthop
Date: Mon, 22 Jan 2024 16:00:29 -0800
Message-ID: <20240122235829.897980289@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

From: Petr Machata <petrm@nvidia.com>

[ Upstream commit 62bef63646c194e0f82b40304a0f2d060b28687b ]

If there are IPIP nexthops at the time when the driver is loaded (or the
devlink instance reloaded), the driver looks up the corresponding IPIP
entry. But IPIP entries are only created as a result of netdevice
notifications. Since the netdevice notifier is registered after the nexthop
notifier, mlxsw_sp_nexthop_type_init() never finds the IPIP entry,
registers the nexthop MLXSW_SP_NEXTHOP_TYPE_ETH, and fails to assign a CRIF
to the nexthop. Later on when the CRIF is necessary, the WARN_ON in
mlxsw_sp_nexthop_rif() triggers, causing the splat [1].

In order to fix the issue, reorder the netdevice notifier to be registered
before the nexthop one.

[1] (edited for clarity):

    WARNING: CPU: 1 PID: 1364 at drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3245 mlxsw_sp_nexthop_rif (drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3246 (discriminator 1)) mlxsw_spectrum
    Hardware name: Mellanox Technologies Ltd. MSN4410/VMOD0010, BIOS 5.11 01/06/2019
    Call Trace:
    ? mlxsw_sp_nexthop_rif (drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3246 (discriminator 1)) mlxsw_spectrum
    __mlxsw_sp_nexthop_eth_update (drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3637) mlxsw_spectrum
    mlxsw_sp_nexthop_update (drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3679 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3727) mlxsw_spectrum
    mlxsw_sp_nexthop_group_update (drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3757) mlxsw_spectrum
    mlxsw_sp_nexthop_group_refresh (drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:4112) mlxsw_spectrum
    mlxsw_sp_nexthop_obj_event (drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:5118 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:5191 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:5315 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:5500) mlxsw_spectrum
    nexthops_dump (net/ipv4/nexthop.c:217 net/ipv4/nexthop.c:440 net/ipv4/nexthop.c:3609)
    register_nexthop_notifier (net/ipv4/nexthop.c:3624)
    mlxsw_sp_router_init (drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:11486) mlxsw_spectrum
    mlxsw_sp_init (drivers/net/ethernet/mellanox/mlxsw/spectrum.c:3267) mlxsw_spectrum
    __mlxsw_core_bus_device_register (drivers/net/ethernet/mellanox/mlxsw/core.c:2202) mlxsw_core
    mlxsw_devlink_core_bus_device_reload_up (drivers/net/ethernet/mellanox/mlxsw/core.c:2265 drivers/net/ethernet/mellanox/mlxsw/core.c:1603) mlxsw_core
    devlink_reload (net/devlink/dev.c:314 net/devlink/dev.c:475)
    [...]

Fixes: 9464a3d68ea9 ("mlxsw: spectrum_router: Track next hops at CRIFs")
Reported-by: Maksym Yaremchuk <maksymy@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/74edb8d45d004e8d8f5318eede6ccc3d786d8ba9.1705502064.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index debd2c466f11..ae2fb9efbc50 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -11458,6 +11458,13 @@ int mlxsw_sp_router_init(struct mlxsw_sp *mlxsw_sp,
 	if (err)
 		goto err_register_netevent_notifier;
 
+	mlxsw_sp->router->netdevice_nb.notifier_call =
+		mlxsw_sp_router_netdevice_event;
+	err = register_netdevice_notifier_net(mlxsw_sp_net(mlxsw_sp),
+					      &mlxsw_sp->router->netdevice_nb);
+	if (err)
+		goto err_register_netdev_notifier;
+
 	mlxsw_sp->router->nexthop_nb.notifier_call =
 		mlxsw_sp_nexthop_obj_event;
 	err = register_nexthop_notifier(mlxsw_sp_net(mlxsw_sp),
@@ -11473,22 +11480,15 @@ int mlxsw_sp_router_init(struct mlxsw_sp *mlxsw_sp,
 	if (err)
 		goto err_register_fib_notifier;
 
-	mlxsw_sp->router->netdevice_nb.notifier_call =
-		mlxsw_sp_router_netdevice_event;
-	err = register_netdevice_notifier_net(mlxsw_sp_net(mlxsw_sp),
-					      &mlxsw_sp->router->netdevice_nb);
-	if (err)
-		goto err_register_netdev_notifier;
-
 	return 0;
 
-err_register_netdev_notifier:
-	unregister_fib_notifier(mlxsw_sp_net(mlxsw_sp),
-				&mlxsw_sp->router->fib_nb);
 err_register_fib_notifier:
 	unregister_nexthop_notifier(mlxsw_sp_net(mlxsw_sp),
 				    &mlxsw_sp->router->nexthop_nb);
 err_register_nexthop_notifier:
+	unregister_netdevice_notifier_net(mlxsw_sp_net(mlxsw_sp),
+					  &router->netdevice_nb);
+err_register_netdev_notifier:
 	unregister_netevent_notifier(&mlxsw_sp->router->netevent_nb);
 err_register_netevent_notifier:
 	unregister_inet6addr_validator_notifier(&router->inet6addr_valid_nb);
@@ -11536,11 +11536,11 @@ void mlxsw_sp_router_fini(struct mlxsw_sp *mlxsw_sp)
 {
 	struct mlxsw_sp_router *router = mlxsw_sp->router;
 
-	unregister_netdevice_notifier_net(mlxsw_sp_net(mlxsw_sp),
-					  &router->netdevice_nb);
 	unregister_fib_notifier(mlxsw_sp_net(mlxsw_sp), &router->fib_nb);
 	unregister_nexthop_notifier(mlxsw_sp_net(mlxsw_sp),
 				    &router->nexthop_nb);
+	unregister_netdevice_notifier_net(mlxsw_sp_net(mlxsw_sp),
+					  &router->netdevice_nb);
 	unregister_netevent_notifier(&router->netevent_nb);
 	unregister_inet6addr_validator_notifier(&router->inet6addr_valid_nb);
 	unregister_inetaddr_validator_notifier(&router->inetaddr_valid_nb);
-- 
2.43.0




