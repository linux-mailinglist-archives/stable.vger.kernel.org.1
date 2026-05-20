Return-Path: <stable+bounces-252787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMegLzYEDmqs5QUAu9opvQ
	(envelope-from <stable+bounces-252787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:57:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF375977A5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7574439E71BA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDC4371048;
	Wed, 20 May 2026 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bUhUyIp8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6903D7D67;
	Wed, 20 May 2026 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301590; cv=none; b=uc91dv7Rr2jX0wcu7+sN0Jq/dKnc0ywn3fEnf22SYVG0z2TAwoHLJmwt7TPi15ojrxkS9bBxGHnpS0hTzYSPlF5rExoNIqIGcaViRNuYy/av6+JpCkpF8pANvGq3ZmImt3uzV4CojhhjkFKN5sxcHQdUosIMAP8N7kacSj8S0vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301590; c=relaxed/simple;
	bh=utJVPP4lNKPgiQPW9N0GgwD/R8egImgv9GVa7DQd87A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRTqScSNg/E2m6FBZzk3j0W8+YiMeP87rTESSUMddMOIP3PB3cVF8e+D6Mm/BZQ98HBkXJh9Ne6PUNILXgFXbfBwGjKfnz4cyXdMHnu60k/nGYJXQD2EzyTiijEpNEJnfZfJveSId6u4W5h7j71WsDbHoY7OJ/RFk4zWSoQ5+6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bUhUyIp8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664201F000E9;
	Wed, 20 May 2026 18:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301588;
	bh=1fqSg8Gvs826Fp0Jrj9oJ6O+5AjLu1wcN4BofoyWPkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bUhUyIp81De6aGe0ulVCvwHrWr4wcgMci5Fr/m4pB3HsnJCmAVSWL6kKLB9VySa3i
	 y8r5WpTz+c6h46WxRNmYEuWrD38K+Jy2IybhAK2N2G57RCObtT9ZagIURaPPEg4qfq
	 nMWylh7C0y3oQzkrtc9indFec0hiptZTeaQw/SuM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 571/666] bareudp: fix NULL pointer dereference in bareudp_fill_metadata_dst()
Date: Wed, 20 May 2026 18:23:02 +0200
Message-ID: <20260520162123.644918825@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252787-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,asu.edu,gmail.com,google.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,asu.edu:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 0DF375977A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Weiming Shi <bestswngs@gmail.com>

[ Upstream commit aa6c6d9ee064aabfede4402fd1283424e649ca19 ]

bareudp_fill_metadata_dst() passes bareudp->sock to
udp_tunnel6_dst_lookup() in the IPv6 path without a NULL check.
The socket is only created in bareudp_open() and NULLed in
bareudp_stop(), so calling this function while the device is down
triggers a NULL dereference via sock->sk.

 BUG: kernel NULL pointer dereference, address: 0000000000000018
 RIP: 0010:udp_tunnel6_dst_lookup (net/ipv6/ip6_udp_tunnel.c:160)
 Call Trace:
  <TASK>
  bareudp_fill_metadata_dst (drivers/net/bareudp.c:532)
  do_execute_actions (net/openvswitch/actions.c:901)
  ovs_execute_actions (net/openvswitch/actions.c:1589)
  ovs_packet_cmd_execute (net/openvswitch/datapath.c:700)
  genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)
  genl_rcv_msg (net/netlink/genetlink.c:1209)
  netlink_rcv_skb (net/netlink/af_netlink.c:2550)
  </TASK>

Add a NULL check returning -ESHUTDOWN, consistent with the xmit paths
in the same driver.

Fixes: 571912c69f0e ("net: UDP tunnel encapsulation module for tunnelling different protocols like MPLS, IP, NSH etc.")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260426165350.1663137-2-bestswngs@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bareudp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index fa2dd76ba3d9e..8d6b632371f89 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -528,6 +528,9 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 		struct in6_addr saddr;
 		struct socket *sock = rcu_dereference(bareudp->sock);
 
+		if (!sock)
+			return -ESHUTDOWN;
+
 		dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock,
 					     0, &saddr, &info->key,
 					     sport, bareudp->port, info->key.tos,
-- 
2.53.0




