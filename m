Return-Path: <stable+bounces-231244-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC1+ILyPymn09gUAu9opvQ
	(envelope-from <stable+bounces-231244-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:59:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5198D35D52E
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95A22302EE96
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFF33254A3;
	Mon, 30 Mar 2026 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qExj1jP5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6696019CCF5
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882258; cv=none; b=STSUWEavd6v4/dLiv1S8Tfv+Dc4io6a9CCvDGnaHhQqvckhwdPtq341COf0Ak1WQdFfm5GhXVcsSF+FPy0VPcYogTm9cNS17gxcP3+tnnL9sJuKiLJTu/IsntthlZVnzOhSmuJ6Kzv0RLd46wO4cL93AdqvRe5XepBgGDBD8Lx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882258; c=relaxed/simple;
	bh=60SnPQByYHOM/RTzrzGfmR1Mc7EOtQsTFIntcfQQnlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E+dXjBYqrsJdv77JSBltedxsc2aQmSdP5TMFHeShirITLaetB4z63Y1yQ3s88Wgl+19cu5xR3zEG82BdF7WVvzxAt1GvfF4b9JHEJ8MtFIvxKEzm2sg4+R3Xx30bcKyKUxmiTBxtiSeRKSUF8B66nUX9s1d7gliHCcX14eRFiho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qExj1jP5; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9382e59c0eso738322166b.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 07:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774882255; x=1775487055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iEQgyKbT1VQKSh6QDXL908TnF5Z4/wgCTC4niu9wvmY=;
        b=qExj1jP5PR7Q8Ogm6obtkSGPeimtPdkp80nMtxZ5Rd1lJrvrht7d0BDsEUsiL7R7gO
         nq7RqjqnUQgcdAhlRqyWT6GBerwP7v4nlR/f646c/ELyX7WaBNB4jtji3qJUOBxQP6yz
         d1Aq+uxlPMbd+40qDUGIMpswypvdDRtUB/5pTGelwu8tj+KCaBeWFAhRfgiRqVONGq5C
         wuNoL510mW0MFEfHte2xCAHnUEErW3zQz//ZmrxnbE6Wy/kM+eAcTqXI84WiQekIC59A
         J8axv8anuepDrn/J2AWsbQhUFr5V/jeHPcGjOHzTBZeDTC1naErak0VvPDrKQhbOJauA
         2B6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882255; x=1775487055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEQgyKbT1VQKSh6QDXL908TnF5Z4/wgCTC4niu9wvmY=;
        b=OFgcHcS1KXjfT7Eyf6EnVo7DStchxNwiNTkkQPKxqzzghv38dAHNYy+5R7zkObmGPe
         HRqlWMZH8LsTkw7Fci5neuFHKfk4A2KUkwyyhTOCM8PhqzIK1hZbjwbSirRAbomz+mSB
         aMlX0HyOtIIN9EK6tgPrg20Nwa3imBL5H3maWfKCIWCAZuLRDUKFzMrNRc5xN4sFDZZi
         SIiLqPMLIC6o42dpI5v4Eq2Np//Qj5OUnpxUn74f64YFD3p5CFMMWcxTHYF5jndiwt+b
         lAjG7h1t0byB7GMut9NT4+LeKOk8JwF4Q6ZUD2JMYbLsu44DxN5wTX0JeOTD3cGkzhbx
         xDLw==
X-Forwarded-Encrypted: i=1; AJvYcCV89H1iDBBS3fy8AsC8KdBRQYTy6pm2M40+Z2XmCFdIja0HEUt6xFlDMioNN2dOO0CiI2lvfWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4RH0zrSlgrxhE3hEISTvDxHiHTSlQVrnOdUwUIst43mTJtIle
	81i3V6BvMJ6S0DtNg5y5Gv53+joJd8ca9oL8h+2xi93h8ghL8VEG4+vK
X-Gm-Gg: ATEYQzy7yt7GA5lOiTpENxuRqQg6eMLHKC5c6ZDgZGFrx6/9Gq5pqYLaAqRe/a7oFCU
	3QnqlOE5O+Vam6n6iPldNjHkdLdFT0kSGuYvW0+eDqGuFBjsNdpj1b2CkzX76IV/f6lEkrORbRX
	nW9X4sv7SzrJaNRHXF7/s2FrWZsZ1xGJhlVff0qjVKMnfHTr84SicATXnd9c+yNahracyFQlp1r
	pW9KOjJvEjjP2aBl4NyN1/6DVKZmI8+KPfgoSz6Kx9tOJ51CzrCAhjVHcLwEDElosb8OWC4/6xz
	e87woOYercnyDlwoD84tbOuyctmdF6Tb8q+Yiwr8Gyx+ETYVU73ESX/j7MQV8dC+GCuaaQpUSnh
	5sTKqZ5bEYGlCLWuNEz2xmRpV1SUzhYPJCGoh7F4ltuhuAqXT9zgKmzYRQ59LLOTLq2mJ5+Cduq
	L1q7UsfhlGe0Hv8b3CPMnp8XttylywmLKLqGqc9TSC8xo=
X-Received: by 2002:a17:907:2d8d:b0:b9b:207c:f7df with SMTP id a640c23a62f3a-b9b507a92c1mr792638966b.29.1774882254394;
        Mon, 30 Mar 2026 07:50:54 -0700 (PDT)
Received: from localhost ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66b7340cae2sm2848609a12.11.2026.03.30.07.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:50:53 -0700 (PDT)
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
Subject: [PATCH v4] drm/amdgpu: replace PASID IDR with XArray
Date: Mon, 30 Mar 2026 19:50:49 +0500
Message-ID: <20260330145049.21936-1-mikhail.v.gavrilov@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231244-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
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
X-Rspamd-Queue-Id: 5198D35D52E
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
GFP_KERNEL pre-allocation and IRQ-safe locking internally, and
xa_erase() is already IRQ-safe, so no explicit locking is needed.
This fixes both bugs in a single, cleaner conversion.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Fixes: 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

v4: Use xa_alloc_cyclic/xa_erase directly instead of explicit
    xa_lock_irqsave, as suggested by Lijo Lazar.
v3: Replace IDR with XArray instead of fixing the spinlock, as
    suggested by Lijo Lazar.
    https://lore.kernel.org/all/20260330110346.16548-1-mikhail.v.gavrilov@gmail.com/
v2: Added second patch fixing the {HARDIRQ-ON-W} -> {IN-HARDIRQ-W}
    lock inconsistency (spin_lock -> spin_lock_irqsave).
    https://lore.kernel.org/all/20260330053025.19203-1-mikhail.v.gavrilov@gmail.com/
v1: Fixed sleeping-under-spinlock (idr_alloc_cyclic with GFP_KERNEL)
    using idr_preload/GFP_NOWAIT.
    https://lore.kernel.org/all/20260328213900.19255-1-mikhail.v.gavrilov@gmail.com/

 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 43 +++++++++++--------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index d88523568b62..2b63b54eaaa7 100644
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
@@ -86,9 +87,7 @@ void amdgpu_pasid_free(u32 pasid)
 {
 	trace_amdgpu_pasid_freed(pasid);
 
-	spin_lock(&amdgpu_pasid_idr_lock);
-	idr_remove(&amdgpu_pasid_idr, pasid);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	xa_erase(&amdgpu_pasid_xa, pasid);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
@@ -625,13 +624,9 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
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


