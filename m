Return-Path: <stable+bounces-158548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B36AE8364
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA4B1BC255C
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 12:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7A7261568;
	Wed, 25 Jun 2025 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GkNMWyYC"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE4025C6FE
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855943; cv=none; b=lAbe5Kl2uN5tUTPhsJtbdC+wTimVDVeHwG1iAyZLx9eQVQeE2/eBIWH2WAKR1jqxjlSfmOp4lAOwVSLx1BE6GK/I6TIE58K6wB8q0r9XpZEqT0OpU6rj1n2h040ZcgH3ZUbIl/dzHgmhDpR5bOj+khjp69mGe4bi1u7zJ7vLXG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855943; c=relaxed/simple;
	bh=+d+WOjSThRKkCj+GaX6XMDVytrRsH/OvqHIung7uN50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3Cl9AWzTqyeO4G21ZE7FB9kFla3l2Znt/hisLZ+uhQgwL8bs2p/FGoEm9nSQ1cNNdUCmkhkezH4Qx/azOgfNdsXt1iUyDzLpCM7LOzoALkPPg59sn9nhJbmw1h1RFffskW4egElvw64VkWSKB3xdoBsywXInr9tLpjwwRNdO/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GkNMWyYC; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32b5931037eso12189001fa.2
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 05:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750855939; x=1751460739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTDiq0mirxQ56WYFq9gJtUavFqgrGHK5vHZXmD5cjU0=;
        b=GkNMWyYCXsVIkm+otb6W3/pc+pXt4cKVam9CWL++IIdIJgNF4veeaLDB16+Vte5OZb
         dUawQ6/Yr6pEv9ce2MDcga4oPPAYOOwgTVzIqsH6oFwACrLM8IdXTFDA7I08KDNrybH3
         5xRdKCmLtA4veq8aHNQ0tXobjC5m25C8lZtp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855939; x=1751460739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTDiq0mirxQ56WYFq9gJtUavFqgrGHK5vHZXmD5cjU0=;
        b=Q/ppDIwoW/MAI3gfvkLpoqOOneWVwG+8J/hdDz8Rf1w9ZFTUImSMKt2nbwK9fOhUC5
         G0Vn1ysPRFSPPOx9X/ko6V+jKBg9UYqcuTYx32RcJKIbNdtStN9an7tOIQlwzF79Ln0x
         n7TutwYKkyEQZ0BZ4a3hEbDt2Eby0lZyI0opu7kDk4+onu99hr49JS9PxXbN8iu99jqP
         hEG8CYrY8rTz8tZACOh7RusuZyjTZkQIdLFimXpS2MHsVLHfGrYw8eLzTNy08Z99pjRf
         DbyXUP1TAqryndmfPOKhqb6Qn0qDnwekPu2w3pQHV/fFmpi8961ji+z+qhjzSSUqwU9U
         Eizw==
X-Gm-Message-State: AOJu0YwWkFzH4gdOH/vGoTsd7TBqYQE9QPaTYtVRgLOjBhWTHfT3qiGl
	2NDosneOVv8du/dSnkV6vZUQ48pLNVByr4LW0deuAzHf+gdXdxtuhKeBefG04yGEdWoCZbgOE0Z
	4Dxs=
X-Gm-Gg: ASbGncv3sMKCKSG7HO5yBNQkwfDQaYSQ8EQeAW5ghpib40Het4MKtr+gfsdDaOiJ6mj
	KP9GM57+3c42Iye4oc0MtA0zq+sdty+2dYVYmKT7wMr8xP1NDL7cdcIJ9fLuNPqlPUcalYOiq5a
	t0B8dugL8mJF8bfYtCB8LK5MwGizYyHwxJ6zgetTBub5TDnIE/iXcdTvUDJvhXY0s7TmOzX5y81
	oi40Je+gXUUj/j2X5YPQXlrHeDObtl7JdDgBzWmeAjzg7NO+ehxHpq7SV07JiVyWkE9ukfgpdwy
	p6QASl3AOZz4C0MWzUEjFxUIrjX97F5wJNrTwBwLzJBqWuHAsN9Y2S3MxqKVoCB6fZY6Vk5Oqp7
	CNnJSzzQKaXVatDWVs74V7xM+vRgMNjUW3Jf9Zm8PP+x2BCA=
X-Google-Smtp-Source: AGHT+IFRjCevVlfPcaM963k1QjPeA/4V/LhGzXw9kYcoj7i+8z9lf3l4rjNM3+6nxZrl8fjz1ybUvg==
X-Received: by 2002:a05:651c:11c3:b0:32b:3b5a:c4a2 with SMTP id 38308e7fff4ca-32cc641dca5mr7583651fa.6.1750855939079;
        Wed, 25 Jun 2025 05:52:19 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a3668sm19795981fa.57.2025.06.25.05.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:52:18 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.1.y 2/3] media: uvcvideo: Send control events for partial succeeds
Date: Wed, 25 Jun 2025 12:52:06 +0000
Message-ID: <20250625125207.566757-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625125207.566757-1-ribalda@chromium.org>
References: <2025062015-vocalist-panning-1ddc@gregkh>
 <20250625125207.566757-1-ribalda@chromium.org>
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
---
 drivers/media/usb/uvc/uvc_ctrl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 47e3e5e5c670..618e66784d0e 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1593,7 +1593,9 @@ static bool uvc_ctrl_xctrls_has_control(const struct v4l2_ext_control *xctrls,
 }
 
 static void uvc_ctrl_send_events(struct uvc_fh *handle,
-	const struct v4l2_ext_control *xctrls, unsigned int xctrls_count)
+				 struct uvc_entity *entity,
+				 const struct v4l2_ext_control *xctrls,
+				 unsigned int xctrls_count)
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
@@ -1604,6 +1606,9 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
 		u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 
 		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
+		if (ctrl->entity != entity)
+			continue;
+
 		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			/* Notification will be sent from an Interrupt event. */
 			continue;
@@ -1842,11 +1847,12 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 					uvc_ctrl_find_ctrl_idx(entity, ctrls,
 							       err_ctrl);
 			goto done;
+		} else if (ret > 0 && !rollback) {
+			uvc_ctrl_send_events(handle, entity,
+					     ctrls->controls, ctrls->count);
 		}
 	}
 
-	if (!rollback)
-		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
 	ret = 0;
 done:
 	mutex_unlock(&chain->ctrl_mutex);
-- 
2.50.0.727.gbf7dc18ff4-goog


