Return-Path: <stable+bounces-108668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84699A11892
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 05:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24D77A20F6
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 04:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD00E22F38B;
	Wed, 15 Jan 2025 04:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5D7hgXe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3B9156880
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 04:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736916358; cv=none; b=PG1Ki4KPmFSuzkpLStIz6yQGW53cyqnBIUw6Xip9muxjkiFCV6Ja/fUM+qHEYwjCCIrWArzapI7eIMKi2+oUks5hMKynscN1UgUb3aaFM3+H66yFixHVo7lbWsmgdAZl5m6J7YR88uh/B9vj5pQCEVKeLxQ39aWxtkVA/Iq9zks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736916358; c=relaxed/simple;
	bh=Rs3iU75BPjBxdbiw5HZnrXaDjajAgcAfQrjJFAg8Srg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZSCxyBfRV4mUWi+Gh/x+bQxTxyX/bsFK0JadCr72o3Xll9G52HDlb+ajBeW59p4SpIUGPpMOrwbmDcwxCkvbUqg7F/gFMJfNAJBo/UoenvuUtTYJo5rkPb7nXUvFo+RSBWnetYjZXIOFSIMZy/FH1MKbv9oZVsnNkPvyqe+1c2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5D7hgXe; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2178115051dso114192995ad.1
        for <stable@vger.kernel.org>; Tue, 14 Jan 2025 20:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736916355; x=1737521155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uzJUS+TBGgIy8wVOHUCLoOBsCy49bT0VT2xYdEdiljY=;
        b=P5D7hgXeaPQ3ppPuYRbJlJmJOIhid/GY3kOUfElhh0lx03Xs2oxOQTVwjS5UizkBlG
         k9McnpK7YAU6oDHN+Clgvj2ouAAi/UqISy0onfHEtkLvP4hpo2JJgfYm53moEMwFcE+c
         kZxglAVs48UPYh+jUDzcIA1i3CBC0da/iP2q1tvVycaG4R5PYF2PfWBQbiX5Pw+Hacsk
         TSVSWEXpMuSVFbajVXqsAg47YFN81UBfEIAszxYXPXgRAIEn4kQ2YnJr0sdbL0htzGRa
         auGxQ1AjdUCeXH8lGspWKSiH9sauJeINfcGa+5d3tjser613xrwn44BVRJCzXxJixKMh
         rt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736916355; x=1737521155;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uzJUS+TBGgIy8wVOHUCLoOBsCy49bT0VT2xYdEdiljY=;
        b=a5+Ua4zZLvwcx/+B5gLSIX5LkRaYyNV+PPBL+Ix6dvcNvhQy7Dh5c7+odlDdGEzG04
         9ZmQO62PTjtG1DQyPJtWVeFrGN5bzTh64icNs6apFnAiIk2tUocqlf3598X8TTZRnn8U
         gVEtP+OswdojM95cWMZEWheVt/roWSOffzpP8uUsN3p4+Bo9a0Pqp7DJbP7TjRpOZKy/
         AgDEZO32t3yVcpE3qh1kH7UUsaQ7Eya+WWn+JpncPHSFFY2n6q91TT1Bq+a10EiVA7wd
         8HlKyR7TjoYF4QAXeErtgsAbOTRCBVNgG96I8MJj2epJTteG3XLkCowN/V4XbeX7w6e5
         N1Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXrVgwpxHe9y0JZxhYooJD6LsF3H/e2uCsQ8jfsaGnYJLEquJDYCri+j87ExBT5vuygGuPpJTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRKySnxzlQKLtt53P5A+qoHVnge2UlgeoX68epuJi8z8/BUWSa
	eIQp2MAWvSGcMmHGMGNiUghZQG5eF9Qszr/YSxXhMxQVu0YJufoS99/gxlF2Abz76Ak7oH1LQfs
	/7NF5Ig==
X-Google-Smtp-Source: AGHT+IH+6g5AYVxZ4+GIsTrLIh8vINC6goLc5AwIWvkIO0MYDuXuHUHdA5IzdZb0nDr+V2ZRBE4yDoW7REMO
X-Received: from pgll188.prod.google.com ([2002:a63:25c5:0:b0:7fd:4c8f:e6a1])
 (user=kyletso job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12cc:b0:1e1:e2d8:fd1d
 with SMTP id adf61e73a8af0-1e88d0a2b46mr41166358637.33.1736916355337; Tue, 14
 Jan 2025 20:45:55 -0800 (PST)
Date: Wed, 15 Jan 2025 12:45:48 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250115044548.2701138-1-kyletso@google.com>
Subject: [PATCH v2] usb: dwc3: core: Defer the probe until USB power supply ready
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
v1 -> v2:
- get the power supply in a dedicated function

---
 drivers/usb/dwc3/core.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7578c5133568..dfa1b5fe48dc 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1684,8 +1684,6 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			tx_thr_num_pkt_prd = 0;
 	u8			tx_max_burst_prd = 0;
 	u8			tx_fifo_resize_max_num;
-	const char		*usb_psy_name;
-	int			ret;
 
 	/* default to highest possible threshold */
 	lpm_nyet_threshold = 0xf;
@@ -1720,13 +1718,6 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 
 	dwc->sys_wakeup = device_may_wakeup(dwc->sysdev);
 
-	ret = device_property_read_string(dev, "usb-psy-name", &usb_psy_name);
-	if (ret >= 0) {
-		dwc->usb_psy = power_supply_get_by_name(usb_psy_name);
-		if (!dwc->usb_psy)
-			dev_err(dev, "couldn't get usb power supply\n");
-	}
-
 	dwc->has_lpm_erratum = device_property_read_bool(dev,
 				"snps,has-lpm-erratum");
 	device_property_read_u8(dev, "snps,lpm-nyet-threshold",
@@ -2129,6 +2120,23 @@ static int dwc3_get_num_ports(struct dwc3 *dwc)
 	return 0;
 }
 
+static struct power_supply *dwc3_get_usb_power_supply(struct dwc3 *dwc)
+{
+	struct power_supply *usb_psy;
+	const char *usb_psy_name;
+	int ret;
+
+	ret = device_property_read_string(dwc->dev, "usb-psy-name", &usb_psy_name);
+	if (ret < 0)
+		return NULL;
+
+	usb_psy = power_supply_get_by_name(usb_psy_name);
+	if (!usb_psy)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return usb_psy;
+}
+
 static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
@@ -2185,6 +2193,10 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_software_properties(dwc);
 
+	dwc->usb_psy = dwc3_get_usb_power_supply(dwc);
+	if (IS_ERR(dwc->usb_psy))
+		return dev_err_probe(dev, PTR_ERR(dwc->usb_psy), "couldn't get usb power supply\n");
+
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset)) {
 		ret = PTR_ERR(dwc->reset);
-- 
2.48.0.rc2.279.g1de40edade-goog


