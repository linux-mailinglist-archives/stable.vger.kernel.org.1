Return-Path: <stable+bounces-246812-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMDGEUZhBGq6HgIAu9opvQ
	(envelope-from <stable+bounces-246812-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:32:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADE8532549
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E88173105F58
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993AB3A6B74;
	Wed, 13 May 2026 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSzhwtq0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C41F3C37A5
	for <stable@vger.kernel.org>; Wed, 13 May 2026 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671551; cv=none; b=HWgDN0Vy3vqXa9ILQwf7U6sG9X9PwMcK3761hca1pD+pUOVjBE1UrDEvE6dZ9dP33ca+0HEUNfxxzPhko28MwqVFKtBc+UwoTxaoHWj2TARBem5635+DW62I3Sf3I75qMQspIv3Pvi7bRAYl9RO9sOTCFEkcUvNYZj+qVNkXSSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671551; c=relaxed/simple;
	bh=uMY1xUzZLmx9pIIhGTvNmYLSQTPG2hCHJdKDHBcbA/I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nMsdqYw353snVl6NlGI1ieQhCc6/tMBoIMsnMZfAi6cdN5p+t6zpHQYq1WYPmovh3zrpnH6jfUvkGLxE89z731flr4VQ1w6w8Yx50vqBGQuTaaZfssJsYxEFNLnoMlf/eviAkudZFd+r5fPXzEho0e6uD7FOa6S0xzdwjVnofTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSzhwtq0; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c7b9f54d3deso4543389a12.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 04:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778671549; x=1779276349; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jC3Oz3urweM8DZ8AQW7ssSyHv2DVXktc02WHM58msu0=;
        b=SSzhwtq0/mE1Jl0f0eAT0b25iQuc1IB8KX1CZqfKb72l+ypb7YkDqOHr3tyzwUlbpV
         LkuC4hRO9xWEFUGqEsAqMRj5CUkP6fKxTR3R/2aFYzQJUwrU1w4ayY2KtIkTjy7t3+m2
         rgWrGWOPt/TLZGUjKj764uEw0NPvqqpT2ozyfWDGBmeR70wbOadRDMHXntFuVydABAfJ
         aRkwb/zUN8klq25joFj6zI2lHtn6Npi/u5uGt5RdsKnzjPepaALvkad9jiAcV4Q8cFrT
         NadwXmJyJIMJ+Fy7fQmmE4OmWU1LBxU9WmkO7JhutzqAlK+S4LqI50mYHZTMBIdD/aep
         KwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778671549; x=1779276349;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jC3Oz3urweM8DZ8AQW7ssSyHv2DVXktc02WHM58msu0=;
        b=Rn4ZPcjqE6gmglKWlZOnxAb40MMNwFiQYMNXXJhbBNU6YD/i2lJfwyJB73VRNsjOjn
         q/+dfzkJ8FKpb+R9YXLp6HVoGJ56KsE0Sf+hGplMbVVAIlhUwVXRXPwxnbiNjFApVOTx
         QvZvSgUNMYvwR9asQ4zXmAFsqvLm89O/UVja84viUJMvlyX26s2nNFADDYM1ilvr9Aah
         rO0LMyxwslOOU4ak5r7iKvvaj64L1opKvszJgr7QSCCI5cvzKkxE4v2K4iAVlafTJIMK
         zsihFT1SdwSSgHDcwASrlGon0NSMDU9j3V02fU5DJojc6vlR9DsclUsHwYyb1ddj7syR
         C0lQ==
X-Gm-Message-State: AOJu0YwdPaNvV5yxCOusPxGxfcJLHC2E8iRafc2of5pEMR6E72kW4Bz8
	0le0QuDy4Vk0s0AmmwJwJ6wxE1KB9RLYoZmWO6gjbjYyW2VlPME3JSQ58SdTyMU8P3E=
X-Gm-Gg: Acq92OEGfW5SaGYFsKJZC+RBwA7Aox3BMdkIfxJOPodRnhPUyNkLjJpyWgdxrk7485O
	iH1uIzMR9HTzgPdisu94wDuMT0KczIVe1PoPW9MQaRmQhEAN1O5jpaUjKsw/j5v+bdfXWp8D1et
	8C1yfpq/xxV909H9t3gHelgmj7l9vuCAk0Fi2aAAgUzh7Ei61cthJQDx/gy/QF+B11idZvOh5QV
	zyYVah0quFHvSkNiOcSqN6f05PyiSwNeC16t781g/YHoQjY4FUt6yoQbMLlolggfPjyaxMKwAdX
	Utr5RVZ5JufPagXU/Wl9+fC280cEldjQvspuCZyC3xREyzzwl3a6MYpGhIOFwHmDyldT7FFMAIm
	hZgUrQMCqDrfGD6lw8m4H6WxP4qxFce/KroIaZD5/1Lw/N+MYvzTjB55rPAtfJP8GW/uCOFc0zF
	n/rQ2dY2oVgiKJ0OnVy7fkbOd6VfJEeB3/NWORMzQMy9s=
X-Received: by 2002:a17:903:458:b0:2bd:412:21fb with SMTP id d9443c01a7336-2bd2714691fmr22745275ad.8.1778671549342;
        Wed, 13 May 2026 04:25:49 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d52ef9sm164810685ad.35.2026.05.13.04.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:25:48 -0700 (PDT)
Date: Wed, 13 May 2026 20:25:45 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, dsahern@kernel.org, vakzz@zellic.io
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] net: skbuff: propagate shared-frag marker through
 pskb_copy()
Message-ID: <agRfuVOeMI5pbHhY@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 9ADE8532549
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246812-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zellic.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

__pskb_copy_fclone() shallow-copies the source's frag descriptors and
bumps each page's refcount via skb_frag_ref(), then defers the rest
of the shinfo metadata to skb_copy_header().  That helper only carries
over gso_{size,segs,type} and never touches skb_shinfo()->flags, so
the destination skb keeps a reference to the same externally-owned or
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
 net/core/skbuff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7dad68e3b518..15bdec53e8d9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2248,6 +2248,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb, int headroom,
 			skb_frag_ref(skb, i);
 		}
 		skb_shinfo(n)->nr_frags = i;
+		skb_shinfo(n)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
 	}
 
 	if (skb_has_frag_list(skb)) {
@@ -6200,6 +6201,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	       from_shinfo->frags,
 	       from_shinfo->nr_frags * sizeof(skb_frag_t));
 	to_shinfo->nr_frags += from_shinfo->nr_frags;
+	if (from_shinfo->nr_frags)
+		to_shinfo->flags |= from_shinfo->flags & SKBFL_SHARED_FRAG;
 
 	if (!skb_cloned(from))
 		from_shinfo->nr_frags = 0;
-- 
2.43.0


