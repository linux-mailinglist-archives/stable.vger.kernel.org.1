Return-Path: <stable+bounces-213945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIYgMONpg2kbmgMAu9opvQ
	(envelope-from <stable+bounces-213945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:46:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29517E957B
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86589312DD2C
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA44423169;
	Wed,  4 Feb 2026 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S48Al8qO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2353423178;
	Wed,  4 Feb 2026 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218041; cv=none; b=LtInFQ1ooujAtSRoxaM89hi0am0/sraHdur+ZObqECawNAioVPncCAM0i/22DoTqxPIlgyQsFjO5tK3dWKyAtwt/aLlyBlAY4rKY4K3fWBmJ11ACSPwAV90Ub+AgUmFCKQG3dn/yJxFQ7VNCB9MApgeyYqVcjCWejt0wBgNudxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218041; c=relaxed/simple;
	bh=3Ruc6bzFcwkyNZrNMD7oR30PYjjGw5w3XwPrUlmFmNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9dH6WYDb2DEFa+1iXbbr+TMG2kE33q9n9Dp/Uu3X8v40r6hzBdm0UeB5ifh1m4sNgks4enqUuFEXRmczCf0j0WVWOWpycJ1Sz1nFsrBPXeH0uidVHfDtQQvXQ0TDwmZrVCYpV6kHl24noEZav5LZWABjfF1FM4rHkonDCk/ngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S48Al8qO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31463C4CEF7;
	Wed,  4 Feb 2026 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218041;
	bh=3Ruc6bzFcwkyNZrNMD7oR30PYjjGw5w3XwPrUlmFmNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S48Al8qOdas4dK/1ixQn2Pws8k+ouLhJN2jg0nQ+el8kJ89C5bMZdA9ScSpVZGPle
	 Sn4il4PNK7HBMtH4tm6ywf4DPHae6XL7Jj2pI90srYPgEHf8sF8I27V+iNq8vBWQ8y
	 BoNOJyELBgKgXvCghmslwISJhamMkIFk+J8wWMWI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 193/280] ipv6: use the right ifindex when replying to icmpv6 from localhost
Date: Wed,  4 Feb 2026 15:39:27 +0100
Message-ID: <20260204143916.553494945@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-213945-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 29517E957B
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fernando Fernandez Mancera <fmancera@suse.de>

[ Upstream commit 03cbcdf93866e61beb0063392e6dbb701f03aea2 ]

When replying to a ICMPv6 echo request that comes from localhost address
the right output ifindex is 1 (lo) and not rt6i_idev dev index. Use the
skb device ifindex instead. This fixes pinging to a local address from
localhost source address.

$ ping6 -I ::1 2001:1:1::2 -c 3
PING 2001:1:1::2 (2001:1:1::2) from ::1 : 56 data bytes
64 bytes from 2001:1:1::2: icmp_seq=1 ttl=64 time=0.037 ms
64 bytes from 2001:1:1::2: icmp_seq=2 ttl=64 time=0.069 ms
64 bytes from 2001:1:1::2: icmp_seq=3 ttl=64 time=0.122 ms

2001:1:1::2 ping statistics
3 packets transmitted, 3 received, 0% packet loss, time 2032ms
rtt min/avg/max/mdev = 0.037/0.076/0.122/0.035 ms

Fixes: 1b70d792cf67 ("ipv6: Use rt6i_idev index for echo replies to a local address")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20260121194409.6749-1-fmancera@suse.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/icmp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 7d88fd314c390..7ba3c642ab3c3 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -765,7 +765,9 @@ static void icmpv6_echo_reply(struct sk_buff *skb)
 	fl6.daddr = ipv6_hdr(skb)->saddr;
 	if (saddr)
 		fl6.saddr = *saddr;
-	fl6.flowi6_oif = icmp6_iif(skb);
+	fl6.flowi6_oif = ipv6_addr_loopback(&fl6.daddr) ?
+			 skb->dev->ifindex :
+			 icmp6_iif(skb);
 	fl6.fl6_icmp_type = type;
 	fl6.flowi6_mark = mark;
 	fl6.flowi6_uid = sock_net_uid(net, NULL);
-- 
2.51.0




