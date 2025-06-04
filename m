Return-Path: <stable+bounces-151384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF55ACDDAB
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 14:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7998E7A1D9F
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 12:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CE528F92F;
	Wed,  4 Jun 2025 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G8iyOkHg"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F725EFBF
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749039369; cv=none; b=OcmpipEIA2pm/4izrEQTH+Pznw0FHZXy0ifQF1naBUEU6KmUiEyIIglAqPwGHjxqLE4/CZcFae5Zs+QEW5R88EbIVyn0hc2QBjxtzMskLToZtFskjdJ7+DI3O4xSrvz5dB3wjNhIr4Xl/cXTDMzLGgfjR5QpXIY/2RrUNF4tpG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749039369; c=relaxed/simple;
	bh=jSBviQQTH7JAePMwo7QwRip56LEcJbJopD0NUjuBTkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3yy+BswZ8vMOYFXxCS53i6twM1DRU+1N/FhN/VSlNa5CUM6+ItIaOR3mQbIYLOHnxdWuo83hP00jRT48BOVb+kA7Pz0bxFvpTuxh10+fYL9S8aeOMngr1P+R1kj/eFGdEYWRc8y+ak+G5LN68UlmEJguJr6nkbkd9qpwBzrzGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G8iyOkHg; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553331c3dc7so6782409e87.3
        for <stable@vger.kernel.org>; Wed, 04 Jun 2025 05:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749039364; x=1749644164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bRE2ys8mv+7tBhBfvYdhYX2EBs6/nnVBCJEn6Vbnr8=;
        b=G8iyOkHgPN+IXSQUq/50GbvfkUfYWE1dHn25TjVwlMnCI57vMa0ouZo0U5J7Om9WzN
         lSozfueM+T7UjGRuGi2SuzxlBQTWdcGNZ2gdVWffCUYLaM7Imp0a3rtLA1zD+6niy3e/
         Ddr+9OhNKBcrntuRrnBk07c37Mg5rpDdIef70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749039364; x=1749644164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bRE2ys8mv+7tBhBfvYdhYX2EBs6/nnVBCJEn6Vbnr8=;
        b=TJqZNFLiBldIpSXYM/fpWa/i9HB51aSTzoCLehIRxzPL75ZOoOipB5kmBEOT0FurjX
         ulvFJjOKM61/dJdKL0aS/REZfDqcD3GyE8SbHRLy0I+DENwHldpir5j6WXQTnQeehZvl
         sYmsxmHfFcllqCGB+1Uf8ZxcLt7Joxecma4Y4fVcO+qPAclXKgRZRX7JEHjvzC30TZ9f
         8Uk+45PnYYNPfdIdzfJB+9FOqvU64+fcxNYxwJdEA32SU2FHDQpmIpoyi3AneVk1PvLJ
         rztzQpJGjwlcEcyiDXpy9FJc74n3RLVWeZka9FG9yj5Xz16e0h0D714jSBg9wiTAc313
         9IbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpIGo6WxAl4+/PZLFhsUwQl7VX9HXXuYKr+4OnteSYOjIniZnpj0lCepd5m64ZnLg5Y5nJFAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4kK1b7HyGUkcdBp/tqkT6D3noAf/9E7VnK2IApew3nsvX9Ggv
	L9F24lSEH915ikGxgWKOKtVQbzh+Y+yhmRNWhOnLMt7IcEYbqmFIYv1PxmLZNt49Bw==
X-Gm-Gg: ASbGncvJI/CriZ2QJcK6J90yVOtWf9jGXiOjLRZMvjf/N5DsUe2yKgWOPF5J2Uwrb9H
	2fvRLbmPg33mW5Y0KuZ74LiNzZrCnnR2qhSqyXcChSjA6tXA5lcDTeqaQwZgzFmmnDPESzH/Svr
	jCAeDMJzmCRIDaamKjy81GOMBUQUaUtIUu/YJaMxfOIE6/FCmNjzhD7Q29jqNPUEXvrI3Nny5k0
	k7BE+lmmppDnzGQRDUetK6MIWVuKj3wKX1GJqld78ialyaayTtqeISvVDrXvpIGae1fUGTLTSta
	vhjGXbppnLMTyRPNEN0c07rUeO4xeLP2HLNiV7gZwtbAm0g+gOYsA5FbgTWXVEv2pTdqHEMc3VE
	RcyuemLxr67Wz2PhZhoCWCwoV6xBy9Q+GZC0p
X-Google-Smtp-Source: AGHT+IH07nfEfCPRSuygtbpDMHx2EgaT3En+BmBFDnKq74uak7z24qXSWnIDRK5q++KIzPjVa2AeUA==
X-Received: by 2002:a05:6512:3d28:b0:549:5866:6489 with SMTP id 2adb3069b0e04-55356defd46mr716577e87.47.1749039364509;
        Wed, 04 Jun 2025 05:16:04 -0700 (PDT)
Received: from ribalda.c.googlers.com (90.52.88.34.bc.googleusercontent.com. [34.88.52.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553378a12ecsm2289134e87.90.2025.06.04.05.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 05:16:04 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 04 Jun 2025 12:16:02 +0000
Subject: [PATCH v6 1/4] media: uvcvideo: Do not mark valid metadata as
 invalid
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-uvc-meta-v6-1-7141d48c322c@chromium.org>
References: <20250604-uvc-meta-v6-0-7141d48c322c@chromium.org>
In-Reply-To: <20250604-uvc-meta-v6-0-7141d48c322c@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org, Hans de Goede <hansg@kernel.org>
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
2.50.0.rc0.604.gd4ff7b7c86-goog


