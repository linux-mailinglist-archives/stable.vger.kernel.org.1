Return-Path: <stable+bounces-260949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q6yBCIFCJWriFAIAu9opvQ
	(envelope-from <stable+bounces-260949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:05:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCF564F523
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:05:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="PLH/Pjpx";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260949-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260949-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43CDB3002303
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A778285CAE;
	Sun,  7 Jun 2026 10:05:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E804071C7;
	Sun,  7 Jun 2026 10:05:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826751; cv=none; b=sMqed8U2eybYMe1tQoBkBR63DmhHgXcUDRU9xhyyLIooHBxSY5sREzdO/O7hsvzZy93JAlv/xFQTHGUpJgpvdsC7qUZBJIBzhA7rNDPtrGjIkNlVzRSJWUnDROrgU2rytmd0EDcMG422Oc1qpyO9X54kJj3PtRiNFzStYMWKV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826751; c=relaxed/simple;
	bh=BVIWnP7hYX2kPzQ4itWb/Z/SAOKzYUXB4KF32EAi0UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGpIaGrpCOBpxqQ+xvPCOZeuNnde2/U+vn+xvwMDf8Rms0kDDMFtHqyYL2vSnrnMmLtEkeVC4OJWe2nNKSpdXnhyyF/9W13R+F6y+fyrHwR2/FjiuxIbFFKHdXaMI1/utTqUPrf1wBH+pC473fW5EnBQlr63pcedhVgXsNIBDRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PLH/Pjpx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A40A1F00893;
	Sun,  7 Jun 2026 10:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826750;
	bh=mVlan1Oxf9fXBr8AOaj2uJLKKIRNiMdcfgY2MlS1Pdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PLH/PjpxC1wvMNqFMENecwBDVWAcoHjtutEkEtBovpohOhR0G0N9OsikqGrceRNji
	 Ivg8LLdzdCfDBhqwh5Fp9TGr3wjc5Kb1+3oQEGf93+hkbxz438mb77/wxH0gT3yhRT
	 5QZNN/hNceybAI7XLGi5MGfgXyZMmVG1kQdXB8js=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Mason <clm@meta.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 017/332] netfilter: synproxy: refresh tcphdr after skb_ensure_writable
Date: Sun,  7 Jun 2026 11:56:26 +0200
Message-ID: <20260607095728.683473916@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260949-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:clm@meta.com,m:fmancera@suse.de,m:fw@strlen.de,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,suse.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,strlen.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBCF564F523

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Mason <clm@meta.com>

[ Upstream commit 92170e6afe927ab2792a3f71902845789c8e31b1 ]

synproxy_tstamp_adjust() rewrites the TCP timestamp option in place
and then patches the TCP checksum via inet_proto_csum_replace4() on
the caller-supplied tcphdr pointer.  Both ipv4_synproxy_hook() and
ipv6_synproxy_hook() obtain that pointer with skb_header_pointer()
before calling in, so it may either alias skb->head directly or
point at the caller's on-stack _tcph buffer.

Between obtaining the pointer and using it, the function calls
skb_ensure_writable(skb, optend), which on a cloned or non-linear
skb invokes pskb_expand_head() and frees the old skb->head.  After
that point the cached th is stale:

    caller (ipv[46]_synproxy_hook)
      th = skb_header_pointer(skb, ..., &_tcph)
      synproxy_tstamp_adjust(skb, protoff, th, ...)
        skb_ensure_writable(skb, optend)
          pskb_expand_head()        /* kfree(old skb->head) */
        ...
        inet_proto_csum_replace4(&th->check, ...)
                                    /* writes into freed head, or
                                       into the caller's stack copy
                                       leaving the on-wire checksum
                                       stale */

The option bytes are written through skb->data and are fine; only
the checksum update goes through th and so lands in the wrong
place.  The result is either a write into freed slab memory or a
packet leaving with a checksum that does not match its payload.

Fix by re-deriving th from skb->data + protoff immediately after
skb_ensure_writable() succeeds, so the subsequent checksum update
targets the linear, writable header.

Fixes: 48b1de4c110a ("netfilter: add SYNPROXY core/target")
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_synproxy_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_synproxy_core.c b/net/netfilter/nf_synproxy_core.c
index 57f57e2fc80a8f..036c8586f49b75 100644
--- a/net/netfilter/nf_synproxy_core.c
+++ b/net/netfilter/nf_synproxy_core.c
@@ -200,6 +200,8 @@ synproxy_tstamp_adjust(struct sk_buff *skb, unsigned int protoff,
 	if (skb_ensure_writable(skb, optend))
 		return 0;
 
+	th = (struct tcphdr *)(skb->data + protoff);
+
 	while (optoff < optend) {
 		unsigned char *op = skb->data + optoff;
 
-- 
2.53.0




