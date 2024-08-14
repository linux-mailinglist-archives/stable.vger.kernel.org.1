Return-Path: <stable+bounces-67622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D1A951877
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 12:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC89B21A8E
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 10:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCD4144D15;
	Wed, 14 Aug 2024 10:15:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54290137C37;
	Wed, 14 Aug 2024 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723630559; cv=none; b=Oq488RNaSktk1GonOCjLc+ma67mhPEWUzmB01hjHVGOpEqqWGoIBdu1aIaLzoFEKHZnTM4U6axEa1vVCdfpxegR1xMOV3EM8MRu/VL517IkZ3yq4IBgfRp/rWBbiZHPrrxTmTCz24cqoiQv14HxP7VTJ5M4hGrNC6jL7WhNpaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723630559; c=relaxed/simple;
	bh=3wgSizC2K7D0EjJTHEAYQtnfII0JD4LxZQRqZo2h+zI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q3muLQfhf/vWtPy+mC8EvO6sJ13SLz/udD1/yjDDKGAfxnVlUbvn8FspPW1wiCCSDxAaC7UiVLJFxYvhp3u1pp84BjTx4meW+cPsdoOEns+eMlS4ywHGmnQqpboPCt+pyW++JkueqzGcv+k5eS3R9cHUIWvUpqLKbyBUeyQeb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowAB3nwK5g7xm9DhUBg--.39765S2;
	Wed, 14 Aug 2024 18:15:29 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	make24@iscas.ac.cn,
	u.kleine-koenig@pengutronix.de,
	tglx@linutronix.de,
	zhang_shurong@foxmail.com,
	B56683@freescale.com,
	cosmin.stoica@nxp.com,
	stefan-gabriel.mirea@nxp.com,
	Larisa.Grigore@nxp.com,
	matthew.nunez@nxp.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] tty: serial: Add a NULL check for of_node
Date: Wed, 14 Aug 2024 18:15:20 +0800
Message-Id: <20240814101520.17129-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3nwK5g7xm9DhUBg--.39765S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw13tFWkKFyUZr1kKFW8Xrb_yoWfArg_CF
	1q93srWr12kF43tr47AFy7ur9agw4kZF4kXF1vva9aqryDAr4rZFy7Zrs8ury7Ww4UJryD
	AanrWr1akr17ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

The pdev->dev.of_node can be NULL if the "serial" node is absent.
Add a NULL check for np to return an error in such cases.

Found by code review. Compile tested only.

Cc: stable@vger.kernel.org
Fixes: 09864c1cdf5c ("tty: serial: Add linflexuart driver for S32V234")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/tty/serial/fsl_linflexuart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index e972df4b188d..f46f3c21ee1b 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -811,6 +811,9 @@ static int linflex_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret;
 
+	if (!np)
+		return -ENODEV;
+
 	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
 	if (!sport)
 		return -ENOMEM;
-- 
2.25.1


