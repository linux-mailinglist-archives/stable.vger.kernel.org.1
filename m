Return-Path: <stable+bounces-246964-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMJNBN+3BGplNQIAu9opvQ
	(envelope-from <stable+bounces-246964-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:41:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE1F53830F
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56D6631BC0CF
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DB13A380B;
	Wed, 13 May 2026 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3e4/Fee"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343F13A3E86
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692592; cv=none; b=U7kmiQza5xynD7kjRzLpgO9QeOfSPPhDIEOuR/K6o8k7P+KSVLnh5ij3iwmOq3VS4FJgu2mfprbBrAkBi5PxWr1L0W06q2aEOs1D1C8YkL3BH8RfdhENLbfCP5KYOnswMQKAO083VAoxDzU4EwqsMkcHKGujH0F3E+mCKKHuQ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692592; c=relaxed/simple;
	bh=nAVFpg4isOGPbjKijuKYNA7yFRBlASRw7e6kaIuH7SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7cIb6NzxR1glZPVfw1Lrt2s0KRMAeJHZ7TFFG3aXJtfkycCDrpBwvlnjwcEyMI4wtBZhqUrTqP3x0dLRC3seuGMvRZSAU1a5AaZrRrFCIfxvHc3ByGNLfFFM1SMkHFM5uj0e0YFotkBpZqSDDlg8Cz//W7WEvz2OpUdOdF5/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3e4/Fee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD70C19425;
	Wed, 13 May 2026 17:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778692591;
	bh=nAVFpg4isOGPbjKijuKYNA7yFRBlASRw7e6kaIuH7SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b3e4/FeeijAFzbP6nhPYlPJt8hKyN1HhpLxlclw5ljWmL1I4l0AsZp/LcYCvVAOLi
	 HkO6yi1g1RMarJjKoDQwYQ+DiUR1Ni3wyOmgpFUDECgzoWXul4MVsyOOLhrbPBIpOU
	 eLeqDA0SOx26kkh7n2BAEybj07ng7ZExJJVEyRBUBh0z4Pdm006iqyVj9GqfGIjPXg
	 i7AyPKtSmHKEkGlOFaUG43PXzbHxUdz/E/RFhoRqohhcjlYOcQ72wPgH9JgYa9wEd5
	 6bi+QQFDw03ALsHFOp3exuZnAUg2ygKk75w6IqMb7bFrCa/q8NCEsZ5MzgLmg3U2Wz
	 gg/Cm/i4tTvAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michal Kosiorek <mkosiorek121@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfrm: defensively unhash xfrm_state lists in __xfrm_state_delete
Date: Wed, 13 May 2026 13:16:28 -0400
Message-ID: <20260513171628.3878131-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051212-caucus-caterer-9e72@gregkh>
References: <2026051212-caucus-caterer-9e72@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5FE1F53830F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,secunet.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246964-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:email]
X-Rspamd-Action: no action

From: Michal Kosiorek <mkosiorek121@gmail.com>

[ Upstream commit 14acf9652e5690de3c7486c6db5fb8dafd0a32a3 ]

KASAN reproduces a slab-use-after-free in __xfrm_state_delete()'s
hlist_del_rcu calls under syzkaller load on linux-6.12.y stable
(reproduced on 6.12.47, also reachable via the same code path on
torvalds/master and on the ipsec tree). Nine unique signatures cluster
in the xfrm_state lifecycle, the load-bearing one being:

  BUG: KASAN: slab-use-after-free in __hlist_del include/linux/list.h:990 [inline]
  BUG: KASAN: slab-use-after-free in hlist_del_rcu include/linux/rculist.h:516 [inline]
  BUG: KASAN: slab-use-after-free in __xfrm_state_delete net/xfrm/xfrm_state.c
  Write of size 8 at addr ffff8881198bcb70 by task kworker/u8:9/435

  Workqueue: netns cleanup_net
  Call Trace:
   __hlist_del / hlist_del_rcu
   __xfrm_state_delete
   xfrm_state_delete
   xfrm_state_flush
   xfrm_state_fini
   ops_exit_list
   cleanup_net

The other observed signatures hit the same slab object from
__xfrm_state_lookup, xfrm_alloc_spi, __xfrm_state_insert and an OOB
write variant of __xfrm_state_delete, all on the byseq/byspi
hash chains.

__xfrm_state_delete() guards its byseq and byspi unhashes with
value-based predicates:

	if (x->km.seq)
		hlist_del_rcu(&x->byseq);
	if (x->id.spi)
		hlist_del_rcu(&x->byspi);

while everywhere else in the file (e.g. state_cache, state_cache_input)
the safer hlist_unhashed() check is used. xfrm_alloc_spi() sets
x->id.spi = newspi inside xfrm_state_lock and then immediately inserts
into byspi, but a path that observes x->id.spi != 0 outside of
xfrm_state_lock can still skip-or-hit the byspi unhash inconsistently
with whether x is actually on the list. The same holds for x->km.seq
versus byseq, and the bydst/bysrc unhashes have no predicate at all,
so a second __xfrm_state_delete() on the same object writes through
LIST_POISON pprev.

The defensive change here:

  - Use hlist_del_init_rcu() instead of hlist_del_rcu() on bydst,
    bysrc, byseq and byspi so a second deletion is a no-op rather
    than a write through LIST_POISON pprev. The byseq/byspi nodes
    are already initialised in xfrm_state_alloc().
  - Test hlist_unhashed() rather than the value predicate for
    byseq/byspi, so the unhash decision tracks list state rather than
    mutable scalar fields.

Empirical verification: applied this patch on top of v6.12.47, rebuilt,
and re-ran the same syzkaller harness for 1h16m on a previously-crashy
configuration that produced ~100 hits each of slab-use-after-free
Read in xfrm_alloc_spi / Read in __xfrm_state_lookup / Write in
__xfrm_state_delete. After the patch, 7.1M execs across 32 VMs at
~1550 exec/sec produced zero xfrm_state UAF/OOB hits. /proc/slabinfo
confirms the xfrm_state slab is actively allocated and freed during
the run (~143 KiB resident), so the fuzzer is still exercising those
code paths -- they just no longer crash.

Reproduction:

  - Linux 6.12.47 x86_64 + KASAN_GENERIC + KASAN_INLINE + KCOV
  - syzkaller @ 746545b8b1e4c3a128db8652b340d3df90ce61db
  - 32 QEMU/KVM VMs x 2 vCPU on AWS c5.metal bare metal
  - 9 unique signatures collected in ~9h, all within xfrm_state
    lifecycle

Fixes: fe9f1d8779cb ("xfrm: add state hashtable keyed by seq")
Fixes: 7b4dc3600e48 ("[XFRM]: Do not add a state whose SPI is zero to the SPI hash.")
Reported-by: Michal Kosiorek <mkosiorek121@gmail.com>
Tested-by: Michal Kosiorek <mkosiorek121@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Michal Kosiorek <mkosiorek121@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
[ dropped state_cache/state_cache_input unhash hunks and xfrm_nat_keepalive_state_updated() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_state.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index ca42c9b8cecc3..8ba31cf9b3199 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -752,12 +752,12 @@ int __xfrm_state_delete(struct xfrm_state *x)
 		x->km.state = XFRM_STATE_DEAD;
 		spin_lock(&net->xfrm.xfrm_state_lock);
 		list_del(&x->km.all);
-		hlist_del_rcu(&x->bydst);
-		hlist_del_rcu(&x->bysrc);
-		if (x->km.seq)
-			hlist_del_rcu(&x->byseq);
-		if (x->id.spi)
-			hlist_del_rcu(&x->byspi);
+		hlist_del_init_rcu(&x->bydst);
+		hlist_del_init_rcu(&x->bysrc);
+		if (!hlist_unhashed(&x->byseq))
+			hlist_del_init_rcu(&x->byseq);
+		if (!hlist_unhashed(&x->byspi))
+			hlist_del_init_rcu(&x->byspi);
 		net->xfrm.state_num--;
 		spin_unlock(&net->xfrm.xfrm_state_lock);
 
-- 
2.53.0


