Return-Path: <stable+bounces-237013-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLqyLiof3WmsaAkAu9opvQ
	(envelope-from <stable+bounces-237013-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:51:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3AC3F006D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 046A63014923
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1422EBB8C;
	Mon, 13 Apr 2026 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UN5wjk3l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53F624E4A1;
	Mon, 13 Apr 2026 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098365; cv=none; b=jntdd9TN2JzFiLVtHxkYiK/NILhE2fJu41uRyfISnS0Tw36Qq81NJpAoFFo645WZvvScE/af+C/e34xpkeOBkCurZQop6RA60xiYre0lMfMDkavSmq3GFDDPbgGscJ06bXm3lXS82asivuSpt/D/YU67QX5kKef9RhdlqTSmapg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098365; c=relaxed/simple;
	bh=U71P5GufQDHv47s+sunhcmd30uFEazj4kOx8GHndY0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJK17bFyC0GaeZyfqRfwwGtKcHaUM/L8BUEMXsrqKX6BRSlD27clljYN6Omqg2OoId8vZ+TGgRkloOkcI1NnChFTPUddqZh9GbvG5VCnQMWw1o0GkK36GM3PxmzdeEjFFYRcMLilZMzfv3AgOf8RUZjI/I/RrS2G4E3mz4wiIjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UN5wjk3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78532C2BCAF;
	Mon, 13 Apr 2026 16:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098364;
	bh=U71P5GufQDHv47s+sunhcmd30uFEazj4kOx8GHndY0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UN5wjk3lwOhWjRzQFgxGmFpOxtKd3kolV7b3m5I4ZqzultTI/FnyuqcyK4w0hWRz+
	 Wwp6Mq+vVdDXdkhKJNQm1RXujMJk3NK8HxMZP+L5Eo+glZBylWj9BSZpQ1W6UMQeKX
	 l48W9cbPPWsc1rbZpKS+oJco2yM43g2+y/lpQDWs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+e76d52dadc089b9d197f@syzkaller.appspotmail.com,
	syzbot+1065a199625a388fce60@syzkaller.appspotmail.com,
	Matt Johnston <matt@codeconstruct.com.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Johnny Hao <johnny_haocn@sina.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 496/570] net: mctp: Dont access ifa_index when missing
Date: Mon, 13 Apr 2026 18:00:27 +0200
Message-ID: <20260413155849.037731314@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-237013-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,codeconstruct.com.au,kernel.org,sina.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,e76d52dadc089b9d197f,1065a199625a388fce60];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,sina.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: BD3AC3F006D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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

[ The context change is due to the commit 2d45eeb7d5d7
("mctp: no longer rely on net->dev_index_head[]") in v6.14
which is irrelevant to the logic of this patch. ]

Fixes: 583be982d934 ("mctp: Add device handling and netlink interface")
Reported-by: syzbot+e76d52dadc089b9d197f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68135815.050a0220.3a872c.000e.GAE@google.com/
Reported-by: syzbot+1065a199625a388fce60@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/681357d6.050a0220.14dd7d.000d.GAE@google.com/
Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
Link: https://patch.msgid.link/20250508-mctp-addr-dump-v2-1-c8a53fd2dd66@codeconstruct.com.au
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mctp/device.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/mctp/device.c b/net/mctp/device.c
index c00a2550e2e0e..aec7ffad2666a 100644
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
2.53.0




