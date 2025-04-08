Return-Path: <stable+bounces-129752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218B3A800FB
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A91F188EFB2
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEE3268C41;
	Tue,  8 Apr 2025 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TOMkSMMr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F56224234;
	Tue,  8 Apr 2025 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111884; cv=none; b=nbkK0JYdNCGPss5e0jHGHKfXNFZMLP4WYaZvZzovWkwAd8E//x/5GMIq22LJhyU0BYC1+PANd6oe24/1j1P5JigzjL+goEn61TeShpiIohKSLkuve/BrAv0rGpIBM1ig+NpPWf/cclW6P4YWNam+6+4uu/0BqBwbxlPr3sD2J/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111884; c=relaxed/simple;
	bh=RocecJFTnQzhrEc4g/Pp5JZgnjf0rgL2Bgb8PZV2quw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUSN9I4slF5bS6vnTHBRJqAjrwii+i1rXSc9RnVcSQKdWbBXdCzjxtGu3xl6YfL/YyCoxHlFmBKJdvkUQCTzut3t8iaZAdfZCv93Nmyb8WFYvxKjYvmLu2EAkVoBXPflP8cidc7p0eqhSC9HjTWT3LN0Ov99R002UygJOhjsEXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TOMkSMMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC85C4CEE5;
	Tue,  8 Apr 2025 11:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111884;
	bh=RocecJFTnQzhrEc4g/Pp5JZgnjf0rgL2Bgb8PZV2quw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOMkSMMrEWunIcCayhqry75kXJNmDGGbZo5MN+KqfdGe2TDuBhHQJ3hBFVUtcpI80
	 beK2LXm99uiRiF6rIzcpPfuyAMLH1Qz3UEKbVYcsH9tw8e9In0DuNwHiSwPke4T9ch
	 vLpXkutyEXsPwah0bkoKcKZtP42p+FL5KyahyC00=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Zhang <markzhang@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 555/731] rtnetlink: Allocate vfinfo size for VF GUIDs when supported
Date: Tue,  8 Apr 2025 12:47:32 +0200
Message-ID: <20250408104927.186079320@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Zhang <markzhang@nvidia.com>

[ Upstream commit 23f00807619d15063d676218f36c5dfeda1eb420 ]

Commit 30aad41721e0 ("net/core: Add support for getting VF GUIDs")
added support for getting VF port and node GUIDs in netlink ifinfo
messages, but their size was not taken into consideration in the
function that allocates the netlink message, causing the following
warning when a netlink message is filled with many VF port and node
GUIDs:
 # echo 64 > /sys/bus/pci/devices/0000\:08\:00.0/sriov_numvfs
 # ip link show dev ib0
 RTNETLINK answers: Message too long
 Cannot send link get request: Message too long

Kernel warning:

 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 1930 at net/core/rtnetlink.c:4151 rtnl_getlink+0x586/0x5a0
 Modules linked in: xt_conntrack xt_MASQUERADE nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter overlay mlx5_ib macsec mlx5_core tls rpcrdma rdma_ucm ib_uverbs ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_cm iw_cm ib_ipoib fuse ib_cm ib_core
 CPU: 2 UID: 0 PID: 1930 Comm: ip Not tainted 6.14.0-rc2+ #1
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:rtnl_getlink+0x586/0x5a0
 Code: cb 82 e8 3d af 0a 00 4d 85 ff 0f 84 08 ff ff ff 4c 89 ff 41 be ea ff ff ff e8 66 63 5b ff 49 c7 07 80 4f cb 82 e9 36 fc ff ff <0f> 0b e9 16 fe ff ff e8 de a0 56 00 66 66 2e 0f 1f 84 00 00 00 00
 RSP: 0018:ffff888113557348 EFLAGS: 00010246
 RAX: 00000000ffffffa6 RBX: ffff88817e87aa34 RCX: dffffc0000000000
 RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffff88817e87afb8
 RBP: 0000000000000009 R08: ffffffff821f44aa R09: 0000000000000000
 R10: ffff8881260f79a8 R11: ffff88817e87af00 R12: ffff88817e87aa00
 R13: ffffffff8563d300 R14: 00000000ffffffa6 R15: 00000000ffffffff
 FS:  00007f63a5dbf280(0000) GS:ffff88881ee00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f63a5ba4493 CR3: 00000001700fe002 CR4: 0000000000772eb0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? __warn+0xa5/0x230
  ? rtnl_getlink+0x586/0x5a0
  ? report_bug+0x22d/0x240
  ? handle_bug+0x53/0xa0
  ? exc_invalid_op+0x14/0x50
  ? asm_exc_invalid_op+0x16/0x20
  ? skb_trim+0x6a/0x80
  ? rtnl_getlink+0x586/0x5a0
  ? __pfx_rtnl_getlink+0x10/0x10
  ? rtnetlink_rcv_msg+0x1e5/0x860
  ? __pfx___mutex_lock+0x10/0x10
  ? rcu_is_watching+0x34/0x60
  ? __pfx_lock_acquire+0x10/0x10
  ? stack_trace_save+0x90/0xd0
  ? filter_irq_stacks+0x1d/0x70
  ? kasan_save_stack+0x30/0x40
  ? kasan_save_stack+0x20/0x40
  ? kasan_save_track+0x10/0x30
  rtnetlink_rcv_msg+0x21c/0x860
  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
  ? arch_stack_walk+0x9e/0xf0
  ? rcu_is_watching+0x34/0x60
  ? lock_acquire+0xd5/0x410
  ? rcu_is_watching+0x34/0x60
  netlink_rcv_skb+0xe0/0x210
  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
  ? __pfx_netlink_rcv_skb+0x10/0x10
  ? rcu_is_watching+0x34/0x60
  ? __pfx___netlink_lookup+0x10/0x10
  ? lock_release+0x62/0x200
  ? netlink_deliver_tap+0xfd/0x290
  ? rcu_is_watching+0x34/0x60
  ? lock_release+0x62/0x200
  ? netlink_deliver_tap+0x95/0x290
  netlink_unicast+0x31f/0x480
  ? __pfx_netlink_unicast+0x10/0x10
  ? rcu_is_watching+0x34/0x60
  ? lock_acquire+0xd5/0x410
  netlink_sendmsg+0x369/0x660
  ? lock_release+0x62/0x200
  ? __pfx_netlink_sendmsg+0x10/0x10
  ? import_ubuf+0xb9/0xf0
  ? __import_iovec+0x254/0x2b0
  ? lock_release+0x62/0x200
  ? __pfx_netlink_sendmsg+0x10/0x10
  ____sys_sendmsg+0x559/0x5a0
  ? __pfx_____sys_sendmsg+0x10/0x10
  ? __pfx_copy_msghdr_from_user+0x10/0x10
  ? rcu_is_watching+0x34/0x60
  ? do_read_fault+0x213/0x4a0
  ? rcu_is_watching+0x34/0x60
  ___sys_sendmsg+0xe4/0x150
  ? __pfx____sys_sendmsg+0x10/0x10
  ? do_fault+0x2cc/0x6f0
  ? handle_pte_fault+0x2e3/0x3d0
  ? __pfx_handle_pte_fault+0x10/0x10
  ? preempt_count_sub+0x14/0xc0
  ? __down_read_trylock+0x150/0x270
  ? __handle_mm_fault+0x404/0x8e0
  ? __pfx___handle_mm_fault+0x10/0x10
  ? lock_release+0x62/0x200
  ? __rcu_read_unlock+0x65/0x90
  ? rcu_is_watching+0x34/0x60
  __sys_sendmsg+0xd5/0x150
  ? __pfx___sys_sendmsg+0x10/0x10
  ? __up_read+0x192/0x480
  ? lock_release+0x62/0x200
  ? __rcu_read_unlock+0x65/0x90
  ? rcu_is_watching+0x34/0x60
  do_syscall_64+0x6d/0x140
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f63a5b13367
 Code: 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
 RSP: 002b:00007fff8c726bc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
 RAX: ffffffffffffffda RBX: 0000000067b687c2 RCX: 00007f63a5b13367
 RDX: 0000000000000000 RSI: 00007fff8c726c30 RDI: 0000000000000004
 RBP: 00007fff8c726cb8 R08: 0000000000000000 R09: 0000000000000034
 R10: 00007fff8c726c7c R11: 0000000000000246 R12: 0000000000000001
 R13: 0000000000000000 R14: 00007fff8c726cd0 R15: 00007fff8c726cd0
  </TASK>
 irq event stamp: 0
 hardirqs last  enabled at (0): [<0000000000000000>] 0x0
 hardirqs last disabled at (0): [<ffffffff813f9e58>] copy_process+0xd08/0x2830
 softirqs last  enabled at (0): [<ffffffff813f9e58>] copy_process+0xd08/0x2830
 softirqs last disabled at (0): [<0000000000000000>] 0x0
 ---[ end trace 0000000000000000 ]---

Thus, when calculating ifinfo message size, take VF GUIDs sizes into
account when supported.

Fixes: 30aad41721e0 ("net/core: Add support for getting VF GUIDs")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/20250325090226.749730-1-mbloch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/rtnetlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index d1e559fce918d..80e006940f51a 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1171,6 +1171,9 @@ static inline int rtnl_vfinfo_size(const struct net_device *dev,
 				 /* IFLA_VF_STATS_TX_DROPPED */
 				 nla_total_size_64bit(sizeof(__u64)));
 		}
+		if (dev->netdev_ops->ndo_get_vf_guid)
+			size += num_vfs * 2 *
+				nla_total_size(sizeof(struct ifla_vf_guid));
 		return size;
 	} else
 		return 0;
-- 
2.39.5




