Return-Path: <stable+bounces-10810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAC782CCEB
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 15:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D98F1C21381
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 14:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE65D210FA;
	Sat, 13 Jan 2024 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=froggi.es header.i=@froggi.es header.b="jR/x3uWe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B1B21344
	for <stable@vger.kernel.org>; Sat, 13 Jan 2024 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=froggi.es
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3368b9bbeb4so6643930f8f.2
        for <stable@vger.kernel.org>; Sat, 13 Jan 2024 06:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=froggi.es; s=google; t=1705154535; x=1705759335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BkRH0xQaORaYFC0L9YHXubUjP3FyyFde2/Uyaek8ns=;
        b=jR/x3uWekzt8e2HoLNQ8YxWErw75j3a1l7UCgTrSZil1aLdaUqxSHGa0kZxGH/hYtv
         5jCgImfBicgMqpWa0Ik5b5bzuFIb0sz4UytydvSM6OyT2POCN9q3oVV2f1fYoZ6Wu/DM
         g6Cj6xcVp9ntEtkIgELGxCe680ZG5ikJ7aju8Lk55cTXWa7XrAcxxVxyMdQVEIwpBrn8
         hUpBp2ln6QnXfjppCDqI+yNLgca4H1CdlQS1reT2W3775cjVnvkQBTxGEeHx2TM9kt9F
         aLiDBrx2AFmHvy8yAd9r0XtHNtZTt+DwsLxfXDGlU97IZ92DiQ+aBksJANOAeGoigjZJ
         ymnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705154535; x=1705759335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BkRH0xQaORaYFC0L9YHXubUjP3FyyFde2/Uyaek8ns=;
        b=V9qNaGBqCADbpcJyvOyXT1kKjQOPMCPvzWyOzKfQUnHkpkSXKFgmhWx2OvcaRR0y4D
         QFPesw/2ukM/0N8kFg6mn9r70QJGGrg8wghrc195G3yjT4iKviq+LEEtAjmnPvcEe89W
         6vlEv++d1qZd6Oy7oCVpUoixYcG+q/ILtb05TUqIL8CCPfYCME1VR3I0GPXgPaTG5whu
         0rJZzfLlxh5yBpTanNzOWnEKG6e1/zsxkvMbPgOn5B2RQe1d1IsZIDgY8bAEm4ZBTEjH
         RDMtAjjPuv+RPhYPPLqVgvN7OmHmHUPs1IuvFJTn19rzu813o9yB6DRlWb0ayiV7snCd
         F0mQ==
X-Gm-Message-State: AOJu0YzpyKgANXe2OAkFoaLs9TzgWvd6sXsQNav28QLv3wARxPLSa9Ub
	XzhKIWS9TfvrfdKUkVoKpl2Trjmm6hgopw==
X-Google-Smtp-Source: AGHT+IFTbWqSwyuSRbOZuWE3Z/J7aa8f/fYQG3u9Ga+GpYjv+X4+9uWCTEMlzYUI3lWMMQL0oNxHzw==
X-Received: by 2002:a5d:4a8e:0:b0:337:427f:e993 with SMTP id o14-20020a5d4a8e000000b00337427fe993mr823916wrq.85.1705154535387;
        Sat, 13 Jan 2024 06:02:15 -0800 (PST)
Received: from localhost.localdomain (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
        by smtp.gmail.com with ESMTPSA id z17-20020a056000111100b003377cb92901sm6756540wrw.83.2024.01.13.06.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 06:02:15 -0800 (PST)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Cc: Joshua Ashton <joshua@froggi.es>,
	Friedrich Vock <friedrich.vock@gmx.de>,
	Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery path
Date: Sat, 13 Jan 2024 14:02:04 +0000
Message-ID: <20240113140206.2383133-2-joshua@froggi.es>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113140206.2383133-1-joshua@froggi.es>
References: <20240113140206.2383133-1-joshua@froggi.es>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We need to bump the karma of the drm_sched job in order for the context
that we just recovered to get correct feedback that it is guilty of
hanging.

Without this feedback, the application may keep pushing through the soft
recoveries, continually hanging the system with jobs that timeout.

There is an accompanying Mesa/RADV patch here
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27050
to properly handle device loss state when VRAM is not lost.

With these, I was able to run Counter-Strike 2 and launch an application
which can fault the GPU in a variety of ways, and still have Steam +
Counter-Strike 2 + Gamescope (compositor) stay up and continue
functioning on Steam Deck.

Signed-off-by: Joshua Ashton <joshua@froggi.es>

Cc: Friedrich Vock <friedrich.vock@gmx.de>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: Christian König <christian.koenig@amd.com>
Cc: André Almeida <andrealmeid@igalia.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 25209ce54552..e87cafb5b1c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -448,6 +448,8 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, struct amdgpu_job *job)
 		dma_fence_set_error(fence, -ENODATA);
 	spin_unlock_irqrestore(fence->lock, flags);
 
+	if (job->vm)
+		drm_sched_increase_karma(&job->base);
 	atomic_inc(&ring->adev->gpu_reset_counter);
 	while (!dma_fence_is_signaled(fence) &&
 	       ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
-- 
2.43.0


