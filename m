Return-Path: <stable+bounces-28308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE3387DC23
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 01:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CD12823D1
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 00:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C636D17EF;
	Sun, 17 Mar 2024 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVaAIo3s"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D608D7F6
	for <stable@vger.kernel.org>; Sun, 17 Mar 2024 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710636847; cv=none; b=Ax7mBaQMCljNJ24hxdiLRUKY3I1sKyplRyHWQGB1G0PlIy/Wzd8hee1ZWXonxkMZGiRGnR1n8cFrVo6zrM8hiBbAK3bUvmgbAidm0lrHTRC4cVslZiatgUO4D2Gwsc/1/584q77By8Z7PcaiwaVI4eafTEIFewynmy2sHeyThVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710636847; c=relaxed/simple;
	bh=2D5ryF554R+EWdgTwxojTSL3YVMJ1ywzHcXk1y0zKls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BtHfwW23TZiysIGvTkLcUDc6TNxQGOeimh4qHkpzkynURNBv91VvX0Ln3v0N8h2vVSEPqmhDMEK0Hg2qJlz7mSHPKzD62lPWWCRmmivTlJYyjYmBqu9mqEiOATWFu6fKkr+bIAivtyYsPirrlHC9lsftM6OjrLZ17gQYjpoTCeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVaAIo3s; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-413f1853bf3so20984045e9.0
        for <stable@vger.kernel.org>; Sat, 16 Mar 2024 17:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710636844; x=1711241644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31AYkRN99gvm9LN4MFzuhtm8eZrhDxgIy+xCDzSyhyE=;
        b=AVaAIo3sUOB+v/ahqnHCwjgL6qcUh9x2Um620+9l7TwzR8w3gkL7OAMIOcG3xCiULl
         9bAAmPbPwLq3afCOFOwT64FNRzVzbRt6Yhr20Ke+DjR9J0/EcOUxktDGKSPDg/J8E06P
         1YUF7MNVc1oTUe4V0i1kFt+q3Cc6C2Qu6ClsiVD1t6entu4KdXy2eGnwh7CqeraJeV/C
         iKJncvsvV9x6N/coW0KL2YOqZbg76tWmID9i7f58JcSRAD2vaoNH5lkDV9h5iExZUwU/
         kLAoN3deMHvhcdaImoIvawt1Tt241WvUDCf2KPFxA6T7qsg+MMXKafLWsqld0tt8S1y7
         qiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710636844; x=1711241644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31AYkRN99gvm9LN4MFzuhtm8eZrhDxgIy+xCDzSyhyE=;
        b=LWFT4Ouip9JO7+sB9BZIGo74t6skev7yyo/cAB3/3byp29exCW0aZTsmUpoufnK+ie
         5r42LNVYfrMjl2aV7nT4l5JKgn8fd3bpE+CGFlv7dfHvIDCUgMRuvIkkHnJnYXEcbix8
         jIlxdiSQVcsY9w9vBtCnwQCDc7uJhxH6mRWLtXTyZzsRTzPO7VmZ/b8UCues+iXLECdF
         VNHyRj2DTL2uuejM09+QzcTz0nR0Urw/bDFtJ34xRHX63mDNXbkoog4LQNItGqfscXks
         wX27z5MVt1tCqjU9ygzgE7QhxfWUVJz5dBvJFIQ5Or/g3CHJQvIyt7X14jqJFGPbut63
         uoIw==
X-Gm-Message-State: AOJu0YwYsq/Umc7OyK9u2zB/hemFfPUIDJnSHWCxX/KefSW2IqBRyoMw
	NZZmDFeJglnkRjcut9bm3shSX1ROZTZbPFmRdRkuNkyBthvxzaBxPad6E3m0CC72
X-Google-Smtp-Source: AGHT+IEu7kIYVTWo3CPnLw8Y3yIoezDqRD8c98OxdfMKOb8d7TKUe7be5iQULJ1bG04s0WDDAVn0xw==
X-Received: by 2002:a05:600c:511e:b0:414:1a5:2085 with SMTP id o30-20020a05600c511e00b0041401a52085mr4207860wms.31.1710636844013;
        Sat, 16 Mar 2024 17:54:04 -0700 (PDT)
Received: from localhost.localdomain (77-59-144-113.dclient.hispeed.ch. [77.59.144.113])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600c4f0c00b0041409d4841dsm2049349wmq.33.2024.03.16.17.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 17:54:02 -0700 (PDT)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v0 2/2] mfd: intel-lpss: Introduce QUIRK_CLOCK_DIVIDER_UNITY for XPS 9530
Date: Sun, 17 Mar 2024 01:54:00 +0100
Message-Id: <20240317005400.974432-3-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240317005400.974432-1-alex.vinarskis@gmail.com>
References: <20240317005400.974432-1-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 1d8c51ed2ddcc4161e6496cf14fcd83921c50ec8 upstream.

Some devices (eg. Dell XPS 9530, 2023) due to a firmware bug have a
misconfigured clock divider, which should've been 1:1. This introduces
quirk which conditionally re-configures the clock divider to 1:1.

Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20231221185142.9224-3-alex.vinarskis@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/intel-lpss-pci.c | 5 +++++
 drivers/mfd/intel-lpss.c     | 7 +++++++
 drivers/mfd/intel-lpss.h     | 5 +++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 07713a2f694f..8c00e0c695c5 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -34,6 +34,11 @@ static const struct pci_device_id quirk_ids[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237),
 		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS,
 	},
+	{
+		/* Dell XPS 9530 (2023) */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x51fb, 0x1028, 0x0beb),
+		.driver_data = QUIRK_CLOCK_DIVIDER_UNITY,
+	},
 	{ }
 };
 
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index aafa0da5f8db..2a9018112dfc 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -300,6 +300,7 @@ static int intel_lpss_register_clock_divider(struct intel_lpss *lpss,
 {
 	char name[32];
 	struct clk *tmp = *clk;
+	int ret;
 
 	snprintf(name, sizeof(name), "%s-enable", devname);
 	tmp = clk_register_gate(NULL, name, __clk_get_name(tmp), 0,
@@ -316,6 +317,12 @@ static int intel_lpss_register_clock_divider(struct intel_lpss *lpss,
 		return PTR_ERR(tmp);
 	*clk = tmp;
 
+	if (lpss->info->quirks & QUIRK_CLOCK_DIVIDER_UNITY) {
+		ret = clk_set_rate(tmp, lpss->info->clk_rate);
+		if (ret)
+			return ret;
+	}
+
 	snprintf(name, sizeof(name), "%s-update", devname);
 	tmp = clk_register_gate(NULL, name, __clk_get_name(tmp),
 				CLK_SET_RATE_PARENT, lpss->priv, 31, 0, NULL);
diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
index 2fa9ef916258..6f8f668f4c6f 100644
--- a/drivers/mfd/intel-lpss.h
+++ b/drivers/mfd/intel-lpss.h
@@ -19,6 +19,11 @@
  * Set to ignore resource conflicts with ACPI declared SystemMemory regions.
  */
 #define QUIRK_IGNORE_RESOURCE_CONFLICTS BIT(0)
+/*
+ * Some devices have misconfigured clock divider due to a firmware bug.
+ * Set this to force the clock divider to 1:1 ratio.
+ */
+#define QUIRK_CLOCK_DIVIDER_UNITY		BIT(1)
 
 struct device;
 struct resource;
-- 
2.40.1


