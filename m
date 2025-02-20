Return-Path: <stable+bounces-118439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5552AA3DB6C
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 14:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66DBD19C211F
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 13:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059981F9F62;
	Thu, 20 Feb 2025 13:35:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DA61EEE9;
	Thu, 20 Feb 2025 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058513; cv=none; b=FJr07ayLgRqIHiz/JNV3PqE9GbXNAc11QV3QVxFPB3UCs2QcpOcONV7JvDm8bxMHUDm53HWsscUZg0FmWshxTy2R6CgCoB/rmF/0kSB8LGsGkl6MQZgQkU072LPd0+rVSwPSvlYfv09YCNLHGmsJ/Aj4guydsYTO0hG/7QJxhpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058513; c=relaxed/simple;
	bh=YjI1IJ9bAMJ3Aq/iklOIs3K8UyDjqFRqGclif3dNzv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RuILqN9hbhvipi5bB6izmDOkS5qK0cGBXRAPr4PfQil+oF9As7YM9oNgDyfnxrx9Q/IDjZlM8XOras+GnZO2L/sK2GRE9gXRPRP/yywxzoKPr8i96vpMP/M8GEYQaMIdmZI2HJ/eeRmBzksIOY0OsZPvvmz/rxRIlJudJUauxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowACnrAyEL7dnOoHnDg--.26826S2;
	Thu, 20 Feb 2025 21:35:02 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alexander.usyskin@intel.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mei: Add error logging in IRQ handler to prevent silent failures
Date: Thu, 20 Feb 2025 21:34:35 +0800
Message-ID: <20250220133435.1060-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnrAyEL7dnOoHnDg--.26826S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyfWw18Cw18ZF4UZw1UWrg_yoWfCrcEvw
	4DZr97GFyDGFs3AF1IyryY9FyakF48urn7Grn2gFW3K3s7CryUurZ2vFn5Kr4UW395Cr9r
	Wr1DZ3yxGry5AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUcBMtUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgTA2e3LZoHIgAAsW

Log mei_irq_write_handler() errors to prevent silent IRQ handling failures.

Fixes: 962ff7bcec24 ("mei: replace callback structures used as list head by list_head")
Cc: stable@vger.kernel.org # 4.11+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/misc/mei/hw-me.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index d11a0740b47c..5df42a64b4db 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1415,6 +1415,8 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
 	if (dev->pg_event != MEI_PG_EVENT_WAIT &&
 	    dev->pg_event != MEI_PG_EVENT_RECEIVED) {
 		rets = mei_irq_write_handler(dev, &cmpl_list);
+		if (rets)
+			dev_err(dev->dev, "mei_irq_write_handler ret = %d.\n", rets);
 		dev->hbuf_is_ready = mei_hbuf_is_ready(dev);
 	}
 
-- 
2.42.0.windows.2


