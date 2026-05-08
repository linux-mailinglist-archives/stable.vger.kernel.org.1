Return-Path: <stable+bounces-244687-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIQaOByR/WnWfgAAu9opvQ
	(envelope-from <stable+bounces-244687-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 09:30:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 810794F304C
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 09:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C0C2306E659
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 07:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2BF3806A3;
	Fri,  8 May 2026 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EVmfvR0a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68823803EE;
	Fri,  8 May 2026 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225102; cv=none; b=KVDkvmOFAg1x3xW6W3yN4549MSvViWOvF8mJ+/80ywZM9hj0K1tepsivM1Z0E68UYsrBCLV95+Sdewc3NqV0JXGakIANVYKD/LBrmbzii+mhxQzmhWrf/vg1gd78SBsjFa0LulChkkNuwY6YeCl3wt0R3mf68pkOemzboJKPpzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225102; c=relaxed/simple;
	bh=75OWvzRMkVmXiDHDU861/5UsS965ZR6S7blk+rCZUog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPgbDSyth0CWgVDZ61/iAHwWDXfVJPSKKQi1f10IY+U6zZcQIuIkrqQXZK5v0AAD4nzHViTHtcxyKOTNfZ/aObBirQFzr+yjSJnNVfKkoGP9fF5sYFO62hgTehX1h4F0LCGhEpFdNseHAWsN4Sg3r9uVi8g/Zo679wo3e9s/eNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EVmfvR0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97DBC2BCB0;
	Fri,  8 May 2026 07:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778225102;
	bh=75OWvzRMkVmXiDHDU861/5UsS965ZR6S7blk+rCZUog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EVmfvR0aL/3QWq0TXDfoViEFo2jJ0ifLSGCP70/BmPQ87SWjoTilC6ogt65gWoH1l
	 7l1jKb5E0sk0I/CeOiS3N39rtMPr7RHUeQhR9fP2V2GibgnB2vFAG0Kb2b1yesBRR9
	 16klE0BGKhYI/dXChMMQjP3N+NQlmorz1pHfeIok=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 7.0.5
Date: Fri,  8 May 2026 09:24:51 +0200
Message-ID: <2026050851-sister-rebalance-69c0@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026050851-iron-hurdle-6421@gregkh>
References: <2026050851-iron-hurdle-6421@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 810794F304C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244687-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index 316c0c4ebe5c..6694d125285e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 7
 PATCHLEVEL = 0
-SUBLEVEL = 4
+SUBLEVEL = 5
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 6dfc0bcdef65..6a5febbdbee4 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -873,7 +873,8 @@ static int esp_input(struct xfrm_state *x, struct sk_buff *skb)
 			nfrags = 1;
 
 			goto skip_cow;
-		} else if (!skb_has_frag_list(skb)) {
+		} else if (!skb_has_frag_list(skb) &&
+			   !skb_has_shared_frag(skb)) {
 			nfrags = skb_shinfo(skb)->nr_frags;
 			nfrags++;
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index e4790cc7b5c2..5bcd73cbdb41 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1233,6 +1233,8 @@ static int __ip_append_data(struct sock *sk,
 			if (err < 0)
 				goto error;
 			copy = err;
+			if (!(flags & MSG_NO_SHARED_FRAGS))
+				skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
 			wmem_alloc_delta += copy;
 		} else if (!zc) {
 			int i = skb_shinfo(skb)->nr_frags;
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 9f75313734f8..9c06c5a1419d 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -915,7 +915,8 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 			nfrags = 1;
 
 			goto skip_cow;
-		} else if (!skb_has_frag_list(skb)) {
+		} else if (!skb_has_frag_list(skb) &&
+			   !skb_has_shared_frag(skb)) {
 			nfrags = skb_shinfo(skb)->nr_frags;
 			nfrags++;
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 8e2a6b28cea7..3f14e363c96e 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1765,6 +1765,8 @@ static int __ip6_append_data(struct sock *sk,
 			if (err < 0)
 				goto error;
 			copy = err;
+			if (!(flags & MSG_NO_SHARED_FRAGS))
+				skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
 			wmem_alloc_delta += copy;
 		} else if (!zc) {
 			int i = skb_shinfo(skb)->nr_frags;

