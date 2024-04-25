Return-Path: <stable+bounces-41456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 812BD8B2908
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 21:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954511C217F5
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 19:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD1D15250A;
	Thu, 25 Apr 2024 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Wx6BXBqY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E13638FB6
	for <stable@vger.kernel.org>; Thu, 25 Apr 2024 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714073274; cv=none; b=MBu+cnVT2/WwlQJzRpx8yzqBjy8bakh/DzcVvZMw2t9TZt4vsGciUMHB3blSsx2C2pRjsNP5gjcx8jTrYiu5/wPNMh7pPNM0xr4lBkUjBqHjLCa++13lAE3TRzB1e1wvQf0S+3O0ShawPMK1/LubE1aBaBhBOFMNoJgDJXjndOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714073274; c=relaxed/simple;
	bh=9zUGvtPYESFL93IQuZWZqwV2EmLmIRwNFPqf2JM2j3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g/fsBFj5z5Ro1TuG1X2d9HeyHwM7goMFVUebhHp8vKdMulcOblAkbtwVQOtBe92C+vpgnNcWi7SCXpeHIsL/CZrssKk05RqvBhbShHFV7VNHh7c+xP0QopFQHZ0vn0x1F5WnQTSLl0OqCS2OTObK9EOmB7+nOuT8O7lDp9qwLfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Wx6BXBqY; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7ec9c994c27so252741241.2
        for <stable@vger.kernel.org>; Thu, 25 Apr 2024 12:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714073271; x=1714678071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xRfxLogI9T4CmFpA/Ru6xajlEXu5NliZz/2sLYlz8bo=;
        b=Wx6BXBqYAXL03L5j1u7tuT6AFEwV26Is/tb8riQ7q/8YrnJqPe/jkcmgN80qeMfw2A
         XzMO0nRv+pCjXyXz3T7HPkA8AWcKylGG2o37hkKbiOASBCUyoOI06A1x3hpD1aSrQIVL
         zKFFdyo+kNnOnlYWCavh+9mC2Kp72tPl+QF6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714073271; x=1714678071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRfxLogI9T4CmFpA/Ru6xajlEXu5NliZz/2sLYlz8bo=;
        b=RNFdMvjD3lnB2tMxs/00SvYqkZSd35VWxf7RBfYdNACXpbU0yIDuW7nlBSEGomrXrK
         Z0768JPvDQc/AX/MVgLamGUSftnGDZS3NCWWIGmSPhGGpJ2WZO1xIkmB9tqHLMw2EuVD
         TNsN2v78NFsOlB2ju40xBk4pV44uK+NoLtUU2bF+v3A6XDFTU1O7NW87MAM1rpSnS1tO
         rN5q388mLkUdsCzbsFFGqGW9jlAOPoWF48qqzCcQdJmo6K1fJDLYlBLnpspDa2ce2IOu
         ILTSK39K6aD4AbejBMeuPM/cLdtVV7IlzAHlU3Z1zqjL9ugCNq1SfvQxbcXfjNyVOx+t
         +lqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmmkfOUaDGJ7fsreUx2ontDMJtV1jcAgXgdeYdp9pQEKd+k7RY8VnT41dfMNCAEOIcAcEmRHVxzb9lnq78x1SwgpfYOuJD
X-Gm-Message-State: AOJu0YzNksRfv5wrtHtJMXtyutegwdHd1lYaXHnq9mNkfOWQSqF7ai91
	mRRDj4dx4WogYAx10llho1rknQP6mFkASnXUEaCV3WMv16bM137dbpYVXqyRrg==
X-Google-Smtp-Source: AGHT+IGiWvcsbM8xXbwuiNnV+4S3QNaR+rkFtqZskbW40nOl8jDdg6Vv+cSiZ7zf6opnHiBk1LVHtA==
X-Received: by 2002:a67:fad2:0:b0:47c:1c1b:59be with SMTP id g18-20020a67fad2000000b0047c1c1b59bemr446547vsq.33.1714073271249;
        Thu, 25 Apr 2024 12:27:51 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id b4-20020a0cf044000000b0069b1e2f3074sm7258689qvl.98.2024.04.25.12.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 12:27:50 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	zdi-disclosures@trendmicro.com,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: Fix invalid reads in fence signaled events
Date: Thu, 25 Apr 2024 15:27:48 -0400
Message-Id: <20240425192748.1761522-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correctly set the length of the drm_event to the size of the structure
that's actually used.

The length of the drm_event was set to the parent structure instead of
to the drm_vmw_event_fence which is supposed to be read. drm_read
uses the length parameter to copy the event to the user space thus
resuling in oob reads.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: 8b7de6aa8468 ("vmwgfx: Rework fence event action")
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-23566
Cc: David Airlie <airlied@gmail.com>
CC: Daniel Vetter <daniel@ffwll.ch>
Cc: Zack Rusin <zack.rusin@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: <stable@vger.kernel.org> # v3.4+
---
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
index 2a0cda324703..5efc6a766f64 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
@@ -991,7 +991,7 @@ static int vmw_event_fence_action_create(struct drm_file *file_priv,
 	}
 
 	event->event.base.type = DRM_VMW_EVENT_FENCE_SIGNALED;
-	event->event.base.length = sizeof(*event);
+	event->event.base.length = sizeof(event->event);
 	event->event.user_data = user_data;
 
 	ret = drm_event_reserve_init(dev, file_priv, &event->base, &event->event.base);
-- 
2.40.1


