Return-Path: <stable+bounces-189762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC628C0A530
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 10:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461A13ADF6D
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 09:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0B02877D9;
	Sun, 26 Oct 2025 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNoXStkk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C3D24DCF9
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761469757; cv=none; b=lCYbh7raQTHoyqY4QAJmtbjMwvsOyChu+JanMRIx4YyjXS6O2Dcb0TbiQiQNL/upUI21eWktU5rQLcySVUFZx0j6sB4SwF78MYKeAeb2oizU+Oi73Mc4lYiQhc+vpnB/Bs+RMqjIbAIJhW1+xhfIi+veNZZW5gukIMXfF26kzYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761469757; c=relaxed/simple;
	bh=rhvUQQ1aDLIgY9l5Xbthj+I3M2mzo0BNAfDOxjdvxS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=owr3ZZWeqTTTCvh0dzVBSyNAC6hRnU0uE2Ti2jHe5c7JtoY2aWRJ8pBvlLO4KJnRwyMpQMEuv8KLDPaI7FVEIUbrnth/lIMIfiS8lcDnSZ5gsVyZE03ILnujE23RwBORkVL6C8JTEXCGJKFETO4iCW3YEhFzc9vTc4QTfnef+2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNoXStkk; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6a225b7e9eso2586694a12.0
        for <stable@vger.kernel.org>; Sun, 26 Oct 2025 02:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761469755; x=1762074555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XDgBxVdEbTdr5iOqBlPvDWxYT4j0U5j6kRWBLPDFwas=;
        b=QNoXStkkgsY4pho1HMXuuLiPrtSIgXcbhdyz+4isjbnNhpi5t9B5RgxKgvbfRYNeVM
         LDsLBzSblXbY/Dsu5nC+ZMubDVj0T7Qb+lGWBDYQ5PI85GTkmMUbDxriWiXzNhXNqgRh
         A5uBA6fRENpD1Mg1zVGCnXnC2lJJzNvFVxFhv7d7TdY5O9pTWhLM94XH0UvmNXSgYk9E
         OYIDgstyJAQTy+ydE+0X5mqTyPad65KYyWdS37oZ6AVLlACSGfXfbjc0qa7a2SB0b4DH
         OFeAz5pCLGs5Yhf72nv/y3A3qFXbEYzCEJiVi0XaBGXnEWIUHPrHburyyAmstanfLOt+
         Ircw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761469755; x=1762074555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDgBxVdEbTdr5iOqBlPvDWxYT4j0U5j6kRWBLPDFwas=;
        b=MC3BnQ1c6H9WbNBBU1nWa5jAfMEAELYoBIjCgcH7eUS5vmvTBr99VJp5NxpafSvcgi
         3RKA0Ig0Qw7ZCDP1Ga93Qv6bAEvP8LTMIJv2/csneBeLPBFf35LBDQ1EF8tNoMapPUYl
         FmnlFyhst79wXBcfwkIfLG3UWlnZZk//isgz6JpXdf46Tbv45SpPQhGELvpOFm+G4ccS
         danei8Z6DMqXBMFEW7QQ+7zWqTXa2P0rEjBa2feMLX2y/9JHp+1UU5s6WgFytyhx2WZn
         vTXBSROwjsjmRtiL5yGwFKNf40jCC7m/ExuizdeGKJHvaxngn+GlYqOIw7Gi6ZzxtsxJ
         J6wA==
X-Forwarded-Encrypted: i=1; AJvYcCXw9tIgATYHko1bFb/+Zcd6bNiqbQePjT0A9SBAee6rPZMmGBAirVD+BLWSSvfSECESbc8SsnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxucO6skn5y+B1oBCpTQq1RpgU4bWBnV0ZCCcwCwjJdJedJ4tyL
	3aWJ+THTroBN1lYkwYlZ+rBPGDBBQI9s/kTDiOQcKPWY9gAH3kDkypgfr9Ly5Ywn3EuplQ==
X-Gm-Gg: ASbGncte5hj+n6U6wdAWIqZRGe/FxCAbYTIVnGeKPWD4RDJqN603XZf9D7VjW63n06N
	k/A2pDNWJEPODqEL7YWqQnSSC0h/zjMW5rtnUL6jHkgjhclTzWVG02kbLRJ3FlOYHzRtP9jmehm
	eaqMOyrpyyUfsF8kfRhuxg/LM1P0ZhneRKedE3vVW0ZZouFPf2RFqhAfe/y8a9ZGe+Pt/47qloh
	/QGFyDyCcDJtgvhPG+lL9DxibIUbDMLJAXY6GnH8nXOpjskGI0u2U1YjVUqduJtmH47cJvDgL4p
	fPVCamzlMlAqSNDLSb/KP1ph5HO15fUhP4Q/75jxLctJpl72UcShqMVDbf3LjxIC/ww+Kc20wik
	LbrmMsH61Th8373jzCgG8bLEAxGHwJ/skWoDdtuTPenoMVvdtIeyFonJ/6DTUrwOAav/DlobkNe
	SfUeb7fY+WbXm2KIoR3kzGTA==
X-Google-Smtp-Source: AGHT+IHoQyB3vduskRb0VU1yRtEZxt+TCgaYNmvXlhRvC3wwf/9MqRK9WnjLi1uyYkvh8yX+068xAw==
X-Received: by 2002:a17:902:d512:b0:290:9ebf:211b with SMTP id d9443c01a7336-2948ba3d94emr87342155ad.40.1761469755256;
        Sun, 26 Oct 2025 02:09:15 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498d230basm45238555ad.46.2025.10.26.02.09.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 02:09:14 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] usb: cdns3: Fix double resource release in cdns3_pci_probe
Date: Sun, 26 Oct 2025 17:08:59 +0800
Message-Id: <20251026090859.33107-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver uses pcim_enable_device() to enable the PCI device,
the device will be automatically disabled on driver detach through
the managed device framework. The manual pci_disable_device() calls
in the error paths are therefore redundant and should be removed.

Found via static anlaysis and this is similar to commit 99ca0b57e49f
("thermal: intel: int340x: processor: Fix warning during module unload").

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/usb/cdns3/cdns3-pci-wrap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
index 3b3b3dc75f35..57f57c24c663 100644
--- a/drivers/usb/cdns3/cdns3-pci-wrap.c
+++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
@@ -98,10 +98,8 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
 		wrap = pci_get_drvdata(func);
 	} else {
 		wrap = kzalloc(sizeof(*wrap), GFP_KERNEL);
-		if (!wrap) {
-			pci_disable_device(pdev);
+		if (!wrap)
 			return -ENOMEM;
-		}
 	}
 
 	res = wrap->dev_res;
@@ -160,7 +158,6 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
 		/* register platform device */
 		wrap->plat_dev = platform_device_register_full(&plat_info);
 		if (IS_ERR(wrap->plat_dev)) {
-			pci_disable_device(pdev);
 			err = PTR_ERR(wrap->plat_dev);
 			kfree(wrap);
 			return err;
-- 
2.39.5 (Apple Git-154)


