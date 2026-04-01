Return-Path: <stable+bounces-232631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO/qJi9rzGlXSwYAu9opvQ
	(envelope-from <stable+bounces-232631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:47:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E30B373470
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B575A30265AC
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 00:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263591D8E01;
	Wed,  1 Apr 2026 00:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="0WJGfLsX"
X-Original-To: stable@vger.kernel.org
Received: from smtp134-25.sina.com.cn (smtp134-25.sina.com.cn [180.149.134.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F191C861D
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775004295; cv=none; b=mNjluLK/b6v6sy3JuT5UMqt9cpkSGugi9ybF6+1h7fsA09P/kZhI8//7S8U0bf5cXFnAsbiGepgK6JyLYNe4yMggV7F1iYZ0EMlXY8B20FjzA+Gq+hLkN0kAsEX0HwNcLOCSTCKxUtbEVDEylJCKgBXC40Y27us6A9m18ekYihY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775004295; c=relaxed/simple;
	bh=mfVsPU2KaYdGU78yOA9MOerup3tdd4QHuKBumFu6460=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DLIjPSImLx97f3/2iYiDQLO0sIPprcjKcvAAE9eFK08IXY7lrkFKi5sqh+odOcHakRu0l6de1/3ljB7yiKxG8wSjB/5YhMOflB2cgAdRoQe+88COeUgGV/lqw6O15lj8edC5SEhyGVVLNY4tsoUgm38PbApRAAdih8C6pmPZUMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=0WJGfLsX; arc=none smtp.client-ip=180.149.134.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1775004289;
	bh=j6UEnK7coCyYu5WAGKM8DDkqKJIpGKfRXgUFV6o7BlY=;
	h=From:Subject:Date:Message-Id;
	b=0WJGfLsXx3FxXCa1qVB0Cmf8seN4jtfrPWNEb9rInyQgWTPV4I4xLO6XIlE5W5Z/s
	 GF4MhMLZwU5WCA83uBZ5hD31+z9RAo8UgAjK2tFKkrqCAG+wI16McJQ8XOuO1O0dcz
	 yLOWWwngypEx5vrCjc9kE7R6qAnCgVTw7TDNvysg=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.21) with ESMTP
	id 69CC6A7C00002F3B; Wed, 1 Apr 2026 08:44:46 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 5084753408296
X-SMAIL-UIID: 79060A47AE414EB29236CC80D3EE0CDC-20260401-084446-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Matt Johnston <matt@codeconstruct.com.au>,
	syzbot+e76d52dadc089b9d197f@syzkaller.appspotmail.com,
	syzbot+1065a199625a388fce60@syzkaller.appspotmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 5.15.y] net: mctp: Don't access ifa_index when missing
Date: Wed,  1 Apr 2026 08:44:41 +0800
Message-Id: <20260401004441.3928950-1-johnny_haocn@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,codeconstruct.com.au,syzkaller.appspotmail.com,kernel.org,sina.com];
	TAGGED_FROM(0.00)[bounces-232631-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnny_haocn@sina.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sina.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,e76d52dadc089b9d197f,1065a199625a388fce60];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,msgid.link:url,sina.com:dkim,sina.com:email,sina.com:mid,codeconstruct.com.au:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E30B373470
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Matt Johnston <matt@codeconstruct.com.au>

[ Upstream commit f11cf946c0a92c560a890d68e4775723353599e1 ]

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
[ The context change is due to the commit 2d45eeb7d5d7
("mctp: no longer rely on net->dev_index_head[]") in v6.14
which is irrelevant to the logic of this patch. ]
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
---
 net/mctp/device.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/mctp/device.c b/net/mctp/device.c
index c00a2550e2e0..aec7ffad2666 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -99,12 +99,19 @@ static int mctp_dump_addrinfo(struct sk_buff *skb, struct netlink_callback *cb)
 	struct net_device *dev;
 	struct ifaddrmsg *hdr;
 	struct mctp_dev *mdev;
-	int ifindex;
-	int idx, rc;
-
-	hdr = nlmsg_data(cb->nlh);
-	// filter by ifindex if requested
-	ifindex = hdr->ifa_index;
+	int idx;
+	int ifindex = 0, rc;
+
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
2.34.1


