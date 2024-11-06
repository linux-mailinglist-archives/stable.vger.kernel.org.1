Return-Path: <stable+bounces-91527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C75A59BEE62
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61060B224F8
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C9B1E1C37;
	Wed,  6 Nov 2024 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yRp7DX7D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED6F1DEFC0;
	Wed,  6 Nov 2024 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898994; cv=none; b=oCLq+iazpgVNgGVO/bvapD9Pr9neJT4ypThX7qUFZKkjGVEsebTpFLQHuw0CIIY5PFa4fTVZ+CKWqLsuxFeYbx/Gk2u/In5wOEgCf6rW0MVa52OAgWGq1QQZXkY88h5pESw5fZ9yXC0fG41fE1Z86Gk0teAGJg2n9z9MC5WD3e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898994; c=relaxed/simple;
	bh=oB9uH2juW47zv7tG/B2MG/JJsHa2ZawuN0M7LC124qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5tUlfvDtjqYIWSsvH8otBWptzlYhXcjPICfhsMfayAzqQ4AwCiqupiexxnfmxEXlI3RKRCBknnO1mkEeBJUrohzfpkO/Y8rdwEia5Zn+J91RQOMSj/88w3kfYUAKbHhnkEyaP61yg3G2nQmOfMq3B40SpL/uh+0tA1clOt1sQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yRp7DX7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0995C4CECD;
	Wed,  6 Nov 2024 13:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898994;
	bh=oB9uH2juW47zv7tG/B2MG/JJsHa2ZawuN0M7LC124qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yRp7DX7DwHs5mCnC/RVoQvdCOCGYmF7NQxHUAGEyof5+yLkh/ikn6GPm+1AQQCUmT
	 sHRrR6eSh/Yuh8X/zSEhAo9hvD/CDT4aQ6A2mv05X7vH2ZlzjOX88aWPtmruM/EqRS
	 3DbopW1P/NoGyFVtcEWif6C29R89MJqRDs5w2K3o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xin Long <lucien.xin@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 388/462] ipv4: give an IPv4 dev to blackhole_netdev
Date: Wed,  6 Nov 2024 13:04:41 +0100
Message-ID: <20241106120341.108114319@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 22600596b6756b166fd052d5facb66287e6f0bad ]

After commit 8d7017fd621d ("blackhole_netdev: use blackhole_netdev to
invalidate dst entries"), blackhole_netdev was introduced to invalidate
dst cache entries on the TX path whenever the cache times out or is
flushed.

When two UDP sockets (sk1 and sk2) send messages to the same destination
simultaneously, they are using the same dst cache. If the dst cache is
invalidated on one path (sk2) while the other (sk1) is still transmitting,
sk1 may try to use the invalid dst entry.

         CPU1                   CPU2

      udp_sendmsg(sk1)       udp_sendmsg(sk2)
      udp_send_skb()
      ip_output()
                                             <--- dst timeout or flushed
                             dst_dev_put()
      ip_finish_output2()
      ip_neigh_for_gw()

This results in a scenario where ip_neigh_for_gw() returns -EINVAL because
blackhole_dev lacks an in_dev, which is needed to initialize the neigh in
arp_constructor(). This error is then propagated back to userspace,
breaking the UDP application.

The patch fixes this issue by assigning an in_dev to blackhole_dev for
IPv4, similar to what was done for IPv6 in commit e5f80fcf869a ("ipv6:
give an IPv6 dev to blackhole_netdev"). This ensures that even when the
dst entry is invalidated with blackhole_dev, it will not fail to create
the neigh entry.

As devinet_init() is called ealier than blackhole_netdev_init() in system
booting, it can not assign the in_dev to blackhole_dev in devinet_init().
As Paolo suggested, add a separate late_initcall() in devinet.c to ensure
inet_blackhole_dev_init() is called after blackhole_netdev_init().

Fixes: 8d7017fd621d ("blackhole_netdev: use blackhole_netdev to invalidate dst entries")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/3000792d45ca44e16c785ebe2b092e610e5b3df1.1728499633.git.lucien.xin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/devinet.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index dec884bf73f05..9910844c890ba 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -273,17 +273,19 @@ static struct in_device *inetdev_init(struct net_device *dev)
 	/* Account for reference dev->ip_ptr (below) */
 	refcount_set(&in_dev->refcnt, 1);
 
-	err = devinet_sysctl_register(in_dev);
-	if (err) {
-		in_dev->dead = 1;
-		neigh_parms_release(&arp_tbl, in_dev->arp_parms);
-		in_dev_put(in_dev);
-		in_dev = NULL;
-		goto out;
+	if (dev != blackhole_netdev) {
+		err = devinet_sysctl_register(in_dev);
+		if (err) {
+			in_dev->dead = 1;
+			neigh_parms_release(&arp_tbl, in_dev->arp_parms);
+			in_dev_put(in_dev);
+			in_dev = NULL;
+			goto out;
+		}
+		ip_mc_init_dev(in_dev);
+		if (dev->flags & IFF_UP)
+			ip_mc_up(in_dev);
 	}
-	ip_mc_init_dev(in_dev);
-	if (dev->flags & IFF_UP)
-		ip_mc_up(in_dev);
 
 	/* we can receive as soon as ip_ptr is set -- do this last */
 	rcu_assign_pointer(dev->ip_ptr, in_dev);
@@ -328,6 +330,19 @@ static void inetdev_destroy(struct in_device *in_dev)
 	call_rcu(&in_dev->rcu_head, in_dev_rcu_put);
 }
 
+static int __init inet_blackhole_dev_init(void)
+{
+	int err = 0;
+
+	rtnl_lock();
+	if (!inetdev_init(blackhole_netdev))
+		err = -ENOMEM;
+	rtnl_unlock();
+
+	return err;
+}
+late_initcall(inet_blackhole_dev_init);
+
 int inet_addr_onlink(struct in_device *in_dev, __be32 a, __be32 b)
 {
 	const struct in_ifaddr *ifa;
-- 
2.43.0




