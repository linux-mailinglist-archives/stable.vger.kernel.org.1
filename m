Return-Path: <stable+bounces-253928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPEJJ8aTEWpLnwYAu9opvQ
	(envelope-from <stable+bounces-253928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 13:47:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AB75BEC0A
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 13:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D53ED3031AF0
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 11:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B85D38AC7A;
	Sat, 23 May 2026 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GiQmzRHM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CA9388868;
	Sat, 23 May 2026 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779536760; cv=none; b=exWiBJk1GM/ETTgMcC0Yp6t/pWCFdhpzPziCH1AARf1XEFxgni7PLSqycEdIK56udSVu41InmCLnNTf4OxnE02ZnbQNza3AAfe8wVLNapuHk1WSUREM6sD3QvPY9pjBPbprcQZlIlTZIgUdSEfluKNb3lMOmU3QN908bDTveH1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779536760; c=relaxed/simple;
	bh=EAJtk/wEJAZODOtPr/L44LBB+bJcBmCUX7kP3zPdxtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmpP3vgIjhGSQfoXHeofEpxt1vSlrhosLxWPVgJBdDh7zmIoJ2kzCHou0AW9WrEGBaaheOXdWreIysggtuA5kdBohhWXorC0BsnHzxmTcYJrJQfCDVG/SrvnVmbleFvXBMJsAo7Z9ac2Li1xLW2TvsH/zkk7YBk1Znyeri+6xcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GiQmzRHM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F7E1F00A3A;
	Sat, 23 May 2026 11:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779536758;
	bh=xpZe37Nv2SE7g/oErCQ8XJAa7OrU1c6XHLXGOo6XtXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GiQmzRHMsW4QhXvmN1xuWtpKY92ncPjix9ipFop/Bb9rBC6iF2XlGnLf4RXhzSQ5i
	 zHPT+fIKUINEcVYrTZSkCX0eYGYnjAkjn7bICzpAL36iOMTDYfUyd2bo8IJwe8ekQY
	 3/v+h/JEuOAEmgRDuEr2kMXIQWHkZ2/HnplrFVTQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.257
Date: Sat, 23 May 2026 13:45:55 +0200
Message-ID: <2026052355-superjet-nylon-0596@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026052355-hasty-small-7772@gregkh>
References: <2026052355-hasty-small-7772@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253928-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.964];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 39AB75BEC0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

diff --git a/Makefile b/Makefile
index d8f781615d3e..d3d82c21152f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 256
+SUBLEVEL = 257
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 297a2efd6322..f7100f5af37c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1596,6 +1596,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb, int headroom,
 			skb_frag_ref(skb, i);
 		}
 		skb_shinfo(n)->nr_frags = i;
+		skb_shinfo(n)->tx_flags |= skb_shinfo(skb)->tx_flags & SKBTX_SHARED_FRAG;
 	}
 
 	if (skb_has_frag_list(skb)) {
@@ -3502,6 +3503,8 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 	tgt->ip_summed = CHECKSUM_PARTIAL;
 	skb->ip_summed = CHECKSUM_PARTIAL;
 
+	skb_shinfo(tgt)->tx_flags |= skb_shinfo(skb)->tx_flags & SKBTX_SHARED_FRAG;
+
 	/* Yak, is it really working this way? Some helper please? */
 	skb->len -= shiftlen;
 	skb->data_len -= shiftlen;
@@ -3843,6 +3846,8 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 	p->truesize += skb->truesize;
 	p->len += skb->len;
 
+	skb_shinfo(p)->tx_flags |= skb_shinfo(skb)->tx_flags & SKBTX_SHARED_FRAG;
+
 	NAPI_GRO_CB(skb)->same_flow = 1;
 
 	return 0;
@@ -4076,7 +4081,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		skb_copy_from_linear_data_offset(head_skb, offset,
 						 skb_put(nskb, hsize), hsize);
 
-		skb_shinfo(nskb)->tx_flags |= skb_shinfo(head_skb)->tx_flags &
+		skb_shinfo(nskb)->tx_flags |= (skb_shinfo(head_skb)->tx_flags |
+					       skb_shinfo(frag_skb)->tx_flags) &
 					      SKBTX_SHARED_FRAG;
 
 		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
@@ -4093,6 +4099,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 				nfrags = skb_shinfo(list_skb)->nr_frags;
 				frag = skb_shinfo(list_skb)->frags;
 				frag_skb = list_skb;
+
+				skb_shinfo(nskb)->tx_flags |= skb_shinfo(frag_skb)->tx_flags & SKBTX_SHARED_FRAG;
+
 				if (!skb_headlen(list_skb)) {
 					BUG_ON(!nfrags);
 				} else {
@@ -4309,10 +4318,12 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	p->data_len += len;
 	p->truesize += delta_truesize;
 	p->len += len;
+	skb_shinfo(p)->tx_flags |= skbinfo->tx_flags & SKBTX_SHARED_FRAG;
 	if (lp != p) {
 		lp->data_len += len;
 		lp->truesize += delta_truesize;
 		lp->len += len;
+		skb_shinfo(lp)->tx_flags |= skbinfo->tx_flags & SKBTX_SHARED_FRAG;
 	}
 	NAPI_GRO_CB(skb)->same_flow = 1;
 	return 0;
@@ -5315,6 +5326,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	       from_shinfo->frags,
 	       from_shinfo->nr_frags * sizeof(skb_frag_t));
 	to_shinfo->nr_frags += from_shinfo->nr_frags;
+	if (from_shinfo->nr_frags)
+		to_shinfo->tx_flags |= from_shinfo->tx_flags & SKBTX_SHARED_FRAG;
 
 	if (!skb_cloned(from))
 		from_shinfo->nr_frags = 0;

