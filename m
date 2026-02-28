Return-Path: <stable+bounces-220575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L8dOURPo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:25:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FC31C854B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 022BF3701DA8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661F03DD74A;
	Sat, 28 Feb 2026 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ll7h0DNE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0CD3DD743;
	Sat, 28 Feb 2026 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300457; cv=none; b=Q/FwJ4yTy5fjtCaBSTcIoppoytPacOwohAFjnmIE20S+66dzoYOgGynf/h0plR/78BjVxGwc3GyEfkvNPEIvwQ5UKchx6aq/t8ik3rD9hEKDkiMI98R9zDk54xC2gYbtkPveu1LoM7fdh232IJlCSIs/JT6Gk+aNG46+GaYpXLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300457; c=relaxed/simple;
	bh=RdkuAf7scFKBUlHx22gyfCGgrI6nOkT0Ss8a3+t2sEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anfwNNqM8/GLDmNRU8bV708AHBc40XX6Lpadg1L01XjUFSx3X3TSOFB9eVtxZ09AvDZHizfkl++zRzuSQVk7C/UzjN+gxpdOmBhKadfofnEnFMfi4d/n9IJb8t6royoaQY0+vZVk6iOPS0az59EEvvMie7ccquMQefp/O+RO9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ll7h0DNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BB5C2BC87;
	Sat, 28 Feb 2026 17:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300457;
	bh=RdkuAf7scFKBUlHx22gyfCGgrI6nOkT0Ss8a3+t2sEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ll7h0DNEAl5dWMlfp0FqPLRjNIU84hpfTOARXgUVbiB/uC5ubc3/5XbI5tVCmy0Q1
	 xbcOpgUIMsoo9xzr+NLneXZGYbhXqK9H/VQ+EtncG0oXmIFqayIp4jUZt0d4zAklve
	 k4UnT0TfwhGXL3enMtHGR8FjVIEOZMhMzZz9dTlpBVwX/pWDg7uet33Cv7E1RMNcmW
	 WFOlvdhIPV/qWig6BmDzYqgaN0JXdv2O+VB+Lg7lCU3HaMk4aE9g2TFagjupMtP6bN
	 ZklkCWLzdU5I+AMels8O0sX/+2wT6ImVZNCV1NqRLc0C66mXRtjCp9y2wvXR+OYlzO
	 riOCz64xZQqcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shay Drory <shayd@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Alex Vesker <valex@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 496/844] net/mlx5: DR, Fix circular locking dependency in dump
Date: Sat, 28 Feb 2026 12:26:49 -0500
Message-ID: <20260228173244.1509663-497-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220575-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 44FC31C854B
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

[ Upstream commit 2700b7e603af39ca55fe9fc876ca123efd44680f ]

Fix a circular locking dependency between dbg_mutex and the domain
rx/tx mutexes that could lead to a deadlock.

The dump path in dr_dump_domain_all() was acquiring locks in the order:
  dbg_mutex -> rx.mutex -> tx.mutex

While the table/matcher creation paths acquire locks in the order:
  rx.mutex -> tx.mutex -> dbg_mutex

This inverted lock ordering creates a circular dependency. Fix this by
changing dr_dump_domain_all() to acquire the domain lock before
dbg_mutex, matching the order used in mlx5dr_table_create() and
mlx5dr_matcher_create().

Lockdep splat:
 ======================================================
 WARNING: possible circular locking dependency detected
 6.19.0-rc6net_next_e817c4e #1 Not tainted
 ------------------------------------------------------
 sos/30721 is trying to acquire lock:
 ffff888102df5900 (&dmn->info.rx.mutex){+.+.}-{4:4}, at:
dr_dump_start+0x131/0x450 [mlx5_core]

 but task is already holding lock:
 ffff888102df5bc0 (&dmn->dump_info.dbg_mutex){+.+.}-{4:4}, at:
dr_dump_start+0x10b/0x450 [mlx5_core]

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #2 (&dmn->dump_info.dbg_mutex){+.+.}-{4:4}:
        __mutex_lock+0x91/0x1060
        mlx5dr_matcher_create+0x377/0x5e0 [mlx5_core]
        mlx5_cmd_dr_create_flow_group+0x62/0xd0 [mlx5_core]
        mlx5_create_flow_group+0x113/0x1c0 [mlx5_core]
        mlx5_chains_create_prio+0x453/0x2290 [mlx5_core]
        mlx5_chains_get_table+0x2e2/0x980 [mlx5_core]
        esw_chains_create+0x1e6/0x3b0 [mlx5_core]
        esw_create_offloads_fdb_tables.cold+0x62/0x63f [mlx5_core]
        esw_offloads_enable+0x76f/0xd20 [mlx5_core]
        mlx5_eswitch_enable_locked+0x35a/0x500 [mlx5_core]
        mlx5_devlink_eswitch_mode_set+0x561/0x950 [mlx5_core]
        devlink_nl_eswitch_set_doit+0x67/0xe0
        genl_family_rcv_msg_doit+0xe0/0x130
        genl_rcv_msg+0x188/0x290
        netlink_rcv_skb+0x4b/0xf0
        genl_rcv+0x24/0x40
        netlink_unicast+0x1ed/0x2c0
        netlink_sendmsg+0x210/0x450
        __sock_sendmsg+0x38/0x60
        __sys_sendto+0x119/0x180
        __x64_sys_sendto+0x20/0x30
        do_syscall_64+0x70/0xd00
        entry_SYSCALL_64_after_hwframe+0x4b/0x53

 -> #1 (&dmn->info.tx.mutex){+.+.}-{4:4}:
        __mutex_lock+0x91/0x1060
        mlx5dr_table_create+0x11d/0x530 [mlx5_core]
        mlx5_cmd_dr_create_flow_table+0x62/0x140 [mlx5_core]
        __mlx5_create_flow_table+0x46f/0x960 [mlx5_core]
        mlx5_create_flow_table+0x16/0x20 [mlx5_core]
        esw_create_offloads_fdb_tables+0x136/0x240 [mlx5_core]
        esw_offloads_enable+0x76f/0xd20 [mlx5_core]
        mlx5_eswitch_enable_locked+0x35a/0x500 [mlx5_core]
        mlx5_devlink_eswitch_mode_set+0x561/0x950 [mlx5_core]
        devlink_nl_eswitch_set_doit+0x67/0xe0
        genl_family_rcv_msg_doit+0xe0/0x130
        genl_rcv_msg+0x188/0x290
        netlink_rcv_skb+0x4b/0xf0
        genl_rcv+0x24/0x40
        netlink_unicast+0x1ed/0x2c0
        netlink_sendmsg+0x210/0x450
        __sock_sendmsg+0x38/0x60
        __sys_sendto+0x119/0x180
        __x64_sys_sendto+0x20/0x30
        do_syscall_64+0x70/0xd00
        entry_SYSCALL_64_after_hwframe+0x4b/0x53

 -> #0 (&dmn->info.rx.mutex){+.+.}-{4:4}:
        __lock_acquire+0x18b6/0x2eb0
        lock_acquire+0xd3/0x2c0
        __mutex_lock+0x91/0x1060
        dr_dump_start+0x131/0x450 [mlx5_core]
        seq_read_iter+0xe3/0x410
        seq_read+0xfb/0x130
        full_proxy_read+0x53/0x80
        vfs_read+0xba/0x330
        ksys_read+0x65/0xe0
        do_syscall_64+0x70/0xd00
        entry_SYSCALL_64_after_hwframe+0x4b/0x53

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&dmn->dump_info.dbg_mutex);
                                lock(&dmn->info.tx.mutex);
                                lock(&dmn->dump_info.dbg_mutex);
   lock(&dmn->info.rx.mutex);

                   *** DEADLOCK ***

Fixes: 9222f0b27da2 ("net/mlx5: DR, Add support for dumping steering info")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Alex Vesker <valex@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260224114652.1787431-2-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_dbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_dbg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_dbg.c
index 030a5776c9374..a4c19af1775f1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_dbg.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_dbg.c
@@ -1050,8 +1050,8 @@ static int dr_dump_domain_all(struct seq_file *file, struct mlx5dr_domain *dmn)
 	struct mlx5dr_table *tbl;
 	int ret;
 
-	mutex_lock(&dmn->dump_info.dbg_mutex);
 	mlx5dr_domain_lock(dmn);
+	mutex_lock(&dmn->dump_info.dbg_mutex);
 
 	ret = dr_dump_domain(file, dmn);
 	if (ret < 0)
@@ -1064,8 +1064,8 @@ static int dr_dump_domain_all(struct seq_file *file, struct mlx5dr_domain *dmn)
 	}
 
 unlock_mutex:
-	mlx5dr_domain_unlock(dmn);
 	mutex_unlock(&dmn->dump_info.dbg_mutex);
+	mlx5dr_domain_unlock(dmn);
 	return ret;
 }
 
-- 
2.51.0


