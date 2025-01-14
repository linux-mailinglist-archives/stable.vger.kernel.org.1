Return-Path: <stable+bounces-108598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50315A108E5
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 15:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33BB3A51D9
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 14:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FF313FD86;
	Tue, 14 Jan 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gxnZXrpw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E0535DC
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864199; cv=none; b=ETNr6tQUhfRFyMmqycUZp4adwWMvbRgYLs222g2tgAmeOgSWhh8lET9lr+7CF9K7C8Digt6S9HiN4DPHZG7Gi0r6WbgMIedJrjUvKnouboyXcNfGrWyrjFUO/+2IE5CGJRzfniJOg/wCLoysxGoim2/A2I7+5KImXzK4t/Zuj64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864199; c=relaxed/simple;
	bh=2E3qbaOE73Jk7sbI6FLKhD7qbg28oP2KAGipqvlhwsI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ePIStsw4cFyXoeEPhUOn5KqD7CcXS2kY9KcFQx5BAG6uFOxnr6lJ8fAtW7uhAXsdyuIpgYbKF+F0pECp6gTW12uDocOefr7YIvjEYdf8jdRsgez2VTHZZfdkf7YwtIIK8/J9GRWa2XkPQQqKZ+0IlpC9g/f4RYv5Q+/oNA0o1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gxnZXrpw; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21650d4612eso146740545ad.2
        for <stable@vger.kernel.org>; Tue, 14 Jan 2025 06:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736864197; x=1737468997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=avmnJeP52XhrbIUiTpoZxNrqy28miD97Nfy+XqLUs0Q=;
        b=gxnZXrpwuGXQJvM72L+oQzDrMxwlEeLnXZ4OHz9GjkvYZ/cBtXNg5QPdlyz6g/7FxQ
         Zo5uwSxzRxygJS2/NylNUMNJ0RrOH90BGIXrkEFPS000kHmHh2i8iD/GvZEqJFC8cune
         sBB8geFdcp0p9fOsu8I2b/DYaB08/gf0bVGiD+T/IdmTV2m+pbnEesQIHehwst7C2oVF
         TUY5X1Rg1NPI3f7Ol8RK/XB0tIbHVRV26m8C/t18SLj0COFhcJpyV0d451DBZaAcbcW7
         WknH54Z2Lsu8zpuPvRnB6Ysf6Im1mamvUGX+hWEGa31wHUdLpeYp3QEuAp3A+sucawt0
         0x6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736864197; x=1737468997;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=avmnJeP52XhrbIUiTpoZxNrqy28miD97Nfy+XqLUs0Q=;
        b=MGM5i4pjvmG1GPcxLjjQ2aaYe8TX2ytxPAQgLIvZ8MEu2Te8+7jAGOKERpc/+QN0bk
         rFK6WUwgUuoveCXRQPrTrwLY7LKet+yH1mixaf2jlM/YTFFkb9C8X2IkwIVcTquKKFGx
         M9X7D+45wXRrj5RTmUMAkbIXo/e7lUUq5mjiF7ckJnnSWbTkVFHKs0f64SKNti+KAwCm
         5YcrFB/H+Mbdt2OCTDQBnaMBwZYQETqU3JkhZ9LZPnsv34m6QZsyxKERGbCSa8BtYhdY
         Z1pwweFVnFMZpIXO/MmXyiOrlrL7XQvEaxpLoZ774ev8ncrhffTf+dusS9XcyeeUrByM
         23BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzKRVV+JZv8KKENPspDpjt1v2HWfq9RCB5QGx7y/oU3aWn1duY4iWuQDfh9wsB34c5bOei7Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLmVJWcH9z+jmQ9bRWtkg0G7jg6TXc9QP9Dn6EOAoaLETLcOx1
	f48dfeI1dfxBfpDawCEV+CkqtWayauxm0fVy/rKPBt3vGPhlN72+pmTtVL7Hobbg/hWieBzJoQg
	Xq74/FA==
X-Google-Smtp-Source: AGHT+IHuhPge/LAKQx8gD9Y76v9vi2x2c/fi/iGzC8d1cvWEsELlR4g/XA0QMzvawNsKc5h+NkXx0WCqBUMc
X-Received: from plrf18.prod.google.com ([2002:a17:902:ab92:b0:216:61ba:610])
 (user=kyletso job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:230b:b0:20c:6399:d637
 with SMTP id d9443c01a7336-21a83ffbea3mr435808695ad.40.1736864196856; Tue, 14
 Jan 2025 06:16:36 -0800 (PST)
Date: Tue, 14 Jan 2025 22:16:07 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250114141607.2091154-1-kyletso@google.com>
Subject: [PATCH v1] usb: dwc3: core: Defer the probe until USB power supply ready
From: Kyle Tso <kyletso@google.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, raychi@google.com
Cc: badhri@google.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	royluo@google.com, bvanassche@acm.org, Kyle Tso <kyletso@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, DWC3 driver attempts to acquire the USB power supply only
once during the probe. If the USB power supply is not ready at that
time, the driver simply ignores the failure and continues the probe,
leading to permanent non-functioning of the gadget vbus_draw callback.

Address this problem by delaying the dwc3 driver initialization until
the USB power supply is registered.

Fixes: 6f0764b5adea ("usb: dwc3: add a power supply for current control")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Tso <kyletso@google.com>
---
Note: This is a follow-up of https://lore.kernel.org/all/20240804084612.2561230-1-kyletso@google.com/
---
 drivers/usb/dwc3/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7578c5133568..1550c39e792a 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1669,7 +1669,7 @@ static void dwc3_get_software_properties(struct dwc3 *dwc)
 	}
 }
 
-static void dwc3_get_properties(struct dwc3 *dwc)
+static int dwc3_get_properties(struct dwc3 *dwc)
 {
 	struct device		*dev = dwc->dev;
 	u8			lpm_nyet_threshold;
@@ -1724,7 +1724,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	if (ret >= 0) {
 		dwc->usb_psy = power_supply_get_by_name(usb_psy_name);
 		if (!dwc->usb_psy)
-			dev_err(dev, "couldn't get usb power supply\n");
+			return dev_err_probe(dev, -EPROBE_DEFER, "couldn't get usb power supply\n");
 	}
 
 	dwc->has_lpm_erratum = device_property_read_bool(dev,
@@ -1847,6 +1847,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->imod_interval = 0;
 
 	dwc->tx_fifo_resize_max_num = tx_fifo_resize_max_num;
+
+	return 0;
 }
 
 /* check whether the core supports IMOD */
@@ -2181,7 +2183,9 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->regs	= regs;
 	dwc->regs_size	= resource_size(&dwc_res);
 
-	dwc3_get_properties(dwc);
+	ret = dwc3_get_properties(dwc);
+	if (ret)
+		return ret;
 
 	dwc3_get_software_properties(dwc);
 
-- 
2.47.1.688.g23fc6f90ad-goog


