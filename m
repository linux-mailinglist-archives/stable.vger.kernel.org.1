Return-Path: <stable+bounces-153961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78790ADD7A2
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF70716AA87
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B297D23AE84;
	Tue, 17 Jun 2025 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="doqQoYIZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4578F54;
	Tue, 17 Jun 2025 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177655; cv=none; b=mDsg1aLbf6kflll1RxgjpPfccrgvHtZIfjV4gq2HN0qiZ8Kk95N8zt9nNNhL+j+bXGO5TNs7uzcPTqs6GZ3CR+baCoAWL5Yp1UFY8/rpbYivLJHUE9gAi/XTi1K4mCA/T/AbQ1j0bZNse773IHEEZyMfXTSJdYmSAEUMeHtWM7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177655; c=relaxed/simple;
	bh=134HMdCDzmf/bzAQf/8XLQr8H9GMo76Yx8iCuLXbVjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHYBVfxG9M0ELgbbklCaz8uvlnX+dFWenh3DfJ5/478Gg3Hy5A9EoLPQsxA9tIeXC/j5d76oc8YGL8yQmnEuzhRvIYhq3hj0HPZkIlP64fzOKNVrMsA9SkD66pK/ElsTYWwpXl3QM2R/e9+jcMKsgmmtk8LuWCYp2KgLOj7ARqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=doqQoYIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14F7C4CEE3;
	Tue, 17 Jun 2025 16:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750177655;
	bh=134HMdCDzmf/bzAQf/8XLQr8H9GMo76Yx8iCuLXbVjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=doqQoYIZj1ojrqcJaWss2FhWoDJho/uRNxU0mFgoTwaiUmJ6cQjD+sZuqrlAi6E0x
	 1WXLmBn/VC1NgP50jDsdAMlbiRzNQLkFwG6fs0uTVVuN6YbIi5D+yrXnsYo467Laf4
	 kT4c4s/3Yby5jhErHw8D0hbTcr5YpY0Mr0TBrfg8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yafang Shao <laoar.shao@gmail.com>,
	Shaun Brady <brady.1345@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 377/512] netfilter: nf_nat: also check reverse tuple to obtain clashing entry
Date: Tue, 17 Jun 2025 17:25:43 +0200
Message-ID: <20250617152434.873509318@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 50d9ce9679dd50df2dc51ada717fa875bc248fad ]

The logic added in the blamed commit was supposed to only omit nat source
port allocation if neither the existing nor the new entry are subject to
NAT.

However, its not enough to lookup the conntrack based on the proposed
tuple, we must also check the reverse direction.

Otherwise there are esoteric cases where the collision is in the reverse
direction because that colliding connection has a port rewrite, but the
new entry doesn't.  In this case, we only check the new entry and then
erronously conclude that no clash exists anymore.

 The existing (udp) tuple is:
  a:p -> b:P, with nat translation to s:P, i.e. pure daddr rewrite,
  reverse tuple in conntrack table is s:P -> a:p.

When another UDP packet is sent directly to s, i.e. a:p->s:P, this is
correctly detected as a colliding entry: tuple is taken by existing reply
tuple in reverse direction.

But the colliding conntrack is only searched for with unreversed
direction, and we can't find such entry matching a:p->s:P.

The incorrect conclusion is that the clashing entry has timed out and
that no port address translation is required.

Such conntrack will then be discarded at nf_confirm time because the
proposed reverse direction clashes with an existing mapping in the
conntrack table.

Search for the reverse tuple too, this will then check the NAT bits of
the colliding entry and triggers port reallocation.

Followp patch extends nft_nat.sh selftest to cover this scenario.

The IPS_SEQ_ADJUST change is also a bug fix:
Instead of checking for SEQ_ADJ this tested for SEEN_REPLY and ASSURED
by accident -- _BIT is only for use with the test_bit() API.

This bug has little consequence in practice, because the sequence number
adjustments are only useful for TCP which doesn't support clash resolution.

The existing test case (conntrack_reverse_clash.sh) exercise a race
condition path (parallel conntrack creation on different CPUs), so
the colliding entries have neither SEEN_REPLY nor ASSURED set.

Thanks to Yafang Shao and Shaun Brady for an initial investigation
of this bug.

Fixes: d8f84a9bc7c4 ("netfilter: nf_nat: don't try nat source port reallocation for reverse dir clash")
Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1795
Reported-by: Yafang Shao <laoar.shao@gmail.com>
Reported-by: Shaun Brady <brady.1345@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Tested-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_nat_core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index 4085c436e3062..02f10a46fab7c 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -248,7 +248,7 @@ static noinline bool
 nf_nat_used_tuple_new(const struct nf_conntrack_tuple *tuple,
 		      const struct nf_conn *ignored_ct)
 {
-	static const unsigned long uses_nat = IPS_NAT_MASK | IPS_SEQ_ADJUST_BIT;
+	static const unsigned long uses_nat = IPS_NAT_MASK | IPS_SEQ_ADJUST;
 	const struct nf_conntrack_tuple_hash *thash;
 	const struct nf_conntrack_zone *zone;
 	struct nf_conn *ct;
@@ -287,8 +287,14 @@ nf_nat_used_tuple_new(const struct nf_conntrack_tuple *tuple,
 	zone = nf_ct_zone(ignored_ct);
 
 	thash = nf_conntrack_find_get(net, zone, tuple);
-	if (unlikely(!thash)) /* clashing entry went away */
-		return false;
+	if (unlikely(!thash)) {
+		struct nf_conntrack_tuple reply;
+
+		nf_ct_invert_tuple(&reply, tuple);
+		thash = nf_conntrack_find_get(net, zone, &reply);
+		if (!thash) /* clashing entry went away */
+			return false;
+	}
 
 	ct = nf_ct_tuplehash_to_ctrack(thash);
 
-- 
2.39.5




