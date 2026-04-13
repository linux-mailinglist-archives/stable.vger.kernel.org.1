Return-Path: <stable+bounces-236957-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oO7QJ3Ye3WmSaAkAu9opvQ
	(envelope-from <stable+bounces-236957-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:48:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4A93EFDD2
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FDEB3027DA4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD41307AC7;
	Mon, 13 Apr 2026 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zgv2h6zb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFEE2D8364;
	Mon, 13 Apr 2026 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098225; cv=none; b=Y8z3UdI10/+uZNtIi7Szq+vkQDRUUMAMzvNFAbQYcyNf9KZwyDrm7wMuGxxz4N/Bi9t7qGQvbV0CAIM8fqHuYMWtKvT0BluU2MY2F8y6d/E60cy/dinl7NuTcFnZx5/xNvYdWHCgBbwcKBSoUmJKto4uNHqjxe5PVa+XRqVf2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098225; c=relaxed/simple;
	bh=cPJJLlOvduWChpF9prrap1Zb5JmjxMsn/pW5UbPvxFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwReo3nCzF5TteHYQZ62uzRiLFycYXjRqosspKTYAp86WU+ufSu6/tvOMIUi02rIK6NgH/77QcRi1PdLjolJoJEXgTSw0y4RGn1xTJ+SXCPnQ6pfSLzMnXp276VAFgJeMEvNKg92sHGe9Z2cOXjceGhIZR7zWvDGRaLb6gUVpoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zgv2h6zb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61263C2BCAF;
	Mon, 13 Apr 2026 16:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098225;
	bh=cPJJLlOvduWChpF9prrap1Zb5JmjxMsn/pW5UbPvxFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zgv2h6zbI3tJisrZOSbajFsYZUXRQzPBazeFJZl/srxdQBSjLTNDHCXHKnhFpMjV7
	 m4GbWkNUBoQA+cpcYoYtrvBENaoe4J1hUePrH/hYdFAMzRpXldh+e76tCyP2zbkgSh
	 D3HpYZeNhBfZOXx3js/3wvclJVDzDElnR9v4/Kek=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oskar Kjos <oskar.kjos@hotmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 410/570] ip6_tunnel: clear skb2->cb[] in ip4ip6_err()
Date: Mon, 13 Apr 2026 17:59:01 +0200
Message-ID: <20260413155845.825998868@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,hotmail.com,google.com,nvidia.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-236957-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,nvidia.com:email]
X-Rspamd-Queue-Id: 0E4A93EFDD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 2edfa31769a4add828a7e604b21cb82aaaa05925 ]

Oskar Kjos reported the following problem.

ip4ip6_err() calls icmp_send() on a cloned skb whose cb[] was written
by the IPv6 receive path as struct inet6_skb_parm. icmp_send() passes
IPCB(skb2) to __ip_options_echo(), which interprets that cb[] region
as struct inet_skb_parm (IPv4). The layouts differ: inet6_skb_parm.nhoff
at offset 14 overlaps inet_skb_parm.opt.rr, producing a non-zero rr
value. __ip_options_echo() then reads optlen from attacker-controlled
packet data at sptr[rr+1] and copies that many bytes into dopt->__data,
a fixed 40-byte stack buffer (IP_OPTIONS_DATA_FIXED_SIZE).

To fix this we clear skb2->cb[], as suggested by Oskar Kjos.

Also add minimal IPv4 header validation (version == 4, ihl >= 5).

Fixes: c4d3efafcc93 ("[IPV6] IP6TUNNEL: Add support to IPv4 over IPv6 tunnel.")
Reported-by: Oskar Kjos <oskar.kjos@hotmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20260326155138.2429480-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_tunnel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 7c1b5d01f8203..53930c28b6946 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -603,11 +603,16 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	if (!skb2)
 		return 0;
 
+	/* Remove debris left by IPv6 stack. */
+	memset(IPCB(skb2), 0, sizeof(*IPCB(skb2)));
+
 	skb_dst_drop(skb2);
 
 	skb_pull(skb2, offset);
 	skb_reset_network_header(skb2);
 	eiph = ip_hdr(skb2);
+	if (eiph->version != 4 || eiph->ihl < 5)
+		goto out;
 
 	/* Try to guess incoming interface */
 	rt = ip_route_output_ports(dev_net(skb->dev), &fl4, NULL, eiph->saddr,
-- 
2.53.0




