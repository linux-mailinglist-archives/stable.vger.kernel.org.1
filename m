Return-Path: <stable+bounces-106784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297D4A0200B
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 08:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D02D1885074
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 07:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DEE18E02D;
	Mon,  6 Jan 2025 07:47:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790DE442F;
	Mon,  6 Jan 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736149673; cv=none; b=W5hulGQj3ok05CDOYhtE2Rf5B5IA3jvNxdnYHZ/506LHsxigzkGc8EXLDW2+xSyZdG/TDKqlykIj6UOAj4XikKcBHu7T2ALtMBjSFTutShhwhvZKYHNTYP5t3hTZ8WXgpkdiNeO3/aPKM3QrmXPmIDCAt/NlZMRIsMoP6Ql/Lbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736149673; c=relaxed/simple;
	bh=b7JJfoS8gYAXZNa0IbXhoRwlvffIKCfO3JLl8SlcZc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uD7umhe10EsA2BJTVJQ/D9rA2RMU4YKX8Fydk/VP0pukPkg6LW3yPJL0G9nCXZsZZ/mzDRkEXT6mFOog+0UuAl27mJ2jXGFe6fAo6ipjdDk72vQikhu6ZTwYatcfyC9f8lGcGtojJ/n4LCrerHoksD7OCeqN3+3tohs/IahCwfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowAAnkMmgintnbO+bBQ--.7092S2;
	Mon, 06 Jan 2025 15:47:46 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: linux@armlinux.org.uk,
	make24@iscas.ac.cn
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] [ARM] fix reference leak in locomo_init_one_child()
Date: Mon,  6 Jan 2025 15:47:43 +0800
Message-Id: <20250106074743.313384-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnkMmgintnbO+bBQ--.7092S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF13GrWUGF4kuFy3ZF43Jrb_yoWDtFgEyw
	1Iv348ur1rJwsY9r43AF13Zr1I9wn7tFWfWr4xtr1kJ34rWFZIvrsYv3ZYqr1UW3WUCrW3
	JF4jgr4jyw1SkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUhNVkUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Once device_register() failed, we should call put_device() to
decrement reference count for cleanup. Or it could cause memory leak.

device_register() includes device_add(). As comment of device_add()
says, 'if device_add() succeeds, you should call device_del() when you
want to get rid of it. If device_add() has not succeeded, use only
put_device() to drop the reference count'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- modified the patch as suggestions.
---
 arch/arm/common/locomo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 309b74783468..9e48cbb2568e 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -253,6 +253,8 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
 
 	ret = device_register(&dev->dev);
 	if (ret) {
+		put_device(&dev->dev);
+		return ret;
  out:
 		kfree(dev);
 	}
-- 
2.25.1


