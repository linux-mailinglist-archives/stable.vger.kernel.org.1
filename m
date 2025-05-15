Return-Path: <stable+bounces-144505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F10AB83AE
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 12:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC24A188167B
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 10:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F8A297A78;
	Thu, 15 May 2025 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvGrq1dH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC871AAE13;
	Thu, 15 May 2025 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747304500; cv=none; b=hV7v6ch9kmmvAR2rlPX9KIBlWURjXeuTWHMXrPmsXJL5ZUdquPxHqKwNwRHOSXTS1InvGgToESDLOQ5dfqrpfwmRYxL/Zr0SVE7uGusx9CXi9zbRjj3KTrPBGb62kNeduco77xuzjnw/Q02s9ZJFIEer+q6abfAeNVqrypLSCDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747304500; c=relaxed/simple;
	bh=IBJ48B8FrMxfymzU8kCA1OeBhWC5BE+jfp6BuTVBTV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e9MNya0iqMZLvapvCYi1SSNZqfieSfrN4WFtrkZfkqFxZY+gvBr9B68GmPhAd2pOnPOKYQVNtFMAEyVaiP2t0ZSPn6MYH27KPKe+2Y8mWLnbMhluRsT7xdA08ZuEDcaRLMlM66AEPtJl6Dflkze/JeVIGrdaXUFPZrrCwQ3Xmxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvGrq1dH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-441d1ed82faso6019175e9.0;
        Thu, 15 May 2025 03:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747304497; x=1747909297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=On9eUUQjGme99Aldh0NoBD5EoLx8LLi3roOkaysaImI=;
        b=FvGrq1dHTJeNrO6n7iqE7g/ddEp3397RyaF5CVezz1HDKipqPsuK8XUFK/VB8blsjL
         AmZVtjexAjxFdcXvUlTja5udWloVpjpvAijbymuAvIqBzBxVAofw9TFWZLNRzffraFyf
         vkVWW7OZ2Tusylx6IBE0RyJpspXmr3IsfnLN+DXiYSa4Cv/w9yHONwBX0WtwhTC6M31Z
         oC1rZbvEKqJDo7cUOuRuhFwBX58sTSZvth2n6n+aPh2Klw3txdbRwwn2rZTgpMeWNoCH
         EXXi3JxhjpYkbQMrRUYodCqi1EeZ6q0ISgpGC5qgn+OGLlIfT9XWJZM1Kq3sQkPPaGoi
         1gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747304497; x=1747909297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=On9eUUQjGme99Aldh0NoBD5EoLx8LLi3roOkaysaImI=;
        b=hC2zY//r2IOuQOv8a2rRwjKARHP4cGGfNfwirTWNfybXZwmeFcjPaZjJLViESOWPrk
         kMbbRGd8JqqOnQy6nyXNruxF1ZPpOYfRC7GZ4wrv96VTM42s840i3UVlePZnGztYkMud
         k4jGpdXifO+og/hmAVhrFCk7/waqtRSobhrIOcgkNnJl3RAVSeO8JAWqem8Wg8CyJid0
         GewnPsrfWMzq61QT32EKWI+JxV43cWHF/GpAHzeVfqYbny9gkbYSju6JOT/Ei6V7OinU
         IkVr1tEISM2RvJjURLx0vG1kIZW8jcU2mcY2j2oqjgKS/B4t7tasCzn9D8q/Pxpi6w4E
         ql6g==
X-Forwarded-Encrypted: i=1; AJvYcCVzm9uVxiOeCK+7Me3Fqs7/iRfyo0GE1ZKK33SLqREZVvavT9IqqYoL0vR/LUMeqFEO+8AY5O0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrGVRDRg1x5Am4ml+6EK5oWYizunWKHG+/wBoryc94rxEcivs7
	/11YzV6oVZgkWn35nMU604axXrH25UY9hz8q8uWD6zZIiXlamceIn9zcOCz7
X-Gm-Gg: ASbGncsZSlsdO9jh8js4ePJXVaU71ZZpioBMc5TOwkX5FjJcCjfHOvKhASev0be/NnD
	P/KEhsbFr5JcV62HnS9gizywrOWC/BuyCSUwdrLxd1vAtPTGSjBZqpsOLunlB2epUlaBUS3wQHq
	GW7nq8shMrFHJqqEa6Fv9VXGHfLauORD6GGNp8rjZdjeDjBMYLczAWOpNeZnJiTrfUtu4MT4OU0
	BXzYtws4rk+sAFfUtBQPuThr+ncMomuLAuGZ0/2PuqmqPR/KumQOBaMZ6lauRAZvHkAAQIJhLGj
	9ZxdefwC0PZFmUjJg/ZrSSas1pX81rYLuwxVA0Vz5MRWtQLGY56qDy6s2JiqaBl9Rq99
X-Google-Smtp-Source: AGHT+IHy4jHcrdobRv0+hmIO7Zf8+Kedvbw4BXOlx2nloQE+IEuvIZOU88dP270djnJ+7idCGIAd0g==
X-Received: by 2002:a05:6000:2289:b0:3a3:49dd:ada1 with SMTP id ffacd0b85a97d-3a35373780dmr1380068f8f.24.1747304496495;
        Thu, 15 May 2025 03:21:36 -0700 (PDT)
Received: from arrakis.kwizart.net (home.kwizart.net. [82.65.38.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2f65sm22668028f8f.55.2025.05.15.03.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 03:21:36 -0700 (PDT)
From: Nicolas Chauvet <kwizart@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	Nicolas Chauvet <kwizart@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Add sample rate quirk for Microdia JP001 USB Camera
Date: Thu, 15 May 2025 12:21:32 +0200
Message-ID: <20250515102132.73062-1-kwizart@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Microdia JP001 does not support reading the sample rate which leads to
many lines of "cannot get freq at ep 0x84".
This patch adds the USB ID to quirks.c and avoids those error messages.

usb 7-4: New USB device found, idVendor=0c45, idProduct=636b, bcdDevice= 1.00
usb 7-4: New USB device strings: Mfr=2, Product=1, SerialNumber=3
usb 7-4: Product: JP001
usb 7-4: Manufacturer: JP001
usb 7-4: SerialNumber: JP001
usb 7-4: 3:1: cannot get freq at ep 0x84

Cc: <stable@vger.kernel.org>
Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 9112313a9dbc..d3e45240329d 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2242,6 +2242,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0c45, 0x6340, /* Sonix HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x0c45, 0x636b, /* Microdia JP001 USB Camera */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x0d8c, 0x0014, /* USB Audio Device */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
-- 
2.49.0


