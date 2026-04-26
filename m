Return-Path: <stable+bounces-241195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OmrEGaJ7mlyvAAAu9opvQ
	(envelope-from <stable+bounces-241195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 23:53:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB75746B537
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 23:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4CD23003427
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 21:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD6A306B31;
	Sun, 26 Apr 2026 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tE5g9oe8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D1F30499A
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240411; cv=none; b=jGTaOE0mAVO1DgrzJ+BTw6I2e+O+ga6Q7ukbQkIcuoaGF/OR/BtBrsXMyWCAj9U16tS9WJCi+F/KrzGVQQDwKu3Abu1AN5EJFXr6G2+IEJ3wecWN9fiJ7RA7rfPQj9SNKmailVT6TGKTbH2dIPuDlTmc/JlEQFjAmP+C1Ew1lis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240411; c=relaxed/simple;
	bh=sA3mx2HWfjIDrHbQQavcX6TV6BrMkyr0y8nWkwRlbHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IssX4Eih7mlieOPJ9T0d7eEP2Z3AS/JaJvRbHA98s7y0K32nHTlHdDPISdZPeTEDiM44p7tgvK7x0MoVX991+s5TpfMzH0a2oJdNde8rXSVDRG7J7bfi/ThCrgimtTfn5kZ+OPzezvQLl4YA+91poFpK+Qr3S0dRjrwU1PQrPBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tE5g9oe8; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7de7dc85b74so454836a34.2
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 14:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777240406; x=1777845206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SP/YI4HtDk0TtX1V0TKtvjH0atba9by0J0PL+dY5whM=;
        b=tE5g9oe8oxRe6CG7QGVGeFmoj32UikwNzkKfdGra4TWtcdtbEWeUNzrgajG2tSSQCp
         I9dT6eRkIebbJhuvGhHKBZzJrPvDoLKmHB5sjV3CBGOOB1wZ8u8KLO2MqBM/hgs5L/Cy
         dcpcsj6YhX7oRJlhrGEwHkERgE7Qj2BEbzMHbEy9GjGGk56fBnZO13aWf+SxlCABowQl
         NH//w+T11B4LpQqG3fX9iIyvnm6bGGEB8+VbI0XWDOqAwvkplrOrCEYMXLSBmuq0Uwrm
         UhjfHcyGK5PWaL8UNsfnQZN88O/uHrN2ZbShupY84IbP3Z6dtxyT3sCFl96T/WJmYsM6
         DK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240406; x=1777845206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SP/YI4HtDk0TtX1V0TKtvjH0atba9by0J0PL+dY5whM=;
        b=cbVEAC0Z4dhisibXNYrYjz618K+Xtf0ZSSSURVwTn4XvC9AFL6r5+ExXjiik454vGE
         j8nvC10gX2+oo3wTmgjeKVNIrqJaTAKBzaRqqV8bB1ybHnlkYVUZjMnh85eqqFlfe+xs
         yLyj3JRc1JG/c/EBvezNPy0hctHtSF19+f2/vsPgZq7aTAKWrjbGGldcIXkh0pITw1Zq
         +01wBUUL/zam6TTNQko71NhCRFDSb8v3Pxz1iwQkTOhqSl5jflZqkFkfLNa74opOluXb
         R6+cFbLeM9wdb2TixpvJezXDCk0xxidNXD7vBZcvwGASqZ+im/Zwt1lMpydiAYrdJ/kY
         f8JA==
X-Forwarded-Encrypted: i=1; AFNElJ/ObWfllrP7AmINcSgD8c/m8gR4Fn6SIMHRnYAymje2TW4t8eVlbeIyrhT9mzswkELKZCt/Te0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYlHZvUy5rhQ0dbV+tFTVFdh8u1XfGGLINBrH+4FHAIJ1uAXEZ
	IcQs3W6NHm/mEv7vTicxkqdSbVqEdqfOYlHTjChwFqV0Muy926Dk+CbRnuPgrYo=
X-Gm-Gg: AeBDievhOEG5xxlHsmX8zAkzkpxzEQE7BditzMl/CxfgURGXB61HzEgWhkRpdKFrjtT
	5o27Suj7ARXFD6bE7DGDy8K+c/jcqT+aYTCgDgE15oxXkQWmomNLJp6UhV55HAEQADaXI34f73k
	18WkXo7fm3mBl8wBoZV6MNfLWeYuPY02SH2pdwjKKgYw6k4Rvb+8hH6fEOwhHBMQsRRN2NCe5ok
	g8ZqoaFKamTJ0HTYC6INYkYZ0eALHYoT/Vd3tdVdLbG264KJOWpdosQj+QZE5yYsN9gH1R2d6cX
	h+W/GUxM2Nre2KVGMTrtWl/DWMCllrVI5BfTNB1X0kD28RsLSGuBn+b9NNmauanBw5W/LH2OGh+
	TXzqAlOvYVMLWgb49lUTtHA4NI2cuW9P5mizS+XzXZ3/7R7NaJqES2JPAvdqtlh8uvb4jyft8Ke
	uy+mbDL7fjN9+xFoW2a9mZVqXeQokwJBv9tEZ5wpr8FryJCrMdlnRpaBknwRJOOknBa8EyZxZ2N
	070lUuONYxVLm8alSO6FdsLiYhLUUQs2YbtVnsTIgc=
X-Received: by 2002:a05:6820:61b:b0:694:8d83:a344 with SMTP id 006d021491bc7-6948d83a592mr20000952eaf.16.1777240406227;
        Sun, 26 Apr 2026 14:53:26 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6962b40d504sm4738997eaf.10.2026.04.26.14.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:53:25 -0700 (PDT)
From: jbmoore <jbmoore61@gmail.com>
X-Google-Original-From: jbmoore <jbmoore@nooks.dev>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: "John B. Moore" <jbmoore61@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] drm/amdgpu/gfx9: replace BUG_ON with WARN_ON_ONCE for KIQ 64-bit fence flag
Date: Sun, 26 Apr 2026 16:52:52 -0500
Message-ID: <20260426215256.50722-4-jbmoore@nooks.dev>
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
X-Rspamd-Queue-Id: EB75746B537
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241195-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbmoore61@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: "John B. Moore" <jbmoore61@gmail.com>

gfx_v9_0_ring_emit_fence_kiq() contains a BUG_ON() that fires when
the AMDGPU_FENCE_FLAG_64BIT flag is passed.  The KIQ (Kernel
Interface Queue) ring only allocates 32-bit writeback buffer
addresses for fence sequence numbers.  A 64-bit fence write would
overflow the allocated writeback slot, potentially corrupting
adjacent kernel memory.

Replace BUG_ON() with WARN_ON_ONCE() and mask off the unsupported
flag.  This prevents the kernel panic while still logging the
unexpected condition and falling back to a safe 32-bit fence write.

This is separated from the main gfx9 BUG_ON conversion patch
because it addresses a different security concern (potential buffer
overflow in kernel-managed writeback memory) rather than the address
alignment assertions in the ring emission paths.

Found by a custom amdgpu DRM ioctl fuzzer.

Fixes: b1023571479020e9 ("drm/amdgpu: implement GFX 9.0 support (v2)")
Signed-off-by: John B. Moore <jbmoore61@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 47e81c33d..fb2a0f1af 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5679,7 +5679,8 @@ static void gfx_v9_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 	struct amdgpu_device *adev = ring->adev;
 
 	/* we only allocate 32bit for each seq wb address */
-	BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
+	if (WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT))
+		flags &= ~AMDGPU_FENCE_FLAG_64BIT;
 
 	/* write fence seq to the "addr" */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-- 
2.43.0


