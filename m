Return-Path: <stable+bounces-127376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BD8A786C7
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 05:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61437188C82C
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 03:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ED3223327;
	Wed,  2 Apr 2025 03:17:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC282222560;
	Wed,  2 Apr 2025 03:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743563845; cv=none; b=P2+u+D/h5luQO5Yfw3leFB8m9OAG1Ih81mLXDZO23C52Png0AC9B3aC86KrkTlnJ1GXqP6rqFcDsZ3ysKB/9Il+1UCYB2XUzU2n+iqMqOEfO+LNGPfe9FCxJHlDiKS9X9gMr7imFM4MGb1sjzcvUn6nRuq3eemBHedjiHzFc58o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743563845; c=relaxed/simple;
	bh=IeVF2kSvbAC+Wzxuvu1xOQGtbrUK7K3oT9bYB6KwpnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tr6UFRgnnohRFrosf7Z1/YxMUPaHybERn5L21d8wRIBe6MnsvdkGq7mO/KkyhiV1xi36Y7CQjhbOwwb1KrYqHPUBdz6wTnG5P3C04Cq3zWuxsE9FaclrvAQjhy68grcXjTQOnG2Rghh39TXs7nmYXgazZrzXfu55PM874WmAvEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowADXDgcsrOxnHJMABQ--.17449S2;
	Wed, 02 Apr 2025 11:17:06 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mtd: inftlcore: Add error check for inftl_read_oob()
Date: Wed,  2 Apr 2025 11:16:43 +0800
Message-ID: <20250402031643.3025-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXDgcsrOxnHJMABQ--.17449S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF48JF4rWry3Gr4UtrWfuFg_yoW8JFy3pa
	yDArWUA348Cr95u3Wvyr1UCF15AayrKFW29F4UX3WfXw45GasxZwn0qFW0qrWUJFWxW3Wx
	KF4vyr98AayDCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsAA2fsiD9yogABsi

In INFTL_findwriteunit(), the return value of inftl_read_oob()
need to be checked. A proper implementation can be
found in INFTL_deleteblock(). The status will be set as
SECTOR_IGNORE to break from the while-loop correctly
if the inftl_read_oob() fails.

Fixes: 8593fbc68b0d ("[MTD] Rework the out of band handling completely")
Cc: stable@vger.kernel.org # v2.6+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/mtd/inftlcore.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/inftlcore.c b/drivers/mtd/inftlcore.c
index 9739387cff8c..58c6e1743f5c 100644
--- a/drivers/mtd/inftlcore.c
+++ b/drivers/mtd/inftlcore.c
@@ -482,10 +482,11 @@ static inline u16 INFTL_findwriteunit(struct INFTLrecord *inftl, unsigned block)
 		silly = MAX_LOOPS;
 
 		while (thisEUN <= inftl->lastEUN) {
-			inftl_read_oob(mtd, (thisEUN * inftl->EraseSize) +
-				       blockofs, 8, &retlen, (char *)&bci);
-
-			status = bci.Status | bci.Status1;
+			if (inftl_read_oob(mtd, (thisEUN * inftl->EraseSize) +
+				       blockofs, 8, &retlen, (char *)&bci) < 0)
+				status = SECTOR_IGNORE;
+			else
+				status = bci.Status | bci.Status1;
 			pr_debug("INFTL: status of block %d in EUN %d is %x\n",
 					block , writeEUN, status);
 
-- 
2.42.0.windows.2


