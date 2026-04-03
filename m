Return-Path: <stable+bounces-233199-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELn3NJHgz2kS1gYAu9opvQ
	(envelope-from <stable+bounces-233199-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:45:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8B2395E9B
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 799CC308FE70
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 15:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85E73BC666;
	Fri,  3 Apr 2026 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9ocWJt3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2318023ABA8
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230658; cv=none; b=pBOBZf+qlovPvSlCSfaC096vbFWAqSiVIJtkgj03xk9PvFqzhiIT1DwYzqeXnbU0qs4kBMXHfzjFhIq8xMQlwCc3y1t4NsCS4jA4BWAfxFwkUD0x3PqMZocpLSF9tREjGDY9ECElPLTEnLzFR32DWeDYkc5TQ5arIHfyb/2PPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230658; c=relaxed/simple;
	bh=3I/iYhSSY8eYyI/8nNGRyX9wMATo2c3VveSwY3uI4zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7J22ASj29vHbgbugdjfclAKw3RAU85EOqNdE+vr+tb2UeXeJigWMY62Jc+gzofOrJUoBHqihKLe/jnV2HEx7GNd7I8GOwl8OSJaU8/iu3rgrx0s6Ww13ZZt24MgbfiG70oe4ySzmkFRm+UgokAtfwP5mBkajoFugWY2i4fLUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9ocWJt3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48374014a77so25544795e9.3
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 08:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775230655; x=1775835455; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MNbYrGuEYoTVG4MtfibMM0DzA2cXMVoUV7CDQ9g5nUg=;
        b=W9ocWJt3dw8EpMRJ0tig+zv6B++puY8nqnHOImJJDBAJelfvi96I+Lh4PLtGTsSbCy
         yEbbZEmzd/4gMJkZens56AMfxmnfFxDyan8dNtPDTRgHSZhKvwOjdOPzem5Y5eiLxAwC
         36+emzQ4nNOuFP0w6fxG9f+4cFtPX2tovZarncfr0X11AYdKt244LcCkkRRyB1YwctT6
         ELBkmz8Qo8qis0bBtJcfPBsNa2Y5cD86s06o2RjRRGaCvCJpgDFCHWI9TdInzs7v/OEC
         Xg/ycCAk5i78bh6GrWQVHhAO1wunSbUvDJdM32/+yD10j1e00R+8xqWPRaqjzKGu2Cti
         IyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775230655; x=1775835455;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNbYrGuEYoTVG4MtfibMM0DzA2cXMVoUV7CDQ9g5nUg=;
        b=c70ep4QhLYeFqXDXTq3TVouas1npSKdj4h4+O16gQlh+BkmXutNDi4nsbmRhJEi1zr
         MjbHw9GID4Ie/frGdOrN9UTp5meF8Gyy917iURZ6AG+f2JoRJ+1vWTqv9nFtBSaRQThA
         gTcFmCSWg4qgXItvRB5YxDKBDTInu0JMyNGrg3X7EvnGjg2FCDVXH30igB6t9Aj7BeE1
         uKdYnWlo3Zvx6NZtyFNgHbI8u3LefEL/xDC6/AYDPGJvv7Ov6Z06OUBJP1iWQ3dEmKzE
         yrrWjwnTDEfrDHCNUxJlVb8rrTkM0Rn7RfJ7KbS9k/G1ljWKZeDDZ4sXKPC+AEokHFsY
         gPfQ==
X-Gm-Message-State: AOJu0YxPbCht2NGuu9WD05Qaf4GKVi/1Ou0d4hWwjWRwUT3+gUGASWub
	xIGaSQxG+4TkUc9yCFNtSJnPH9MWYhxqJO+0I1dodhby31X0emnsD7FhzHAE0pDM
X-Gm-Gg: ATEYQzzqrbbqGidyWDZuVkkrPU+e5VU2Dm5FM5pLqkMV07t3HnBppGY9FSfHKzf8FMp
	KpHLha75BMOdDTptZ9I1xYBAO8d/Y2MG0zLmZpS0jAoznS+bLLplhGMcDxihoOauQcq8wEdGiTG
	olWcbBjq0y2FK8G9ee/jOOw6Lcx6Yul3o2yOora+haIOOFvEA7aANXfSDXn9uWYwOfafjPcE6AZ
	83syDH1glPo8gnrQsaPZeYqNOz8d1RtOhsqT9R6KPJrxfxfwwajBN23zhU3rGg6qKeZLiBF1yCe
	ig4eBOc3svp9QmlceFIkFcL2hc8YXAp1XmW8QTl40fMW0jC0RVDKWO+oQBkaNmXq6p6+wOi76tu
	gsqoUrMGRLy8B2XulKsm6f47z2WgQACa/vn24NGF7KqdCV1T6Lgfrku8lrkT6WmY0Pjy/RTdmGZ
	8lsL6cEnRKYSqFlFiEGDZ/0fD4+Z8LxeKPSQXElnMRJwN6oHfANA25ArYFs+gGbFJmXINNfV8VO
	uEIXhAUKPLzLFFfqCrBtgw/qy4sc0NqsX/fkrFysQR0HZLh3/qzQNkyqypocQn0GzIouujLKlJd
	QZkF23v0mB6Pn8/kVZLfUAYWbLhZIQA9AxXwZefy1eA=
X-Received: by 2002:a05:600c:6305:b0:486:d76c:fa57 with SMTP id 5b1f17b1804b1-4889978da75mr53517975e9.17.1775230655247;
        Fri, 03 Apr 2026 08:37:35 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00c96ae484ac75459c.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:c96a:e484:ac75:459c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e829c43sm254746815e9.5.2026.04.03.08.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:37:34 -0700 (PDT)
Date: Fri, 3 Apr 2026 17:37:33 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH stable 6.6 5/6] bpf: Fix u32/s32 bounds when ranges cross
 min/max boundary
Message-ID: <b9a0f1832723f3881833a1c466af998749292d05.1775206732.git.paul.chaignon@gmail.com>
References: <cover.1775206731.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1775206731.git.paul.chaignon@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-233199-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 4C8B2395E9B
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


