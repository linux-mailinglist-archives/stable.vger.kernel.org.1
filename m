Return-Path: <stable+bounces-124256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5950FA5EF5C
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A8207AD5B1
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A6526388D;
	Thu, 13 Mar 2025 09:16:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88C52641DC;
	Thu, 13 Mar 2025 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857409; cv=none; b=UY/oHPn4ipGPfEk1thiHSZpT7P/s2BSQeZKKmNyskxlPSt5lNzRGsBZ5x1oeOivX/EpYo4A84R94Az4MLr8f30wtCaMYxpsHkVFc9hLrYgwmsevCsLo1NvWaxeiCQxgBHzAHK3SjMf5iJRv+4L9ejWFcIqVboLVfnIRhLBdV3Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857409; c=relaxed/simple;
	bh=GMpKsFQDqRJixl02f5ZFWUqRst3V8NblsC2Avh6Eg8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=He0TUj0rOKlrNFxtFXSfqKv+TKFpR/Dvh1weLYYtWi/rodp4TVSLii0sqqnW2T7l2rjDHmwSwRR8mDjfMGNJpl7E38uq3ZAn5YP8Js00UeFv2canV0RL1gi3UV7ZYNO0HBCyrCvRpLMpgRbZqf+bRBm2qklkF5QoTjAC/dBHDdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowADn7aFaotJn6LGLFA--.36390S2;
	Thu, 13 Mar 2025 17:16:17 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: richard@nod.at,
	chengzhihao1@huawei.com,
	miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	logang@deltatee.com,
	gregkh@linuxfoundation.org
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mtd: fix error handling in uif_init()
Date: Thu, 13 Mar 2025 17:16:09 +0800
Message-Id: <20250313091609.308724-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADn7aFaotJn6LGLFA--.36390S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF13GrWUGF4kurWDCF4fAFb_yoWfWwcE9F
	navwsxWr4rW3Z3Ka1Syw1F9FyI9F4qgFsa9F1Iqws5ta1UZFnrWrsrJrnIyFWUCw47AF1r
	Aa4Ykw48Jr43WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Once cdev_device_add() failed, we should call put_device() to decrement
reference count for cleanup. Or it could cause memory leak.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 493cfaeaa0c9 ("mtd: utilize new cdev_device_add helper function")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/mtd/ubi/build.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index ef6a22f372f9..ca4c54cf9fd4 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -486,6 +486,7 @@ static int uif_init(struct ubi_device *ubi)
 	kill_volumes(ubi);
 	cdev_device_del(&ubi->cdev, &ubi->dev);
 out_unreg:
+	put_device(&ubi->dev);
 	unregister_chrdev_region(ubi->cdev.dev, ubi->vtbl_slots + 1);
 	ubi_err(ubi, "cannot initialize UBI %s, error %d",
 		ubi->ubi_name, err);
-- 
2.25.1


