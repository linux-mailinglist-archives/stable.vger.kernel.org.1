Return-Path: <stable+bounces-163434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C63C3B0B036
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 15:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6AC1AA4469
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A33D21B905;
	Sat, 19 Jul 2025 13:18:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD5278F4A;
	Sat, 19 Jul 2025 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752931114; cv=none; b=SAwnZOzcFkXf2ub5d5Mfa6yrIPao7YBqOM9SRlE5l9hKgAkET2hYPknuBDKaSEow6Wt0RJYaz4WGVHelSivfrosRavVeBqlkD/8SIpr5VkzwFG72PMymwbryj8YjfUkEubVza2HbPo9WsfvWM/b9ByaMWhD9Ogzd6Ii6+UlEpPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752931114; c=relaxed/simple;
	bh=QIVADv+zCAQp7r0/sAmvKhzMjW5Og9xW3fTb692QlSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kkEdzQDl3As66oDBzZde/LMIzkbrMXZBEaDPNvQN8MrBzRO7TvfNQKmFgEM8pJCyEMKjxCJu5u46NERgL5hmYz4Agi5yrILAlNN6Ubdvc3ZT8Cb/e9zN9lFM7eygfGYLiXQ2N+YTtwtg/5k1IKZDw6I6VawAe6JeMJ844zewjNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [211.71.28.34])
	by APP-01 (Coremail) with SMTP id qwCowADnE6gIm3toLJmCBQ--.46045S2;
	Sat, 19 Jul 2025 21:18:08 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: eli.billauer@gmail.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v4] char: xillybus: Fix error handling in xillybus_init_chrdev()
Date: Sat, 19 Jul 2025 21:17:58 +0800
Message-Id: <20250719131758.3458238-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnE6gIm3toLJmCBQ--.46045S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary8Ww1rZw4kur43Wr1xKrg_yoW8GFWrpF
	ZrW3ZYkrWUGa1jy3Zrtan8uay3Ja9rXr9rur47K3srZw15Wa4xJFWrCFWUJFyDWw4rK3y2
	yanxAF18JF4xZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW5GwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4WlkUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Use cdev_del() instead of direct kobject_put() when cdev_add() fails.
This aligns with standard kernel practice and maintains consistency
within the driver's own error paths.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 8cb5d216ab33 ("char: xillybus: Move class-related functions to new xillybus_class.c")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v4:
- Apologize, due to the long time that has passed since the last v2 version, I was negligent when submitting v3. I have now corrected it;
Changes in v3:
- modified the patch description, centralized cdev cleanup through standard API and maintained symmetry with driver's existing error handling;
Changes in v2:
- modified the patch as suggestions to avoid UAF.
---
 drivers/char/xillybus/xillybus_class.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/xillybus/xillybus_class.c b/drivers/char/xillybus/xillybus_class.c
index c92a628e389e..493bbed918c2 100644
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
 
-- 
2.25.1


