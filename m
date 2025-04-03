Return-Path: <stable+bounces-127487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA651A79CFF
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 09:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182393B5714
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 07:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF29240608;
	Thu,  3 Apr 2025 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yR2OhGUJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8BA23F41E
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743665386; cv=none; b=qqVq39ju6cakdTSeJvNbnWhjdUxZBVVozlQo95u5w5N5f2asYrVblaz6bc5g395Kh68tFvNTs6X0cKm+zLStV3P9FEododvffW3eNxcX3rRSU+FF4ejSsRx3HV+yQTrR5059jTghVmaHsXjwHZN/xiMeW/LUW+uDtelfX1lheg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743665386; c=relaxed/simple;
	bh=gPgYbaL+rhOQ9fSKgtZrjLnPUZeu+nsmZ0Ecrf1wPtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q+uFioR3ws1iVBXJLkHwKZLVlNEsUf2Y//m40aZiuWmDIEgEbzG2p2cJRiy+24vLEgXBvrwNCwMN3lvGnfje7cFoO3rmwm5mGPZMDk7zqzxWgZruk9qM4a2oqHeKmXw/NQqVY/kXHS7PsL0Ax78ClFTziBsM91o179dq2GVQw6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yR2OhGUJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso3061955e9.2
        for <stable@vger.kernel.org>; Thu, 03 Apr 2025 00:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743665381; x=1744270181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0sRQ76srbv8D7/R1qXBY2wavN01HHK5lciers8r4d0E=;
        b=yR2OhGUJYwZFUmtlVjT9dsuo9Dew3HYopvtcmgCSNpg0GJWPVHbYYwFPVnBp2RRcgv
         Z0Z0b3MEGUfmG8Jl4815BdKWCH3SxBhFrWMvTpcJg01+J5N/RgHaDLM0lD/0iCTwa4oz
         3YMz5XzCf+j4EQcOKCBgfXwmm1Aryy6tbB7n00PnfzixRH1NTORGTgH2d2WLvGXlxiGp
         itlXNHJBRTcYq4Gh4A8uOkJ2Y3TngFgdFIdOjbTAcvjEai4jrnlaFSVSbhzCSqjWkw5h
         JPe6jG5NSWyEik44YDL6FQnxESHfsvqPTFcNp0Qs8a8ra2idyBCTHVoOCD5a1w6vkfin
         H7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743665381; x=1744270181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sRQ76srbv8D7/R1qXBY2wavN01HHK5lciers8r4d0E=;
        b=n9oc82IAKLpNWAw7jWVjuvu0hhIxlgT+IiIY30VVd1GrZLE88mepMAWvIzXXG8Rg+x
         Y7tKxopQTIkY7uKo0JkWZTiIOkEe6PcmDpiwKwN3Qkrgrt/9/hubdZcqb16Z0hS2li/D
         hKTG+jFzIVLEDQmVf0DMgqd0gLfd+OY66dSLHpbXWgTcaoNkehPc7v60LT8Ggq8/YZSV
         kBEsjzGT3kNfozqDtd/XeOwvGAurb73OUKSaRdbZaiv0pVTnIKozMcvE5H8ECCAtmr+K
         wDNZTShAkU6fP260GbWjCTgjXgUiLuCA9vPyS6TW6FnbvtE0+GTtJIEQdfeRYUgyYxJq
         1R4w==
X-Forwarded-Encrypted: i=1; AJvYcCVm4pDaDZ/tXRh2GHrX4g4Nb5vC4Kdt8ejZIl/LdImjsFiR2skcvs05CTMpBBpfLkmapl8lPdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU2SscWvKeQGAT4ZUt9ipp0SREoLiOcXUrU7WUpCcGznDzNaPU
	GhjN18AE8q9xcUXwoO0lylF93plpRchQ+Yh9Xu3VuP7XvvxWf0hXT/9k41Ukgb8=
X-Gm-Gg: ASbGncu7NtHG7lrA0G64UTEtvuMrFJv1JJdyI65MKddjUv+aorjNEniwgNFReN52eSu
	cjvEE0WtUPDoML2L5mQYbABVOu3WNTzxhkL16OGbZWzo006r7Ag/RepHQWDuW4tZtnATeq9rLKu
	aZnPzqVBdEgKWYw2BmxswU7ybURwtOqXpsT+0lNGQBxg9vec86yfVY8V4whGqOERipUKie6560p
	HNKS8ntFsOvoY8RRMQ4AQJUsyQ67OBuZPmDiJx4unmwDcanEobdN45lhF1wC2sh2o9bInzyCrdk
	t10wVnEqgZm9P51kmRaX4ZnUPSZfvmu2uywsih1q6DDmuNiEm8cnakjOacC1kA==
X-Google-Smtp-Source: AGHT+IEK0NpzRIdpqLlvwUQOGPVY8za1RLz3sOqZ86LJdKiJXmK3wLJ1S9B5P6HVxD40Xla2VSb1kg==
X-Received: by 2002:a05:600c:4586:b0:439:8c80:6af4 with SMTP id 5b1f17b1804b1-43ec42b9616mr7733425e9.19.1743665380662;
        Thu, 03 Apr 2025 00:29:40 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:355:6b90:e24f:43ff:fee6:750f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1794e94sm13460735e9.31.2025.04.03.00.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 00:29:39 -0700 (PDT)
From: Frode Isaksen <fisaksen@baylibre.com>
To: linux-usb@vger.kernel.org,
	Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	krishna.kurapati@oss.qualcomm.com,
	Frode Isaksen <frode@meta.com>,
	stable@vger.kernel.org
Subject: [PATCH v5] usb: dwc3: gadget: check that event count does not exceed event buffer length
Date: Thu,  3 Apr 2025 09:28:03 +0200
Message-ID: <20250403072907.448524-1-fisaksen@baylibre.com>
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
Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
Cc: stable@vger.kernel.org
---
v1 -> v2: Added Fixes and Cc tag.
v2 -> v3: Added error log
v3 -> v4: Rate limit error log
v4 -> v5: Changed Fixes tag

 drivers/usb/dwc3/gadget.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89a4dc8ebf94..b75b4c5ca7fc 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4564,6 +4564,12 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	if (!count)
 		return IRQ_NONE;
 
+	if (count > evt->length) {
+		dev_err_ratelimited(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
+			count, evt->length);
+		return IRQ_NONE;
+	}
+
 	evt->count = count;
 	evt->flags |= DWC3_EVENT_PENDING;
 
-- 
2.49.0


