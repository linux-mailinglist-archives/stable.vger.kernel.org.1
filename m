Return-Path: <stable+bounces-219217-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOd+IZKdnmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219217-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:58:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C3B192A40
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0C9030B38AE
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00E82C21C4;
	Wed, 25 Feb 2026 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lYJNeMOw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631412C11D6;
	Wed, 25 Feb 2026 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002569; cv=none; b=SMSLvYl7iIuqDWQtFxvKCDnjzZLSZxjis71TyjHB+FNMRXTjOQNWickXd+MPakt6zzA3+5sl+797vapUkNB3lX4GNZXof0JpgKhlxHat+cSoDjNpr02aLTbbTriYwzfGIK1yX32va78f+63/XyyiZc1Ua0NQWeKUe7FJK0VsXuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002569; c=relaxed/simple;
	bh=AZT0/WdBUPk4dvLbppaHXQmSBIfXqWHG+vSLLIE19og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGjMhSGm/CNjm9dV7ftqvnRywn39hxY/9DldKDOmhs03cs4DUzkgIQ7YpbTeWtqPuWjNXCQ6y9C7/saWpM4Regy4UpuD3ZyLIZne/tllT1p4bFGqixIJ/5r1QusgQd23YryuOddf6cVH6szPr4uuNAwi1LLc38tWgeJM8LEuEvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lYJNeMOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C72BC4AF0E;
	Wed, 25 Feb 2026 06:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002569;
	bh=AZT0/WdBUPk4dvLbppaHXQmSBIfXqWHG+vSLLIE19og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lYJNeMOw0HdkrSZ3ZY4J7wTP99BYwxcru3ynHJhp9YWyy1THEaWlsMTMXWDPti42A
	 CxJJiUYW66zKcpDDUiguyirQj3+iHMG+a6g54I9OPOPVxChHij/j0KeJKZYqxrJfGk
	 eMiKLMBLo/obIRgjWpLSbvGapVWxhA8h3ewfgs2c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 302/641] inet: RAW sockets using IPPROTO_RAW MUST drop incoming ICMP
Date: Tue, 24 Feb 2026 17:20:28 -0800
Message-ID: <20260225012356.063796219@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219217-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,tsinghua.edu.cn:email]
X-Rspamd-Queue-Id: D9C3B192A40
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit c89477ad79446867394360b29bb801010fc3ff22 ]

Yizhou Zhao reported that simply having one RAW socket on protocol
IPPROTO_RAW (255) was dangerous.

  socket(AF_INET, SOCK_RAW, 255);

A malicious incoming ICMP packet can set the protocol field to 255
and match this socket, leading to FNHE cache changes.

inner = IP(src="192.168.2.1", dst="8.8.8.8", proto=255)/Raw("TEST")
pkt = IP(src="192.168.1.1", dst="192.168.2.1")/ICMP(type=3, code=4, nexthopmtu=576)/inner

"man 7 raw" states:

  A protocol of IPPROTO_RAW implies enabled IP_HDRINCL and is able
  to send any IP protocol that is specified in the passed header.
  Receiving of all IP protocols via IPPROTO_RAW is not possible
  using raw sockets.

Make sure we drop these malicious packets.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Link: https://lore.kernel.org/netdev/20251109134600.292125-1-zhaoyz24@mails.tsinghua.edu.cn/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20260203192509.682208-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/icmp.c | 14 ++++++++++----
 net/ipv6/icmp.c |  6 ++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 1b7fb5d935edf..8e10e9e7676c5 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -843,16 +843,22 @@ static void icmp_socket_deliver(struct sk_buff *skb, u32 info)
 	/* Checkin full IP header plus 8 bytes of protocol to
 	 * avoid additional coding at protocol handlers.
 	 */
-	if (!pskb_may_pull(skb, iph->ihl * 4 + 8)) {
-		__ICMP_INC_STATS(dev_net_rcu(skb->dev), ICMP_MIB_INERRORS);
-		return;
-	}
+	if (!pskb_may_pull(skb, iph->ihl * 4 + 8))
+		goto out;
+
+	/* IPPROTO_RAW sockets are not supposed to receive anything. */
+	if (protocol == IPPROTO_RAW)
+		goto out;
 
 	raw_icmp_error(skb, protocol, info);
 
 	ipprot = rcu_dereference(inet_protos[protocol]);
 	if (ipprot && ipprot->err_handler)
 		ipprot->err_handler(skb, info);
+	return;
+
+out:
+	__ICMP_INC_STATS(dev_net_rcu(skb->dev), ICMP_MIB_INERRORS);
 }
 
 static bool icmp_tag_validation(int proto)
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index cf6455cbe2cc9..306eec18e82c1 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -870,6 +870,12 @@ enum skb_drop_reason icmpv6_notify(struct sk_buff *skb, u8 type,
 	if (reason != SKB_NOT_DROPPED_YET)
 		goto out;
 
+	if (nexthdr == IPPROTO_RAW) {
+		/* Add a more specific reason later ? */
+		reason = SKB_DROP_REASON_NOT_SPECIFIED;
+		goto out;
+	}
+
 	/* BUGGG_FUTURE: we should try to parse exthdrs in this packet.
 	   Without this we will not able f.e. to make source routed
 	   pmtu discovery.
-- 
2.51.0




