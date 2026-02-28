Return-Path: <stable+bounces-220362-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNlTIH8zo2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220362-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:27:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CD01C5CE9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABC8931F13E0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719A6348875;
	Sat, 28 Feb 2026 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oogm0o/5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3322739FEAB;
	Sat, 28 Feb 2026 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300259; cv=none; b=uzrqLIKG0u00YRqGG6utPCtHsxUBTp8Txp8quCrxaV71Lz3gVF/o2qvGf1GcFSLeWtLvMg3wixQxZ/mxLb3yPoGz7+zu3/GwirU0UBGKkdpt/EJ4O5QqOqmEpbjRmdMhyRMZPszVL3bCAHBcMOzDOMuVVw/u7vaWmTfMbcDmNL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300259; c=relaxed/simple;
	bh=tXbNfB7hO5F8+9n9dk0VgnOyhPu7iYznsXMvifmgdsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrghWg5FoxJBBEcXZyWm61nFI/dhKaZJEBgzz+GJM8uSuvo4IMTjzaYMtYQQXTleqBzBOfga+Vuv/V2wyHaM2tPl1KRYo7g6dFlcIEGlZkf3LRE8md4ynp+qLFftYUAGSPc3DuL3irR2v8B6ZuVSvLgo8yXnBry00791lts/YXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oogm0o/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BFBC116D0;
	Sat, 28 Feb 2026 17:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300259;
	bh=tXbNfB7hO5F8+9n9dk0VgnOyhPu7iYznsXMvifmgdsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oogm0o/5Fzus8glYH4cNFR4rQTpyLqIetbLVBkReBd05jQoKEI6ql777C2gCCoAwe
	 zPBgGXUZF51QZUNyoJxWuvtlhf8RXhVx7W2Ibwsn9sbU02FZw0/OMehaOAbSvkHQGL
	 GL39WiHBeTS6byvQwmhJMKUOEAKukeMCNCJMhTtTaH3opXVfHbaCWwEFYsjoDn/4OP
	 Ya539hGSSgFzsqUdq90ObOG6y5yDsX795txBUeoRcoEvBaShVW0kkceDhEnvO07ElI
	 +u8ODZzfmozR/QA/yDu1CPkbIunH4XPLeEGWxD4K4Ogqv2k18v0SmZcpQbtNblU2AM
	 YSY9SsV8J/vIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 284/844] ipv6: annotate data-races over sysctl.flowlabel_reflect
Date: Sat, 28 Feb 2026 12:23:17 -0500
Message-ID: <20260228173244.1509663-285-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220362-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 36CD01C5CE9
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 5ade47c974b46eb2a1279185962a0ffa15dc5450 ]

Add missing READ_ONCE() when reading ipv6.sysctl.flowlabel_reflect,
as its value can be changed under us.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260115094141.3124990-6-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/af_inet6.c | 4 ++--
 net/ipv6/icmp.c     | 3 ++-
 net/ipv6/tcp_ipv6.c | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index d3534bdb805da..56d453a598ec6 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -224,8 +224,8 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	inet6_set_bit(MC6_LOOP, sk);
 	inet6_set_bit(MC6_ALL, sk);
 	np->pmtudisc	= IPV6_PMTUDISC_WANT;
-	inet6_assign_bit(REPFLOW, sk, net->ipv6.sysctl.flowlabel_reflect &
-				     FLOWLABEL_REFLECT_ESTABLISHED);
+	inet6_assign_bit(REPFLOW, sk, READ_ONCE(net->ipv6.sysctl.flowlabel_reflect) &
+				      FLOWLABEL_REFLECT_ESTABLISHED);
 	sk->sk_ipv6only	= net->ipv6.sysctl.bindv6only;
 	sk->sk_txrehash = READ_ONCE(net->core.sysctl_txrehash);
 
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 55b1aa75ab802..0f41ca6f3d83e 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -953,7 +953,8 @@ static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 	tmp_hdr.icmp6_type = type;
 
 	memset(&fl6, 0, sizeof(fl6));
-	if (net->ipv6.sysctl.flowlabel_reflect & FLOWLABEL_REFLECT_ICMPV6_ECHO_REPLIES)
+	if (READ_ONCE(net->ipv6.sysctl.flowlabel_reflect) &
+	    FLOWLABEL_REFLECT_ICMPV6_ECHO_REPLIES)
 		fl6.flowlabel = ip6_flowlabel(ipv6_hdr(skb));
 
 	fl6.flowi6_proto = IPPROTO_ICMPV6;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 280fe59785598..4ae664b05fa91 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1085,7 +1085,8 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
 			txhash = inet_twsk(sk)->tw_txhash;
 		}
 	} else {
-		if (net->ipv6.sysctl.flowlabel_reflect & FLOWLABEL_REFLECT_TCP_RESET)
+		if (READ_ONCE(net->ipv6.sysctl.flowlabel_reflect) &
+		    FLOWLABEL_REFLECT_TCP_RESET)
 			label = ip6_flowlabel(ipv6h);
 	}
 
-- 
2.51.0


