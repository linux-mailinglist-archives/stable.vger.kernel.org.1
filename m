Return-Path: <stable+bounces-192300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C16C2EE88
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 03:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCEC1893A11
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 02:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A146D1D7995;
	Tue,  4 Nov 2025 02:01:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A2D515;
	Tue,  4 Nov 2025 02:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762221718; cv=none; b=ShIb3Wv7yjb23f3krvolZ5L4UkKQ+LFpkOlMJ3SEAGGdfmhfC25UQGoKjp9LpMOo6P7Gu22CkTHRrK/w0b3coGugQLtlxiexKb5XgHPTpqKE+7Djrwe1HZyhX0yGc++vH8grimmk/QZJPbFLWXk1hxVtNQcLNUqMkWOGbTER/mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762221718; c=relaxed/simple;
	bh=GhfGJY/c2fpp5GNxD/8wpOQ3b7/KtTzQPcOtoJAgAL0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=d+HJTJsIuZ4NhHJXQ+RcFA76O/7nFrebefKIZzlxC1hHSqUZyAaqQQjvD5nZ0iXhZQH3a4MJJUoDTT09TgW6MRL9O6NzvAOJMTQLpqEYJmDyIUX5fHH/xrdzyL8IyKqxYsdaM4nOhy1iOa66BE0nGud9QFBoew+lbaAVCjPX3u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowACnI+t_XglpplVZAQ--.27197S2;
	Tue, 04 Nov 2025 10:01:47 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: alexander.usyskin@intel.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mei: Fix error handling in mei_register
Date: Tue,  4 Nov 2025 10:01:33 +0800
Message-Id: <20251104020133.5017-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowACnI+t_XglpplVZAQ--.27197S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrWxZrWfJr1DJFWDZryUGFg_yoWkArX_Ga
	nY9r9rWr4kGrWIkr1Yyr4fZFWS9FsF9FWfJr17tFZ5t3yxZrZrur1DZwnxtr1Uur47Cr15
	AFyUXrWSkw1UujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUkHUDUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

mei_register() fails to release the device reference in error paths
after device_initialize(). During normal device registration, the
reference is properly handled through mei_deregister() which calls
device_destroy(). However, in error handling paths (such as cdev_alloc
failure, cdev_add failure, etc.), missing put_device() calls cause
reference count leaks, preventing the device's release function
(mei_device_release) from being called and resulting in memory leaks
of mei_device.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 7704e6be4ed2 ("mei: hook mei_device on class device")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/misc/mei/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 86a73684a373..6f26d5160788 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -1307,6 +1307,7 @@ int mei_register(struct mei_device *dev, struct device *parent)
 err_del_cdev:
 	cdev_del(dev->cdev);
 err:
+	put_device(&dev->dev);
 	mei_minor_free(minor);
 	return ret;
 }
-- 
2.17.1


