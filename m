Return-Path: <stable+bounces-80839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BEB990BB3
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AB41C210F3
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FA71E7C1B;
	Fri,  4 Oct 2024 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVsJr4fR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F661E7C0D;
	Fri,  4 Oct 2024 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066021; cv=none; b=UIQ8F7qrKx5MubrO1bracBwICFfjDvpReow+ssBCHQcHDuvX4plhQiUMd69EqTfXnmdzkWKxDbIe5Mm+NTRfIrUKxhOybcpw84pvtm1bFYHZpLMdBai8AHSY5BD0mlvRry5FrIOnHgnaCBXN2Tq7txk5pn/zLTX37ci3Rg6gtZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066021; c=relaxed/simple;
	bh=UoREA1gRIdfQBsHi0CWufZCyDNTMXVKrLh/hCnPluYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=om1yoavilzkZ3Q9xyAQ8TbeaPSIr0dDfpTkz8SJXPEfmtusFaNTllo4TMoEjkAbD8gA5DLlkVeGMvO22xzleDSduw2hCM3qGc0l64bfCPgsodtO/uGkIiLAGVjOrk2iEPrfnd6wzqfuh99mdHLPIaNI2dA+qB+D+8xfBNw/GSbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVsJr4fR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16158C4CECC;
	Fri,  4 Oct 2024 18:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066021;
	bh=UoREA1gRIdfQBsHi0CWufZCyDNTMXVKrLh/hCnPluYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LVsJr4fRDuKRjlsZa62O0Mle2i2/hyurdg2+twosXMHDYtSQtlvGBTn02DuMKmSDt
	 JVvEYTHLrIZUTq3gl2czv6EGhTXolqSR6b4WvmkoAAw5STwS27TG3J/48TO7OE+CiA
	 aqGQ/KNha4KG0bPuibGTvZQbKTavDrkEI9k9WvwuFKLJsOcVik6s2hyrBf91vGNVMr
	 gN4hFyER6M0cxlNuaOkQNk5nOlfszgqBhMW/jmIXh7Rl83t0Ca7BNtSRcn/D/FFTW7
	 lzybInYaEG+k7UFqMhpKStGE5OoG6TGcymoBvaFet9LMtJhcy14g2woYVG7Ve4E+Zw
	 66uVl4B2TsWtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>,
	kadlec@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 59/76] netfilter: nf_nat: don't try nat source port reallocation for reverse dir clash
Date: Fri,  4 Oct 2024 14:17:16 -0400
Message-ID: <20241004181828.3669209-59-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit d8f84a9bc7c4e07fdc4edc00f9e868b8db974ccb ]

A conntrack entry can be inserted to the connection tracking table if there
is no existing entry with an identical tuple in either direction.

Example:
INITIATOR -> NAT/PAT -> RESPONDER

Initiator passes through NAT/PAT ("us") and SNAT is done (saddr rewrite).
Then, later, NAT/PAT machine itself also wants to connect to RESPONDER.

This will not work if the SNAT done earlier has same IP:PORT source pair.

Conntrack table has:
ORIGINAL: $IP_INITATOR:$SPORT -> $IP_RESPONDER:$DPORT
REPLY:    $IP_RESPONDER:$DPORT -> $IP_NAT:$SPORT

and new locally originating connection wants:
ORIGINAL: $IP_NAT:$SPORT -> $IP_RESPONDER:$DPORT
REPLY:    $IP_RESPONDER:$DPORT -> $IP_NAT:$SPORT

This is handled by the NAT engine which will do a source port reallocation
for the locally originating connection that is colliding with an existing
tuple by attempting a source port rewrite.

This is done even if this new connection attempt did not go through a
masquerade/snat rule.

There is a rare race condition with connection-less protocols like UDP,
where we do the port reallocation even though its not needed.

This happens when new packets from the same, pre-existing flow are received
in both directions at the exact same time on different CPUs after the
conntrack table was flushed (or conntrack becomes active for first time).

With strict ordering/single cpu, the first packet creates new ct entry and
second packet is resolved as established reply packet.

With parallel processing, both packets are picked up as new and both get
their own ct entry.

In this case, the 'reply' packet (picked up as ORIGINAL) can be mangled by
NAT engine because a port collision is detected.

This change isn't enough to prevent a packet drop later during
nf_conntrack_confirm(), the existing clash resolution strategy will not
detect such reverse clash case.  This is resolved by a followup patch.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_nat_core.c | 120 +++++++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index 016c816d91cbc..c212b1b137222 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -183,7 +183,35 @@ hash_by_src(const struct net *net,
 	return reciprocal_scale(hash, nf_nat_htable_size);
 }
 
-/* Is this tuple already taken? (not by us) */
+/**
+ * nf_nat_used_tuple - check if proposed nat tuple clashes with existing entry
+ * @tuple: proposed NAT binding
+ * @ignored_conntrack: our (unconfirmed) conntrack entry
+ *
+ * A conntrack entry can be inserted to the connection tracking table
+ * if there is no existing entry with an identical tuple in either direction.
+ *
+ * Example:
+ * INITIATOR -> NAT/PAT -> RESPONDER
+ *
+ * INITIATOR passes through NAT/PAT ("us") and SNAT is done (saddr rewrite).
+ * Then, later, NAT/PAT itself also connects to RESPONDER.
+ *
+ * This will not work if the SNAT done earlier has same IP:PORT source pair.
+ *
+ * Conntrack table has:
+ * ORIGINAL: $IP_INITIATOR:$SPORT -> $IP_RESPONDER:$DPORT
+ * REPLY:    $IP_RESPONDER:$DPORT -> $IP_NAT:$SPORT
+ *
+ * and new locally originating connection wants:
+ * ORIGINAL: $IP_NAT:$SPORT -> $IP_RESPONDER:$DPORT
+ * REPLY:    $IP_RESPONDER:$DPORT -> $IP_NAT:$SPORT
+ *
+ * ... which would mean incoming packets cannot be distinguished between
+ * the existing and the newly added entry (identical IP_CT_DIR_REPLY tuple).
+ *
+ * @return: true if the proposed NAT mapping collides with an existing entry.
+ */
 static int
 nf_nat_used_tuple(const struct nf_conntrack_tuple *tuple,
 		  const struct nf_conn *ignored_conntrack)
@@ -200,6 +228,94 @@ nf_nat_used_tuple(const struct nf_conntrack_tuple *tuple,
 	return nf_conntrack_tuple_taken(&reply, ignored_conntrack);
 }
 
+static bool nf_nat_allow_clash(const struct nf_conn *ct)
+{
+	return nf_ct_l4proto_find(nf_ct_protonum(ct))->allow_clash;
+}
+
+/**
+ * nf_nat_used_tuple_new - check if to-be-inserted conntrack collides with existing entry
+ * @tuple: proposed NAT binding
+ * @ignored_ct: our (unconfirmed) conntrack entry
+ *
+ * Same as nf_nat_used_tuple, but also check for rare clash in reverse
+ * direction. Should be called only when @tuple has not been altered, i.e.
+ * @ignored_conntrack will not be subject to NAT.
+ *
+ * @return: true if the proposed NAT mapping collides with existing entry.
+ */
+static noinline bool
+nf_nat_used_tuple_new(const struct nf_conntrack_tuple *tuple,
+		      const struct nf_conn *ignored_ct)
+{
+	static const unsigned long uses_nat = IPS_NAT_MASK | IPS_SEQ_ADJUST_BIT;
+	const struct nf_conntrack_tuple_hash *thash;
+	const struct nf_conntrack_zone *zone;
+	struct nf_conn *ct;
+	bool taken = true;
+	struct net *net;
+
+	if (!nf_nat_used_tuple(tuple, ignored_ct))
+		return false;
+
+	if (!nf_nat_allow_clash(ignored_ct))
+		return true;
+
+	/* Initial choice clashes with existing conntrack.
+	 * Check for (rare) reverse collision.
+	 *
+	 * This can happen when new packets are received in both directions
+	 * at the exact same time on different CPUs.
+	 *
+	 * Without SMP, first packet creates new conntrack entry and second
+	 * packet is resolved as established reply packet.
+	 *
+	 * With parallel processing, both packets could be picked up as
+	 * new and both get their own ct entry allocated.
+	 *
+	 * If ignored_conntrack and colliding ct are not subject to NAT then
+	 * pretend the tuple is available and let later clash resolution
+	 * handle this at insertion time.
+	 *
+	 * Without it, the 'reply' packet has its source port rewritten
+	 * by nat engine.
+	 */
+	if (READ_ONCE(ignored_ct->status) & uses_nat)
+		return true;
+
+	net = nf_ct_net(ignored_ct);
+	zone = nf_ct_zone(ignored_ct);
+
+	thash = nf_conntrack_find_get(net, zone, tuple);
+	if (unlikely(!thash)) /* clashing entry went away */
+		return false;
+
+	ct = nf_ct_tuplehash_to_ctrack(thash);
+
+	/* NB: IP_CT_DIR_ORIGINAL should be impossible because
+	 * nf_nat_used_tuple() handles origin collisions.
+	 *
+	 * Handle remote chance other CPU confirmed its ct right after.
+	 */
+	if (thash->tuple.dst.dir != IP_CT_DIR_REPLY)
+		goto out;
+
+	/* clashing connection subject to NAT? Retry with new tuple. */
+	if (READ_ONCE(ct->status) & uses_nat)
+		goto out;
+
+	if (nf_ct_tuple_equal(&ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple,
+			      &ignored_ct->tuplehash[IP_CT_DIR_REPLY].tuple) &&
+	    nf_ct_tuple_equal(&ct->tuplehash[IP_CT_DIR_REPLY].tuple,
+			      &ignored_ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple)) {
+		taken = false;
+		goto out;
+	}
+out:
+	nf_ct_put(ct);
+	return taken;
+}
+
 static bool nf_nat_may_kill(struct nf_conn *ct, unsigned long flags)
 {
 	static const unsigned long flags_refuse = IPS_FIXED_TIMEOUT |
@@ -611,7 +727,7 @@ get_unique_tuple(struct nf_conntrack_tuple *tuple,
 	    !(range->flags & NF_NAT_RANGE_PROTO_RANDOM_ALL)) {
 		/* try the original tuple first */
 		if (nf_in_range(orig_tuple, range)) {
-			if (!nf_nat_used_tuple(orig_tuple, ct)) {
+			if (!nf_nat_used_tuple_new(orig_tuple, ct)) {
 				*tuple = *orig_tuple;
 				return;
 			}
-- 
2.43.0


