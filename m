Return-Path: <stable+bounces-51036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623C8906E08
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF83E1C227D6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9D014430C;
	Thu, 13 Jun 2024 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kriJQCjq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C38F44C6F;
	Thu, 13 Jun 2024 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280118; cv=none; b=ez9w+p3RJU3Tx0OyMti+9xdMcuTnU7EYTW0hFLOHSzxYCLuc0Qw5XfMS8MXSdLoTxdmpA43UUC8bPY8V2WFycty+BlWqyBV7859llqENJyo1bErT0NzoNcph/6slDeWD4F54unCiiCPNIZdLx+cGqUB8HKt6iKloImbogNZUrHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280118; c=relaxed/simple;
	bh=wikmbb981eKPNz4OTe7RUA38HhpCAnHeovU/a80OrBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPGJ5pd5MX7H3Ni4jgsGaSQoRCCyT2ax9alfstLhj+jtXr1tpv+DQD4kPQT0nAieklpHjLYUMSK08+0lj+yJ8cBoe6AZ615EHU6JNv/sQ0fSgWiHCZoFo7IvgugBJUgLpig8PJOVU8k6w6YiRdPM9qDqXnFFu7jpZp+tUOgiSmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kriJQCjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E853FC2BBFC;
	Thu, 13 Jun 2024 12:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280118;
	bh=wikmbb981eKPNz4OTe7RUA38HhpCAnHeovU/a80OrBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kriJQCjq2PKCD0EvA7STBGuhys+vk08bHE+aJVLqsSarrHzKSUR9xDZjNh3/0t3nC
	 fROkWtgGVS4Gu8Qh1z/DhGe0JoR7C9MTwUdwPwNP1Ku4DvfkYTmrsQoEFLCGzdNtTe
	 5O2kZ5EPrBzWc1FQIHsC5HGrF3oOuRHd5fZFwf+4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 121/202] serial: sh-sci: protect invalidating RXDMA on shutdown
Date: Thu, 13 Jun 2024 13:33:39 +0200
Message-ID: <20240613113232.431131685@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.759341286@linuxfoundation.org>
References: <20240613113227.759341286@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit aae20f6e34cd0cbd67a1d0e5877561c40109a81b ]

The to-be-fixed commit removed locking when invalidating the DMA RX
descriptors on shutdown. It overlooked that there is still a rx_timer
running which may still access the protected data. So, re-add the
locking.

Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
Closes: https://lore.kernel.org/r/ee6c9e16-9f29-450e-81da-4a8dceaa8fc7@de.bosch.com
Fixes: 2c4ee23530ff ("serial: sh-sci: Postpone DMA release when falling back to PIO")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20240506114016.30498-7-wsa+renesas@sang-engineering.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sh-sci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 95db67c07c340..d570edf21239d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1259,9 +1259,14 @@ static void sci_dma_rx_chan_invalidate(struct sci_port *s)
 static void sci_dma_rx_release(struct sci_port *s)
 {
 	struct dma_chan *chan = s->chan_rx_saved;
+	struct uart_port *port = &s->port;
+	unsigned long flags;
 
+	uart_port_lock_irqsave(port, &flags);
 	s->chan_rx_saved = NULL;
 	sci_dma_rx_chan_invalidate(s);
+	uart_port_unlock_irqrestore(port, flags);
+
 	dmaengine_terminate_sync(chan);
 	dma_free_coherent(chan->device->dev, s->buf_len_rx * 2, s->rx_buf[0],
 			  sg_dma_address(&s->sg_rx[0]));
-- 
2.43.0




