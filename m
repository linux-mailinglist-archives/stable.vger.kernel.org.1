Return-Path: <stable+bounces-152884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E8DADD056
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADBB400ECE
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 14:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4312E2673;
	Tue, 17 Jun 2025 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lkqYUoYC"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AF92BEFE7
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171357; cv=none; b=LHrpPu0WXrYk3XimX1oVQddv4QGX+cXZmIeOc+JtAf2VXr58G2gSNIHhZFrBg5hn5D2oCgn4L3JRgQ/6kYEMGTVsgpxxeG8L5+sb+edGYhzronqtXBxQV0eqDnpE3KH1Jts2j+sg3IFtcvVaBGmsXwtsKtenCDNTi8N32vkPg4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171357; c=relaxed/simple;
	bh=aktg2opJq0+dY4a+/MNIzTnrkdP0Ocg7NaKfj2bHfhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g5J9QFDhrDCF8ylbNASRyWYT1Vvo7xE10bqqOyslrMA2MdOARH/6PCMdJM38FKuxxTAx8/QUJ4/OAIIXCjRvhA9P/hAC1jNCbL4sbptnj2XSGz9X+to+4MEKjrkO181RWZb+swIwmJUZZtlKxBmeo+I5tNsHZDbEc/6GAqreWnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lkqYUoYC; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5533a86a134so5123397e87.3
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750171353; x=1750776153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzIXP1ycrxCwpqJ0rvCcPdawBbbWpEqHaCxqb+yy90M=;
        b=lkqYUoYCEgGbtLQssHjEDMlNVUOkMZSLMhZcW54QsjOKP37nb3j3DILDimDNfCDFun
         VUCplA7lZ30DdaR39W+RC5ZpHqTDa32JKP1ca1bT6ktwDAPh5fDfhtYgv5E/kMoPvdkJ
         XfwN36BoSQCuHpYI/bxxrFYo3HzcdSA3XZ6Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171353; x=1750776153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzIXP1ycrxCwpqJ0rvCcPdawBbbWpEqHaCxqb+yy90M=;
        b=YPmJJ8LrXJjgqztFMRv1htjqIxWoKPuA7v5/0xywHuUP1GoS6hCWqIEJBeYFloyQEW
         cH9z54/wyF68mJT3c65UH5sQKHXouJLTcSfhTP1pFBPMbuvMin0Jx1DlcCHPve1Iy9Ko
         f4x+7Sqyi0DK9IhaEPs1Zj3mIlif9yIPB199myUWY1s3XVpnO/45u60J+OXmIcFY4bEs
         E08Fxkoosx9bh+l2ID8M5MRDhzLjT28kApmQAnwRggiGTi4fgXDY2NuQbDq8kx4RfIW7
         fFLG7w5iVfMHUXQCfKPTRwH+a+u4S9EkkH6IbxYwObWDkT6QeWzOzdLK5E0YG4f9+L3K
         9Gig==
X-Forwarded-Encrypted: i=1; AJvYcCUu8C+x8pu2fS0LiHy7VAv2IqViXQk26+Do04h/qssFVLFOYkUssLk44Dn2LnV0HJSA5uWxIYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrCX3kEauTDHHd2D7sZlv/mdr4BmtuERFgOc+ZZIVhzas91WPm
	vTMBEIqfIFzLroSx/r+gsYu9d0trGIDy92K0NwL5TEDbbcW8BJHd/AN9bsAiMU+3WA==
X-Gm-Gg: ASbGncsohllMbIBdF+vKbuRIkXs2n8oDxznHNWp6yH+4mflHtJQUtfHL8qf9kPxKnQT
	943/PFbSu5BmFNNxYEQ0vnzGlkkbxkWfXu4WxwyM6e8LxEc7ltq6k+M3dOc3eXjba57R2UAlBT8
	upAyO1rtxAeqoI57RW4CxBY6W6X/eGAbWSzTxQayQntBmsmhECkzhuOdArKTFU9j/CS+ApU6aU/
	o8XwqqBKwYICK0pyEaQjKpzPa+86VxSKV4YtxihYB217nIHPhFjnpPGoXejhzJ1EwQ3dvJ8AHJJ
	n8j+jWE9mMBFf9AwWfTtWrEYp1sAs4aVhGuAmii+YoG/t9GNCqi47ssPPOGaaawYdGEER6SaVFx
	R8EPgXUsA+ydkeMaBvYmpO3JnG0MgzDrEligFzN/Gag==
X-Google-Smtp-Source: AGHT+IGDdZamuUtegaqRzq6f6YTXv/XwbBpEBszibH6S83g9q8LYSRxOGewlvA2AvUElv4QXpy7yqQ==
X-Received: by 2002:a05:6512:159d:b0:553:3665:366d with SMTP id 2adb3069b0e04-553b6ee2b81mr3316711e87.21.1750171353230;
        Tue, 17 Jun 2025 07:42:33 -0700 (PDT)
Received: from ribalda.c.googlers.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ae234437sm1814992e87.53.2025.06.17.07.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:42:32 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 17 Jun 2025 14:42:22 +0000
Subject: [PATCH v7 1/5] media: uvcvideo: Do not mark valid metadata as
 invalid
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-uvc-meta-v7-1-9c50623e2286@chromium.org>
References: <20250617-uvc-meta-v7-0-9c50623e2286@chromium.org>
In-Reply-To: <20250617-uvc-meta-v7-0-9c50623e2286@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans de Goede <hansg@kernel.org>, Hans de Goede <hansg@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

Currently, the driver performs a length check of the metadata buffer
before the actual metadata size is known and before the metadata is
decided to be copied. This results in valid metadata buffers being
incorrectly marked as invalid.

Move the length check to occur after the metadata size is determined and
is decided to be copied.

Cc: stable@vger.kernel.org
Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 11769a1832d2ba9b3f9a50bcb10b0c4cdff71f09..2e377e7b9e81599aca19b800a171cc16a09c1e8a 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1442,12 +1442,6 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
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
 
@@ -1468,6 +1462,12 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
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
2.50.0.rc2.692.g299adb8693-goog


