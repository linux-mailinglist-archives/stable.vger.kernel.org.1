Return-Path: <stable+bounces-76051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 311A3977BF5
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 11:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1401F22DAA
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 09:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79991D6C62;
	Fri, 13 Sep 2024 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTQlb8J+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052CD1D67B6;
	Fri, 13 Sep 2024 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218664; cv=none; b=cBdWEUh2KfN7McBp5cx67iS4e1bSCISLptqDTafgfYr16BR4rwLUoXhacNKO62DcE8MBuvnO7rLbe3KW+0Wf33082ykDCsP8oK+zQkXU1HGpdCEqnYIqsuGu1azbTJWO0U2dOR1axTs6wQjr2NSp+dAa2+gvKq5xq7YU2mwAKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218664; c=relaxed/simple;
	bh=H1DEQUCDUzUOXlRaC4aA86YWZ/hLPsD9x3abWlVWMwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rMjkuROalgZHs6klopj8LsBwohrcNCsMQdvuhsEK9mivCIe+HO9CCGcLxV3U8vc9d0ryQXvIOI38ucZr7i8kp1tH+7fR+EZx4IsMebZ/AXAiuhTzkgECFbyMDd4k995kzw2fkXkxTm8w2GCVUAF6kQJGIB6XTiehZmOu1uF0inw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTQlb8J+; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-205909af9b5so6546305ad.3;
        Fri, 13 Sep 2024 02:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726218662; x=1726823462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hj2GddeQps/FE1fWEl/3u7sXcPoqY/f7cIdf4hfzm/8=;
        b=FTQlb8J+UcdDNFboXwAkDDk+nauVvt1YGoRwZhivuuqu/Np1RwstzbO2JwhZ6asuEa
         2oiYFSojLAslW6JyKjMKRgP36zLej+DBjB0z1XX4bsn8FNKKvjxIoT9ZmVPaAtbd2pvT
         WXCblRv87wMxTNaOydazTbYp1HmodktSG3x9mSpYXev5lmgjpf7hg3lc2NAqeSserhw5
         ysCk0Ug27qARd3dXN93+4Jm92Vbb0gUmx3EtS9/aT/t7QHjl5zClwdgiDpLrt/vjLlCL
         Z3/3z8/+jAJBugGOA15GLamyGpb1Ea44cgYW+aq8j3kTAunvRapdFg/LV4id1hoVQv6L
         f9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726218662; x=1726823462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hj2GddeQps/FE1fWEl/3u7sXcPoqY/f7cIdf4hfzm/8=;
        b=QQZQ70d5IWSbcdB3Bi5TYEp4TjVc0LVTqMew7FnFkQFSfXXgLO9kAUdJjMx2+y6b/f
         LA8sk0BKj19/noOPsmo1fuaWtkyw7TeedZMCaxtNWGYFC1m5kn3uSPK3C0yASg/Zz8fA
         zflMCQNEiOknXyqwg50bWphPTjs+51K4udu9NEDZpCTF18CQzPpwhEbJK25rKjmZmb6C
         gZd5y7Mhwwat8NpKk/wVZkDlTYM7UhjHBiPtu/2cj4yxue8SpI8JHh/nys6TbVRrVsf/
         qDYCDvlqGKedlt/kEHdrGlCx1pBYKja/ES8bhKAGniTfqr6dPvXBGU9VU85fyL3+3tpf
         JFYw==
X-Forwarded-Encrypted: i=1; AJvYcCWyx3F6g1Q4fy3j4x3M29pRkSbOTm0EM/Y0OYdIiMmAnRe0ERP2AjnxPWFprgEBjImc2/nm2ms5lVWFX2g=@vger.kernel.org, AJvYcCXUXlUoHqleHf3AF/qZb1TZ/afM35F6tTsCa+2YrFXL9vE0p6/SwyIwHWV7Kb5QYETavrE463xM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3VMMuwzsRvyySBHB8mNb8zAqoWEVPLD5YIKdlhZEkmtzqZMkf
	TV4F1qAy8A+ewwat+7y8XVyJnip9rq85JWTWx5YhCDG1i8Fj1Bmv
X-Google-Smtp-Source: AGHT+IHqr6Ea/+/C5VS1ndd+a6oK2hZU9vmvQDeDsKAJlBu82gDjVw6gDtp76gUirTBv0x8t4OfxJg==
X-Received: by 2002:a17:902:f60d:b0:205:76d0:563b with SMTP id d9443c01a7336-20781947b5fmr31093955ad.0.1726218661777;
        Fri, 13 Sep 2024 02:11:01 -0700 (PDT)
Received: from tom-QiTianM540-A739.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207810a4d62sm8606085ad.8.2024.09.13.02.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 02:11:01 -0700 (PDT)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: mripard@kernel.org,
	dave.stevenson@raspberrypi.com,
	kernel-list@raspberrypi.com,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/vc4: Fix atomicity violation in vc4_crtc_send_vblank()
Date: Fri, 13 Sep 2024 17:10:53 +0800
Message-Id: <20240913091053.14220-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Atomicity violation occurs when the vc4_crtc_send_vblank function is
executed simultaneously with modifications to crtc->state or
crtc->state->event. Consider a scenario where both crtc->state and
crtc->state->event are non-null. They can pass the validity check, but at
the same time, crtc->state or crtc->state->event could be set to null. In
this case, the validity check in vc4_crtc_send_vblank might act on the old
crtc->state and crtc->state->event (before locking), allowing invalid
values to pass the validity check, leading to null pointer dereference.

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


