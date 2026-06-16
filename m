Return-Path: <stable+bounces-265342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Iw8xJP6GMWrYlgUAu9opvQ
	(envelope-from <stable+bounces-265342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:25:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADFE6931B3
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:25:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=XUexXK4m;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265342-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265342-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1218030027A9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748CC478E26;
	Tue, 16 Jun 2026 17:25:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FEC466B5E;
	Tue, 16 Jun 2026 17:25:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630716; cv=none; b=UiZxHjIIgJyHwrtkuN4qQ1G85b9mvVQ7TDKlQ5Pz5h3jyuHeTLyj+r8EAgdp7dHdm/S4BsOeMl7GWuGUKkG9AkWjtWa0N1nBm3AVUJhsi7kVAnit8+P8PPKcQavuJW4VZ4XAImQCcJFLYnAya7jELAXm4QniIzXbsNkzktnC4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630716; c=relaxed/simple;
	bh=HIqGEVlvOXo5berEeHlD67d4ezl1oEEKIyb8GWZ0o18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VX58DIIy8EDgNizhmmhGpToJ38dHf0O8oG0ZwNd4YtzHS/QCZEiuNEyELasUKZaDokVBWEMhqzI0Jp+S6rooYwO+ui/AOPmjc0/l3OmZXsCsZn7KORHmlaNm6uGXOML89LrHD4UH/LROLKwdl/sj1FsD7mbJ06w9aV2/A/glUHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XUexXK4m; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AAC1F000E9;
	Tue, 16 Jun 2026 17:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630715;
	bh=EqZyJMl+Szf4KEVjzCJLAU3kPe4k2Bs7o2F2H5WycqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XUexXK4m+nCOYqjq44FruuOELpXrE36muvl3iTdnwF82TUssW3/Qs0KFC8lD6H+pl
	 j6TlHeifNFx87DxJqMz6wy6xxB6+/crT2XOHbchCmN0bnQRN1L3U//XPMgGryqq3jx
	 9GuqI4558zabg6UOXKPOYh2b2ehpAU6UijeFL/Bw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 065/522] net/packet: convert po->tp_tx_has_off to an atomic flag
Date: Tue, 16 Jun 2026 20:23:32 +0530
Message-ID: <20260616145128.836527112@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265342-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:edumazet@google.com,m:davem@davemloft.net,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,davemloft.net:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0ADFE6931B3

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 7438344660fa55b33b8234c1797c886eb73667a7 ]

This is to use existing space in po->flags, and reclaim
the storage used by the non atomic bit fields.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 2c054e17d9d4 ("net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/packet/af_packet.c | 6 +++---
 net/packet/internal.h  | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 502d2f6de18a29..1ceb8f765114b3 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2723,7 +2723,7 @@ static int tpacket_parse_header(struct packet_sock *po, void *frame,
 		return -EMSGSIZE;
 	}
 
-	if (unlikely(po->tp_tx_has_off)) {
+	if (unlikely(packet_sock_flag(po, PACKET_SOCK_TX_HAS_OFF))) {
 		int off_min, off_max;
 
 		off_min = po->tp_hdrlen - sizeof(struct sockaddr_ll);
@@ -4064,7 +4064,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 
 		lock_sock(sk);
 		if (!po->rx_ring.pg_vec && !po->tx_ring.pg_vec)
-			po->tp_tx_has_off = !!val;
+			packet_sock_flag_set(po, PACKET_SOCK_TX_HAS_OFF, val);
 
 		release_sock(sk);
 		return 0;
@@ -4191,7 +4191,7 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
 		lv = sizeof(rstats);
 		break;
 	case PACKET_TX_HAS_OFF:
-		val = po->tp_tx_has_off;
+		val = packet_sock_flag(po, PACKET_SOCK_TX_HAS_OFF);
 		break;
 	case PACKET_QDISC_BYPASS:
 		val = packet_use_direct_xmit(po);
diff --git a/net/packet/internal.h b/net/packet/internal.h
index b2edfe6fc8e770..31bac09a687233 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -119,8 +119,7 @@ struct packet_sock {
 	unsigned long		flags;
 	unsigned int		running;	/* bind_lock must be held */
 	unsigned int		has_vnet_hdr:1, /* writer must hold sock lock */
-				tp_loss:1,
-				tp_tx_has_off:1;
+				tp_loss:1;
 	int			pressure;
 	int			ifindex;	/* bound device		*/
 	__be16			num;
@@ -146,6 +145,7 @@ static inline struct packet_sock *pkt_sk(struct sock *sk)
 enum packet_sock_flags {
 	PACKET_SOCK_ORIGDEV,
 	PACKET_SOCK_AUXDATA,
+	PACKET_SOCK_TX_HAS_OFF,
 };
 
 static inline void packet_sock_flag_set(struct packet_sock *po,
-- 
2.53.0




