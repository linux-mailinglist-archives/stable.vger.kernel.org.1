Return-Path: <stable+bounces-231267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLT3AujKyml3AAYAu9opvQ
	(envelope-from <stable+bounces-231267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 21:11:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA7F360368
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 21:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BA7D30185DC
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 19:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3503E0C7C;
	Mon, 30 Mar 2026 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWF9BsbQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327E13E023E
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 19:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774897889; cv=none; b=ou9e46dmAqLU6src4v80L2jpB2tTyjDDmlafQK2UHhN5VH5l8Jr2q8SPKdCdDVM4KJlOkCZMwp5EzjaHyis4AWX6GmxjHkN1SL7QjVP+qTVMS9tgl9IXi+6pFVX9UrR0wM9g6f17nqNY+0DkgN8glXdL34oGTJp9lvL9e9k5y9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774897889; c=relaxed/simple;
	bh=ch6ZSz4had+8Tn9Nj/vYlVj3OBl/476v+kXgpd5Sxjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JYXWX17bme+vMm0L67FC7IWUOKeu8geQoFsLEtqQdulN5FIJvJYWGcMHBoaw0G5A6rOxWMWxEfXdZpJKoNLv/zPn2czCCp5TC4ZoJE6ic5s/foRmusWKXL97BzKNitUoNwa8KbkRdXVLsPp10RSkpbHo1Iq+aV7naj0On2kicUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWF9BsbQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9841aecf72so583625366b.2
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774897886; x=1775502686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6a4ZAZ+tx15YWcQtSZ0Ur1vxlfH/UsJLxqB03uCLMU=;
        b=IWF9BsbQtzsGducqgOpNIJYoDa8PV282fJ8o1oEIWJyi/eH0qCluvnNDtJkPP041q+
         p8zJ2Jk7X7K/4PSEoI0LC8yKQuctDhEXnmtCKP0lTHzoHzjBIFpUKZjp64fBiNyPCRwf
         LtoVh5MG0wF3Bka/peZMsaocJ0Z35Q/AuTvm2galnNaTQyWowtggDpU8b+XXuBMrBmJu
         6REeIHOTponHfUQ1AUMumTELoNBY3v9mOI/2IoGOrZEzaxVKUsSQmj8o0N/IUhtflDAO
         p8VnHaTw5k0V+dNv0a2HaqrN+1zm4wNicGGko6Wv7uyZNk7gz/+GTtdXdAmkYQt3tBtn
         7uBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774897886; x=1775502686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6a4ZAZ+tx15YWcQtSZ0Ur1vxlfH/UsJLxqB03uCLMU=;
        b=Yb9iNqOV2BJQ4xdgNgsI/RE43aPNGvEJf01+Wdq8zBXs5E86/papK27N5DPiJ87s6/
         Lzw9Y+X6v7mGtry/kExSd78AesxtsQGABlhEM/Q1P2vjPBzK2MEs7SBUNUECknaW3zAr
         Fwwe+p0UYnLtozQHJb6gt2XHVWEMv+FZPB3p4/7WCksg0uqM3RTki8Yu8bdjEw1dnPGX
         JJlk6RYZhaPqzXQ/SMjmwlY1Zq9pjY26FOnyNMyLj5hZ71mP3ytOoKwhwFFMiPDNmfX0
         qvootItB0m8x7HjA9eXdoyTQk7QPQc3NtyDK/CtDZMoAe4TURDxCKH7rW6irRapJW9cq
         O0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUYAYHTjRYz9Yt3EE9V3uM4AwG0Q3rlGuo4g3PcjFP1pCNRMtMuT85n1FtNchlBepALFE5BptE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqJoqhgUywqzEMCJsy5LLNFu9anDfeHIwF1b0TKH1+iZNO4ErI
	Rq4xoHZCmF43fSKgk5PkcLQD/5/4SzzlpQBu7ap2biHvNgghBTdZQWSJ
X-Gm-Gg: ATEYQzwVafTuEFbh1ZcYN3Y2lRZpsuXZzvt8JG8/pi2RBvSxMYBGwbsuHP8yBujALhP
	XGfvSRGf7nJ0uA2LzqILpBLoyKcoSfKI9HQFF1oX5uSjGlS+YfZyEbYwXCvqk6SeMYITxGET9mx
	LlYuMI0uDtRZyGFIejit51y6PAEg5aK6LRlybD3QUvlD/bbuYJJoV7sU0ABo+1qJ2hae7o2v5ML
	KmEjxvz34RuaJAKD6bK78cQZyhBo3DVCti04gH/6CmVp3wRgKBtwF5jhr3ZMSWrrcLTZBooZG7X
	PSCqq5FZrruH6yU4V2euM0n78GQvz7zgCC1rwh3HkT2GqkR99eoIvGWIX69hNttLEL4wRzvaa4e
	9IjJAjF2qKvAABjE/SJYjTCPzyLB8+CvYImeZZcR4mpL8Cy7IPamEukC2MiAmrl3012gfN4veOO
	8c6F1XnCcFTpTsf2sbLV1so764TRkmMUlJ
X-Received: by 2002:a17:907:9711:b0:b9b:63af:d9cf with SMTP id a640c23a62f3a-b9b63afda64mr750376566b.48.1774897886184;
        Mon, 30 Mar 2026 12:11:26 -0700 (PDT)
Received: from localhost ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7ae52295sm330600666b.24.2026.03.30.12.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:11:25 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: lijo.lazar@amd.com,
	Eric Huang <jinhuieric.huang@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v5] drm/amdgpu: replace PASID IDR with XArray
Date: Tue, 31 Mar 2026 00:11:20 +0500
Message-ID: <20260330191120.105065-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-231267-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BA7F360368
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
converted the global PASID allocator from IDA to IDR with a spinlock
for cyclic allocation, but introduced two locking bugs:

1) idr_alloc_cyclic() is called with GFP_KERNEL under spin_lock(),
   which can sleep.

2) amdgpu_pasid_free() can be called from hardirq context via the
   fence signal path (amdgpu_pasid_free_cb), but the lock is taken
   with plain spin_lock() in process context, creating a potential
   deadlock:

     CPU0
     ----
     spin_lock(&amdgpu_pasid_idr_lock)   // process context, IRQs on
     <Interrupt>
       spin_lock(&amdgpu_pasid_idr_lock) // deadlock

   The hardirq call chain is:

     sdma_v6_0_process_trap_irq
      -> amdgpu_fence_process
       -> dma_fence_signal
        -> drm_sched_job_done
         -> dma_fence_signal
          -> amdgpu_pasid_free_cb
           -> amdgpu_pasid_free

   This was observed on an RX 7900 XTX when exiting a Vulkan game
   running under Proton/Wine, which triggers the fence callback path
   during VM teardown.

Replace the IDR + spinlock with XArray.  xa_alloc_cyclic() handles
GFP_KERNEL pre-allocation and IRQ-safe locking internally, so it is
used directly in amdgpu_pasid_alloc().  For amdgpu_pasid_free(), which
can be called from hardirq context, use explicit xa_lock_irqsave()
with __xa_erase() since xa_erase() only uses plain xa_lock() which
is not IRQ-safe.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Fixes: 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

v5: Use explicit xa_lock_irqsave/__xa_erase for amdgpu_pasid_free()
    since xa_erase() only uses plain xa_lock() which is not safe from
    hardirq context. Keep xa_alloc_cyclic() for amdgpu_pasid_alloc()
    as it handles locking internally. (Lijo Lazar)
v4: Use xa_alloc_cyclic/xa_erase directly instead of explicit
    xa_lock_irqsave, as suggested by Lijo Lazar.
    https://lore.kernel.org/all/20260330162038.25073-1-mikhail.v.gavrilov@gmail.com/
v3: Replace IDR with XArray instead of fixing the spinlock, as
    suggested by Lijo Lazar.
    https://lore.kernel.org/all/20260330110346.16548-1-mikhail.v.gavrilov@gmail.com/
v2: Added second patch fixing the {HARDIRQ-ON-W} -> {IN-HARDIRQ-W}
    lock inconsistency (spin_lock -> spin_lock_irqsave).
    https://lore.kernel.org/all/20260330053025.19203-1-mikhail.v.gavrilov@gmail.com/
v1: Fixed sleeping-under-spinlock (idr_alloc_cyclic with GFP_KERNEL)
    using idr_preload/GFP_NOWAIT.
    https://lore.kernel.org/all/20260328213900.19255-1-mikhail.v.gavrilov@gmail.com/

 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 47 ++++++++++++-------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index d88523568b62..3fbf631e67c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -22,7 +22,7 @@
  */
 #include "amdgpu_ids.h"
 
-#include <linux/idr.h>
+#include <linux/xarray.h>
 #include <linux/dma-fence-array.h>
 
 
@@ -35,13 +35,13 @@
  * PASIDs are global address space identifiers that can be shared
  * between the GPU, an IOMMU and the driver. VMs on different devices
  * may use the same PASID if they share the same address
- * space. Therefore PASIDs are allocated using IDR cyclic allocator
- * (similar to kernel PID allocation) which naturally delays reuse.
- * VMs are looked up from the PASID per amdgpu_device.
+ * space. Therefore PASIDs are allocated using an XArray cyclic
+ * allocator (similar to kernel PID allocation) which naturally delays
+ * reuse. VMs are looked up from the PASID per amdgpu_device.
  */
 
-static DEFINE_IDR(amdgpu_pasid_idr);
-static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
+static DEFINE_XARRAY_ALLOC(amdgpu_pasid_xa);
+static u32 amdgpu_pasid_xa_next;
 
 /* Helper to free pasid from a fence callback */
 struct amdgpu_pasid_cb {
@@ -53,8 +53,7 @@ struct amdgpu_pasid_cb {
  * amdgpu_pasid_alloc - Allocate a PASID
  * @bits: Maximum width of the PASID in bits, must be at least 1
  *
- * Uses kernel's IDR cyclic allocator (same as PID allocation).
- * Allocates sequentially with automatic wrap-around.
+ * Uses XArray cyclic allocator for sequential allocation with wrap-around.
  *
  * Returns a positive integer on success. Returns %-EINVAL if bits==0.
  * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
@@ -62,20 +61,22 @@ struct amdgpu_pasid_cb {
  */
 int amdgpu_pasid_alloc(unsigned int bits)
 {
-	int pasid;
+	u32 pasid;
+	int r;
 
 	if (bits == 0)
 		return -EINVAL;
 
-	spin_lock(&amdgpu_pasid_idr_lock);
-	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
-				 1U << bits, GFP_KERNEL);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
+			    XA_LIMIT(1, (1U << bits) - 1),
+			    &amdgpu_pasid_xa_next, GFP_KERNEL);
 
-	if (pasid >= 0)
+	if (r >= 0) {
 		trace_amdgpu_pasid_allocated(pasid);
+		return pasid;
+	}
 
-	return pasid;
+	return r;
 }
 
 /**
@@ -84,11 +85,13 @@ int amdgpu_pasid_alloc(unsigned int bits)
  */
 void amdgpu_pasid_free(u32 pasid)
 {
+	unsigned long flags;
+
 	trace_amdgpu_pasid_freed(pasid);
 
-	spin_lock(&amdgpu_pasid_idr_lock);
-	idr_remove(&amdgpu_pasid_idr, pasid);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
+	__xa_erase(&amdgpu_pasid_xa, pasid);
+	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
@@ -625,13 +628,9 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_pasid_mgr_cleanup - cleanup PASID manager
- *
- * Cleanup the IDR allocator.
+ * amdgpu_pasid_mgr_cleanup - Cleanup PASID manager
  */
 void amdgpu_pasid_mgr_cleanup(void)
 {
-	spin_lock(&amdgpu_pasid_idr_lock);
-	idr_destroy(&amdgpu_pasid_idr);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	xa_destroy(&amdgpu_pasid_xa);
 }
-- 
2.53.0


