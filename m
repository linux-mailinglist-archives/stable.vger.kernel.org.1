Return-Path: <stable+bounces-106348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257769FE7F5
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDA11882F09
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7E81537C8;
	Mon, 30 Dec 2024 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lBLcpkd/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2102E414;
	Mon, 30 Dec 2024 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735573667; cv=none; b=A40lSYze7CEjeHpJTEUElq0JCouRkTqonzNQNitL4p+wh4bLBRDb8bQSpy+QWYfGbyhREtsb9COSDnXxYq8n7NZ0l81tNj+NPCbruXF8Cput8Kn1X4JnN3SHeCsTYXfOfd6Ga0v5ltwC1SZuKQcg0fogTNpox1Vz9QHatHyIgZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735573667; c=relaxed/simple;
	bh=QjLWvNg8ZnrQrrFsLjPwphN01vIMjkPiwmE6e8WnJB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIfH9KCM7EnNoHmQ0BfhSM62n4C4doiRge64i8MIEwMvNl9e8CeH4IaG4P29pbGfF09tEFDc+wmRB939njxyhpvRvf/0steZazFoHve6yrDpoJb6k7ZjxT2rOubnSspWqWLWYZg2OmS1zjumqtgU3DDcseTRWjzrTXsjBbutPBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lBLcpkd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538C5C4CED0;
	Mon, 30 Dec 2024 15:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735573667;
	bh=QjLWvNg8ZnrQrrFsLjPwphN01vIMjkPiwmE6e8WnJB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lBLcpkd/zVrvH1NYhB0gWIh6+yoVcVoNtcniKvGXg+3uwMi3M8W83rBBhm/Dunmce
	 0qtwkghE13htmBkq2/1Hx4K8tQiWgon7wKyGxMq8xWWEpdgwDiMnPYn4dee8G/MVoA
	 1/gGFcAbyBdDttxlnb5b4YS0sef76kc0PDswG2EE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Conor Dooley <conor.dooley@microchip.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 6.1 52/60] i2c: microchip-core: actually use repeated sends
Date: Mon, 30 Dec 2024 16:43:02 +0100
Message-ID: <20241230154209.248926718@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230154207.276570972@linuxfoundation.org>
References: <20241230154207.276570972@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Conor Dooley <conor.dooley@microchip.com>

commit 9a8f9320d67b27ddd7f1ee88d91820197a0e908f upstream.

At present, where repeated sends are intended to be used, the
i2c-microchip-core driver sends a stop followed by a start. Lots of i2c
devices must not malfunction in the face of this behaviour, because the
driver has operated like this for years! Try to keep track of whether or
not a repeated send is required, and suppress sending a stop in these
cases.

CC: stable@vger.kernel.org
Fixes: 64a6f1c4987e ("i2c: add support for microchip fpga i2c controllers")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20241218-football-composure-e56df2461461@spud
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-microchip-corei2c.c |  120 ++++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 26 deletions(-)

--- a/drivers/i2c/busses/i2c-microchip-corei2c.c
+++ b/drivers/i2c/busses/i2c-microchip-corei2c.c
@@ -93,27 +93,35 @@
  * @base:		pointer to register struct
  * @dev:		device reference
  * @i2c_clk:		clock reference for i2c input clock
+ * @msg_queue:		pointer to the messages requiring sending
  * @buf:		pointer to msg buffer for easier use
  * @msg_complete:	xfer completion object
  * @adapter:		core i2c abstraction
  * @msg_err:		error code for completed message
  * @bus_clk_rate:	current i2c bus clock rate
  * @isr_status:		cached copy of local ISR status
+ * @total_num:		total number of messages to be sent/received
+ * @current_num:	index of the current message being sent/received
  * @msg_len:		number of bytes transferred in msg
  * @addr:		address of the current slave
+ * @restart_needed:	whether or not a repeated start is required after current message
  */
 struct mchp_corei2c_dev {
 	void __iomem *base;
 	struct device *dev;
 	struct clk *i2c_clk;
+	struct i2c_msg *msg_queue;
 	u8 *buf;
 	struct completion msg_complete;
 	struct i2c_adapter adapter;
 	int msg_err;
+	int total_num;
+	int current_num;
 	u32 bus_clk_rate;
 	u32 isr_status;
 	u16 msg_len;
 	u8 addr;
+	bool restart_needed;
 };
 
 static void mchp_corei2c_core_disable(struct mchp_corei2c_dev *idev)
@@ -222,6 +230,47 @@ static int mchp_corei2c_fill_tx(struct m
 	return 0;
 }
 
+static void mchp_corei2c_next_msg(struct mchp_corei2c_dev *idev)
+{
+	struct i2c_msg *this_msg;
+	u8 ctrl;
+
+	if (idev->current_num >= idev->total_num) {
+		complete(&idev->msg_complete);
+		return;
+	}
+
+	/*
+	 * If there's been an error, the isr needs to return control
+	 * to the "main" part of the driver, so as not to keep sending
+	 * messages once it completes and clears the SI bit.
+	 */
+	if (idev->msg_err) {
+		complete(&idev->msg_complete);
+		return;
+	}
+
+	this_msg = idev->msg_queue++;
+
+	if (idev->current_num < (idev->total_num - 1)) {
+		struct i2c_msg *next_msg = idev->msg_queue;
+
+		idev->restart_needed = next_msg->flags & I2C_M_RD;
+	} else {
+		idev->restart_needed = false;
+	}
+
+	idev->addr = i2c_8bit_addr_from_msg(this_msg);
+	idev->msg_len = this_msg->len;
+	idev->buf = this_msg->buf;
+
+	ctrl = readb(idev->base + CORE_I2C_CTRL);
+	ctrl |= CTRL_STA;
+	writeb(ctrl, idev->base + CORE_I2C_CTRL);
+
+	idev->current_num++;
+}
+
 static irqreturn_t mchp_corei2c_handle_isr(struct mchp_corei2c_dev *idev)
 {
 	u32 status = idev->isr_status;
@@ -247,10 +296,14 @@ static irqreturn_t mchp_corei2c_handle_i
 		break;
 	case STATUS_M_SLAW_ACK:
 	case STATUS_M_TX_DATA_ACK:
-		if (idev->msg_len > 0)
+		if (idev->msg_len > 0) {
 			mchp_corei2c_fill_tx(idev);
-		else
-			last_byte = true;
+		} else {
+			if (idev->restart_needed)
+				finished = true;
+			else
+				last_byte = true;
+		}
 		break;
 	case STATUS_M_TX_DATA_NACK:
 	case STATUS_M_SLAR_NACK:
@@ -287,7 +340,7 @@ static irqreturn_t mchp_corei2c_handle_i
 		mchp_corei2c_stop(idev);
 
 	if (last_byte || finished)
-		complete(&idev->msg_complete);
+		mchp_corei2c_next_msg(idev);
 
 	return IRQ_HANDLED;
 }
@@ -311,21 +364,48 @@ static irqreturn_t mchp_corei2c_isr(int
 	return ret;
 }
 
-static int mchp_corei2c_xfer_msg(struct mchp_corei2c_dev *idev,
-				 struct i2c_msg *msg)
+static int mchp_corei2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
+			     int num)
 {
-	u8 ctrl;
+	struct mchp_corei2c_dev *idev = i2c_get_adapdata(adap);
+	struct i2c_msg *this_msg = msgs;
 	unsigned long time_left;
+	u8 ctrl;
 
-	idev->addr = i2c_8bit_addr_from_msg(msg);
-	idev->msg_len = msg->len;
-	idev->buf = msg->buf;
+	mchp_corei2c_core_enable(idev);
+
+	/*
+	 * The isr controls the flow of a transfer, this info needs to be saved
+	 * to a location that it can access the queue information from.
+	 */
+	idev->restart_needed = false;
+	idev->msg_queue = msgs;
+	idev->total_num = num;
+	idev->current_num = 0;
+
+	/*
+	 * But the first entry to the isr is triggered by the start in this
+	 * function, so the first message needs to be "dequeued".
+	 */
+	idev->addr = i2c_8bit_addr_from_msg(this_msg);
+	idev->msg_len = this_msg->len;
+	idev->buf = this_msg->buf;
 	idev->msg_err = 0;
 
-	reinit_completion(&idev->msg_complete);
+	if (idev->total_num > 1) {
+		struct i2c_msg *next_msg = msgs + 1;
 
-	mchp_corei2c_core_enable(idev);
+		idev->restart_needed = next_msg->flags & I2C_M_RD;
+	}
 
+	idev->current_num++;
+	idev->msg_queue++;
+
+	reinit_completion(&idev->msg_complete);
+
+	/*
+	 * Send the first start to pass control to the isr
+	 */
 	ctrl = readb(idev->base + CORE_I2C_CTRL);
 	ctrl |= CTRL_STA;
 	writeb(ctrl, idev->base + CORE_I2C_CTRL);
@@ -335,20 +415,8 @@ static int mchp_corei2c_xfer_msg(struct
 	if (!time_left)
 		return -ETIMEDOUT;
 
-	return idev->msg_err;
-}
-
-static int mchp_corei2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
-			     int num)
-{
-	struct mchp_corei2c_dev *idev = i2c_get_adapdata(adap);
-	int i, ret;
-
-	for (i = 0; i < num; i++) {
-		ret = mchp_corei2c_xfer_msg(idev, msgs++);
-		if (ret)
-			return ret;
-	}
+	if (idev->msg_err)
+		return idev->msg_err;
 
 	return num;
 }



