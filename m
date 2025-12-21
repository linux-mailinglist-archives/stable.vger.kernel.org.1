Return-Path: <stable+bounces-203159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F2FCD3FDD
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 13:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E997300C5CF
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 12:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534FC2F7468;
	Sun, 21 Dec 2025 12:05:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D6C280A5C;
	Sun, 21 Dec 2025 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766318752; cv=none; b=iZ7Bjgw+NVazzDHD+eI4BOGww0YTg/48VPpAtYCGoPRpCegK+/0uDCAvI77CIm3kz0urdjNIF8ZUeeZ/6OkFt88IQjVN4X1Dlc/Nh6rU2c9wkyVnXmGjdNV35p5y4Vg4Yxk2EjoVkdwsbYOMx+ZG+GqroU+yTLYdkQjp4ybSTU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766318752; c=relaxed/simple;
	bh=pnKUMZbOh2TxyJ98yzTQBNp4qK/Sp5UYZ8L+8PZu4o4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O78wxgngZicQ4jSc4ZehRu6g1lfk7CjZORmleqSTGsEl7t2MK1Olz8K6CrclYPWTsLv93HPwytmjjJA3z0pp8M01rOm5WWMri+ShY6LxH4S9FGx7T6pcJP6VWWVmKSCilvZuzKs7krfwNcyNrPD+NORr6FRssMmsEMePObLLaMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.209])
	by APP-05 (Coremail) with SMTP id zQCowADXaAyT4kdpZZ1sAQ--.803S2;
	Sun, 21 Dec 2025 20:05:41 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: mporter@kernel.crashing.org,
	alex.bou9@gmail.com,
	akpm@linux-foundation.org,
	dan.carpenter@linaro.org,
	linux@treblig.org
Cc: linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] rapidio: fix a resource leak when rio_add_device() fails
Date: Sun, 21 Dec 2025 20:05:38 +0800
Message-Id: <20251221120538.947670-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXaAyT4kdpZZ1sAQ--.803S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrWkCw48ZFyrurW3Kr1rZwb_yoW3tFc_Cw
	1xur1DXrsYyF18tr15Grn0vFWS9FnIqrZ5Zr4jqFZ3Gry3WF9F9FyUZr4ktr1UZa1fZF97
	Xay8Wr4rCr47GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiDAYDE2lHoUdQagABsp

If rio_add_device() fails, call rio_free_net() to unregister
the net device registered by rio_add_net().

Fixes: e8de370188d0 ("rapidio: add mport char device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 995cfeca972b..4a804b4ad6f7 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -1789,6 +1789,7 @@ static int rio_mport_add_riodev(struct mport_cdev_priv *priv,
 	err = rio_add_device(rdev);
 	if (err) {
 		put_device(&rdev->dev);
+		rio_free_net(net);
 		return err;
 	}
 
-- 
2.25.1


