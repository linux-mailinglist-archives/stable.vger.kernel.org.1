Return-Path: <stable+bounces-188205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D94AABF2988
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 19:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D22E3441EF
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAB3264A92;
	Mon, 20 Oct 2025 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8OVx+yA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E867E221FB6
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979870; cv=none; b=RN4ikkDPep0sOPFEWCsV7gE5O3+jTPq2uMa+sPUKkoW+VOUuNUYSSlj+MtZbeDEi++1vlxDQ6HYj1qpUFMBJcoggiyvJG6nRMMx8Svks7JU0fVAwUOnsn1HTtcTY9FwYhEpwLJ7MQzx+ihHxNXfhzfS+JkBLUW7ELUohelVq54o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979870; c=relaxed/simple;
	bh=XhOlz3kAPdUF9bGBRZ6c+cMdoaaBjrW9asgz0NHPSdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJiJHreMlqcCElfrOYxEvMzGhDnxWY3Jpd98eX8FAYuF7vzeGGcr65gB8Px0fy+WToLUR7Ti7IFti74U+aar/zHrJZYrNkKapiL13qmIQ5idReBtJHS09HaAXE++QLPLe3NfUrCegqAES9+kGymsHGT5cuAwv4qjv9jdtedZh0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8OVx+yA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-279e2554c8fso43047095ad.2
        for <stable@vger.kernel.org>; Mon, 20 Oct 2025 10:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760979866; x=1761584666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WppCDBBiFkCvhQW1KO9eTwckbkeMfZO3ylMtK0PiG6g=;
        b=G8OVx+yAI+LqWhpefmn+gOMLS2zZ2kUfgNUC4nNTSGFoK1Is1fjMLO7NwWi8kl07GG
         s3FFQRN4ooLJ984Ce7HspZcRk60nH6fQ+MntK0FlJGca2udNwXqnD65iUIof5eohkMw0
         DDx6BsNxIe31ZIouJE8EkzsxYpPmgLhbCyc8tqPksSZRLlHwqDDzTopaitXBkPvjpTAN
         WNGphD9DOsupxb0oIs2U/i6YV9Srk8UfzvzukWz8Sp7eXMuSQ4YlnNo9fneaFEo4kJ+E
         pBJvizHXagrO5SgAmGhBDq6F8dfvSTONzbG3+wAfHy5xNUKQaCiJPN69BLY3a2ILgEs+
         z8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979866; x=1761584666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WppCDBBiFkCvhQW1KO9eTwckbkeMfZO3ylMtK0PiG6g=;
        b=MSdkOxrapsCbLnWPJKEHfLx9GNLxZ1HtS+I+RBOxSujc+3Cpcmataq/EhP3mPUEMmz
         RNHg05CJqYOpJdABvarXbVqqWs65J77zowBG96oSUJrS3NsOsJEb4Sn9kJUIHiyLOkz+
         iupg0+CWklNYNxf7SdtP0IfCzjn3D2Ts+SUYsQ/eswcd4IpXLPNfYsDniBHugyN94tIs
         UeuFLgmQsJQhYElF8c/tlKr6zF9N90cwhw2jx/1awHKSeKQ1VoTJs2YOAYxXiFiYJ42Y
         tGKcIAPwhpt0IvFVFkGINXlJNtmVom84HWWlYv54sxK3hjq+EC5GhFoT5TkFYUzs4rmj
         xFcQ==
X-Gm-Message-State: AOJu0YwXXypOY5NRPx9vBlTrRZ4ItY9ngZk0LlN7TqfoRRAFQ1Dpa8s2
	jaFS9r1mpHHsR+fDGZE0NjBPG5LKhv5c61B0RLnW71Rv1M+0mXELSbG/OVHX2w==
X-Gm-Gg: ASbGnctOB43/8hCdJqj4GuY50bg8r34DS5Z82L6WYplV6Bt3s5gHPWdr5soya/6dB7Q
	+YmqAGSZ7r4gGiwTYgZvVGCrlBNg6AK5SZnBSEb4ciTarFmgpxWhVwoigNFOWVmshEK+EBA0n4m
	xBFL2/iruBkueT6euQiDh07VpQ/IReFpIc6eTwGM4tH84XuY1O4fHTMc2GUR4BGe+A3VPkPj3bm
	0X2WctEOTaNK3VaykcPWSCNrwpQzEMgOyvVUJD8dLVIzzcL+Ao0HYXiey6ov5F5FYDla1JUfyr2
	DVI925ntwo80q193p5ysYeg+wy4U1JwzXh3miLYlVnD3grGiPnXGEMeXxtZBIJotEpot3oDHp5+
	obos/1OeeKuUugJttch1Ju3rhjcEocNwKGs85zWWBduWMmfs3xEF+1HxbyfJ4QJD/bxotrN+xgy
	xlkFyOtRnr0rgm
X-Google-Smtp-Source: AGHT+IFKlxr0ZVQCyE839sOznv/uVVZ8Plq2Fm/8Jbv6NaXL62Z7entHqYnJ1t0Nk/AWzx3U3+ulLQ==
X-Received: by 2002:a17:902:dad0:b0:24c:d0b3:3b20 with SMTP id d9443c01a7336-290ca12180emr179889945ad.37.1760979865873;
        Mon, 20 Oct 2025 10:04:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdcccsm84887255ad.78.2025.10.20.10.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:04:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dmaengine@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Yi Sun <yi.sun@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.12] dmaengine: Add missing cleanup on module unload
Date: Mon, 20 Oct 2025 10:04:22 -0700
Message-ID: <20251020170422.2630360-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upstream commit b7cb9a034305 ("dmaengine: idxd: Fix refcount underflow
on module unload") fixes a refcount underflow by replacing the call to
idxd_cleanup() in the remove function with direct cleanup calls. That works
fine upstream. However, upstream removed support for IOMMU_DEV_FEAT_IOPF,
which is still supported in v6.12.y. The backport of commit b7cb9a034305
into v6.12.y misses the call to disable it. This results in a warning
backtrace when unloading and reloading the module.

WARNING: CPU: 0 PID: 665849 at drivers/pci/ats.c:337 pci_reset_pri+0x4c/0x60
...
RIP: 0010:pci_reset_pri+0xa7/0x130

Add the missing cleanup call to fix the problem.

Fixes: ce81905bec91 ("dmaengine: idxd: Fix refcount underflow on module unload")
Cc: Yi Sun <yi.sun@intel.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
The problem fixed with this patch only affects v6.12.y.

 drivers/dma/idxd/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 74a83203181d..e55136bb525e 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -923,6 +923,8 @@ static void idxd_remove(struct pci_dev *pdev)
 	idxd_cleanup_interrupts(idxd);
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
+	if (device_user_pasid_enabled(idxd))
+		idxd_disable_sva(idxd->pdev);
 	pci_iounmap(pdev, idxd->reg_base);
 	put_device(idxd_confdev(idxd));
 	pci_disable_device(pdev);
-- 
2.45.2


