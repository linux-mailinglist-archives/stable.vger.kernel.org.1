Return-Path: <stable+bounces-256998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNJtLWUQG2q/+ggAu9opvQ
	(envelope-from <stable+bounces-256998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:29:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE0260E2F0
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AE093002B69
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D163341AC7;
	Sat, 30 May 2026 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NkTyNnhG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC0933F8A4;
	Sat, 30 May 2026 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780158559; cv=none; b=mCHrDR+rlRzooCLqcrXACwdz5/f54kMSpTWh2Ljs+YTZ7eXer/twCElAOVjHiSSqoFU4Qf/FzyJSGC+AFpgw5kUdTBwM2ROaCzSPpN/uw+P7g2TBwsm5luPV9YEkJnJB5LXhOduhC7zeTK93IruHM0GfWIeKiza5qTOJFqo0N84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780158559; c=relaxed/simple;
	bh=gSopnPRNNlRFcgWWs+ShXMeN75UsUE1PuPfb15AWCms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCe9BxdkGJQ1jh8bIU3VK5mvuBdVvk4b03rM2/jF4d9pZCCJx5TEYbgdZobZCthQmzehn5YX0Xe6Ucf2YYNUI9Fkr972HJnhWckJftEY7lFvA0jHnYAELnKGtmdx7gSs/DGSri2Fq6eTmGvnIYL+oFGnG0XW3uZ8WsFkVxOWKAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NkTyNnhG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9BE1F00893;
	Sat, 30 May 2026 16:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780158558;
	bh=x34wlP6I+PBV2D390VWGQdtSzkKBn0O4ahLDtsLD1/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NkTyNnhGl7a34xfO6CfmK74VGZ8svtFYy6aR8ZE/o+XcBrTkICGvc1YzvMIfE2qWG
	 5VTuzjzPuRGHdDcQVz9xo0OMli9Wzdjnp0eew4yg4fdcy0GKvmG0kljgkmQos6H1rh
	 2Bs6SSNnr1k8e2h+yOvbKHzYbalrsfC53XIpEibI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable <stable@kernel.org>
Subject: [PATCH 6.1 062/969] net: usb: cdc-phonet: fix skb frags[] overflow in rx_complete()
Date: Sat, 30 May 2026 17:53:06 +0200
Message-ID: <20260530160302.095398848@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-256998-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,davemloft.net:email]
X-Rspamd-Queue-Id: BDE0260E2F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 600dc40554dc5ad1e6f3af51f700228033f43ea7 upstream.

A malicious USB device claiming to be a CDC Phonet modem can overflow
the skb_shared_info->frags[] array by sending an unbounded sequence of
full-page bulk transfers.

Drop the skb and increment the length error when the frag limit is
reached.  This matches the same fix that commit f0813bcd2d9d ("net:
wwan: t7xx: fix potential skb->frags overflow in RX path") did for the
t7xx driver.

Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: stable <stable@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026041134-dreamboat-buddhism-d1ec@gregkh
Fixes: 87cf65601e17 ("USB host CDC Phonet network interface driver")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/cdc-phonet.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/usb/cdc-phonet.c
+++ b/drivers/net/usb/cdc-phonet.c
@@ -157,11 +157,16 @@ static void rx_complete(struct urb *req)
 						PAGE_SIZE);
 				page = NULL;
 			}
-		} else {
+		} else if (skb_shinfo(skb)->nr_frags < MAX_SKB_FRAGS) {
 			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 					page, 0, req->actual_length,
 					PAGE_SIZE);
 			page = NULL;
+		} else {
+			dev_kfree_skb_any(skb);
+			pnd->rx_skb = NULL;
+			skb = NULL;
+			dev->stats.rx_length_errors++;
 		}
 		if (req->actual_length < PAGE_SIZE)
 			pnd->rx_skb = NULL; /* Last fragment */



