Return-Path: <stable+bounces-231003-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJW8F6oKymmL4gUAu9opvQ
	(envelope-from <stable+bounces-231003-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:31:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC665355912
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE0493016926
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 05:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8593806A3;
	Mon, 30 Mar 2026 05:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELurACqp"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8CC8462
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 05:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848648; cv=none; b=KN/Wb/X8vJC0/VDK9L6Zdr2/lDqCrLNTmKIUKpqBCCLhz03tAJ0EahWWGlLlxUlvZ78dSKMMhEEFLdBB5WiAJzoEQp8eJVrNxTOEyWjPwjQNK3JIo93shVzXBSA0kjx8UVORM6WzYCHaZ2/8UWE8makwh3SaP2geLXvl4jk/xag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848648; c=relaxed/simple;
	bh=fbdG6MZVJOib0JNTgkvFhbUGVGvROA/9dgP1oNUk7TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfhKBw14GC6q3pLtqApL6qq8ZyLwayynFHz0329WTm5juRZdranL69s+9f3INfq4ffaEHrba6QdozYz/tVLVR1c+iNHKqpjcFSS7iQxbEMyDqJpMLsmiICHJl5Ph8NwW7bIsTIPvA4k3jAb7fq73Ot5zsu0CVFeEywf90TDJIK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELurACqp; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8f9568e074so592746566b.0
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 22:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774848645; x=1775453445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4h/NQNA+UNY/vL0CTGhvWEa0MkHre3ParL6tgrkGUs=;
        b=ELurACqpO+KltKktNedKhP7NKzBY9tsgBxIkOk8q9doJ1uRrvSVEK2/wNEwyA+KlLg
         adBD6q9860QaIW1tNBkPte8Hd1hlQJHTf8lz9WscoKAvMIgWgIFXjo2VzxPUAaDFkggi
         yaTqiCX62HFiCsQw63Zmj7ptsAVkXsorYxkpncjnxtNMWwsbnBBObTqoFL8N2KoW5gw9
         uUs+3b/y5h3G/8gyjCqEgfSVJpI+r89LfPPiPlpAeUKw3V0dQZBk1uTkH+JbSWJv8yG8
         HePeR4FBtTjQIgYSZSqSF891Cl2vVGqkhFwLNfS6xP3UbXshhy99DU/uk/CMf/lEwGL7
         3xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774848645; x=1775453445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p4h/NQNA+UNY/vL0CTGhvWEa0MkHre3ParL6tgrkGUs=;
        b=BtsdEWujOHCIRIJPePRGE9TFfdPPZBosdvpSHmVc1CQoeaavymG9wxgPbk0Jz+1FR8
         gxpNliM4OUZJLdQTOdqcP212KAKd+JECPmAUts1mjKpWEr8/ChKy2KnajujKJqHKeDpZ
         0x1GvN9efqVg6U5r1PjNFB3yVITMNlNW32p/Z6KkhR/zgZWua48AgqyAvMLvUmAL8d/c
         g4A0bgvBHI4GDt8LNPoRpm0H9xRNq5A8AeY18Up/NXES8xU40F70TPnSo1XM1MiG4/eF
         BRvVVFALRdNRCTj/1juWJ8PgJgwTuJsJX0uMQ/Bwci5obmC9vslHkzI47bN8TMWJv4p4
         7b1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnvjwLY4fiDGicvFvsPedBrlBViePljaixPajxKF8h/HGKluoc7/kgLTFL0YORIXdEtxm0ndQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnHCHLyE5sMmriV94X4dq/3hUYxi2HhhJgkP8BKOwjo1/9XQFM
	URIyRg6UGXyJLgYdQ2HtLncGS1C8KNRUXiSjTVnq9UtZh35LRN4xdFiu
X-Gm-Gg: ATEYQzzb4TSrljj2VYx3zhBkDzHoZEz7tjBqmhAduMIt9EUiflAcnz+t0fl+4jmNNMD
	aPl11+/5BCi9RZjjdOLm6I/RsQwsDcevBhlTNMXKLylz8Fe4OqR2bVlnedd3tan9J2FmhTqCHue
	DYLPdp76U1MrmtQrP/OEQFUJCrYH/8OZYM+tJCOw8l+uIXQI43U8C4J1QIgJSg/HbjzSdH8ZgFo
	PLciKwzWG0LoX2LNS+wGfSrCT1DpaAn+i0SEJk7MirpZzXaFKt/2Nd18hmz6As7dItWfxm7PRRg
	ufHVQEQXUMDdA9sFFVx1RhHdL58YBmZcEEp6EMnzU9yxVfMUF4r62pXXVUdsjdysieZKh89fSyy
	sXxS4rop0AEtWryoaiMwnzW3q1aXZpruX75OruJlK3djzeGvl1me8IwCPbO2QoycpXRoJPyM/v1
	1gRRIcNNXhH+fLxaiBEvlrehGIaqmgom8O
X-Received: by 2002:a17:907:9614:b0:b9b:e5d:71d0 with SMTP id a640c23a62f3a-b9b5098bb2bmr700871866b.53.1774848644973;
        Sun, 29 Mar 2026 22:30:44 -0700 (PDT)
Received: from localhost ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b1a5fc9sm240417066b.36.2026.03.29.22.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 22:30:44 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Eric Huang <jinhuieric.huang@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2 2/2] drm/amdgpu: use spin_lock_irqsave for PASID IDR lock
Date: Mon, 30 Mar 2026 10:30:25 +0500
Message-ID: <20260330053025.19203-3-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330053025.19203-1-mikhail.v.gavrilov@gmail.com>
References: <20260330053025.19203-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231003-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BC665355912
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

amdgpu_pasid_free() can be called from hardirq context via the fence
signal path:

  sdma_v6_0_process_trap_irq
   -> amdgpu_fence_process
    -> dma_fence_signal
     -> drm_sched_job_done
      -> dma_fence_signal
       -> amdgpu_pasid_free_cb
        -> amdgpu_pasid_free
         -> spin_lock(&amdgpu_pasid_idr_lock)  <- hardirq context

But the lock was originally taken with plain spin_lock() in process
context (amdgpu_pasid_alloc), creating an inconsistent
{HARDIRQ-ON-W} -> {IN-HARDIRQ-W} lock state that can deadlock if an
interrupt arrives while the lock is held on the same CPU.

Use spin_lock_irqsave/spin_unlock_irqrestore for all call sites of
amdgpu_pasid_idr_lock to prevent the deadlock.

This patch applies on top of "drm/amdgpu: fix sleeping allocation
under spinlock in PASID IDR".

Fixes: 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 515775eab2ef..762ceb3c708a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -62,16 +62,17 @@ struct amdgpu_pasid_cb {
  */
 int amdgpu_pasid_alloc(unsigned int bits)
 {
+	unsigned long flags;
 	int pasid;
 
 	if (bits == 0)
 		return -EINVAL;
 
 	idr_preload(GFP_KERNEL);
-	spin_lock(&amdgpu_pasid_idr_lock);
+	spin_lock_irqsave(&amdgpu_pasid_idr_lock, flags);
 	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
 				 1U << bits, GFP_NOWAIT);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	spin_unlock_irqrestore(&amdgpu_pasid_idr_lock, flags);
 	idr_preload_end();
 
 	if (pasid >= 0)
@@ -86,11 +87,12 @@ int amdgpu_pasid_alloc(unsigned int bits)
  */
 void amdgpu_pasid_free(u32 pasid)
 {
+	unsigned long flags;
 	trace_amdgpu_pasid_freed(pasid);
 
-	spin_lock(&amdgpu_pasid_idr_lock);
+	spin_lock_irqsave(&amdgpu_pasid_idr_lock, flags);
 	idr_remove(&amdgpu_pasid_idr, pasid);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	spin_unlock_irqrestore(&amdgpu_pasid_idr_lock, flags);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
@@ -633,7 +635,9 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
  */
 void amdgpu_pasid_mgr_cleanup(void)
 {
-	spin_lock(&amdgpu_pasid_idr_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&amdgpu_pasid_idr_lock, flags);
 	idr_destroy(&amdgpu_pasid_idr);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	spin_unlock_irqrestore(&amdgpu_pasid_idr_lock, flags);
 }
-- 
2.53.0


