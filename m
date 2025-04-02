Return-Path: <stable+bounces-127409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51386A78ED6
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 14:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15CC816818C
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 12:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA66238D3B;
	Wed,  2 Apr 2025 12:45:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2941F2BBB;
	Wed,  2 Apr 2025 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743597948; cv=none; b=WIYv+KARBhzYuDo1AOitq6Hnhb3Si5+sUUs6B1t3HC71z3bbeFI/YiGFUkoL2xC4NQ7+gZv/NVZ4LDhtq76NboeSa5+cYCKaoS9efq2Pdsl5vLif+VmNgdXhM91ORts2RhgOZRg7dfwmNuZxmqdGr46NmgwgaDlwdTn3S+D8pnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743597948; c=relaxed/simple;
	bh=kkd8u8qjRsZKGfCBhYwabWw6BCgMMgLM99/L5iSUIiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RDvyTry3nrPe3WJKTTepfEcj5LIK6MEoFkyX67lN6J0XWdaoMFO9AI5yqU2dZxqh+f/U/iCm/YEhWlh6qB1NKpMljkdwTZNNUyRkBevR649NJfAnGJATGiZtFazqAT3Loh296cqo1sbGxajngpebgL637UWAi79wXX8SYWDXbsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowACHLwBtMe1npwYqBQ--.6509S2;
	Wed, 02 Apr 2025 20:45:35 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: renesas_usbhs: Add error handling for usbhsf_fifo_select()
Date: Wed,  2 Apr 2025 20:45:15 +0800
Message-ID: <20250402124515.3447-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHLwBtMe1npwYqBQ--.6509S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1rGrWkZF1Utr4kXrWDArb_yoW8XrWfpF
	W7G3y5ur1rJw1UXa1UJ3y8Zw1FvayFgry7ZrsrKa97AF13Ja12ya9YvF10vr1DG3yayw1F
	g3WvyFs5Gan7CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUcBMtUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgAA2ftBI+RrQAAs6

In usbhsf_dcp_data_stage_prepare_pop(), the return value of
usbhsf_fifo_select() needs to be checked. A proper implementation
can be found in usbhsf_dma_try_pop_with_rx_irq().

Add an error check and jump to PIO pop when FIFO selection fails.

Fixes: 9e74d601de8a ("usb: gadget: renesas_usbhs: add data/status stage handler")
Cc: stable@vger.kernel.org # v3.2+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/renesas_usbhs/fifo.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index 10607e273879..6cc07ab4782d 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -466,6 +466,7 @@ static int usbhsf_dcp_data_stage_prepare_pop(struct usbhs_pkt *pkt,
 	struct usbhs_pipe *pipe = pkt->pipe;
 	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
 	struct usbhs_fifo *fifo = usbhsf_get_cfifo(priv);
+	int ret;
 
 	if (usbhs_pipe_is_busy(pipe))
 		return 0;
@@ -480,10 +481,14 @@ static int usbhsf_dcp_data_stage_prepare_pop(struct usbhs_pkt *pkt,
 
 	usbhs_pipe_sequence_data1(pipe); /* DATA1 */
 
-	usbhsf_fifo_select(pipe, fifo, 0);
+	ret = usbhsf_fifo_select(pipe, fifo, 0);
+	if (ret < 0)
+		goto usbhsf_pio_prepare_pop;
+
 	usbhsf_fifo_clear(pipe, fifo);
 	usbhsf_fifo_unselect(pipe, fifo);
 
+usbhsf_pio_prepare_pop:
 	/*
 	 * change handler to PIO pop
 	 */
-- 
2.42.0.windows.2


