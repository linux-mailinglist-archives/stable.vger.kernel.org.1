Return-Path: <stable+bounces-231178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEPnLiNhymn27gUAu9opvQ
	(envelope-from <stable+bounces-231178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:40:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DACD435A659
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81D98301C3B5
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD1B38551B;
	Mon, 30 Mar 2026 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwj6UNzx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B247A3B5307
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774870514; cv=none; b=pcySNEQ/3RyzUlI7G68DMmLgNieGji9oJLkbVZrlrVceOh94ZnmRGE0Qbvw4oUz7GVCkGH+nytbWumiENlpYyVeCUGSYyGkoChpzDR4nPkCpHJgMllQ6N1jp3NwzSfbTJqPLyFQSVJY2pZpAhwUmBEqi2W3PeX1jBy6N1u/JObc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774870514; c=relaxed/simple;
	bh=b4fSnX5MyjQGGrZgce59LCQN1UjeEyTMlWj8DV7Vwl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UWwPfcPD7ftIoR5+UL4HIqize9XQ7jM5Jk4WAx5q5jP2HW4jSFfy9yrQ8QOjGOJEKWntISgF/qQUmIWiY4i5FQ41K66JRxzofXl0wvaexbyPibfUbkjW8pZnNUQu2O0KX1/7vs9LMMQ29N6aYcP0qDRZNNyC1wN3LVrtuleUisM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rwj6UNzx; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b93698bb57aso800918266b.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 04:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774870511; x=1775475311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqY6YiaLNlQCEP7q+Nu54Vt1vO291I/2sltGJknyu9M=;
        b=Rwj6UNzxNk2tEsVIJc04NBJ6CgdRCklq0bQ6/6a12kLJd2Ue9VLL8VJ5pNcDzizToP
         ND8k0/a/+pKMRMr8rs/bhD4ya+1H0VUz0CdVvFVI1SXsYeom1EJvAn7j698UHh1Y5QLu
         zikJTCF+VIIetXw97AhavkIs+Y5zM+pl0qQXZGG5cFuqZ5Jjd2nm3MyN+ldZXd0sIyVm
         ce+lxccmNy4DsnjqIneffoNc1/ygwdPfj+yMMn7w0VydJBrGVFqzXyGqRz6aAQIoCuPl
         lnKTkvcuGwU/altGY2FePapnAm6sCNYz8l/a3mDt7y8SF0vXQwSDAM+uSLGi4YO7aUdK
         G8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774870511; x=1775475311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqY6YiaLNlQCEP7q+Nu54Vt1vO291I/2sltGJknyu9M=;
        b=UlBzTXk+Wiov65uvVJ8jelbgCSzRxYVa3OHmdki7v7jcMFBU7x3Cg8YXIsSj7dUlv0
         ir7KHlV202z3RfMves/AvqMULBjfsAaOlh/Kp2ohStQA+6vpFff59NFoMElRbDoDMbie
         bQNUHzndyeMhKIar1niY7U5gARU4Mu6zAl9CG1ODVSORS8iv2zPwoyr8Sb6Y9b7G7BjN
         xjyZOuQdX2+86rEH1KUF1FukvDvtY333IJvRR8ILnHHmx9khe1AWYjIlzes1TviLOXld
         nAIa64ssAICgi2Hp1lF33x1usJAlklziufIgziEpAU69x7MnhOv2XkV0SuktW+xNWohS
         3VYw==
X-Forwarded-Encrypted: i=1; AJvYcCV3wwGMZJ+vgMi/LxmU+B5sdZf/q0JL3uefatfNBhqW4dWUio2mm1ZG4cOmpjAwZLox1phLO3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNVRrUVSXTt2fXHZOwkS1n5hfMdeSpA1q/bHNrO1m9pYfjXBKm
	ekNumR16u+4PvSf5UuH1r9Qpi2/NKPUkKRAoqjkA8aU85gU8IbJ04tj2
X-Gm-Gg: ATEYQzwz3/gKlfX/Wgwo71kO0yvIMMYt+IbmcXXGt9Xn8Cc86AAKts4BERBZEbH/1W1
	ty/XCJX5ASoHaCBHHETO6c+C6fXhrdqe5FfGsjnuXIig0czSovY5iZ7ZrYuld6RBd7XXqinq9Xz
	C5fEqBppBhIetDbaEGVqT2GopCE8FSxPzF0kNE7QVUMLfuiesFs10lGJeYzcwFwsi7G7k2inRKF
	LRTNxi4EOZIqyN8Wo93uWM0p8noeDTDAiyn9OK/NfGZfZnv7VJtEheCB081tGuqtuZdt2u13d2E
	/ETdOubzc5mS2cfyT3Wd/mx9enN0hb9QP7QGK+BDicGElEJNs2YdGVp5xfnCGwz27Zsi/HP18/P
	OF97pAhjaAFzhdhxxgt8NAMZQx/WN8V5bH4+d9IfJ0FDg0vqJtkVM+PmRqJHJkDfTB5o2+Go3T2
	1W/AdOKKDqvwvytSh8YINDfyTjY3zGg7an
X-Received: by 2002:a17:907:2d8a:b0:b98:f1d:6a63 with SMTP id a640c23a62f3a-b9b2e5921bbmr865454266b.9.1774870510699;
        Mon, 30 Mar 2026 04:35:10 -0700 (PDT)
Received: from localhost ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66c07ab15basm369758a12.17.2026.03.30.04.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:35:10 -0700 (PDT)
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
Subject: [PATCH v3] drm/amdgpu: replace PASID IDR with XArray
Date: Mon, 30 Mar 2026 16:35:01 +0500
Message-ID: <20260330113501.25654-1-mikhail.v.gavrilov@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-231178-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DACD435A659
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

Replace the IDR + spinlock with an XArray, which provides built-in
cyclic allocation (__xa_alloc_cyclic) and fine-grained IRQ-safe
locking (xa_lock_irqsave).  This fixes both bugs in a single,
cleaner conversion.

Suggested-by: Lazar, Lijo <lijo.lazar@amd.com>
Fixes: 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

v3: Replace IDR with XArray instead of fixing the spinlock, as
    suggested by Lijo Lazar.
    https://lore.kernel.org/all/20260330053025.19203-1-mikhail.v.gavrilov@gmail.com/
v2: Added second patch fixing the {HARDIRQ-ON-W} -> {IN-HARDIRQ-W}
    lock inconsistency (spin_lock -> spin_lock_irqsave).
    https://lore.kernel.org/all/20260330053025.19203-1-mikhail.v.gavrilov@gmail.com/
v1: Fixed sleeping-under-spinlock (idr_alloc_cyclic with GFP_KERNEL)
    using idr_preload/GFP_NOWAIT.
    https://lore.kernel.org/all/20260328213900.19255-1-mikhail.v.gavrilov@gmail.com/

 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 50 +++++++++++++------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index d88523568b62..1e660fbc42ff 100644
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
@@ -62,20 +61,25 @@ struct amdgpu_pasid_cb {
  */
 int amdgpu_pasid_alloc(unsigned int bits)
 {
-	int pasid;
+	unsigned long flags;
+	u32 pasid;
+	int r;
 
 	if (bits == 0)
 		return -EINVAL;
 
-	spin_lock(&amdgpu_pasid_idr_lock);
-	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
-				 1U << bits, GFP_KERNEL);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
+	r = __xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
+			      XA_LIMIT(1, (1U << bits) - 1),
+			      &amdgpu_pasid_xa_next, GFP_ATOMIC);
+	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
 
-	if (pasid >= 0)
+	if (r >= 0) {
 		trace_amdgpu_pasid_allocated(pasid);
+		return pasid;
+	}
 
-	return pasid;
+	return r;
 }
 
 /**
@@ -84,11 +88,13 @@ int amdgpu_pasid_alloc(unsigned int bits)
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
@@ -625,13 +631,11 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_pasid_mgr_cleanup - cleanup PASID manager
+ * amdgpu_pasid_mgr_cleanup - Cleanup PASID manager
  *
- * Cleanup the IDR allocator.
+ * Free all internal data structures of the XArray allocator.
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


