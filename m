Return-Path: <stable+bounces-213424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vanxDWtbg2mWlwMAu9opvQ
	(envelope-from <stable+bounces-213424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:44:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7617E74D5
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7600A3012C84
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2774C410D3B;
	Wed,  4 Feb 2026 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hO4caiIh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04BB3ACEF6;
	Wed,  4 Feb 2026 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216290; cv=none; b=ZfMyMembgo3ucFJCezL7GeKleFF07TS914BZ4l/P0W8Jgcs3uN4EHM2tt/6XACsnWsWCRaPaSSvAqOMCr2z5lE+ZHbs/UtkYZH32jz5HPx0tZ8vWDMOkDbnY4hdubxn5AjChgbplv6gzOwcljV0pii2ON1FtBHo/2gFmvoKi3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216290; c=relaxed/simple;
	bh=3jSGnVMyvzomy/uZZ2H/p1kd6PJIJj6TTZuLWZBrV5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+ClSxF47s+cXEltCHbjpqhLGGqm5r+7CXRgxI6XIVtpmBTCJKt/nPR4k19L7c5wnt22uVod3DOQURjWTPYVYECS16tVaV0pkKXjyC8lueEPJmOmoZsz9wk89Jm6rYWXEB8M3JKaGKFBUn2hhn1RDyNI/wA9m6gwDKyf115kZPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hO4caiIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E5BC4CEF7;
	Wed,  4 Feb 2026 14:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216290;
	bh=3jSGnVMyvzomy/uZZ2H/p1kd6PJIJj6TTZuLWZBrV5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hO4caiIhqhF7EjXaKE/1kAyO1Ei4Pqy1giTmWY39Jv91NTaUoyugGpGNkqCixnpFL
	 r2T6TmauM0rXhBTQCOWt3rIrFa+foYlYcipLCXpANpNHbL7lxoRZkdTzhUmz7cZAg5
	 rE4k9USN0/Ybe3n18XKRwnWCf2sUa0yGW14pU1VQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin Willi <martin@strongswan.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.10 044/161] macvlan: Fix leaking skb in source mode with nodst option
Date: Wed,  4 Feb 2026 15:38:27 +0100
Message-ID: <20260204143853.349829292@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213424-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davemloft.net:email,strongswan.org:email]
X-Rspamd-Queue-Id: B7617E74D5
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Willi <martin@strongswan.org>

commit e16b859872b87650bb55b12cca5a5fcdc49c1442 upstream.

The MACVLAN receive handler clones skbs to all matching source MACVLAN
interfaces, before it passes the packet along to match on destination
based MACVLANs.

When using the MACVLAN nodst mode, passing the packet to destination based
MACVLANs is omitted and the handler returns with RX_HANDLER_CONSUMED.
However, the passed skb is not freed, leaking for any packet processed
with the nodst option.

Properly free the skb when consuming packets to fix that leak.

Fixes: 427f0c8c194b ("macvlan: Add nodst option to macvlan type source")
Signed-off-by: Martin Willi <martin@strongswan.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/macvlan.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -464,8 +464,10 @@ static rx_handler_result_t macvlan_handl
 			return RX_HANDLER_CONSUMED;
 		*pskb = skb;
 		eth = eth_hdr(skb);
-		if (macvlan_forward_source(skb, port, eth->h_source))
+		if (macvlan_forward_source(skb, port, eth->h_source)) {
+			kfree_skb(skb);
 			return RX_HANDLER_CONSUMED;
+		}
 		src = macvlan_hash_lookup(port, eth->h_source);
 		if (src && src->mode != MACVLAN_MODE_VEPA &&
 		    src->mode != MACVLAN_MODE_BRIDGE) {
@@ -484,8 +486,10 @@ static rx_handler_result_t macvlan_handl
 		return RX_HANDLER_PASS;
 	}
 
-	if (macvlan_forward_source(skb, port, eth->h_source))
+	if (macvlan_forward_source(skb, port, eth->h_source)) {
+		kfree_skb(skb);
 		return RX_HANDLER_CONSUMED;
+	}
 	if (macvlan_passthru(port))
 		vlan = list_first_or_null_rcu(&port->vlans,
 					      struct macvlan_dev, list);



