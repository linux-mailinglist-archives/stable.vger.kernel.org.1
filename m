Return-Path: <stable+bounces-233195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2B8/BTnez2mn1QYAu9opvQ
	(envelope-from <stable+bounces-233195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:35:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A20EF395CE3
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC868300753B
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 15:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229A61D61A3;
	Fri,  3 Apr 2026 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFzm0UMl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E4B29C325
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230517; cv=none; b=H9lWUwiJxuXleAP3/KmSmGz2G137jSfPJoKyDQh1WciojyRxROWNGI2MoDsm/5UCWZdeXeA/oHR5NhwewaTJUZZk3QI+Ho0dxdwymBe0UcUg/+JaoC7Uer8/Hf/GowInIrynduPHORNwLyF0y2SEFht0XOKV6IZsT0c1U8sqw4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230517; c=relaxed/simple;
	bh=/qXGPqxuZuzFUKXFwMaKnp17rwob3oDV39p/bkWtKoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0mr9LlMBZ+2c0F0gYM+N62qADci4Drp5q6rj91aQ86fY8CJPKHNq+BQcdB6UWLh32kVtDbUall4MxiQKWYqedO3VaSwFrbBu7rqPKlnz9GvLN38Gyxr1ceevhUt79jOGPD1+9EvgRQH5bQBq9PPobzH3lsGvvMFlXwVdq8yGSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFzm0UMl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488879b2e6aso17959495e9.1
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775230515; x=1775835315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ULP8DbOuEXZhN3CexgIC4rE4TGyJM/8Cix5w8Cv44c=;
        b=MFzm0UMlrRVvkFD/zg8TsbEBtGuEpuEKJB0JqGSfYIrBpAcgLYuV2qKk1xHdGmxTKE
         5lr6uIa8f9cqJ2hjEGzLya27ZArj1Z6TLc58RVe8hUY5VGp3wOK0h/3LcKxh+Pnvvq4u
         ah6pgRY0H1Z45e0UUwy9AwkWW931tjGqsssoT0rIWg9Gppgwqpm1VFcSMba1wjW5H+ka
         FQYxDKFXnnT2JIcS9bg/OkBpt7UvhBY2B/+Ybc3yAcyFYBa3MXlfPNNpmoV6fZMmhbuL
         nS4GCm+SZA7Dt5tcjyj1dg+x2CgizxbkRKLa7BGVj2OcU/Z+o6A596SxCqCIoaRFXH9l
         knfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775230515; x=1775835315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ULP8DbOuEXZhN3CexgIC4rE4TGyJM/8Cix5w8Cv44c=;
        b=dsXhcJbvroxDxqiiruHYAzGOzns3J0DF4TVjuiwOoUoWZtzypcdngupzHcwCerusfS
         5rHAc2dY9/CGxx5Wvwu9H1c/RbY6rV0vPLOkJvMaTLY1F2z3dPDkhNCLVbqkB4HI3Xse
         1mw4CMZ6bnKLG7RKcLpQ7PEDm3LO+hjIKFCMqB0wbPCNqPDtLKM1owIadT3yOGmh9bly
         cVApmT2fhgWg5XkULFUeAb7A2PyluiNcJpGzMfKsDO9xGm6LC4Cf92R73PE6IBff2PbL
         P0wUevrVJebLBY82yAyAB3dXtuK9NEW0Qd6HXpbFU/IMQSoFiYnaLln+icQH5dPJqTLC
         K/5Q==
X-Gm-Message-State: AOJu0Yzlt1l3GMTs54cEZ4iYM7LxVFDcDZraPhv5kVL/yaZAcs/afB3f
	HMbjKzc0LG9OtiMZoIwV8oQ5rcyhEi75oT1W7Z1H/dBJhVBaUriFTeofZYyNldTM
X-Gm-Gg: ATEYQzzLJP4VlVwRZvlSbCWVqxfn5gfeiZMkRe96OUVur9OelUjFcFLcY93dQ3fe8Ee
	Ke240z2euIShUndTXnmRT/rKdJ0azD2BdkXWla4DpTv9LMIfea0QaAY8GlusquExulvAJmeZE5I
	8dy39Orn6/kmayGc/tBcZN1ZVtaSV5dWT9B6pr2h2mEwYCtwd3BM6RTEv0UTnQyMNwgsRTvfYeF
	OgKss6OnLrcKPw0M8an4hA11MRP3HjoV16pIc9F4fLHx3z8inANz3eOCYN7lBjcULb+pGt+/nXa
	5oOxP2Tp33d1RRrCF/4wIXtWssMyJ6QVNnL8htf9Jvjk6L949C9XLSvpEU2Ks98veljddmwE7tR
	ocC/jjkslplCQTxBrenmOur0Yln/J56FIz4aOP5s3q3S+AohojL49xcpHH6jE5GzUIhBW+VzoKw
	PULL4oAC4NSUdLBzAKjZNNFi1zdinFCwsyi6tS3uyQ5NI88cUQ0+Fyap1Hm4e7d7jq30lR0wPv5
	CTli95vE5d/GsvWA/sHuXV4fzRQHOez6e/cjtVQpaUeXAdoNrMu9dCfZWNMQYjo81VPnKd1YmBC
	ibPj84IQbFBTixjEC/VNMGcnaxp9HW9awcvYmzrydZpyPYyTuXacCw==
X-Received: by 2002:a05:600c:c8f:b0:487:243f:dc3e with SMTP id 5b1f17b1804b1-488996d23e7mr46694585e9.6.1775230514532;
        Fri, 03 Apr 2026 08:35:14 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00c96ae484ac75459c.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:c96a:e484:ac75:459c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889cb46adcsm47487565e9.4.2026.04.03.08.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:35:13 -0700 (PDT)
Date: Fri, 3 Apr 2026 17:35:12 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.6 1/6] bpf: Improve bounds when s64 crosses sign
 boundary
Message-ID: <0f6da4f74ebc491dd651dfcf3ba984bbd3dc566f.1775206731.git.paul.chaignon@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,suse.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-233195-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Queue-Id: A20EF395CE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit 00bf8d0c6c9be0c481fc45a3f7d87c7f8812f229 ]

__reg64_deduce_bounds currently improves the s64 range using the u64
range and vice versa, but only if it doesn't cross the sign boundary.

This patch improves __reg64_deduce_bounds to cover the case where the
s64 range crosses the sign boundary but overlaps with the u64 range on
only one end. In that case, we can improve both ranges. Consider the
following example, with the s64 range crossing the sign boundary:

    0                                                   U64_MAX
    |  [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]              |
    |----------------------------|----------------------------|
    |xxxxx s64 range xxxxxxxxx]                       [xxxxxxx|
    0                     S64_MAX S64_MIN                    -1

The u64 range overlaps only with positive portion of the s64 range. We
can thus derive the following new s64 and u64 ranges.

    0                                                   U64_MAX
    |  [xxxxxx u64 range xxxxx]                               |
    |----------------------------|----------------------------|
    |  [xxxxxx s64 range xxxxx]                               |
    0                     S64_MAX S64_MIN                    -1

The same logic can probably apply to the s32/u32 ranges, but this patch
doesn't implement that change.

In addition to the selftests, the __reg64_deduce_bounds change was
also tested with Agni, the formal verification tool for the range
analysis [1].

Link: https://github.com/bpfverif/agni [1]
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Link: https://lore.kernel.org/r/933bd9ce1f36ded5559f92fdc09e5dbc823fa245.1753695655.git.paul.chaignon@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 68fa30852051..6448f9eeede0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2129,6 +2129,58 @@ static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
 	if ((u64)reg->smin_value <= (u64)reg->smax_value) {
 		reg->umin_value = max_t(u64, reg->smin_value, reg->umin_value);
 		reg->umax_value = min_t(u64, reg->smax_value, reg->umax_value);
+	} else {
+		/* If the s64 range crosses the sign boundary, then it's split
+		 * between the beginning and end of the U64 domain. In that
+		 * case, we can derive new bounds if the u64 range overlaps
+		 * with only one end of the s64 range.
+		 *
+		 * In the following example, the u64 range overlaps only with
+		 * positive portion of the s64 range.
+		 *
+		 * 0                                                   U64_MAX
+		 * |  [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]              |
+		 * |----------------------------|----------------------------|
+		 * |xxxxx s64 range xxxxxxxxx]                       [xxxxxxx|
+		 * 0                     S64_MAX S64_MIN                    -1
+		 *
+		 * We can thus derive the following new s64 and u64 ranges.
+		 *
+		 * 0                                                   U64_MAX
+		 * |  [xxxxxx u64 range xxxxx]                               |
+		 * |----------------------------|----------------------------|
+		 * |  [xxxxxx s64 range xxxxx]                               |
+		 * 0                     S64_MAX S64_MIN                    -1
+		 *
+		 * If they overlap in two places, we can't derive anything
+		 * because reg_state can't represent two ranges per numeric
+		 * domain.
+		 *
+		 * 0                                                   U64_MAX
+		 * |  [xxxxxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxxxxx]        |
+		 * |----------------------------|----------------------------|
+		 * |xxxxx s64 range xxxxxxxxx]                    [xxxxxxxxxx|
+		 * 0                     S64_MAX S64_MIN                    -1
+		 *
+		 * The first condition below corresponds to the first diagram
+		 * above.
+		 */
+		if (reg->umax_value < (u64)reg->smin_value) {
+			reg->smin_value = (s64)reg->umin_value;
+			reg->umax_value = min_t(u64, reg->umax_value, reg->smax_value);
+		} else if ((u64)reg->smax_value < reg->umin_value) {
+			/* This second condition considers the case where the u64 range
+			 * overlaps with the negative portion of the s64 range:
+			 *
+			 * 0                                                   U64_MAX
+			 * |              [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]  |
+			 * |----------------------------|----------------------------|
+			 * |xxxxxxxxx]                       [xxxxxxxxxxxx s64 range |
+			 * 0                     S64_MAX S64_MIN                    -1
+			 */
+			reg->smax_value = (s64)reg->umax_value;
+			reg->umin_value = max_t(u64, reg->umin_value, reg->smin_value);
+		}
 	}
 }
 
-- 
2.43.0


