Return-Path: <stable+bounces-27111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3156087568C
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 20:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6A91C20E76
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 19:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F22212FB12;
	Thu,  7 Mar 2024 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=froggi.es header.i=@froggi.es header.b="Yai6lh9r"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587DB1350CD
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838296; cv=none; b=fkIpWvEyYyyIsjaJH7dboYdWFOt30w3949jd3dRFCM6f45HLMGtAnGHmq+sYMUsYwftKRamrZsBbhFwfH8FJ3AmR8WttHym6Qmmn89Z8EYHKII73PerrDYSNsaDO7kVC2iAPTFZpqXnT6XgZ+QZFeaXpPuW7k61UOqIFJ1d0Y/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838296; c=relaxed/simple;
	bh=v1NBMKwQfpIt51QPZ/rPDug3WSZq260n/nLwzyjg1n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+ZVv97ZKFzS8LRmor8S/yW53CnFuvrFd6agCJc3LxxJKUbZzyVK5jrEpSST5cJY4nFU5obujvSvumM5YuQdZcqL1nBFGItvcjdyyEJF7wqwjAPujroaqbSRMSHhdGUciQFqmOyqnv57+sKNqANeShflf3g8yTpRIUO1qZ4773U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es; spf=pass smtp.mailfrom=froggi.es; dkim=pass (2048-bit key) header.d=froggi.es header.i=@froggi.es header.b=Yai6lh9r; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=froggi.es
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33e4c676f0aso748031f8f.3
        for <stable@vger.kernel.org>; Thu, 07 Mar 2024 11:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=froggi.es; s=google; t=1709838293; x=1710443093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJitx3GushnQPx39r/QJ9b/HXKTpuDcX2u8DXI7Aa3w=;
        b=Yai6lh9rbTmPYajeqtuEueDwlAZhFx63FRIkvJqvyOAXz/QdfFowQ6M5C/f514VNHT
         opz+RCxfDukok6LG/5WI/KsKNuAEuyxzaxAl9LbzP5nltrz2rWcXGxcBayT+KwoW3mAS
         gNtIGfbhk7wyaj1AmEKzyARmOseiC/PNzTocqIg2j2090K+f4tdNV2VpicG6z+BRR78W
         ilofjb1iaCb0R61FakA14tfCFJL4AFkMFAvxkXnZS7ZJ7rn3hcnUvd64y0ivJN5ocTnT
         gi4ig+VMmlR+d7mSnvFvNBby0ks042yrB8c9A+ZFNUiiDMTNwPdn7vdsrgGhfPBsm43U
         xgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709838293; x=1710443093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJitx3GushnQPx39r/QJ9b/HXKTpuDcX2u8DXI7Aa3w=;
        b=FAv21OPsc6TliGpPqHsvoeNVyIlCCkpSLyeRE/GjdLcEJX7JNpMCNOYs+7KbxqiZes
         UsGC7jK8wXHzGFjAuQXcbbbkef5EfumWLVKPCR8juukKhsmwGtP34fDY4g5mQFDQPYzs
         CVc5PctnF7Yq02qBQUYLc1OryYR6o1VHZ7rLnv6kskIZrUNxF+CBBGz9QPFp0ViYbgTh
         iF+8l29Duqcf+31LQlzgGdi/bX0Yl1x4Tb39DsR0epQ9fAHw0h4pt8PgymtnDZE3o2um
         oAwm2dKJHEsfOa6SOeGYumpREKXXeR3PmHw85YkmV7qKlKSnPTQU/jQYqtK6fMSRnsj4
         pgRw==
X-Forwarded-Encrypted: i=1; AJvYcCXxNte2b018TXg4LME+tQUI5I4c2D3neUCDqwLwWYPushd7vUvWRn5KkKPgSQjfg0eQZ/hrXTM6Fj8s/IxYEl+stPDhWomz
X-Gm-Message-State: AOJu0Yw5dOg/XtjYiDdltEkKpje7Oa9j2q9WnUkZIC5l5WVsS8ASqxki
	Kstc0YGUY2uVietGmJAnztEAqnCc7QlejJgAzJz8v0ps0eiAw63M6SUoBVcR30Y=
X-Google-Smtp-Source: AGHT+IF+DSKHr6PlK/tMrh1ta5X/S3H5YLAKelTF7nKs4v6C5XUKQU+eaCHTYwsq2j+/y4Lc7skvfQ==
X-Received: by 2002:adf:e54b:0:b0:33d:73de:c1a0 with SMTP id z11-20020adfe54b000000b0033d73dec1a0mr11916466wrm.18.1709838292633;
        Thu, 07 Mar 2024 11:04:52 -0800 (PST)
Received: from localhost.localdomain (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d44d1000000b0033e5b28c97csm4105713wrr.37.2024.03.07.11.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:04:52 -0800 (PST)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Cc: Joshua Ashton <joshua@froggi.es>,
	Friedrich Vock <friedrich.vock@gmx.de>,
	Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] drm/amdgpu: Increase soft recovery timeout to .5s
Date: Thu,  7 Mar 2024 19:04:33 +0000
Message-ID: <20240307190447.33423-3-joshua@froggi.es>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307190447.33423-1-joshua@froggi.es>
References: <20240307190447.33423-1-joshua@froggi.es>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Results in much more reliable soft recovery on
Steam Deck.

Signed-off-by: Joshua Ashton <joshua@froggi.es>

Cc: Friedrich Vock <friedrich.vock@gmx.de>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: Christian König <christian.koenig@amd.com>
Cc: André Almeida <andrealmeid@igalia.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 57c94901ed0a..be99db0e077e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -448,7 +448,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 	spin_unlock_irqrestore(fence->lock, flags);
 
 	atomic_inc(&ring->adev->gpu_reset_counter);
-	deadline = ktime_add_us(ktime_get(), 10000);
+	deadline = ktime_add_ms(ktime_get(), 500);
 	while (!dma_fence_is_signaled(fence) &&
 	       ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
 		ring->funcs->soft_recovery(ring, vmid);
-- 
2.44.0


