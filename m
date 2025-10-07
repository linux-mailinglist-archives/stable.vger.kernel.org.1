Return-Path: <stable+bounces-183565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47232BC2CBB
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 23:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96C63C1A28
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 21:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268AC248898;
	Tue,  7 Oct 2025 21:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7M0g4DI"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4D5246783
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873918; cv=none; b=ReAX9g0rDtM4HPc0rSuRV30MuLLGiZfl2brcofHWMfStWiVhaSezHldip3CMptvO4JM8dbN+zaKenUiy1zyjnjMv70FFqT7JDUm7csfIkRD+XPnecsyu2VQTYDF0KooofwaVUxpfyOZFYdXtRsWw1TCk28rjT+8RItjdMZvvVyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873918; c=relaxed/simple;
	bh=QDGRau9hUTIw0LmGZxQbGkUnm+lvJ+Sc5cUwuswn8gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N60xyAsBEWbtR/Zls/IgMe756g+/esiXOTUDb5A68Ij6LUil4OlzTZb06BQV0VJPC82o2ZVuNpGyEbEVElQEZo8BHw14W8V2qYQxvOIBBxGmDgfBUHNluBuIIGg6tkxKER9lEsPplXSSokmltoepXDQB0W7Lj573e9LKRoALXuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7M0g4DI; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-87808473c3bso873840985a.1
        for <stable@vger.kernel.org>; Tue, 07 Oct 2025 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759873916; x=1760478716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zspedv/g7MbmKhSduq0BNA8/CtYiYE9VtM2LqWSPvok=;
        b=k7M0g4DIQmPLKKBSH2K+BRrIRpBxar64hq/OqbP+UATzE/JJfPvQS4t1Ze2Hah7poU
         0cH4ptnxaLZj++AWaZI/V/K0zFZbcR9Ft/afHqqi6lOOuScrevHhwOu4go9DhgiaNkbK
         vvVGQ1PZBBqR1HQIFzIDqKRZ5V4KYjZHQgy1oFd/YIwcWH0P2tBOCs2cWf7h1MAB1O6Q
         b7LOPbf87PkTxujCPEb/iu4caC/aHieOGlOlFplYETEtzSFZNzxMW9Zh+RiClbrUCUDu
         wVPbGgbhCXtA+FAtRg2Oab7o82VyizOw+tjNur1+6MX+oAhSHGwWQCSqiCgbTlr4aY0r
         ATQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759873916; x=1760478716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zspedv/g7MbmKhSduq0BNA8/CtYiYE9VtM2LqWSPvok=;
        b=adIWLT0kSgzN66/R2wmF6tzUQCW6rggo9SNdSD/qIFoOFovoZjvwhN4fqVop75zMff
         SQnCO2k3fwZsL3baK63zwRPs0R6jksywNVqb7U1C84KRLCs5AEXFW9WjZPk8K5ocZdKy
         yFC/HcvzLzMu24QLhcpsRamTC4VeYIHoG9LWnDPxgZU+BJprGjwmhdhRwTz70Ql+rQCl
         DGERAGE+Co5P9MWPAHb52ysFj/UVSZEsdDYRfa0Iy5nTt7Q8Mxsut2Etk++KC9a6x1ed
         F0is7KbTL2bPL/yBAAu3uFk3e0QnpBlZkQN5O8WbpJIevkTGEJ4DORGs/ffdveqcUKgA
         4roQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn5ktVqZ5VYFAlRAqEkjO7pv5QwuO2hdEBbA4blBHtm8XXhacWsdEWLEFtZ0sUQ7GNEzhKwNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0UeHM7Jwr81tjXIFjdVKaPCdO1QVIC1DP+etY3W34l3Nmx1g6
	68FyyE/hN+dIti13+ZT/Ry17U1HWFYnZ3xk0gl3ahV4SQGQRRvaX6nDo
X-Gm-Gg: ASbGncuPcmnj2ZQS0JcQJtDAzs8vCchy4OpOSOEujd4WEO3sbrYloH2bzD9SzwiVY78
	flS1vce8PhMFiNS7nN7Ras/48nWRXneHHpLTR5sgu64qCDZCDJENh4ivD15UgUP1bk5jOBdKWUP
	Ae9QLlPmqtJfh+SsMy94PaYRx79B/XtMSGt4IV1LvufVS9BV0KKr+b1DorWVpuBiteWj6UkEQkM
	yHa90OkB27U/bTeKaDOdGdpqv1AZ/C8u3VpYakPmEoc03ea77QIIBYzVvGD7Vw6mhZiRDP71b8J
	OFoxOfeacMkYf0OtJ4XSbLMvUfhZ4GPWm3L8bt/bHMxDWy5Y1aR54PKrHB8hNV75ODSm8q2dbkA
	zWmRXy0nJxNaz0bdvzJ+lD5YpQ9vut6/RIXU4tv34uEul1ib/gJJwzTfIytLrGI79c09PkPCoHP
	Riqo0/2BKN9mUpYc0OBrQwDGc+jK1FApc=
X-Google-Smtp-Source: AGHT+IGOq5pYG58K8mMoqQOeJGCTbi6ZyRgh8XgbbYFkzRFf5ylz+GiLTUem9QZ+rZgBYEWJ1sLt5w==
X-Received: by 2002:a05:620a:4807:b0:84a:568:b7d3 with SMTP id af79cd13be357-883546e1a86mr163438385a.74.1759873916127;
        Tue, 07 Oct 2025 14:51:56 -0700 (PDT)
Received: from mango-teamkim.. ([129.170.197.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87771129fdasm1618199585a.6.2025.10.07.14.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 14:51:54 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Input: pegasus-notetaker - fix out-of-bounds access vulnerability in pegasus_parse_packet() function of the pegasus driver
Date: Tue,  7 Oct 2025 17:41:32 -0400
Message-ID: <20251007214131.3737115-2-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

In the pegasus_notetaker driver, the pegasus_probe() function allocates
the URB transfer buffer using the wMaxPacketSize value from
the endpoint descriptor. An attacker can use a malicious USB descriptor
to force the allocation of a very small buffer.

Subsequently, if the device sends an interrupt packet with a specific
pattern (e.g., where the first byte is 0x80 or 0x42),
the pegasus_parse_packet() function parses the packet without checking
the allocated buffer size. This leads to an out-of-bounds memory access,
which could result in a system panic.

Fixes: 948bf18 ("Input: remove third argument of usb_maxpacket()")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 drivers/input/tablet/pegasus_notetaker.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index 8d6b71d59793..6c4199712a4e 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -311,6 +311,11 @@ static int pegasus_probe(struct usb_interface *intf,
 	}
 
 	pegasus->data_len = usb_maxpacket(dev, pipe);
+    if (pegasus->data_len < 5) {
+		dev_err(&intf->dev, "Invalid number of wMaxPacketSize\n");
+		error = -EINVAL;
+		goto err_free_mem;
+	}
 
 	pegasus->data = usb_alloc_coherent(dev, pegasus->data_len, GFP_KERNEL,
 					   &pegasus->data_dma);
-- 
2.43.0


