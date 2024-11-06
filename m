Return-Path: <stable+bounces-91337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843199BED88
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B700B1C23F83
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DD51E0084;
	Wed,  6 Nov 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iudrn18E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776F81DE4CA;
	Wed,  6 Nov 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898438; cv=none; b=gbEmtp/crfrHTcvvHwATbmdZ1YUmGzwFpe+/asTam5fjiXJvlsL41IWllx4L3z+9tWInmvuZexZeJW4yaiOVhjen4x0PBV/pC8Is6+jcytQqOg8IHyRiEAtfr+50z8mKfVZbPvWL3ORB6REpaCjSmnXTA/jHei3g/aC8sLiEHN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898438; c=relaxed/simple;
	bh=rVySh+g9/1DLay6HLsbLMnXkxz1teQBXt/2InPXOg2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pm+OocZ90U6INEGh/CGfQQ1rJuPZdUeBpJRFySYVZ58lS+O0RvhXHjcqiP93dOmF81uKjBjD7kjMjnW3xVbQ6aBjga4toWv9tMiHRHiK+X57/XWv/ciS1mPZqbQIJjQPG2QAyp0duJRiRsmzt8Vp6RRDj63vDYjNapLNThM7Gtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iudrn18E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0099CC4CECD;
	Wed,  6 Nov 2024 13:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898438;
	bh=rVySh+g9/1DLay6HLsbLMnXkxz1teQBXt/2InPXOg2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iudrn18EgPJxVCGVFOq4GDjs4LPXuDQaH75w6FkiwFkCRHGHq3xLevdYH08s8akof
	 v3TReUG+gkgUyTYI+KRTghiOc2nzYx58wMDaWNZNOUNJsl5P876pGj17DARcOIZCPx
	 WW0pGR1Q2AaFsAVWcU1IC4CHd76faiyAExaVi8t0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robert Hancock <robert.hancock@calian.com>,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 5.4 239/462] i2c: xiic: Wait for TX empty to avoid missed TX NAKs
Date: Wed,  6 Nov 2024 13:02:12 +0100
Message-ID: <20241106120337.426338753@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

From: Robert Hancock <robert.hancock@calian.com>

commit 521da1e9225450bd323db5fa5bca942b1dc485b7 upstream.

Frequently an I2C write will be followed by a read, such as a register
address write followed by a read of the register value. In this driver,
when the TX FIFO half empty interrupt was raised and it was determined
that there was enough space in the TX FIFO to send the following read
command, it would do so without waiting for the TX FIFO to actually
empty.

Unfortunately it appears that in some cases this can result in a NAK
that was raised by the target device on the write, such as due to an
unsupported register address, being ignored and the subsequent read
being done anyway. This can potentially put the I2C bus into an
invalid state and/or result in invalid read data being processed.

To avoid this, once a message has been fully written to the TX FIFO,
wait for the TX FIFO empty interrupt before moving on to the next
message, to ensure NAKs are handled properly.

Fixes: e1d5b6598cdc ("i2c: Add support for Xilinx XPS IIC Bus Interface")
Signed-off-by: Robert Hancock <robert.hancock@calian.com>
Cc: <stable@vger.kernel.org> # v2.6.34+
Reviewed-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-xiic.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -469,14 +469,17 @@ static irqreturn_t xiic_process(int irq,
 			goto out;
 		}
 
-		xiic_fill_tx_fifo(i2c);
-
-		/* current message sent and there is space in the fifo */
-		if (!xiic_tx_space(i2c) && xiic_tx_fifo_space(i2c) >= 2) {
+		if (xiic_tx_space(i2c)) {
+			xiic_fill_tx_fifo(i2c);
+		} else {
+			/* current message fully written */
 			dev_dbg(i2c->adap.dev.parent,
 				"%s end of message sent, nmsgs: %d\n",
 				__func__, i2c->nmsgs);
-			if (i2c->nmsgs > 1) {
+			/* Don't move onto the next message until the TX FIFO empties,
+			 * to ensure that a NAK is not missed.
+			 */
+			if (i2c->nmsgs > 1 && (pend & XIIC_INTR_TX_EMPTY_MASK)) {
 				i2c->nmsgs--;
 				i2c->tx_msg++;
 				xfer_more = 1;
@@ -487,11 +490,7 @@ static irqreturn_t xiic_process(int irq,
 					"%s Got TX IRQ but no more to do...\n",
 					__func__);
 			}
-		} else if (!xiic_tx_space(i2c) && (i2c->nmsgs == 1))
-			/* current frame is sent and is last,
-			 * make sure to disable tx half
-			 */
-			xiic_irq_dis(i2c, XIIC_INTR_TX_HALF_MASK);
+		}
 	}
 out:
 	dev_dbg(i2c->adap.dev.parent, "%s clr: 0x%x\n", __func__, clr);



