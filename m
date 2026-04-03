Return-Path: <stable+bounces-233200-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDj2GpXgz2kS1gYAu9opvQ
	(envelope-from <stable+bounces-233200-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:45:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0458B395EA2
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6EA23090A96
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D8C3BD64F;
	Fri,  3 Apr 2026 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLKKfBEo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AF523ABA8
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230676; cv=none; b=fhpiDzcdH3IoWGFU79Ko2Axua8I11jYLusdrC2uSnE+88oaluOYeyIhdMUl6pNudyiwscQ58mx3oEJWvMlc63koz5AnMRnfNb0Ro30mZiNplXho6DRyQD+V3z1aYCjrgb1EjnYVD7T/eatI7zON1oZGH3GP0r5lVtUsM6GU+0KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230676; c=relaxed/simple;
	bh=UGUakupRFwqfRj0Wf1MgzHYZcLxI2TG7a8ChlRShHs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tg3jYdOVl3RexQ4Q1ZXnYkAqhrCmIpVuMyxuT6E0u9A0oWMfKJYf0dZsfZr6BIO5On1eXNrX/LUncGHelNvj+juC72rwMvu78mEYE2/6S/WIFnd2O6NfzijWk+iQyn0g1Hu17WRT7G/mMtgSWonF36yI4g0OKOEk2ukjjO0Csfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLKKfBEo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483487335c2so20774685e9.2
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775230673; x=1775835473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9QtDAtuj+DI+rbavi9AYYmBMM9A4IkRJ4xbnMdUWd8=;
        b=cLKKfBEo46r0jD/QROEUhMLYoToRflAHS8n74JN50nM4y5mVDB5of7FzTLkRswbkmE
         wXe/q94FHd6vhM6oHtkPh5S+mvpow7+794iWM9bkd3vs3M6Dba1v7uGobzvBeeB+ehWt
         ZQfWqKWTfFZeVzOlt1J8ypcf/FBCficnnn62wXuP1Cy15w+FASY+aSjS8tcRvAFw9hVl
         PwxnbilNvduUiQpCysnWEKVhiZww8WJbe60fdgqkUBZ+SqktPoJmRSG452UwN5YwVgnI
         cAHKGPAxEPf7XF7qWlycpUI6D7LG0hG/RNfmIcPegBvzY+q4gaxxtvMpLWKp0im8P8UN
         ifyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775230673; x=1775835473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9QtDAtuj+DI+rbavi9AYYmBMM9A4IkRJ4xbnMdUWd8=;
        b=CA/qIMSZ4QirOZ9WC4LN6tQa/bhW+0tuEyuzSrD/c8YvN0i0ItOOT6CJv+yROGv3jq
         X6lBEBHDDnirKlyFa7Iah8mrC9Q0V6zQPcTUEvhLhVONBqhX3gpH6XZIYhTnrsqfYjmJ
         LutehkcukJFwmwallhoBjVN1bgeVAUP3AP9hYZAiHcOxtnMnDFJVKy5yuKAVjYH5UNOJ
         nn8tZter7vOb7u+MDQDwalVk0CUlbvprxYeRA2+9L35IXo5xNwoNMGs5GO/EixK6M5nV
         sQvcUbZumyITSxYOH5GuKk/i4NoP2bCMh259jp4GjFTstu8q09rbDbqR+aL0cQHFMCLn
         aylQ==
X-Gm-Message-State: AOJu0YweDEMdpaYoO3Cif8aj4JgNiPnc7+7Nk2FaT+mxcHgXplzVZSG5
	IAGHzeqVSaVxylqjmdlNsEsW4dHb17j1HtmZeyI3JY38FhWJeRby0J4jDQWaE9Jk
X-Gm-Gg: ATEYQzz5ccDEsoioTf6X7Uq0mUkS6TrXe6WdpYTd+Ydlz4sEGob+1InSQ4+NTOYuulE
	XLy4dgcXK8Q2tjVRKk1zGEdQRC10th+ckyUrh4VYiLpdzjyGLpg3ZF93MCuXVeX9bPS60N2HyB+
	u1gRtVabhIGGknxFV0iJpJmkUOyDPX0FikFeVeomTi+1dV3aoufL3L2DohhqFD41eScZuy+E8ZP
	HQDCAvyE5fY0YXWKn9q0utvNjliEYQRUd4Kpbw81zKRZlpYXsxaCjiFpiPjP4jwkuD8XBIw/4zi
	XLia3Re1udXoUNRt/0TFEpDE6z0gBs8LOiub5NHOyAnZYgoSEgXc+mqZd/7YsQJb7To9Y9TktbK
	IaNA9rmJPb3re4ECQTs4lPhJh1h6shaIDeZZWwIglf/zvvM5SxN4b7BlGmunE0ysnGQCqX+BGq9
	PFkjZrc6ge6POoces5WlF7MX9LsvX9UdxqrB4LycQFaC2SU06NQpeJfxTrltuXT05TMqiOW+CtZ
	4osbPOvTCR2XWRw9aXPRGjCxAw8VVmWzN4Z3nHMcCbtVXYybKPOqJRBXP8HOzzkM02HUhXyOKc+
	d0PhIaO0hEkO9Ep0pvETc9kxiLjBztDAFTXdYFBFLfc=
X-Received: by 2002:a05:600c:3e87:b0:486:f8d6:5dea with SMTP id 5b1f17b1804b1-488997c273dmr60344565e9.19.1775230672752;
        Fri, 03 Apr 2026 08:37:52 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00c96ae484ac75459c.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:c96a:e484:ac75:459c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d282esm17744353f8f.18.2026.04.03.08.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:37:52 -0700 (PDT)
Date: Fri, 3 Apr 2026 17:37:50 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH stable 6.6 6/6] selftests/bpf: test refining u32/s32 bounds
 when ranges cross min/max boundary
Message-ID: <ba33eedcb64f447d5ea0025606c76fd4f00b22bd.1775206732.git.paul.chaignon@gmail.com>
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
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,suse.com,kernel.org,etsalapatis.com];
	TAGGED_FROM(0.00)[bounces-233200-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0458B395EA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit f81fdfd16771e266753146bd83f6dd23515ebee9 ]

Two test cases for signed/unsigned 32-bit bounds refinement
when s32 range crosses the sign boundary:
- s32 range [S32_MIN..1] overlapping with u32 range [3..U32_MAX],
  s32 range tail before sign boundary overlaps with u32 range.
- s32 range [-3..5] overlapping with u32 range [0..S32_MIN+3],
  s32 range head after the sign boundary overlaps with u32 range.

This covers both branches added in the __reg32_deduce_bounds().

Also, crossing_32_bit_signed_boundary_2() no longer triggers invariant
violations.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20260306-bpf-32-bit-range-overflow-v3-2-f7f67e060a6b@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index e6297e9dd2ed..5feb07584084 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1110,7 +1110,7 @@ l0_%=:	r0 = 0;						\
 SEC("xdp")
 __description("bound check with JMP32_JSLT for crossing 32-bit signed boundary")
 __success __retval(0)
-__flag(!BPF_F_TEST_REG_INVARIANTS) /* known invariants violation */
+__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void crossing_32_bit_signed_boundary_2(void)
 {
 	asm volatile ("					\
@@ -1318,4 +1318,41 @@ l0_%=:	r0 = 0;				\
 	: __clobber_all);
 }
 
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void signed_unsigned_intersection32_case1(void *ctx)
+{
+	asm volatile("									\
+	call %[bpf_get_prandom_u32];							\
+	w0 &= 0xffffffff;								\
+	if w0 < 0x3 goto 1f;		/* on fall-through u32 range [3..U32_MAX]  */	\
+	if w0 s> 0x1 goto 1f;		/* on fall-through s32 range [S32_MIN..1]  */	\
+	if w0 s< 0x0 goto 1f;		/* range can be narrowed to  [S32_MIN..-1] */	\
+	r10 = 0;			/* thus predicting the jump. */			\
+1:	exit;										\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void signed_unsigned_intersection32_case2(void *ctx)
+{
+	asm volatile("									\
+	call %[bpf_get_prandom_u32];							\
+	w0 &= 0xffffffff;								\
+	if w0 > 0x80000003 goto 1f;	/* on fall-through u32 range [0..S32_MIN+3] */	\
+	if w0 s< -3 goto 1f;		/* on fall-through s32 range [-3..S32_MAX] */	\
+	if w0 s> 5 goto 1f;		/* on fall-through s32 range [-3..5] */		\
+	if w0 <= 5 goto 1f;		/* range can be narrowed to  [0..5] */		\
+	r10 = 0;			/* thus predicting the jump */			\
+1:	exit;										\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


