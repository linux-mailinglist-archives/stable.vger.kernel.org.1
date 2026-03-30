Return-Path: <stable+bounces-231001-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHMCMH8KymmL4gUAu9opvQ
	(envelope-from <stable+bounces-231001-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:30:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F5A3558DA
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB5DA3002B0A
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 05:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8762F3806D2;
	Mon, 30 Mar 2026 05:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iitq6aiP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCE131E854
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 05:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848637; cv=none; b=VGxjK8LBXh7Pmq8r37qy8XIlcXhi74QRlC5ft6IXYoK7pPYAR+p6gwT1fbEQS6XdvJidnuadMNcshq4WQHNUkBNfwZBDiE9ezQIBEf+9SUZjpZSwMfmhDyNwPZ26g7W7fsBEY9aCPuhZmvZx38bT8PsBQBdHy4EDPicvwOrYdeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848637; c=relaxed/simple;
	bh=Izh9RIch/mHEFm3p7OFD/Jw9SQPq9Gu+jViwIvzPbq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o8TPSvuj4gC2AEkVAwaclbOMf6m4D7Y84pOXvlHq1/X/Seuuy0epmhp6+JAKt4A8PL14MDb89v2UwaVGBlR/zzmMK89ctUUVC0XbJKKNYWIH8k3ODfamIru8pwv/EnPv7TPveJT3sj4K7zHxxnMuCiJL/eg6zx3W0gSv0IiyvEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iitq6aiP; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66bd4f7b2d3so694380a12.3
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 22:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774848634; x=1775453434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rzyOkW6psCI+1rNPxWyjW/PJoO9NXtwwLlsKbLLkl+8=;
        b=iitq6aiPhSzdqY5TXNVQrBmVsNw0jbvOgkj5N9ZGBb1L9SWoLYEDSfJdoOyTWLSk07
         rTjxdhvgRWM8LEotpJgUD7mlgCn3yaY2ri9Wz3HfXqzru+kj5LjY4JMCvmtHvo5tE/22
         QSnyZ9IY3A8vy0+Qd+pcyMTISPxau+D28qztJZB7WkNHl+wEoZKmppu/bZDNNHvPgl7c
         1quAeky8lKPxSqnIAkg3bBKrnsAze+mHhVLGpGhzrOyu+jc7IPeRPvrdqOuUCgi4qBOE
         1A1hm1wHxS/VGFAyfqIifPgqyXzyIrH9ukGPt41w6bVVoxITnrCAsHEFdNTVaCKlGHbh
         5blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774848634; x=1775453434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzyOkW6psCI+1rNPxWyjW/PJoO9NXtwwLlsKbLLkl+8=;
        b=ivbNezBxgoa9vgphfK5BMtBZTA3+c7Kebycn96leDNw1j7v5k0pqrxYRvjx6i2zejN
         kCaXAfOLNM5XU+d+6YYvBjzMppZWI2Uku339UC6NdaSkijaB7bqivs06QsfmeU3lxZdW
         6ynrhRuXVuPXA+0I5aldyJgj5O2jAlNfoefVQqnnF+1kLvP4TMwAqGdHYBUZHwgzin8h
         8DUlUjrdwmw9M5/MTF1+JNu2ewEENFhASL741S37tdnOq7108W6t34uIwiotaMM8DV0H
         OSxUNE54+Si98YDmdEU3TMSkp7Vj6Z+NEVSkpOcbxudgHkLJ5LzSt7f4eYjiyIIC6S+/
         c3uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkn62Pue1ystNwIuaykOOy0/RmX9aAtDVuhQomgN+75ZuLzopUJ4nL2dd/1hVo5mZJEDZpOvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG3TkWTybslxVYvxMlaviEJ+we/5zwdoc9rfNGUldYpuPyGi5t
	WwyAjMpiHV1iepqXzoFEl8BsvuR42Cpni51JMt3/1WXXAuekChNdp5B7
X-Gm-Gg: ATEYQzwiMQ9sn+12sod2vomiNtLqY/yUba50rc9FbHxUdEOWokWm1PLvc4OMWSFHHzQ
	oZxQVZlH3qWIlMwTHmmMTNKuFLjv1ReU8zN83LPwKH2yngichvBOcudOzDb6Iw+DXnB2BFoyPi2
	CBVnrBcJ59051gskV4FZhGDkggNI0e/YCWvROpgfH8HHlp4OHxoQ9aneFHYdUj4LMVkTBBWzxGW
	5AITkk28CNUf52/+WtCL0O4rKiGO8Q3fRgd9/rxFKF0WhuXk456bdO3TeaLMF3f2o31ugE3f/8I
	0imwFeppJ6mlAObeDXVbRyE13zhMJmds6V7y2jl1TrMccANQItK5cnD0CaRjM/zdpaDmSKaLel7
	aXjnvyLEEUBfkrEpqrXEUZc6rLC79rKTlJW+k8SaUC6/NzkarDik5kK8YMBcXtfqDHx7kBWHs3t
	wWEL4POTZTFz1NoHShSjzqU9Qc1dtdcl8vCF3bkkkKoKs=
X-Received: by 2002:a17:906:b39e:b0:b98:3e7a:22c2 with SMTP id a640c23a62f3a-b9b5090a9admr504129566b.31.1774848633956;
        Sun, 29 Mar 2026 22:30:33 -0700 (PDT)
Received: from localhost ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b1a5fc9sm240417066b.36.2026.03.29.22.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 22:30:32 -0700 (PDT)
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
Subject: [PATCH v2 0/2] drm/amdgpu: fix locking issues in PASID IDR management
Date: Mon, 30 Mar 2026 10:30:23 +0500
Message-ID: <20260330053025.19203-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231001-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.989];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 62F5A3558DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
converted the global PASID allocator from IDA to IDR with a spinlock
for cyclic allocation.  This introduced two locking bugs:
 
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
 
Patch 1 fixes the sleeping-under-spinlock by using idr_preload() with
GFP_KERNEL before taking the lock, then GFP_NOWAIT for the actual
allocation.
 
Patch 2 converts all three spin_lock/spin_unlock call sites to
spin_lock_irqsave/spin_unlock_irqrestore.
 
Tested on ASUS ROG STRIX B650E-I / Ryzen 9 7950X / RX 7900 XTX with
CONFIG_PROVE_LOCKING=y.  The lockdep warning is no longer triggered
after applying both patches.

Mikhail Gavrilov (2):
  drm/amdgpu: fix sleeping allocation under spinlock in PASID IDR
  drm/amdgpu: use spin_lock_irqsave for PASID IDR lock

 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
2.53.0


