Return-Path: <stable+bounces-266369-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uPSYNN+bMWqCoAUAu9opvQ
	(envelope-from <stable+bounces-266369-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:54:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D91A6948F8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:54:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=EJI0MkEQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266369-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266369-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCAC7303CD5E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13F14779BF;
	Tue, 16 Jun 2026 18:54:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6EE3CC303;
	Tue, 16 Jun 2026 18:54:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636061; cv=none; b=oXSpB55VR+uO7TDU/hWgo4YzgrWOY+XsitrBNFoJ3yZb0U7Q4ZhTwi8VtbFar1VdeDjd4I8emjnfQsXe43s4msMjxipXirLq3LAA5m1dch5atJOkDDOqkL3FGwMKJREOmYZKousi/QXEGn3FFB5Jk4E5day+24J2o6hm5je5ixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636061; c=relaxed/simple;
	bh=kcxcSLBjzie0abp3QLTGX6cDmPq99aTOrYt9AS6rNIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YArB3Gsah1mjG95PxFWi0xILmCPtl0ZNJ7fBq1/baOPcyqccozmxMvNaVTHrHNwQZSqUPNdZein1+UoJT5P6wTUXQINWT5cXdTnQzOpyLpD30/eajkhjuc++Sxh7koUlKrg6Q68M9K8lE+CISEciqLxhMX2vOXXyvZCZY+JpBVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EJI0MkEQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F29A1F000E9;
	Tue, 16 Jun 2026 18:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781636060;
	bh=hGRbcdhQRVhpR/XYwMYXxK9n4n5qaHeg8RcgwAvGuVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EJI0MkEQcuVhnU+DRuRpVvStsrSU9X6FR2xoZ8mqADBOCoQTZyveibUP8+bemyD0T
	 +/BArzi3nWAie7u5DvLiBAxG6VeWUfKNwYcvfnjuEBRBPhxybappLysSqIJTkLk3m7
	 aeHWERxuT9tYe5a+sc6+alkXtk4u8Jpk8NmAP9vE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kyle Zeng <kylebot@openai.com>,
	Eric Dumazet <edumazet@google.com>,
	syzbot+6eb9ca986d80f6f88cf9@syzkaller.appspotmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 168/342] ipv6: sit: reload inner IPv6 header after GSO offloads
Date: Tue, 16 Jun 2026 20:27:44 +0530
Message-ID: <20260616145056.024084124@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266369-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kylebot@openai.com,m:edumazet@google.com,m:syzbot+6eb9ca986d80f6f88cf9@syzkaller.appspotmail.com,m:kuba@kernel.org,m:sashal@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,6eb9ca986d80f6f88cf9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,appspotmail.com:email,msgid.link:url,openai.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D91A6948F8

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kyle Zeng <kylebot@openai.com>

[ Upstream commit f0e42f0c4337b1f220de1ddd63f47197c7dee4de ]

ipip6_tunnel_xmit() caches the inner IPv6 header pointer at function
entry and continues using it after iptunnel_handle_offloads().

For GSO skbs, iptunnel_handle_offloads() calls skb_header_unclone().
When the skb header is cloned, skb_header_unclone() can call
pskb_expand_head(), which may move the skb head. The pskb_expand_head()
contract requires pointers into the skb header to be reloaded after the
call.

If the later skb_realloc_headroom() branch is not taken, SIT uses the
stale iph6 pointer to read the inner hop limit and DS field. That can
read from a freed skb head after the old head's remaining clone is
released.

Reload iph6 after the offload helper succeeds and before subsequent
reads from the inner IPv6 header. Keep the existing reload after
skb_realloc_headroom(), since that branch can also replace the skb.

Fixes: 14909664e4e1 ("sit: Setup and TX path for sit/UDP foo-over-udp encapsulation")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+6eb9ca986d80f6f88cf9@syzkaller.appspotmail.com
Link: https://patch.msgid.link/20260605073448.6524-1-kylebot@openai.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/sit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 9806bd56b95f12..387b48ba4aac71 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -964,6 +964,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 		ip_rt_put(rt);
 		goto tx_error;
 	}
+	iph6 = ipv6_hdr(skb);
 
 	if (df) {
 		mtu = dst_mtu(&rt->dst) - t_hlen;
-- 
2.53.0




