Return-Path: <stable+bounces-244682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB+cC8qP/WnWfgAAu9opvQ
	(envelope-from <stable+bounces-244682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 09:24:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B86744F2F74
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 09:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D30B73017E6F
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 07:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D035737C932;
	Fri,  8 May 2026 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QLd1O28T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A84837C902;
	Fri,  8 May 2026 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225076; cv=none; b=qh96h8qzMVRFcQ0ampEhd15L3rIw4yTJd9h2B5p8pu4BuJ9GjAVg/KgWq1qx42kLHEm18lSKD3yrmBJ/95/l0iSAqR27UdOL2osZK5gBKce4tRM4Rw/V2nBCk8bIFUZNCEpvu3f5Ja9gve7n4sTMQuLzD7hrUkSlRMowHcWCZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225076; c=relaxed/simple;
	bh=9E1O/+LRKi/gYYXDdjC2mcuhZ/v0x2IJmXkH9AEFZhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHV7GIh7AG33fxs74mKznjGD/Lc+UagZUb+rBFl6kMzI96NIGo+i0RW54OcPPLMZIYsU8arKLAIVZyRQS+pzi79Qq0LttELYABPxfvYHcxe/c11rlOt1Z6VX1EVUCaM/AagJTg+JBTA04U1Ep2Idg2Sx6awuyAviV790YfhFey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QLd1O28T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704E2C2BCB0;
	Fri,  8 May 2026 07:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778225075;
	bh=9E1O/+LRKi/gYYXDdjC2mcuhZ/v0x2IJmXkH9AEFZhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QLd1O28TkqpCMz7yIdpXkxVpVYMqAF4EP5zJmO1VjdViX87/XjeM7+FHrUYNFwNvN
	 TYKFySP0bwYy6lzcwiWgFdj83VHvYAfdMlqtgIh9D4qeQPYgvs5dN1Mc7pt7Gu5FRX
	 I0p31w1QAjjlQ7RwdYncpfDnJOttKrPkHv4y0MmY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.138
Date: Fri,  8 May 2026 09:24:25 +0200
Message-ID: <2026050825-reverence-manifesto-af14@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026050825-heaving-spender-13a8@gregkh>
References: <2026050825-heaving-spender-13a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B86744F2F74
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244682-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index 11d81cfd9dcc..7878fd783212 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 137
+SUBLEVEL = 138
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 4256c7ee5939..d307e487b3a4 100644
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
index ff8040101193..305d0e2786a2 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1230,6 +1230,8 @@ static int __ip_append_data(struct sock *sk,
 			if (err < 0)
 				goto error;
 			copy = err;
+			if (!(flags & MSG_NO_SHARED_FRAGS))
+				skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
 			wmem_alloc_delta += copy;
 		} else if (!zc) {
 			int i = skb_shinfo(skb)->nr_frags;
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index f3305154745e..3a5fd0da8702 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -921,7 +921,8 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 			nfrags = 1;
 
 			goto skip_cow;
-		} else if (!skb_has_frag_list(skb)) {
+		} else if (!skb_has_frag_list(skb) &&
+			   !skb_has_shared_frag(skb)) {
 			nfrags = skb_shinfo(skb)->nr_frags;
 			nfrags++;
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 74145d05ddd2..a824c707dfff 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1829,6 +1829,8 @@ static int __ip6_append_data(struct sock *sk,
 			if (err < 0)
 				goto error;
 			copy = err;
+			if (!(flags & MSG_NO_SHARED_FRAGS))
+				skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
 			wmem_alloc_delta += copy;
 		} else if (!zc) {
 			int i = skb_shinfo(skb)->nr_frags;

