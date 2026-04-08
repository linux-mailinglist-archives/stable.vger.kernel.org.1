Return-Path: <stable+bounces-234956-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DM+LGOk1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234956-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:54:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 693803C1E59
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 820213010BBA
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8D62727F3;
	Wed,  8 Apr 2026 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QQjMg3SK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C1337B81;
	Wed,  8 Apr 2026 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674198; cv=none; b=klRpXCXQuo/oI04Mb7pG6D1GDKiiJjQ1IIvdE192bFiqPhBU1gvlQTun2n0mxiIQXWWrfqTIxyWYPuq8DwBkewOd6SFNDK0IwvU/WoNUvzCSoNbsUHuMl5upkbA2usCWpVvhW+VY1TYYLK8uCFhUxDT3PIO5RUiuSFrXicmbjtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674198; c=relaxed/simple;
	bh=nz8bBU9H9ygZZHEOt1JIu81GEZAgEgm7207INAfEWxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7CLAQZUSGceZQ1l1aZmIHdjVPeIB8dROEvPgKE6Gnae7LQMqGcd/4za3I7Ijnyn+6JtvmH2f+ibmnnAZtQ9MyHe+FF8LoHDX2dvHfnuWYjKeoRsFQCbbQaNjXliwhKPduP87jZMuOmAveli91oaPp21gwVApDjWb3cgR0u5oZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QQjMg3SK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C18AC19421;
	Wed,  8 Apr 2026 18:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674198;
	bh=nz8bBU9H9ygZZHEOt1JIu81GEZAgEgm7207INAfEWxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QQjMg3SKmRPQ+SCB1zGJT/UgJUXjwr2wKBHy1o4QJ33VHrOZ2c435Q+ur6CEU8QI8
	 fSlUoRo25iO2wBUgXOTbvTKL4PdYiwztl+bHA/dZSDJOj6dj95F3RpcQ0QoqgdD+MS
	 KuqPtTC0uBHGsMy5NmKZi5ijzX+jptQ3SpN2HwSw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 6.12 240/242] bpf: Add third round of bounds deduction
Date: Wed,  8 Apr 2026 20:04:40 +0200
Message-ID: <20260408175936.087726108@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-234956-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 693803C1E59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Chaignon <paul.chaignon@gmail.com>

[ Upstream commit 5dbb19b16ac498b0b7f3a8a85f9d25d6d8af397d ]

Commit d7f008738171 ("bpf: try harder to deduce register bounds from
different numeric domains") added a second call to __reg_deduce_bounds
in reg_bounds_sync because a single call wasn't enough to converge to a
fixed point in terms of register bounds.

With patch "bpf: Improve bounds when s64 crosses sign boundary" from
this series, Eduard noticed that calling __reg_deduce_bounds twice isn't
enough anymore to converge. The first selftest added in "selftests/bpf:
Test cross-sign 64bits range refinement" highlights the need for a third
call to __reg_deduce_bounds. After instruction 7, reg_bounds_sync
performs the following bounds deduction:

  reg_bounds_sync entry:          scalar(smin=-655,smax=0xeffffeee,smin32=-783,smax32=-146)
  __update_reg_bounds:            scalar(smin=-655,smax=0xeffffeee,smin32=-783,smax32=-146)
  __reg_deduce_bounds:
      __reg32_deduce_bounds:      scalar(smin=-655,smax=0xeffffeee,smin32=-783,smax32=-146,umin32=0xfffffcf1,umax32=0xffffff6e)
      __reg64_deduce_bounds:      scalar(smin=-655,smax=0xeffffeee,smin32=-783,smax32=-146,umin32=0xfffffcf1,umax32=0xffffff6e)
      __reg_deduce_mixed_bounds:  scalar(smin=-655,smax=0xeffffeee,umin=umin32=0xfffffcf1,umax=0xffffffffffffff6e,smin32=-783,smax32=-146,umax32=0xffffff6e)
  __reg_deduce_bounds:
      __reg32_deduce_bounds:      scalar(smin=-655,smax=0xeffffeee,umin=umin32=0xfffffcf1,umax=0xffffffffffffff6e,smin32=-783,smax32=-146,umax32=0xffffff6e)
      __reg64_deduce_bounds:      scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e)
      __reg_deduce_mixed_bounds:  scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e)
  __reg_bound_offset:             scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))
  __update_reg_bounds:            scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))

In particular, notice how:
1. In the first call to __reg_deduce_bounds, __reg32_deduce_bounds
   learns new u32 bounds.
2. __reg64_deduce_bounds is unable to improve bounds at this point.
3. __reg_deduce_mixed_bounds derives new u64 bounds from the u32 bounds.
4. In the second call to __reg_deduce_bounds, __reg64_deduce_bounds
   improves the smax and umin bounds thanks to patch "bpf: Improve
   bounds when s64 crosses sign boundary" from this series.
5. Subsequent functions are unable to improve the ranges further (only
   tnums). Yet, a better smin32 bound could be learned from the smin
   bound.

__reg32_deduce_bounds is able to improve smin32 from smin, but for that
we need a third call to __reg_deduce_bounds.

As discussed in [1], there may be a better way to organize the deduction
rules to learn the same information with less calls to the same
functions. Such an optimization requires further analysis and is
orthogonal to the present patchset.

Link: https://lore.kernel.org/bpf/aIKtSK9LjQXB8FLY@mail.gmail.com/ [1]
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Link: https://lore.kernel.org/r/79619d3b42e5525e0e174ed534b75879a5ba15de.1753695655.git.paul.chaignon@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c                               |    1 +
 tools/testing/selftests/bpf/progs/verifier_bounds.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2292,6 +2292,7 @@ static void reg_bounds_sync(struct bpf_r
 	/* We might have learned something about the sign bit. */
 	__reg_deduce_bounds(reg);
 	__reg_deduce_bounds(reg);
+	__reg_deduce_bounds(reg);
 	/* We might have learned some bits from the bounds. */
 	__reg_bound_offset(reg);
 	/* Intersecting with the old var_off might have improved our bounds
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1223,7 +1223,7 @@ l0_%=:	r0 = 0;						\
 SEC("socket")
 __description("bounds deduction cross sign boundary, negative overlap")
 __success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
-__msg("7: (1f) r0 -= r6 {{.*}} R0=scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))")
+__msg("7: (1f) r0 -= r6 {{.*}} R0=scalar(smin=smin32=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,umin32=0xfffffd71,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))")
 __retval(0)
 __naked void bounds_deduct_negative_overlap(void)
 {



