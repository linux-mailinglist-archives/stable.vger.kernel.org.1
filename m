Return-Path: <stable+bounces-128280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE8CA7B7D8
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 08:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91514189AC08
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 06:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E07417A31B;
	Fri,  4 Apr 2025 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hZYMBiVr"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4DF155316
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 06:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743748662; cv=none; b=iDRSAsyvfH2LqSnA2R6lqkTJjqcakfmemN++m7AnL2mLnHZSkNLMInew7RzO6pX+s/sZhf5sDYY6WSjLEmxCe0lJ/XL2sZhoZKIcXUcjYcxPV9Lqses/w/pt0ZFgzbOQPMmYmZCBi/Mq6uMAaVpBTa2JtxcjsSR2o5I8/RAFV2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743748662; c=relaxed/simple;
	bh=LA7uZ6q3Sc7Jg4Eh7U3qdrnVOUP1fZHPRdVwZ90iFbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FYLbxJPMlX+JScEmhLH9WIXnheaDp8beaco7vb/P5ESoxKoqUY/sD7YKCQ6WwcxXCJF9dGtpy0IW9zlhaGJA8aapKxivjtesb386mLYddxe3MKCfavH9m1F7ouGaYxUUVD1rRXEAcc/FSg6gHsUiWPowY20Z77sJ7axi81iglEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hZYMBiVr; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54991d85f99so2784296e87.1
        for <stable@vger.kernel.org>; Thu, 03 Apr 2025 23:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1743748658; x=1744353458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptSauccsQCiihyTIqD40ILfoZlJ+Jkp9zzyDCujSkmg=;
        b=hZYMBiVrrwl2CFEk8rfiWYylTtD/p2JsPLOGY6mf6Q3UzPXvkOPtWIdwE/At620zTq
         fRM23lm5+R+RywGZn77dPzhbJJtAth1z+ef6DNYVmwPMCoaSgWZ6C7TX2AXYwtWrLoJy
         KDfabVhNO0ER34CsCT68BadegARW8jPrfy3UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743748658; x=1744353458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptSauccsQCiihyTIqD40ILfoZlJ+Jkp9zzyDCujSkmg=;
        b=NxEcOfGZ3si6ti6bGBq7eTFYqPC4HT+jCPYxjgNC5c9aNRj/FchzZM/aVVAKBi/QvH
         eVZnCmH0wrudFhDbi8nBX+X6JguOBgnECxL23z3ErpXs/sg9ghr5iyerY3sn8rebL0IB
         exTl0hISqAYOPOpDHJEA177OoZbLA3yTrc8GFSOUtQN7eCp6xgcvL1Ngo2G5KQvtmzrx
         k3fvXwZrGV6BgN/ReCPPRm6JbjSAaPl9waWnIJqnpUZwQcDWw26SP0o3kRmyLtIoCb0G
         r/vnOYIqyRLfQrtOzEuS3eTnMDo7kQmtAKGt6n5ubiwFsvg/SPnMDIhG4b01zEaMQFos
         19ag==
X-Forwarded-Encrypted: i=1; AJvYcCUQAUpyS0XmoYcEkio3mC0VedA+XpVnmiDprJVr+j50lawQmn7aM/Qd9eWPok8Vn/fzvA84NBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Cs8eL9hqtiFKwpFOPqKalOBvKEPuh9UQM5LMjFwrSonl4qbs
	PHYyuUc2X3Ca+Xpl6Hlu38CZWAiW6xpXUYL7Uzv76hwQ2D1ovZCF+4XSc1BmgA==
X-Gm-Gg: ASbGncsUuQY0VhAauw2cBPY0JGjpqWMglwJEaM2qRUjYjt9J2ef6lejItOYvk77E6O4
	HU/TLGdPpawdKaNsYd4y5Us5/UA8p8X5FOC+hjS/RBuCY1T8eH9Sqq9tJc0ukewgSYBRELXZSS+
	7iBxQRImxnFTGLa8+mU+KLiLK3AP1SvB2/EKCGMmpejugs1Jo9R2w3+Fv6fe08UqBPBYlfeq0rK
	3il5X7c/RjXuSxAdkm3c+MGBW0BLDZzUFlXHr2iRYfF3YVfxJTJR6bFwo0N2buHbJAb6fP90i9C
	Tl5JmnKf4zsRv52Pags+0vt9TXEWapPTnzs1fLOBYcW2OEmMqb56cpT+sajqFhUQVwPJSt6k0wS
	FSk9kFGSztFSbqXzxGhEYCmVH
X-Google-Smtp-Source: AGHT+IFe0yc7cU3i1TuFDXhwgGxvVCCEnVSWjWSy8bq9xJ+B6v2LXYpgvddwkI0CUCf2TzgjhXvGGg==
X-Received: by 2002:a05:6512:1281:b0:545:a70:74c5 with SMTP id 2adb3069b0e04-54c225d560cmr612312e87.13.1743748658431;
        Thu, 03 Apr 2025 23:37:38 -0700 (PDT)
Received: from ribalda.c.googlers.com (216.148.88.34.bc.googleusercontent.com. [34.88.148.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e672444sm338275e87.251.2025.04.03.23.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 23:37:37 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 04 Apr 2025 06:37:34 +0000
Subject: [PATCH v5 1/4] media: uvcvideo: Do not mark valid metadata as
 invalid
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-uvc-meta-v5-1-f79974fc2d20@chromium.org>
References: <20250404-uvc-meta-v5-0-f79974fc2d20@chromium.org>
In-Reply-To: <20250404-uvc-meta-v5-0-f79974fc2d20@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

Currently, the driver performs a length check of the metadata buffer
before the actual metadata size is known and before the metadata is
decided to be copied. This results in valid metadata buffers being
incorrectly marked as invalid.

Move the length check to occur after the metadata size is determined and
is decided to be copied.

Cc: stable@vger.kernel.org
Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index e3567aeb0007c1f0a766f331e4e744359e95a863..b113297dac61f1b2eecd72c36ea61ef2c1e7d28a 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1433,12 +1433,6 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 	if (!meta_buf || length == 2)
 		return;
 
-	if (meta_buf->length - meta_buf->bytesused <
-	    length + sizeof(meta->ns) + sizeof(meta->sof)) {
-		meta_buf->error = 1;
-		return;
-	}
-
 	has_pts = mem[1] & UVC_STREAM_PTS;
 	has_scr = mem[1] & UVC_STREAM_SCR;
 
@@ -1459,6 +1453,12 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 				  !memcmp(scr, stream->clock.last_scr, 6)))
 		return;
 
+	if (meta_buf->length - meta_buf->bytesused <
+	    length + sizeof(meta->ns) + sizeof(meta->sof)) {
+		meta_buf->error = 1;
+		return;
+	}
+
 	meta = (struct uvc_meta_buf *)((u8 *)meta_buf->mem + meta_buf->bytesused);
 	local_irq_save(flags);
 	time = uvc_video_get_time();

-- 
2.49.0.504.g3bcea36a83-goog


