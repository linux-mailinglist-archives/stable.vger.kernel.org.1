Return-Path: <stable+bounces-258204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH7AMhAmG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-258204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:01:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B699610D8D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4A2430C46E3
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F830342CA7;
	Sat, 30 May 2026 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x9/u0hL7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7093F261B9E;
	Sat, 30 May 2026 17:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163562; cv=none; b=H5ZDeCPCy7FHXzv9B5Z+QaSFF6wzcxcqoqW/epLYI2VtHaQco4/clLRRPeom2wjmGObx0+TCFWaajJDbvkY6/PDlMYi0UZgMDqP2rvVy+leR7LUiABs68zvf+1D+TtY8CyqssH2M+Qu31sZMti5oHJ8vttzfqopkNr/lLfaOA7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163562; c=relaxed/simple;
	bh=pemr5yaiuuOmg8GHUxZhM/xklpCDlxJKaTCzUNC71to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvISp5uaexPBBaZrr5SCMz+uz+/Aigw1xoQX5DdTmfQ+khyxBEVIabuDxOj0c917whuyUzFsEcxponH8B+QSTxXAujJWYKFSKpybjIZvVNhjmWTFY3QKqbChmgKP+FwtblnEIjK/f+AZgS/KSbEyMLWdsRNwHvUJPi7Og0gOTdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x9/u0hL7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B573A1F00893;
	Sat, 30 May 2026 17:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163561;
	bh=dbROgYu1NheMRhyo+6MT1mY801AKVTDqel/fIo95Wa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=x9/u0hL7Ez9q53dBOHYpwv+avTGtIUp34QW5E3/KKgoMlbiTfkIe4MNqTvbj3HjQP
	 7z/otrbp4ExhyUNW6w5SkOXMGotiVlSZhORLY5ufW5PdLp0HV/4UiAzjOFtA5LaimQ
	 6Wfh3WS8eB2XedE7PRMKBL004D2g700n16WbSMQY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 266/776] ipv6: rpl: reserve mac_len headroom when recompressed SRH grows
Date: Sat, 30 May 2026 17:59:40 +0200
Message-ID: <20260530160247.415815968@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258204-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6B699610D8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 9e6bf146b55999a095bb14f73a843942456d1adc upstream.

ipv6_rpl_srh_rcv() decompresses an RFC 6554 Source Routing Header, swaps
the next segment into ipv6_hdr->daddr, recompresses, then pulls the old
header and pushes the new one plus the IPv6 header back.  The
recompressed header can be larger than the received one when the swap
reduces the common-prefix length the segments share with daddr (CmprI=0,
CmprE>0, seg[0][0] != daddr[0] gives the maximum +8 bytes).

pskb_expand_head() was gated on segments_left == 0, so on earlier
segments the push consumed unchecked headroom.  Once skb_push() leaves
fewer than skb->mac_len bytes in front of data,
skb_mac_header_rebuild()'s call to:

	skb_set_mac_header(skb, -skb->mac_len);

will store (data - head) - mac_len into the u16 mac_header field, which
wraps to ~65530, and the following memmove() writes mac_len bytes ~64KiB
past skb->head.

A single AF_INET6/SOCK_RAW/IPV6_HDRINCL packet over lo with a two
segment type-3 SRH (CmprI=0, CmprE=15) reaches headroom 8 after one
pass; KASAN reports a 14-byte OOB write in ipv6_rthdr_rcv.

Fix this by expanding the head whenever the remaining room is less than
the push size plus mac_len, and request that much extra so the rebuilt
MAC header fits afterwards.

Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
Cc: stable <stable@kernel.org>
Reported-by: Anthropic
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026042133-gout-unvented-1bd9@gregkh
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/exthdrs.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -493,6 +493,7 @@ static int ipv6_rpl_srh_rcv(struct sk_bu
 	struct inet6_dev *idev;
 	struct ipv6hdr *oldhdr;
 	struct in6_addr addr;
+	unsigned int chdr_len;
 	unsigned char *buf;
 	int accept_rpl_seg;
 	int i, err;
@@ -614,8 +615,10 @@ looped_back:
 	skb_pull(skb, ((hdr->hdrlen + 1) << 3));
 	skb_postpull_rcsum(skb, oldhdr,
 			   sizeof(struct ipv6hdr) + ((hdr->hdrlen + 1) << 3));
-	if (unlikely(!hdr->segments_left)) {
-		if (pskb_expand_head(skb, sizeof(struct ipv6hdr) + ((chdr->hdrlen + 1) << 3), 0,
+	chdr_len = sizeof(struct ipv6hdr) + ((chdr->hdrlen + 1) << 3);
+	if (unlikely(!hdr->segments_left ||
+		     skb_headroom(skb) < chdr_len + skb->mac_len)) {
+		if (pskb_expand_head(skb, chdr_len + skb->mac_len, 0,
 				     GFP_ATOMIC)) {
 			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_OUTDISCARDS);
 			kfree_skb(skb);
@@ -625,7 +628,7 @@ looped_back:
 
 		oldhdr = ipv6_hdr(skb);
 	}
-	skb_push(skb, ((chdr->hdrlen + 1) << 3) + sizeof(struct ipv6hdr));
+	skb_push(skb, chdr_len);
 	skb_reset_network_header(skb);
 	skb_mac_header_rebuild(skb);
 	skb_set_transport_header(skb, sizeof(struct ipv6hdr));



