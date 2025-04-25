Return-Path: <stable+bounces-136719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29E2A9CCB3
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 17:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2DC16A789
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 15:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524DD28A1DC;
	Fri, 25 Apr 2025 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="ZHwq+GeP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2610925DD18
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745594331; cv=none; b=qtrogKCUfDtZ0H5m2aqS+3ieb88b8rY1xbZtiBpGAMADe0aeSFEdcEM+dRatiNRSZXjULbLwHaNMDXU5QWkhX8slmRZWEPowR8eXzbHcuyOM1W6q26hHUe2shgeN6SR37D64oOfDNX647+6c1PzOua4+G1tyAc5CWZNrVXtSd0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745594331; c=relaxed/simple;
	bh=wDYHCLa5R2Lm8PFv1HaWiPbvSjf5XzEvOyMvWi1H6CY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nc0gn7J/R+fQRgpw4QX3RBVmHXp1YSpm0SqSUbhZmYg37vGMCcAaZeLw7ielOK2QfdF7RduRkvhCbogS5FMCXqoW82F2dms+3Qum9zFkyIOus+OlfPuilGux7bPfAV7D4cqIAfirJodjE7iZHOknpZnAnx64ajr0k2Yzkft2mCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=ZHwq+GeP; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-acb615228a4so595313566b.0
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1745594327; x=1746199127; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGhABSDncyCkqMF1m9WG+uwjNnjeaT93SjRTLfv5Zno=;
        b=ZHwq+GePs+RKCQobQ9swTjG3tVZNiCPZNr0zGEbFHlxgRETxYR4W62+5S9Qsjuj1xg
         KNY1+TXArniXt/OBtRxLicDD2HoiXwbDS/lZHycrwnCpsa1YLnd3TQ8z4nBLFUvXk1mB
         K59QofHgU9nipZfx5dAY4eqcdoLepMk5Dkze2em4PnmpjAPyiqRB1UTMKgvFcEl9/zeK
         hEwqBb1SnpN3dFcQ1gRUZMQ3rrStUu9hrXjoSn7mq4++GE8gIHuCNTHEJnf0thS5gsk4
         oYbDFRx9Vs0a51dES32e1sVlTII1Z/DrpRmoxOO0wsnRVVwhNhCgvOBRW5LJKejjVLU0
         4K/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745594327; x=1746199127;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGhABSDncyCkqMF1m9WG+uwjNnjeaT93SjRTLfv5Zno=;
        b=DNopZA/vJhssmlbhbZHuPRwRgb33X5XOSbTDHw9z664qbHWmw0B1rEWT+fLNFg1g4E
         7QXq4Eu/GtiQ7flMGwS54xwqRNFPiPDNaw60L8ZCeRJmUAWLF5C1w000cHWNjlqLn4kZ
         HnUfjLzn6p2S5wyn4IkQLRjA7E2vMLgs4RhkCq01IEk3xaWaWuh8nIRCd6WkJHQ6PK7E
         wipYob5X7Fm/De5sPlBDvXP5aG9iImjlqGjdwVlaY0dFiE5irHKKeMOVTXEKkqfgUCcp
         v1Qc2OFUg0dVr0Ez/1FFii8Ylc8oZTMABULtx8iTF1973hZjt1WV/VjHuvTGxyV/V+rL
         cNBw==
X-Forwarded-Encrypted: i=1; AJvYcCWu8FRNaN/fQnlv4KJgOnSOxnH945QskMTJ/W/gI5vhwr1dVcMYkpBvkmb37mdhzWFMF6CvPOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrZ0t1fE/HPP09OL4HiWwwd0QlsRFodYxQznzjCk1Bp0sLXLKy
	FvuMbZz4mfdoZdEKvxKBP7e2XnlkLZjXYJi91f9LiF2HguFg14yYdVWGVXOfd4BoPJuHhkYB8OF
	WbZE=
X-Gm-Gg: ASbGnctufeKhqn0oZQ3CkbROcx4kUTTo53lbIyjzIOkNIqi4kH08H1PjMWsWgoe6R0t
	yBIkbwI5MVvSddQxv/lYIpzQwpF/QIeAKjLhnm45ECa0lKWGKPfjKmeZD3h2KmNL/L9aQ0r0KSE
	I9kPJEnwDS11+HudV4ifcUtmNsuCF2Hys73B8b2RK/MvcQSGRkZaUyXemf7lVznPdXLu7XcwBoQ
	m6Y9yXsKtas/1mTAnbm0yl0u+rS4xdzYleFyhwz9Ox8HGBCCHz5ukbRjJaFbRc5/CMdSK6fj+qV
	4Eza20vT2vlx+fm5dnnqrnBPkbE7jaGqEfs1Sk0NUtki+rEg49WMR+NgVbCJqsnZSUPb
X-Google-Smtp-Source: AGHT+IHtzafs1U3OlDFbdl1EHKhqDpSLv5FVfv0SchkozUHNmBnUPWs9GEdrQlZ8/5oMkLAgq6/HDw==
X-Received: by 2002:a17:907:72d0:b0:ac7:e4b5:4827 with SMTP id a640c23a62f3a-ace5a484e6dmr564732266b.28.1745594327250;
        Fri, 25 Apr 2025 08:18:47 -0700 (PDT)
Received: from [127.0.1.1] ([185.164.142.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e59649fsm151099766b.85.2025.04.25.08.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 08:18:46 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Fri, 25 Apr 2025 17:18:07 +0200
Subject: [PATCH v2 2/5] dt-bindings: usb: cypress,hx3: Add support for all
 variants
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-onboard_usb_dev-v2-2-4a76a474a010@thaumatec.com>
References: <20250425-onboard_usb_dev-v2-0-4a76a474a010@thaumatec.com>
In-Reply-To: <20250425-onboard_usb_dev-v2-0-4a76a474a010@thaumatec.com>
To: Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Benjamin Bara <benjamin.bara@skidata.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

The Cypress HX3 hubs use different default PID value depending
on the variant. Update compatibles list.
Becasuse all hub variants use the same driver data, allow the
dt node to have two compatibles: leftmost which matches the HW
exactly, and the second one as fallback.

Fixes: 1eca51f58a10 ("dt-bindings: usb: Add binding for Cypress HX3 USB 3.0 family")
Cc: stable@vger.kernel.org # 6.6
Cc: stable@vger.kernel.org # Backport of the patch ("dt-bindings: usb: usb-device: relax compatible pattern to a contains") from list: https://lore.kernel.org/linux-usb/20250418-dt-binding-usb-device-compatibles-v2-1-b3029f14e800@cherry.de/
Cc: stable@vger.kernel.org # Backport of the patch in this series fixing product ID in onboard_dev_id_table in drivers/usb/misc/onboard_usb_dev.c driver
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 .../devicetree/bindings/usb/cypress,hx3.yaml          | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/cypress,hx3.yaml b/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
index 1033b7a4b8f953424cc3d31d561992c17f3594b2..d6eac1213228d2acb50ebc959d1ff15134c5a91c 100644
--- a/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
+++ b/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
@@ -14,9 +14,22 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - usb4b4,6504
-      - usb4b4,6506
+    oneOf:
+      - enum:
+          - usb4b4,6504
+          - usb4b4,6506
+      - items:
+          - enum:
+              - usb4b4,6500
+              - usb4b4,6508
+          - const: usb4b4,6504
+      - items:
+          - enum:
+              - usb4b4,6502
+              - usb4b4,6503
+              - usb4b4,6507
+              - usb4b4,650a
+          - const: usb4b4,6506
 
   reg: true
 

-- 
2.43.0


