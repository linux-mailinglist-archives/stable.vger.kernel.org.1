Return-Path: <stable+bounces-163352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F22B0A05B
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 12:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 719747B84C2
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 10:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2ED29B8C2;
	Fri, 18 Jul 2025 10:08:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5567033086;
	Fri, 18 Jul 2025 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752833314; cv=none; b=PGnqNniG1qExjxAJQSdh356YrOLYayXbfnz4H2vH9v7uhEvj4VFdGWF0PAJqTmDpDwlhOFIw5ViapboM8Fx4Z01KT+mSYMEtg2hJMSweutHdSmqIngFUD3uwOrOCoU+/kryCS9RrVBm0ovhX5xztvfPb0wvpcGTMCu6KnacCTQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752833314; c=relaxed/simple;
	bh=8bt3Uu2z/NA/kSlutCPfVE7KQEvACOpvwhlrZ4sAB/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mX2q5S4pD3eXzG+hbMe+L/ubzeWNumrx5906N0a28Zc+qywCLuCA29a97rW3jQJA339ngZRV5RcUnfdLmwE5CIk26QIbXuVFjH1QO10kmBGfcoGeLOlBg0E65L9apg5m2lXEzfMR0J3dKvwZc4i7oRqMIp4v6+rqQX85W0Ygql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [211.71.28.34])
	by APP-03 (Coremail) with SMTP id rQCowAAXrH0QHXpoUwkxBQ--.1396S2;
	Fri, 18 Jul 2025 18:08:26 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: eli.billauer@gmail.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] char: xillybus: Fix error handling in xillybus_init_chrdev()
Date: Fri, 18 Jul 2025 18:08:15 +0800
Message-Id: <20250718100815.3404437-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAXrH0QHXpoUwkxBQ--.1396S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary8Ww1rZw4kur43Wr1xKrg_yoW8Wr18pF
	47W3ZYkrW5Ga1jvw1DXa1kCFW3JanFgrZrur47K3sxZwn8ua4xJFW8GrW8XrWUW3yrK3yU
	tanxAw18JF4xZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Gw1l42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYxhLUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Use cdev_del() instead of direct kobject_put() when cdev_add() fails.
This aligns with standard kernel practice and maintains consistency
within the driver's own error paths.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 8cb5d216ab33 ("char: xillybus: Move class-related functions to new xillybus_class.c")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v3:
- modified the patch description, centralized cdev cleanup through standard API and maintained symmetry with driver's existing error handling;
Changes in v2:
- modified the patch as suggestions to avoid UAF.
---
 drivers/char/xillybus/xillybus_class.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/char/xillybus/xillybus_class.c b/drivers/char/xillybus/xillybus_class.c
index c92a628e389e..e79cf9a0caa4 100644
--- a/drivers/char/xillybus/xillybus_class.c
+++ b/drivers/char/xillybus/xillybus_class.c
@@ -103,8 +103,7 @@ int xillybus_init_chrdev(struct device *dev,
 		      unit->num_nodes);
 	if (rc) {
 		dev_err(dev, "Failed to add cdev.\n");
-		/* kobject_put() is normally done by cdev_del() */
-		kobject_put(&unit->cdev->kobj);
+		cdev_del(unit->cdev);
 		goto unregister_chrdev;
 	}
 
@@ -157,8 +156,6 @@ int xillybus_init_chrdev(struct device *dev,
 		device_destroy(&xillybus_class, MKDEV(unit->major,
 						     i + unit->lowest_minor));
 
-	cdev_del(unit->cdev);
-
 unregister_chrdev:
 	unregister_chrdev_region(MKDEV(unit->major, unit->lowest_minor),
 				 unit->num_nodes);
-- 
2.25.1


