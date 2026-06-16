Return-Path: <stable+bounces-266337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iwz9DzqbMWpPoAUAu9opvQ
	(envelope-from <stable+bounces-266337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:51:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7837D694864
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:51:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=wExwuUpC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266337-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-266337-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A52C33009E08
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6398747B435;
	Tue, 16 Jun 2026 18:51:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCD832E13B;
	Tue, 16 Jun 2026 18:51:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635893; cv=none; b=cbkI5fbfSbzd7DvT4Xl9gfGgI6E9MYMXHJsjowLgeaeaaQj9E59iA9hPXGmwPyDcYCAvbTRFCfRPu707BhXTFfraAjGGFvCkyYOBBrY98xzcLYq/1kIGPKw94XOgHecO2yZa2W9Fr4UyqehPhDosubjsifl3S5nSLoiCAQULXqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635893; c=relaxed/simple;
	bh=9MPCnPGvoTcYehAZcIwgnT8N1yAePXCQ0lHtV+FEajw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqUR9sDC0a/pxTcEAkD1w1Z4n/8SOkxMYYZUI0+TF/igygGpgHyFIH4RCX9zPS+QIZF+tl/0JKelP0wAaPkTBHKJYeN7WRt2utJPh7so1Fvwpb8Y51vcXTaOFR3qNpGsIQVrE1x1UolhSWFlKFMdQEpbd2TfGfZ8hC7xJm+dZ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wExwuUpC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD1B1F000E9;
	Tue, 16 Jun 2026 18:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781635892;
	bh=jkDjFk3t8ctT1vTFdyae+l4YXOWrwWPnLUuKbMovo1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wExwuUpCEU7wrDQPqqkLVwJpBnakaSrjYfEvf61BnlD1AiSIEhMoZNtTFK3QWn6aD
	 rMDA5PAkpDR+aZMVf1kOpRpQGunbUeHL3CMFm+BRWBZDwk85LPxAkdvAt/26z8CqMT
	 Nq7IqB0ITzqkQdguOvhATTJoBA2B8k3aRcmkcdUw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yiming Qian <yimingqian591@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 136/342] netfilter: bridge: make ebt_snat ARP rewrite writable
Date: Tue, 16 Jun 2026 20:27:12 +0530
Message-ID: <20260616145054.524653820@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,strlen.de,netfilter.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-266337-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:yimingqian591@gmail.com,m:fw@strlen.de,m:pablo@netfilter.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,netfilter.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,strlen.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7837D694864

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yiming Qian <yimingqian591@gmail.com>

[ Upstream commit 67ba971ae02514d85818fe0c32549ab4bfa3bf49 ]

The ebtables SNAT target keeps the Ethernet source address rewrite
behind skb_ensure_writable(skb, 0).  This is intentional: at the bridge
ebtables hooks the Ethernet header is addressed through
skb_mac_header()/eth_hdr(), while skb->data points at the Ethernet
payload.  Asking skb_ensure_writable() for ETH_HLEN bytes would check
the payload, not the Ethernet header, and would reintroduce the small
packet regression fixed by commit 63137bc5882a.

However, the optional ARP sender hardware address rewrite is different.
It writes through skb_store_bits() at an offset relative to skb->data:

        skb_store_bits(skb, sizeof(struct arphdr), info->mac, ETH_ALEN)

skb_header_pointer() only safely reads the ARP header; it does not make
the later sender hardware address range writable.  If that range is
still held in a nonlinear skb fragment backed by a splice-imported file
page, skb_store_bits() maps the frag page and copies the new MAC address
directly into it.

Ensure the ARP SHA range is writable before reading the ARP header and
before calling skb_store_bits().

Fixes: 63137bc5882a ("netfilter: ebtables: Fixes dropping of small packets in bridge nat")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/netfilter/ebt_snat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bridge/netfilter/ebt_snat.c b/net/bridge/netfilter/ebt_snat.c
index 7dfbcdfc30e5d2..c9e229af0366b8 100644
--- a/net/bridge/netfilter/ebt_snat.c
+++ b/net/bridge/netfilter/ebt_snat.c
@@ -31,6 +31,9 @@ ebt_snat_tg(struct sk_buff *skb, const struct xt_action_param *par)
 		const struct arphdr *ap;
 		struct arphdr _ah;
 
+		if (skb_ensure_writable(skb, sizeof(_ah) + ETH_ALEN))
+			return EBT_DROP;
+
 		ap = skb_header_pointer(skb, 0, sizeof(_ah), &_ah);
 		if (ap == NULL)
 			return EBT_DROP;
-- 
2.53.0




