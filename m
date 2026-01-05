Return-Path: <stable+bounces-204869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C12CF5079
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 18:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1A7A30321E4
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 17:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1470B32BF42;
	Mon,  5 Jan 2026 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ILNpMCE7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7055B1FE45D
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634440; cv=none; b=Ud5nUtbg9BMIU8tBcRPYwmd830pqKn8ZRX82Mb5+28k5VMkINv1dgi3X+dTTrDBggKwUNj73Kh/eE+dtZ4URIActLm88XKlw5EyY4Em/Jg5q9woWnHWR5ZEdBn80gzgf5ARtf2v8HhMsyhUBLl19X2cuboQ9Z1csm9FpB5+szB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634440; c=relaxed/simple;
	bh=FI/y3k70MGEsrWBmOco0n5n5y8bTb8Z/9pdkQyecoUw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S+173KYtHWhvQEtsTuMDUSfKfXKYD1z5d29Ox7wlFnDpAyKLgJ43+ijHoI2b+1qXsBIFZOC5va8OPU77Jrm7W4GhHnAdssriPZz0ile7T9aZE2u/jPpgnkCATipJ+bzltgCv/UTbEba9AICQPMLWXukCpbUCrldJgmz1ykcpby0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nktgrg.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ILNpMCE7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nktgrg.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34c213419f5so174934a91.2
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 09:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767634439; x=1768239239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IMKJH4+cAbmF7zR34yBcAd2WgEHbDH4oxuDfD1twveE=;
        b=ILNpMCE7S3fvcUcwHqj8YBIVNilyUMnLER/Vbo+CtmTyOxqZ2HZgVqWDBexXIRqDtl
         g2Dt/0wcIDIlw/HvlramDnQKuzqMhAZU7mUy4cuOzIDCha20g6wEwzaKowYkxNiL1Kdq
         QdLNPLGHhdGmYBBLUnrGVxP6Srtk/xwZyY4jU8Km3P8ykww6PYw3EudtwGebtBDbtvfJ
         0zGPIcYnvgU246aMTNtBlPfg1rP6PEaQ00g/ZP4RKXJ4+I0czf3u30jvbe9ZVv3N8qqn
         wR62Sjpa6kKE8UxTUp+yPfx2Rt0MEmGfukFVbP2ZSp+Zz0JjOG+eeYhinHvvuhn+DmXw
         VZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767634439; x=1768239239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMKJH4+cAbmF7zR34yBcAd2WgEHbDH4oxuDfD1twveE=;
        b=Eot2Fwn6Fq7BSEuQ9V+AmoK9Br5SSfAR8i90nIGxm4b5KafeaRUeSMZk47rfrVeODQ
         1xKI7hG75qHAKH8C+2Gr5WyvLHnhuScJI6N4ZuAIaJfdljDZNOx/eOtvf8VQswzPdOgT
         zR7CgjnH1qAqLLkODen5jVIgmbwRqqgR2chcaLurLe1EAx16DxTTKNDoB5xQmJdAVwPg
         jKgfOMlUcubi176owgTDaChjCe13PKhJyZE2stFa9FO1pDHiK9ZPK17iZ86LYRudqi+1
         NTQhKLL4OXvebOTzu3R8xAzMaiLHZmRG+O2a48571atCRduY1rVwiDlj0F4dju5QWvSX
         oDKA==
X-Gm-Message-State: AOJu0Yykv0zU2zxC+G5ZyrNoCGKOZBYlNhOzQ2gnMdJEO16jtrmxNvDV
	xU/sFQsQmcM6Vx6XMr9gbRSHOXpIWjVgFN+mUy+hQryc7MEIVlJwzj/9cETLTxaQJCVbKDb8GTq
	foCuqWVtkwWHTo2srYxpId04HbAW3pwC+G9YovBAhNLQzzceAWwhAQBr8lngHHR87pRD5n6vEuf
	Gm6DS6J4lbW2v9wle3pvfBGsyHl4Rv5qV50Yex
X-Google-Smtp-Source: AGHT+IEZXN8L9YVjHhkLypoRKfnVHlDnIiIGr0zmf5DOsS35ZB7lQ9cER4vb0gEIHtR3rfULdNVYtJaQGVg=
X-Received: from dlbvv19.prod.google.com ([2002:a05:7022:5f13:b0:11d:cf4c:62ab])
 (user=nktgrg job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:629d:b0:119:e56b:98bf
 with SMTP id a92af1059eb24-121f18f09c4mr70065c88.38.1767634438441; Mon, 05
 Jan 2026 09:33:58 -0800 (PST)
Date: Mon,  5 Jan 2026 17:32:54 +0000
In-Reply-To: <2026010559-clock-gore-94e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026010559-clock-gore-94e2@gregkh>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260105173254.1676720-1-nktgrg@google.com>
Subject: [PATCH 6.12.y] gve: defer interrupt enabling until NAPI registration
From: Ankit Garg <nktgrg@google.com>
To: stable@vger.kernel.org
Cc: Ankit Garg <nktgrg@google.com>, Jordan Rhee <jordanrhee@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Currently, interrupts are automatically enabled immediately upon
request. This allows interrupt to fire before the associated NAPI
context is fully initialized and cause failures like below:

[    0.946369] Call Trace:
[    0.946369]  <IRQ>
[    0.946369]  __napi_poll+0x2a/0x1e0
[    0.946369]  net_rx_action+0x2f9/0x3f0
[    0.946369]  handle_softirqs+0xd6/0x2c0
[    0.946369]  ? handle_edge_irq+0xc1/0x1b0
[    0.946369]  __irq_exit_rcu+0xc3/0xe0
[    0.946369]  common_interrupt+0x81/0xa0
[    0.946369]  </IRQ>
[    0.946369]  <TASK>
[    0.946369]  asm_common_interrupt+0x22/0x40
[    0.946369] RIP: 0010:pv_native_safe_halt+0xb/0x10

Use the `IRQF_NO_AUTOEN` flag when requesting interrupts to prevent auto
enablement and explicitly enable the interrupt in NAPI initialization
path (and disable it during NAPI teardown).

This ensures that interrupt lifecycle is strictly coupled with
readiness of NAPI context.

Cc: stable@vger.kernel.org
Fixes: 1dfc2e46117e ("gve: Refactor napi add and remove functions")
Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
Link: https://patch.msgid.link/20251219102945.2193617-1-hramamurthy@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

(cherry picked from commit 3d970eda003441f66551a91fda16478ac0711617)
---
 drivers/net/ethernet/google/gve/gve_main.c  | 2 +-
 drivers/net/ethernet/google/gve/gve_utils.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 497a19ca198d..43d0c40de5fc 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -500,7 +500,7 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 		block->priv = priv;
 		err = request_irq(priv->msix_vectors[msix_idx].vector,
 				  gve_is_gqi(priv) ? gve_intr : gve_intr_dqo,
-				  0, block->name, block);
+				  IRQF_NO_AUTOEN, block->name, block);
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to receive msix vector %d\n", i);
diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
index 2349750075a5..90805ab65f92 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.c
+++ b/drivers/net/ethernet/google/gve/gve_utils.c
@@ -111,11 +111,13 @@ void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
 	netif_napi_add(priv->dev, &block->napi, gve_poll);
+	enable_irq(block->irq);
 }
 
 void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
 {
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
+	disable_irq(block->irq);
 	netif_napi_del(&block->napi);
 }
-- 
2.52.0.351.gbe84eed79e-goog


