Return-Path: <stable+bounces-10076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD2282724C
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35971C22940
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E344B5AB;
	Mon,  8 Jan 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EloHsK3d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D423F4C3CC;
	Mon,  8 Jan 2024 15:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F36CC433C9;
	Mon,  8 Jan 2024 15:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704726684;
	bh=Z3TGeW+F/aNqLZEkmBGe/yEl9kn7BrxTQYfWN4Cjc6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EloHsK3dIXP8khk3cUmwwqr4T6Rs6tSSV/H3yAkrC2yoQGjQbrs9DPSUQhIS64P+J
	 035VEJiu+nzkNOsXD251EiD7luWfEDciOdex0xYorXV8mR79PqG056ILKSsRNYuvdL
	 Zt0ntA3T8hEKa6PFOGQp0bIGjuCOF1ai0o9hauvk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ke Xiao <xiaoke@sangfor.com.cn>,
	Ding Hui <dinghui@sangfor.com.cn>,
	Di Zhu <zhudi2@huawei.com>,
	Jan Sokolowski <jan.sokolowski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 6.6 045/124] i40e: fix use-after-free in i40e_aqc_add_filters()
Date: Mon,  8 Jan 2024 16:07:51 +0100
Message-ID: <20240108150605.045310667@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
References: <20240108150602.976232871@linuxfoundation.org>
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

From: Ke Xiao <xiaoke@sangfor.com.cn>

[ Upstream commit 6a15584e99db8918b60e507539c7446375dcf366 ]

Commit 3116f59c12bd ("i40e: fix use-after-free in
i40e_sync_filters_subtask()") avoided use-after-free issues,
by increasing refcount during update the VSI filter list to
the HW. However, it missed the unicast situation.

When deleting an unicast FDB entry, the i40e driver will release
the mac_filter, and i40e_service_task will concurrently request
firmware to add the mac_filter, which will lead to the following
use-after-free issue.

Fix again for both netdev->uc and netdev->mc.

BUG: KASAN: use-after-free in i40e_aqc_add_filters+0x55c/0x5b0 [i40e]
Read of size 2 at addr ffff888eb3452d60 by task kworker/8:7/6379

CPU: 8 PID: 6379 Comm: kworker/8:7 Kdump: loaded Tainted: G
Workqueue: i40e i40e_service_task [i40e]
Call Trace:
 dump_stack+0x71/0xab
 print_address_description+0x6b/0x290
 kasan_report+0x14a/0x2b0
 i40e_aqc_add_filters+0x55c/0x5b0 [i40e]
 i40e_sync_vsi_filters+0x1676/0x39c0 [i40e]
 i40e_service_task+0x1397/0x2bb0 [i40e]
 process_one_work+0x56a/0x11f0
 worker_thread+0x8f/0xf40
 kthread+0x2a0/0x390
 ret_from_fork+0x1f/0x40

Allocated by task 21948:
 kasan_kmalloc+0xa6/0xd0
 kmem_cache_alloc_trace+0xdb/0x1c0
 i40e_add_filter+0x11e/0x520 [i40e]
 i40e_addr_sync+0x37/0x60 [i40e]
 __hw_addr_sync_dev+0x1f5/0x2f0
 i40e_set_rx_mode+0x61/0x1e0 [i40e]
 dev_uc_add_excl+0x137/0x190
 i40e_ndo_fdb_add+0x161/0x260 [i40e]
 rtnl_fdb_add+0x567/0x950
 rtnetlink_rcv_msg+0x5db/0x880
 netlink_rcv_skb+0x254/0x380
 netlink_unicast+0x454/0x610
 netlink_sendmsg+0x747/0xb00
 sock_sendmsg+0xe2/0x120
 __sys_sendto+0x1ae/0x290
 __x64_sys_sendto+0xdd/0x1b0
 do_syscall_64+0xa0/0x370
 entry_SYSCALL_64_after_hwframe+0x65/0xca

Freed by task 21948:
 __kasan_slab_free+0x137/0x190
 kfree+0x8b/0x1b0
 __i40e_del_filter+0x116/0x1e0 [i40e]
 i40e_del_mac_filter+0x16c/0x300 [i40e]
 i40e_addr_unsync+0x134/0x1b0 [i40e]
 __hw_addr_sync_dev+0xff/0x2f0
 i40e_set_rx_mode+0x61/0x1e0 [i40e]
 dev_uc_del+0x77/0x90
 rtnl_fdb_del+0x6a5/0x860
 rtnetlink_rcv_msg+0x5db/0x880
 netlink_rcv_skb+0x254/0x380
 netlink_unicast+0x454/0x610
 netlink_sendmsg+0x747/0xb00
 sock_sendmsg+0xe2/0x120
 __sys_sendto+0x1ae/0x290
 __x64_sys_sendto+0xdd/0x1b0
 do_syscall_64+0xa0/0x370
 entry_SYSCALL_64_after_hwframe+0x65/0xca

Fixes: 3116f59c12bd ("i40e: fix use-after-free in i40e_sync_filters_subtask()")
Fixes: 41c445ff0f48 ("i40e: main driver core")
Signed-off-by: Ke Xiao <xiaoke@sangfor.com.cn>
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
Cc: Di Zhu <zhudi2@huawei.com>
Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a9f5a8a7d3f05..370825e433cc6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -104,12 +104,18 @@ static struct workqueue_struct *i40e_wq;
 static void netdev_hw_addr_refcnt(struct i40e_mac_filter *f,
 				  struct net_device *netdev, int delta)
 {
+	struct netdev_hw_addr_list *ha_list;
 	struct netdev_hw_addr *ha;
 
 	if (!f || !netdev)
 		return;
 
-	netdev_for_each_mc_addr(ha, netdev) {
+	if (is_unicast_ether_addr(f->macaddr) || is_link_local_ether_addr(f->macaddr))
+		ha_list = &netdev->uc;
+	else
+		ha_list = &netdev->mc;
+
+	netdev_hw_addr_list_for_each(ha, ha_list) {
 		if (ether_addr_equal(ha->addr, f->macaddr)) {
 			ha->refcount += delta;
 			if (ha->refcount <= 0)
-- 
2.43.0




