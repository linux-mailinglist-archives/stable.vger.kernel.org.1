Return-Path: <stable+bounces-192180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034F5C2B107
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 11:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713991891C1E
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 10:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EC52FDC5E;
	Mon,  3 Nov 2025 10:31:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69862472BB;
	Mon,  3 Nov 2025 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165875; cv=none; b=Cs9McvcvCYuqQsWIWikd+TznoToP0pPrn509MUEvule1TiJQkEmaNeqnq6Z5N0RGUEHm7Cvx8ki1T+fpxJiLxws6c46i0mTnB4fAwLFmjwIdN2l07wTP2gay0hJ47146i6qmbSdjrYCd4oRVe6GJY6DcyRziGn7OOGoPeFyWW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165875; c=relaxed/simple;
	bh=A4ul1pOCUy+LD5Ggv7iouIcDKNOUs/YcNgWoa4KtQY0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NHRsRCQfTW4H6rjNqGFsX6Ge6s4aUYBuCWmB9ycI/QP3CBXpONIaoCHtdIHdTtGm9xxu8BuvOLGoPw6zWbQKy5yxRJQ9r1tWfZcFaGKeDHIP+wp0NUvijwXUcO3PEOaeKI1IEqixw46oX5J/X9hsC9EMyxvhZKR51tDRe2bViHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowAC3M+tQhAhpF5U3AQ--.23416S2;
	Mon, 03 Nov 2025 18:30:55 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: jckuo@nvidia.com,
	vkoul@kernel.org,
	kishon@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	mchehab@kernel.org,
	wentong.wu@intel.com,
	sakari.ailus@linux.intel.com
Cc: linux-phy@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] phy: Fix error handling in tegra_xusb_pad_init
Date: Mon,  3 Nov 2025 18:30:38 +0800
Message-Id: <20251103103038.8193-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowAC3M+tQhAhpF5U3AQ--.23416S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4DKFWkAF15tFW3Aw4fKrg_yoW8Xr18p3
	WDGa4Ykr9Ygrs5Kr4rXF40vFyUGF42k3yrur1rJ34a9rs3u34rKa90qrWxXa4UArZ2kF4U
	JrsxJaykWFyUu3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

If device_add() fails, do not use device_unregister() for error
handling. device_unregister() consists two functions: device_del() and
put_device(). device_unregister() should only be called after
device_add() succeeded because device_del() undoes what device_add()
does if successful. Change device_unregister() to put_device() call
before returning from the function.

As comment of device_add() says, 'if device_add() succeeds, you should
call device_del() when you want to get rid of it. If device_add() has
not succeeded, use only put_device() to drop the reference count'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 78876f71b3e9 ("media: pci: intel: ivsc: Add ACE submodule")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/phy/tegra/xusb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index c89df95aa6ca..d89493d68699 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -171,16 +171,16 @@ int tegra_xusb_pad_init(struct tegra_xusb_pad *pad,
 
 	err = dev_set_name(&pad->dev, "%s", pad->soc->name);
 	if (err < 0)
-		goto unregister;
+		goto put_device;
 
 	err = device_add(&pad->dev);
 	if (err < 0)
-		goto unregister;
+		goto put_device;
 
 	return 0;
 
-unregister:
-	device_unregister(&pad->dev);
+put_device:
+	put_device(&pad->dev);
 	return err;
 }
 
-- 
2.17.1


