Return-Path: <stable+bounces-266282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ru5VDh2aMWrvnwUAu9opvQ
	(envelope-from <stable+bounces-266282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:46:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00305694767
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:46:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Q148TV8e;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266282-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266282-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DA883035BB5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B3B43D4E8;
	Tue, 16 Jun 2026 18:46:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3154C3CFF55;
	Tue, 16 Jun 2026 18:46:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635611; cv=none; b=VwMPwUKxTSi4tMldtw7icKy/HGHNYxU+8s//o31oaDN03L2QFY2OH5gnIXKRbxDIPhVnYLm71LxloyGsGfLEMxVmPfCun+e3fa8ClLjhOy+YQBADckA0ZK7BfxtWHimWdZ4vSVhZw4Zh4Dp9mMk0YIZX90SmJqfRvdc1LIwLieg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635611; c=relaxed/simple;
	bh=vA5EVknq2r9HeuYXLrAK4BuLsEx9AiPxm13NbcjNd1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBLd7omYsk2+K1ekz8LfVj06z2ZuSUTjU2gC5T2GT9BTfP3lOw+BW3GSaCArcs/xI/NF+ADz6cy/kBCEC9N3W12alaDCUkM4W2nZVadZwQC0JHEoQWWb/V3T3py2b38js1fa9vgyeYtVQrIeWQWS9eCxfTbuqKD8fbubn37/gH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q148TV8e; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE3B1F000E9;
	Tue, 16 Jun 2026 18:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781635610;
	bh=9zQuFtS+mZUp90nyHkBAKPzaRV7ogRO+hfOVhf6bfe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q148TV8ejMcRQVXj5/hP+SrNAd5wHHMWVRkQv7K1uhbQMdrvVVcisWvCDZSLzc2uk
	 IdQiZU7/Dclh/+lH8SNjd+AQhy0rUsBaRVKVXatm33E9rqF4wQ58vIffk5vtYrKUQd
	 /7K1bfwZAxHC2M9h1qFwoju3XntCsFVjE1bLEn5k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 5.10 080/342] xfrm: ah: use skb_to_full_sk in async output callbacks
Date: Tue, 16 Jun 2026 20:26:16 +0530
Message-ID: <20260616145051.971393489@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266282-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:michael.bommarito@gmail.com,m:steffen.klassert@secunet.com,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,secunet.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00305694767

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

commit 79d8be262377f7112cfa3088dfc4142d5a2533f3 upstream.

When AH output is offloaded to an asynchronous crypto provider
(hardware accelerators such as AMD CCP, or a forced-async software
shim used for testing), the digest completion fires
ah_output_done() / ah6_output_done() on a workqueue.  The egress
skb at that point may have been originated by a TCP listener
sending a SYN-ACK, which sets skb->sk to a request_sock via
skb_set_owner_edemux(); it may also have been originated by an
inet_timewait_sock retransmit.  Neither is a full struct sock, and
passing the raw skb->sk to xfrm_output_resume() then forwards a
non-full socket through the rest of the xfrm output chain.

xfrm_output_resume() and its downstream consumers expect a full
sk where they dereference at all.  The natural egress path
through ah_output_done() does not crash today because the
consumers that read past sock_common are either gated by
sk_fullsock() or short-circuit on flags that are clear on a fresh
request_sock; an exhaustive walk of the 50 most plausible
consumers under sch_fq, dev_queue_xmit, netfilter, tc-egress and
cgroup-egress BPF found no current unguarded deref.  The bug is
still a real type confusion that future consumer changes could
turn into a memory-corruption primitive.

This is the same bug class fixed for ESP in commit 1620c88887b1
("xfrm: Fix the usage of skb->sk").  Apply the analogous fix to
AH: convert skb->sk to a full socket pointer (or NULL) via
skb_to_full_sk() before handing it to xfrm_output_resume().

The same async AH callbacks were touched recently for an
independent ESN-related ICV layout bug in commit ec54093e6a8f
("xfrm: ah: account for ESN high bits in async callbacks"); the
sk type-confusion addressed here is orthogonal.  This patch is
part of an ongoing audit of the AH callback paths; an ah_output
ihl-validation hardening series is also currently under review on
netdev.

Reproduced under UML + KASAN + lockdep with a forced-async
hmac(sha1) shim that registers at priority 9999 and wraps the
sync in-tree hmac-sha1-lib.  With the shim loaded, ah_output_done
runs on every SYN-ACK egress through a transport-mode AH SA and
skb->sk arrives as a request_sock (TCP_NEW_SYN_RECV); after this
patch, xfrm_output_resume() receives the listener (the result of
sk_to_full_sk()) and consumer derefs land on full-sock fields as
intended.

Fixes: 9ab1265d5231 ("xfrm: Use actual socket sk instead of skb socket for xfrm_output_resume")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ah4.c |    2 +-
 net/ipv6/ah6.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv4/ah4.c
+++ b/net/ipv4/ah4.c
@@ -141,7 +141,7 @@ static void ah_output_done(struct crypto
 	}
 
 	kfree(AH_SKB_CB(skb)->tmp);
-	xfrm_output_resume(skb->sk, skb, err);
+	xfrm_output_resume(skb_to_full_sk(skb), skb, err);
 }
 
 static int ah_output(struct xfrm_state *x, struct sk_buff *skb)
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -338,7 +338,7 @@ static void ah6_output_done(struct crypt
 	ah6_restore_hdrs(top_iph, iph_ext, extlen);
 
 	kfree(AH_SKB_CB(skb)->tmp);
-	xfrm_output_resume(skb->sk, skb, err);
+	xfrm_output_resume(skb_to_full_sk(skb), skb, err);
 }
 
 static int ah6_output(struct xfrm_state *x, struct sk_buff *skb)



