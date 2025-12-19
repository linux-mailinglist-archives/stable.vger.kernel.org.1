Return-Path: <stable+bounces-203105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 43640CD0E5A
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 17:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF2FA3018BD2
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9841C3612D3;
	Fri, 19 Dec 2025 16:29:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4CC33F8C8;
	Fri, 19 Dec 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766161746; cv=none; b=akpKNmPLWZLGUl0ymPSuEYQ8cn7yWqSVniXvAAbN6PORUSDfg7d4WRBA8E96SqyrJW6gBpfbcFYzYLKCUip7w4BFc04K2Bh4k5z1fXg/iBszAB5alX0AJDfRCpHbfwVeCTKd/D/8rN4/ybAF7/5QkbMTXXlJJ5JmFseENquQjjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766161746; c=relaxed/simple;
	bh=LG7/zBNaMxhNgYXA2UtTbwQfgiJEBduc/chRTM9RdMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VhmzidVj9i6U/DuKj+AuY2WI7xh+wAl2LeE5KMS3IUOMl1Ztk3pCSP7jwvLK6Zn8n2jht2oUQU+GJBDRHso29KMhm02xnYB94TGIudP4CVb8Vu5e8Uuok3uUp5YMzYkcYfmtW6VamFsxTCmTNMJdoiYQqxb2bhr3tRxZXgBhekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.209])
	by APP-03 (Coremail) with SMTP id rQCowADnANg_fUVpuy49AQ--.30316S2;
	Sat, 20 Dec 2025 00:28:47 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: perex@perex.cz,
	tiwai@suse.com,
	robert.jarzmik@free.fr,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: ac97: fix a double free in snd_ac97_controller_register()
Date: Sat, 20 Dec 2025 00:28:45 +0800
Message-Id: <20251219162845.657525-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADnANg_fUVpuy49AQ--.30316S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyruw4kCr4UKr13uF4fGrg_yoW8WF4rpF
	48AayxtFW2qrn5Wan7AFn7XFy3Wan7Ka48uF48Ww4xG3ZxXryrA3yUGFy0vF4akF1xGa13
	Ar4UKw18Cr15ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r1j6r
	4UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBwkBE2lFacUrDQAAs6

If ac97_add_adapter() fails, put_device() is the correct way to drop
the device reference. kfree() is not required.
Add kfree() if idr_alloc() fails and in ac97_adapter_release() to do
the cleanup.

Found by code review.

Fixes: 74426fbff66e ("ALSA: ac97: add an ac97 bus")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 sound/ac97/bus.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index f4254703d29f..bb9b795e0226 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -298,6 +298,7 @@ static void ac97_adapter_release(struct device *dev)
 	idr_remove(&ac97_adapter_idr, ac97_ctrl->nr);
 	dev_dbg(&ac97_ctrl->adap, "adapter unregistered by %s\n",
 		dev_name(ac97_ctrl->parent));
+	kfree(ac97_ctrl);
 }
 
 static const struct device_type ac97_adapter_type = {
@@ -319,7 +320,9 @@ static int ac97_add_adapter(struct ac97_controller *ac97_ctrl)
 		ret = device_register(&ac97_ctrl->adap);
 		if (ret)
 			put_device(&ac97_ctrl->adap);
-	}
+	} else
+		kfree(ac97_ctrl);
+
 	if (!ret) {
 		list_add(&ac97_ctrl->controllers, &ac97_controllers);
 		dev_dbg(&ac97_ctrl->adap, "adapter registered by %s\n",
@@ -361,14 +364,11 @@ struct ac97_controller *snd_ac97_controller_register(
 	ret = ac97_add_adapter(ac97_ctrl);
 
 	if (ret)
-		goto err;
+		return ERR_PTR(ret);
 	ac97_bus_reset(ac97_ctrl);
 	ac97_bus_scan(ac97_ctrl);
 
 	return ac97_ctrl;
-err:
-	kfree(ac97_ctrl);
-	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(snd_ac97_controller_register);
 
-- 
2.25.1


