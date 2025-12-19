Return-Path: <stable+bounces-203099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0440CD04E9
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 15:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86DCD30A8945
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 14:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9A2328B6F;
	Fri, 19 Dec 2025 14:33:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8431AF16;
	Fri, 19 Dec 2025 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154839; cv=none; b=qmj+C0M5cHxA3+Z3jUr6DSMCFkjQzfgLJ7wPrtZ32Ge1cctdjDx/iQ1drFSrVmuc7vL/i8m3L9obypi9DuhhZ8lKOVNw9RAnX2+yBNgZeV/V1ysycijegWo35ffb7lsTe3p5gkDDqLitUe5lSu0ADEirat2OpwK+bUZNjbtiaao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154839; c=relaxed/simple;
	bh=q2ij44PqWJGIUgatJ1M16oWIQ7y8gBmei8uwIOGEQ24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jbdIkPnDGreeuajQ3w99VoMALfYEHSIM1tQdQ/CvAg7NLfb4KV3wayhtnlmcBdxQ1eqOHnudlgzkivb6aZe9IHgEc7+srOITGV3Ewqnf+iGBNEgBNAc+zKC79fXBuXj2fVTNocj1/yarzgOdZJoOy14cs6n0XTZ6fQoPGOgZkl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.209])
	by APP-05 (Coremail) with SMTP id zQCowABH3RBJYkVppnMwAQ--.29983S2;
	Fri, 19 Dec 2025 22:33:45 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	tonyj@suse.de,
	kay.sievers@vrfy.org
Cc: linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] enclosure: fix a api misuse in enclosure_register()
Date: Fri, 19 Dec 2025 22:33:43 +0800
Message-Id: <20251219143343.636091-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABH3RBJYkVppnMwAQ--.29983S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFW7CF4UWF18WrW7Wr4DJwb_yoW3tFbE9r
	4jvw4UXr95Kw1Skry3Kw4rZry0yF1DWFWfZw12qrZ3Ja43Zr4DWw1aqr98Jr9rZw4xAr1D
	GFyDWrZ5Cr4agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiDAcBE2lFN+VpTwAAsB

If device_register() fails, put_device() is the correct way to
drop the device reference.

Found by code review.

Fixes: ee959b00c335 ("SCSI: convert struct class_device to struct device")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/misc/enclosure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index ca4c420e4a2f..f7f72856d697 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -149,7 +149,7 @@ enclosure_register(struct device *dev, const char *name, int components,
 
  err:
 	put_device(edev->edev.parent);
-	kfree(edev);
+	put_device(&edev->edev);
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(enclosure_register);
-- 
2.25.1


