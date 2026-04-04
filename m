Return-Path: <stable+bounces-233273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCxKCVbJ0GmfAAcAu9opvQ
	(envelope-from <stable+bounces-233273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:18:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D07839A60E
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 560B3302D10C
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 08:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4B63A4525;
	Sat,  4 Apr 2026 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evtK5q6d"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008F82DB7BF
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775290466; cv=none; b=MSneFBXoyUL+v2C0/2tam2WeQ42dUp8QzfOnQqQBaoZ3Hb/mKPyG3iHdc0nZ8OE9MSrf0JZ/sI/q0ux8ts5rl7xIiiDoUwADXpQBzB3Ukgw2u4XRiUHVaALVtKfIhnqWJhkcWDIVXoqAUeGu//x44BxX1/l6Wlv2Gnfyl/qXkA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775290466; c=relaxed/simple;
	bh=3I/iYhSSY8eYyI/8nNGRyX9wMATo2c3VveSwY3uI4zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXZFPYEFrmoLKy6B/4sJSbxgl03+l4ZSSldC+sImdWB3xRNnLYRkLfibAVUqowSOteQlZaOON2HXpLUL0NtXPsA7nU13SFTm8jy/bwcXyThA1L5C1bzKlsYqOpTWBGtLE1R4E9tTwY45uVZFzHGb/7nN2AwILIOrR+RkhIpT74M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evtK5q6d; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48374014a77so32158085e9.3
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 01:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775290463; x=1775895263; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MNbYrGuEYoTVG4MtfibMM0DzA2cXMVoUV7CDQ9g5nUg=;
        b=evtK5q6dPjMubNgzNtjBb9g+b6A/dKyD4O7QxfDvUZjUtvbbQiJgmgIC+8Nh5bTnUX
         HfInOJr9+VWM49J3cLtL6kjQ5LH2Zlvfmt4LuVtxVF1sS8/uLS1IJ15k3sPC9Vx4gXLO
         FWEAbOmWGt4+YIrqjVqDwVlMuezIj1mDJa1OyTQontHEwmM1+Uhtthq1gMok1zgAIUr6
         SVU/i5hI1reb8mq17P1lXkLJ55RuqfkkVBQcWub4Vn/vhgowxUztiFHhpQc+zGqH2Wa7
         C7e0LZ3FG8/4gHKsDj9I27IWajjq5TKmJ7bwBqaFDgv8Jx/1hHSNf+v/aTc3PtM7tpXu
         Ks6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775290463; x=1775895263;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNbYrGuEYoTVG4MtfibMM0DzA2cXMVoUV7CDQ9g5nUg=;
        b=n4GTfI6iu/8WKyAJ1OU1EsGf3mO9cfvzqENyPlUnXMn12NS9J3MSVyMZyLbQ8eDlVU
         NtvvKxMn9ms5rRxx36kjRZZrjUtx/kvWHM9ZdwBuAPurGnr+3WmhYSJ8zd6XrC6oTUJK
         ntZ5Xh1lmVrhzf61Bj6/HgzkM1UdAzrFrkJs/ncrR3Vf7Z6KvXSnVsmGV5FdIxEvzVFX
         SBg40qKHF9y4EhztWahNOzbXhP5rGzG7+uq54SCHnohCAhnrbErIcYhFqhtMJC1l1WN7
         WVUol+0kE7z9iJHb8+/iTQ26bQT9BnN7ETBX5GP8170k090Pa7QmKYjl0b2638glvKxv
         tM/Q==
X-Gm-Message-State: AOJu0Yz6S8bfRzSlitSZmFFfqi1Xl4Zd9ZJjh5pPLLOax6t+il5CdtVJ
	0AVzMi6pcdotGjmJKvG+Ic01q9u8i54B98pllmwwsQvj6w4CEkOtcZTpIYh8OPLJ
X-Gm-Gg: AeBDiesqlnUhs4mo8xm1bBqqrbiXGVQ5LkB895t7Y7JRN9i2SWG+gZZ+tFWXNXQQiN7
	YrG1Qib8iUx5b5rnGs0QxlGBALSiWra8TApgP4rUJvnUq3DM62z3DSNcyDETB/AZohEQMdA5e2o
	t0T3jw28F8PmXhDxEeFuJz3UHPKBoUMn1L/11CskLXalgJx/w1zdQMbYcSM/CxizJ7Buv3Ng9cS
	YGONyvbEw0MphFJlTCN0jrdyDaFNGc/N/NwGO6bpaI59qFWA6TSFMYWSidpNgLEd96HypfAEQpA
	XvOdiX09Lcp3mrzz4eOC/zWpjof/6K1qtkDN1xifAIM5ddgeur/zKteianJJp9Rj01iiovO583G
	eN30NNkSUKbpx4D429Qbj2wiKYRwPlZdl1TX7XlL62vi7jt3Q0gE+Qv5dOBnr++2X4rWMWpDG3m
	WOuaHPSl6/g2vewcOpWRKo390iIfpNlztoETSn/bty3kBpP3RbAi01AeZl6yW7PmVCOi6n5lzU8
	cqRyD5h+k7zlfwsSFpGe5gR8Z5Er4WcaoYCQGiy18ASiv3IjDEHnI0SlHVF6H1cBHiFsVFGVVMB
	rYtrmeHPw5BREDPH20cWpNjS2PwfVWrOLiARb7f/hDs=
X-Received: by 2002:a05:600c:a104:b0:485:3a27:a960 with SMTP id 5b1f17b1804b1-488995d5ed1mr67030965e9.0.1775290463068;
        Sat, 04 Apr 2026 01:14:23 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00359acd79a267583c.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:359a:cd79:a267:583c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d27a8sm23479052f8f.17.2026.04.04.01.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 01:14:22 -0700 (PDT)
Date: Sat, 4 Apr 2026 10:14:20 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH stable 6.12 5/6] bpf: Fix u32/s32 bounds when ranges cross
 min/max boundary
Message-ID: <b9a0f1832723f3881833a1c466af998749292d05.1775289842.git.paul.chaignon@gmail.com>
References: <cover.1775289842.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1775289842.git.paul.chaignon@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,suse.com,kernel.org,etsalapatis.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-233273-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 8D07839A60E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit fbc7aef517d8765e4c425d2792409bb9bf2e1f13 ]

Same as in __reg64_deduce_bounds(), refine s32/u32 ranges
in __reg32_deduce_bounds() in the following situations:

- s32 range crosses U32_MAX/0 boundary, positive part of the s32 range
  overlaps with u32 range:

  0                                                   U32_MAX
  |  [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]              |
  |----------------------------|----------------------------|
  |xxxxx s32 range xxxxxxxxx]                       [xxxxxxx|
  0                     S32_MAX S32_MIN                    -1

- s32 range crosses U32_MAX/0 boundary, negative part of the s32 range
  overlaps with u32 range:

  0                                                   U32_MAX
  |              [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]  |
  |----------------------------|----------------------------|
  |xxxxxxxxx]                       [xxxxxxxxxxxx s32 range |
  0                     S32_MAX S32_MIN                    -1

- No refinement if ranges overlap in two intervals.

This helps for e.g. consider the following program:

   call %[bpf_get_prandom_u32];
   w0 &= 0xffffffff;
   if w0 < 0x3 goto 1f;    // on fall-through u32 range [3..U32_MAX]
   if w0 s> 0x1 goto 1f;   // on fall-through s32 range [S32_MIN..1]
   if w0 s< 0x0 goto 1f;   // range can be narrowed to  [S32_MIN..-1]
   r10 = 0;
1: ...;

The reg_bounds.c selftest is updated to incorporate identical logic,
refinement based on non-overflowing range halves:

  ((x ∩ [0, smax]) ∩ (y ∩ [0, smax])) ∪
  ((x ∩ [smin,-1]) ∩ (y ∩ [smin,-1]))

Reported-by: Andrea Righi <arighi@nvidia.com>
Reported-by: Emil Tsalapatis <emil@etsalapatis.com>
Closes: https://lore.kernel.org/bpf/aakqucg4vcujVwif@gpd4/T/
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20260306-bpf-32-bit-range-overflow-v3-1-f7f67e060a6b@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c                         | 24 +++++++
 .../selftests/bpf/prog_tests/reg_bounds.c     | 62 +++++++++++++++++--
 2 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4ae3032f42e5..7769a2a47bcb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2046,6 +2046,30 @@ static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
 	if ((u32)reg->s32_min_value <= (u32)reg->s32_max_value) {
 		reg->u32_min_value = max_t(u32, reg->s32_min_value, reg->u32_min_value);
 		reg->u32_max_value = min_t(u32, reg->s32_max_value, reg->u32_max_value);
+	} else {
+		if (reg->u32_max_value < (u32)reg->s32_min_value) {
+			/* See __reg64_deduce_bounds() for detailed explanation.
+			 * Refine ranges in the following situation:
+			 *
+			 * 0                                                   U32_MAX
+			 * |  [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]              |
+			 * |----------------------------|----------------------------|
+			 * |xxxxx s32 range xxxxxxxxx]                       [xxxxxxx|
+			 * 0                     S32_MAX S32_MIN                    -1
+			 */
+			reg->s32_min_value = (s32)reg->u32_min_value;
+			reg->u32_max_value = min_t(u32, reg->u32_max_value, reg->s32_max_value);
+		} else if ((u32)reg->s32_max_value < reg->u32_min_value) {
+			/*
+			 * 0                                                   U32_MAX
+			 * |              [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]  |
+			 * |----------------------------|----------------------------|
+			 * |xxxxxxxxx]                       [xxxxxxxxxxxx s32 range |
+			 * 0                     S32_MAX S32_MIN                    -1
+			 */
+			reg->s32_max_value = (s32)reg->u32_max_value;
+			reg->u32_min_value = max_t(u32, reg->u32_min_value, reg->s32_min_value);
+		}
 	}
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 39d42271cc46..ac4e2557f739 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -422,15 +422,69 @@ static bool is_valid_range(enum num_t t, struct range x)
 	}
 }
 
-static struct range range_improve(enum num_t t, struct range old, struct range new)
+static struct range range_intersection(enum num_t t, struct range old, struct range new)
 {
 	return range(t, max_t(t, old.a, new.a), min_t(t, old.b, new.b));
 }
 
+/*
+ * Result is precise when 'x' and 'y' overlap or form a continuous range,
+ * result is an over-approximation if 'x' and 'y' do not overlap.
+ */
+static struct range range_union(enum num_t t, struct range x, struct range y)
+{
+	if (!is_valid_range(t, x))
+		return y;
+	if (!is_valid_range(t, y))
+		return x;
+	return range(t, min_t(t, x.a, y.a), max_t(t, x.b, y.b));
+}
+
+/*
+ * This function attempts to improve x range intersecting it with y.
+ * range_cast(... to_t ...) looses precision for ranges that pass to_t
+ * min/max boundaries. To avoid such precision loses this function
+ * splits both x and y into halves corresponding to non-overflowing
+ * sub-ranges: [0, smin] and [smax, -1].
+ * Final result is computed as follows:
+ *
+ *   ((x ∩ [0, smax]) ∩ (y ∩ [0, smax])) ∪
+ *   ((x ∩ [smin,-1]) ∩ (y ∩ [smin,-1]))
+ *
+ * Precision might still be lost if final union is not a continuous range.
+ */
+static struct range range_refine_in_halves(enum num_t x_t, struct range x,
+					   enum num_t y_t, struct range y)
+{
+	struct range x_pos, x_neg, y_pos, y_neg, r_pos, r_neg;
+	u64 smax, smin, neg_one;
+
+	if (t_is_32(x_t)) {
+		smax = (u64)(u32)S32_MAX;
+		smin = (u64)(u32)S32_MIN;
+		neg_one = (u64)(u32)(s32)(-1);
+	} else {
+		smax = (u64)S64_MAX;
+		smin = (u64)S64_MIN;
+		neg_one = U64_MAX;
+	}
+	x_pos = range_intersection(x_t, x, range(x_t, 0, smax));
+	x_neg = range_intersection(x_t, x, range(x_t, smin, neg_one));
+	y_pos = range_intersection(y_t, y, range(x_t, 0, smax));
+	y_neg = range_intersection(y_t, y, range(y_t, smin, neg_one));
+	r_pos = range_intersection(x_t, x_pos, range_cast(y_t, x_t, y_pos));
+	r_neg = range_intersection(x_t, x_neg, range_cast(y_t, x_t, y_neg));
+	return range_union(x_t, r_pos, r_neg);
+
+}
+
 static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t, struct range y)
 {
 	struct range y_cast;
 
+	if (t_is_32(x_t) == t_is_32(y_t))
+		x = range_refine_in_halves(x_t, x, y_t, y);
+
 	y_cast = range_cast(y_t, x_t, y);
 
 	/* If we know that
@@ -444,7 +498,7 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
 	 */
 	if (x_t == S64 && y_t == S32 && y_cast.a <= S32_MAX  && y_cast.b <= S32_MAX &&
 	    (s64)x.a >= S32_MIN && (s64)x.b <= S32_MAX)
-		return range_improve(x_t, x, y_cast);
+		return range_intersection(x_t, x, y_cast);
 
 	/* the case when new range knowledge, *y*, is a 32-bit subregister
 	 * range, while previous range knowledge, *x*, is a full register
@@ -462,11 +516,11 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
 		x_swap = range(x_t, swap_low32(x.a, y_cast.a), swap_low32(x.b, y_cast.b));
 		if (!is_valid_range(x_t, x_swap))
 			return x;
-		return range_improve(x_t, x, x_swap);
+		return range_intersection(x_t, x, x_swap);
 	}
 
 	/* otherwise, plain range cast and intersection works */
-	return range_improve(x_t, x, y_cast);
+	return range_intersection(x_t, x, y_cast);
 }
 
 /* =======================
-- 
2.43.0


