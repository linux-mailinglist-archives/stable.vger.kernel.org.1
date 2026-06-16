Return-Path: <stable+bounces-265353-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2hUBNjaHMWrqlgUAu9opvQ
	(envelope-from <stable+bounces-265353-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:26:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1586A6931EC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:26:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=m7RHOswn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265353-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-265353-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F3A03011A48
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C033478E50;
	Tue, 16 Jun 2026 17:26:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4248B3876CF;
	Tue, 16 Jun 2026 17:26:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630772; cv=none; b=eU7APxOTEHuX5AzfgX3+aa5NBzb5B5fanjuUzXc/A0pRb2f+VHdWT1mD6tbwqv3DS9xoVHtY4bCm9uyywHSOTwhJBa2EI2U7AkI8/MN9RmNWCnqE73VKCBithHY9PXXO9Ethlf6Z0SQ2cj8jlKrhY5FdkgzW3zSZ741vK9EReRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630772; c=relaxed/simple;
	bh=Z/9BgJtq8hlwm06FWpZz3vYoBDqqDDsQDNAL8BnmBpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K38U6CVaVy0WyD/lGzcdhShAGSGdd5yr587CAN4YxscDa0M9U6W785hv7abSwgw5YbdlAthzv8siMIHPD/qv4yuURNdXKMS4be7kB8knXx/0BeXuAW5bXa+mIbeb2kXB+lc8usLHYJCEU/YELWsb4Rsvnc/swjE6nFziF+7m7R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m7RHOswn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431F21F000E9;
	Tue, 16 Jun 2026 17:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630771;
	bh=VE24EAO6nsQYbxpkjibKTGa7eMO+mrGKB/4Euh7gDhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m7RHOswnGF3L3kdqhk0eK0e+smy3kf2gCZwjpiJT4uAEYVbubiWVZQky0w3z9zndu
	 8o/YFEdAI+shymdOX+d8ZWX3gSxRgCcRJXOFabVW3ARHQfHQlZqRK/RXZDU9iXdt95
	 0Czkl4ttT+lt3vvnDwuEn5Z5iRy4c9MtqP5T7MxA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 066/522] net/packet: convert po->tp_loss to an atomic flag
Date: Tue, 16 Jun 2026 20:23:33 +0530
Message-ID: <20260616145128.887812611@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265353-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:edumazet@google.com,m:davem@davemloft.net,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,davemloft.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1586A6931EC

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 164bddace2e03f6005e650cb88f101a66ebdc05a ]

tp_loss can be read locklessly.

Convert it to an atomic flag to avoid races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 2c054e17d9d4 ("net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/packet/af_packet.c | 6 +++---
 net/packet/diag.c      | 2 +-
 net/packet/internal.h  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 1ceb8f765114b3..490bfec158035e 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2900,7 +2900,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 
 		if (unlikely(tp_len < 0)) {
 tpacket_error:
-			if (po->tp_loss) {
+			if (packet_sock_flag(po, PACKET_SOCK_TP_LOSS)) {
 				__packet_set_status(po, ph,
 						TP_STATUS_AVAILABLE);
 				packet_increment_head(&po->tx_ring);
@@ -3957,7 +3957,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec) {
 			ret = -EBUSY;
 		} else {
-			po->tp_loss = !!val;
+			packet_sock_flag_set(po, PACKET_SOCK_TP_LOSS, val);
 			ret = 0;
 		}
 		release_sock(sk);
@@ -4166,7 +4166,7 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
 		val = po->tp_reserve;
 		break;
 	case PACKET_LOSS:
-		val = po->tp_loss;
+		val = packet_sock_flag(po, PACKET_SOCK_TP_LOSS);
 		break;
 	case PACKET_TIMESTAMP:
 		val = po->tp_tstamp;
diff --git a/net/packet/diag.c b/net/packet/diag.c
index 057ee37bd0766c..677d442cd930fe 100644
--- a/net/packet/diag.c
+++ b/net/packet/diag.c
@@ -29,7 +29,7 @@ static int pdiag_put_info(const struct packet_sock *po, struct sk_buff *nlskb)
 		pinfo.pdi_flags |= PDI_ORIGDEV;
 	if (po->has_vnet_hdr)
 		pinfo.pdi_flags |= PDI_VNETHDR;
-	if (po->tp_loss)
+	if (packet_sock_flag(po, PACKET_SOCK_TP_LOSS))
 		pinfo.pdi_flags |= PDI_LOSS;
 
 	return nla_put(nlskb, PACKET_DIAG_INFO, sizeof(pinfo), &pinfo);
diff --git a/net/packet/internal.h b/net/packet/internal.h
index 31bac09a687233..82a997824e5733 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -118,8 +118,7 @@ struct packet_sock {
 	struct mutex		pg_vec_lock;
 	unsigned long		flags;
 	unsigned int		running;	/* bind_lock must be held */
-	unsigned int		has_vnet_hdr:1, /* writer must hold sock lock */
-				tp_loss:1;
+	unsigned int		has_vnet_hdr:1; /* writer must hold sock lock */
 	int			pressure;
 	int			ifindex;	/* bound device		*/
 	__be16			num;
@@ -146,6 +145,7 @@ enum packet_sock_flags {
 	PACKET_SOCK_ORIGDEV,
 	PACKET_SOCK_AUXDATA,
 	PACKET_SOCK_TX_HAS_OFF,
+	PACKET_SOCK_TP_LOSS,
 };
 
 static inline void packet_sock_flag_set(struct packet_sock *po,
-- 
2.53.0




