Return-Path: <stable+bounces-141555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F28AAB469
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A091BA6A37
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C954479C39;
	Tue,  6 May 2025 00:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOp1AlOt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1BC2F0B86;
	Mon,  5 May 2025 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486687; cv=none; b=TUOVzxGkmMLWU5G6e1Dgh75PjacQKOweSokF6Cl2+coS0MFlb3bXXaNnPkvrb5vQ8v+iotGRq8sXDaS8M6WjlPXqYwEK71U4cyAoAZzs+F1jZY6DpoZLRwYC2VA39Aq96nFQZpaxa0nxA3GR4hlwIPRPEjtTb5vL6ELmXIwdWQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486687; c=relaxed/simple;
	bh=djmlti2Dw3AFkLYPi+h2Yc+4TenUZKFXpqRehzpPmBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IxuXOmDm8VaWZLW4xbbkvZuK6FuHWl/CheZFPlrn1WutNft7gF19dFsy0DArEN/wqvMruZ5H7L1dW6lCbcHmjraH7u+3SbuYjwoeJ25JsrvlvKxyT8gmu/UhQ9qACgN1BVCR0MafNvXJh7P/yBmQ4rh7SZ9yQb8OHcyQ1+Cc0Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOp1AlOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0351BC4CEEE;
	Mon,  5 May 2025 23:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486687;
	bh=djmlti2Dw3AFkLYPi+h2Yc+4TenUZKFXpqRehzpPmBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vOp1AlOtXhhtr8mei1Qp4A9poNTRWT0WOXMXR3wSUKvGMXN9u9v6L6zHr0hOxWKCo
	 PcO/GFJPbREPBOKRHoCKqVSn54/CQLb8dd1uoNEV3fQnTOt0Ooffj/l7ZMr843Dm9Z
	 NyjBgrIYWxpbcpQekxmAUchujT1jxIxC+fz++ypuzBjNSV+S4uRpUr9jKCL4/gP61M
	 xIe8iMMT84cRrQSXaH2K1dfrHRUUk2RqG+18SQgiRcoISfke01evNPlKMrjQ7J2oGQ
	 NeOM6DIxqBM+RndrqajqwyJSvl2Et2DPw1L7wZSw3GXm1dKHolyveFQJFb1v54+feR
	 NuFBAV0DdIqRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	menglong8.dong@gmail.com,
	gnault@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 151/212] vxlan: Join / leave MC group after remote changes
Date: Mon,  5 May 2025 19:05:23 -0400
Message-Id: <20250505230624.2692522-151-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Petr Machata <petrm@nvidia.com>

[ Upstream commit d42d543368343c0449a4e433b5f02e063a86209c ]

When a vxlan netdevice is brought up, if its default remote is a multicast
address, the device joins the indicated group.

Therefore when the multicast remote address changes, the device should
leave the current group and subscribe to the new one. Similarly when the
interface used for endpoint communication is changed in a situation when
multicast remote is configured. This is currently not done.

Both vxlan_igmp_join() and vxlan_igmp_leave() can however fail. So it is
possible that with such fix, the netdevice will end up in an inconsistent
situation where the old group is not joined anymore, but joining the new
group fails. Should we join the new group first, and leave the old one
second, we might end up in the opposite situation, where both groups are
joined. Undoing any of this during rollback is going to be similarly
problematic.

One solution would be to just forbid the change when the netdevice is up.
However in vnifilter mode, changing the group address is allowed, and these
problems are simply ignored (see vxlan_vni_update_group()):

 # ip link add name br up type bridge vlan_filtering 1
 # ip link add vx1 up master br type vxlan external vnifilter local 192.0.2.1 dev lo dstport 4789
 # bridge vni add dev vx1 vni 200 group 224.0.0.1
 # tcpdump -i lo &
 # bridge vni add dev vx1 vni 200 group 224.0.0.2
 18:55:46.523438 IP 0.0.0.0 > 224.0.0.22: igmp v3 report, 1 group record(s)
 18:55:46.943447 IP 0.0.0.0 > 224.0.0.22: igmp v3 report, 1 group record(s)
 # bridge vni
 dev               vni                group/remote
 vx1               200                224.0.0.2

Having two different modes of operation for conceptually the same interface
is silly, so in this patch, just do what the vnifilter code does and deal
with the errors by crossing fingers real hard.

The vnifilter code leaves old before joining new, and in case of join /
leave failures does not roll back the configuration changes that have
already been applied, but bails out of joining if it could not leave. Do
the same here: leave before join, apply changes unconditionally and do not
attempt to join if we couldn't leave.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan/vxlan_core.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 50be5a3c47795..0afd7eb976e6c 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4231,6 +4231,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 			    struct netlink_ext_ack *extack)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	bool rem_ip_changed, change_igmp;
 	struct net_device *lowerdev;
 	struct vxlan_config conf;
 	struct vxlan_rdst *dst;
@@ -4254,8 +4255,13 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (err)
 		return err;
 
+	rem_ip_changed = !vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip);
+	change_igmp = vxlan->dev->flags & IFF_UP &&
+		      (rem_ip_changed ||
+		       dst->remote_ifindex != conf.remote_ifindex);
+
 	/* handle default dst entry */
-	if (!vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip)) {
+	if (rem_ip_changed) {
 		u32 hash_index = fdb_head_index(vxlan, all_zeros_mac, conf.vni);
 
 		spin_lock_bh(&vxlan->hash_lock[hash_index]);
@@ -4299,6 +4305,9 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 		}
 	}
 
+	if (change_igmp && vxlan_addr_multicast(&dst->remote_ip))
+		err = vxlan_multicast_leave(vxlan);
+
 	if (conf.age_interval != vxlan->cfg.age_interval)
 		mod_timer(&vxlan->age_timer, jiffies);
 
@@ -4306,7 +4315,12 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (lowerdev && lowerdev != dst->remote_dev)
 		dst->remote_dev = lowerdev;
 	vxlan_config_apply(dev, &conf, lowerdev, vxlan->net, true);
-	return 0;
+
+	if (!err && change_igmp &&
+	    vxlan_addr_multicast(&dst->remote_ip))
+		err = vxlan_multicast_join(vxlan);
+
+	return err;
 }
 
 static void vxlan_dellink(struct net_device *dev, struct list_head *head)
-- 
2.39.5


