Return-Path: <stable+bounces-126925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0514A748B1
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 11:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D91AF7A83AD
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 10:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9D4212FAD;
	Fri, 28 Mar 2025 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="liim98gH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F2D1C174E
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743158992; cv=none; b=TXmOl88/SgBgdipBacGxfKY0hlHnl4oG8UHppXaceyvo/q1AJoMqN7zJqH6uVSkZ4a5wk+bZGNL13/9oUGvWhhqYlmwI38MjRzdLZIrCWjWV8tYdGAOz8VE2Jn4VICBNQRX4uB8UOBdneb+5vaRHOXo7Gz8bOlP2bzXT4g2RDR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743158992; c=relaxed/simple;
	bh=72hN35xKbPLsrofs2a84WCnG4Ltb4xvwlQLBAMP5uYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HdrAn6mHRDw3cu+BQTxjS/tJc8EH/Oo2Rkd3oDk/pTEcTFBWmlFtZC4ZO9fD2OVyz3+erPmc5zxbnfEMTtJP2/Fa8UiPz/3J85x5neulESm3aigWS9hYof+awweD5+0flz9m86+H81/eCwBe4LuoMUtke4n6iSH5iKIuwjzccRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=liim98gH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394036c0efso13076515e9.2
        for <stable@vger.kernel.org>; Fri, 28 Mar 2025 03:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743158987; x=1743763787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VH0Cwtt/VTuuDdT3io/MJ5ajnJoFp34tHNTuBuJNQOU=;
        b=liim98gH4gL+tpMdeetqRkKaOb/whCUks5eoNW6zM9Ji1hOby7epRb288Mpu5Ic7Xy
         LD8eVOPc5iBLcyU8Y51ssggARHzXq2LjwNqXZpWwS/DSpyP7hJZKi7IyNDfu+TArgWez
         FuFaVaZQmVdsuM1u86dIgVu52DvBq/amvFE5Qp+N/yS2MDVEmogbNq2L/7rspRQTxJ0/
         n18Jb+g/0rjrXBAsM3aGKGHfdKpzY/y1fHIKJ/Q1kRQ9lXtjlI9AD93ppnfz8OY4az0X
         v98NwdfH3VjhtRPNDqfXs5FvfGyxBC+MYx1GrRjm9lXaxpxexPNUxh1GTmk6w2TtyaaI
         vmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743158987; x=1743763787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VH0Cwtt/VTuuDdT3io/MJ5ajnJoFp34tHNTuBuJNQOU=;
        b=VhPCCM3ev9ay7Lmu5MorsxdniQCsZja8YveMDjlJmhx92l+g7PsxMmZbtJvbNELSKr
         i3H3MivhIg45ioRx6HwNSnaiPCZuid2SBxgpj67ibmfybB10xOiT8WWjdutjDUgw1kBu
         7KVKb6xmSCownHBlhk458pgTp+VmZFFonbTiPhZqUnxL+C4V1yRQBRRmI01DCn9pcWYF
         5DmoMEKCfF5iqzElctVvx3tpPwYKwNiRM5uNBJ6sKTS0sI+/Hm2uh8xB9yGxeWyBEtPn
         kUFd1gfW343r4EgjPvZgjPsb/xqTbR3Z6UmtAlRekhrRpDAJkBvYH75RZ596D4zwJ/CE
         oPNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJzzhvS5Xo2uqGcblOlCrqcnTqS8E4DGXKBozmqr6gD0ANLZlmPjSs6KqFT70S7TvSoFNWwec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaW9TTmXOPtWTeQ/OgVf1WHnim1qaxsdKh6PuQf1TQnrpAPhN6
	n0Q3zlUsBoIDs2qVzGgRnQORlAOlPw0zHidYf7A/NZd/nc0jQ80Oxxe1JE7eXiRvM86tWxCRhHX
	HtrA=
X-Gm-Gg: ASbGncvvdnNorx698z5Yz+J2U8IOIufq09aM1oOz7lGHHC5OxSivei2I/rggDN+1bHt
	9MmIdrzICYNQQNIGbnBinNCllD8pDjDwLDTqi9bvAJ1agu4oBuLAOUH/lnTEW6xvRP5LlYQ+q09
	Sp6qqj8Vv2lblwsJUFCX5IsXwbjozy4tEkjXiXSKdGP/arN6actBR0O69QPdTRRw24RmnM65C28
	3OWNuFsHAIuhsacRXrY7pmVnik1ensFJRFG/bxVMw2AHwe0hFlEedi8RgfXsjmADM8kkFKBi7l9
	c1ilDHIwvcMX5SEbi6GlRuoPiMm6j6WvIOAsJvD/JM+P6A3pVXCH1A2efwe+cesvPqOKcnpE
X-Google-Smtp-Source: AGHT+IHp8Quyt2xQsQT//2VK/V1cAZvb4JwTbOBC6Hl7+G6SZLVoHWk9yvPPwlmOIpGiBX4qeXqhoQ==
X-Received: by 2002:a05:600c:5103:b0:43d:683:8caa with SMTP id 5b1f17b1804b1-43d84fbea4bmr60361565e9.15.1743158987018;
        Fri, 28 Mar 2025 03:49:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:355:6b90:e24f:43ff:fee6:750f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a41c0sm2163406f8f.88.2025.03.28.03.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 03:49:46 -0700 (PDT)
From: Frode Isaksen <fisaksen@baylibre.com>
To: linux-usb@vger.kernel.org,
	Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	fisaksen@baylibre.com,
	Frode Isaksen <frode@meta.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: dwc3: gadget: check that event count does not exceed event buffer length
Date: Fri, 28 Mar 2025 11:44:35 +0100
Message-ID: <20250328104930.2179123-1-fisaksen@baylibre.com>
X-Mailer: git-send-email 2.48.1
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
v1 -> v2: Added Fixes and Cc tag.

This bug was discovered, tested and fixed (no more crashes seen) on Meta Quest 3 device.
Also tested on T.I. AM62x board.

 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 63fef4a1a498..548e112167f3 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4564,7 +4564,7 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 
 	count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
 	count &= DWC3_GEVNTCOUNT_MASK;
-	if (!count)
+	if (!count || count > evt->length)
 		return IRQ_NONE;
 
 	evt->count = count;
-- 
2.48.1


