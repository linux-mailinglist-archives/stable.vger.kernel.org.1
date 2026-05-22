Return-Path: <stable+bounces-253731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM4hHv4hEGpzUAYAu9opvQ
	(envelope-from <stable+bounces-253731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:29:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 981DF5B1325
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E8C33014BC4
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293AB35DA75;
	Fri, 22 May 2026 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w6Ok8CLA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D833D33C1B4
	for <stable@vger.kernel.org>; Fri, 22 May 2026 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779442017; cv=none; b=KlHwRdrTHi5fl4olU8sotI1aisPXAIVWc/O/h1HnKMvudANv9N22va9q5bV7t/4Np0Po0WbzVC/pHey7Ir6FvsO4QQ86nP47w96Mqwi5dJ6coaA5gO4KUuz0vFDDFab0LK9fewJphRfebG//kb3l5XsgAh7TbXOG0V3kiJzewaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779442017; c=relaxed/simple;
	bh=iKar1HwuIysNc7z3UI7ZeCdaLsnkK3oTiQFoblAMpaA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DnvvxA4WMJAFXCKnPu+Z+kt9odL+CWLcKIiysRl1QI5L9wXucr/oPntfWvpg35Flzy85dlN2LoyDUzSf0L589tPA1d3iNrqTm/8mhS+qXjZ6JV/f2A1awN1UkIb1HnDC9l82CyDThwkzy25ELcThEXqmvomIsJA/DhjCbgKNIjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w6Ok8CLA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BB11F000E9;
	Fri, 22 May 2026 09:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779442015;
	bh=GZ8XpUMXZnw5PUkr0WskGmY/umNAUUz+HdfU3xQ2Fxs=;
	h=Subject:To:Cc:From:Date;
	b=w6Ok8CLAfrss2tYve2V9h0mYn3pWKLcuJRlQqGlLoFjaKRSNg/YdSLJDyKgM2bHJW
	 bQRljI8xP8UVMuaJG2Y0n/3105HL0ipsQ0W6MjH1NyuMg21iyXBfMGUj4u3/KCJwJY
	 TRnqygwB3/2rZ06tC4YdGWFEA6Zx6G6pxLJ12Ad4=
Subject: FAILED: patch "[PATCH] net: skbuff: preserve shared-frag marker during coalescing" failed to apply to 5.10-stable tree
To: vakzz@zellic.io,edumazet@google.com,jiayuan.chen@linux.dev,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 May 2026 11:26:58 +0200
Message-ID: <2026052258-glamorous-basically-d5e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253731-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linux.dev:email,msgid.link:url]
X-Rspamd-Queue-Id: 981DF5B1325
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f84eca5817390257cef78013d0112481c503b4a3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052258-glamorous-basically-d5e2@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f84eca5817390257cef78013d0112481c503b4a3 Mon Sep 17 00:00:00 2001
From: William Bowling <vakzz@zellic.io>
Date: Wed, 13 May 2026 04:16:35 +0000
Subject: [PATCH] net: skbuff: preserve shared-frag marker during coalescing

skb_try_coalesce() can attach paged frags from @from to @to.  If @from
has SKBFL_SHARED_FRAG set, the resulting @to skb can contain the same
externally-owned or page-cache-backed frags, but the shared-frag marker
is currently lost.

That breaks the invariant relied on by later in-place writers.  In
particular, ESP input checks skb_has_shared_frag() before deciding
whether an uncloned nonlinear skb can skip skb_cow_data().  If TCP
receive coalescing has moved shared frags into an unmarked skb, ESP can
see skb_has_shared_frag() as false and decrypt in place over page-cache
backed frags.

Propagate SKBFL_SHARED_FRAG when skb_try_coalesce() transfers paged
frags.  The tailroom copy path does not need the marker because it copies
bytes into @to's linear data rather than transferring frag descriptors.

Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
Signed-off-by: William Bowling <vakzz@zellic.io>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Tested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://patch.msgid.link/20260513041635.1289541-1-vakzz@zellic.io
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7dad68e3b518..9c4e8d331d6d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6200,6 +6200,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	       from_shinfo->frags,
 	       from_shinfo->nr_frags * sizeof(skb_frag_t));
 	to_shinfo->nr_frags += from_shinfo->nr_frags;
+	if (from_shinfo->nr_frags)
+		to_shinfo->flags |= from_shinfo->flags & SKBFL_SHARED_FRAG;
 
 	if (!skb_cloned(from))
 		from_shinfo->nr_frags = 0;


