Return-Path: <stable+bounces-213352-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNWpN03igmlbeAMAu9opvQ
	(envelope-from <stable+bounces-213352-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 07:08:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EFEE2300
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 07:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C8F2302BB84
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 06:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4178369979;
	Wed,  4 Feb 2026 06:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oGZRVQu8"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F45D367F21;
	Wed,  4 Feb 2026 06:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770185228; cv=none; b=n5M7TGEOMTxyzKD3b9yPKFWyytk04ZUWnI1Irrjf+IftmU0zDIIAOPUpVZx3xnmxKm1vIMvUnXcXg5cZGGn/CVhtIs2B6bh960lbVlSDAOZHR3Zzhq7+jgyPmcG5OfblcXRbqh/0vUtLDReEolxbpgrNNOYDcuoRS3+GdkYM5G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770185228; c=relaxed/simple;
	bh=Ugf/mfcgL38TO81Y5FYZYyUXhhIAUevpJU3HmkTWW/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R6A68SKEKK68lP6TA+xxY7D2S28TKPTrfijiGYwUXH5+MtHMvd3Ey7SUV78xBp8IRNCCljvl6fVD+8AacShevD9mbEQ8rMGBWrRKq0gm2wA5VG78gXSSx0nBadltlujyjrX8luVs5wGUORBqfPkVxYF+icjm8nHhQZ1iBM1ufJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oGZRVQu8; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+b
	V7JEMXDWpE9llLQMAl4mC4gYTL0RnElrO1W2hIK1M=; b=oGZRVQu849IRE+nmP/
	o8BzIGZJLWsCQp409/GBP5bri5m3k+5ib8n3fQqkCI8VRARAZOeyHc4UrCPef18/
	nSpGSbWinG7J3zjTFykwI/lMjUbOqIaUEJ6P2SPzy9azZjPxdibE+/ISc2ZyfRNa
	czEGg3UUklmgudnL7w1tQYEuY=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAXR73h4YJpOAKGKA--.5382S2;
	Wed, 04 Feb 2026 14:06:26 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>,
	syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com,
	Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 5.15.y] team: Move team device type change at the end of team_port_add
Date: Wed,  4 Feb 2026 14:06:24 +0800
Message-Id: <20260204060624.1367679-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXR73h4YJpOAKGKA--.5382S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF43Ww4fCryxKF45Kw4DArb_yoWrWw4rpF
	W3X3Z5tryDGay2gF93uw4jqF4Yq392ya42qry5tw1jk34YqryrAFWrtFy8KFy0kFWUCFWa
	qF4YvFs5Aw1jgF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMGQD9UUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC3QSsRmmC4eTCmgAA3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com,nvidia.com,kernel.org,163.com];
	TAGGED_FROM(0.00)[bounces-213352-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,a2a3b519de727b0f7903];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 40EFEE2300
X-Rspamd-Action: no action

From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>

[ Upstream commit 0ae9cfc454ea5ead5f3ddbdfe2e70270d8e2c8ef ]

Attempting to add a port device that is already up will expectedly fail,
but not before modifying the team device header_ops.

In the case of the syzbot reproducer the gre0 device is
already in state UP when it attempts to add it as a
port device of team0, this fails but before that
header_ops->create of team0 is changed from eth_header to ipgre_header
in the call to team_dev_type_check_change.

Later when we end up in ipgre_header() struct ip_tunnel* points to nonsense
as the private data of the device still holds a struct team.

Example sequence of iproute2 commands to reproduce the hang/BUG():
ip link add dev team0 type team
ip link add dev gre0 type gre
ip link set dev gre0 up
ip link set dev gre0 master team0
ip link set dev team0 up
ping -I team0 1.1.1.1

Move team_dev_type_check_change down where all other checks have passed
as it changes the dev type with no way to restore it in case
one of the checks that follow it fail.

Also make sure to preserve the origial mtu assignment:
  - If port_dev is not the same type as dev, dev takes mtu from port_dev
  - If port_dev is the same type as dev, port_dev takes mtu from dev

This is done by adding a conditional before the call to dev_set_mtu
to prevent it from assigning port_dev->mtu = dev->mtu and instead
letting team_dev_type_check_change assign dev->mtu = port_dev->mtu.
The conditional is needed because the patch moves the call to
team_dev_type_check_change past dev_set_mtu.

Testing:
  - team device driver in-tree selftests
  - Add/remove various devices as slaves of team device
  - syzbot

Reported-by: syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a2a3b519de727b0f7903
Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Link: https://patch.msgid.link/20251122002027.695151-1-zlatistiv@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 drivers/net/team/team.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index f866f7a4be31..af5dbdd8f138 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1181,10 +1181,6 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		return -EPERM;
 	}
 
-	err = team_dev_type_check_change(dev, port_dev);
-	if (err)
-		return err;
-
 	if (port_dev->flags & IFF_UP) {
 		NL_SET_ERR_MSG(extack, "Device is up. Set it down before adding it as a team port");
 		netdev_err(dev, "Device %s is up. Set it down before adding it as a team port\n",
@@ -1202,10 +1198,16 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	INIT_LIST_HEAD(&port->qom_list);
 
 	port->orig.mtu = port_dev->mtu;
-	err = dev_set_mtu(port_dev, dev->mtu);
-	if (err) {
-		netdev_dbg(dev, "Error %d calling dev_set_mtu\n", err);
-		goto err_set_mtu;
+	/*
+	 * MTU assignment will be handled in team_dev_type_check_change
+	 * if dev and port_dev are of different types
+	 */
+	if (dev->type == port_dev->type) {
+		err = dev_set_mtu(port_dev, dev->mtu);
+		if (err) {
+			netdev_dbg(dev, "Error %d calling dev_set_mtu\n", err);
+			goto err_set_mtu;
+		}
 	}
 
 	memcpy(port->orig.dev_addr, port_dev->dev_addr, port_dev->addr_len);
@@ -1280,6 +1282,10 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		}
 	}
 
+	err = team_dev_type_check_change(dev, port_dev);
+	if (err)
+		goto err_set_dev_type;
+
 	if (dev->flags & IFF_UP) {
 		netif_addr_lock_bh(dev);
 		dev_uc_sync_multiple(port_dev, dev);
@@ -1298,6 +1304,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 
 	return 0;
 
+err_set_dev_type:
 err_set_slave_promisc:
 	__team_option_inst_del_port(team, port);
 
-- 
2.34.1


