Return-Path: <stable+bounces-233197-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G9HK1zgz2kS1gYAu9opvQ
	(envelope-from <stable+bounces-233197-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:44:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A712395E7D
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 130F33041A6E
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 15:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663483BE145;
	Fri,  3 Apr 2026 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="greZRlwY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822723ABA8
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230633; cv=none; b=lpAS+qUTSQenAF6HIm6j94tw1uvDQE67WqZfsMCt5b3K7dp4YQOCdaXwkbmrHaXXO09e+doFXRFiFsB+SjM+whbpzHo8HS0mIRuSLlX+IHAkhYabUohb8uknZlpjvjJ2Vas9uhNE97vTgpTIsJdY3zmEmDL6a3oZWmR4+k1i1d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230633; c=relaxed/simple;
	bh=ORnUqdz4ubAqnYzzzFqNVLdeVP03R9sWIIGWUXs1rWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teps2G644K6snrmvaElrl89tYIG+WQYCu0pqqVpQWOM0ski5S3UbfNyur19w+5Yvc0kHolKoGEBUXmZPzRXEIypRJoQLjXvivIOPZy/9xaaipaqtdt7izD4QKMx7mdIHIfUupUFXzLAVIsQoeiFh2diDEUvV4EENFdthRQ5witM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=greZRlwY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso18124505e9.3
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775230630; x=1775835430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nJ34TCzJzKWinCWURHGvYIN+UCxz91gBSkks4GEORFE=;
        b=greZRlwYzYa45IK8/yClW8PFLMCg6zanB9e374HVr1v6OikuCaf2AObm7knJAlA2yT
         Z74gjgfrtTAsLzgIG5rzPrLS0R1flty6OUHP/lzOrqNcPjF9htSz+JjOL1wLZOungJyZ
         0JYwvUYipzFI8aTfsYiyyd1sxgl0cB3WXm46ehm68RxSCK6Y0QFkpOS9pNEjTflZBDEr
         /vmpSRBOkkvdzAUJCwhPGGIPGsag6LTkSq1wQKmtdo4bd9D3Doacx43C6oT3S4cxHaci
         5pxH0oNRtW1qqJZ1p8DN0z88mgqs4roEsN1osnnYy3+bl7x+KNE5XiAVwBz2h0wGF7wH
         n+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775230630; x=1775835430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJ34TCzJzKWinCWURHGvYIN+UCxz91gBSkks4GEORFE=;
        b=ItiT4qxuW4GHl4Nezy/JKK97llJfIbsp96hOAQQrTNKXuvgPJlykgEuRmsuBl5ksDy
         3oWa2pobOrA9Dy8OWo7v1krhFdvds5Khd4zUd0TN7doa8NTKx9h8fKZHaMFtZNNVHpg9
         86T+J33QAdKowK2NauW3NWTtiSusPy1b3aIasDqGzCVWKv/IYDPkP2n83Px/tBZx3Qkm
         Zo2KFtbPoaj3OWwTzkJHgOMTgY1T14OPR/MSB4QbQPjfUFAev80iOIswbBP+HYMvswpf
         UpfTIpvtSls+rzIdSIndo7JOP3vvHcuPb4BAQfCZUShit6JNpw4eWfz6LtsWxTJwlxnZ
         X6kg==
X-Gm-Message-State: AOJu0Yy+2AU0/i6jP6XbE6lGLs8otRRHxq9KZ5D2AcR+8c2VXw9f9O3f
	hl5WCEaAeDuug2WJnHQEbAyJ5NkS5ERsfLbJq+4y5LZH7SeHBFqz/CwQNZpKV297
X-Gm-Gg: ATEYQzwopLj5kRyVZuot3kOnJjUnYRS1yRw5EYJIzNcfNtaFKh1sGBneLsnFTz2xlzV
	B/ReuVCPJDP8/7P833ZU2HPaQmufP5y33YAUT2wmEFmqSF84JOPKfHsdlEpMyAZ92nQyaPUS1Lu
	ugzqFdLP8guRbNENwVF03R/W9M2cP+RbQBWajLmHu+b+zQgonJdLLZ/X7oIYhzYoYFvo5sOs6gl
	SR3La8t12XmaGJZ526GRkLijMPCw2ZMQkUnORkRRgjH7f8MCiu45JJomEFMFH+F61+BKVDKhlsh
	gOuEb8IUEslRQvaKct4uqxVOOa29g0r2uTc3A+M2cMYWHJUTwp7+Z1tlz661j3wjKyicWuDUMnS
	rtOm+jW7ca67yOnQ3U+zkhouNb1F7U9dlQ+02OyqF4YHceeU0ArgQzbV45GYpUHe7DOU+dJm8Ll
	2emermt9Y1Xyyitm9ABosHJHQW4mHZXzhHHCgsKmeseIN2feUyFcOthPIByKBDehM2636Vegt17
	K5OoeTWYEoSXX5tk3rHwtLRAVaix6lpNc1YwhJkEZkHbCHsCQGKq2KbTvYoIK2pL5pcozwY1990
	ZqrdoZHO/Hb0cmoSFZQu1Q+r8XAwyRIePUW7/WxL0q8=
X-Received: by 2002:a05:600c:4e0b:b0:488:869c:eda6 with SMTP id 5b1f17b1804b1-488997d6b8dmr61300595e9.29.1775230630231;
        Fri, 03 Apr 2026 08:37:10 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00c96ae484ac75459c.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:c96a:e484:ac75:459c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a65635fsm152901525e9.6.2026.04.03.08.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:37:09 -0700 (PDT)
Date: Fri, 3 Apr 2026 17:37:08 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.6 3/6] selftests/bpf: Test invariants on JSLT
 crossing sign
Message-ID: <8391b533f7f9876aadc8ae1bf9915516db575cd9.1775206731.git.paul.chaignon@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,suse.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-233197-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A712395E7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit f96841bbf4a1ee4ed0336ba192a01278fdea6383 ]

The improvement of the u64/s64 range refinement fixed the invariant
violation that was happening on this test for BPF_JSLT when crossing the
sign boundary.

After this patch, we have one test remaining with a known invariant
violation. It's the same test as fixed here but for 32 bits ranges.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Link: https://lore.kernel.org/r/ad046fb0016428f1a33c3b81617aabf31b51183f.1753695655.git.paul.chaignon@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_bounds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index fe3e2b326c6b..3924b1d1421b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1028,7 +1028,7 @@ l0_%=:	r0 = 0;						\
 SEC("xdp")
 __description("bound check with JMP_JSLT for crossing 64-bit signed boundary")
 __success __retval(0)
-__flag(!BPF_F_TEST_REG_INVARIANTS) /* known invariants violation */
+__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void crossing_64_bit_signed_boundary_2(void)
 {
 	asm volatile ("					\
-- 
2.43.0


