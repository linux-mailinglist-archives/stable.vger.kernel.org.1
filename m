Return-Path: <stable+bounces-121267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B38A54F93
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 16:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988EE16A31F
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 15:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A4821019C;
	Thu,  6 Mar 2025 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iRYskNbc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D16117BEBF
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276268; cv=none; b=fH9IUW02nUxUASNhtiSAS3aMXsigJdt61eP53UABJMkUrj3E7rvPapaTZageHsvJpWLDyzqzCXaJ/m9ENTbW2kO2i6i8zJXsoBpVVsa0hgwAt83k/jQBU/+Am4vzLr1HOAMT1PPNk7fh1k8QiXyCRgjyTYFHApE8eODmvMLe/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276268; c=relaxed/simple;
	bh=+tMzP8/U4KAu2Jedl6Pv/UjdmDc9hwAIH6ZLozGbNFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=agI55xCfob9N6Ki6BJPbrnLbOfetvr2G0pxDRtzudMS8jPYdDmD744ZrM4iN8sOENa+3R14zR5kjfRCdPxvwjZm7AI2szLe0tFs+QK3a0E8NLnks+tIgdfxLO67OVudZHR9QcTBUmLx/IH/sHtjSl6DvU/J4WSkREvIncu0k6fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iRYskNbc; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7be6fdeee35so153278685a.1
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 07:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741276265; x=1741881065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tebyllIN/Zbv6qJSF1gFn0ztQoDPanzaNONkrFerC40=;
        b=iRYskNbcRb5aI0TOVuOq6zWSGMvzSGnD0QaL2TWHuKIAJL+xz6N//zG+mqimioU/TG
         hPl5WyWBZ4/aMjPsQuEVqBufF2zfy9BX6qrp8INHNgY1Ozkpwq1QipfaEcs3dnQi+4RZ
         V/chydMSFMXjadsCMi0sJ+FY3tJkG4qA9rU8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741276265; x=1741881065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tebyllIN/Zbv6qJSF1gFn0ztQoDPanzaNONkrFerC40=;
        b=SV70oRTzMvlLZZCRkb1Oj+JBGiWE0XVnL5kfLnk8SFV1JmPihJEZL0j/dubad92Zil
         rLyvjUIQGuI+yCLiE7cxsvNJo/Pg8EP90V9yBnt4Awtr31bqdZ/7JNbt6T19sIzBSENH
         2auwUKvX9dQrujHFlIF2dvv3tpHfiHAWNXzHu0Itza5TVnR3mgC5zgSbb8t45ou0CS5O
         vPxvl1Krs3Ewt+MN+9NoogQDCSOdkoUQatQN8GddO+85DfCKnBPL8UkRbOx5UhjwpXbD
         5x2LJu4fb6IwTHaCsqXk5liUn21Z69hIMqRdqkvIDEbv5Fo/wYOK0RDunTXdp64ilBmo
         i2sA==
X-Forwarded-Encrypted: i=1; AJvYcCVx8vVZcuyFSz8XKHi6x2R21ZxlvJ/y6LgHMMnAaGrXCZmMb36PhKtkpw0a66DgFgX9xWnoCoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG+V3FSzSQ76bLCF4eEYhK2NiStnFTpufvqLmKzYsr5zkZrB2a
	HRqsbFKP0kaV9zgp1qbCdA2bmdeU3ld+jpQdTBuI9PrIZkHcqvNbEil6CA++uQ==
X-Gm-Gg: ASbGncvpJ42OJ5K1z+2J5HPcqA6Y2CdKurJQPsY2suu4H6RTBXnkvqd3fH4P2WNeM3p
	ykBKlYFaUn5zUllhrbHkdO16GU8eW1aOevHS4diymH2sYH5AAJZfmQwfR9lcQID8Noc62tNuA41
	y4J8sMMUgvcXtjEbGEHrBveWTPawYzIdl7b583Cg41TRCP49NZV0VMX82GrAxCl8w2YDGQDdSTQ
	qtdbq+B/PubmHBbmF9C24QfuF6FBII3njTmWA/u22MKKdWkTCm364Zds4uD1fyMjRczkCk/jbmP
	iGoGXcc5v8+kZ6TnSNyXTQLbBamlXgpZAESIR5SXuu1V+ie9T3I+3Ihj024TbeYMz8dCyC+R5/S
	xGYbgOolD+wE4QiRd+2+faw==
X-Google-Smtp-Source: AGHT+IH5bWdUn9V+inAAYzX1nFsPFrQPywd00cBMWhKVgBRcwkroYe3aZ88m81OT1RfDwLpdZdOW6A==
X-Received: by 2002:a05:620a:84c8:b0:7c3:d07f:12c5 with SMTP id af79cd13be357-7c3d8e97042mr1392961385a.53.1741276265252;
        Thu, 06 Mar 2025 07:51:05 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533a1a1sm106257585a.6.2025.03.06.07.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:51:04 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 06 Mar 2025 15:51:01 +0000
Subject: [PATCH v2 1/3] media: uvcvideo: Do not mark valid metadata as
 invalid
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-uvc-metadata-v2-1-7e939857cad5@chromium.org>
References: <20250306-uvc-metadata-v2-0-7e939857cad5@chromium.org>
In-Reply-To: <20250306-uvc-metadata-v2-0-7e939857cad5@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
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
2.48.1.711.g2feabab25a-goog


