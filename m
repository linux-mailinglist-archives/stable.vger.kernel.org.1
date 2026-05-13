Return-Path: <stable+bounces-247037-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8O5mCizoBGqnQQIAu9opvQ
	(envelope-from <stable+bounces-247037-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 23:07:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F217553AD54
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 23:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33321300B9E9
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 21:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34578395AF2;
	Wed, 13 May 2026 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyT84jP3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CCC3955C1
	for <stable@vger.kernel.org>; Wed, 13 May 2026 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778706472; cv=none; b=L+nm478Be+d8TDw9DnzasF0qJYlwue57DQ/eI16L2W7HeDEE604fw/LnuGYXxAVwdd3PVPzJfyOTXeDNi61MckoMBl2R3OyToJiWgr07fm1fYvJIAfTsqf/0P0jTnuLrqT5OlhqPLOjkO3vJuwP/9AgQGvPRzK2eYKnIkwwfvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778706472; c=relaxed/simple;
	bh=uKjpy6mZcAKH6MrZUZmS6VAiqXKWfj84zFJxwe+av8I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V6bRm219Ym4OMx/tGN5Ud3nLaI5gWQuDNIYpQazQFZVl+n1uFIB7BvgKyasj5Ys8m8+8FILu4eGSX3qU1RI+PnNQr6cjh3NcrrZ3FqPPKka51hQfG2iaOh/HKXWzNVNPYtri7jINmfZb1gsefQDKrC3Dc6jzjpBdu4LxIHZKb5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyT84jP3; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c828daf83e2so2010339a12.2
        for <stable@vger.kernel.org>; Wed, 13 May 2026 14:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778706470; x=1779311270; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lmUB95Voc4Y//0lmslcCl8gB+7WwYY40nezEV7x/XVs=;
        b=QyT84jP3xP8jgw/9kq+ZWcpg4BflotMXsohLI7UhHnOX/brBb+Q/RVHhcB29eUfgIX
         CWBP3xZLZTbrsdd6dkrlL7Amjo6tBrbStp0eP1aqs7tjh2Ad3DzeKK5WHngTbFfUL87d
         4cfLLgztJ4LFrfz1meZAxfnNIbGFlhBbrr24gN+O0HAFNEWoj3WPGrLod0CckBGaHmum
         d0P7Sfhey3oycHPEtP7DcmkmtqXXyxAyKrxQpN4InWccQeE/bsrqxBy7+c3lKqM0DKh1
         DqkBJQHKH07RhxvHDrRC3P+gK9sw7sb8ILi6xveXXh0coPotfz86ZyCkGs2NK3UzcEpF
         M+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778706470; x=1779311270;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmUB95Voc4Y//0lmslcCl8gB+7WwYY40nezEV7x/XVs=;
        b=es6SyYS9izT5ZDuh11kCE60YQurb6vi0QXx3GeB4PuCIm13/2VdWnwijBdi7veCMXX
         JGrk+r6L18Yp4f7gAEetSHLtR+ozk9sQ37coz/txmsCAylmJxZUcbpjaPreWaCYt1Ehx
         qF2+Msw49WuFvUl24GDvaStDhQ8skJ5qApwqQagOOYfP+/9iJHP80sMTbx4PLnXA1eMJ
         BuE5eB+uzi4/FJL1cbPprWjd9HdxK20c34If2GhGMA2p3ZnEXnbhSMRoDfoI3dpCU2fE
         aB4LX7IW0xX3Iupp6tw6g3eS6sDGz2LFZT6WPT+AO/bnJ7lAhM1fhlVq/PUyDy+FPtlD
         n9ag==
X-Forwarded-Encrypted: i=1; AFNElJ/lSc7UohXSVJ0LLGvopgqZ+0H/dh0ah3OxUtY9y/4Iuys/m9U6+DK0J3XxEFEqOe/yDKROcM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqN5cHqZI53SfbHuEIfKODDrefVd9zKFc0qy2JWL8l6s3X3RvU
	hWK87cNLZk7vUPUWrJ4s2cIxxZjhmqVaSRlxMYFmgeOdO2N4TiE9/c9e
X-Gm-Gg: Acq92OE/wMj3NHRb07eO+Ywj734ZeIEx0jQQGIky4jI5+4cdK+aWiALcyY/q9//Nfq6
	AHqlNNxeaynWkwACSTQNcrdgiAohna0Dg0YqFjVrL5M9wbZoSKQEZtQCba/jnJXtRoSAHnE7YBw
	ggYBgjJca/3p0bFgVNJffL2nsxH1AoTwNmr4+cz3Dr3/iGmX7CiKEqh+DmEA9K9f7lByc+kLNhn
	aG/4slljx7Ah+qHvV9RYVB4fOhLcQ626Jm6as4gjKURbFlWElN+vfN8k3/ES8Kl/wZuKweRZzk+
	TAPfS3GPVewzJOK9ll0AWqOzNqlh/xoq90gknGUH0dmWW4zvGHdNOcTFNkMeNP3T52+lTGPjKYT
	QkhMZSbhk/ncC9tbgy9zrFXlzeIcNhoYhiPP2QOYVrEuhBgRqdAqTF3i0rO0+GNSccKRjqaQYdk
	mP+3rk4vPEIzJPGsJsxrlbbRxcdgq2UBujk2G2C5DjZf9UEISRjAvmLw==
X-Received: by 2002:a17:90a:c105:b0:368:5367:d681 with SMTP id 98e67ed59e1d1-368f782ef5amr4634594a91.10.1778706469883;
        Wed, 13 May 2026 14:07:49 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3692e72c584sm189648a91.6.2026.05.13.14.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:07:49 -0700 (PDT)
Date: Thu, 14 May 2026 06:07:44 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
	kuniyu@google.com, mhal@rbox.co, jiayuan.chen@linux.dev,
	steffen.klassert@secunet.com, vakzz@zellic.io, ben@decadent.org.uk,
	herbert@gondor.apana.org.au, dsahern@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net v2] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <agToIEDI4TaTNLRb@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: F217553AD54
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247037-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co,linux.dev,secunet.com,zellic.io,decadent.org.uk,gondor.apana.org.au];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,zellic.io:email]
X-Rspamd-Action: no action

Three frag-transfer helpers (__pskb_copy_fclone(), skb_try_coalesce(),
and skb_shift()) fail to propagate the SKBFL_SHARED_FRAG bit in
skb_shinfo()->flags when moving frags from source to destination.
__pskb_copy_fclone() defers the rest of the shinfo metadata to
skb_copy_header() after copying frag descriptors, but that helper
only carries over gso_{size,segs,type} and never touches
skb_shinfo()->flags; skb_try_coalesce() and skb_shift() move frag
descriptors directly and leave flags untouched.  As a result, the
destination skb keeps a reference to the same externally-owned or
page-cache-backed pages while reporting skb_has_shared_frag() as
false.

The mismatch is harmful in any in-place writer that uses
skb_has_shared_frag() to decide whether shared pages must be detoured
through skb_cow_data().  ESP input is one such writer (esp4.c,
esp6.c), and a single nft 'dup to <local>' rule -- or any other
nf_dup_ipv4() / xt_TEE caller -- is enough to land a pskb_copy()'d
skb in esp_input() with the marker stripped, letting an unprivileged
user write into the page cache of a root-owned read-only file via
authencesn-ESN stray writes.

Set SKBFL_SHARED_FRAG on the destination whenever frag descriptors
were actually moved from the source.  skb_copy() and skb_copy_expand()
share skb_copy_header() too but linearize all paged data into freshly
allocated head storage and emerge with nr_frags == 0, so
skb_has_shared_frag() returns false on its own; they need no change.

Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
Reported-by: William Bowling <vakzz@zellic.io>
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Also propagate SHARED_FRAG in skb_shift()
- v1: https://lore.kernel.org/all/agRfuVOeMI5pbHhY@v4bel/
---
 net/core/skbuff.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7dad68e3b518..7cd388504297 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2248,6 +2248,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb, int headroom,
 			skb_frag_ref(skb, i);
 		}
 		skb_shinfo(n)->nr_frags = i;
+		skb_shinfo(n)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
 	}
 
 	if (skb_has_frag_list(skb)) {
@@ -4349,6 +4350,8 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 	tgt->ip_summed = CHECKSUM_PARTIAL;
 	skb->ip_summed = CHECKSUM_PARTIAL;
 
+	skb_shinfo(tgt)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
+
 	skb_len_add(skb, -shiftlen);
 	skb_len_add(tgt, shiftlen);
 
@@ -6200,6 +6203,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	       from_shinfo->frags,
 	       from_shinfo->nr_frags * sizeof(skb_frag_t));
 	to_shinfo->nr_frags += from_shinfo->nr_frags;
+	if (from_shinfo->nr_frags)
+		to_shinfo->flags |= from_shinfo->flags & SKBFL_SHARED_FRAG;
 
 	if (!skb_cloned(from))
 		from_shinfo->nr_frags = 0;
-- 
2.43.0


