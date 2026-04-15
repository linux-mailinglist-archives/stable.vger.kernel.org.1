Return-Path: <stable+bounces-238170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MNODgbK32nVYwAAu9opvQ
	(envelope-from <stable+bounces-238170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:25:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C91406C6E
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E650D3248A1E
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 17:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902BA3E63A5;
	Wed, 15 Apr 2026 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3DiXkGL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4E33E5581
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272729; cv=none; b=fa8hb0RJEQacaFu3vqGrVQsD9tE2JCEMWByd+GQnHE5MadFZbk3zo11nmPIqYVDRHilQfkujZhbordLXj3bsRhcYLS12OVIYaTq/WJbOX9TPLNthcn0DKf1LAvH4V8vRmMtKqPUX+vVIh2xOioCJimM8qPQMEXdYAvOCwrgY6/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272729; c=relaxed/simple;
	bh=1Zn3MdRMyjWLIyrQcNN+35GVvqWTDtyPLOv6jmk0AwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RAqMEEMcfgN1exNbfK+jMq19PXOz+dnm/gmRgR6IaZSyxAzb/xfJaamKbX8dxGPvoKDW5psmp2HUDnNcvGwnbFXXae/61OPJbB/x92X5pzmrcdaCukhZ0Q5AeTjgSUyvv+HtRhJshPPnsVHdyJ84qVzvdqgvJip2A3u5rrLJz0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3DiXkGL; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82f0884bcfaso4191463b3a.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776272726; x=1776877526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=veen0Vc8lnvEHEqHsNTL0m1ag5OPOf79GJ5X3Fcd3Ls=;
        b=m3DiXkGLSr6L5u3CBK3ogoVclqgKduUsQqIqGcYjV7dsAhteqnrPdqe828tv5JfRnw
         S/yVa7m3Xfel32YuvAsYHrYCcZ8dLuZHnCzCdWbX63UMT4p7yt9P1ugnrAkB3Ae6GthE
         FjHIpYFj+K8kQSCnD6yrZRZnIFBfVkUowqI2rXQMCX5+5PaMAduyURwYm2VsN/FbXOLa
         9NArOJxH5aDzffWGKGdHWjkoPm7CpcFdXzv176PUWN6DsyfKJE4LsvhSzAhqSaUXrXLG
         5jpxjJzmEXL/B5xcSWpp4nj1IU/paFK/Zr3csa2fsyq3O6J8v4/LIcDx+oyOr3LLPKXJ
         O7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776272726; x=1776877526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veen0Vc8lnvEHEqHsNTL0m1ag5OPOf79GJ5X3Fcd3Ls=;
        b=olhpJIDr7JrRgVlk3cPzuulPlcswVi+YNKHDiD0XgUS2qxmvHt8CNrS1TAsnI2YaKq
         4PvKVDheYtphI3VUaYsZ1ozofl6lkDRv/i2lmf85HUHVGPr8gM3GaGA5mnNte3JxiN3+
         Duf9RwqYTdx26uFpimDtari8IyjQpw6HGVMbqRV2u6qx3BytppbgIcM4nRLVYgyvaN7g
         uJrTbjQkqB7EegqcuIv7nXABLgFbT/UrdvODpaPKu3fJw0QTk2Vipc9BSSv8AU+/Ped/
         LS4K4yQsVVF4fLnnOgTcv7jWRiHG6lOU03tMZ50RehzBn+VfktdHM6qCbvAcAEgpVa57
         OtxA==
X-Forwarded-Encrypted: i=1; AFNElJ9JKRbb12d2uCdArU7/wOlIiaxniZCEcGVvLDc47EfS5uECPIUNevmYmjfv9kz5rPkzxD1hBuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+5VoEBi1jYam+meEPQSnELFXLTt86Xuf+MJvHAKn4D12rbKgt
	ywADHzKqO2EpKYx9gJ1//7wcgpIlKhytRfkkRFVtfn1Tvd0TX3Q3Ogdt
X-Gm-Gg: AeBDievdSL1OMNQKbZdm3Br61PTRW1JRC0isblN1+Qlmt05LYmTAHWRgtukyV/cwIg9
	dxZj9Ns13IdHgjDs4Y+WZaBE1+X0YrwIc5ZpFDiZgDL1zMoFxo7qqO0YMnwI+qjIclfHfSKTcR9
	+6S4s7BKIhpNOR+zP0x7F+SpOEbBoXO1hyPo2Tq935yqxaEstPeqOpYyANQm+rRoi+dkuQsloPW
	1cP7VlIW7HIEhSVpY8Bov70yspMtG3l9ETWw9zjxZ1a7DJwJBtEiv/wuRnu26aKbuxxmI+MnB4K
	Xl5gF+Et5UTxSaXTC9olYdstAMC8oVIIDdhBKqdX2yRDrxGqRO7sAwi66bcbylvOt65gOOGqBNa
	+4ooyzKUfzUHsjn63w1Uv16MEmmE9mSmNxDjnTVC+wqljf7jgO2XJCRzfQhtpwnsYcIP8SrNB3r
	Uv+el7r35dCxASQTivB0P0tLFWeb6Z0rIFPmj7
X-Received: by 2002:a05:6a00:8c83:b0:82f:1b50:d2f2 with SMTP id d2e1a72fcca58-82f1b50e2d6mr13938223b3a.18.1776272726443;
        Wed, 15 Apr 2026 10:05:26 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:48dd:8f21:beaa:cec8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6f52d45asm1522337b3a.38.2026.04.15.10.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:05:25 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] parisc: led: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 01:05:15 +0800
Message-ID: <20260415170515.3605095-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238170-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[HansenPartnership.com,gmx.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9C91406C6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in startup_leds(), the embedded
struct device in platform_leds has already been initialized by
device_initialize(), but the failure path only reports the error and
does not drop the device reference for the current platform device:

  startup_leds()
    -> platform_device_register(&platform_leds)
       -> device_initialize(&platform_leds.dev)
       -> setup_pdev_dma_masks(&platform_leds)
       -> platform_device_add(&platform_leds)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() after reporting the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 789e527adfc33 ("parisc: led: Rewrite LED/LCD driver to utilizize Linux LED subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/parisc/led.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/parisc/led.c b/drivers/parisc/led.c
index 016c9d5a60a8..b299fcc48b08 100644
--- a/drivers/parisc/led.c
+++ b/drivers/parisc/led.c
@@ -543,8 +543,10 @@ static void __init register_led_regions(void)
 
 static int __init startup_leds(void)
 {
-	if (platform_device_register(&platform_leds))
-                printk(KERN_INFO "LED: failed to register LEDs\n");
+	if (platform_device_register(&platform_leds)) {
+		pr_info("LED: failed to register LEDs\n");
+		platform_device_put(&platform_leds);
+	}
 	register_led_regions();
 	return 0;
 }
-- 
2.43.0


