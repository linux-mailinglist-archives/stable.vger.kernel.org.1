Return-Path: <stable+bounces-109476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78344A160AC
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 08:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2EA11657A6
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 07:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5295E18A6DF;
	Sun, 19 Jan 2025 07:11:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D723C9;
	Sun, 19 Jan 2025 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737270669; cv=none; b=MJf7cF+KiNG0cCvr8ZZzB4m+/zPygHQRAFvzAbm9tYkv8UBmzsnV0gq2OcXwyEhvG8lL8EZO5i5GLKn7wnDHfq6yucqYvY5qKEz3V2ZewwHYe36bVDBGOUXSvGp6kwv3KZ/RYtM1dw/buTBLHiYvMNy/aC8v7oZ88EL6qmFKLgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737270669; c=relaxed/simple;
	bh=sS6epZ/Q0dmr2tgVut1X+sY8gavr366YXLTOVDwcdzM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gDfwxGnZbIL5InoGSZ8EFj0JZlidpQ20rU5CQ5f1f2/0CQ+ymEDnHtW2qQs5VxIYu2LSu2p9ZDGu4CZznlv3Yr9s5mOP4FnN9PFHDR08nOnJaywqpvYs5jOedAhM6BD7iLA+OPs48jpjtLYghSF+dKYqDkegAhHEuezCrS0q7wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowACnr6N8pYxn6tgHCA--.8977S2;
	Sun, 19 Jan 2025 15:10:58 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: jckuo@nvidia.com,
	vkoul@kernel.org,
	kishon@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com
Cc: linux-phy@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 RESEND] phy: Fix error handling in tegra_xusb_port_init
Date: Sun, 19 Jan 2025 15:10:49 +0800
Message-Id: <20250119071049.2279065-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnr6N8pYxn6tgHCA--.8977S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4DKFWkAF15tFW3Aw4fKrg_yoW8XFyDpa
	1DGas8Kr9YgrWkKF4jvF409Fy5GF42k3yrur1rJ34akrn3W348tas8trWxXa4UArZ7uF4U
	ArnxJa4kJFyUC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbCPfPUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

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
Fixes: 53d2a715c240 ("phy: Add Tegra XUSB pad controller support")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- modified the bug description as suggestions.
---
 drivers/phy/tegra/xusb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 79d4814d758d..c89df95aa6ca 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -548,16 +548,16 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
 
 	err = dev_set_name(&port->dev, "%s-%u", name, index);
 	if (err < 0)
-		goto unregister;
+		goto put_device;
 
 	err = device_add(&port->dev);
 	if (err < 0)
-		goto unregister;
+		goto put_device;
 
 	return 0;
 
-unregister:
-	device_unregister(&port->dev);
+put_device:
+	put_device(&port->dev);
 	return err;
 }
 
-- 
2.25.1


