Return-Path: <stable+bounces-114282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39231A2CA61
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 18:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76660188C656
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 17:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749AF19C578;
	Fri,  7 Feb 2025 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijpybkwu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E0B1957E2
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949838; cv=none; b=oFVKo58OnLj216rdlIQVmFEDmQHzPhTJ+QcQIgmyf/wNTJWtaa1PvF+Hwh2dobWUNPS4y0OeYtC0QEw4pWMD9pOyioigyzBK6i+3lvSJbTLUVh2mx+0A2nRZJ7CybIfbhmFanQFWkzA2PA4UydVf4VAQrfGDzKk4FUXIEh6hNEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949838; c=relaxed/simple;
	bh=ItXGnaWx1lP5PTo1KUXWgJOjGbnNnPo/OVIa4e7wOqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+3U56ptaFRZHBG0n+iaANQelL2QVSwFumXk0ohTS0UQDHHCgs6c6t2nTW8RE5C9LkQ3AEv0U9DHxEUpQ1IDaJ07yuIdAlvM0dv+2fNOGfdoc5EGo+bsPJ0PR8uSJyAA4axnJ28EzckWLYlr32d2Z4JWrVUS7wkLuu1fkbb5NgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijpybkwu; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2166360285dso43071045ad.1
        for <stable@vger.kernel.org>; Fri, 07 Feb 2025 09:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738949835; x=1739554635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZH3zGJsZtnCvGxHODl8zvhem1ucNnB+SB7x8P30MrWc=;
        b=ijpybkwugappM9ZCPh0N5lTQ8bLY5GT2GPttQg2iE7KKBRX5eRqbaShY+wQoEO/2k0
         tMRLC0PO4lj+SBUYAL6+/sZfJF+VpCvSJ1a5J9eqaPjz7KNDhRWJeCrNgH08DMd2E4DY
         Cv4DPmnRLd47KjPmz/uY+BzLc8dQecxSfHcoEV88uhW7pXnUeeJs5HgwGelP/NY8fg3C
         UfkTmrWErSBAvuVJ72Kcgi+zbgK/HyeqXk8MahKaus7EXm7uFBBfDYwMhv6iC8WDxKoP
         fLE00tuDB86L1OFSgOg7gSyLyaihbyy87ETVmsFkQozSMZfN9DGkEsmtzHaykXgQNb7I
         Jo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949835; x=1739554635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZH3zGJsZtnCvGxHODl8zvhem1ucNnB+SB7x8P30MrWc=;
        b=KmY5uOhmu9l551XtB04ug1z7ZeqhwlZAFktTa/anjwSFuiIQI0ka4j/iA4gPb5WduI
         DF4xHJ07hoqtjRvrlbN3zDEk7Wu4Kl9fL+pttBFqxXaZHKtjj5luPXyRhqSLFBiDK47f
         ztFU3Z/XuDGdGArsIsxy2QFWYZKrgD1k+B5rG7v8YtU8gtVAGVJqlOShXMYrBheJybVZ
         MmaDhGQmWGFrd5zH5XKfCnJBFFhQ3JkCKCplGJhLaqgUJZf2lObXJlLVG/caHvwkd1ot
         KJVPYNO8b+kRm7CKuYDjvOqDy4mS4/fWp15skI5/T+vNOv3B5pbfDWP14wdGAlV2VXig
         wkkQ==
X-Gm-Message-State: AOJu0YxtX/hYCoBRyxsbxCipKlox49/3nnAYBqRQ8hQVPTJy1BUa270T
	xp1lNA6ovmck6kX9UBH2ashzg8KqEdaHNm/uqWYuW5ETaV+P6Wq5bUsepVeQfQ==
X-Gm-Gg: ASbGncuLRrMqOkCl++XgwoAgbp8kA9+g3Ig9EKsa14oL7kFgzlgdULImktoPMjNe3fv
	VY6SJjQLCJgev+mxp8VKp+HUnHX+gZbNNw6rbCmnUjL1Bod+Eub06EzJ9UAicXd0m5Fyrfez5PP
	vDr4LJH6Mz17YNUDaALSbDtzWFd1Y1XHR7eTIibghvQcMoJB3pZIvbqqPmZ6vgYz1cLNIMPEiiI
	wJ56WmBCu33fTjwS+uVvf+j8lydyEXKoPjN8QJtydJcA2YHVhZ3a82VHh4pdxEeufFsNpsw7sJ6
	dNbScUvvUyNpay/oLBXDYBMniE1XFXsm
X-Google-Smtp-Source: AGHT+IFR94Hjjm7CF0lIgUKpwUcWitIz+G9uquuQVqBDUIZ0+70zoBL1Fx9jgGVAY5ae4H0+CCa2Cg==
X-Received: by 2002:a17:903:1c8:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-21f4e6fd43amr55715815ad.23.1738949835435;
        Fri, 07 Feb 2025 09:37:15 -0800 (PST)
Received: from kotori-linux-laptop.lan ([116.232.67.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683dbaasm33134055ad.144.2025.02.07.09.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:37:15 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: stable@vger.kernel.org
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH 6.1 5.15 5.10 5.4 2/3] serial: 8250_pci: add support for ASIX AX99100
Date: Sat,  8 Feb 2025 01:36:58 +0800
Message-ID: <20250207173659.579555-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250207173659.579555-1-tomitamoeko@gmail.com>
References: <20250207173659.579555-1-tomitamoeko@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 0b32216557ce3b2a468d1282d99b428bf72ff532 ]

Each of the 4 PCI functions on ASIX AX99100 PCIe to Multi I/O
Controller can be configured as a single-port serial port controller.
The subvendor id is 0x1000 when configured as serial port and MSI
interrupts are supported.

Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230724083933.3173513-4-jiaqing.zhao@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 drivers/tty/serial/8250/8250_pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 38fb7126ab0e..6026cc50a7ea 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -66,6 +66,8 @@ static const struct pci_device_id pci_use_msi[] = {
 			 0xA000, 0x1000) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9922,
 			 0xA000, 0x1000) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100,
+			 0xA000, 0x1000) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL,
 			 PCI_ANY_ID, PCI_ANY_ID) },
 	{ }
@@ -5890,6 +5892,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
 		0xA000, 0x3004,
 		0, 0, pbn_b0_bt_4_115200 },
+
+	/*
+	 * ASIX AX99100 PCIe to Multi I/O Controller
+	 */
+	{	PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100,
+		0xA000, 0x1000,
+		0, 0, pbn_b0_1_115200 },
+
 	/* Intel CE4100 */
 	{	PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CE4100_UART,
 		PCI_ANY_ID,  PCI_ANY_ID, 0, 0,
-- 
2.47.2


