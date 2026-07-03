Return-Path: <stable+bounces-271670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +aD4NlFnR2oZXwAAu9opvQ
	(envelope-from <stable+bounces-271670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 09:40:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 778F16FFA33
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 09:40:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271670-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271670-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E57973008D54
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 07:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6DD36AB6B;
	Fri,  3 Jul 2026 07:39:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC3F34678E;
	Fri,  3 Jul 2026 07:39:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064398; cv=none; b=Y+f/gYNa9IgFAtGXlimjqApaGANp93jclWOMSZeMDQaW4s9uROg4fiAf4wBrBJ4Y03drGYFlYQImXq/vPVlkSekzac3OW9iil64rBKnxuoaojuBS0Jnml6kGdatIa4+QFahETrq9yBKzlWivcxmzM5GwQY+4s1vjrGY+Igdf2ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064398; c=relaxed/simple;
	bh=xAM3itkDUKFtNzGrdzv0Yzm8+Y84rh2AI/CNOTYNg4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBH1h+pYDlmFONAtxAxf9Vjh+Nrs4wGwUtM/e7NdLCcEoiW/vcXr8awYfp966mKOHsqUYyGrgTcwp3Fas/1mJhnbr0xcKONl8ZjhCJ8AmeCwKcOw7hAEqJz6AvHnBq+Trb7X6b7+HNXtHdJChomvqM39WsgxqCSvXPgJahhAX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowADXu+JAZ0dqs0PAFg--.12816S2;
	Fri, 03 Jul 2026 15:39:44 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vladimir Zapolskiy <vz@kernel.org>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2] mtd: rawnand: lpc32xx_slc: fail DMA transfer on completion timeout
Date: Fri,  3 Jul 2026 15:39:43 +0800
Message-ID: <20260703073943.43373-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADXu+JAZ0dqs0PAFg--.12816S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFy8WF17Cw18WFy3ZrW5KFg_yoW8uFyfpa
	10kwnIkr4jqr43Kr4UCa1Uu3W5Wa1rArW7K3sIvw4ruws5Zr4jvF9Y9FyqqF45tFZ5CF47
	XFZ5tFn8Cr1UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271670-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:vz@kernel.org,m:piotr.wojtaszczyk@timesys.com,m:linux-mtd@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:pengpeng@iscas.ac.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:from_mime,iscas.ac.cn:email,iscas.ac.cn:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 778F16FFA33

lpc32xx_xmit_dma() waits for the DMA completion callback but ignores
wait_for_completion_timeout(). A timed out DMA transfer is therefore
unmapped and reported as successful to the NAND read/write path.

Return -ETIMEDOUT when the completion wait expires. Terminate the DMA
channel before unmapping the scatterlist so the timed out transfer cannot
continue to access the buffer after the error is returned.

Fixes: 2944a44da09e ("mtd: add LPC32xx SLC NAND driver")
Cc: stable@vger.kernel.org
Reviewed-by: Vladimir Zapolskiy <vz@kernel.org>
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1: https://lore.kernel.org/all/20260624144127.69075-1-pengpeng@iscas.ac.cn/
- add Fixes and Cc stable tags as requested by Miquel
- carry Vladimir's Reviewed-by tag

 drivers/mtd/nand/raw/lpc32xx_slc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 3ca30e7dce33..10c8080207f4 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -430,6 +430,7 @@ static int lpc32xx_xmit_dma(struct mtd_info *mtd, dma_addr_t dma,
 	struct dma_async_tx_descriptor *desc;
 	int flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
 	int res;
+	unsigned long time_left;
 
 	host->dma_slave_config.direction = dir;
 	host->dma_slave_config.src_addr = dma;
@@ -467,12 +468,19 @@ static int lpc32xx_xmit_dma(struct mtd_info *mtd, dma_addr_t dma,
 	dmaengine_submit(desc);
 	dma_async_issue_pending(host->dma_chan);
 
-	wait_for_completion_timeout(&host->comp, msecs_to_jiffies(1000));
+	time_left = wait_for_completion_timeout(&host->comp,
+						msecs_to_jiffies(1000));
+	if (!time_left) {
+		dmaengine_terminate_sync(host->dma_chan);
+		res = -ETIMEDOUT;
+	} else {
+		res = 0;
+	}
 
 	dma_unmap_sg(host->dma_chan->device->dev, &host->sgl, 1,
 		     DMA_BIDIRECTIONAL);
 
-	return 0;
+	return res;
 out1:
 	dma_unmap_sg(host->dma_chan->device->dev, &host->sgl, 1,
 		     DMA_BIDIRECTIONAL);
-- 
2.53.0


