Return-Path: <stable+bounces-229458-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEx8DvlywWlkTQQAu9opvQ
	(envelope-from <stable+bounces-229458-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:06:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BAA2F96F3
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAB8F32DBE58
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FDE3B5302;
	Mon, 23 Mar 2026 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rrHs6JDD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C373B8BCD;
	Mon, 23 Mar 2026 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279297; cv=none; b=E1SDi8cmW6DHiYe0kM25zH878YQSDygRs8mzOjmDvgY3jvOF9o1TUyoysyUx0eALSHPzJ6XVaVwxfWqrzwVDlk0sVEey7DMMPQYuz7LMpkOU1Pg/Ov5FOKr651g5K+DlCnVgKDEYpe/Ks0hcXGjyC/89sWcCTmlAOAsYsmUvPUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279297; c=relaxed/simple;
	bh=dynd7tAva9rO0XM106hlDsAMTYbfy8twMT41qXd7Vv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATqywGENLaMbFW0j442ViDD12Bb9nUQvzex4KLGzFxbbyRQcTzbhp4bEHNxi5n3SXFlibkVXegGAIaYJACkkwjwd4xHCf4TzfbwyMbFzJUSyuNKfSLUkViD5XpFGebKUCpiQe7VP56G2dZFY0RgIuwBEoplmaNG2OmOxAB9PI/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rrHs6JDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3133C4CEF7;
	Mon, 23 Mar 2026 15:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279297;
	bh=dynd7tAva9rO0XM106hlDsAMTYbfy8twMT41qXd7Vv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rrHs6JDDinF1AvZNdo7pA4q2MhkSqYXOmLlba8YoCl/29RhKcarZ0mIaLTGAb9LJz
	 0dfcavmxsyzNODURHa4iqBFM8GKrpWhc15tU90Enqplvvfo3bJKA9580vnSk7vbeGx
	 +ve293/PT7z7O9OL/eGKYFq4QgXYTwe81+xHQsko=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 538/567] net/mlx5: qos: Restrict RTNL area to avoid a lock cycle
Date: Mon, 23 Mar 2026 14:47:38 +0100
Message-ID: <20260323134547.314013235@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229458-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A1BAA2F96F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cosmin Ratiu <cratiu@nvidia.com>

[ Upstream commit b7e3a5d9c0d66b7fb44f63aef3bd734821afa0c8 ]

A lock dependency cycle exists where:
1. mlx5_ib_roce_init -> mlx5_core_uplink_netdev_event_replay ->
mlx5_blocking_notifier_call_chain (takes notifier_rwsem) ->
mlx5e_mdev_notifier_event -> mlx5_netdev_notifier_register ->
register_netdevice_notifier_dev_net (takes rtnl)
=> notifier_rwsem -> rtnl

2. mlx5e_probe -> _mlx5e_probe ->
mlx5_core_uplink_netdev_set (takes uplink_netdev_lock) ->
mlx5_blocking_notifier_call_chain (takes notifier_rwsem)
=> uplink_netdev_lock -> notifier_rwsem

3: devlink_nl_rate_set_doit -> devlink_nl_rate_set ->
mlx5_esw_devlink_rate_leaf_tx_max_set -> esw_qos_devlink_rate_to_mbps ->
mlx5_esw_qos_max_link_speed_get (takes rtnl) ->
mlx5_esw_qos_lag_link_speed_get_locked ->
mlx5_uplink_netdev_get (takes uplink_netdev_lock)
=> rtnl -> uplink_netdev_lock
=> BOOM! (lock cycle)

Fix that by restricting the rtnl-protected section to just the necessary
part, the call to netdev_master_upper_dev_get and speed querying, so
that the last lock dependency is avoided and the cycle doesn't close.
This is safe because mlx5_uplink_netdev_get uses netdev_hold to keep the
uplink netdev alive while its master device is queried.

Use this opportunity to rename the ambiguously-named "hold_rtnl_lock"
argument to "take_rtnl" and remove the "_locked" suffix from
mlx5_esw_qos_lag_link_speed_get_locked.

Fixes: 6b4be64fd9fe ("net/mlx5e: Harden uplink netdev access against device unbind")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20260316094603.6999-2-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 23 ++++++++-----------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 05fbd2098b268..71df503f40d6d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -713,24 +713,24 @@ int mlx5_esw_qos_set_vport_rate(struct mlx5_eswitch *esw, struct mlx5_vport *vpo
 	return err;
 }
 
-static u32 mlx5_esw_qos_lag_link_speed_get_locked(struct mlx5_core_dev *mdev)
+static u32 mlx5_esw_qos_lag_link_speed_get(struct mlx5_core_dev *mdev,
+					   bool take_rtnl)
 {
 	struct ethtool_link_ksettings lksettings;
 	struct net_device *slave, *master;
 	u32 speed = SPEED_UNKNOWN;
 
-	/* Lock ensures a stable reference to master and slave netdevice
-	 * while port speed of master is queried.
-	 */
-	ASSERT_RTNL();
-
 	slave = mlx5_uplink_netdev_get(mdev);
 	if (!slave)
 		goto out;
 
+	if (take_rtnl)
+		rtnl_lock();
 	master = netdev_master_upper_dev_get(slave);
 	if (master && !__ethtool_get_link_ksettings(master, &lksettings))
 		speed = lksettings.base.speed;
+	if (take_rtnl)
+		rtnl_unlock();
 
 out:
 	mlx5_uplink_netdev_put(mdev, slave);
@@ -738,20 +738,15 @@ static u32 mlx5_esw_qos_lag_link_speed_get_locked(struct mlx5_core_dev *mdev)
 }
 
 static int mlx5_esw_qos_max_link_speed_get(struct mlx5_core_dev *mdev, u32 *link_speed_max,
-					   bool hold_rtnl_lock, struct netlink_ext_ack *extack)
+					   bool take_rtnl,
+					   struct netlink_ext_ack *extack)
 {
 	int err;
 
 	if (!mlx5_lag_is_active(mdev))
 		goto skip_lag;
 
-	if (hold_rtnl_lock)
-		rtnl_lock();
-
-	*link_speed_max = mlx5_esw_qos_lag_link_speed_get_locked(mdev);
-
-	if (hold_rtnl_lock)
-		rtnl_unlock();
+	*link_speed_max = mlx5_esw_qos_lag_link_speed_get(mdev, take_rtnl);
 
 	if (*link_speed_max != (u32)SPEED_UNKNOWN)
 		return 0;
-- 
2.51.0




