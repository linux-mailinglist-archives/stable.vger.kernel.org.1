Return-Path: <stable+bounces-253930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Pl/FyyUEWpLnwYAu9opvQ
	(envelope-from <stable+bounces-253930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 13:49:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E117A5BEC3E
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 13:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D92D8304635A
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 11:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0CD38A72A;
	Sat, 23 May 2026 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MUwkWFRU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA7E38AC61;
	Sat, 23 May 2026 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779536768; cv=none; b=Y2SgXOQPLAppjLWGrfeNSVkAoUjJv5zsptBigOEAeSJtCGw1jV2WLFQccLU4Cwht/SbDaxDwO/Bva4VQTjSOr0X495DI3/qE1EwjULo7OJAPexwGFROu2g+zja20m7ZUQr9653wKmTlpfXnREa89uefkpWM6xIdfsZo+Bk5hxYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779536768; c=relaxed/simple;
	bh=GTValV8KsWidRZqN8oOcrC3uescreoCN+VQVfldGr6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hrf4ApvEUwMd8rq2Nu40A41WKhjWBHRbi9YzjiYDXFWN3LMKnYUGFH0agZLdaoAjhAwaoLl0Ev7P1K1oVK32cn6maeQCvli6Pd4FZArz9Z1FTzWx5PId9mZHU2/BijnZ1wdFUAlcMTM9NBQPtRnQAx8IIIMu/2UunXvfr+bZ3Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MUwkWFRU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041AA1F000E9;
	Sat, 23 May 2026 11:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779536764;
	bh=/f/7AFcvREUuoIrkHl9DmCUYLD0x/KX6RDgV77iHmcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MUwkWFRUBaGxplPzkspmDUhIIkAdixCfGsxCfZSV+xeZOuXQe5e+2XIvR+QMESrqF
	 8Hwotxpz3K9xtjnlYO/WLANec0I3/OVCLABTRNRWhHN4BAYotwnUyqqV5MrWZFcpQ3
	 7wc3SmaDSU25U5jKmo+jo1pN+RX0OkJ1T+GhMokc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.208
Date: Sat, 23 May 2026 13:46:00 +0200
Message-ID: <2026052300-cyclic-cruelly-a529@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026052300-comfort-aspire-57fb@gregkh>
References: <2026052300-comfort-aspire-57fb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-253930-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.959];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E117A5BEC3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

diff --git a/Makefile b/Makefile
index 905d708fd87b..1567d457225e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 207
+SUBLEVEL = 208
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d4c821d97b54..a8d09eff26f1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1661,6 +1661,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb, int headroom,
 			skb_frag_ref(skb, i);
 		}
 		skb_shinfo(n)->nr_frags = i;
+		skb_shinfo(n)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
 	}
 
 	if (skb_has_frag_list(skb)) {
@@ -3650,6 +3651,8 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 	tgt->ip_summed = CHECKSUM_PARTIAL;
 	skb->ip_summed = CHECKSUM_PARTIAL;
 
+	skb_shinfo(tgt)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
+
 	/* Yak, is it really working this way? Some helper please? */
 	skb->len -= shiftlen;
 	skb->data_len -= shiftlen;
@@ -4017,6 +4020,8 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 	p->truesize += skb->truesize;
 	p->len += skb->len;
 
+	skb_shinfo(p)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
+
 	NAPI_GRO_CB(skb)->same_flow = 1;
 
 	return 0;
@@ -4251,7 +4256,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		skb_copy_from_linear_data_offset(head_skb, offset,
 						 skb_put(nskb, hsize), hsize);
 
-		skb_shinfo(nskb)->flags |= skb_shinfo(head_skb)->flags &
+		skb_shinfo(nskb)->flags |= (skb_shinfo(head_skb)->flags |
+					    skb_shinfo(frag_skb)->flags) &
 					   SKBFL_SHARED_FRAG;
 
 		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
@@ -4268,6 +4274,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 				nfrags = skb_shinfo(list_skb)->nr_frags;
 				frag = skb_shinfo(list_skb)->frags;
 				frag_skb = list_skb;
+
+				skb_shinfo(nskb)->flags |= skb_shinfo(frag_skb)->flags & SKBFL_SHARED_FRAG;
+
 				if (!skb_headlen(list_skb)) {
 					BUG_ON(!nfrags);
 				} else {
@@ -4490,10 +4499,12 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	p->data_len += len;
 	p->truesize += delta_truesize;
 	p->len += len;
+	skb_shinfo(p)->flags |= skbinfo->flags & SKBFL_SHARED_FRAG;
 	if (lp != p) {
 		lp->data_len += len;
 		lp->truesize += delta_truesize;
 		lp->len += len;
+		skb_shinfo(lp)->flags |= skbinfo->flags & SKBFL_SHARED_FRAG;
 	}
 	NAPI_GRO_CB(skb)->same_flow = 1;
 	return 0;
@@ -5512,6 +5523,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	       from_shinfo->frags,
 	       from_shinfo->nr_frags * sizeof(skb_frag_t));
 	to_shinfo->nr_frags += from_shinfo->nr_frags;
+	if (from_shinfo->nr_frags)
+		to_shinfo->flags |= from_shinfo->flags & SKBFL_SHARED_FRAG;
 
 	if (!skb_cloned(from))
 		from_shinfo->nr_frags = 0;

