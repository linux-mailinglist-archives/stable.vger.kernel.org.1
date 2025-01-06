Return-Path: <stable+bounces-107179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50D7A02A9C
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD701881315
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D073158536;
	Mon,  6 Jan 2025 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cmMWbMMi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D1E15958A;
	Mon,  6 Jan 2025 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177692; cv=none; b=D85xK4IONFYfKxzbifdZ1006BSpCBvXsrZQETZTW5PZgoMKr9BQuNL6Y9GKOKZ3rkPcsNmXnlQcjPRZiaQF6Br1Akm8Hf75PuVpbj6xaxNNkLlUEelf2C06lTHn6bAWYqftaNMl3uaJWIBWT4RyKFautndiHdEpi1hpDjqA6HPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177692; c=relaxed/simple;
	bh=DRUDkuWJ1v3p8mipJ/2Ucx43kkpeh1tLnpqkJYvIJYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYG9JbJpwZpqsDLYt8xzKUn3bvanJ7prZE/dw8pKuhSjQKx9BHUlAlkq4oTLCjnHKTffUeNnc76nOUB7AEcD23tV7SxIPFDi7n95Xa4DDzKEn+z7es6maOp9EfHsVMuVSOrxnEvlfV2agkyfDdIAjyL/+jcwekuifStoPpiVnQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cmMWbMMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D3FC4CED2;
	Mon,  6 Jan 2025 15:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177691;
	bh=DRUDkuWJ1v3p8mipJ/2Ucx43kkpeh1tLnpqkJYvIJYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cmMWbMMiHsjeBxRrU6xz7tnQ4GSGP03taOQOPPHcZ1P35W0bGm+tOZLJosxTsqHwC
	 OUZCxFwwtL0BcSaZz2AEgG+wKpHWmgJ/AqmBUDOD28T04Za8ECR6b/0KJv/0sksmG/
	 1S6kzCrRv/GcL2ft+KC2fO4HAuBWf3y9mNtGv8/E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 025/156] RDMA/siw: Remove direct link to net_device
Date: Mon,  6 Jan 2025 16:15:11 +0100
Message-ID: <20250106151142.689386945@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151141.738050441@linuxfoundation.org>
References: <20250106151141.738050441@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bernard Metzler <bmt@zurich.ibm.com>

[ Upstream commit 16b87037b48889d21854c8e97aec8a1baf2642b3 ]

Do not manage a per device direct link to net_device. Rely
on associated ib_devices net_device management, not doubling
the effort locally. A badly managed local link to net_device
was causing a 'KASAN: slab-use-after-free' exception during
siw_query_port() call.

Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
Reported-by: syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4b87489410b4efd181bf
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
Link: https://patch.msgid.link/20241212151848.564872-1-bmt@zurich.ibm.com
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/siw/siw.h       |  7 +++---
 drivers/infiniband/sw/siw/siw_cm.c    | 27 ++++++++++++++++-----
 drivers/infiniband/sw/siw/siw_main.c  | 15 +-----------
 drivers/infiniband/sw/siw/siw_verbs.c | 35 ++++++++++++++++++---------
 4 files changed, 49 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 86d4d6a2170e..ea5eee50dc39 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -46,6 +46,9 @@
  */
 #define SIW_IRQ_MAXBURST_SQ_ACTIVE 4
 
+/* There is always only a port 1 per siw device */
+#define SIW_PORT 1
+
 struct siw_dev_cap {
 	int max_qp;
 	int max_qp_wr;
@@ -69,16 +72,12 @@ struct siw_pd {
 
 struct siw_device {
 	struct ib_device base_dev;
-	struct net_device *netdev;
 	struct siw_dev_cap attrs;
 
 	u32 vendor_part_id;
 	int numa_node;
 	char raw_gid[ETH_ALEN];
 
-	/* physical port state (only one port per device) */
-	enum ib_port_state state;
-
 	spinlock_t lock;
 
 	struct xarray qp_xa;
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 86323918a570..708b13993fdf 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1759,6 +1759,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 {
 	struct socket *s;
 	struct siw_cep *cep = NULL;
+	struct net_device *ndev = NULL;
 	struct siw_device *sdev = to_siw_dev(id->device);
 	int addr_family = id->local_addr.ss_family;
 	int rv = 0;
@@ -1779,9 +1780,15 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		struct sockaddr_in *laddr = &to_sockaddr_in(id->local_addr);
 
 		/* For wildcard addr, limit binding to current device only */
-		if (ipv4_is_zeronet(laddr->sin_addr.s_addr))
-			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
-
+		if (ipv4_is_zeronet(laddr->sin_addr.s_addr)) {
+			ndev = ib_device_get_netdev(id->device, SIW_PORT);
+			if (ndev) {
+				s->sk->sk_bound_dev_if = ndev->ifindex;
+			} else {
+				rv = -ENODEV;
+				goto error;
+			}
+		}
 		rv = s->ops->bind(s, (struct sockaddr *)laddr,
 				  sizeof(struct sockaddr_in));
 	} else {
@@ -1797,9 +1804,15 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		}
 
 		/* For wildcard addr, limit binding to current device only */
-		if (ipv6_addr_any(&laddr->sin6_addr))
-			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
-
+		if (ipv6_addr_any(&laddr->sin6_addr)) {
+			ndev = ib_device_get_netdev(id->device, SIW_PORT);
+			if (ndev) {
+				s->sk->sk_bound_dev_if = ndev->ifindex;
+			} else {
+				rv = -ENODEV;
+				goto error;
+			}
+		}
 		rv = s->ops->bind(s, (struct sockaddr *)laddr,
 				  sizeof(struct sockaddr_in6));
 	}
@@ -1860,6 +1873,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 	}
 	list_add_tail(&cep->listenq, (struct list_head *)id->provider_data);
 	cep->state = SIW_EPSTATE_LISTENING;
+	dev_put(ndev);
 
 	siw_dbg(id->device, "Listen at laddr %pISp\n", &id->local_addr);
 
@@ -1879,6 +1893,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		siw_cep_set_free_and_put(cep);
 	}
 	sock_release(s);
+	dev_put(ndev);
 
 	return rv;
 }
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 17abef48abcd..14d3103aee6f 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -287,7 +287,6 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 		return NULL;
 
 	base_dev = &sdev->base_dev;
-	sdev->netdev = netdev;
 
 	if (netdev->addr_len) {
 		memcpy(sdev->raw_gid, netdev->dev_addr,
@@ -381,12 +380,10 @@ static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
 
 	switch (event) {
 	case NETDEV_UP:
-		sdev->state = IB_PORT_ACTIVE;
 		siw_port_event(sdev, 1, IB_EVENT_PORT_ACTIVE);
 		break;
 
 	case NETDEV_DOWN:
-		sdev->state = IB_PORT_DOWN;
 		siw_port_event(sdev, 1, IB_EVENT_PORT_ERR);
 		break;
 
@@ -407,12 +404,8 @@ static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
 		siw_port_event(sdev, 1, IB_EVENT_LID_CHANGE);
 		break;
 	/*
-	 * Todo: Below netdev events are currently not handled.
+	 * All other events are not handled
 	 */
-	case NETDEV_CHANGEMTU:
-	case NETDEV_CHANGE:
-		break;
-
 	default:
 		break;
 	}
@@ -442,12 +435,6 @@ static int siw_newlink(const char *basedev_name, struct net_device *netdev)
 	sdev = siw_device_create(netdev);
 	if (sdev) {
 		dev_dbg(&netdev->dev, "siw: new device\n");
-
-		if (netif_running(netdev) && netif_carrier_ok(netdev))
-			sdev->state = IB_PORT_ACTIVE;
-		else
-			sdev->state = IB_PORT_DOWN;
-
 		ib_mark_name_assigned_by_user(&sdev->base_dev);
 		rv = siw_device_register(sdev, basedev_name);
 		if (rv)
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 986666c19378..7ca0297d68a4 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -171,21 +171,29 @@ int siw_query_device(struct ib_device *base_dev, struct ib_device_attr *attr,
 int siw_query_port(struct ib_device *base_dev, u32 port,
 		   struct ib_port_attr *attr)
 {
-	struct siw_device *sdev = to_siw_dev(base_dev);
+	struct net_device *ndev;
 	int rv;
 
 	memset(attr, 0, sizeof(*attr));
 
 	rv = ib_get_eth_speed(base_dev, port, &attr->active_speed,
 			 &attr->active_width);
+	if (rv)
+		return rv;
+
+	ndev = ib_device_get_netdev(base_dev, SIW_PORT);
+	if (!ndev)
+		return -ENODEV;
+
 	attr->gid_tbl_len = 1;
 	attr->max_msg_sz = -1;
-	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
-	attr->active_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
-	attr->phys_state = sdev->state == IB_PORT_ACTIVE ?
+	attr->max_mtu = ib_mtu_int_to_enum(ndev->max_mtu);
+	attr->active_mtu = ib_mtu_int_to_enum(READ_ONCE(ndev->mtu));
+	attr->phys_state = (netif_running(ndev) && netif_carrier_ok(ndev)) ?
 		IB_PORT_PHYS_STATE_LINK_UP : IB_PORT_PHYS_STATE_DISABLED;
+	attr->state = attr->phys_state == IB_PORT_PHYS_STATE_LINK_UP ?
+		IB_PORT_ACTIVE : IB_PORT_DOWN;
 	attr->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_DEVICE_MGMT_SUP;
-	attr->state = sdev->state;
 	/*
 	 * All zero
 	 *
@@ -199,6 +207,7 @@ int siw_query_port(struct ib_device *base_dev, u32 port,
 	 * attr->subnet_timeout = 0;
 	 * attr->init_type_repy = 0;
 	 */
+	dev_put(ndev);
 	return rv;
 }
 
@@ -505,21 +514,24 @@ int siw_query_qp(struct ib_qp *base_qp, struct ib_qp_attr *qp_attr,
 		 int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr)
 {
 	struct siw_qp *qp;
-	struct siw_device *sdev;
+	struct net_device *ndev;
 
-	if (base_qp && qp_attr && qp_init_attr) {
+	if (base_qp && qp_attr && qp_init_attr)
 		qp = to_siw_qp(base_qp);
-		sdev = to_siw_dev(base_qp->device);
-	} else {
+	else
 		return -EINVAL;
-	}
+
+	ndev = ib_device_get_netdev(base_qp->device, SIW_PORT);
+	if (!ndev)
+		return -ENODEV;
+
 	qp_attr->qp_state = siw_qp_state_to_ib_qp_state[qp->attrs.state];
 	qp_attr->cap.max_inline_data = SIW_MAX_INLINE;
 	qp_attr->cap.max_send_wr = qp->attrs.sq_size;
 	qp_attr->cap.max_send_sge = qp->attrs.sq_max_sges;
 	qp_attr->cap.max_recv_wr = qp->attrs.rq_size;
 	qp_attr->cap.max_recv_sge = qp->attrs.rq_max_sges;
-	qp_attr->path_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
+	qp_attr->path_mtu = ib_mtu_int_to_enum(READ_ONCE(ndev->mtu));
 	qp_attr->max_rd_atomic = qp->attrs.irq_size;
 	qp_attr->max_dest_rd_atomic = qp->attrs.orq_size;
 
@@ -534,6 +546,7 @@ int siw_query_qp(struct ib_qp *base_qp, struct ib_qp_attr *qp_attr,
 
 	qp_init_attr->cap = qp_attr->cap;
 
+	dev_put(ndev);
 	return 0;
 }
 
-- 
2.39.5




