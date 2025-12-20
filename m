Return-Path: <stable+bounces-203128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4945CD288E
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 07:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98CB5301462F
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 06:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AC0286897;
	Sat, 20 Dec 2025 06:28:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCDD1DE2B4;
	Sat, 20 Dec 2025 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766212139; cv=none; b=QDKcu168pxVKPQH6CyFdAUnPall82V/jHE3uTAjSPYtwVTPK4iZIruiu9mjZghm0M9683pigO4iwQM0FJwDaS5ED5eS0ll+QAp37awXYEUu1Cs9izOuxIR8twZ0hbLVNeq3r2GAWOn/Dnlijl++xfcybYY6OXMqz1F+47jV3nrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766212139; c=relaxed/simple;
	bh=IlA6304SEvKT21QZ+fG6/Ci5xwu+1N+/74jJm4qoP1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gaWlsOTpC5Abri0t6fWT1aRe3U8GaWTq9Msw0YBF+ZK945eqa93mzgwTwleXKuQNis/0Xc3rq4B9uaTrUSoeNXjdG0xxVm4WB+9i+oDAGIHdUSCj+Veida9B40jgbsZLvzfAD/TGtwB2Y4v9oBzSYxJ03Jv0RvZ+prHFz7n8yZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.209])
	by APP-05 (Coremail) with SMTP id zQCowAC3SQ0VQkZpoWREAQ--.48251S2;
	Sat, 20 Dec 2025 14:28:37 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	kay.sievers@vrfy.org,
	gregkh@suse.de
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] sh: dma-sysfs: add missing put_device() in dma_create_sysfs_files()
Date: Sat, 20 Dec 2025 14:28:36 +0800
Message-Id: <20251220062836.683611-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3SQ0VQkZpoWREAQ--.48251S2
X-Coremail-Antispam: 1UD129KBjvJXoWrurykCry3WF4ftFyDAr1rXrb_yoW8Jr4xpF
	4UJa4Ygry2ga109r4xZanrua45X34xC3y09rW8J345uw4fZrySv34Fqa40gr1UJFZ5CF4I
	qrZxJryrGF4UGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUU
	UU=
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBgoBE2lFaRaBGAACsW

If device_register() fails, call put_device() to drop the device
reference. Also, call device_unregister() if device_create_file()
fails.

Found by code review.

Fixes: dc6876a288cc ("sh: dma - convert sysdev_class to a regular subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 arch/sh/drivers/dma/dma-sysfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/sh/drivers/dma/dma-sysfs.c b/arch/sh/drivers/dma/dma-sysfs.c
index 9f666280d80c..5695fd0a0cd7 100644
--- a/arch/sh/drivers/dma/dma-sysfs.c
+++ b/arch/sh/drivers/dma/dma-sysfs.c
@@ -134,8 +134,10 @@ int dma_create_sysfs_files(struct dma_channel *chan, struct dma_info *info)
 	dev->bus = &dma_subsys;
 
 	ret = device_register(dev);
-	if (ret)
+	if (ret) {
+		put_device(dev);
 		return ret;
+	}
 
 	ret |= device_create_file(dev, &dev_attr_dev_id);
 	ret |= device_create_file(dev, &dev_attr_count);
@@ -145,6 +147,7 @@ int dma_create_sysfs_files(struct dma_channel *chan, struct dma_info *info)
 
 	if (unlikely(ret)) {
 		dev_err(&info->pdev->dev, "Failed creating attrs\n");
+		device_unregister(dev);
 		return ret;
 	}
 
-- 
2.25.1


