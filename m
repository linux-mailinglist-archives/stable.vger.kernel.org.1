Return-Path: <stable+bounces-144550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89769AB8F5E
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 20:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F318B500792
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 18:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F5429B766;
	Thu, 15 May 2025 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M37H/kvt"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DB229B22C
	for <stable@vger.kernel.org>; Thu, 15 May 2025 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335167; cv=none; b=LDmYX3eTtdHnnuvR5XSzY1C9zpNQtsGKGzfN1KBZHc4q6GrO/kjN4+y4jYArSZO+0eHAY03wXBPGM1z/LGFGkyX1qrVxE8u5G6LIQRKNelmH35FExTtIIk1R3FhN1hRnjejW+2sFxmdRt2f3nTsY6cAueqwBa+yLBZ+fB65oiew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335167; c=relaxed/simple;
	bh=0LjNKhbfmAib3/bCGGrxaNTDj6/FhN1QTzDXt9i+2Dg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GlZm7CV9VVCXmHVPSNoKcxBbx8VDf6Z8cfNTkdzzxfKaTi9qXyuboe+8gCi05HqguaB1kLng3lDyE4tfTFIsCGqKQcrOlkGa8NIY7xLQJJNGA31luq4hcgFXcWQnMCxGWCoiNjU4frVtM8yZC2HbJRtHJLAXL/SjcHFHcQ+8s5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M37H/kvt; arc=none smtp.client-ip=209.85.217.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-4df9bc2037bso189622137.3
        for <stable@vger.kernel.org>; Thu, 15 May 2025 11:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747335165; x=1747939965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DWyXRAdP87qgljLxl+HMaPV4zDEKZVcFQ9p3OniQnHM=;
        b=M37H/kvt3HAzYxRy423MGjcicT9FxMy76qDD9tflwllQp1ur6qZIwOIs+p2hnYdtvL
         /o2PAOGLM1aSU8tBsctPeuJoP6Svs7wwJ4XGflNFLOQPpuHrG82MXffzYuGPjcNsPxRw
         SUrek7mTeAsfOA9JjCjPUjPnY8XeuHeABA2luMC8AzwjtaUdPBuGdLY2Bmbr0jX0UIvr
         F18s3C+D5V1+lI6FKVLOnmyb+sks5gAgyBR86o14311U+hfGNG/xtm58wI2h4Bagh3e+
         wXT78oA1D8XqUiZ38NS6dhflqUp4ELMYiSO4su7bc7xybvoBi0Q4sh1y8IJ/qFvA+up3
         GR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747335165; x=1747939965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWyXRAdP87qgljLxl+HMaPV4zDEKZVcFQ9p3OniQnHM=;
        b=MysusyEJANcFlerfV/+tUjYXIvQhV/w2+tOMSso/jRDglXFHwmoSjg8yD1kaD2x81J
         cIrHIgje39/FdT+zF5i+tUlQrpiH2kIhpzrv+6eh3/Ls9Xahz/2ooUBZkDCfA4hG3B8H
         kB4b3YeVJ1Jl3nOo+w5bVtb+SM818erkLuYybyf419jbCAcMMBjpkpHAiob4y8gswFUR
         FA4cEJAdJiH7IN9ZonTVJ4go6k1VzC7LlHIyRFEzutvvDtc8BX6m0Fwu9+UrCFm9Rlxf
         quwDG4ZsIGp7jseQf6+tF9WeaLz/06yeBrHU0bXkDCnPvpASyyB8AXDjxUt5Rd3+ESkG
         dr1w==
X-Gm-Message-State: AOJu0Yx9bEqunrXzMODGuaOG+6Dc8bkcGSjD9UEsMv41BOML2jHE9eFe
	UibX+MsdyF/A5Z9t/u/VM7M7mrYLK2HCf6asQu6N6MT77GQl82ViWk3IJJc7IWOnAtQAMPQrXxz
	/nww4/Q==
X-Google-Smtp-Source: AGHT+IG22pOiWebGnpFU30OwudK3lZF8XV0VjtcFcbirfzEnZEJ1trZz38ISLvHcqDC7fMy1q+bzyq8op8g=
X-Received: from uabji15.prod.google.com ([2002:a05:6130:694f:b0:862:24ba:d6a3])
 (user=royluo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:a54:b0:4df:8259:e99
 with SMTP id ada2fe7eead31-4dfa6aa8d4emr1466532137.1.1747335164831; Thu, 15
 May 2025 11:52:44 -0700 (PDT)
Date: Thu, 15 May 2025 18:52:27 +0000
In-Reply-To: <20250515185227.1507363-1-royluo@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250515185227.1507363-1-royluo@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250515185227.1507363-3-royluo@google.com>
Subject: [PATCH v2 2/2] usb: dwc3: Force full reset on xhci removal
From: Roy Luo <royluo@google.com>
To: royluo@google.com, mathias.nyman@intel.com, quic_ugoswami@quicinc.com, 
	Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

During an xhci host controller reset (via `USBCMD.HCRST`), reading DWC3
registers can return zero instead of their actual values. This applies
not only to registers within the xhci memory space but also those in
the broader DWC3 IP block.

By default, the xhci driver doesn't wait for the reset handshake to
complete during teardown. This can cause problems when the DWC3 controller
is operating as a dual role device and is switching from host to device
mode, the invalid register read caused by ongoing HCRST could lead to
gadget mode startup failures and unintended register overwrites.

To mitigate this, enable xhci-full-reset-on-remove-quirk to ensure that
xhci_reset() completes its full reset handshake during xhci removal.

Cc: stable@vger.kernel.org
Fixes: 6ccb83d6c497 ("usb: xhci: Implement xhci_handshake_check_state() helper")
Signed-off-by: Roy Luo <royluo@google.com>
---
 drivers/usb/dwc3/host.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index b48e108fc8fe..ea865898308f 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -126,7 +126,7 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
 
 int dwc3_host_init(struct dwc3 *dwc)
 {
-	struct property_entry	props[6];
+	struct property_entry	props[7];
 	struct platform_device	*xhci;
 	int			ret, irq;
 	int			prop_idx = 0;
@@ -182,6 +182,9 @@ int dwc3_host_init(struct dwc3 *dwc)
 	if (DWC3_VER_IS_WITHIN(DWC3, ANY, 300A))
 		props[prop_idx++] = PROPERTY_ENTRY_BOOL("quirk-broken-port-ped");
 
+	if (dwc->dr_mode == USB_DR_MODE_OTG)
+		props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-full-reset-on-remove-quirk");
+
 	if (prop_idx) {
 		ret = device_create_managed_software_node(&xhci->dev, props, NULL);
 		if (ret) {
-- 
2.49.0.1112.g889b7c5bd8-goog


