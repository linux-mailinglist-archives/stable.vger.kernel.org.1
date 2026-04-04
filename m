Return-Path: <stable+bounces-233272-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id n2/aJgvJ0GmfAAcAu9opvQ
	(envelope-from <stable+bounces-233272-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:17:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B764F39A5E0
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A419A300EF4A
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 08:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193EF3A4F31;
	Sat,  4 Apr 2026 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATSLLOgr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAAD3A4537
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775290401; cv=none; b=MG5kR8adPDiTkFXWcXh2CF/LApcMupYZKXGpw8nIHQA4KYIE80FRSr8mSemdwvCftBP+UGZ7qEsauLK1aQBjZILBxPygwKSoPj47ebT0NFSM09BLX8pQQ2pDgoVnDTt53AOncqilet6hz1SYFUagR+lmKn+rAucJTn+g0j5WTEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775290401; c=relaxed/simple;
	bh=lZcdYyUNO6qKrlc0H/wzPdy7I6FQutqTRMvIhN4J1oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/oSeEfon2SvD08cBozb5gK+86nSMjPNKwDc2whh2JFLqebhvlVPHjtifsO7vuQyneyffS2NSRq1JrEL1/XH1NhWC1JwgonpVua2KVHAn0orKAvDjuyom1Vh59gCymMN/x7MY4t8tX6kiZb03VbZgqiFfxcWY8MMSmy0kz8/RrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATSLLOgr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48374014a77so32150025e9.3
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 01:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775290399; x=1775895199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f1R65QIWg8P00g8Izukhg397E8WDefcCvMk+OI3vPV8=;
        b=ATSLLOgr6NL2db0TscKqhLWZfw8SSLk16hA3MNUNzFmb/mlJmEkSfLLwxbIx+fcwFm
         4St0whwHV+IW60K9dfUuiXY655p33317MBK7sfKu1mJcvbMgeXrJ5x3wRUFSuCuMP+G+
         ZAXHztADzx7JSJO6w7zv78Tnox/T7lVtdD9KGhPtl/o7bIeMn1m5rRBFIyzrshTUZDel
         lfh3Q2uInD6m8eNrzLBhKmHTVasmM+StepcobPA0wG3S6Xt3uiGd7NVEuwjcJz4BOuqT
         9h/ltb/MhDaMBBCIvzSDwHiWRSjAZs1wpcGfahTSpOQ10YozimQwSN0fl7cTwkft9w6a
         C42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775290399; x=1775895199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1R65QIWg8P00g8Izukhg397E8WDefcCvMk+OI3vPV8=;
        b=S8eWxsPkoKG8Kb6Zl/upOayAK0L4gIJTXZpbJ70c/Kj6LWn3bD1A2wsVRucbnaEOne
         wjKEA+E5oesknh1DfmB+raPnjMoQoU/uB2LdBPcTSg34P5/JknhXqovSZQtOe4xdaHoM
         brPNGonAvLYqaQGLj6M5mUDr02j3XT4FTZ2inHeDksoQNuZEugdVEYN2sAOdojE5XEYy
         YVSodiLcqS7njksuCl/xO94S8bRHL42WYhf8qew5DhxzKWxfEOd6wxgHB2OnZ7d9vMb4
         /vB570ZHpnMJqOS74+kvIC55vsj5j6dHcU7QYz+Kha8d8bZbr56MthiPJjQFJDknyQRt
         0TTQ==
X-Gm-Message-State: AOJu0YzqQfendumiNNGv4wPI5/Wg7Xha3pfVUAYfthZduLZ8mKlZOhax
	9Fnzfnd20jP3LJ2wvzSrzKF8RQlLFkxP7N4Tfe00vLYXEyKjyyG0nf2yzsgpONXn
X-Gm-Gg: AeBDietdNVg35cjTSRJahOwPBZcChxE97zBVny5tXBYkSiAUSCcpTu6Q3MCHpGQQMeS
	WE531b1tJhZwXrer/HVzUlqMrc5wrnIQqE9w++wLf8wcVdOIll1vJxGxaNlhFSpi9xcTOlZNRa2
	q8Zz8YfoX3lAgcbg8IHGzuwnjCWu1X6k59ynryruMNwOg7hLrdDU7dGro2jqr1Po7NTvwP0KfFk
	gMVm31GAE5ECvPK/Hou9+V3384/I80v9h3KlCgsZXvJ2wb4zSupSyD5hdXcZnj6s3fd4ex+ftYv
	nRIafejw0hRQWmYfLn0DAC5vOuX6b82o6+2kv8GbyViduBSdwQ63GsB0gasiCw7TQ5vF7lhGhbY
	XImu5azk/8yJbwJ+haQqRBZwrMcrCaApPgnpRiK3bVyRKHqPs5pdmovaFDAzil4TBzvYQDZftVl
	TUvflP2svWG6d3jHKA7ui7xpnZr+DfOmGzzf3YGXgR827bx6g0b68SzpcdiGxr9TzzeAUxg0FrJ
	Zz2YYAJOjElVfo6BT2ZRzcZRqYjM32bkO6F9yDVvs3kSRWe1MIpTA+jYAsPI7q776IMZ9sMOt20
	p5dyrmop/55V85XJcIIqvLs3vN+cXDrCdfoJaJArIpY=
X-Received: by 2002:a05:600c:4593:b0:485:33ad:3c9f with SMTP id 5b1f17b1804b1-488997de1c6mr91937315e9.25.1775290398685;
        Sat, 04 Apr 2026 01:13:18 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00359acd79a267583c.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:359a:cd79:a267:583c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a3d6944bsm35528045e9.11.2026.04.04.01.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 01:13:18 -0700 (PDT)
Date: Sat, 4 Apr 2026 10:13:16 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.12 4/6] bpf: Add third round of bounds deduction
Message-ID: <c3ad9d44dbf14a110f85902bdc6e119a762e932a.1775289842.git.paul.chaignon@gmail.com>
References: <cover.1775289842.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775289842.git.paul.chaignon@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,suse.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-233272-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B764F39A5E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 kernel/bpf/verifier.c                               | 1 +
 tools/testing/selftests/bpf/progs/verifier_bounds.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6448f9eeede0..4ae3032f42e5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2292,6 +2292,7 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
 	/* We might have learned something about the sign bit. */
 	__reg_deduce_bounds(reg);
 	__reg_deduce_bounds(reg);
+	__reg_deduce_bounds(reg);
 	/* We might have learned some bits from the bounds. */
 	__reg_bound_offset(reg);
 	/* Intersecting with the old var_off might have improved our bounds
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 3924b1d1421b..e6297e9dd2ed 100644
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
-- 
2.43.0


