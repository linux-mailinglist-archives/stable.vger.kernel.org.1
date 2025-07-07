Return-Path: <stable+bounces-160394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C91FBAFBAD0
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 20:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648533AC7A1
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 18:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F21272817;
	Mon,  7 Jul 2025 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ReLbL6Ef"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C96C265606
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913247; cv=none; b=W7LXp4ypkqpflTVrkzJDG9WNFEzo+jgvGLVsrzilMetfdHlAUSMYB4dvKeVuIpflXBX0dFD8Sc+lkGQpzzKPZDW6RuCcjiKUV2y5RfkDU2z1ePjP+OwKn/iIx7WuKcGNyGQY2i+pVFeVUkkxrV+6/6jWv8DxeVCunl+mipHWfC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913247; c=relaxed/simple;
	bh=RVxAqarkuhEy/QD/KmC40z7AIVmkZCTNthOhmweLPWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SG6FxGYaER4K2eWgbrKeKypt32flfixHdWborcmJGm4KbVFm2tG7icKozPTjMTLrx1k4mtdhbBf+fW+Fs+dNjRROmlHKIalx/qVWRtboA/g0mcO7gVyrLLkMNSoLoGq1b303tnygECFrFfxjGB1YKw2IYCVPXC/IweBipMUQSTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ReLbL6Ef; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553b584ac96so3376836e87.1
        for <stable@vger.kernel.org>; Mon, 07 Jul 2025 11:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751913243; x=1752518043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEhoouKujX/9FWBm8EBjOLs/wPi+sCT2bfLGhUx3n5Y=;
        b=ReLbL6EfWBuUhA6aT/giSyaRRxVPOU+NwkQNz2WXqa+b0ldRYnDjtEz2ntC6s5O315
         fDt2+rmZR/OqpyNW3K4IA3JbgBnJOJXek4WEzrFwewdtJ9OUFT+ZvJeGVpRWzeAos1Jb
         oX5JhiKOlIv2I222P4u94m2/5ErN5h57U0skU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751913243; x=1752518043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEhoouKujX/9FWBm8EBjOLs/wPi+sCT2bfLGhUx3n5Y=;
        b=fAice/MtmQsTsO+ew0ScD7offnLTnMQ/86jNznocXwPzqpFIhs6X47ZDKZl9ongs63
         Bw5QzJNg7OJCkEJc98ei37q37zZjjidU+qaw1kPY0WOqyHUltazXMCW2YUFhmI94utiE
         4qCmc53wpfB4xskkPi4znhKBVpwQWEgQ9APyrZNoOClK1BVMMzVjqRiL+EuaG0NDsIvq
         l9pGRkHa25MTQHdV5xvIo6TaaNHSdGD3rGhMLuhESeMepSM7f4qw7OFct9Ko+OYsLdZF
         e9fD5B8DsqIF9rty/JVNcRAxze5uAG4IeW2DAuWNH5c679PtWWCciUyvl9MGxH7cq664
         MWKA==
X-Forwarded-Encrypted: i=1; AJvYcCVU3k4mHKEzmeUtO+lrPETW6gyC1Faiw2qDz3AiVkRk7AVB1u0gWQcXUqUl5rtrr2MBDWwKf38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKu0/0vpCO1a7VLSW1K+e5NG3B8QS7v1n0GeH+iH5KS46Kl3CI
	X0nZM+bQE0vxM32A7Z2tYrAjqUaMAtwg5OE+1eJo/MMKsH+x/Lnw9upCz2jbxWC0pR7U1SXIM2s
	rZWE=
X-Gm-Gg: ASbGncsiFYHlstzGd/7TDXA9Q4utvg/dRzwxjnr6a4F0C2h7AWazYOEbIqC7o0/GoUD
	ZpBzAjPesIey/6QZ1Ynubua6HoyoTnoSQLNO5swD5gAoqEVmg3q2OvgR2WYKsTaLDBKQccMUbzi
	OwvHEPGM2mixBxD7ALasJ3JxrASTUzq4DuvytU0w6yh6OA5DkJpytwQzDO1Ioa4PvW2k5nue+MW
	2XfBAn9r1cbmGYDHz9vn14wIRQEpX5d+l4Ccdrw4Lts186/UY2YrfXjraXMxmwH6qAnlzGyprnE
	Ol06YKzlZjXpmkh/UqI4ZX5n7bTziU6P5zIgISNJjJKN6jKwlfcFs+sCDy/nlnypU/2ECLxMIEK
	TvO2041WD1NgFJdz7qe6SnR7xtSKSg91WHxv1ZH+qww==
X-Google-Smtp-Source: AGHT+IGKJuOX4Bg7R899m2AwcOsJNjoMYlKG41sbEd23b05icnKCcd071bRXekr5xYL9YnWZKX+jcw==
X-Received: by 2002:a05:6512:3c94:b0:553:aa32:4106 with SMTP id 2adb3069b0e04-557e5556e89mr2272305e87.23.1751913242985;
        Mon, 07 Jul 2025 11:34:02 -0700 (PDT)
Received: from ribalda.c.googlers.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d31a6sm1417630e87.61.2025.07.07.11.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:34:02 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 07 Jul 2025 18:34:01 +0000
Subject: [PATCH v8 1/5] media: uvcvideo: Do not mark valid metadata as
 invalid
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-uvc-meta-v8-1-ed17f8b1218b@chromium.org>
References: <20250707-uvc-meta-v8-0-ed17f8b1218b@chromium.org>
In-Reply-To: <20250707-uvc-meta-v8-0-ed17f8b1218b@chromium.org>
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
2.50.0.727.gbf7dc18ff4-goog


