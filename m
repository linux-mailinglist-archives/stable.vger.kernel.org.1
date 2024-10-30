Return-Path: <stable+bounces-89296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52379B5BFF
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 07:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A49BB2231E
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 06:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45651D278D;
	Wed, 30 Oct 2024 06:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6pxZr3i"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCDC1D0E27;
	Wed, 30 Oct 2024 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270950; cv=none; b=suRgJtIXbLT9jCLs45wYz8ZEt2wYbdEEdvEV8LR0hvjcILnsjzTv0ez3p2x6d0/cFORdcpzCnUsiy6BBfVJmcm2QFgVmz6BjSOvSuGr3liAqeciu6xsRbkCSNnalpY+5WqpYSTMDWJCA7guEzwMO5+A9hdMRJkYYQH9JqNaVSsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270950; c=relaxed/simple;
	bh=iowdLuseAV8qpEg8ClqNrS17qOQ3G1zukdjjjQNZLEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YuChp2VbE+Sve46fpMpHYOlldXP+q2qS4MZe7gUn4t006PKzoicWjEmdG3Nasxi7a1ejiiCMsfpqf3v00FTA5OuDy6BiBmIo8KFXSHvNrcFsSUCjv1U1EiWcbHVw6F9QhiZo7W8GoiPwxVQNWc7gtppsAbbH+xNLpaoBmYwaGIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6pxZr3i; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2e2d1858cdfso4500590a91.1;
        Tue, 29 Oct 2024 23:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730270948; x=1730875748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g1QvxUmXWeKxvEL2k5Sf0XB0155cpa70LB5E4HbGTTc=;
        b=D6pxZr3iPpCus9aiqjMx7PsBsLhJv1yD0R3TC8scvQbSxRM4lolLxKt6ZyJaqwEef8
         /54rCN/IontKwptPDdcppb9v6Xqvrg9qdyvQypX645Uh+C2Y4b/XAxAmSKnsOOcEBent
         k/Eei7jTTOAtAsT1qMEbdCBUQ5Leko/GA2fn+Yhv94j+kZbCHhZrAEvdrE4/lmqcl5+S
         FZo6BKANlSp8No2hZNrFOQ3Rtu7jB/xWykt7XteJ96gGglwiqx/30AVDb54a0hHDQ2Fj
         TO+jfjpzDA150EuGLV0KLTkOjrFf+50gCSCBr0f0PZV9sdvGK52z2MgtuIgrUnAu+FrX
         2+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730270948; x=1730875748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1QvxUmXWeKxvEL2k5Sf0XB0155cpa70LB5E4HbGTTc=;
        b=mOjn0FMPMov3CWFE+YBTGiH7qxS/SFDkk8HTIwCiNyZZ/zlFBA3sTf033+R1bxTXuU
         RwqU0SShM5FI62n8wqOxzaiYxFNvbGIu1raXiSAYx0Oxsq4/SaNm5kA0cUqrrIOuBqx8
         iynwxn1+B9JB+ASRXiYIaqJBtVP4mhlT514pfXteMTXuja7xj5NsUWEb3v8GL/Ai05qY
         g18fYWSdWl80KqnQlZjvZ+YZ2gqZhXOKw110i/rzRrh9jgwLySNN9I7pOaLsPMfcCZXV
         mQtPDDPyi4Dr48q0lDURKZYBr1gNDpVo1ULF6dWnm0oJtsWBi2m1SuXymf62FKC/F3dL
         CxzA==
X-Forwarded-Encrypted: i=1; AJvYcCUVs1x+h/Qi7HNxgxMON3OTwa1tW6hMXIjyAW+BwQuYjh99PE5WIWmIhIkm0f2aJFLxYnBm1kFn@vger.kernel.org, AJvYcCUqRn2HVvZnGrWscZjLhFV17FzD60s/kTL4BDuodIVp22c3+DnhtMDMzzWFaT0G3DT5sdRUsUyzaRlZHR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLzo1EcdKrvq9gvLlEi8Vw0dIySIEnULv2Ybf4q43eR4evg6nh
	8YNZCK725NKy8dTW/eVlPIG1IGDCd2lpnuUrEi9IoZfEOfXs9zaG
X-Google-Smtp-Source: AGHT+IGeeX6tlLELS4LC5m1oeR6KbY5EW00IpuH+lUL9rB6Sj2dEw30McrgidrmkIVOU+SIh7wpGSA==
X-Received: by 2002:a17:90a:9312:b0:2e2:a8e0:85fa with SMTP id 98e67ed59e1d1-2e8f1057e59mr15767410a91.8.1730270948108;
        Tue, 29 Oct 2024 23:49:08 -0700 (PDT)
Received: from tom-QiTianM540-A739.. ([106.39.42.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa63967sm860530a91.32.2024.10.29.23.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 23:49:07 -0700 (PDT)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: mripard@kernel.org,
	dave.stevenson@raspberrypi.com,
	kernel-list@raspberrypi.com,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/vc4: Fix atomicity violation in vc4_crtc_send_vblank()
Date: Wed, 30 Oct 2024 14:48:52 +0800
Message-Id: <20241030064852.6154-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An atomicity violation occurs when the vc4_crtc_send_vblank function 
executes simultaneously with modifications to crtc->state->event. Consider 
a scenario where crtc->state->event is non-null, allowing it to pass the 
validity check. However, at the same time, crtc->state->event might be set 
to null. In this case, the validity check in vc4_crtc_send_vblank might act
on the old crtc->state->event (before locking), allowing invalid values to 
pass the validity check, which could lead to a null pointer dereference.

In the drm_device structure, it is mentioned: "@event_lock: Protects
@vblank_event_list and event delivery in general." I believe that the
validity check and the subsequent null assignment operation are part
of the event delivery process, and all of these should be protected by
the event_lock. If there is no lock protection before the validity
check, it is possible for a null crtc->state->event to be passed into
the drm_crtc_send_vblank_event() function, leading to a null pointer
dereference error.

We have observed its callers and found that they are from the
drm_crtc_helper_funcs driver interface. We believe that functions
within driver interfaces can be concurrent, potentially causing a data
race on crtc->state->event.

To address this issue, it is recommended to include the validity check of
crtc->state and crtc->state->event within the locking section of the
function. This modification ensures that the values of crtc->state->event
and crtc->state do not change during the validation process, maintaining
their valid conditions.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations.

Fixes: 68e4a69aec4d ("drm/vc4: crtc: Create vblank reporting function")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
V2: 
The description of the patch has been modified to make it clearer.
Thanks to Simona Vetter for suggesting this improvement.
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 8b5a7e5eb146..98885f519827 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -575,10 +575,12 @@ void vc4_crtc_send_vblank(struct drm_crtc *crtc)
 	struct drm_device *dev = crtc->dev;
 	unsigned long flags;
 
-	if (!crtc->state || !crtc->state->event)
+	spin_lock_irqsave(&dev->event_lock, flags);
+	if (!crtc->state || !crtc->state->event) {
+		spin_unlock_irqrestore(&dev->event_lock, flags);
 		return;
+	}
 
-	spin_lock_irqsave(&dev->event_lock, flags);
 	drm_crtc_send_vblank_event(crtc, crtc->state->event);
 	crtc->state->event = NULL;
 	spin_unlock_irqrestore(&dev->event_lock, flags);
-- 
2.34.1


