Return-Path: <stable+bounces-241193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLlgHGGJ7mlCvAAAu9opvQ
	(envelope-from <stable+bounces-241193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 23:53:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F10946B52C
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 23:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1432F3001302
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 21:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFD1308F15;
	Sun, 26 Apr 2026 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kox2nKqK"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAE6308F05
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240409; cv=none; b=Y3j7TrMi2y9gBvcxeiCvl7FLB5/MkQ3YFZHALHGT3XvcPuYBRBHUqwC0+7IaPUX6pYX1NwQ3B+TVeEbKHjxte9dQMYz3f0t1kesiRgOX/44WvyvEqEYHoH7WaD468uE0Yh7KmRZNcx9Zu+vtHwBQMOY4uepKU757JlufPz8SSzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240409; c=relaxed/simple;
	bh=l0U1ITX9eVD8xt75MZVCrvnUvX5Mqajvm5sdVqbUmcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEnrRnQiJ3PGtmaIA+w42FCLqii9ZHbdbbrnndb5pB6PZ3QURC4RQni8dPUTBir5pW3OhCmTomvZggleAH6gsvyRSzCeWBm3PC1rI7JjYY37tUlRa+hDw7FCZxD19Q0q9hE1w7hkVmedwMWZg7BR5c6tfWwK7/2XPD8IgXKAhDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kox2nKqK; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-694885bf090so4002674eaf.0
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 14:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777240404; x=1777845204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIwRA9DnaAl1LP+vhP5TF/gZsFPtvrSfr52uVozsBd8=;
        b=kox2nKqKDHIWqorEtSwSTIGnwpahgl6/1nZt2C2xTLtz8Yret8G1lUrOfD8lFQ7ssR
         4Gj0KPbg7biWlCy3ngYbH7HT0qdSWlpkwLyQTagtc/Vscy0JkKXTJSs4xRf47cu3OGPb
         kQe9LHzFnV3MGQ4DDn9QOMT4AlHhZ/f14j7QFLusv92hiaMJ/finCLP9kqDuGZsyZkcH
         MINIQ2GUNDrPia1HVvGu/UNQ+f/z/3D7F/XN9JexfurXyQvZHKwI3+W1acM0E2aqZWey
         yCEng0bpFGNHqCAYBRgDIHiUsIYhvj7Zi54NxmwWSo0fZ66m47W4ENwi97HvZ3/8L3Ew
         /Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240404; x=1777845204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cIwRA9DnaAl1LP+vhP5TF/gZsFPtvrSfr52uVozsBd8=;
        b=nU9BF2z6lVz9gbTyO+r2rQrPwagbKjkTJlyuJwG8c3/Z3YgJaQxBiNuIH2JpEaCwZ1
         RY+wAC3NUlST984aR2wb/CtNnT3/vApZlx1n10fcBpgkWfm/7m05flBfz1XmbIcyZSWp
         6AwZLSn2b/JjRuMHC3DtVa4UvWn1sKfwO1NSdrB7/3oAY4jirgXl3HZsZGx0hIZLRchr
         gMhGNxt6gHO74XP64qmeMiaSWtxBfFX5i4C7ZcS5eTUcL4yp7V+ESB6dUEbu2jjzeafj
         J//LSznQL3wLO98ql9uoa7fpm6BM+cq8KIXvRDx1op70r5rnkrxnLgm+ZWKzmrQhaJ5k
         khBQ==
X-Forwarded-Encrypted: i=1; AFNElJ8LEXUhdJMKGtIHbmdCu/ZC/B/CR5QFFA+cZr95SYSfFQpaC38GrnJs74a0B8mf5ZsSSRkbRg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWrMKWFUr7yvmKGU1xLDleBJYHSrgunCUNtFc4Cr8CQ9fjYVdB
	ChGlGiQhquFUMH4C46XXBEv6//bQlqIJDLGBtCcKDVHNNawyouU6rFI=
X-Gm-Gg: AeBDieuFK9IwsRhh9ewzYVsyqhNFKjM1+vUFaV7Xr1hfbqMuMQIkAh3QeGUx0p0nArz
	peBP4vsTfdi1FnDTLr9o+SgRxVpoBgLDhNEOzKJJ3TG/aonBWbYkUKNfNDPITSpUxBtxvZxuW63
	3b48BfLTXBQvl+gAyGHi1tLrvvvDeS1cCG/v/b0KSYv3twr+B6tC6hH9tR/V2OHniNTOjPKmtIj
	RWLbIGKVTuk0ip3fPMQ1nT16uuKm1XfrXsGol1+ML8SxlsTc3FP6Hule/rP0URcWGzUolVn/uJT
	A3Kdo65qkK9AeEYB1fCzYC5HoEwnm03iAAmuGxCpxDlued7roI+SwcE+vX8HT/HPgIEAQTqXj03
	SOOSzmns9te6MA/vPhvHyPA3B20eyo8J6kkRuSg4JoIQsiDENOIYeN8chN3qfDy6haodZq1BTQn
	TmoRestbSYkEjxw3aR25Jlgkvw17NyAtcIhXemE4xWBksbMtZ3gS0BwL7uteW62bvEXsF1Ate6n
	H/wk7pNmgRLAbG3R0fvAUexN8C3PGuU
X-Received: by 2002:a05:6820:4c8c:b0:688:c97d:bfc3 with SMTP id 006d021491bc7-69462ef3522mr23558608eaf.38.1777240404095;
        Sun, 26 Apr 2026 14:53:24 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6962b40d504sm4738997eaf.10.2026.04.26.14.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:53:23 -0700 (PDT)
From: jbmoore <jbmoore61@gmail.com>
X-Google-Original-From: jbmoore <jbmoore@nooks.dev>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: "John B. Moore" <jbmoore61@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] drm/amdgpu/sdma4: replace BUG_ON with WARN_ON_ONCE in fence emission
Date: Sun, 26 Apr 2026 16:52:50 -0500
Message-ID: <20260426215256.50722-2-jbmoore@nooks.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426215256.50722-1-jbmoore@nooks.dev>
References: <20260426215256.50722-1-jbmoore@nooks.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F10946B52C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241193-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbmoore61@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: "John B. Moore" <jbmoore61@gmail.com>

sdma_v4_0_ring_emit_fence() contains two BUG_ON(addr & 0x3) assertions
that verify fence writeback addresses are dword-aligned.  These
assertions can be reached via crafted DRM_IOCTL_AMDGPU_CS submissions
from unprivileged userspace, causing a fatal kernel panic in a
scheduler worker thread.

Replace both BUG_ON() calls with WARN_ON_ONCE() and force-align the
address by clearing the reserved bits.  This logs the condition once
per boot and allows the hardware to proceed without crashing the
kernel.

On all hardware that amdgpu supports, bits [1:0] of ring buffer
addresses are reserved (they historically encoded byte-swap mode on
legacy pre-amdgpu hardware).  A misaligned fence address indicates a
driver bug, but crashing the kernel is never the correct response.

Found by a custom amdgpu DRM ioctl fuzzer.

Fixes: 2130f89ced2c ("drm/amdgpu: add SDMA v4.0 implementation (v2)")
Signed-off-by: John B. Moore <jbmoore61@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 8a2a4e618..dcb7e4219 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -889,7 +889,8 @@ static void sdma_v4_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 	/* write the fence */
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE));
 	/* zero in first two bits */
-	BUG_ON(addr & 0x3);
+	if (WARN_ON_ONCE(addr & 0x3))
+		addr &= ~0x3ULL;
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -899,7 +900,8 @@ static void sdma_v4_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 		addr += 4;
 		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE));
 		/* zero in first two bits */
-		BUG_ON(addr & 0x3);
+		if (WARN_ON_ONCE(addr & 0x3))
+			addr &= ~0x3ULL;
 		amdgpu_ring_write(ring, lower_32_bits(addr));
 		amdgpu_ring_write(ring, upper_32_bits(addr));
 		amdgpu_ring_write(ring, upper_32_bits(seq));
-- 
2.43.0


