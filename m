Return-Path: <stable+bounces-200321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D598DCABF90
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 04:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ABA33017386
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 03:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1522F7AC5;
	Mon,  8 Dec 2025 03:36:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D179233704;
	Mon,  8 Dec 2025 03:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765164991; cv=none; b=TeGuHlQJsay0i5zyYLGMwq7b+YciqmrXdWfbL35562Aian7oEZ1M5uZq1A2VlQNQ2PPCFaAbUK/WyzLjYMwr2l6dcAKalGuwNrk3OP/MBX4X3OaZfN2Wr0jgEBIK7O8VFZwFlatBEuPB8JXXkuMGgZQnnOrUzluJunbaCdpVYd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765164991; c=relaxed/simple;
	bh=VI3aERMVwqpqhU7buuiP4rZeSCQxAapxIHYZ9H7nXx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YuXWw6PXu9g9Gxk7hDAXDb5vYdEOy4UdXlKOpwGyhmmllwvXst5ZfKDIv/p0RprGMk6ihvxhXZxcxkZUW/pyjVA52k/H4AUt56HdiNdBrKeepyypGk5R9u1FKg1oMt0OGyRIsPPCyb3zfK1Bn7X+vpMcSKX1tax49lAcpZ9yDUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowABH2NqsRzZpQkGGAw--.10984S2;
	Mon, 08 Dec 2025 11:36:12 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: eajames@linux.ibm.com,
	ninad@linux.ibm.com
Cc: linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fsi: master-gpio: Fix reference count leak in probe error path
Date: Mon,  8 Dec 2025 03:36:06 +0000
Message-Id: <20251208033606.10647-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABH2NqsRzZpQkGGAw--.10984S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr17Gry7tFy5CrWkCF4Uurg_yoWDXrcEkF
	18WF97X3yUCF1DGrs0yrWavrZFgr9xWFZ7GFykta1Sqw18AryYqF1avrs5J3WrXr4fJFsY
	yr97Gw1fWr43ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUoKZXUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYKA2k2L0FkiAAAse

The function of_node_get() returns a node pointer with its refcount
incremented, but in the error path of the fsi_master_gpio_probe(),
this reference is not released before freeing the master structure,
causing a refcount leak.

Add the missing of_node_put() in the error handling path to properly
release the device tree node reference.

Fixes: 8ef9ccf81044 ("fsi: master-gpio: Add missing release function")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/fsi/fsi-master-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 69de0b5b9cbd..ae9e156284d0 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -861,6 +861,7 @@ static int fsi_master_gpio_probe(struct platform_device *pdev)
 	}
 	return 0;
  err_free:
+	of_node_put(master->master.dev.of_node);
 	kfree(master);
 	return rc;
 }
-- 
2.34.1


