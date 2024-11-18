Return-Path: <stable+bounces-93873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19449D1B09
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 23:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254B22850B6
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 22:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA061E5730;
	Mon, 18 Nov 2024 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmPr89Xu"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FAA158DAC;
	Mon, 18 Nov 2024 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731968404; cv=none; b=CoEUt1zmi79MhcY14KsIYlZTNcfijcNe2HaHe1+wCJe5tsXc3uD369xyY9V7+eIK/twACgrvoK75wdPNhUXz/Tn1pxE5Df/6Qu710MfDJc5N/alyORQ320p8atOKY3oUwCb2PxlYhwYIzcRlCnxyB9dRReeqblayeOAND93BQrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731968404; c=relaxed/simple;
	bh=bsXiz7UT10hwFu7zTn8p15kzJpEBtSpS5WxrH6zvpP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tvhK5kbxpJX7W32fcsQk5S58uOR5nyCfwVgzJgj5PIGF2N8605c7csHSfbi6m0bnbhCeHAv0/XuIKBLBXK5HiFuh0AoVa/CKafJnlNVeNpsVt3hrNO0qkC2qa9ENu3KVDT6IPEC+DHLx1/4xgZIYAq00OOXvHa5ksLCdeosu6HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmPr89Xu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa20944ce8cso856259266b.0;
        Mon, 18 Nov 2024 14:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731968401; x=1732573201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jYtGEYKooR3k70+jqsHoRxERDWbVZz+C79qNhsZlccU=;
        b=WmPr89Xu+x4Kd9KWIOSlngY0DNUM8qNxh8KMuPmvWGl2AGbxBCFYm6hFZM+rKVUAru
         oGrnRju/znEHmNX5II4BgjqDTsYpWigk/nG3Yk2+v2gxVgx+L8rtArNWsXu0azlh9csP
         jvWR5TtxOs1lZtP/Vd2LG3yOw/G2Z3tySQj3VWxYMgYQWgjUORPgjgj58ESYVNKQuklU
         9MbsSYptxHOFkpqW97/yviBaj6wRcwtUyz3Nh3AnUH6eKVNSWVT8apiqqIz0LSbeMSJ6
         UhFlTMHm1RyYVK0UNqoNnArfv478q9MoiBt62ajeqPfrZEqcbqxN2Q8CkOpj7Hx0pWQp
         2evA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731968401; x=1732573201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYtGEYKooR3k70+jqsHoRxERDWbVZz+C79qNhsZlccU=;
        b=rdzG0kK8+w9VxIeYi6drJpAD6yugIh1KYyy3DWKeTDCCgTj2LimI2RuepiRqsonEGy
         vAoA0FX4ONR7zLoxwVvdDM2Lo8i3zropN2ydXI5lyuCywLvhENaINTnrg7pqTZPzl52K
         Y2lnlaAdapYvLGpB/wMmykQp5Q5uCaTzbRyINgFtDmgIUfS7iK0cE1ZYKR/UfJJMJETn
         B4RYCOZ/JOwtmMmpIo7Dn2hmVp/5u6CkiKPtgiZCilh3ITfSOqK4vmBY3OSrywjObkY8
         wq+UMXcoLpQoZvf7a9Ug1405bJmdHF8Kop1U6Hz8yBV1+BIDxdX3sv2e2kWzBbvkcGDQ
         mHNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNyqKaJMGpnIyXGpM7lKST42WvwsCv0LyJxJvN2Z0Wk5sD8S16/rcZp3t3wqayj3Lguwg7r+1P@vger.kernel.org, AJvYcCXKJcL4b+T4x4Ya9ColcAsJjGOln0qQSVy1vd7uPIvoOhFrwuCBfRV1kSjcGnEgO+I96DZhrY/Jw+A/kvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPlmiq7UvI/S4OhLUfhs1S4ioTgQL34Bo3Sw62+eLios+sYrYQ
	0BhArPwV/QvES/qHKh6IAVqJPgEndnTL+Byt+Y65T4lTyPcxmq0qdfY4eiRm
X-Google-Smtp-Source: AGHT+IHzyzhLjxv2Vl4C59o5aYbPpYinJKFAwD2oK6Fnp2vAcv4hP5NceZ2ycS6tUBogOMQIR7kSbg==
X-Received: by 2002:a17:907:1c04:b0:a9a:e0b8:5bac with SMTP id a640c23a62f3a-aa4c7ed4dfdmr63138766b.23.1731968400653;
        Mon, 18 Nov 2024 14:20:00 -0800 (PST)
Received: from localhost.localdomain (62-178-82-42.cable.dynamic.surfer.at. [62.178.82.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26c84sm584323966b.35.2024.11.18.14.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 14:19:59 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
To: Melissa Wen <mwen@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	"Juan A. Suarez Romero" <jasuarez@igalia.com>
Cc: kernel-dev@igalia.com,
	Christian Gmeiner <cgmeiner@igalia.com>,
	stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/v3d: Stop active perfmon if it is being destroyed
Date: Mon, 18 Nov 2024 23:19:47 +0100
Message-ID: <20241118221948.1758130-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Gmeiner <cgmeiner@igalia.com>

If the active performance monitor (v3d->active_perfmon) is being
destroyed, stop it first. Currently, the active perfmon is not
stopped during destruction, leaving the v3d->active_perfmon pointer
stale. This can lead to undefined behavior and instability.

This patch ensures that the active perfmon is stopped before being
destroyed, aligning with the behavior introduced in commit
7d1fd3638ee3 ("drm/v3d: Stop the active perfmon before being destroyed").

Cc: stable@vger.kernel.org # v5.15+
Fixes: 26a4dc29b74a ("drm/v3d: Expose performance counters to userspace")
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_perfmon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index 00cd081d7873..909288d43f2f 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -383,6 +383,7 @@ int v3d_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
 {
 	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
 	struct drm_v3d_perfmon_destroy *req = data;
+	struct v3d_dev *v3d = v3d_priv->v3d;
 	struct v3d_perfmon *perfmon;
 
 	mutex_lock(&v3d_priv->perfmon.lock);
@@ -392,6 +393,10 @@ int v3d_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
 	if (!perfmon)
 		return -EINVAL;
 
+	/* If the active perfmon is being destroyed, stop it first */
+	if (perfmon == v3d->active_perfmon)
+		v3d_perfmon_stop(v3d, perfmon, false);
+
 	v3d_perfmon_put(perfmon);
 
 	return 0;
-- 
2.47.0


