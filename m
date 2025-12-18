Return-Path: <stable+bounces-202951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F28CCB104
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 10:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3ABD302D11B
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 09:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0632E9730;
	Thu, 18 Dec 2025 09:06:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2EF2F12CA;
	Thu, 18 Dec 2025 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766048799; cv=none; b=PKDSL6b5nwZuDecrlSlRmsFAVpkkzjqLsILoChikd4uYeg2UtakaTaLHjHMWGN3V0ZaEsGrwgnja6iEi0mbt3MWcqvIQzEN7MxFFjr48x1jgRj9PNIdvVVhQR3LVmpXWcoyYhjexvm58FvV0b1Rh3rnmGD+fZeQ7xwwH+e5yn5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766048799; c=relaxed/simple;
	bh=woOCKuv+cQlcPBn0V3RTneI2dXC56NyhIksfDb1G45w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BhQG4QWtj6OpK7uIhY3mERCWA0i97gcehd2OjgyyMUQB47jeameqUOr8mxJ7fxHAvDICd4jYEn63E81/x9lnMkGRsFs/SbX03ck2NFBh/ul/XQjLnXNhdTfKdJxFdOJeo0Y3LqiECLE0WcxSd7LflsijwgrwONeFr4VsO4bJk/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.209])
	by APP-05 (Coremail) with SMTP id zQCowACnPRESxENpk4kQAQ--.33403S2;
	Thu, 18 Dec 2025 17:06:26 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] clockevents: add a error handling in tick_broadcast_init_sysfs()
Date: Thu, 18 Dec 2025 17:06:25 +0800
Message-Id: <20251218090625.557965-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnPRESxENpk4kQAQ--.33403S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurykCrykCF4kJFWftr1UKFg_yoWfAFX_Gw
	4jvrykXr4IkF9Ik343Cwn5ZFy09rs7KFWfCr1UtF4xGrWUXFWq9r4DXFs8Zr4DuFyjk3s8
	ta4DKrs3Gr13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbhvttUUUU
	U==
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBwsAE2lDlnO8gQAAst

If device_register() fails, call put_device() to drop
the device reference.

Fixes: 501f867064e9 ("clockevents: Provide sysfs interface")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 kernel/time/clockevents.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index a59bc75ab7c5..94e223cf9c74 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -733,8 +733,12 @@ static __init int tick_broadcast_init_sysfs(void)
 {
 	int err = device_register(&tick_bc_dev);
 
-	if (!err)
-		err = device_create_file(&tick_bc_dev, &dev_attr_current_device);
+	if (err) {
+		put_deivce(&tick_bc_dev);
+		return err;
+	}
+
+	err = device_create_file(&tick_bc_dev, &dev_attr_current_device);
 	return err;
 }
 #else
-- 
2.25.1


