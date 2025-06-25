Return-Path: <stable+bounces-158562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B8FAE850E
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B707C189AF56
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 13:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A2B142E83;
	Wed, 25 Jun 2025 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SGm9wKyG"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F66262FDE
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859119; cv=none; b=L5pyww3TcoUx+ppZqDBbutBOMixVk5RtLq42GlzSQIbhOlHRVZwXf5kADuGxObmYoyaJh8U1eZF9KoyZKJArQz7fOEltntrOCA6uFgX37clqAjZ/HfJHO6m1a0GwZZ1yDQ+cZMD48syljgVHpjHN1KwLNaSfhxikPeQ2SXqIuoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859119; c=relaxed/simple;
	bh=YwAtWJWgZ7Ql7z2zNHIQWI8p88cOY7MzUmECgFqFwCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pb6nJi4CHR8FHx1qNhyPwJKw9FwfTW3FLe9XtKt5R96YExWJJ/UyheQw2cY6a7WGYzV9VVmnrpdHxW29skb0XiRxg/sMfXXk/MVvhcX6QsUit8HGckOjFwt9WrjF8JTWXnO5zwGRhxNo3s3prNVY5WLgoohybRXN8ivQNIZnhcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SGm9wKyG; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3105ef2a071so79769221fa.1
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 06:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750859116; x=1751463916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11UD5TtGC0Y3AyxHIx3jRz3F0KEAA/kz9PZhbWSIPsI=;
        b=SGm9wKyG6hrxeLvVOmlf4+EmYtkIhYajchEDx3ykqiwTmZ/TN1Y/jIBYfSs9RHyd5R
         tdCP/SwlSGBH5/yV4Zz9hfLOLmrQiryj5Y9CFyNonSR5DmoaTIIs4rMfBnZmsi4QTHXW
         Ijy5/+rNsNcgQfZIDsQNBJNNne3t0GSwlfcFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859116; x=1751463916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11UD5TtGC0Y3AyxHIx3jRz3F0KEAA/kz9PZhbWSIPsI=;
        b=UaWYuZIpNkuKbjzHcoiP6S24JIYyftqCfTZIvpl3N3+1//Z03bITzSsYEHvOI4ZxiS
         bn5AyvgPRoTwffzBLdEPog9zY5MhhX1r49vX0kyy51AbSkBRenqlIGevm3TyRp/nyxLJ
         3fWKdE+jyohUXohnsoi/A7bng0yDNaMBa3cZR65n9cRK+m6rzkS5lJpPsPs+fIaj2RED
         85M+VRgF3PMKvA9uJeYeCxQk3QuBRqKd4X7YPQRN2Dbv6ibBw/06qwMl1MlpDD5npW4u
         Bvzl9+NyU2OdN8J9F9KzbxB1KNrqDHupEA42JKj0xYW+Bdyg9CgGMRTJ8Y37dMzNpf3C
         C6tQ==
X-Gm-Message-State: AOJu0Yzajc6mOMZOh/n5dIIGvWtztSJq1MOLaBa0HlkW7KBr2EMlVEKz
	750DPCxRclyV6s9CaUsGM+LA7JPwBkQ+8qUZlqOSmov/LqP91vA+S/dWbEN09JV36II8XybnGy/
	XAxI=
X-Gm-Gg: ASbGnctyrV6fFVRK/Vs8/W41tXt7wi6wfM+pS6LzyWIqqlpn5WZh5ItYdR9Useqw9Jr
	EfxXdFVFuipYXpBdRjJI+IiC2SxJSUZ/e4pAbVS/b9+ShIGLyKRqc0vu9DY18xvQ7bOn+wmiSqI
	2VGF//UPADJyCEb3DtOraGHQBDR1YnFX4DbeSwIS/JBnZ3NRcJAnyw9rt+KnWKeM9jwu+bai6x0
	ngtKIjiyY3M/HHY+a5NVa4yJ9nc70iJiGR/71RpHkWUC7nfR1k3316GcXFPb9ZyYG0XYOcFUO8B
	LXALdEhKpSMoyvbFwXEDwYGZcDJsOePY5y53g2o5CEGrlOOd6q7u7nHOWUV2NAB2Eh0/Hfjkehc
	c1oHPtj2vC9EmzRn4SRkoNkscug5ssA3OaX956FYehseEQlY=
X-Google-Smtp-Source: AGHT+IHPEJHLA+z+gyESRc7KWaNxRzigC6utS8MtvyLQSioTRRWNZCv6nf+VQ1eE71y4kDS1PtgUVQ==
X-Received: by 2002:a05:6512:3d1e:b0:554:f72c:819d with SMTP id 2adb3069b0e04-554fde590d5mr1083680e87.43.1750859115719;
        Wed, 25 Jun 2025 06:45:15 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41c455csm2206389e87.186.2025.06.25.06.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:45:15 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.10.y 2/3] media: uvcvideo: Send control events for partial succeeds
Date: Wed, 25 Jun 2025 13:45:11 +0000
Message-ID: <20250625134512.666883-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625134512.666883-1-ribalda@chromium.org>
References: <2025062016-whole-vaporizer-3c88@gregkh>
 <20250625134512.666883-1-ribalda@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Today, when we are applying a change to entities A, B. If A succeeds and B
fails the events for A are not sent.

This change changes the code so the events for A are send right after
they happen.

Cc: stable@kernel.org
Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Message-ID: <20250224-uvc-data-backup-v2-2-de993ed9823b@chromium.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
(cherry picked from commit 5c791467aea6277430da5f089b9b6c2a9d8a4af7)
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index f10760ad2da2..a4b082df3b06 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1429,7 +1429,9 @@ static bool uvc_ctrl_xctrls_has_control(const struct v4l2_ext_control *xctrls,
 }
 
 static void uvc_ctrl_send_events(struct uvc_fh *handle,
-	const struct v4l2_ext_control *xctrls, unsigned int xctrls_count)
+				 struct uvc_entity *entity,
+				 const struct v4l2_ext_control *xctrls,
+				 unsigned int xctrls_count)
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
@@ -1440,6 +1442,9 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
 		u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 
 		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
+		if (ctrl->entity != entity)
+			continue;
+
 		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			/* Notification will be sent from an Interrupt event. */
 			continue;
@@ -1638,10 +1643,11 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 					     rollback);
 		if (ret < 0)
 			goto done;
+		else if (ret > 0 && !rollback)
+			uvc_ctrl_send_events(handle, entity, xctrls,
+					     xctrls_count);
 	}
 
-	if (!rollback)
-		uvc_ctrl_send_events(handle, xctrls, xctrls_count);
 	ret = 0;
 done:
 	mutex_unlock(&chain->ctrl_mutex);
-- 
2.50.0.727.gbf7dc18ff4-goog


