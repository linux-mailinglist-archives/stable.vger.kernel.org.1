Return-Path: <stable+bounces-134993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F4201A95C3D
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166F73AAF2E
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF38347A2;
	Tue, 22 Apr 2025 02:39:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D6F6FB9;
	Tue, 22 Apr 2025 02:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745289541; cv=none; b=e+IqSxqT1QJH0xRnh6AiKw5MdLsJkOD71De9vFkEYFJaA3n8e+2FO6j495Ch17/rcjL8kwXt5+URu1Q9Q+1UBnSoINZsXwLK03bCepJG2vgISH03H5LJ0QPnAEt00FyEIbgs/bE0nkWK63AcnGzfr0RVE+G2kSNh1I1n0sTWqVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745289541; c=relaxed/simple;
	bh=kkd8u8qjRsZKGfCBhYwabWw6BCgMMgLM99/L5iSUIiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rOcFRZmW6AUWsPkKX18n/JdPJ7cHwITk4lqkSbL5Mnvfk8c1MecCIxPZjGEJVI8M0vodJUUc9cenZuypcRHgBW409i4vHd+x/gETQijsnP6Lhxt1hXWjlDdS4KbNxxqJgTvhYIZrbyt5m8kY/bugeUzYTeprbQeOQ/y//egSLtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowACHKvs7AQdotrUBCw--.14101S2;
	Tue, 22 Apr 2025 10:38:51 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] usb: renesas_usbhs: Add error handling for usbhsf_fifo_select()
Date: Tue, 22 Apr 2025 10:38:24 +0800
Message-ID: <20250422023825.2016-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHKvs7AQdotrUBCw--.14101S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1rGrWkZF1Utr4kXrWDArb_yoW8XrWfpF
	W7G3y5ur1rJw1UXa1UJ3y8Zw1FvayFgry7ZrsrKa97AF13Ja12ya9YvF10vr1DG3yayw1F
	g3WvyFs5Gan7CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUjR6wtUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCREAA2gG55ZwGgAAsu

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


