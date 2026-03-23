Return-Path: <stable+bounces-228886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BraHW5qwWnVSwQAu9opvQ
	(envelope-from <stable+bounces-228886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:29:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D44B42F828D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 227CE331312B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637A03AEF4F;
	Mon, 23 Mar 2026 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f9eRef30"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8923B612;
	Mon, 23 Mar 2026 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277400; cv=none; b=GlpV+5dyPagMxKr1HcXXqx87q9MBUUyua8VB/fE7rKF8vZDdw3C3n2UtlT7FGViX3RGsEIlEmWfeYr+DrHB6vNHJ/28RWMzmNKDwVhnLn37kON37u64g0FBoX8C1Krn35csQzpZmqpfI2qeMLQJibskJDFL+0HD2OBixnHYuPcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277400; c=relaxed/simple;
	bh=7zQBKOllL+fn/JwSuYVYHrToygThvCt1t4Ed7PZqyZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtNlhYaIvbB+jaNcd0yy+WCP2xtHLzquxopN0uQ4fEZb/xTh4ZOrVWx+qEAy8Dpg6r7WwwV9HmOUCUrQcpXMci9sf+ZVgMFOM4OXEf7FfyEtSmR6llMfo6/puX6eeqpc3R2/m9lpzL+5F+SFLoJLOzRIRH5/gEf+qIspc3w5/7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f9eRef30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8A9C4CEF7;
	Mon, 23 Mar 2026 14:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277400;
	bh=7zQBKOllL+fn/JwSuYVYHrToygThvCt1t4Ed7PZqyZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9eRef30Zm3QjZXRQXot0vgWO8FIQxE/1At/fpCa1KWknGvEVIAMXK67ERmW6W2nf
	 SW+Iunme1gWjgi8umMN/CdkLrah4jHyS0h+24iJl6efB12/gk0vcnH7ev1c15btT3e
	 fy6dngtRFNPO00UAqqygeJoxo3PLIB87LhZkLEMs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 423/460] net/mlx5: qos: Restrict RTNL area to avoid a lock cycle
Date: Mon, 23 Mar 2026 14:46:59 +0100
Message-ID: <20260323134536.951307932@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228886-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: D44B42F828D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index d8c304427e2ab..8c2e1d881a1a2 100644
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




