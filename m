Return-Path: <stable+bounces-27110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E1687568B
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 20:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF2B281DA4
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 19:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD82135A68;
	Thu,  7 Mar 2024 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=froggi.es header.i=@froggi.es header.b="OLvwgCg4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7925312FB12
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838295; cv=none; b=bfL4oqP6do1FLtqdnZpD6dMkiv220KwQDwHkCSDZQc7H6og5lyc3hr4LAC9gz/4UG7kj8QPYNQ7H9++WK6DNYwYYYj/1jtxH0nMZMQwni2M66FWE8wp5Z51rsHNB+4pS4m8xCdTafYvcrP0XTRCeFbGAeYxm4EYVqPhcwR5KTVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838295; c=relaxed/simple;
	bh=uUlWR4dJAD0FavELniNe9gCSYUNwEc7vwtcYnAu8mtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TeUYqO0i796h1BjGw96+I7A9Cprlsudv0DqEjOu3JksVggRnhrjzcUDEY0t4VaBNePIIGHVlELUXoana6sR5P6B8XL7nnoyNAfs2sezXQDJEth7itc9q4CeVu2Ejuef9rBBv94U0TZJP8tItRXbXtsfGSr01yPnx3nk+gS+8008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es; spf=pass smtp.mailfrom=froggi.es; dkim=pass (2048-bit key) header.d=froggi.es header.i=@froggi.es header.b=OLvwgCg4; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=froggi.es
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33e17342ea7so11787f8f.2
        for <stable@vger.kernel.org>; Thu, 07 Mar 2024 11:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=froggi.es; s=google; t=1709838292; x=1710443092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LWXKpunu86jn1bIdyNB9+U6YjyEX5hm6WSiNR9W/xM=;
        b=OLvwgCg4Hha+ABBfNVhyxkIcnn2URWxQFqFGmhWYk25DepIT+5RleXR+4ys2HWiknY
         nI+xX6h0U07Nt1Qpkpkwzj2mwLRrUzfCX5Nc6UchadEuaFl8lh58YUsmmUm504RL/vwC
         Oe2JtlAI2UZZTWNETQdpM9iMhssmuqJXMrUsnRWhzsZopt6HiNr56uyEt59P1M0hbV87
         ilZBzq7pRNFjmw3Yhc8bjjJJZyS+/8pADi+YhaJvNwhc5OL+OU8smYShUkWZX8AVUEto
         pAfQJ0aj3La4wltk2cMsiXWko0zqlnTrk04I+zSyOs9JCiijBxjWTnJavy0QN6hYtxbC
         P3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709838292; x=1710443092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LWXKpunu86jn1bIdyNB9+U6YjyEX5hm6WSiNR9W/xM=;
        b=DzuzHHDM3cVoYIYYe7+zhzrJNhcwIh/IzvYT14JK1oBg+3WolLUvt6D7Is2miFSdDM
         eW/rbpmQJVtvfHbj9O4cDzkd9NOnqySAHpOtGonfkQkPH3YC4pg1tESslbUd5Nd40Miv
         vjKMf+WqofCXLkInwgPhLXV6IAw0MWxLO0J3yNiwGdcpHkl8Fb2WtWn8SP74x/XlwvH4
         6TI5Vi75upt9iqW0ZMXdwt3f6dzC9uu0kydpEMmRpV0R0FKYYLAfRxQXuLN939sAHJbN
         /YHe56lKWmlyZUYyQGjslE8l6aLNmvCH9rMHqJNRCDHs91jKG2ZUBY1Pdtj+cOfE0IzN
         2dnA==
X-Forwarded-Encrypted: i=1; AJvYcCXGg3feJ3qe17a46dYDa162mUD22kNMqYvT3gPUz9kQZGFecfYtbg7IsnZnJPjeB7vZVBdyGHM//xhYlWLl6VpPd8VXwq4J
X-Gm-Message-State: AOJu0YxBMOZF78zVFAhXyNs5pVYrN96De4mHNLuJo7Sr7RG/N0Um/yTV
	xgY1YdUtxc9dYOs7NOJMnZZHiIYEME7E4f/Si1i2wSXPx/j50GJijtp12rd5Vg8=
X-Google-Smtp-Source: AGHT+IH4QZsZoTqEIG+t+ka63qTM/aR1gSeTjsBayMBdHIYft3jhY5p/r3fqeu50sYkjBKwIxIaZlA==
X-Received: by 2002:a05:6000:180c:b0:33d:d96b:2615 with SMTP id m12-20020a056000180c00b0033dd96b2615mr12686235wrh.47.1709838291813;
        Thu, 07 Mar 2024 11:04:51 -0800 (PST)
Received: from localhost.localdomain (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d44d1000000b0033e5b28c97csm4105713wrr.37.2024.03.07.11.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:04:51 -0800 (PST)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Cc: Joshua Ashton <joshua@froggi.es>,
	Friedrich Vock <friedrich.vock@gmx.de>,
	Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] drm/amdgpu: Determine soft recovery deadline next to usage
Date: Thu,  7 Mar 2024 19:04:32 +0000
Message-ID: <20240307190447.33423-2-joshua@froggi.es>
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

Otherwise we are determining this timeout based on
a time before we go into some unrelated spinlock,
which is bad.

Signed-off-by: Joshua Ashton <joshua@froggi.es>

Cc: Friedrich Vock <friedrich.vock@gmx.de>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: Christian König <christian.koenig@amd.com>
Cc: André Almeida <andrealmeid@igalia.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 5505d646f43a..57c94901ed0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -439,8 +439,6 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 	if (unlikely(ring->adev->debug_disable_soft_recovery))
 		return false;
 
-	deadline = ktime_add_us(ktime_get(), 10000);
-
 	if (amdgpu_sriov_vf(ring->adev) || !ring->funcs->soft_recovery || !fence)
 		return false;
 
@@ -450,6 +448,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 	spin_unlock_irqrestore(fence->lock, flags);
 
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	deadline = ktime_add_us(ktime_get(), 10000);
 	while (!dma_fence_is_signaled(fence) &&
 	       ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
 		ring->funcs->soft_recovery(ring, vmid);
-- 
2.44.0


