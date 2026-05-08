Return-Path: <stable+bounces-244737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKddJsTA/WkpigAAu9opvQ
	(envelope-from <stable+bounces-244737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 12:53:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 293844F550A
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 12:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A86C83095248
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 10:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8983101B2;
	Fri,  8 May 2026 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i/VPC7Pe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAE41862A;
	Fri,  8 May 2026 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778237444; cv=none; b=LexRKowyMqvM8RXvCPRkDdXKh2EBrJiTpTMCYm/kSSOEuYWyNo+4byRqPtzCdffISQwtphbyWwl/uuiqfJKlVKjC8fTqzjI3cYJG3fwXWTniCnP9xL1qV1qG96ylqhIHPlz3vOTKSKkzFmvSvAoywMHY1BfdXUAZQxcpSLI3Zhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778237444; c=relaxed/simple;
	bh=z51T9FZKqys+r5qYP8qTqJqyqfRvsSsgCgNXQlLwaZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAKb4fhWkBmpcEiWsh1weg2bIlmgEUlUu3pBZ7jYBKWDQJ1YNV3THAVBupo3HITJbIgqB1saps/KiJDixjiHESouRu37kNcUtoWkHKF/Nz+xufRdKgZ1RKEbezCvKY8MYNQbxJPY1zDD5ikL1vlmzhaJ/w9X7MDEjc7tVVWWE2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i/VPC7Pe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3D5C2BCB0;
	Fri,  8 May 2026 10:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778237443;
	bh=z51T9FZKqys+r5qYP8qTqJqyqfRvsSsgCgNXQlLwaZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/VPC7Pe/7mV9v/Ym/zEGEffQ/C3l5P2ga0LHywqa97eJUPgfBTezPkWUgKK2vVgA
	 kmqvtr8sfxJEPSjXrVuc4coPIb9CNJXKVHQo9dr3Ka2BD2hG5vOUPT+1B86ZhviA6i
	 qa26SxZjc5CxaoP5Ie0irpj9jecS4/+yC/yns+Ww=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.205
Date: Fri,  8 May 2026 12:50:35 +0200
Message-ID: <2026050835-appealing-stallion-a207@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026050835-giggly-erratic-e459@gregkh>
References: <2026050835-giggly-erratic-e459@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 293844F550A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244737-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index 3937e96d463f..9fcf204d08af 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 204
+SUBLEVEL = 205
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index c69cee3feff0..0b062959871f 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -921,7 +921,8 @@ static int esp_input(struct xfrm_state *x, struct sk_buff *skb)
 			nfrags = 1;
 
 			goto skip_cow;
-		} else if (!skb_has_frag_list(skb)) {
+		} else if (!skb_has_frag_list(skb) &&
+			   !skb_has_shared_frag(skb)) {
 			nfrags = skb_shinfo(skb)->nr_frags;
 			nfrags++;
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index d674a24217f9..68509e1f89b5 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1443,6 +1443,8 @@ ssize_t	ip_append_page(struct sock *sk, struct flowi4 *fl4, struct page *page,
 			goto error;
 		}
 
+		skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
+
 		if (skb->ip_summed == CHECKSUM_NONE) {
 			__wsum csum;
 			csum = csum_page(page, offset, len);
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index e87f3f8f0681..0aaafc0bd8fa 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -968,7 +968,8 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 			nfrags = 1;
 
 			goto skip_cow;
-		} else if (!skb_has_frag_list(skb)) {
+		} else if (!skb_has_frag_list(skb) &&
+			   !skb_has_shared_frag(skb)) {
 			nfrags = skb_shinfo(skb)->nr_frags;
 			nfrags++;
 

