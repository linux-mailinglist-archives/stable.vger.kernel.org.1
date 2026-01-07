Return-Path: <stable+bounces-206190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AEBCFF6E5
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 19:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84C3130012F5
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 18:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36FA33A9FD;
	Wed,  7 Jan 2026 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SKLF45Pf"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F01C1534EC
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767806504; cv=none; b=t1TM71PAmVABstAgmUQYl54Qt2nEkGCG2x6BeSpYh1cWSCbtmavJCQBym0Jad4135neYAQL+8YWpaxTuzQyv+QIQmDdpJHNsw1McNAiAPmpoPzpGEAnrlEUaPz6qZ1ZCAaFwGEHID7+LSqMW/1zv89vJ6utttgtxkJz4oRVLHQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767806504; c=relaxed/simple;
	bh=vKsNRka7i79ps83X2Nt+cx1Nofoiqab4riN1GKcx228=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5zuhvzHlBgE7tMEMihX/pfe8cyEWO8hYOpyW90RJw/9eWnPeEZgoWQAvazIyrOXFEBTihHOKD9SBmm2KOyc5JSYxd3bHNVLg9eXSsB11+r4FDvt4lzRxz6l24TAmgOIXCtKpYhzsT/g44IGVzidY5bZTvwuHkEZJYZLLdgREQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SKLF45Pf; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ou7XktXAt0FvfdnbLR5nYNVufhM+RaG85A5nCIAdK04=; b=SKLF45Pf67NBB1xdJsWMAmKK/D
	hWpxEgdlZvcrGwitWp8BhqufzvFvTqpDeSMEkt3MJjW7HpAixKFwkFii0qKfC5rUlSAX6UY+3h03v
	fkln8wlbnLrLMdQ4gGDXmbrT8ZmG9ieuui/SjeTdDXInh1aC+DtspliOuQl3+l7a6ExexkoSj7GYl
	ldP9te1fu3TESXVom9+1I2HOn6Dtyfp+ISgmR69OmUJDyJID00CBepsg0MKCorKnyAtSTP1yJH1tk
	+suIjYz7OdTD4HEUa8O08phnGqJ70YfU7HSuhhRvMb+IM7VMn/GS1WA96yJOx08ULfTSUhl940Kzz
	Dmx5oThg==;
Received: from 179-125-75-246-dinamico.pombonet.net.br ([179.125.75.246] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vdXDo-002eKw-Qx; Wed, 07 Jan 2026 18:21:25 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	syzkaller <syzkaller@googlegroups.com>,
	yan kang <kangyan91@outlook.com>,
	yue sun <samsun1006219@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1] net: Remove RTNL dance for SIOCBRADDIF and SIOCBRDELIF.
Date: Wed,  7 Jan 2026 14:21:16 -0300
Message-ID: <20260107172116.2488542-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit ed3ba9b6e280e14cc3148c1b226ba453f02fa76c upstream.

SIOCBRDELIF is passed to dev_ioctl() first and later forwarded to
br_ioctl_call(), which causes unnecessary RTNL dance and the splat
below [0] under RTNL pressure.

Let's say Thread A is trying to detach a device from a bridge and
Thread B is trying to remove the bridge.

In dev_ioctl(), Thread A bumps the bridge device's refcnt by
netdev_hold() and releases RTNL because the following br_ioctl_call()
also re-acquires RTNL.

In the race window, Thread B could acquire RTNL and try to remove
the bridge device.  Then, rtnl_unlock() by Thread B will release RTNL
and wait for netdev_put() by Thread A.

Thread A, however, must hold RTNL after the unlock in dev_ifsioc(),
which may take long under RTNL pressure, resulting in the splat by
Thread B.

  Thread A (SIOCBRDELIF)           Thread B (SIOCBRDELBR)
  ----------------------           ----------------------
  sock_ioctl                       sock_ioctl
  `- sock_do_ioctl                 `- br_ioctl_call
     `- dev_ioctl                     `- br_ioctl_stub
        |- rtnl_lock                     |
        |- dev_ifsioc                    '
        '  |- dev = __dev_get_by_name(...)
           |- netdev_hold(dev, ...)      .
       /   |- rtnl_unlock  ------.       |
       |   |- br_ioctl_call       `--->  |- rtnl_lock
  Race |   |  `- br_ioctl_stub           |- br_del_bridge
  Window   |     |                       |  |- dev = __dev_get_by_name(...)
       |   |     |  May take long        |  `- br_dev_delete(dev, ...)
       |   |     |  under RTNL pressure  |     `- unregister_netdevice_queue(dev, ...)
       |   |     |               |       `- rtnl_unlock
       \   |     |- rtnl_lock  <-'          `- netdev_run_todo
           |     |- ...                        `- netdev_run_todo
           |     `- rtnl_unlock                   |- __rtnl_unlock
           |                                      |- netdev_wait_allrefs_any
           |- netdev_put(dev, ...)  <----------------'
                                                Wait refcnt decrement
                                                and log splat below

To avoid blocking SIOCBRDELBR unnecessarily, let's not call
dev_ioctl() for SIOCBRADDIF and SIOCBRDELIF.

In the dev_ioctl() path, we do the following:

  1. Copy struct ifreq by get_user_ifreq in sock_do_ioctl()
  2. Check CAP_NET_ADMIN in dev_ioctl()
  3. Call dev_load() in dev_ioctl()
  4. Fetch the master dev from ifr.ifr_name in dev_ifsioc()

3. can be done by request_module() in br_ioctl_call(), so we move
1., 2., and 4. to br_ioctl_stub().

Note that 2. is also checked later in add_del_if(), but it's better
performed before RTNL.

SIOCBRADDIF and SIOCBRDELIF have been processed in dev_ioctl() since
the pre-git era, and there seems to be no specific reason to process
them there.

[0]:
unregister_netdevice: waiting for wpan3 to become free. Usage count = 2
ref_tracker: wpan3@ffff8880662d8608 has 1/1 users at
     __netdev_tracker_alloc include/linux/netdevice.h:4282 [inline]
     netdev_hold include/linux/netdevice.h:4311 [inline]
     dev_ifsioc+0xc6a/0x1160 net/core/dev_ioctl.c:624
     dev_ioctl+0x255/0x10c0 net/core/dev_ioctl.c:826
     sock_do_ioctl+0x1ca/0x260 net/socket.c:1213
     sock_ioctl+0x23a/0x6c0 net/socket.c:1318
     vfs_ioctl fs/ioctl.c:51 [inline]
     __do_sys_ioctl fs/ioctl.c:906 [inline]
     __se_sys_ioctl fs/ioctl.c:892 [inline]
     __x64_sys_ioctl+0x1a4/0x210 fs/ioctl.c:892
     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
     do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 893b19587534 ("net: bridge: fix ioctl locking")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Reported-by: yan kang <kangyan91@outlook.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/netdev/SY8P300MB0421225D54EB92762AE8F0F2A1D32@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/20250316192851.19781-1-kuniyu@amazon.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[cascardo: fixed conflict at dev_ifsioc]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 include/linux/if_bridge.h |  6 ++----
 net/bridge/br_ioctl.c     | 36 +++++++++++++++++++++++++++++++++---
 net/bridge/br_private.h   |  3 +--
 net/core/dev_ioctl.c      | 16 ----------------
 net/socket.c              | 19 +++++++++----------
 5 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index d62ef428e3aa..3963f0af4dad 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -63,11 +63,9 @@ struct br_ip_list {
 #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
 
 struct net_bridge;
-void brioctl_set(int (*hook)(struct net *net, struct net_bridge *br,
-			     unsigned int cmd, struct ifreq *ifr,
+void brioctl_set(int (*hook)(struct net *net, unsigned int cmd,
 			     void __user *uarg));
-int br_ioctl_call(struct net *net, struct net_bridge *br, unsigned int cmd,
-		  struct ifreq *ifr, void __user *uarg);
+int br_ioctl_call(struct net *net, unsigned int cmd, void __user *uarg);
 
 #if IS_ENABLED(CONFIG_BRIDGE) && IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING)
 int br_multicast_list_adjacent(struct net_device *dev,
diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index f213ed108361..6bc0a11f2ed3 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -394,10 +394,26 @@ static int old_deviceless(struct net *net, void __user *data)
 	return -EOPNOTSUPP;
 }
 
-int br_ioctl_stub(struct net *net, struct net_bridge *br, unsigned int cmd,
-		  struct ifreq *ifr, void __user *uarg)
+int br_ioctl_stub(struct net *net, unsigned int cmd, void __user *uarg)
 {
 	int ret = -EOPNOTSUPP;
+	struct ifreq ifr;
+
+	if (cmd == SIOCBRADDIF || cmd == SIOCBRDELIF) {
+		void __user *data;
+		char *colon;
+
+		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+			return -EPERM;
+
+		if (get_user_ifreq(&ifr, &data, uarg))
+			return -EFAULT;
+
+		ifr.ifr_name[IFNAMSIZ - 1] = 0;
+		colon = strchr(ifr.ifr_name, ':');
+		if (colon)
+			*colon = 0;
+	}
 
 	rtnl_lock();
 
@@ -430,7 +446,21 @@ int br_ioctl_stub(struct net *net, struct net_bridge *br, unsigned int cmd,
 		break;
 	case SIOCBRADDIF:
 	case SIOCBRDELIF:
-		ret = add_del_if(br, ifr->ifr_ifindex, cmd == SIOCBRADDIF);
+	{
+		struct net_device *dev;
+
+		dev = __dev_get_by_name(net, ifr.ifr_name);
+		if (!dev || !netif_device_present(dev)) {
+			ret = -ENODEV;
+			break;
+		}
+		if (!netif_is_bridge_master(dev)) {
+			ret = -EOPNOTSUPP;
+			break;
+		}
+
+		ret = add_del_if(netdev_priv(dev), ifr.ifr_ifindex, cmd == SIOCBRADDIF);
+	}
 		break;
 	}
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 901b9f609b0c..2d3859c2979a 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -894,8 +894,7 @@ br_port_get_check_rtnl(const struct net_device *dev)
 /* br_ioctl.c */
 int br_dev_siocdevprivate(struct net_device *dev, struct ifreq *rq,
 			  void __user *data, int cmd);
-int br_ioctl_stub(struct net *net, struct net_bridge *br, unsigned int cmd,
-		  struct ifreq *ifr, void __user *uarg);
+int br_ioctl_stub(struct net *net, unsigned int cmd, void __user *uarg);
 
 /* br_multicast.c */
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 5cdbfbf9a7dc..def973eb496a 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -315,7 +315,6 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 	int err;
 	struct net_device *dev = __dev_get_by_name(net, ifr->ifr_name);
 	const struct net_device_ops *ops;
-	netdevice_tracker dev_tracker;
 
 	if (!dev)
 		return -ENODEV;
@@ -378,19 +377,6 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 	case SIOCWANDEV:
 		return dev_siocwandev(dev, &ifr->ifr_settings);
 
-	case SIOCBRADDIF:
-	case SIOCBRDELIF:
-		if (!netif_device_present(dev))
-			return -ENODEV;
-		if (!netif_is_bridge_master(dev))
-			return -EOPNOTSUPP;
-		netdev_hold(dev, &dev_tracker, GFP_KERNEL);
-		rtnl_unlock();
-		err = br_ioctl_call(net, netdev_priv(dev), cmd, ifr, NULL);
-		netdev_put(dev, &dev_tracker);
-		rtnl_lock();
-		return err;
-
 	case SIOCSHWTSTAMP:
 		err = net_hwtstamp_validate(ifr);
 		if (err)
@@ -575,8 +561,6 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr,
 	case SIOCBONDRELEASE:
 	case SIOCBONDSETHWADDR:
 	case SIOCBONDCHANGEACTIVE:
-	case SIOCBRADDIF:
-	case SIOCBRDELIF:
 	case SIOCSHWTSTAMP:
 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
diff --git a/net/socket.c b/net/socket.c
index bd438b89e698..701389e2f22b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1151,12 +1151,10 @@ static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from)
  */
 
 static DEFINE_MUTEX(br_ioctl_mutex);
-static int (*br_ioctl_hook)(struct net *net, struct net_bridge *br,
-			    unsigned int cmd, struct ifreq *ifr,
+static int (*br_ioctl_hook)(struct net *net, unsigned int cmd,
 			    void __user *uarg);
 
-void brioctl_set(int (*hook)(struct net *net, struct net_bridge *br,
-			     unsigned int cmd, struct ifreq *ifr,
+void brioctl_set(int (*hook)(struct net *net, unsigned int cmd,
 			     void __user *uarg))
 {
 	mutex_lock(&br_ioctl_mutex);
@@ -1165,8 +1163,7 @@ void brioctl_set(int (*hook)(struct net *net, struct net_bridge *br,
 }
 EXPORT_SYMBOL(brioctl_set);
 
-int br_ioctl_call(struct net *net, struct net_bridge *br, unsigned int cmd,
-		  struct ifreq *ifr, void __user *uarg)
+int br_ioctl_call(struct net *net, unsigned int cmd, void __user *uarg)
 {
 	int err = -ENOPKG;
 
@@ -1175,7 +1172,7 @@ int br_ioctl_call(struct net *net, struct net_bridge *br, unsigned int cmd,
 
 	mutex_lock(&br_ioctl_mutex);
 	if (br_ioctl_hook)
-		err = br_ioctl_hook(net, br, cmd, ifr, uarg);
+		err = br_ioctl_hook(net, cmd, uarg);
 	mutex_unlock(&br_ioctl_mutex);
 
 	return err;
@@ -1272,7 +1269,9 @@ static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		case SIOCSIFBR:
 		case SIOCBRADDBR:
 		case SIOCBRDELBR:
-			err = br_ioctl_call(net, NULL, cmd, NULL, argp);
+		case SIOCBRADDIF:
+		case SIOCBRDELIF:
+			err = br_ioctl_call(net, cmd, argp);
 			break;
 		case SIOCGIFVLAN:
 		case SIOCSIFVLAN:
@@ -3376,6 +3375,8 @@ static int compat_sock_ioctl_trans(struct file *file, struct socket *sock,
 	case SIOCGPGRP:
 	case SIOCBRADDBR:
 	case SIOCBRDELBR:
+	case SIOCBRADDIF:
+	case SIOCBRDELIF:
 	case SIOCGIFVLAN:
 	case SIOCSIFVLAN:
 	case SIOCGSKNS:
@@ -3415,8 +3416,6 @@ static int compat_sock_ioctl_trans(struct file *file, struct socket *sock,
 	case SIOCGIFPFLAGS:
 	case SIOCGIFTXQLEN:
 	case SIOCSIFTXQLEN:
-	case SIOCBRADDIF:
-	case SIOCBRDELIF:
 	case SIOCGIFNAME:
 	case SIOCSIFNAME:
 	case SIOCGMIIPHY:
-- 
2.47.3


