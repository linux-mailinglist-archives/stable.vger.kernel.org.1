Return-Path: <stable+bounces-257708-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFOrKgIfG2qu/QgAu9opvQ
	(envelope-from <stable+bounces-257708-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:31:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDA260FD9D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3157E3039C9B
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF27380FEC;
	Sat, 30 May 2026 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qvPdtFfz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54DF324B1E;
	Sat, 30 May 2026 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161909; cv=none; b=FiY4OICxY0mp9NI/ARwSpfyfDwn0Z5E3YvQPmMaBHCulpEv29dz/2gZErLwfMgZZ6mBRzvuApm5ieQAbRkfj8KEqnflJ/BG3/CcNgqkKYEApdygPoHfNtFJojofKlIZDfsU/xw+u/GANWOxfaWAK/2S0FwnWjzvRrxFS3D9pZv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161909; c=relaxed/simple;
	bh=JkuqZN8vhuMBcUt9BnqvAekUqvslHOFUIHAoPNy3/Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eN5L0r2/IRcfdXz7szal4Qqnar5HPQ6MnWTC7fsOE7UzcPz+fo0iiKqoDJ70P/YUWROkGV8Hct50PREL5TpwPWCA2yHzpwM7MJwEjSi4h1mbysTDjweyJ9kqlZzw+BTB/o79OqSWdM326dWxUIZl96zcBpdXSCcRv/K3MLnC/D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qvPdtFfz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D8C1F00898;
	Sat, 30 May 2026 17:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161908;
	bh=KCxL8HBldD0HDfOuvXKJwBFAL5QPmk0bkGoPYRk5PmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qvPdtFfzGbF4NCWeZ8pC0WW4VjqcpB3doJd6iLwyXtdRw+yWzYeU70amir2aCGD4n
	 EHF1OLSxoic02fSImHNkXeCgVDfGh4YzvU8TNyUwi2G7W8JwpeJSEEE9hsL29kmwrW
	 56I0HX+i4ul+k4egj3nsfz3aFWaRRc3b17pjjLc4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiang Mei <xmei5@asu.edu>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 734/969] netfilter: arp_tables: fix IEEE1394 ARP payload parsing
Date: Sat, 30 May 2026 18:04:18 +0200
Message-ID: <20260530160320.815564663@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257708-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,asu.edu:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 0DDA260FD9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 1e8e3f449b1e73b73a843257635b9c50f0cc0f0a ]

Weiming Shi says:

"arp_packet_match() unconditionally parses the ARP payload assuming two
hardware addresses are present (source and target). However,
IPv4-over-IEEE1394 ARP (RFC 2734) omits the target hardware address
field, and arp_hdr_len() already accounts for this by returning a
shorter length for ARPHRD_IEEE1394 devices.

As a result, on IEEE1394 interfaces arp_packet_match() advances past a
nonexistent target hardware address and reads the wrong bytes for both
the target device address comparison and the target IP address. This
causes arptables rules to match against garbage data, leading to
incorrect filtering decisions: packets that should be accepted may be
dropped and vice versa.

The ARP stack in net/ipv4/arp.c (arp_create and arp_process) already
handles this correctly by skipping the target hardware address for
ARPHRD_IEEE1394. Apply the same pattern to arp_packet_match()."

Mangle the original patch to always return 0 (no match) in case user
matches on the target hardware address which is never present in
IEEE1394.

Note that this returns 0 (no match) for either normal and inverse match
because matching in the target hardware address in ARPHRD_IEEE1394 has
never been supported by arptables. This is intentional, matching on the
target hardware address should never evaluate true for ARPHRD_IEEE1394.

Moreover, adjust arpt_mangle to drop the packet too as AI suggests:

In arpt_mangle, the logic assumes a standard ARP layout. Because
IEEE1394 (FireWire) omits the target hardware address, the linear
pointer arithmetic miscalculates the offset for the target IP address.
This causes mangling operations to write to the wrong location, leading
to packet corruption. To ensure safety, this patch drops packets
(NF_DROP) when mangling is requested for these fields on IEEE1394
devices, as the current implementation cannot correctly map the FireWire
ARP payload.

This omits both mangling target hardware and IP address. Even if IP
address mangling should be possible in IEEE1394, this would require
to adjust arpt_mangle offset calculation, which has never been
supported.

Based on patch from Weiming Shi <bestswngs@gmail.com>.

Fixes: 6752c8db8e0c ("firewire net, ipv4 arp: Extend hardware address and remove driver-level packet inspection.")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/netfilter/arp_tables.c  | 18 +++++++++++++++---
 net/ipv4/netfilter/arpt_mangle.c |  8 ++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index 14365b20f1c5c..564054123772a 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -110,13 +110,25 @@ static inline int arp_packet_match(const struct arphdr *arphdr,
 	arpptr += dev->addr_len;
 	memcpy(&src_ipaddr, arpptr, sizeof(u32));
 	arpptr += sizeof(u32);
-	tgt_devaddr = arpptr;
-	arpptr += dev->addr_len;
+
+	if (IS_ENABLED(CONFIG_FIREWIRE_NET) && dev->type == ARPHRD_IEEE1394) {
+		if (unlikely(memchr_inv(arpinfo->tgt_devaddr.mask, 0,
+					sizeof(arpinfo->tgt_devaddr.mask))))
+			return 0;
+
+		tgt_devaddr = NULL;
+	} else {
+		tgt_devaddr = arpptr;
+		arpptr += dev->addr_len;
+	}
 	memcpy(&tgt_ipaddr, arpptr, sizeof(u32));
 
 	if (NF_INVF(arpinfo, ARPT_INV_SRCDEVADDR,
 		    arp_devaddr_compare(&arpinfo->src_devaddr, src_devaddr,
-					dev->addr_len)) ||
+					dev->addr_len)))
+		return 0;
+
+	if (tgt_devaddr &&
 	    NF_INVF(arpinfo, ARPT_INV_TGTDEVADDR,
 		    arp_devaddr_compare(&arpinfo->tgt_devaddr, tgt_devaddr,
 					dev->addr_len)))
diff --git a/net/ipv4/netfilter/arpt_mangle.c b/net/ipv4/netfilter/arpt_mangle.c
index a4e07e5e9c118..f65dd339208e8 100644
--- a/net/ipv4/netfilter/arpt_mangle.c
+++ b/net/ipv4/netfilter/arpt_mangle.c
@@ -40,6 +40,10 @@ target(struct sk_buff *skb, const struct xt_action_param *par)
 	}
 	arpptr += pln;
 	if (mangle->flags & ARPT_MANGLE_TDEV) {
+		if (unlikely(IS_ENABLED(CONFIG_FIREWIRE_NET) &&
+			     skb->dev->type == ARPHRD_IEEE1394))
+			return NF_DROP;
+
 		if (ARPT_DEV_ADDR_LEN_MAX < hln ||
 		   (arpptr + hln > skb_tail_pointer(skb)))
 			return NF_DROP;
@@ -47,6 +51,10 @@ target(struct sk_buff *skb, const struct xt_action_param *par)
 	}
 	arpptr += hln;
 	if (mangle->flags & ARPT_MANGLE_TIP) {
+		if (unlikely(IS_ENABLED(CONFIG_FIREWIRE_NET) &&
+			     skb->dev->type == ARPHRD_IEEE1394))
+			return NF_DROP;
+
 		if (ARPT_MANGLE_ADDR_LEN_MAX < pln ||
 		   (arpptr + pln > skb_tail_pointer(skb)))
 			return NF_DROP;
-- 
2.53.0




