Return-Path: <stable+bounces-252637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCaEELj8DWok5QUAu9opvQ
	(envelope-from <stable+bounces-252637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:26:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EC65961ED
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC90030D4FEE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEC53F23C5;
	Wed, 20 May 2026 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xYBSFNNb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990EB347515;
	Wed, 20 May 2026 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301197; cv=none; b=M7VRlO2ySJrgHAGdCU7uMUjOZUKPoIgoKgWOFF1DIFHntF9Du1SE+DLY1BzdtDO5G2UuODIwXuLxgySFQlx9zn08fpEu31CgPYOtrZiA7mPk8m2zf6HbdAo1/rk6QtIDkHOFWlsCvbB84k30WDkNylhrE/D6zw1mbFTQyvWazZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301197; c=relaxed/simple;
	bh=3ElX9vmnrk5Yz4DEM8+bQlCgUWLfvTwTsYDO18oX/m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnjH/OGBY3MHPF92f+XNZ1TRs5xExB0nWKH3Re8zABdPbai5ZR9iH8xA+OmPTKn2QAUu0SIhNJ8C8euXJyhfA6cGwnXeouGAdSdlIVYnGpAC2JUIGO6zjyBqL7npNsW70UwJs5/jcOWd5i7qNHjRzXsggMugB9zQHiabl1c4t14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xYBSFNNb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0271F000E9;
	Wed, 20 May 2026 18:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301196;
	bh=dcXQkmuSMWwWR3ponfDCHvZpZ2V6qZXW7z7LEoExF7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xYBSFNNbeM7he+20WwyRZeuW7NBxu+MbTCLkCMeL9uikey+TXRhcDtEHZzyLD49lL
	 MP+qb0/3emdiJq9HlJWT0zfnkl6h6pyeTN8g5FVaE47/GKSASfcvydEdu8dkYqGkNN
	 9+7iPqZoaGycf+WKJDp1hIRhyUJxgsU8if3f7hdE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Joe Damato <joe@dama.to>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 462/666] ipv6: fix possible UAF in icmpv6_rcv()
Date: Wed, 20 May 2026 18:21:13 +0200
Message-ID: <20260520162121.283509402@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252637-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: D5EC65961ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit f996edd7615e686ada141b7f3395025729ff8ccb ]

Caching saddr and daddr before pskb_pull() is problematic
since skb->head can change.

Remove these temporary variables:

- We only access &ipv6_hdr(skb)->saddr and &ipv6_hdr(skb)->daddr
  when net_dbg_ratelimited() is called in the slow path.

- Avoid potential future misuse after pskb_pull() call.

Fixes: 4b3418fba0fe ("ipv6: icmp: include addresses in debug messages")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Reviewed-by: Joe Damato <joe@dama.to>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20260416103505.2380753-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/icmp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 387400829b207..229ae205450d3 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -910,7 +910,6 @@ static int icmpv6_rcv(struct sk_buff *skb)
 	struct net *net = dev_net_rcu(skb->dev);
 	struct net_device *dev = icmp6_dev(skb);
 	struct inet6_dev *idev = __in6_dev_get(dev);
-	const struct in6_addr *saddr, *daddr;
 	struct icmp6hdr *hdr;
 	u8 type;
 
@@ -941,12 +940,10 @@ static int icmpv6_rcv(struct sk_buff *skb)
 
 	__ICMP6_INC_STATS(dev_net_rcu(dev), idev, ICMP6_MIB_INMSGS);
 
-	saddr = &ipv6_hdr(skb)->saddr;
-	daddr = &ipv6_hdr(skb)->daddr;
-
 	if (skb_checksum_validate(skb, IPPROTO_ICMPV6, ip6_compute_pseudo)) {
 		net_dbg_ratelimited("ICMPv6 checksum failed [%pI6c > %pI6c]\n",
-				    saddr, daddr);
+				    &ipv6_hdr(skb)->saddr,
+				    &ipv6_hdr(skb)->daddr);
 		goto csum_error;
 	}
 
@@ -1029,7 +1026,8 @@ static int icmpv6_rcv(struct sk_buff *skb)
 			break;
 
 		net_dbg_ratelimited("icmpv6: msg of unknown type [%pI6c > %pI6c]\n",
-				    saddr, daddr);
+				    &ipv6_hdr(skb)->saddr,
+				    &ipv6_hdr(skb)->daddr);
 
 		/*
 		 * error of unknown type.
-- 
2.53.0




