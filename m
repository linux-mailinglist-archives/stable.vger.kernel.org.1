Return-Path: <stable+bounces-41125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38BF8AFAB1
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6E7FB2C176
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE08B149C7D;
	Tue, 23 Apr 2024 21:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WMxUy1oq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1001420BE;
	Tue, 23 Apr 2024 21:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908694; cv=none; b=Z9Tg6e07LI5q7LLuhMrDPofzBS8kYPYVFEKvzce0UlGL+wcL/k3ZHSpOaAvUdEbDYfyYO2tuO3C/Z4RdDO1hdQu+zHXWlw0vSTnvBA8V5kHjEHa+bMQuKuf5f0U9InjZOzsmKYW4BFMg6g4cS9IERmHUmKzDfNiGugyAVxuuTJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908694; c=relaxed/simple;
	bh=BX2UoKDF1Vsl4Q/wuxuvrPAJNJnujfeh2J6bWGQIvPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuWOBdZQ7jxMpS1dsEfOBWk2u/N7djOaXcfylzmrRoWBbbRad8yK3wQyE4SsKs7QAG6p65zubtuNzzHUE07FuQ+g+wUUavipQU1148lgL0OSh/A41baBo5q+vhfjxHh8DbO6EJ5eOlh7kgko/jW4JV8BOvURFhn4M4Hrh2gpk68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WMxUy1oq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FB4C116B1;
	Tue, 23 Apr 2024 21:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908694;
	bh=BX2UoKDF1Vsl4Q/wuxuvrPAJNJnujfeh2J6bWGQIvPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WMxUy1oqirwAkrCpfZMsTXCRyRltuk1ezJRCPpeYTnZAUn80C4ucKaEeaQxPGIClV
	 3mk0jFIbJC6WrJJWGPCDy+SL8BsYoJ76BSMv8nuW5xMWUhjyjjMpl1DAF56u3ZykZF
	 Eq9dTluUhh/Hl9wJeDAgQTHxKYHGGHks+4mNHNls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Carolina Jubran <cjubran@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 043/141] net/mlx5e: Prevent deadlock while disabling aRFS
Date: Tue, 23 Apr 2024 14:38:31 -0700
Message-ID: <20240423213854.663234071@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
References: <20240423213853.356988651@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Carolina Jubran <cjubran@nvidia.com>

[ Upstream commit fef965764cf562f28afb997b626fc7c3cec99693 ]

When disabling aRFS under the `priv->state_lock`, any scheduled
aRFS works are canceled using the `cancel_work_sync` function,
which waits for the work to end if it has already started.
However, while waiting for the work handler, the handler will
try to acquire the `state_lock` which is already acquired.

The worker acquires the lock to delete the rules if the state
is down, which is not the worker's responsibility since
disabling aRFS deletes the rules.

Add an aRFS state variable, which indicates whether the aRFS is
enabled and prevent adding rules when the aRFS is disabled.

Kernel log:

======================================================
WARNING: possible circular locking dependency detected
6.7.0-rc4_net_next_mlx5_5483eb2 #1 Tainted: G          I
------------------------------------------------------
ethtool/386089 is trying to acquire lock:
ffff88810f21ce68 ((work_completion)(&rule->arfs_work)){+.+.}-{0:0}, at: __flush_work+0x74/0x4e0

but task is already holding lock:
ffff8884a1808cc0 (&priv->state_lock){+.+.}-{3:3}, at: mlx5e_ethtool_set_channels+0x53/0x200 [mlx5_core]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&priv->state_lock){+.+.}-{3:3}:
       __mutex_lock+0x80/0xc90
       arfs_handle_work+0x4b/0x3b0 [mlx5_core]
       process_one_work+0x1dc/0x4a0
       worker_thread+0x1bf/0x3c0
       kthread+0xd7/0x100
       ret_from_fork+0x2d/0x50
       ret_from_fork_asm+0x11/0x20

-> #0 ((work_completion)(&rule->arfs_work)){+.+.}-{0:0}:
       __lock_acquire+0x17b4/0x2c80
       lock_acquire+0xd0/0x2b0
       __flush_work+0x7a/0x4e0
       __cancel_work_timer+0x131/0x1c0
       arfs_del_rules+0x143/0x1e0 [mlx5_core]
       mlx5e_arfs_disable+0x1b/0x30 [mlx5_core]
       mlx5e_ethtool_set_channels+0xcb/0x200 [mlx5_core]
       ethnl_set_channels+0x28f/0x3b0
       ethnl_default_set_doit+0xec/0x240
       genl_family_rcv_msg_doit+0xd0/0x120
       genl_rcv_msg+0x188/0x2c0
       netlink_rcv_skb+0x54/0x100
       genl_rcv+0x24/0x40
       netlink_unicast+0x1a1/0x270
       netlink_sendmsg+0x214/0x460
       __sock_sendmsg+0x38/0x60
       __sys_sendto+0x113/0x170
       __x64_sys_sendto+0x20/0x30
       do_syscall_64+0x40/0xe0
       entry_SYSCALL_64_after_hwframe+0x46/0x4e

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&priv->state_lock);
                               lock((work_completion)(&rule->arfs_work));
                               lock(&priv->state_lock);
  lock((work_completion)(&rule->arfs_work));

 *** DEADLOCK ***

3 locks held by ethtool/386089:
 #0: ffffffff82ea7210 (cb_lock){++++}-{3:3}, at: genl_rcv+0x15/0x40
 #1: ffffffff82e94c88 (rtnl_mutex){+.+.}-{3:3}, at: ethnl_default_set_doit+0xd3/0x240
 #2: ffff8884a1808cc0 (&priv->state_lock){+.+.}-{3:3}, at: mlx5e_ethtool_set_channels+0x53/0x200 [mlx5_core]

stack backtrace:
CPU: 15 PID: 386089 Comm: ethtool Tainted: G          I        6.7.0-rc4_net_next_mlx5_5483eb2 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x60/0xa0
 check_noncircular+0x144/0x160
 __lock_acquire+0x17b4/0x2c80
 lock_acquire+0xd0/0x2b0
 ? __flush_work+0x74/0x4e0
 ? save_trace+0x3e/0x360
 ? __flush_work+0x74/0x4e0
 __flush_work+0x7a/0x4e0
 ? __flush_work+0x74/0x4e0
 ? __lock_acquire+0xa78/0x2c80
 ? lock_acquire+0xd0/0x2b0
 ? mark_held_locks+0x49/0x70
 __cancel_work_timer+0x131/0x1c0
 ? mark_held_locks+0x49/0x70
 arfs_del_rules+0x143/0x1e0 [mlx5_core]
 mlx5e_arfs_disable+0x1b/0x30 [mlx5_core]
 mlx5e_ethtool_set_channels+0xcb/0x200 [mlx5_core]
 ethnl_set_channels+0x28f/0x3b0
 ethnl_default_set_doit+0xec/0x240
 genl_family_rcv_msg_doit+0xd0/0x120
 genl_rcv_msg+0x188/0x2c0
 ? ethnl_ops_begin+0xb0/0xb0
 ? genl_family_rcv_msg_dumpit+0xf0/0xf0
 netlink_rcv_skb+0x54/0x100
 genl_rcv+0x24/0x40
 netlink_unicast+0x1a1/0x270
 netlink_sendmsg+0x214/0x460
 __sock_sendmsg+0x38/0x60
 __sys_sendto+0x113/0x170
 ? do_user_addr_fault+0x53f/0x8f0
 __x64_sys_sendto+0x20/0x30
 do_syscall_64+0x40/0xe0
 entry_SYSCALL_64_after_hwframe+0x46/0x4e
 </TASK>

Fixes: 45bf454ae884 ("net/mlx5e: Enabling aRFS mechanism")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://lore.kernel.org/r/20240411115444.374475-7-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/en_arfs.c | 27 +++++++++++--------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
index 58eacba6de8cd..ad51edf553185 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
@@ -45,6 +45,10 @@ struct arfs_table {
 	struct hlist_head	 rules_hash[ARFS_HASH_SIZE];
 };
 
+enum {
+	MLX5E_ARFS_STATE_ENABLED,
+};
+
 enum arfs_type {
 	ARFS_IPV4_TCP,
 	ARFS_IPV6_TCP,
@@ -60,6 +64,7 @@ struct mlx5e_arfs_tables {
 	struct list_head               rules;
 	int                            last_filter_id;
 	struct workqueue_struct        *wq;
+	unsigned long                  state;
 };
 
 struct arfs_tuple {
@@ -170,6 +175,8 @@ int mlx5e_arfs_enable(struct mlx5e_flow_steering *fs)
 			return err;
 		}
 	}
+	set_bit(MLX5E_ARFS_STATE_ENABLED, &arfs->state);
+
 	return 0;
 }
 
@@ -454,6 +461,8 @@ static void arfs_del_rules(struct mlx5e_flow_steering *fs)
 	int i;
 	int j;
 
+	clear_bit(MLX5E_ARFS_STATE_ENABLED, &arfs->state);
+
 	spin_lock_bh(&arfs->arfs_lock);
 	mlx5e_for_each_arfs_rule(rule, htmp, arfs->arfs_tables, i, j) {
 		hlist_del_init(&rule->hlist);
@@ -621,17 +630,8 @@ static void arfs_handle_work(struct work_struct *work)
 	struct mlx5_flow_handle *rule;
 
 	arfs = mlx5e_fs_get_arfs(priv->fs);
-	mutex_lock(&priv->state_lock);
-	if (!test_bit(MLX5E_STATE_OPENED, &priv->state)) {
-		spin_lock_bh(&arfs->arfs_lock);
-		hlist_del(&arfs_rule->hlist);
-		spin_unlock_bh(&arfs->arfs_lock);
-
-		mutex_unlock(&priv->state_lock);
-		kfree(arfs_rule);
-		goto out;
-	}
-	mutex_unlock(&priv->state_lock);
+	if (!test_bit(MLX5E_ARFS_STATE_ENABLED, &arfs->state))
+		return;
 
 	if (!arfs_rule->rule) {
 		rule = arfs_add_rule(priv, arfs_rule);
@@ -744,6 +744,11 @@ int mlx5e_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 		return -EPROTONOSUPPORT;
 
 	spin_lock_bh(&arfs->arfs_lock);
+	if (!test_bit(MLX5E_ARFS_STATE_ENABLED, &arfs->state)) {
+		spin_unlock_bh(&arfs->arfs_lock);
+		return -EPERM;
+	}
+
 	arfs_rule = arfs_find_rule(arfs_t, &fk);
 	if (arfs_rule) {
 		if (arfs_rule->rxq == rxq_index) {
-- 
2.43.0




