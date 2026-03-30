Return-Path: <stable+bounces-231002-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGuyBYgKymmL4gUAu9opvQ
	(envelope-from <stable+bounces-231002-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:30:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AB13558F9
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEB303006B1E
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 05:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2608E37F8A2;
	Mon, 30 Mar 2026 05:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOpTVQrA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BBD3806A3
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848644; cv=none; b=KbxQFKXOjXwJ0aiRBnvW1zbhN6j8RnlPX/w0JJkuZAGaIjYzGeJApVninVQitR/qofYB6HGDB8CYRe58SA+BhHG/1Ah8RC0rHA1483j9bPSRRTkGYdx8YdoPLLnEJq3QG13LX0C/SU0reZzbv5v937FaDe0e3eF+/LGMb7bXYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848644; c=relaxed/simple;
	bh=dp9y0LIhxasR0QYSeNO5w2A1c812RSBkpgALIhb9o+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bk+punh7gO7fZ3F2BnyRafuo1kT3y5nF1TnrdGq5p1lZL8ru9M7Tvn+01eL4Twijs8pO2Q/f/NMqSEZ8kyROuXhreZ7zK9aXCI8ZRvu8uJ5Bo27MJeFHuFV+4/OcG6A6nNMOA/iYje8b2mz8ERI6/9JpRUH1vLS0W4U5usFkxeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOpTVQrA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8f9568e074so592742266b.0
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 22:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774848642; x=1775453442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXnSrL1nik3JfElYjJrrOZj+38qywDMZ4t7LJjjm5fU=;
        b=ZOpTVQrAmLPdF6Y3/5C1DQiBHDi7Ze3zUs4vQ8GIpFl3mpYnjWhCNQT7UjjS2PL0CV
         xLVVKFuxJdkpCIpp9n3OQ3IsWdeM4+O17lHGUE+ruQk0yBye7/qrZS80sODwtLAkbbcE
         N/xK2INdgAKalmV6Vg+G5HM3zok8N2uIRMBFF4Q3nP3lkx1S8oQysA71ygj9YkM21sTk
         0Q0gHE7b4uJDxP77ZOKCo/l8lAqjI2bf0nO0RSen/HPGRKbIzzNIcDib93o3Nn1qmJ78
         As46mju2dw1MPMD0cSP/QBwdeyfxmDk+u/AaCkB5/SBXnISknFq1xvR8LBkht1jNJnGy
         MgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774848642; x=1775453442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kXnSrL1nik3JfElYjJrrOZj+38qywDMZ4t7LJjjm5fU=;
        b=eBsYFkgEWeXJEusY4qL2gMEiVAN/cakjsZhvfBe698/SJ+mYaypMQiqYnKPeZlkJEB
         f2kxbYGYKBXa6k1QO4SGG6neM/5j1VUi4imsp8gEKHU6MgC1sVWWJDKFQv+S+Qwk5jXG
         hPsY+QqlgacvQvL0LZou59RgitgikQdrEY+lb9xIQVdQoHDe3w/YN9kqqMenMVGu5OxC
         x6okrWgEjfOHA8bSky563wcVGDb0BNu3KuF0Bh3qg2r36jw1/vRsn6G8x3/0T5xc5Lrt
         4HIMG3bqMTN/4mngGLAw11vRxWF1b3QJe7O5jalnY12eiyFrEvLx+B3poAD9CXAEKJid
         oJ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsqjLzf63whGp3ctomLZcGL2EcPekRQcSOSFRC3rm7TIS9hG9RGC38WSwS7VK4BSvgLvXgjPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEtZRxF4CBuaUvAMbSYm7Xxx4xNgZ4RyTKdhPzt1WOyU5PS73l
	+okvCwXb4K7sW4xrKNg8UxB1bqm0t+pUyMlXLnngCv8gmekgfYbbNoeO
X-Gm-Gg: ATEYQzxZ1hpad65gnUJ+t1mk3ueXyW2+jsJz9uEdM11tPunsfyLow7FoSv2gsEi09uN
	AISUNW2cZntcvZsOtB3kGioH+lESDuEW6oa8hQY0kHLefQteOq8SfjxeYYthSN5DUU3+ffBw6Qf
	hE7x9LRt9QrcKctbtT6wydZ3CK4zPy2JALCzQnXa8syMURgLPjh1FtEpEAJJLYoY0eztl8Mv4QA
	3KQEmFXeqYp16j8EjlVdw/YpTHk4fmG+hpxsZYTbMK/M5rrcbXetaQHXbAtM9NAHWKmdtCcdDNE
	+3Q8u24S6O27U9MmCoqjtTnJv20DBMPZOMFsqTGhHYcf2pOG7yasya/jjRnMi7e4R6yPVr4qWt5
	jIv6tYliXOfyfgv7syJEBaoG1eSPBDuFgXQyvlslf+JkbGdsRI82NYUwq371nmOXfDXJq+1yW/r
	5y/OJftVDfSRIqrZtuUCB0qbDwSUdR+11I
X-Received: by 2002:a17:907:3d52:b0:b98:6984:661c with SMTP id a640c23a62f3a-b9b50301618mr717804066b.10.1774848641892;
        Sun, 29 Mar 2026 22:30:41 -0700 (PDT)
Received: from localhost ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b1a5fc9sm240417066b.36.2026.03.29.22.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 22:30:40 -0700 (PDT)
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
Subject: [PATCH v2 1/2] drm/amdgpu: fix sleeping allocation under spinlock in PASID IDR
Date: Mon, 30 Mar 2026 10:30:24 +0500
Message-ID: <20260330053025.19203-2-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330053025.19203-1-mikhail.v.gavrilov@gmail.com>
References: <20260330053025.19203-1-mikhail.v.gavrilov@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231002-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.990];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: B7AB13558F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 14b81abe7bdc ("drm/amdgpu: prevent immediate PASID reuse case")
switched from ida to idr_alloc_cyclic() protected by a spinlock, but
passes GFP_KERNEL to the allocator.  idr_alloc_cyclic() may need to
allocate radix-tree nodes, which with GFP_KERNEL can sleep — illegal
under a spinlock that disables preemption.  With CONFIG_PREEMPT or
lockdep enabled this triggers:

  BUG: sleeping function called from invalid context at
       ./include/linux/sched/mm.h:323
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 570
  ...
  #1: ffffffffc2cd24f8 (amdgpu_pasid_idr_lock){+.+.}-{3:3},
      at: amdgpu_pasid_alloc+0x24/0x210 [amdgpu]
  ...
  kmem_cache_alloc_noprof+0x41d/0x780
  radix_tree_node_alloc.constprop.0+0x56/0x3a0
  idr_get_free+0x330/0x830
  idr_alloc_u32+0x14a/0x2e0
  idr_alloc_cyclic+0xd3/0x1d0
  amdgpu_pasid_alloc+0x51/0x210 [amdgpu]

A mutex is not an option because amdgpu_pasid_free() is reachable from
dma-fence callbacks (amdgpu_pasid_free_cb) which may run in IRQ context.

Use idr_preload(GFP_KERNEL) before taking the spinlock to pre-allocate
radix-tree nodes, then pass GFP_NOWAIT inside the critical section so
the allocator draws from the preloaded pool and never sleeps.  This is
the standard kernel pattern for IDR allocation under a spinlock.

Fixes: 14b81abe7bdc ("drm/amdgpu: prevent immediate PASID reuse case")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index d88523568b62..515775eab2ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -67,10 +67,12 @@ int amdgpu_pasid_alloc(unsigned int bits)
 	if (bits == 0)
 		return -EINVAL;
 
+	idr_preload(GFP_KERNEL);
 	spin_lock(&amdgpu_pasid_idr_lock);
 	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
-				 1U << bits, GFP_KERNEL);
+				 1U << bits, GFP_NOWAIT);
 	spin_unlock(&amdgpu_pasid_idr_lock);
+	idr_preload_end();
 
 	if (pasid >= 0)
 		trace_amdgpu_pasid_allocated(pasid);
-- 
2.53.0


