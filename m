Return-Path: <stable+bounces-170760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47135B2A640
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6181884F80
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB3A31E11E;
	Mon, 18 Aug 2025 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="se16CTcM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5F631CA6E;
	Mon, 18 Aug 2025 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523686; cv=none; b=JKzriRg2BDcaly0nLCTCWDzX6Th5RAD1ER5IZDoDnnAv6Ku3AgwzX4mMurijUDMbr2hKF3CHe6RiunYGinPzbJooXhdYbS17AxRvP0Arz13E7iKNnribb2ujfUjgzk8y3ip9vHVswAbLYeBbGsumFOHu7CIVWLwgGfOi8dz0hxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523686; c=relaxed/simple;
	bh=nPlH7HDKDexz4qvkNNo9ikqfKxSnC/Fb8cSgfrqyAMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6jv3useczXhopZs9CsAIdqs61p/VbgFuZobP7Egj0Pqf201YakkoGfnoEczxixL8XTz8nhCt+DyHgCGoob+B7kzphwT8NElTUxWtz2HknW1Bs6id4WJpLK2X80fA/iHenuSbW4gAkpPSXmvf8mdD9Mr0zoJYNrydvOIYoBBrVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=se16CTcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC9BC4CEEB;
	Mon, 18 Aug 2025 13:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755523685;
	bh=nPlH7HDKDexz4qvkNNo9ikqfKxSnC/Fb8cSgfrqyAMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=se16CTcM1DM+wJrDp8jbnSTrYXmuPJ6szMWMJ4erCBjxQaKT/0p8ortnUlLItvFsW
	 bmlDI6oO8lr6LdmE4SHASkDyLUnCB4bEgvaQH5Kj5RwfGklDYjTaHNOAsAS+7CEKYR
	 woCp/o9CytT8tZjOLwHgiZEjTu4pq6cru4LfFycw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 247/515] ipv6: mcast: Check inet6_dev->dead under idev->mc_lock in __ipv6_dev_mc_inc().
Date: Mon, 18 Aug 2025 14:43:53 +0200
Message-ID: <20250818124507.903135435@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit dbd40f318cf2f59759bd170c401adc20ba360a3e ]

Since commit 63ed8de4be81 ("mld: add mc_lock for protecting
per-interface mld data"), every multicast resource is protected
by inet6_dev->mc_lock.

RTNL is unnecessary in terms of protection but still needed for
synchronisation between addrconf_ifdown() and __ipv6_dev_mc_inc().

Once we removed RTNL, there would be a race below, where we could
add a multicast address to a dead inet6_dev.

  CPU1                            CPU2
  ====                            ====
  addrconf_ifdown()               __ipv6_dev_mc_inc()
                                    if (idev->dead) <-- false
    dead = true                       return -ENODEV;
    ipv6_mc_destroy_dev() / ipv6_mc_down()
      mutex_lock(&idev->mc_lock)
      ...
      mutex_unlock(&idev->mc_lock)
                                    mutex_lock(&idev->mc_lock)
                                    ...
                                    mutex_unlock(&idev->mc_lock)

The race window can be easily closed by checking inet6_dev->dead
under inet6_dev->mc_lock in __ipv6_dev_mc_inc() as addrconf_ifdown()
will acquire it after marking inet6_dev dead.

Let's check inet6_dev->dead under mc_lock in __ipv6_dev_mc_inc().

Note that now __ipv6_dev_mc_inc() no longer depends on RTNL and
we can remove ASSERT_RTNL() there and the RTNL comment above
addrconf_join_solict().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250702230210.3115355-4-kuni1840@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/addrconf.c |  7 +++----
 net/ipv6/mcast.c    | 11 +++++------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 4ef3a3c166c6..7881637f6518 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2229,13 +2229,12 @@ void addrconf_dad_failure(struct sk_buff *skb, struct inet6_ifaddr *ifp)
 	in6_ifa_put(ifp);
 }
 
-/* Join to solicited addr multicast group.
- * caller must hold RTNL */
+/* Join to solicited addr multicast group. */
 void addrconf_join_solict(struct net_device *dev, const struct in6_addr *addr)
 {
 	struct in6_addr maddr;
 
-	if (dev->flags&(IFF_LOOPBACK|IFF_NOARP))
+	if (READ_ONCE(dev->flags) & (IFF_LOOPBACK | IFF_NOARP))
 		return;
 
 	addrconf_addr_solict_mult(addr, &maddr);
@@ -3860,7 +3859,7 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 	 *	   Do not dev_put!
 	 */
 	if (unregister) {
-		idev->dead = 1;
+		WRITE_ONCE(idev->dead, 1);
 
 		/* protected by rtnl_lock */
 		RCU_INIT_POINTER(dev->ip6_ptr, NULL);
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 616bf4c0c8fd..b91538e90c54 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -945,23 +945,22 @@ static void inet6_ifmcaddr_notify(struct net_device *dev,
 static int __ipv6_dev_mc_inc(struct net_device *dev,
 			     const struct in6_addr *addr, unsigned int mode)
 {
-	struct ifmcaddr6 *mc;
 	struct inet6_dev *idev;
-
-	ASSERT_RTNL();
+	struct ifmcaddr6 *mc;
 
 	/* we need to take a reference on idev */
 	idev = in6_dev_get(dev);
-
 	if (!idev)
 		return -EINVAL;
 
-	if (idev->dead) {
+	mutex_lock(&idev->mc_lock);
+
+	if (READ_ONCE(idev->dead)) {
+		mutex_unlock(&idev->mc_lock);
 		in6_dev_put(idev);
 		return -ENODEV;
 	}
 
-	mutex_lock(&idev->mc_lock);
 	for_each_mc_mclock(idev, mc) {
 		if (ipv6_addr_equal(&mc->mca_addr, addr)) {
 			mc->mca_users++;
-- 
2.39.5




