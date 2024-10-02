Return-Path: <stable+bounces-80561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D7F98DE6A
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291851F27F3A
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C5A1D048E;
	Wed,  2 Oct 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QM0GZMGt"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CFF1D0964
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881641; cv=none; b=gAvySZ9/1rsB7vR081F7uofJ/MSa2a8n80c6zY0Cy8ioiTAda9SuA1Kzvu/vhYfZ02syksrV6C/d9/139eMKbX7/cnLq0NqbroHVgJ+A+lappqpV23wFmP3MGgPXqpP6I54UTTeipJ49045Sxpwprx6h3JANMu9GtvUZbxSQL8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881641; c=relaxed/simple;
	bh=Yfzm0mqcs1/aGabKcH92KcQTc+qFcBLuGvza64VhuWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=khCsqQN6MbjbCxRLzxqKF8UndqzybFR/k81tWZeEOHhef6dR28bMQY57Oqfxm3FNJ1ORFi3EdaFwxD+1eFylVCPJVGti1eFKraNyWKQW2F0Rlelvg8hb3j0GyDua88xmgY7h1inEmtbAFQGtg6t7VmPI+qscFboqf0EgV22xSe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QM0GZMGt; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Cd49Z011636;
	Wed, 2 Oct 2024 15:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=N
	+8XcpRtkBBgN+WOkwjXKALxiS39zAzTb6Mo0m5DCA8=; b=QM0GZMGtyEAgKv6C+
	sbxEIznNSYNXCG48wKKkXzuOufNGqP3i2sRgPRddlwqFjpj7S8aCuKc0OVrJiYSN
	KXRdvEUK/hgOOU1dHiFPSkD2MVF+Omx22oBYdXnzuXitCZPF8l+kuclh5nHx6+Y6
	Z5SiQTTF30ddTkx0C9wzYdG80DvZSHq7BIW0Bs3g4/2ThJCZ7GlHkRgXcrTLV42k
	7Zge4/Ea13wbEA3iRXKhxdYlOkH9h0Tz7eyCqR+aSkfFQ011WTlsQ0RhZt0zSVxu
	O5MJ61sYkE2gb7doDNmHZP+LdKzdno2wAEZ2vZsGz1h//sF+bXdvUDgk1Bpq+xD5
	q+2hQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k39p6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:07:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492EX7Ln017368;
	Wed, 2 Oct 2024 15:07:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x888y0vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:07:02 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 492F1lZS012831;
	Wed, 2 Oct 2024 15:07:01 GMT
Received: from localhost.localdomain (dhcp-10-175-43-118.vpn.oracle.com [10.175.43.118])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x888xyse-9;
	Wed, 02 Oct 2024 15:07:01 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
        mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
        ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
        shivani.agarwal@broadcom.com,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        syzbot+d81bcd883824180500c8@syzkaller.appspotmail.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH RFC 6.6.y 08/15] net: dsa: fix netdev_priv() dereference before check on non-DSA netdevice events
Date: Wed,  2 Oct 2024 17:05:59 +0200
Message-Id: <20241002150606.11385-9-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002150606.11385-1-vegard.nossum@oracle.com>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020109
X-Proofpoint-GUID: 3dN_kSvoLrVy76dFGfVCdGfzuOwiPgvj
X-Proofpoint-ORIG-GUID: 3dN_kSvoLrVy76dFGfVCdGfzuOwiPgvj

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 844f104790bd69c2e4dbb9ee3eba46fde1fcea7b ]

After the blamed commit, we started doing this dereference for every
NETDEV_CHANGEUPPER and NETDEV_PRECHANGEUPPER event in the system.

static inline struct dsa_port *dsa_user_to_port(const struct net_device *dev)
{
	struct dsa_user_priv *p = netdev_priv(dev);

	return p->dp;
}

Which is obviously bogus, because not all net_devices have a netdev_priv()
of type struct dsa_user_priv. But struct dsa_user_priv is fairly small,
and p->dp means dereferencing 8 bytes starting with offset 16. Most
drivers allocate that much private memory anyway, making our access not
fault, and we discard the bogus data quickly afterwards, so this wasn't
caught.

But the dummy interface is somewhat special in that it calls
alloc_netdev() with a priv size of 0. So every netdev_priv() dereference
is invalid, and we get this when we emit a NETDEV_PRECHANGEUPPER event
with a VLAN as its new upper:

$ ip link add dummy1 type dummy
$ ip link add link dummy1 name dummy1.100 type vlan id 100
[   43.309174] ==================================================================
[   43.316456] BUG: KASAN: slab-out-of-bounds in dsa_user_prechangeupper+0x30/0xe8
[   43.323835] Read of size 8 at addr ffff3f86481d2990 by task ip/374
[   43.330058]
[   43.342436] Call trace:
[   43.366542]  dsa_user_prechangeupper+0x30/0xe8
[   43.371024]  dsa_user_netdevice_event+0xb38/0xee8
[   43.375768]  notifier_call_chain+0xa4/0x210
[   43.379985]  raw_notifier_call_chain+0x24/0x38
[   43.384464]  __netdev_upper_dev_link+0x3ec/0x5d8
[   43.389120]  netdev_upper_dev_link+0x70/0xa8
[   43.393424]  register_vlan_dev+0x1bc/0x310
[   43.397554]  vlan_newlink+0x210/0x248
[   43.401247]  rtnl_newlink+0x9fc/0xe30
[   43.404942]  rtnetlink_rcv_msg+0x378/0x580

Avoid the kernel oops by dereferencing after the type check, as customary.

Fixes: 4c3f80d22b2e ("net: dsa: walk through all changeupper notifier functions")
Reported-and-tested-by: syzbot+d81bcd883824180500c8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/0000000000001d4255060e87545c@google.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240110003354.2796778-1-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 844f104790bd69c2e4dbb9ee3eba46fde1fcea7b)
[Harshit: CVE-2024-26596; Resolve conflicts due to missing commit: 6ca80638b90c
 ("net: dsa: Use conduit and user terms") in 6.6.y, used dsa_slave_to_port()
 instead of dsa_user_to_port()]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 net/dsa/slave.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 48db91b33390b..9328ca004fd90 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2822,13 +2822,14 @@ EXPORT_SYMBOL_GPL(dsa_slave_dev_check);
 static int dsa_slave_changeupper(struct net_device *dev,
 				 struct netdev_notifier_changeupper_info *info)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
 	struct netlink_ext_ack *extack;
 	int err = NOTIFY_DONE;
+	struct dsa_port *dp;
 
 	if (!dsa_slave_dev_check(dev))
 		return err;
 
+	dp = dsa_slave_to_port(dev);
 	extack = netdev_notifier_info_to_extack(&info->info);
 
 	if (netif_is_bridge_master(info->upper_dev)) {
@@ -2881,11 +2882,13 @@ static int dsa_slave_changeupper(struct net_device *dev,
 static int dsa_slave_prechangeupper(struct net_device *dev,
 				    struct netdev_notifier_changeupper_info *info)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp;
 
 	if (!dsa_slave_dev_check(dev))
 		return NOTIFY_DONE;
 
+	dp = dsa_slave_to_port(dev);
+
 	if (netif_is_bridge_master(info->upper_dev) && !info->linking)
 		dsa_port_pre_bridge_leave(dp, info->upper_dev);
 	else if (netif_is_lag_master(info->upper_dev) && !info->linking)
-- 
2.34.1


