Return-Path: <stable+bounces-114281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5093DA2CA60
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 18:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752E9188C118
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 17:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CD7199E8D;
	Fri,  7 Feb 2025 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P03ueTAX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8589618E050
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949835; cv=none; b=m0z34SCcTE2MN5TyctDcT2B1zJAeMxA909LlldJxv/tlja/E//tcAzTfXgPrKA6hLREnKZca3JFYpkLTlFdJCeDRTMeqqqHi+JmLnZmz7gnwDQnlDDSGYXFln190F+4NVZxheUon/kcVOk42JSSKuiJlhlCt3IW9FqSGoXtBx2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949835; c=relaxed/simple;
	bh=pMdTess4TRAATyX2BahQW7BJvIhGqjveohgUTTwQtSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diS6VzGoW+FNtIbxwpp4Yse+svE2BIMFodgEq+tY6xcZns0nNVkOR6PBp9P5MoyN202+t0WqvY3DZ+ygn0X2H94CGPmJEQRpz75BuhIW9h3wbSyAJvJiwntIj/C2vxdQpWn7afGazGGLFXPcDQ4Q/EPoofzVN5XjeTtutNhYIrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P03ueTAX; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-21f0444b478so35925865ad.0
        for <stable@vger.kernel.org>; Fri, 07 Feb 2025 09:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738949832; x=1739554632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYKPz6+rK/kBpPklWnLU1B/21mrV2hkctGkFVKJCJHE=;
        b=P03ueTAXdL528i9TMMq4IjApoj0e+n5GGLXmDIYfQR/T/nBVJI1zi1kA1yMH5LcgVA
         kgwbyX4M0FEz2TDkP1M9TneCFcAjEn7BVgwGQjJ1CjzG3BXumk/Verepjmw9DtLZ2HK7
         1phXJ7YafCdcfke49xWXWS/WUFdcBopOCMmh27/+9KyCzV3OP+Eo4Q4sG5zXhNIrLwKS
         uaHwO/gKcnTJgQMz0V/7bJ7ELKuSQEvfjD8MwbpwqLtstHTOJ2w1wuPijKzP8Z8/mUzq
         RoXLouPw9zf+PsmmdGl5Vc9NUcUGQQIAab+jQ94oEDbuBwLkhi1ZJBauuTXJOu/HohoS
         Rm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949832; x=1739554632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYKPz6+rK/kBpPklWnLU1B/21mrV2hkctGkFVKJCJHE=;
        b=wco+LztB+kpYjHX4/K8YTK0njbg2TBJ0NM/H5wA16NwTl5bpz7eujsFB9xOwc8tfPE
         Mg0f2GrrBlY8RIkfFJ2gO2fDj5dzUrTNP0lrEL2SQxm7elnoV5orCGf8on/lp02+5ezs
         Itp7FIb6jMxOxqL9qB9ml863Cq44xUQbYQ0EOnUS4ZlKLqn/EvZ26i9ue2US/iE+P/hM
         KdU3Mvp4Zf8+NxkPQl1CBl1gfkxvOoe2tcjislup/XNOxMwSMsP4nygmxDvUX3WNUcFX
         S1EQb5Q635NJGZiQ2a5e4Z1Wh5PUCr6NJgAtyT8NB9LBQzR7gndWHsy/Iom4zU8+35md
         Rqng==
X-Gm-Message-State: AOJu0YyOF5242YUOPb6UBcpGS5Ki/J5b6aXkwOpOXZaIfEANuTUKdLR7
	4ub+r5y+SVnqJszTo0SmGPARYgqay28stZZ2/0fSCe1s/xL1uz2/GHFY/fpPhQ==
X-Gm-Gg: ASbGncsKAu/bm3UdmP6I2AUsNG+YSH67W30uzV9eGYJVIq3Gpm7KXFusIxzflPZ0O+p
	PPbqev7/0CMfHrR+sASS8iYPhQEKAiAx7fa+UKsAnnHj02DYAyHNyKETG7rqL57HoMVKpdkqGmi
	JYDnDD6yEtFneIKzHW4sGVKy8WFdXDaeBJFPTu1ewJnDDDoKLHM/uJ3iZ5ZsdHTE8771FCKQ0jI
	UPPtwR2uZBZDy+O7Ft8RJ/BcikMG4j4Eg2Rm6+OaYlUXxmP7ce6MMien4HO0wqww6SIuOOPajld
	LPKJrsQo0RUPwcCTrTyF/SkNMQ0YSKfe
X-Google-Smtp-Source: AGHT+IHg3YiliAv8aS/C5Yh4st92UnrCJ1nD9MvCus6gKNYw8HmN4RiuwcwjP/ltfhvz/qSU6zb92w==
X-Received: by 2002:a17:902:db0b:b0:21f:169d:9f39 with SMTP id d9443c01a7336-21f4e779cc3mr75321575ad.46.1738949832537;
        Fri, 07 Feb 2025 09:37:12 -0800 (PST)
Received: from kotori-linux-laptop.lan ([116.232.67.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683dbaasm33134055ad.144.2025.02.07.09.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:37:12 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: stable@vger.kernel.org
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.1 5.15 5.10 5.4 1/3] PCI: add ASIX AX99100 ids to pci_ids.h
Date: Sat,  8 Feb 2025 01:36:57 +0800
Message-ID: <20250207173659.579555-2-tomitamoeko@gmail.com>
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

[ Upstream commit 3029ad91335353a70feb42acd24d580d70ab258b ]

Move PCI Vendor and Device ID of ASIX AX99100 PCIe to Multi I/O
Controller to pci_ids.h for its serial and parallel port driver
support in subsequent patches.

[Moeko: Rename from "can: ems_pci: move ASIX AX99100 ids to pci_ids.h"]
[Moeko: Drop changes in drivers/net/can/sja1000/ems_pci.c]

Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Link: https://lore.kernel.org/r/20230724083933.3173513-3-jiaqing.zhao@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 include/linux/pci_ids.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 69b8c46a42ea..9d7fb137bd93 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1754,6 +1754,10 @@
 #define PCI_SUBDEVICE_ID_AT_2700FX	0x2701
 #define PCI_SUBDEVICE_ID_AT_2701FX	0x2703
 
+#define PCI_VENDOR_ID_ASIX		0x125b
+#define PCI_DEVICE_ID_ASIX_AX99100	0x9100
+#define PCI_DEVICE_ID_ASIX_AX99100_LB	0x9110
+
 #define PCI_VENDOR_ID_ESS		0x125d
 #define PCI_DEVICE_ID_ESS_ESS1968	0x1968
 #define PCI_DEVICE_ID_ESS_ESS1978	0x1978
-- 
2.47.2


