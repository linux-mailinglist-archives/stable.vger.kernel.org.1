Return-Path: <stable+bounces-233198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMAQGI3gz2kS1gYAu9opvQ
	(envelope-from <stable+bounces-233198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:45:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CAD395E93
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1914308F3E3
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 15:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C233BC689;
	Fri,  3 Apr 2026 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbwewWdV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6028A23ABA8
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230645; cv=none; b=X+uiaKLEc0huzSXd6NNcO/LNodNmm84mBFYohM9KqANI3+mvhbYvAsSyR7cehV8aGJpGkSuvzu2nd3MwTEHLRcBSyxSeU4Mmgophq9gB+nCM/QM4yW1+sx0hK1gbmSFicn4f+zuYcrvhlssXwjaGUgmjhbgz5i+v+l3/YoKXGo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230645; c=relaxed/simple;
	bh=lZcdYyUNO6qKrlc0H/wzPdy7I6FQutqTRMvIhN4J1oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmDPrvVyGpeM1FnmBklQenW8wewrjKh0VZOvkAsSSag5LQkRQV2+dlDzPOLmp0z8estixUliLm9fl59DRLqCJ6rqyD0vXFsmtMapxCw4i+swTCm/UJwWJnIztz7ovLvESPRYwVVYwp4rpoPyjwVrq77G7rvcNUnTPif9Q2d+qFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbwewWdV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-482f454be5bso33474025e9.0
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775230643; x=1775835443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f1R65QIWg8P00g8Izukhg397E8WDefcCvMk+OI3vPV8=;
        b=SbwewWdVYqSWQCtyaHLLCro4IVMlwCR5WcuQRpB5+2orZMoS3TfPx6+vzYmY3YhSAx
         gg9W5LMr50GWugjHCkApMOhKPlvbT5x/lqcuP7lt8nvXOJWZE3bx7Ck+p0vPZ1ncuR+8
         RS2cNCkO6dbpL4slOwTufpnNXSkMN3DcmV7lfkrN+Fa7rOOhQL3CkVAjHzCaTnkIMUPJ
         VYpPHnmzIobcHkLFh9egbYt0ENKLOKI8ncnKWDyWlBWQ8DQ2BtW6CqAgRarju3dRC6mF
         hpSuYyq6Fbz9Pz0SHkzgL9K43uOJzgobUFZWYrtB7pErakpdchCq2uZ05XY1aqkIjlUd
         s5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775230643; x=1775835443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1R65QIWg8P00g8Izukhg397E8WDefcCvMk+OI3vPV8=;
        b=ZDg02nCFqnxzrq3U5l0g7dMDWNfCOd8+tZShx4XVQTjXod8hgsVSU4KuHSvXvt1KNq
         XTDyVRjd0qbZMBgQ5MBiaws/l8FjoTwrqzhuphmDSuo+PndxLr7abKas+/4nk3VF3/5t
         cRyNHhusO+316yiwgB0hpPxkreV7EXKJD4M2yWU1M45uAQStduOFgR0RaPP4ENKYp3b8
         b1a8dwBnt1FfF5NEDqnVuf52yzvpV0o5J0U9H4xrOvSL2M+1haKhy/VqTR0X2SLzFmJC
         jyOWViwXDgkUB/w9ZU7eX/7+1T6ogZuBJKr1CB1B07cu8zcsF/1SNemShlP4VPNylz6X
         fXkQ==
X-Gm-Message-State: AOJu0YzjsgjFzvHwKXQ3fngCQLqBfRDeKrfBxo4OFkDmnkFVx1yfkMFH
	vjBdQ6fzW70X2D35H7hbTwcrEGjN4vcvf5tNkCfMk9owocOborYu2CEZ47QUb4Mc
X-Gm-Gg: ATEYQzyXvMJ6ogboMGf3i9mV3kr/d/HAX1XT862R03VfJP28KykE5nb/f6RZIrdEqqZ
	EzFBLNpD7PNEN5FyFR8HpA0b7fcROLGuVUh3gmcNaRAAqyepHDIv2j9I6Xi/UOenuaow3JHNVaG
	+P96UFpaFcAjlvwPQu0oKLdVDZ4LdxE1ADSJ+qi14Q2UbkLfMffneUWw6PlzWs8GtEWPeVVoRd4
	nsn/phHkKa8voxgn/UwFiLf8WLUnVAc/MaMGlM4mtJ2OQE5J3X3d/UzCryYgKK1mRBWxQrGrrwq
	OcRnV0rudVMYZ0g9RU3VXGETAvjmCK47Nd3r6YcdfDFVqxx2ACN3WzjoYgOLvRBSQsV6z2Mu+3/
	d6IdpS7GvF2wQmqmtMD7+ZTZ8oxNQnXpqpSF2+1rGZo3jvO/ENSW2eTTQGNwRV3J+btwcN9Dj8L
	cih+66sHzyrRdy9Yl4iPfIaW4NQhdrmwwtoFALablqFnykxlLyVbjt9vWlWnBmbw7dn1aL3swKw
	0r6PyX8f0Tm8W1z9qPh+EkmP/L7OWsB0fE7NoiFqAh0BP70hXhD3H8Dy4zY3kjmCFdaYVyAbCQ+
	2y/iyaXH4ZqLSRxoFwPTc/uL7y/e+XmXd6LS6sAoijQ=
X-Received: by 2002:a05:600c:5289:b0:487:22ad:403e with SMTP id 5b1f17b1804b1-488994b34b4mr62690805e9.14.1775230642765;
        Fri, 03 Apr 2026 08:37:22 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00c96ae484ac75459c.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:c96a:e484:ac75:459c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a5e2sm269425945e9.1.2026.04.03.08.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:37:22 -0700 (PDT)
Date: Fri, 3 Apr 2026 17:37:20 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.6 4/6] bpf: Add third round of bounds deduction
Message-ID: <c3ad9d44dbf14a110f85902bdc6e119a762e932a.1775206731.git.paul.chaignon@gmail.com>
References: <cover.1775206731.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775206731.git.paul.chaignon@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,suse.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-233198-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: A2CAD395E93
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


