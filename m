Return-Path: <stable+bounces-132403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9776AA878AA
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 09:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFAD27A334B
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 07:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ED22580C9;
	Mon, 14 Apr 2025 07:25:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EA41A262D;
	Mon, 14 Apr 2025 07:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744615551; cv=none; b=LJDGFqJW8uhNfZg9McYT5qJKqjUwqdE0fpXryNfGUCy6jfpNBSNQPW8yPkZ+INXDLXuCB/1iKAx9tXikxqWV3zx9aJP+0Qj1hr4Lp/ISvhXa8uk+Awb+QGp6BhVSRu+4eS6h67YOS1utqgi2HnJHX2FdaLi4Zwq8QTfzpglAgYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744615551; c=relaxed/simple;
	bh=kkd8u8qjRsZKGfCBhYwabWw6BCgMMgLM99/L5iSUIiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erFjOkPaWw1KKnmaOaJPYuheLRSuZgnTT5QWjCWSfnQxc0wL1Nk9SlqgfdbPGAixefsxqWcPH2ugtS28woS7mO2Nfy4o6nn4TzrpO53qEk+UefifdKa9CJqSea+g78kRS7ybJS5xPg3s8z7QjxL8cm9XvaZ4atx1GvwjF1gQ0PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAAHQwt4uPxnkVbnCA--.16352S2;
	Mon, 14 Apr 2025 15:25:45 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] usb: renesas_usbhs: Add error handling for usbhsf_fifo_select()
Date: Mon, 14 Apr 2025 15:25:01 +0800
Message-ID: <20250414072501.2259-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHQwt4uPxnkVbnCA--.16352S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1rGrWkZF1Utr4kXrWDArb_yoW8XrWfpF
	W7G3y5ur1rJw1UXa1UJ3y8Zw1FvayFgry7ZrsrKa97AF13Ja12ya9YvF10vr1DG3yayw1F
	g3WvyFs5Gan7CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JU7DGOUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgoMA2f8nCRmcAAAs2

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


