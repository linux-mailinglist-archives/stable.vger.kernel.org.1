Return-Path: <stable+bounces-47544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3220F8D1259
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 05:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A671BB21C1B
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 03:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CB9EED6;
	Tue, 28 May 2024 02:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXeGOGxB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4DF17BA2
	for <stable@vger.kernel.org>; Tue, 28 May 2024 02:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716865198; cv=none; b=Ja37ITykGVJt1tFFcB79PSmRqS+rRXNCbAP9jqTojYzESbai/d3XW+luLPcMgaLEsvMROo0+BmcOw6mq6EiFRMOt38jcIzEGY5v5VK7BMHj713KbR9wwe35IFlFCAezKEoZBQCg0D0/MI8E1odJbqR+w77oyUI3OHm1HIx9LjWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716865198; c=relaxed/simple;
	bh=ny8m4xCBhnV/0UIeJvOKqCsXclSGkQHmtW+lTaQqHV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S+xRVm3h4JJEDVXTSYtcVGHnJD2rddh75ZshdWs29qZwx42hR1bxpyLJ3B9H3moNoTCX6r7grDB8K+J2wa8ANRWAXM4Ap9f2znXQNkh2gNUrMIuw6YDBXQ4LKweFAUQSICpZglMTJW0fTYC9FWfkO1YVlu7Xn8G9LHHWOawgLTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXeGOGxB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f8ea3eaa67so5777b3a.2
        for <stable@vger.kernel.org>; Mon, 27 May 2024 19:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716865196; x=1717469996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IdqVzW0uYQzAgGRGuUdCNdfOkC+1NS25yKoubiH4Tn0=;
        b=aXeGOGxB8PKwaYTzjvTZuzbDK6ra2cvrB+SqL1X3/zpsxnj1077k9b6gZnxO1GMP+P
         CT6eHHT7Rgz2J+Ii5Ncx5TGRS8Rzd8a4xio/aNKGgplCQhAngw0YDMUIgqY6CDZ8Cz5A
         dOiCYilL22KH9hbsmfVX7SN3RGtUshxYeJ0rS33UfZfhsh6GbOv+ic/4OqNduILHRwc5
         dkZqJ1aarAl6Dtj1HCeu0V72nWKcUEYr8rty/decLDjIU2c4udCtc9aG9sTmfi90cjYi
         OZdlZtfrkZt3rSL7q2lN9Xz0Gw4fZJymGX9me+bms5NhYUBPbqPthbNyzW/HkdoKXDpQ
         FYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716865196; x=1717469996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdqVzW0uYQzAgGRGuUdCNdfOkC+1NS25yKoubiH4Tn0=;
        b=ORypp4+MdJaeO3YTRCdHWhL8GhqkQvPCSxkWrABrS8a1LVwqTpsn7ebzLNWEM1DWmn
         b9EnsGgx5qUzQsUmbbuQv1oz8mB6A6ZVvVfABb2BtgJUXaQIjLKRu6BqOTFwCH6o0W1L
         kgKgTrXjh3eyKN2mMKFlTp6yTG7rIxMO6Ihh2RicrUbOLlAisyBU7Thbod03N1cNf5ct
         hGVpS9drSGYDUgmycTejReQTLl7SIF4S5Z7xST0gpuc5IJ9cIi4X5wQVxLeGPIxIHXp1
         qnZrjbEgMmU8n3Kry7Oq7J4tKAjTzLFX3V651MtTT0DE9DLAhKPsTR9DolxOLnHHK08c
         G6YA==
X-Gm-Message-State: AOJu0Yz9MeE8yO6ky4tdCjPMKwEk+XnXtNuWaRBEeChRpLSETWNrqrtL
	VolHBe7Kvac8aWrNsGJZNS2SV8XvzWIfNHQ4Lm55YFoCCx4riqI2
X-Google-Smtp-Source: AGHT+IE1EEbClyN4/8JG/iztN9La3f4CKYuWs340HV/+kCEZ3HYh0Js20B0tTpsLGFWZmGnQHQJekg==
X-Received: by 2002:a05:6a00:2e85:b0:6fd:1705:9cb8 with SMTP id d2e1a72fcca58-6fd17059fdemr8154691b3a.1.1716865195829;
        Mon, 27 May 2024 19:59:55 -0700 (PDT)
Received: from localhost.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbeea11sm5666533b3a.98.2024.05.27.19.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 19:59:55 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: ki.chiang65@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH v2 2/2] xhci: Apply broken streams quirk to Etron EJ188 xHCI host
Date: Tue, 28 May 2024 10:59:48 +0800
Message-Id: <20240528025949.13679-1-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in commit 8f873c1ff4ca ("xhci: Blacklist using streams on the
Etron EJ168 controller"), EJ188 have the same issue as EJ168, where Streams
do not work reliable on EJ188. So apply XHCI_BROKEN_STREAMS quirk to EJ188
as well.

Cc: <stable@vger.kernel.org>
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
---
Changes in v2:
- Porting to latest release

 drivers/usb/host/xhci-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index b47d57d80b96..effeec5cf1fa 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -399,6 +399,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
 			pdev->device == PCI_DEVICE_ID_EJ188) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
+		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
 	    pdev->device == 0x0014) {
-- 
2.25.1


