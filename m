Return-Path: <stable+bounces-123138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F3DA5B5F2
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 02:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D590188BF1D
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 01:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9697A1E0B62;
	Tue, 11 Mar 2025 01:40:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5F71DF977;
	Tue, 11 Mar 2025 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741657200; cv=none; b=i3ysf2XZoey7y8FLyHexHDqsrwNRN2qF/H1RlhI/uCVcOEkO2nrP1uMmXtVIsCLTfF1cOW7rB/UEWHZMc52Ho2Olf2BitkU8EaXKOuQtopK+JDar6etFnrWr9DEJet4aCg+zvUvM9gr7mpmmeX7t8EezV2eNSOMVx8dq7JjAmQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741657200; c=relaxed/simple;
	bh=vhZIzTDN0OSeiT0046Ezc3Do+jQB3FRS93pF8EYxZIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DgQwFUDLsanu3t08d98FCH9Gn9ZIiIhhc4WJm46AJuEspvn4TxK0qG6fvqzFu3KjXt/66V48CH2JVqcuWGU3r5WxcqrPzceqYLxUJummXLMZV59Eyix0ejSRavoAnW5xKSjohn+LxWMPPoDMsAkkQSktAba5FRAjSb534sS9yl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowABHsMlZlM9nXH7HEw--.388S2;
	Tue, 11 Mar 2025 09:39:45 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: eli.billauer@gmail.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] char: xillybus: Fix error handling in xillybus_init_chrdev()
Date: Tue, 11 Mar 2025 09:39:35 +0800
Message-Id: <20250311013935.219615-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHsMlZlM9nXH7HEw--.388S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKr4ktr47JrWfJF4kKry8Krg_yoW8JF1UpF
	47W3WrKrW5Ja1jyr1DJa1DGFW3JayqvF9rur47K3sxZw15u3W8JFWrCrWUJFyDX3yrKay5
	AFsxA3Z5JryxZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
	evJa73UjIFyTuYvjfUY3kuUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

After cdev_alloc() succeed and cdev_add() failed, call cdev_del() to
remove unit->cdev from the system properly.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 8cb5d216ab33 ("char: xillybus: Move class-related functions to new xillybus_class.c")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- modified the patch as suggestions to avoid UAF.
---
 drivers/char/xillybus/xillybus_class.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/xillybus/xillybus_class.c b/drivers/char/xillybus/xillybus_class.c
index c92a628e389e..356af6551b0d 100644
--- a/drivers/char/xillybus/xillybus_class.c
+++ b/drivers/char/xillybus/xillybus_class.c
@@ -104,8 +104,7 @@ int xillybus_init_chrdev(struct device *dev,
 	if (rc) {
 		dev_err(dev, "Failed to add cdev.\n");
 		/* kobject_put() is normally done by cdev_del() */
-		kobject_put(&unit->cdev->kobj);
-		goto unregister_chrdev;
+		goto err_cdev;
 	}
 
 	for (i = 0; i < num_nodes; i++) {
@@ -157,6 +156,7 @@ int xillybus_init_chrdev(struct device *dev,
 		device_destroy(&xillybus_class, MKDEV(unit->major,
 						     i + unit->lowest_minor));
 
+err_cdev:
 	cdev_del(unit->cdev);
 
 unregister_chrdev:
-- 
2.25.1


