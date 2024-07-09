Return-Path: <stable+bounces-58593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9B892B7C5
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBBA1C2354A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D3F156238;
	Tue,  9 Jul 2024 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FTz32lhs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D54D27713;
	Tue,  9 Jul 2024 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524409; cv=none; b=Rs5J8Ih4eUCLYkLL6SmPwCAQ83nZs/BzGpYxySvZAvSCTy9g8sz0ntGzOieDFviKXA53kqoz9P6dssZ7NXJspK45kl5gwAtDWLxD5oHwlh+20zCaWcXHRasoD/4jBVKX7uOYM/S95HBe3nwpLJFNnlItEKbeLkdoTyOdJwEf+3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524409; c=relaxed/simple;
	bh=kaBJ0du7fqgvt2qumAV48M5Lb4ANFNA7iQOM1Uq66UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXYXDnbagcLriDcpb0ED72IGz+b/IcsU8UNWgPhfA52mU0QS01uKesVOTiVVbBPadKXm607ubyT6JsZJ2hHg15EhiWG0QX1adoUVbnEibq0JFrsCvlXXTJtMcxHA8VTr4iJsjdMaZr89QtoY2vPaIfBufG/PiLC3u4rnPoPlAdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FTz32lhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED53BC3277B;
	Tue,  9 Jul 2024 11:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524409;
	bh=kaBJ0du7fqgvt2qumAV48M5Lb4ANFNA7iQOM1Uq66UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FTz32lhs+ZZZV3RdED3tKIKetaIQ7mTy3VzXkso4D/csgS4g1KWEONZjnYNPScfjc
	 dVXJX67QQdsH4pwPq2Nnmy2Vt8Dv8IAkeIq2FcCzIKHbvByMpzTdLjr34OwrHRmEqO
	 uBJrC0tMaAvs7fbcHdh8Pm7IKhYoff2FOgbuk4WY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 173/197] i2c: pnx: Fix potential deadlock warning from del_timer_sync() call in isr
Date: Tue,  9 Jul 2024 13:10:27 +0200
Message-ID: <20240709110715.644050617@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
References: <20240709110708.903245467@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>

[ Upstream commit f63b94be6942ba82c55343e196bd09b53227618e ]

When del_timer_sync() is called in an interrupt context it throws a warning
because of potential deadlock. The timer is used only to exit from
wait_for_completion() after a timeout so replacing the call with
wait_for_completion_timeout() allows to remove the problematic timer and
its related functions altogether.

Fixes: 41561f28e76a ("i2c: New Philips PNX bus driver")
Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-pnx.c | 48 ++++++++----------------------------
 1 file changed, 10 insertions(+), 38 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index a12525b3186bc..f448505d54682 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -15,7 +15,6 @@
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
-#include <linux/timer.h>
 #include <linux/completion.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
@@ -32,7 +31,6 @@ struct i2c_pnx_mif {
 	int			ret;		/* Return value */
 	int			mode;		/* Interface mode */
 	struct completion	complete;	/* I/O completion */
-	struct timer_list	timer;		/* Timeout */
 	u8 *			buf;		/* Data buffer */
 	int			len;		/* Length of data buffer */
 	int			order;		/* RX Bytes to order via TX */
@@ -117,24 +115,6 @@ static inline int wait_reset(struct i2c_pnx_algo_data *data)
 	return (timeout <= 0);
 }
 
-static inline void i2c_pnx_arm_timer(struct i2c_pnx_algo_data *alg_data)
-{
-	struct timer_list *timer = &alg_data->mif.timer;
-	unsigned long expires = msecs_to_jiffies(alg_data->timeout);
-
-	if (expires <= 1)
-		expires = 2;
-
-	del_timer_sync(timer);
-
-	dev_dbg(&alg_data->adapter.dev, "Timer armed at %lu plus %lu jiffies.\n",
-		jiffies, expires);
-
-	timer->expires = jiffies + expires;
-
-	add_timer(timer);
-}
-
 /**
  * i2c_pnx_start - start a device
  * @slave_addr:		slave address
@@ -259,8 +239,6 @@ static int i2c_pnx_master_xmit(struct i2c_pnx_algo_data *alg_data)
 				~(mcntrl_afie | mcntrl_naie | mcntrl_drmie),
 				  I2C_REG_CTL(alg_data));
 
-			del_timer_sync(&alg_data->mif.timer);
-
 			dev_dbg(&alg_data->adapter.dev,
 				"%s(): Waking up xfer routine.\n",
 				__func__);
@@ -276,8 +254,6 @@ static int i2c_pnx_master_xmit(struct i2c_pnx_algo_data *alg_data)
 			~(mcntrl_afie | mcntrl_naie | mcntrl_drmie),
 			  I2C_REG_CTL(alg_data));
 
-		/* Stop timer. */
-		del_timer_sync(&alg_data->mif.timer);
 		dev_dbg(&alg_data->adapter.dev,
 			"%s(): Waking up xfer routine after zero-xfer.\n",
 			__func__);
@@ -364,8 +340,6 @@ static int i2c_pnx_master_rcv(struct i2c_pnx_algo_data *alg_data)
 				 mcntrl_drmie | mcntrl_daie);
 			iowrite32(ctl, I2C_REG_CTL(alg_data));
 
-			/* Kill timer. */
-			del_timer_sync(&alg_data->mif.timer);
 			complete(&alg_data->mif.complete);
 		}
 	}
@@ -400,8 +374,6 @@ static irqreturn_t i2c_pnx_interrupt(int irq, void *dev_id)
 			 mcntrl_drmie);
 		iowrite32(ctl, I2C_REG_CTL(alg_data));
 
-		/* Stop timer, to prevent timeout. */
-		del_timer_sync(&alg_data->mif.timer);
 		complete(&alg_data->mif.complete);
 	} else if (stat & mstatus_nai) {
 		/* Slave did not acknowledge, generate a STOP */
@@ -419,8 +391,6 @@ static irqreturn_t i2c_pnx_interrupt(int irq, void *dev_id)
 		/* Our return value. */
 		alg_data->mif.ret = -EIO;
 
-		/* Stop timer, to prevent timeout. */
-		del_timer_sync(&alg_data->mif.timer);
 		complete(&alg_data->mif.complete);
 	} else {
 		/*
@@ -453,9 +423,8 @@ static irqreturn_t i2c_pnx_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void i2c_pnx_timeout(struct timer_list *t)
+static void i2c_pnx_timeout(struct i2c_pnx_algo_data *alg_data)
 {
-	struct i2c_pnx_algo_data *alg_data = from_timer(alg_data, t, mif.timer);
 	u32 ctl;
 
 	dev_err(&alg_data->adapter.dev,
@@ -472,7 +441,6 @@ static void i2c_pnx_timeout(struct timer_list *t)
 	iowrite32(ctl, I2C_REG_CTL(alg_data));
 	wait_reset(alg_data);
 	alg_data->mif.ret = -EIO;
-	complete(&alg_data->mif.complete);
 }
 
 static inline void bus_reset_if_active(struct i2c_pnx_algo_data *alg_data)
@@ -514,6 +482,7 @@ i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	struct i2c_msg *pmsg;
 	int rc = 0, completed = 0, i;
 	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
+	unsigned long time_left;
 	u32 stat;
 
 	dev_dbg(&alg_data->adapter.dev,
@@ -548,7 +517,6 @@ i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		dev_dbg(&alg_data->adapter.dev, "%s(): mode %d, %d bytes\n",
 			__func__, alg_data->mif.mode, alg_data->mif.len);
 
-		i2c_pnx_arm_timer(alg_data);
 
 		/* initialize the completion var */
 		init_completion(&alg_data->mif.complete);
@@ -564,7 +532,10 @@ i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 			break;
 
 		/* Wait for completion */
-		wait_for_completion(&alg_data->mif.complete);
+		time_left = wait_for_completion_timeout(&alg_data->mif.complete,
+							alg_data->timeout);
+		if (time_left == 0)
+			i2c_pnx_timeout(alg_data);
 
 		if (!(rc = alg_data->mif.ret))
 			completed++;
@@ -653,7 +624,10 @@ static int i2c_pnx_probe(struct platform_device *pdev)
 	alg_data->adapter.algo_data = alg_data;
 	alg_data->adapter.nr = pdev->id;
 
-	alg_data->timeout = I2C_PNX_TIMEOUT_DEFAULT;
+	alg_data->timeout = msecs_to_jiffies(I2C_PNX_TIMEOUT_DEFAULT);
+	if (alg_data->timeout <= 1)
+		alg_data->timeout = 2;
+
 #ifdef CONFIG_OF
 	alg_data->adapter.dev.of_node = of_node_get(pdev->dev.of_node);
 	if (pdev->dev.of_node) {
@@ -673,8 +647,6 @@ static int i2c_pnx_probe(struct platform_device *pdev)
 	if (IS_ERR(alg_data->clk))
 		return PTR_ERR(alg_data->clk);
 
-	timer_setup(&alg_data->mif.timer, i2c_pnx_timeout, 0);
-
 	snprintf(alg_data->adapter.name, sizeof(alg_data->adapter.name),
 		 "%s", pdev->name);
 
-- 
2.43.0




