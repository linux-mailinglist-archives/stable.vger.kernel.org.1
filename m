Return-Path: <stable+bounces-230817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDjwBIVKyGlVjgUAu9opvQ
	(envelope-from <stable+bounces-230817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 22:39:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEAF3500CF
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 22:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B2873007AD6
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 21:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30B9346AC2;
	Sat, 28 Mar 2026 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsHohfFC"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF82372B28
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774733949; cv=none; b=bqw7dh7Bu+zX+kElxWUMV62YQe6aojbYnevokxIt/rjETzxlScfb5r53PS9ljDGtJX+aEX4bGIi8KzYiSjrw4iKFpvGw59klhTVQQTrDOeHbjE5PRIpfZUAuVwf6y8ix+B50opfYp+Vzd7MWIAmbtHlYPyGcLDBlT8/XXNH9WlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774733949; c=relaxed/simple;
	bh=dp9y0LIhxasR0QYSeNO5w2A1c812RSBkpgALIhb9o+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EE27ioKoI+nbnFV8soObsfOqgd/fENQKtcYOgNmkF/3VlapU/pWM4yO+1LyWQ/hjwuFdKsiDbgmS2QIwnGseecFcqv1SOZS7vl5mKCDdYNhnyHf29P8IvTaysMLZPmooEc1i7al+UUllYjQmmw/S5eIVrezhLoxuL2tGtUPJ1Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rsHohfFC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66b1019bb55so3007324a12.1
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 14:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774733945; x=1775338745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kXnSrL1nik3JfElYjJrrOZj+38qywDMZ4t7LJjjm5fU=;
        b=rsHohfFCttC34o5YegC+wSoHVzJtDKP3DfZIp3VEgtQxDtysq8OJ542r+micPrxcjv
         8Mq+AFRrKPhkXw01G+rWjAZp6l/lzMDMsYryQebv5Uq/aBKyULWbqHagwDeLbQc4/GHR
         NiaCviOPVj+qyF0dSM6nqhJDRej/wb7vYY63mz9xldcQ7XOgkpCcZb7wWvCbjEt9x1L0
         hMDSzNEigsja6X841QuHlcNo8zdewFRhN73Jib+hmRqEdSXJAVS5m5qHMRWZnoVxzV87
         ovZfEJz1lHekeYcoonlfd5RI5kZSis3olDXqiUdUOiw0OQUsOcL/JXbkeeuZUB8Q48vX
         G80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774733945; x=1775338745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXnSrL1nik3JfElYjJrrOZj+38qywDMZ4t7LJjjm5fU=;
        b=NYWaMjbv6/YHEaOhdvVYNSsbOZdLJawc/DdBM+N0jkbUnWjKf7aE+zp9qJs3kw4ONX
         OFgcPuAXpeejYOQquODCeHB1+MIcxQDN0sPxPRuMfhPp1FrKroXW8XaUnw+dBvt2LVSW
         l2aBFEWnmNVlNEwCA/dFfVdefwxPOicwI47rkh6z0pACfhLKFVKhCf2+wU3ZfaDoam8x
         jBamvWBYqh5YbecK5r6oMvj3mZgTP354+xUxbQrI5fUxRIIS2Pwe2a0kF+n9+Sb5WAKa
         G1ku1L0urjr7B7U2PD3jS0CezbbHdzddvAYJ1f4+v/hqvWxB+6xOwrvRkrJdrDhcePjs
         xWXA==
X-Forwarded-Encrypted: i=1; AJvYcCUz/HeQ0RfMZQ5gUsREdDN3YWTjZE07x8HNDT3omKTyLjpZCl6QQpA1x5//9A9yd84JVC1Sz5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGAeSPy1xNuovW0QDN2jS/Ly/19xeVlV/2qXnN9sfba5j0tKPF
	hfhL8ej/48HB+PUJMmgtaEZVYQPiMfucgJ0RKg42piGBDHOQrOYH3DTu
X-Gm-Gg: ATEYQzzRObWaWmRX37JhsSYs+W7ubdlK8ueWYRfvQ0ZxPmNPjqR+dEU/+h6wIAqRccx
	V9QNbqGvbW5g8TKNrmJg77ayvSdmclRqrBKIXOY70RqrlbihJANC2C0qUZTzk9+e2XTemz/W9vv
	U1CfAIOTGxkkPbqc7w8UdH+Ne+pdPNTQAw05Pgv2WxACs1Q7sVv6q09kiUprHuFydsucwzOeWWA
	skYK97Bty02YBCgluJk9o1gfv/nC+mKlzSMqdK/8jQy9IuUqPfAyRr21W++ZFr3C87+s3KCFXKe
	Op8+mUqbk1wXOUiXKHVPmf43x+5h/rr5iIikQqNZBIcrE41m/wNB7+DqEge5fGvICQxRi6RdamV
	JDx5GRh3QJVWyOBTn/zn2c6DqGZnmQwX+GyvJJIr/OWs9i15Bs///rXW4/a3iEOr09IjqHKw6bn
	jbOOHEr7USFrBZy5d0lM8I+r9RHNMgbz4k
X-Received: by 2002:a05:6402:4618:b0:665:e9f:9021 with SMTP id 4fb4d7f45d1cf-66b2855f8d5mr3612343a12.9.1774733945154;
        Sat, 28 Mar 2026 14:39:05 -0700 (PDT)
Received: from localhost ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66b75f84708sm909093a12.21.2026.03.28.14.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 14:39:04 -0700 (PDT)
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
Subject: [PATCH] drm/amdgpu: fix sleeping allocation under spinlock in PASID IDR
Date: Sun, 29 Mar 2026 02:39:00 +0500
Message-ID: <20260328213900.19255-1-mikhail.v.gavrilov@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-230817-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CEAF3500CF
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


