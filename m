Return-Path: <stable+bounces-147931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA53AC656D
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 11:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20D01686BA
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 09:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A74D276057;
	Wed, 28 May 2025 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Bo7TijSy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E40A27602C
	for <stable@vger.kernel.org>; Wed, 28 May 2025 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423604; cv=none; b=TnHmAPZFgiSgblB6Sy+TK/2sVzmsfIra1l0ixwwXrgG1FUjCC8QHCMMT93JOmsxmLqqIZkAy+CrPX3vBmsxaQwX5jJXoDM3pwZVKYKUpS3QhaR+f6J6M+DGrjvdmnlAfLRHQbvYztjQS8Q1ntYC/WbTXd1wR8O3fs7a++KmoHwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423604; c=relaxed/simple;
	bh=V5Qex4S7ojgLO1R2QCmbE0ZYjxpVi2dhi8vrhyFurTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEYNPPij5nFowis0e0eWVaFEvVoo4XNDsu8bvN4rJLydzOsFT6YNVieC33vJxjT+FzAhrfAFkbI5OybS9EORTzMYrJiUU4SzHMLv9oPnGlsmlV/BnrPS/upP2q0VJpURNuphs/NxzivDuNjCO7W100REVzsv5V0ZYXaCgMzMQHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Bo7TijSy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-441d1ed82faso33286665e9.0
        for <stable@vger.kernel.org>; Wed, 28 May 2025 02:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1748423601; x=1749028401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+2yJB04g31aImN9kYR5m2tQHvzWGDu5CMhZSnchaeA=;
        b=Bo7TijSyuIWt7pP+frtRcL/BkeY4ueYI5uRSaFMIwzAdQbh8F1ZvtTI6sHZhpnegfZ
         a51xPbeQ7O6+oLMQRPonzL66obHmCHQgObJ1dmSZeC8u4Wt+RYYdw+6kMANh6SVQYgeW
         P4rHS9aq7mYExcOSaxIUbyjeUjDroa0KBiS+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748423601; x=1749028401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+2yJB04g31aImN9kYR5m2tQHvzWGDu5CMhZSnchaeA=;
        b=aOacne+O+GuZnG3/0Bv6o0c6sed/PJ3FTNsOOzIyfxnJLhcGzYAZx751qdXq/Mx5Ij
         6sgt04O/rVp1U/fVgdQ3evWJUN8dQCTju0vxSDiXmim4V+rw+V8fesC4X+V3Jp1wKrZ2
         AaAZNs+dLrzbE77yOtSMfIptOa2WAwtgtlsSfYgAPPd0r54Zr/dHEI6n5z7sEIOs9mba
         DdLUVLqTtHUD7kwc+yGaFhxueVydMPAg+Q/dvTHsP0LJpg/cJ4t/8Rzb3YxkPL4YT67g
         Y7PF6R2jX/tLJnn617heTIuraUp/h5U0ShuyUoUG524GXFdnrftaqAMmR7EzD8aqxIz2
         AO4g==
X-Forwarded-Encrypted: i=1; AJvYcCU6xnmgOniZh3Sh0TN34NOOKeEjcmfvMgW4asyU+S7CPTiW+tZ5myhrZInRI21MhPUPUg3WYvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ISJwiXuw2otDDnPSeroVQv5cpV9Zvcq40A7OUqebObcsKWdu
	4foXm26d/XVd5lLWcrpCH9mWGGPeaClA7v+Q8QYnHPCBUQYIE81GaVAbtF/IwhMMJNk=
X-Gm-Gg: ASbGncuIVC9Vk3YisRgIYCZtFXtTUrEYAbnYimWgRG/nwGP/Zdrgy9LU2URDsFwc7AT
	zghoa0+g5mMVNFDxgpBWVpMJ97nGHQm9wjpEMcLXQP2Gu9tt95trUIXVNeXVqrIIrbF3mQuNCJW
	AvI5ETdtOhBy8uHoep7o72KQn0N9xTgCUxJ/QzkKGG2QlURGwpLLXExdKWjtcEYruOC/T90fxu6
	5RVXLUdDqR9tSrdq0RmjF1bN8mO/mlY1bvH+rkIqGlCHOR7Nj9ahz50DG2xS2JVv1Qknhx1eG9k
	FSovpJ4wOABVaIQQf9YOpY9zFJEl7LhJlZX1oWV1rDQJQ2DvbjInTUpzuLnFEpI=
X-Google-Smtp-Source: AGHT+IF+J9gs9Akej4NXfbvlZZ1XUk4UkDRdivSjnyJiYRklFqBZKmKqHXdSYCOnnomp4+/c/cb2rg==
X-Received: by 2002:a05:600c:1553:b0:43c:f513:958a with SMTP id 5b1f17b1804b1-44c935ddb46mr149555705e9.13.1748423601141;
        Wed, 28 May 2025 02:13:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4500e1d85b5sm14811715e9.32.2025.05.28.02.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 02:13:20 -0700 (PDT)
From: Simona Vetter <simona.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: intel-xe@lists.freedesktop.org,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Rob Clark <robdclark@chromium.org>,
	Emil Velikov <emil.l.velikov@gmail.com>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	stable@vger.kernel.org,
	Simona Vetter <simona.vetter@intel.com>
Subject: [PATCH 2/8] drm/fdinfo: Switch to idr_for_each() in drm_show_memory_stats()
Date: Wed, 28 May 2025 11:13:00 +0200
Message-ID: <20250528091307.1894940-3-simona.vetter@ffwll.ch>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528091307.1894940-1-simona.vetter@ffwll.ch>
References: <20250528091307.1894940-1-simona.vetter@ffwll.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike idr_for_each_entry(), which terminates on the first NULL entry,
idr_for_each passes them through. This fixes potential issues with the
idr walk terminating prematurely due to transient NULL entries the
exist when creating and destroying a handle.

Note that transient NULL pointers in drm_file.object_idr have been a
thing since f6cd7daecff5 ("drm: Release driver references to handle
before making it available again"), this is a really old issue.

Aside from temporarily inconsistent fdinfo statistic there's no other
impact of this issue.

Fixes: 686b21b5f6ca ("drm: Add fdinfo memory stats")
Cc: Rob Clark <robdclark@chromium.org>
Cc: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: <stable@vger.kernel.org> # v6.5+
Signed-off-by: Simona Vetter <simona.vetter@intel.com>
Signed-off-by: Simona Vetter <simona.vetter@ffwll.ch>
---
 drivers/gpu/drm/drm_file.c | 95 ++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 246cf845e2c9..428a4eb85e94 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -892,6 +892,58 @@ void drm_print_memory_stats(struct drm_printer *p,
 }
 EXPORT_SYMBOL(drm_print_memory_stats);
 
+struct drm_bo_print_data {
+	struct drm_memory_stats status;
+	enum drm_gem_object_status supported_status;
+};
+
+static int
+drm_bo_memory_stats(int id, void *ptr, void *data)
+{
+	struct drm_bo_print_data *drm_data;
+	struct drm_gem_object *obj = ptr;
+	enum drm_gem_object_status s = 0;
+	size_t add_size;
+
+	if (!obj)
+		return 0;
+
+	add_size = (obj->funcs && obj->funcs->rss) ?
+		obj->funcs->rss(obj) : obj->size;
+
+	if (obj->funcs && obj->funcs->status) {
+		s = obj->funcs->status(obj);
+		drm_data->supported_status |= s;
+	}
+
+	if (drm_gem_object_is_shared_for_memory_stats(obj))
+		drm_data->status.shared += obj->size;
+	else
+		drm_data->status.private += obj->size;
+
+	if (s & DRM_GEM_OBJECT_RESIDENT) {
+		drm_data->status.resident += add_size;
+	} else {
+		/* If already purged or not yet backed by pages, don't
+		 * count it as purgeable:
+		 */
+		s &= ~DRM_GEM_OBJECT_PURGEABLE;
+	}
+
+	if (!dma_resv_test_signaled(obj->resv, dma_resv_usage_rw(true))) {
+		drm_data->status.active += add_size;
+		drm_data->supported_status |= DRM_GEM_OBJECT_ACTIVE;
+
+		/* If still active, don't count as purgeable: */
+		s &= ~DRM_GEM_OBJECT_PURGEABLE;
+	}
+
+	if (s & DRM_GEM_OBJECT_PURGEABLE)
+		drm_data->status.purgeable += add_size;
+
+	return 0;
+}
+
 /**
  * drm_show_memory_stats - Helper to collect and show standard fdinfo memory stats
  * @p: the printer to print output to
@@ -902,50 +954,13 @@ EXPORT_SYMBOL(drm_print_memory_stats);
  */
 void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
 {
-	struct drm_gem_object *obj;
-	struct drm_memory_stats status = {};
-	enum drm_gem_object_status supported_status = 0;
-	int id;
+	struct drm_bo_print_data data = {};
 
 	spin_lock(&file->table_lock);
-	idr_for_each_entry (&file->object_idr, obj, id) {
-		enum drm_gem_object_status s = 0;
-		size_t add_size = (obj->funcs && obj->funcs->rss) ?
-			obj->funcs->rss(obj) : obj->size;
-
-		if (obj->funcs && obj->funcs->status) {
-			s = obj->funcs->status(obj);
-			supported_status |= s;
-		}
-
-		if (drm_gem_object_is_shared_for_memory_stats(obj))
-			status.shared += obj->size;
-		else
-			status.private += obj->size;
-
-		if (s & DRM_GEM_OBJECT_RESIDENT) {
-			status.resident += add_size;
-		} else {
-			/* If already purged or not yet backed by pages, don't
-			 * count it as purgeable:
-			 */
-			s &= ~DRM_GEM_OBJECT_PURGEABLE;
-		}
-
-		if (!dma_resv_test_signaled(obj->resv, dma_resv_usage_rw(true))) {
-			status.active += add_size;
-			supported_status |= DRM_GEM_OBJECT_ACTIVE;
-
-			/* If still active, don't count as purgeable: */
-			s &= ~DRM_GEM_OBJECT_PURGEABLE;
-		}
-
-		if (s & DRM_GEM_OBJECT_PURGEABLE)
-			status.purgeable += add_size;
-	}
+	idr_for_each(&file->object_idr, &drm_bo_memory_stats, &data);
 	spin_unlock(&file->table_lock);
 
-	drm_print_memory_stats(p, &status, supported_status, "memory");
+	drm_print_memory_stats(p, &data.status, data.supported_status, "memory");
 }
 EXPORT_SYMBOL(drm_show_memory_stats);
 
-- 
2.49.0


