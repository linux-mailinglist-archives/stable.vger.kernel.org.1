Return-Path: <stable+bounces-90839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CDC9BEB47
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938D41C215E4
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FA51F707F;
	Wed,  6 Nov 2024 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xiuEwbad"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9F21F7079;
	Wed,  6 Nov 2024 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896965; cv=none; b=D+QWBMPqb7kDwu3G1zKRxgux6sgD0E2USdQLk4571KF9LTTmUwvyf02fcDmuAhRdoqmIu6q+/n//oYoJI4+qjO5dWBlyxq0UM4j0mUECKDl2h3dad1hZMAgn7/jsyncE4xkYFdEjzNMeISQChCqaSV0QhoVfdvYNwIYLFbFktc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896965; c=relaxed/simple;
	bh=8qZL4rDnxblA+lpiaoy2JAfeq+XJplfOMMHHeblh54Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTuUeyn0gmuT9rzyww3yCwAU90/uVuimjHuxQtskVGVjvMHp9qk41WmjCHENGBEkG/18v3yPjH4d6PwBCWDu2n8ZD9kx8S2Q0R4mxHFBUbVNd1B3VMVOW3IlFPVBQPqlk+eXK9l2VKqM+ggxsJ5kZWu+9hpB8ORDzuXc7FL6mi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xiuEwbad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25987C4CED3;
	Wed,  6 Nov 2024 12:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730896965;
	bh=8qZL4rDnxblA+lpiaoy2JAfeq+XJplfOMMHHeblh54Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xiuEwbadf81mm/r0lfbDSFRdvJitXAGHy8815Ohso3HdcnC1P7uMQ5M+jaczXZ7r5
	 Bktjslv0KYn3iCEpNZfcCtETRCspkAG0Xs19LaaOxqw3RAQJYVeTIX0lNuqFPHD5Ej
	 pNstGqdZN0LrlDQyQOECI5dUIcpgD3LeGPnqJCsI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jianbo Liu <jianbol@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Chris Mi <cmi@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 021/126] macsec: Fix use-after-free while sending the offloading packet
Date: Wed,  6 Nov 2024 13:03:42 +0100
Message-ID: <20241106120306.669367267@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120306.038154857@linuxfoundation.org>
References: <20241106120306.038154857@linuxfoundation.org>
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

From: Jianbo Liu <jianbol@nvidia.com>

[ Upstream commit f1e54d11b210b53d418ff1476c6b58a2f434dfc0 ]

KASAN reports the following UAF. The metadata_dst, which is used to
store the SCI value for macsec offload, is already freed by
metadata_dst_free() in macsec_free_netdev(), while driver still use it
for sending the packet.

To fix this issue, dst_release() is used instead to release
metadata_dst. So it is not freed instantly in macsec_free_netdev() if
still referenced by skb.

 BUG: KASAN: slab-use-after-free in mlx5e_xmit+0x1e8f/0x4190 [mlx5_core]
 Read of size 2 at addr ffff88813e42e038 by task kworker/7:2/714
 [...]
 Workqueue: mld mld_ifc_work
 Call Trace:
  <TASK>
  dump_stack_lvl+0x51/0x60
  print_report+0xc1/0x600
  kasan_report+0xab/0xe0
  mlx5e_xmit+0x1e8f/0x4190 [mlx5_core]
  dev_hard_start_xmit+0x120/0x530
  sch_direct_xmit+0x149/0x11e0
  __qdisc_run+0x3ad/0x1730
  __dev_queue_xmit+0x1196/0x2ed0
  vlan_dev_hard_start_xmit+0x32e/0x510 [8021q]
  dev_hard_start_xmit+0x120/0x530
  __dev_queue_xmit+0x14a7/0x2ed0
  macsec_start_xmit+0x13e9/0x2340
  dev_hard_start_xmit+0x120/0x530
  __dev_queue_xmit+0x14a7/0x2ed0
  ip6_finish_output2+0x923/0x1a70
  ip6_finish_output+0x2d7/0x970
  ip6_output+0x1ce/0x3a0
  NF_HOOK.constprop.0+0x15f/0x190
  mld_sendpack+0x59a/0xbd0
  mld_ifc_work+0x48a/0xa80
  process_one_work+0x5aa/0xe50
  worker_thread+0x79c/0x1290
  kthread+0x28f/0x350
  ret_from_fork+0x2d/0x70
  ret_from_fork_asm+0x11/0x20
  </TASK>

 Allocated by task 3922:
  kasan_save_stack+0x20/0x40
  kasan_save_track+0x10/0x30
  __kasan_kmalloc+0x77/0x90
  __kmalloc_noprof+0x188/0x400
  metadata_dst_alloc+0x1f/0x4e0
  macsec_newlink+0x914/0x1410
  __rtnl_newlink+0xe08/0x15b0
  rtnl_newlink+0x5f/0x90
  rtnetlink_rcv_msg+0x667/0xa80
  netlink_rcv_skb+0x12c/0x360
  netlink_unicast+0x551/0x770
  netlink_sendmsg+0x72d/0xbd0
  __sock_sendmsg+0xc5/0x190
  ____sys_sendmsg+0x52e/0x6a0
  ___sys_sendmsg+0xeb/0x170
  __sys_sendmsg+0xb5/0x140
  do_syscall_64+0x4c/0x100
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

 Freed by task 4011:
  kasan_save_stack+0x20/0x40
  kasan_save_track+0x10/0x30
  kasan_save_free_info+0x37/0x50
  poison_slab_object+0x10c/0x190
  __kasan_slab_free+0x11/0x30
  kfree+0xe0/0x290
  macsec_free_netdev+0x3f/0x140
  netdev_run_todo+0x450/0xc70
  rtnetlink_rcv_msg+0x66f/0xa80
  netlink_rcv_skb+0x12c/0x360
  netlink_unicast+0x551/0x770
  netlink_sendmsg+0x72d/0xbd0
  __sock_sendmsg+0xc5/0x190
  ____sys_sendmsg+0x52e/0x6a0
  ___sys_sendmsg+0xeb/0x170
  __sys_sendmsg+0xb5/0x140
  do_syscall_64+0x4c/0x100
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: 0a28bfd4971f ("net/macsec: Add MACsec skb_metadata_dst Tx Data path support")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Chris Mi <cmi@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/20241021100309.234125-1-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macsec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 3a19d6f0e0dd8..c007e262daf7d 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3726,8 +3726,7 @@ static void macsec_free_netdev(struct net_device *dev)
 {
 	struct macsec_dev *macsec = macsec_priv(dev);
 
-	if (macsec->secy.tx_sc.md_dst)
-		metadata_dst_free(macsec->secy.tx_sc.md_dst);
+	dst_release(&macsec->secy.tx_sc.md_dst->dst);
 	free_percpu(macsec->stats);
 	free_percpu(macsec->secy.tx_sc.stats);
 
-- 
2.43.0




