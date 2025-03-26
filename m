Return-Path: <stable+bounces-126758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ABBA71BC7
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E4D1897E83
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8861F872C;
	Wed, 26 Mar 2025 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="keGNTtuP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187381F583D
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006235; cv=none; b=ozcwKk618NIyyKnAtFLJ11NO6BjlfkEk3gXgf+DhqS0sVgft0LQRAJdxdsqLiMtbFCRrz/Yqaf6HPmi+ZppzU9Wf3ODkEd3ROKVyhTO/lWkcn6GcIkNbciK8YMCAEmL/+zoz7KwFUiKDQXMFbtavs1WnD+ez1N10ZzFL9txqTco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006235; c=relaxed/simple;
	bh=qgZT/BBWMA235GCVCrIy5Wv1qr+OiVKxM6mDIVHCULs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XhkcbkdmTac2QjuNVa7FMM/GYLFUnVBdtm8ga9WfndIxTRtjfWe25nTFnEl8znedNbWCDFmI+x2MkWWK5mwWHz8tX7ZhVAkXt9Vq/ZoYWzGmYCyKBICh1qgdsFVd+PMss//ZoMu1ZpLCFsJp3f5Q/TNR5DdfJSUuFRXdU1tQLsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=keGNTtuP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so1489766b.0
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1743006231; x=1743611031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TIHXHkF/8pZLgK+rwXO3tbSWnw+8GWfU/CEp6SLN7PM=;
        b=keGNTtuPrAf1NxIYmURHTRV+BnL5YmifOhs0/pBDY3y/+Wejzb/Hom8xIjlantJVAk
         lfWm46d1GA6MVEa+I2QJhKuuQjKjvYhSWbT9Xo5cYP3K/tc9RSadjLt4d+YwaNmbgoL2
         Q85wMFEscLjrF6sPTj6OCTcakcCwnJYC5jprRURQwDlEPaANPyXBUPyYH/243hodLQUi
         fhAV45pT+mUZyZdJFI1gqFhiW2kd6Dtimihfgaa0b/mpJY5lzfkLKtCD38d08ybZ0sPr
         0iSdl6jmCWr0rcLJ3rMiHZZwFQR2q3V3M+WuBBDGDRin69y9MmG2dXbmN1fyal+MuKgF
         9pZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743006231; x=1743611031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIHXHkF/8pZLgK+rwXO3tbSWnw+8GWfU/CEp6SLN7PM=;
        b=pgkuMd98SE/HOSiZYljGwurn5bB0b5753I1u8YusmZacUzYv4fSldAIDbs1y8tWdby
         Hy5Enj4DJq/4PSn4vVnhEdYT8d9cpPsy535jw7hRem0e6cb0MTWHwviWpuIDtqM0wiU7
         rNAdV1NFlx37VgkwvcrryltQ65sKe1HUqlOxg1KyJceHIcNNKIc9Yuesn5U70qMqQphd
         DK+dNTyhS6OfGFsAEr5K0gVjHyJspHz6KBTtDveyGibaKM0B+gAseelU2PcR5asKwEVC
         7tz5OWaldPuwQRgme5IhVetL+S1yIY4jfpgVRNLIWNAte3mA1QU69Sr+2j3/nAZQ3EHC
         l87A==
X-Forwarded-Encrypted: i=1; AJvYcCWir+zIIDILagqrQ0ZuJLMUErCX2ELIKGOx9WjCt1/Xai523KitthLtcdw/Bot5AslFhJeuUxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+aPxpy/tSQD85tRplt6N9VdbGd6aRxgUKCOyK8viH4Zevro0
	aEby9droRb5lbP4jQrlfj7M0Z0FdU2z/oUqcIfsuBumbEEhECKFY/EWmnAIPAmY=
X-Gm-Gg: ASbGncuf7tUxQ6QoxiWJZS8Prkqx01LoONvCK0GmCiAxAETeuH/EukHOCTgEcBiarYk
	xJT02KK6L/LiFRlaEV5cikJ2Ss+K9+4DdPoulSyKTH157i9CRcFkoLPaQNnVrarl8/97Ae+wZDq
	nPuQ9D1s6nLNIy8a1Y+pN4CmhWINq0mJQkrVBg3l1e8XqIK8jzhwjmRgerx/2UEH3gVQ9Pjynkt
	jXalLsoZUWPzDxWzjChFmqELzfiuyZCmgmEwJ3bm9JcFh6ynA+6ScIyWUOkFh7FpfkJIyvJvJLg
	hoWd/a7gjBZU2RTKra6F/FQwYrYQy0crdEZXRICe7/yqI/0NkPZnw4EAKw==
X-Google-Smtp-Source: AGHT+IGX6YIZqj3EMmg9fstP7Tv4f5XMwVql68RmQX1PGbQYAIwS++PJhhjAX5oAjP1/BAdfxlVIAA==
X-Received: by 2002:a17:907:968b:b0:abf:733f:5c42 with SMTP id a640c23a62f3a-ac6fae5fc76mr5632266b.8.1743006231199;
        Wed, 26 Mar 2025 09:23:51 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac6f0f498ecsm76678866b.135.2025.03.26.09.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 09:23:50 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Wed, 26 Mar 2025 17:22:57 +0100
Subject: [PATCH 2/5] dt-bindings: usb: cypress,hx3: Add support for all
 variants
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-onboard_usb_dev-v1-2-a4b0a5d1b32c@thaumatec.com>
References: <20250326-onboard_usb_dev-v1-0-a4b0a5d1b32c@thaumatec.com>
In-Reply-To: <20250326-onboard_usb_dev-v1-0-a4b0a5d1b32c@thaumatec.com>
To: Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Benjamin Bara <benjamin.bara@skidata.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 quentin.schulz@cherry.de, stable@vger.kernel.org
X-Mailer: b4 0.13.0

The Cypress HX3 hubs use different default PID value depending
on the variant. Update compatibles list.

Fixes: 1eca51f58a10 ("dt-bindings: usb: Add binding for Cypress HX3 USB 3.0 family")
Cc: stable@vger.kernel.org # 6.6
Cc: stable@vger.kernel.org # Backport of the patch in this series fixing product ID in onboard_dev_id_table and onboard_dev_match in drivers/usb/misc/onboard_usb_dev.{c,h} driver
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 Documentation/devicetree/bindings/usb/cypress,hx3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/cypress,hx3.yaml b/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
index 1033b7a4b8f9..f0b93002bd02 100644
--- a/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
+++ b/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
@@ -15,8 +15,14 @@ allOf:
 properties:
   compatible:
     enum:
+      - usb4b4,6500
+      - usb4b4,6502
+      - usb4b4,6503
       - usb4b4,6504
       - usb4b4,6506
+      - usb4b4,6507
+      - usb4b4,6508
+      - usb4b4,650a
 
   reg: true
 

-- 
2.43.0


