Return-Path: <stable+bounces-119466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2EFA43A0F
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 10:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E034A1752E8
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 09:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F10B2676E9;
	Tue, 25 Feb 2025 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQLnok9r"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD712676EA;
	Tue, 25 Feb 2025 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476520; cv=none; b=gWivCpwEJX/Al3yVdvmqzl6+iJbWum+FI8JhF7EDYCoCZg3ZBZ1ErlOijM7xsj/lM/HbeQyg2BY+CzP+/S74ZURwZkoxN+yG7Jfe7OupMAaio487n/oF/r7j35xqhsJ6IuwFtiZcXbOtuu1vFzgRXLYv20PJmt0M5T7vuOFmXmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476520; c=relaxed/simple;
	bh=1rX3Tw5OEZ9iVi69R/Vz5QGBAg03OkLYqvziaLFw+lE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GI8Jpvtv13McvD638J1nApl7MhiooOJ2fVgemgWuxTqI3yGJ9Ro2yDYGLY2jgqgASrv3xZ+B2mLaOXMnLi6s/EDhwHEiOcRRsSt1GE/qZBXY1zueBkgThljvmjkel/Juo5+8+KiKfln3CCIMGbvIOJQf6OnquuYWDD9bnN4dGeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQLnok9r; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2217875d103so12386975ad.3;
        Tue, 25 Feb 2025 01:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740476518; x=1741081318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xl+Y1l5voHQwtJP92LWp/7002pAoHO14kkZNlQkkxFE=;
        b=JQLnok9rnpqSsFLMPMTHuMsGj5JwiFRVYM4GIMP/CKER6QfjdZIPmr0NcXYSIbeYzV
         CQwqd0aNk9XfL0V+HzLN3R1gMBKcJ6NGzBsaokACMLnrqYeC95ekBYoBnY7JQyAbA5sK
         e6zcS+3b+10wvfpAjgwwkAxxKjjwOsbTp8sBKYlfMDMab0Ax27YGamTMzO1PSzpdXXnY
         60ziJIy0t5tWSU2u0HvQgnqWmBGyZJI1yqiat6oZeXu2F/BtKPRYgfUJ2svGjeWP0yw0
         Szce6O8heqJaZVEt/tcODL7iVHQ/0QIl3tpvYbAo9PnTvMngQt28Rp0WmROugcPm/8GN
         lBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476518; x=1741081318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xl+Y1l5voHQwtJP92LWp/7002pAoHO14kkZNlQkkxFE=;
        b=S4O73sBzMTOFULiPeqKH9nRmupHG20cWPajPGvUW3g71k7ai3jZcW+yFXyVjQBUZzi
         rYhp8JQTCjAHiYIksAFq98RQVUIBd4comVFyn0u0ZtRrGvCn3dJnPU6oLZAVuAXLmrgr
         Kn2IftE8MjKtAegWsKkB1ESEpGeSmbL7l/2Uchb34f+uxW26/CbBBAIMztx3bklnko7w
         CzRXdWvgJwTo+w170B5xW5TaBILcY/fjpxwMTUz3DP6O9WlnXY0u7NESAxESkAWcxAzn
         Fpv2758Hp9/z72OgKCjO8/IMmTVqkkbrZhqRwyZhF1txM9Crau8TnW/VGWLWLFPcStL3
         ruCA==
X-Forwarded-Encrypted: i=1; AJvYcCW4flXJIa6enKzyJYIIfPdqtQgObLz0h8hXcRzuussVuvQZDhYbovgq06/tJQZKijxR/fO/gu8ZujlljiM=@vger.kernel.org, AJvYcCWroyHgZ630GE09Tijqvb32Hq9qoK5eL5/WqCvUYMe1DkQPCW2yxvrRK0baPG57UoXbSFFm/b1w@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj3l0D62vunp1sng3xEQN/NJtDaLn/bwC06h1NVTBsTLnabRYp
	m7Kld2+nqiw8DVhoqCotwpCKrWnz5IjS1PQKiL5plV32EP5WdHb1
X-Gm-Gg: ASbGncsX9g/gVNwN3tGK6Gc/VCr23XzGHGNhqDBjGTR+k9UaPpzjxLV5FwHLYMI8hlW
	tn9hcJ+sgo6gP0pDv8/+ZQpxar/x+j5NQdsyI5ryRGnTqMs+X8ekNJLJ2M+AEwC5h2+iO1su6xA
	bN+rAUp0dZdDGbZqOJlyFrIMTZmPBalq3ic+GWY6+e2kIGTtdQK+6Bxw0AcYNyjkeHPUuyE26J2
	/qs6r+nsZEDXxwkHwooJos2SaUhlf+e3i833cFOxeHdqPQisM9MNS+KzulTJCoTcSxLQkkyAQRg
	1JA9topc93E5LfXLCmqscXFAVGG+tVcahbbvREr6Sg==
X-Google-Smtp-Source: AGHT+IGtCeMHEORvZ0nZqeqoPBF/JydV8dIFt56d4Ce/z/GzK8FrT+PFRSwZV3bo/lzU5Od9Izv+Zw==
X-Received: by 2002:a17:902:dace:b0:221:7854:7618 with SMTP id d9443c01a7336-2219ff78bafmr97636405ad.8.1740476517699;
        Tue, 25 Feb 2025 01:41:57 -0800 (PST)
Received: from localhost.localdomain ([182.148.13.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0b0d61sm9986085ad.240.2025.02.25.01.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:41:57 -0800 (PST)
From: Qianyi Liu <liuqianyi125@gmail.com>
To: matthew.brost@intel.com,
	airlied@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	dakr@kernel.org,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	phasta@kernel.org,
	tzimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	liuqianyi125@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH V2] drm/sched: fix fence reference count leak
Date: Tue, 25 Feb 2025 17:41:25 +0800
Message-Id: <20250225094125.224580-1-liuqianyi125@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: qianyi liu <liuqianyi125@gmail.com>

We leaked last_scheduled fences when the entity was being killed and the
fence callback add fails.

To fix this, we should decrement the reference count of prev when
dma_fence_add_callback() fails, ensuring proper balance.

v2:
 * Make commit message more clearly. (Philipp and Matt)
 * Add "Fixes: " tag and put the stable kernel on Cc. (Philipp)
 * Correct subject line from "drm/scheduler" to "drm/sched". (Philipp)

Cc: stable@vger.kernel.org
Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and fini")

Signed-off-by: qianyi liu <liuqianyi125@gmail.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 69bcf0e99d57..1c0c14bcf726 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -259,9 +259,12 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
 		struct drm_sched_fence *s_fence = job->s_fence;
 
 		dma_fence_get(&s_fence->finished);
-		if (!prev || dma_fence_add_callback(prev, &job->finish_cb,
-					   drm_sched_entity_kill_jobs_cb))
+		if (!prev ||
+		    dma_fence_add_callback(prev, &job->finish_cb,
+					   drm_sched_entity_kill_jobs_cb)) {
+			dma_fence_put(prev);
 			drm_sched_entity_kill_jobs_cb(NULL, &job->finish_cb);
+		}
 
 		prev = &s_fence->finished;
 	}
-- 
2.25.1


