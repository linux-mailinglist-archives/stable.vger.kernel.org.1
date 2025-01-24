Return-Path: <stable+bounces-110345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 789D4A1AE85
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 03:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B29F1887EBC
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 02:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6561D5146;
	Fri, 24 Jan 2025 02:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="rUOpBErr"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5522B9BC
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 02:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737685761; cv=none; b=TeEjQ2Q4wvHjxDw6Y6jfAEX6s0rXx+lpkSzZTD1MReTcPYT6u1ftDfxx8DJvI8V2Kt5K8soaiKGZRWFSoc8PVUocf6gdzKp3YYwYJz9xTYfwUUDuue4imv3G52DV0bV4jpBw09ffyGaOHmQ+gXWVxwA2ZlZvOZATmOcG/QVz4Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737685761; c=relaxed/simple;
	bh=2k8sZQPlk8ikZ2JT8/xABmPbdndbECJ0XpU2dKdV1i0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=BKk7k04oTUe1xrRK0v2td8bnQB2NLIzGJNt7UwRRleFCIK++DeryBxJeLBjFdDPKXG3R8NHPBlkfWAtUAaOLnIK4fOdwA9askjEh6elS4WtuT90xHgi8zln//4rl5+R9vDVi0CItQtcVVdc1uHThs84KSpES89u2DzI2JV/GaPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=rUOpBErr; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1737685453;
	bh=UV2gstlY/yVz9gzEsW8Xu47kRnV7k9+IwwSrc+4lxik=;
	h=From:To:Cc:Subject:Date;
	b=rUOpBErrM/uZe/wzFwG7VWxqCThZ04WrGyHL8cBsnFVmfTFlOmtyF3YFgS4YFoKMO
	 oZq08U5WQwFjP7bYU4AaZ8iPja1FhoNVVkCJ7tjk+fo3S7DTPbdPU/EBzzoamu8A/2
	 j4uyW8RbY+5aINGN2cGi+A+BtSRpeMwQVvVYHxcU=
Received: from public ([120.244.194.224])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id 60887E0C; Fri, 24 Jan 2025 10:24:08 +0800
X-QQ-mid: xmsmtpt1737685448tjxk2z1xn
Message-ID: <tencent_84E371D061F81AB069496BFC3F862449AC09@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JutGjXYvAzJ6i3v+SCNAthpPvpEi6SIojg0FyQ9lTzQ9BCHUdYBS
	 Ja3mBwXlfO+qy1woLRph/89fe5SB4EwQyTBv066sMENnVToL36VDZaA//E3C5od4Y6JCBDh7TsLO
	 hYCdeR2OZWx4KTp4425g5HlGjXT06gHbkxU9hOg0KStMp9pJZcnJX7CVmvAXlmC3xq/fImGovshN
	 dgqK7NTBgZh5Fu4YMtjLbkwq8Z6HTg1oZWR+TNI+MD078JuDuyp66sO5WuHyp3ArKiYJ7CQwp+rS
	 cmSwuZBon4Vxl11xLLwFFjJBttWeEZ3NZnwww0EHWoVyxpUl3McHItokQGO5eYRuomzL9R5d6zCn
	 3n0jY9jrT3MTNb0Yq0eoKHtvESpuqUBu2bhkWTUGkMZwDjhHY1bbStVT7KyXe7iLv41FrXW3fIGU
	 Bvu2NFwhqQvJm/js8qb5ixMJtcEln4KW84QDnpRuGCQe7zYUVH9V6vatpgZPBSP60P/eREcRJNI1
	 SVD1SxV8HqYgiUzXBCJfGW4YCw02Rz1jL9PkA0AoxOI9oBgta/VauqcgZsby1e6PfFrae2uKASPa
	 MOVXGifHt8qEIfC7s0gcWxknCkl7YJbpfS46Bzau0rj4CPq6xfVhMrhOIa845UMmK4rFtDOF0yCm
	 9927AV4R5RWpjLp52/0se7g+sBmhCAsHI6lGDHh2Jp+GIyUCHzgv6s/gpJ3q823Nz3A0OFPsm++7
	 ps5r7NpLdG6VC2u6uk04iwS1XRwBVF6398SZK6GACmkiw0UgaK1ndKAURVsdutpFYxwTzs4rcN1p
	 7KnSUI82ylMckb6Ezwi5EA1zqpDJOSpGP8uuxn034H1wDYSNiSsfqQVbb0YH5vThiUMqde0sctlR
	 GK0FGYLnHOFqAmiffZ5SYMrZU+fLwQI7ZYTeeGnzVCEsDa53jo+FtbSIeU60Y2wRVCj98QwiQrFB
	 qhySj7zndeN/FGCn+JL9ymCUkp/gFQ6Mv78vuWJtUBoY2sHv3y236ufDVR+AXWoLwf4KeFbk9i4j
	 OUxR77bWB+JLSzVfwpVKLlu5/rc+96MjQg0Ou+AMwxPbex2BIh5qwsZLfLLGHeZ33qf0m7PhiEz2
	 sdSA8Q
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: alvalan9@foxmail.com
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 5.10.y] ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
Date: Fri, 24 Jan 2025 10:24:08 +0800
X-OQ-MSGID: <20250124022408.1917-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ido Schimmel <idosch@nvidia.com>

commit 90e0569dd3d32f4f4d2ca691d3fa5a8a14a13c12 upstream.

The per-netns IP tunnel hash table is protected by the RTNL mutex and
ip_tunnel_find() is only called from the control path where the mutex is
taken.

Add a lockdep expression to hlist_for_each_entry_rcu() in
ip_tunnel_find() in order to validate that the mutex is held and to
silence the suspicious RCU usage warning [1].

[1]
WARNING: suspicious RCU usage
6.12.0-rc3-custom-gd95d9a31aceb #139 Not tainted
-----------------------------
net/ipv4/ip_tunnel.c:221 RCU-list traversed in non-reader section!!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
1 lock held by ip/362:
 #0: ffffffff86fc7cb0 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x377/0xf60

stack backtrace:
CPU: 12 UID: 0 PID: 362 Comm: ip Not tainted 6.12.0-rc3-custom-gd95d9a31aceb #139
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
 <TASK>
 dump_stack_lvl+0xba/0x110
 lockdep_rcu_suspicious.cold+0x4f/0xd6
 ip_tunnel_find+0x435/0x4d0
 ip_tunnel_newlink+0x517/0x7a0
 ipgre_newlink+0x14c/0x170
 __rtnl_newlink+0x1173/0x19c0
 rtnl_newlink+0x6c/0xa0
 rtnetlink_rcv_msg+0x3cc/0xf60
 netlink_rcv_skb+0x171/0x450
 netlink_unicast+0x539/0x7f0
 netlink_sendmsg+0x8c1/0xd80
 ____sys_sendmsg+0x8f9/0xc20
 ___sys_sendmsg+0x197/0x1e0
 __sys_sendmsg+0x122/0x1f0
 do_syscall_64+0xbb/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241023123009.749764-1-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 net/ipv4/ip_tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 53cc17b1da34..cf9184928ede 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -218,7 +218,7 @@ static struct ip_tunnel *ip_tunnel_find(struct ip_tunnel_net *itn,
 	struct ip_tunnel *t = NULL;
 	struct hlist_head *head = ip_bucket(itn, parms);
 
-	hlist_for_each_entry_rcu(t, head, hash_node) {
+	hlist_for_each_entry_rcu(t, head, hash_node, lockdep_rtnl_is_held()) {
 		if (local == t->parms.iph.saddr &&
 		    remote == t->parms.iph.daddr &&
 		    link == t->parms.link &&
-- 
2.43.0


