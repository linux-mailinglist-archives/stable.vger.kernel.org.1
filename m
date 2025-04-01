Return-Path: <stable+bounces-127326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EB4A77B5F
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 14:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20FE1688F9
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 12:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557462036F6;
	Tue,  1 Apr 2025 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="trNQnSQ4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCB51F0E56
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743512060; cv=none; b=iPlO5FRa1MinJvjZ8aeDvHuNXXA1Lrwgd+SMtDVdfLwJvGGtX/Dwv0WOQfGIMAEc16ifibaqFNYVn+NvcTmW4WrsN6nFb48P2A0c6xBfvp+LpvP5m1B9GsrQS1498k+v+I3GxCXKw2komc23e8I4h6cQETJIPDfwI6NlNdyX33U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743512060; c=relaxed/simple;
	bh=l2PcQYbG8B/62rNOGiRk4wusyvFroUGb6d2YBZuccW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I7Bk+V+yl8lEOCMy/R/jHD055Rv7yTATRhUDK/c9GhJDuv0eDyR004QfibmR/Bs1FtdrI5WHZ2ruvnKotKiIqIqJbttEQ7TI1TCEHA0dpB85tGhrIW2ZtxnokhcdxuGW/V2Ar9IgcGmikp9B+CdWQ1tWXVg7pdKCn8mPRANElG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=trNQnSQ4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso52428295e9.2
        for <stable@vger.kernel.org>; Tue, 01 Apr 2025 05:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743512055; x=1744116855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kIq2bCCkLTbVl75qgjk5SV7W2QZVt5vI8B/3mGbWOoQ=;
        b=trNQnSQ40kGaZJpWM9QFx+punNyaFS6cCaOYW0f0k6zB/tqEpznMnZUN9VeM6mKYg9
         uMZENe0DTG8StT5z3823P7GXZCQ8IglQhX9XftQoD+4usV+f9F9kRFemtCsFaXe2eEab
         H5fxEfREONJ1O5Zr26laXA5p/7O4iG8XE+70BM5SXWN+ZhlQ7hm+HEg/5uylwN64UK/j
         SDqxs5CahUBwHuH+aDUCW9RvC2SF9oU4wHg16d9ahd1o1sTezvCp6Cfw4xH+Z3cnXuyr
         42Dh/PhJywC4nmJj6yWIjKhNJP0LuEwsVh0KiwXj6JblHnMCtX+HKpsM5ysjcJrai3b2
         Gzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743512055; x=1744116855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIq2bCCkLTbVl75qgjk5SV7W2QZVt5vI8B/3mGbWOoQ=;
        b=hXy7udXZ0g94TJ5EtRx8lv7IneDBwReeJKf7mb1WKibpei5G37YhSbqibvotC+Oua+
         3bJEgMKNn/Rt6VQIiLm83+gkOsjlGfQwIqD6WsYrqwsWvJJtP3UJf/1BBXx7tUJkiFay
         Sbn9YnHf6kkueHDclTKZLIVg4gzc4IFlXyxw3vZ7Dcjfr43/EBUQ3zvLZOpi1wSc8IHU
         Vq21qD1Xj+WtoF23+GNed+o1Zr5mIX76ft2vjajPu4Rel3WewClG+vqsjNXDUE0XOJK0
         Yi4a6urNddz6iwMa2DU4UN8p9dzeDgWfVgFBoaxYHSmNMOd2+wQokD2FnRFxtAo37zyq
         l6pw==
X-Forwarded-Encrypted: i=1; AJvYcCUcDUBWNErjKwzSmYUnLoyLlS3qT/n+g6YVr3Dm91uXucwoFSwjnCtYpU00+v1deKDzi+/hR78=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpm1NULxnrv2/Ubm7wk5pTUYElQVZsdveo0Xw8RK7Wo552ZG7I
	m981VVFEzb++o5jUkjPZXxb0KWqESzfFBMpF6LPOzu2unOM2e80loGhXgpDCurc=
X-Gm-Gg: ASbGnctJgBaMT2sYTE6uxpEnGLC5oiGcR2+/UF+d+VCFJgH9dF5DNlp+idsmTyT/6rv
	tPEmxtMKHq4847ypOIoe0DR5xTDHANNNYgrIOUmNNWdmjZBqrw9nN+UXFDrIkxDxDW/SGUHil5l
	+I8i9LrsHbS7Mz/Nt6SHMqnob/06DjwU7WgNmjQ4e/t1+2KLtpVUQYRKE4RjorWjePbWSzVgJzp
	EBJ217hlCrD6Tw7gSyjzC9pd0CohBNb5xUgwdyEDYDoarUWB6Rxz0fYB0rl6sGmARn2zC4fA976
	qW9so+Wbvs2LhJRYvOhgbZU4AqCBxDxcAvjXkL8HHfyKoWR7EDGr7zNAn1c9Vg==
X-Google-Smtp-Source: AGHT+IEfm8jBIGS/rCkSCv4g7EEJ/qYcFumwtgYOgwdspDEMaLkkrz6eUaRLu7Yh0d7egIxV9UoOVA==
X-Received: by 2002:a5d:6d84:0:b0:391:2dea:c98d with SMTP id ffacd0b85a97d-39c120cbb15mr8544270f8f.8.1743512055189;
        Tue, 01 Apr 2025 05:54:15 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:355:6b90:e24f:43ff:fee6:750f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b658ab2sm14214546f8f.15.2025.04.01.05.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 05:54:14 -0700 (PDT)
From: Frode Isaksen <fisaksen@baylibre.com>
To: linux-usb@vger.kernel.org,
	Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	krishna.kurapati@oss.qualcomm.com,
	Frode Isaksen <frode@meta.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: dwc3: gadget: check that event count does not exceed event buffer length
Date: Tue,  1 Apr 2025 14:53:13 +0200
Message-ID: <20250401125350.221910-1-fisaksen@baylibre.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frode Isaksen <frode@meta.com>

The event count is read from register DWC3_GEVNTCOUNT.
There is a check for the count being zero, but not for exceeding the
event buffer length.
Check that event count does not exceed event buffer length,
avoiding an out-of-bounds access when memcpy'ing the event.
Crash log:
Unable to handle kernel paging request at virtual address ffffffc0129be000
pc : __memcpy+0x114/0x180
lr : dwc3_check_event_buf+0xec/0x348
x3 : 0000000000000030 x2 : 000000000000dfc4
x1 : ffffffc0129be000 x0 : ffffff87aad60080
Call trace:
__memcpy+0x114/0x180
dwc3_interrupt+0x24/0x34

Signed-off-by: Frode Isaksen <frode@meta.com>
Fixes: ebbb2d59398f ("usb: dwc3: gadget: use evt->cache for processing events")
Cc: stable@vger.kernel.org
---
v1->v2: added error log

 drivers/usb/dwc3/gadget.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89a4dc8ebf94..923737776d82 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4564,6 +4564,12 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	if (!count)
 		return IRQ_NONE;
 
+	if (count > evt->length) {
+		dev_err(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
+			count, evt->length);
+		return IRQ_NONE;
+	}
+
 	evt->count = count;
 	evt->flags |= DWC3_EVENT_PENDING;
 
-- 
2.49.0


