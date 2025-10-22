Return-Path: <stable+bounces-189042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B82BFE6E5
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 00:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390643A56BD
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 22:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423D327F01B;
	Wed, 22 Oct 2025 22:36:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317F2295516
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761172596; cv=none; b=EkyZdT9fGnbB/tFcndcTeQ0ky8sffDZx2bZrHvnjNkdjC6sEAacBX0N8yRn24+9gobwcoY4nSoyACKOGQTddB7+gQhW1aRoVXXgUtqUQyve/qc0uQh0sDU3jy3BKL8PB9WPelmphrJGFyoXkPgysXAGfWIBkzph3rs1afOavme8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761172596; c=relaxed/simple;
	bh=1viVxlVljlhWpxer5DUpIVF9HCJ7b85XBeqsv15ioH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YtTBxzaMcJubPcDWCHtCZLgzIh2N4aCc9sairf2QyB4X9BgLm76/j8T5u7WGItcdaea4EmOmOngpR+cIN1OiD/KrFVABE91W26CBh9jkW3fwPNoPUFJtmuKERKQhMPp7H9zy0H1Ux6eRUMQBbaipXdcVbW/iY5kr87Xlu1CU6pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 360272333A;
	Thu, 23 Oct 2025 01:36:29 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 6.1.y] net: mctp: Don't access ifa_index when missing
Date: Thu, 23 Oct 2025 01:36:27 +0300
Message-Id: <20251022223627.216402-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Johnston <matt@codeconstruct.com.au>

commit f11cf946c0a92c560a890d68e4775723353599e1 upstream.

In mctp_dump_addrinfo, ifa_index can be used to filter interfaces, but
only when the struct ifaddrmsg is provided. Otherwise it will be
comparing to uninitialised memory - reproducible in the syzkaller case from
dhcpd, or busybox "ip addr show".

The kernel MCTP implementation has always filtered by ifa_index, so
existing userspace programs expecting to dump MCTP addresses must
already be passing a valid ifa_index value (either 0 or a real index).

BUG: KMSAN: uninit-value in mctp_dump_addrinfo+0x208/0xac0 net/mctp/device.c:128
 mctp_dump_addrinfo+0x208/0xac0 net/mctp/device.c:128
 rtnl_dump_all+0x3ec/0x5b0 net/core/rtnetlink.c:4380
 rtnl_dumpit+0xd5/0x2f0 net/core/rtnetlink.c:6824
 netlink_dump+0x97b/0x1690 net/netlink/af_netlink.c:2309

Fixes: 583be982d934 ("mctp: Add device handling and netlink interface")
Reported-by: syzbot+e76d52dadc089b9d197f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68135815.050a0220.3a872c.000e.GAE@google.com/
Reported-by: syzbot+1065a199625a388fce60@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/681357d6.050a0220.14dd7d.000d.GAE@google.com/
Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
Link: https://patch.msgid.link/20250508-mctp-addr-dump-v2-1-c8a53fd2dd66@codeconstruct.com.au
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ kovalev: bp to fix CVE-2025-38006 ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 net/mctp/device.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/mctp/device.c b/net/mctp/device.c
index 85cc5f31f1e7..27aee8b04055 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -119,12 +119,19 @@ static int mctp_dump_addrinfo(struct sk_buff *skb, struct netlink_callback *cb)
 	struct net_device *dev;
 	struct ifaddrmsg *hdr;
 	struct mctp_dev *mdev;
-	int ifindex;
+	int ifindex = 0;
 	int idx = 0, rc;
 
-	hdr = nlmsg_data(cb->nlh);
-	// filter by ifindex if requested
-	ifindex = hdr->ifa_index;
+	/* Filter by ifindex if a header is provided */
+	if (cb->nlh->nlmsg_len >= nlmsg_msg_size(sizeof(*hdr))) {
+		hdr = nlmsg_data(cb->nlh);
+		ifindex = hdr->ifa_index;
+	} else {
+		if (cb->strict_check) {
+			NL_SET_ERR_MSG(cb->extack, "mctp: Invalid header for addr dump request");
+			return -EINVAL;
+		}
+	}
 
 	rcu_read_lock();
 	for (; mcb->h < NETDEV_HASHENTRIES; mcb->h++, mcb->idx = 0) {
-- 
2.50.1


