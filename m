Return-Path: <stable+bounces-68064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE79953072
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF57285725
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAC219DF9C;
	Thu, 15 Aug 2024 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ntuEcycJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955E51714A8;
	Thu, 15 Aug 2024 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729383; cv=none; b=Wc+GpeUiZi2jszs4G187CvXYqcmwOKZn9697lC4blHDGp2P/tQ2onxIw2bsQ/yvYWbONSuHFUL8W5AYcIqarpYHjw9JDExbfNyp2IGxwTYcGtn+FfdVrr06OBeGzzGZp1udNtHHlKVBY3EX12aAy/xIFSyRW0rVKXEwA4/1uaAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729383; c=relaxed/simple;
	bh=RjIFiRbMonqthMEJEw/jGOILaRdN1ik58RpZ5XuOaj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVf4cz4SysDg8OT+XhZmFArN1nhTfkilT+GyTG4GcBnOIecB0hQvQsBYQsGcoqpMFAriMiLAa4JwHhM8xVOJXR+1anGVGUSA9FIdsNlfPr3PtVT2cWsNjYE3BqNQ4Gt5kNzO1csMjknXP97JiDfWuZbbu8sGHHg7/nddvW1MUCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ntuEcycJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFA3C32786;
	Thu, 15 Aug 2024 13:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723729383;
	bh=RjIFiRbMonqthMEJEw/jGOILaRdN1ik58RpZ5XuOaj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntuEcycJAxjJlH5qbYOW3vAgbcRI05iyzJxz7ckb31pXwnool+QytLpeJil09L9Re
	 AwI9BVBwpQEdKXo0HmiaI5Inek/ZgE8RLJV08kj61p6jgd5Cz1WWL0hGN9+I2blU3b
	 kce1yUvc34mngUb+MCPBjLW7RPbp1UAKlKh9giqI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Taehee Yoo <ap420073@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 080/484] xdp: fix invalid wait context of page_pool_destroy()
Date: Thu, 15 Aug 2024 15:18:58 +0200
Message-ID: <20240815131944.373933267@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 59a931c5b732ca5fc2ca727f5a72aeabaafa85ec ]

If the driver uses a page pool, it creates a page pool with
page_pool_create().
The reference count of page pool is 1 as default.
A page pool will be destroyed only when a reference count reaches 0.
page_pool_destroy() is used to destroy page pool, it decreases a
reference count.
When a page pool is destroyed, ->disconnect() is called, which is
mem_allocator_disconnect().
This function internally acquires mutex_lock().

If the driver uses XDP, it registers a memory model with
xdp_rxq_info_reg_mem_model().
The xdp_rxq_info_reg_mem_model() internally increases a page pool
reference count if a memory model is a page pool.
Now the reference count is 2.

To destroy a page pool, the driver should call both page_pool_destroy()
and xdp_unreg_mem_model().
The xdp_unreg_mem_model() internally calls page_pool_destroy().
Only page_pool_destroy() decreases a reference count.

If a driver calls page_pool_destroy() then xdp_unreg_mem_model(), we
will face an invalid wait context warning.
Because xdp_unreg_mem_model() calls page_pool_destroy() with
rcu_read_lock().
The page_pool_destroy() internally acquires mutex_lock().

Splat looks like:
=============================
[ BUG: Invalid wait context ]
6.10.0-rc6+ #4 Tainted: G W
-----------------------------
ethtool/1806 is trying to lock:
ffffffff90387b90 (mem_id_lock){+.+.}-{4:4}, at: mem_allocator_disconnect+0x73/0x150
other info that might help us debug this:
context-{5:5}
3 locks held by ethtool/1806:
stack backtrace:
CPU: 0 PID: 1806 Comm: ethtool Tainted: G W 6.10.0-rc6+ #4 f916f41f172891c800f2fed
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/2021
Call Trace:
<TASK>
dump_stack_lvl+0x7e/0xc0
__lock_acquire+0x1681/0x4de0
? _printk+0x64/0xe0
? __pfx_mark_lock.part.0+0x10/0x10
? __pfx___lock_acquire+0x10/0x10
lock_acquire+0x1b3/0x580
? mem_allocator_disconnect+0x73/0x150
? __wake_up_klogd.part.0+0x16/0xc0
? __pfx_lock_acquire+0x10/0x10
? dump_stack_lvl+0x91/0xc0
__mutex_lock+0x15c/0x1690
? mem_allocator_disconnect+0x73/0x150
? __pfx_prb_read_valid+0x10/0x10
? mem_allocator_disconnect+0x73/0x150
? __pfx_llist_add_batch+0x10/0x10
? console_unlock+0x193/0x1b0
? lockdep_hardirqs_on+0xbe/0x140
? __pfx___mutex_lock+0x10/0x10
? tick_nohz_tick_stopped+0x16/0x90
? __irq_work_queue_local+0x1e5/0x330
? irq_work_queue+0x39/0x50
? __wake_up_klogd.part.0+0x79/0xc0
? mem_allocator_disconnect+0x73/0x150
mem_allocator_disconnect+0x73/0x150
? __pfx_mem_allocator_disconnect+0x10/0x10
? mark_held_locks+0xa5/0xf0
? rcu_is_watching+0x11/0xb0
page_pool_release+0x36e/0x6d0
page_pool_destroy+0xd7/0x440
xdp_unreg_mem_model+0x1a7/0x2a0
? __pfx_xdp_unreg_mem_model+0x10/0x10
? kfree+0x125/0x370
? bnxt_free_ring.isra.0+0x2eb/0x500
? bnxt_free_mem+0x5ac/0x2500
xdp_rxq_info_unreg+0x4a/0xd0
bnxt_free_mem+0x1356/0x2500
bnxt_close_nic+0xf0/0x3b0
? __pfx_bnxt_close_nic+0x10/0x10
? ethnl_parse_bit+0x2c6/0x6d0
? __pfx___nla_validate_parse+0x10/0x10
? __pfx_ethnl_parse_bit+0x10/0x10
bnxt_set_features+0x2a8/0x3e0
__netdev_update_features+0x4dc/0x1370
? ethnl_parse_bitset+0x4ff/0x750
? __pfx_ethnl_parse_bitset+0x10/0x10
? __pfx___netdev_update_features+0x10/0x10
? mark_held_locks+0xa5/0xf0
? _raw_spin_unlock_irqrestore+0x42/0x70
? __pm_runtime_resume+0x7d/0x110
ethnl_set_features+0x32d/0xa20

To fix this problem, it uses rhashtable_lookup_fast() instead of
rhashtable_lookup() with rcu_read_lock().
Using xa without rcu_read_lock() here is safe.
xa is freed by __xdp_mem_allocator_rcu_free() and this is called by
call_rcu() of mem_xa_remove().
The mem_xa_remove() is called by page_pool_destroy() if a reference
count reaches 0.
The xa is already protected by the reference count mechanism well in the
control plane.
So removing rcu_read_lock() for page_pool_destroy() is safe.

Fixes: c3f812cea0d7 ("page_pool: do not release pool until inflight == 0.")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Link: https://patch.msgid.link/20240712095116.3801586-1-ap420073@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/xdp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index e9a9694c4fdcc..4a9c2f4eceda8 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -124,10 +124,8 @@ void xdp_unreg_mem_model(struct xdp_mem_info *mem)
 		return;
 
 	if (type == MEM_TYPE_PAGE_POOL) {
-		rcu_read_lock();
-		xa = rhashtable_lookup(mem_id_ht, &id, mem_id_rht_params);
+		xa = rhashtable_lookup_fast(mem_id_ht, &id, mem_id_rht_params);
 		page_pool_destroy(xa->page_pool);
-		rcu_read_unlock();
 	}
 }
 EXPORT_SYMBOL_GPL(xdp_unreg_mem_model);
-- 
2.43.0




