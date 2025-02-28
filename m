Return-Path: <stable+bounces-119903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85992A49291
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6454C3ADF79
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 07:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8641D5ACD;
	Fri, 28 Feb 2025 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JtgO1Zbd"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297411D6DDA
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729514; cv=none; b=t7g1724x1jAJH+8yq8SIHrUQaPJudX0ePq7/Q5B74Qzqq1DqSFdCJty1azPundUWkxhbLsuhjbuzKk14TXgWz4QhgD45H+h6HEZ9mS2VzQ1hwelhnJDjDoGgdFfelYGAAqzshuE59WjaSfeFCYZGW7eg6S0Qtu4zixkJ3mZZd+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729514; c=relaxed/simple;
	bh=fbPhhQ1qSBgq05CDY9kYGoNTj9OxJTW9q7KnRjyJgog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvmaTzAiFwMOxkx2cc6/kq/egEbsl8gJ+SvVO5lresZxmY+aCUv0liFeH07s6Py8+Rf6VgcNfByS86EY5/0MojbWOS/1yVJm0j1//d/JpYtOMLnC5vzD3eEuE64x5rFX97gQdDk/S0X+oSsbxrZY8kdXr2EJSvPdp3JORaARc5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JtgO1Zbd; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c0ba89dda9so188950485a.0
        for <stable@vger.kernel.org>; Thu, 27 Feb 2025 23:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740729511; x=1741334311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNK6FlQT5KzVD3lTHrvqPn/0Q2GJ23NqqpagsG9h0As=;
        b=JtgO1Zbd86TigUDVoIgwKuBUkUpNmqgel0aelhbCfYi78KjtJmJASPK+zfk2x50pCS
         lYVTko/lJx/x9EEBu/78r1HXFnyB2upTUYnyqMwDKrhHVdmpRgVUwrgOE65jnv3Y8VwG
         YngZjaKW7HBegR5CmhNaBiKvbVy1hv1zq6/PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740729511; x=1741334311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNK6FlQT5KzVD3lTHrvqPn/0Q2GJ23NqqpagsG9h0As=;
        b=lJ+wU3Z+NZoc1+wT1NkQZhURUp132vCHfFxKSMuB05zfdjmfaDt6UwYzcK4P9mnEJL
         2LGGiKiV+oPStW64Ik9RAKPzVTRpLDRKGxcY4SlXL9JPW1XErVh0gyRpn1VYCQ3mS5tc
         qSF6nFgTGkZD0v9BDK6dO+BmshlMgJy6L1BxU12s0LE5hqqlUO9wd6ZY82/34LElIler
         ZUxRZmF2QLymZtSwAY6GGVDJNZ/gsEpz/cYbYVERxKS5qq5nLpP9n0HoDi3FdNWH/3k7
         3a9+5EibJGXYxcHZ4cC5jxnBSZrj/2YZidjunVHZdB3kfv20V8cW0pYSc8pLereqDdfz
         CxlQ==
X-Gm-Message-State: AOJu0YwnK8LCUzwmXXg69UDj5y2z6fLw7lDkvaFwm53cV3F8PGgk1VUN
	pcv1nUIwCSwlgKva64+YX1EiNngArModbLnudDbDmG0XlBYlCYBOAv+NyXfRcuS/cvYSiixljh2
	4nA==
X-Gm-Gg: ASbGncvXncY+WLhNMC/7Vfa35D2y+n8Et6fMzpyk/U+tVLC6/AMHcQxqYFwuq+BBJy9
	mPSvOKgivL99Ns8qHVSecfDK7ketrUlnqHtHyP/l6vjnMRnYQ8oML4tekti1tE6Anm62nisQY4l
	OFKnszCaDGBsycbNy4HLrAF5iMmDrmjW3U4Qu2uM6ZtfbDu9IDkCboUaLRBaWembCyj9jG7+s3M
	KwG0h6Jha7TLj4XugDTXIpBdFwmHaFOzYQg8jB7D+RSTlVelMxugEgJJX9361G2Mq3hvlD0VKJc
	LP4Uc6FQeLZZW+bHGC7lzlF3+oct2Fq5WqmGQMPYvRz8JNSN74QiQYk7D8o72JuV3Vh7lYRf3Ki
	+Q1++yel5
X-Google-Smtp-Source: AGHT+IEXwB+thvMleh9SWtdhKcLElTUOCMc+Z9GMH14m4MsOWWouSQ6eFuehGAdSgqCLXtZAnTnwTQ==
X-Received: by 2002:a05:620a:1786:b0:7c0:791a:6faf with SMTP id af79cd13be357-7c39c677b0bmr401250285a.53.1740729510688;
        Thu, 27 Feb 2025 23:58:30 -0800 (PST)
Received: from denia.c.googlers.com.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fef4638sm218246485a.25.2025.02.27.23.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 23:58:29 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Tomasz Sikora <sikora.tomus@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.10.y] Revert "media: uvcvideo: Require entities to have a non-zero unique ID"
Date: Fri, 28 Feb 2025 07:58:25 +0000
Message-ID: <20250228075825.2638729-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <2025021007-decoy-pacifist-b3c9@gregkh>
References: <2025021007-decoy-pacifist-b3c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

This reverts commit 3dd075fe8ebbc6fcbf998f81a75b8c4b159a6195.

Tomasz has reported that his device, Generalplus Technology Inc. 808 Camera,
with ID 1b3f:2002, stopped being detected:

$ ls -l /dev/video*
zsh: no matches found: /dev/video*
[    7.230599] usb 3-2: Found multiple Units with ID 5

This particular device is non-compliant, having both the Output Terminal
and Processing Unit with ID 5. uvc_scan_fallback, though, is able to build
a chain. However, when media elements are added and uvc_mc_create_links
call uvc_entity_by_id, it will get the incorrect entity,
media_create_pad_link will WARN, and it will fail to register the entities.

In order to reinstate support for such devices in a timely fashion,
reverting the fix for these warnings is appropriate. A proper fix that
considers the existence of such non-compliant devices will be submitted in
a later development cycle.

Reported-by: Tomasz Sikora <sikora.tomus@gmail.com>
Fixes: 3dd075fe8ebb ("media: uvcvideo: Require entities to have a non-zero unique ID")
Cc: stable@vger.kernel.org
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Link: https://lore.kernel.org/r/20250114200045.1401644-1-cascardo@igalia.com
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
(cherry picked from commit 8004d635f27bbccaa5c083c50d4d5302a6ffa00e)
---
 drivers/media/usb/uvc/uvc_driver.c | 63 ++++++++++++------------------
 1 file changed, 24 insertions(+), 39 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 5770d901a5b8..f3f91635d67b 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1029,27 +1029,14 @@ static int uvc_parse_streaming(struct uvc_device *dev,
 	return ret;
 }
 
-static struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
-					       u16 id, unsigned int num_pads,
-					       unsigned int extra_size)
+static struct uvc_entity *uvc_alloc_entity(u16 type, u8 id,
+		unsigned int num_pads, unsigned int extra_size)
 {
 	struct uvc_entity *entity;
 	unsigned int num_inputs;
 	unsigned int size;
 	unsigned int i;
 
-	/* Per UVC 1.1+ spec 3.7.2, the ID should be non-zero. */
-	if (id == 0) {
-		dev_err(&dev->udev->dev, "Found Unit with invalid ID 0.\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	/* Per UVC 1.1+ spec 3.7.2, the ID is unique. */
-	if (uvc_entity_by_id(dev, id)) {
-		dev_err(&dev->udev->dev, "Found multiple Units with ID %u\n", id);
-		return ERR_PTR(-EINVAL);
-	}
-
 	extra_size = roundup(extra_size, sizeof(*entity->pads));
 	if (num_pads)
 		num_inputs = type & UVC_TERM_OUTPUT ? num_pads : num_pads - 1;
@@ -1059,7 +1046,7 @@ static struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
 	     + num_inputs;
 	entity = kzalloc(size, GFP_KERNEL);
 	if (entity == NULL)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	entity->id = id;
 	entity->type = type;
@@ -1130,10 +1117,10 @@ static int uvc_parse_vendor_control(struct uvc_device *dev,
 			break;
 		}
 
-		unit = uvc_alloc_new_entity(dev, UVC_VC_EXTENSION_UNIT,
-					    buffer[3], p + 1, 2 * n);
-		if (IS_ERR(unit))
-			return PTR_ERR(unit);
+		unit = uvc_alloc_entity(UVC_VC_EXTENSION_UNIT, buffer[3],
+					p + 1, 2*n);
+		if (unit == NULL)
+			return -ENOMEM;
 
 		memcpy(unit->extension.guidExtensionCode, &buffer[4], 16);
 		unit->extension.bNumControls = buffer[20];
@@ -1244,10 +1231,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return -EINVAL;
 		}
 
-		term = uvc_alloc_new_entity(dev, type | UVC_TERM_INPUT,
-					    buffer[3], 1, n + p);
-		if (IS_ERR(term))
-			return PTR_ERR(term);
+		term = uvc_alloc_entity(type | UVC_TERM_INPUT, buffer[3],
+					1, n + p);
+		if (term == NULL)
+			return -ENOMEM;
 
 		if (UVC_ENTITY_TYPE(term) == UVC_ITT_CAMERA) {
 			term->camera.bControlSize = n;
@@ -1303,10 +1290,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return 0;
 		}
 
-		term = uvc_alloc_new_entity(dev, type | UVC_TERM_OUTPUT,
-					    buffer[3], 1, 0);
-		if (IS_ERR(term))
-			return PTR_ERR(term);
+		term = uvc_alloc_entity(type | UVC_TERM_OUTPUT, buffer[3],
+					1, 0);
+		if (term == NULL)
+			return -ENOMEM;
 
 		memcpy(term->baSourceID, &buffer[7], 1);
 
@@ -1327,10 +1314,9 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return -EINVAL;
 		}
 
-		unit = uvc_alloc_new_entity(dev, buffer[2], buffer[3],
-					    p + 1, 0);
-		if (IS_ERR(unit))
-			return PTR_ERR(unit);
+		unit = uvc_alloc_entity(buffer[2], buffer[3], p + 1, 0);
+		if (unit == NULL)
+			return -ENOMEM;
 
 		memcpy(unit->baSourceID, &buffer[5], p);
 
@@ -1352,9 +1338,9 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return -EINVAL;
 		}
 
-		unit = uvc_alloc_new_entity(dev, buffer[2], buffer[3], 2, n);
-		if (IS_ERR(unit))
-			return PTR_ERR(unit);
+		unit = uvc_alloc_entity(buffer[2], buffer[3], 2, n);
+		if (unit == NULL)
+			return -ENOMEM;
 
 		memcpy(unit->baSourceID, &buffer[4], 1);
 		unit->processing.wMaxMultiplier =
@@ -1383,10 +1369,9 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return -EINVAL;
 		}
 
-		unit = uvc_alloc_new_entity(dev, buffer[2], buffer[3],
-					    p + 1, n);
-		if (IS_ERR(unit))
-			return PTR_ERR(unit);
+		unit = uvc_alloc_entity(buffer[2], buffer[3], p + 1, n);
+		if (unit == NULL)
+			return -ENOMEM;
 
 		memcpy(unit->extension.guidExtensionCode, &buffer[4], 16);
 		unit->extension.bNumControls = buffer[20];
-- 
2.48.1.711.g2feabab25a-goog


