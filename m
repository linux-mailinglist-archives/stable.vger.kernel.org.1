Return-Path: <stable+bounces-50599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D79D906B7C
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05903284B9A
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D31143C41;
	Thu, 13 Jun 2024 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="izDw8Gcq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80AC144D36;
	Thu, 13 Jun 2024 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278838; cv=none; b=aEICi/y4iOkZ2C4q+NSvCfFUXn5XUYi47pGKgwxZ8dDCntvIrqTdlyUvlZ0uvrLEdFmRrYhCmQXaXCjR04ETtSVD7XP6ex2l5hK6iAGcsUM/7BjMiLt71sUeblXPeC4pASXovO/dGQulwBroC2H3O9yKXAScdf28R3Ot7Zm3MRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278838; c=relaxed/simple;
	bh=UKAX7tUSFadzbyjVWwIIx2vPgG7YAU9YXVdI5s5YOtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtHBSRa8CpA1LB9ftI+ywmAFzHJT8+J0FbE+SdlDMEbwi8DEmDnB3yDjL0caMqGlPuSIfNB/+KINZ0znMjj4wRa1g4xnocWYqThjMOeLFg+7+nQoL4Tthd2ZSzibK06ei2+G5EAsTKKA+XFECcGR+D+f41AVWRZCTzytWkNYdLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=izDw8Gcq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D873AC32786;
	Thu, 13 Jun 2024 11:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718278838;
	bh=UKAX7tUSFadzbyjVWwIIx2vPgG7YAU9YXVdI5s5YOtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=izDw8GcqhYZB812Z/fuwKEyLsfV7uY77u+mlfBXqxW4aafIYVGQ2fv3oVRsAEvr+x
	 la/IGoSC0y8bH8opT7k1gS4c7FcDbHdE9RlBblRkIPEvdkN2Up7V88AmP0oQJOzxa4
	 AtRGalF6d2+6RlJb+yQs4TgnNoFiFA0q6SWNGVfE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Finn Thain <fthain@telegraphics.com.au>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 045/213] macintosh/via-macii, macintosh/adb-iop: Clean up whitespace
Date: Thu, 13 Jun 2024 13:31:33 +0200
Message-ID: <20240613113229.742711292@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>
References: <20240613113227.969123070@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@telegraphics.com.au>

[ Upstream commit 47fd2060660e62b169990a6fcd9eb61bc1a85c5c ]

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Stable-dep-of: d301a71c76ee ("macintosh/via-macii: Fix "BUG: sleeping function called from invalid context"")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/macintosh/adb-iop.c   |  48 +++---
 drivers/macintosh/via-macii.c | 288 +++++++++++++++++-----------------
 2 files changed, 175 insertions(+), 161 deletions(-)

diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index ca623e6446e4c..17280410e930a 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -20,13 +20,13 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 
-#include <asm/macintosh.h> 
-#include <asm/macints.h> 
+#include <asm/macintosh.h>
+#include <asm/macints.h>
 #include <asm/mac_iop.h>
 #include <asm/mac_oss.h>
 #include <asm/adb_iop.h>
 
-#include <linux/adb.h> 
+#include <linux/adb.h>
 
 /*#define DEBUG_ADB_IOP*/
 
@@ -38,9 +38,9 @@ static unsigned char *reply_ptr;
 #endif
 
 static enum adb_iop_state {
-    idle,
-    sending,
-    awaiting_reply
+	idle,
+	sending,
+	awaiting_reply
 } adb_iop_state;
 
 static void adb_iop_start(void);
@@ -66,7 +66,8 @@ static void adb_iop_end_req(struct adb_request *req, int state)
 {
 	req->complete = 1;
 	current_req = req->next;
-	if (req->done) (*req->done)(req);
+	if (req->done)
+		(*req->done)(req);
 	adb_iop_state = state;
 }
 
@@ -100,7 +101,7 @@ static void adb_iop_complete(struct iop_msg *msg)
 
 static void adb_iop_listen(struct iop_msg *msg)
 {
-	struct adb_iopmsg *amsg = (struct adb_iopmsg *) msg->message;
+	struct adb_iopmsg *amsg = (struct adb_iopmsg *)msg->message;
 	struct adb_request *req;
 	unsigned long flags;
 #ifdef DEBUG_ADB_IOP
@@ -113,9 +114,9 @@ static void adb_iop_listen(struct iop_msg *msg)
 
 #ifdef DEBUG_ADB_IOP
 	printk("adb_iop_listen %p: rcvd packet, %d bytes: %02X %02X", req,
-		(uint) amsg->count + 2, (uint) amsg->flags, (uint) amsg->cmd);
+	       (uint)amsg->count + 2, (uint)amsg->flags, (uint)amsg->cmd);
 	for (i = 0; i < amsg->count; i++)
-		printk(" %02X", (uint) amsg->data[i]);
+		printk(" %02X", (uint)amsg->data[i]);
 	printk("\n");
 #endif
 
@@ -168,14 +169,15 @@ static void adb_iop_start(void)
 
 	/* get the packet to send */
 	req = current_req;
-	if (!req) return;
+	if (!req)
+		return;
 
 	local_irq_save(flags);
 
 #ifdef DEBUG_ADB_IOP
 	printk("adb_iop_start %p: sending packet, %d bytes:", req, req->nbytes);
-	for (i = 0 ; i < req->nbytes ; i++)
-		printk(" %02X", (uint) req->data[i]);
+	for (i = 0; i < req->nbytes; i++)
+		printk(" %02X", (uint)req->data[i]);
 	printk("\n");
 #endif
 
@@ -196,13 +198,14 @@ static void adb_iop_start(void)
 	/* Now send it. The IOP manager will call adb_iop_complete */
 	/* when the packet has been sent.                          */
 
-	iop_send_message(ADB_IOP, ADB_CHAN, req,
-			 sizeof(amsg), (__u8 *) &amsg, adb_iop_complete);
+	iop_send_message(ADB_IOP, ADB_CHAN, req, sizeof(amsg), (__u8 *)&amsg,
+			 adb_iop_complete);
 }
 
 int adb_iop_probe(void)
 {
-	if (!iop_ism_present) return -ENODEV;
+	if (!iop_ism_present)
+		return -ENODEV;
 	return 0;
 }
 
@@ -218,10 +221,12 @@ int adb_iop_send_request(struct adb_request *req, int sync)
 	int err;
 
 	err = adb_iop_write(req);
-	if (err) return err;
+	if (err)
+		return err;
 
 	if (sync) {
-		while (!req->complete) adb_iop_poll();
+		while (!req->complete)
+			adb_iop_poll();
 	}
 	return 0;
 }
@@ -251,7 +256,9 @@ static int adb_iop_write(struct adb_request *req)
 	}
 
 	local_irq_restore(flags);
-	if (adb_iop_state == idle) adb_iop_start();
+
+	if (adb_iop_state == idle)
+		adb_iop_start();
 	return 0;
 }
 
@@ -263,7 +270,8 @@ int adb_iop_autopoll(int devs)
 
 void adb_iop_poll(void)
 {
-	if (adb_iop_state == idle) adb_iop_start();
+	if (adb_iop_state == idle)
+		adb_iop_start();
 	iop_ism_irq_poll(ADB_IOP);
 }
 
diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index fc6ad5bf1875a..177c3ef59c875 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -12,7 +12,7 @@
  *
  * 1999-08-02 (jmt) - Initial rewrite for Unified ADB.
  * 2000-03-29 Tony Mantler <tonym@mac.linux-m68k.org>
- * 				- Big overhaul, should actually work now.
+ *            - Big overhaul, should actually work now.
  * 2006-12-31 Finn Thain - Another overhaul.
  *
  * Suggested reading:
@@ -23,7 +23,7 @@
  * Apple's "ADB Analyzer" bus sniffer is invaluable:
  *   ftp://ftp.apple.com/developer/Tool_Chest/Devices_-_Hardware/Apple_Desktop_Bus/
  */
- 
+
 #include <stdarg.h>
 #include <linux/types.h>
 #include <linux/errno.h>
@@ -77,7 +77,7 @@ static volatile unsigned char *via;
 #define ST_ODD		0x20		/* ADB state: odd data byte */
 #define ST_IDLE		0x30		/* ADB state: idle, nothing to send */
 
-static int  macii_init_via(void);
+static int macii_init_via(void);
 static void macii_start(void);
 static irqreturn_t macii_interrupt(int irq, void *arg);
 static void macii_queue_poll(void);
@@ -123,7 +123,8 @@ static int autopoll_devs;      /* bits set are device addresses to be polled */
 /* Check for MacII style ADB */
 static int macii_probe(void)
 {
-	if (macintosh_config->adb_type != MAC_ADB_II) return -ENODEV;
+	if (macintosh_config->adb_type != MAC_ADB_II)
+		return -ENODEV;
 
 	via = via1;
 
@@ -136,15 +137,17 @@ int macii_init(void)
 {
 	unsigned long flags;
 	int err;
-	
+
 	local_irq_save(flags);
-	
+
 	err = macii_init_via();
-	if (err) goto out;
+	if (err)
+		goto out;
 
 	err = request_irq(IRQ_MAC_ADB, macii_interrupt, 0, "ADB",
 			  macii_interrupt);
-	if (err) goto out;
+	if (err)
+		goto out;
 
 	macii_state = idle;
 out:
@@ -152,7 +155,7 @@ int macii_init(void)
 	return err;
 }
 
-/* initialize the hardware */	
+/* initialize the hardware */
 static int macii_init_via(void)
 {
 	unsigned char x;
@@ -162,7 +165,7 @@ static int macii_init_via(void)
 
 	/* Set up state: idle */
 	via[B] |= ST_IDLE;
-	last_status = via[B] & (ST_MASK|CTLR_IRQ);
+	last_status = via[B] & (ST_MASK | CTLR_IRQ);
 
 	/* Shift register on input */
 	via[ACR] = (via[ACR] & ~SR_CTRL) | SR_EXT;
@@ -188,7 +191,8 @@ static void macii_queue_poll(void)
 	int next_device;
 	static struct adb_request req;
 
-	if (!autopoll_devs) return;
+	if (!autopoll_devs)
+		return;
 
 	device_mask = (1 << (((command_byte & 0xF0) >> 4) + 1)) - 1;
 	if (autopoll_devs & ~device_mask)
@@ -196,8 +200,7 @@ static void macii_queue_poll(void)
 	else
 		next_device = ffs(autopoll_devs) - 1;
 
-	adb_request(&req, NULL, ADBREQ_NOSEND, 1,
-	            ADB_READREG(next_device, 0));
+	adb_request(&req, NULL, ADBREQ_NOSEND, 1, ADB_READREG(next_device, 0));
 
 	req.sent = 0;
 	req.complete = 0;
@@ -236,7 +239,7 @@ static int macii_write(struct adb_request *req)
 		req->complete = 1;
 		return -EINVAL;
 	}
-	
+
 	req->next = NULL;
 	req->sent = 0;
 	req->complete = 0;
@@ -248,7 +251,8 @@ static int macii_write(struct adb_request *req)
 	} else {
 		current_req = req;
 		last_req = req;
-		if (macii_state == idle) macii_start();
+		if (macii_state == idle)
+			macii_start();
 	}
 	return 0;
 }
@@ -263,7 +267,8 @@ static int macii_autopoll(int devs)
 	/* bit 1 == device 1, and so on. */
 	autopoll_devs = devs & 0xFFFE;
 
-	if (!autopoll_devs) return 0;
+	if (!autopoll_devs)
+		return 0;
 
 	local_irq_save(flags);
 
@@ -280,7 +285,8 @@ static int macii_autopoll(int devs)
 	return err;
 }
 
-static inline int need_autopoll(void) {
+static inline int need_autopoll(void)
+{
 	/* Was the last command Talk Reg 0
 	 * and is the target on the autopoll list?
 	 */
@@ -302,7 +308,7 @@ static void macii_poll(void)
 static int macii_reset_bus(void)
 {
 	static struct adb_request req;
-	
+
 	/* Command = 0, Address = ignored */
 	adb_request(&req, NULL, 0, 1, ADB_BUSRESET);
 
@@ -344,7 +350,7 @@ static void macii_start(void)
  * to be activity on the ADB bus. The chip will poll to achieve this.
  *
  * The basic ADB state machine was left unchanged from the original MacII code
- * by Alan Cox, which was based on the CUDA driver for PowerMac. 
+ * by Alan Cox, which was based on the CUDA driver for PowerMac.
  * The syntax of the ADB status lines is totally different on MacII,
  * though. MacII uses the states Command -> Even -> Odd -> Even ->...-> Idle
  * for sending and Idle -> Even -> Odd -> Even ->...-> Idle for receiving.
@@ -367,147 +373,147 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 	}
 
 	last_status = status;
-	status = via[B] & (ST_MASK|CTLR_IRQ);
+	status = via[B] & (ST_MASK | CTLR_IRQ);
 
 	switch (macii_state) {
-		case idle:
-			if (reading_reply) {
-				reply_ptr = current_req->reply;
-			} else {
-				WARN_ON(current_req);
-				reply_ptr = reply_buf;
-			}
+	case idle:
+		if (reading_reply) {
+			reply_ptr = current_req->reply;
+		} else {
+			WARN_ON(current_req);
+			reply_ptr = reply_buf;
+		}
+
+		x = via[SR];
+
+		if ((status & CTLR_IRQ) && (x == 0xFF)) {
+			/* Bus timeout without SRQ sequence:
+			 *     data is "FF" while CTLR_IRQ is "H"
+			 */
+			reply_len = 0;
+			srq_asserted = 0;
+			macii_state = read_done;
+		} else {
+			macii_state = reading;
+			*reply_ptr = x;
+			reply_len = 1;
+		}
+
+		/* set ADB state = even for first data byte */
+		via[B] = (via[B] & ~ST_MASK) | ST_EVEN;
+		break;
 
-			x = via[SR];
+	case sending:
+		req = current_req;
+		if (data_index >= req->nbytes) {
+			req->sent = 1;
+			macii_state = idle;
 
-			if ((status & CTLR_IRQ) && (x == 0xFF)) {
-				/* Bus timeout without SRQ sequence:
-				 *     data is "FF" while CTLR_IRQ is "H"
-				 */
-				reply_len = 0;
-				srq_asserted = 0;
-				macii_state = read_done;
+			if (req->reply_expected) {
+				reading_reply = 1;
 			} else {
-				macii_state = reading;
-				*reply_ptr = x;
-				reply_len = 1;
-			}
+				req->complete = 1;
+				current_req = req->next;
+				if (req->done)
+					(*req->done)(req);
 
-			/* set ADB state = even for first data byte */
-			via[B] = (via[B] & ~ST_MASK) | ST_EVEN;
-			break;
+				if (current_req)
+					macii_start();
+				else if (need_autopoll())
+					macii_autopoll(autopoll_devs);
+			}
 
-		case sending:
-			req = current_req;
-			if (data_index >= req->nbytes) {
-				req->sent = 1;
-				macii_state = idle;
-
-				if (req->reply_expected) {
-					reading_reply = 1;
-				} else {
-					req->complete = 1;
-					current_req = req->next;
-					if (req->done) (*req->done)(req);
-
-					if (current_req)
-						macii_start();
-					else
-						if (need_autopoll())
-							macii_autopoll(autopoll_devs);
-				}
+			if (macii_state == idle) {
+				/* reset to shift in */
+				via[ACR] &= ~SR_OUT;
+				x = via[SR];
+				/* set ADB state idle - might get SRQ */
+				via[B] = (via[B] & ~ST_MASK) | ST_IDLE;
+			}
+		} else {
+			via[SR] = req->data[data_index++];
 
-				if (macii_state == idle) {
-					/* reset to shift in */
-					via[ACR] &= ~SR_OUT;
-					x = via[SR];
-					/* set ADB state idle - might get SRQ */
-					via[B] = (via[B] & ~ST_MASK) | ST_IDLE;
-				}
+			if ((via[B] & ST_MASK) == ST_CMD) {
+				/* just sent the command byte, set to EVEN */
+				via[B] = (via[B] & ~ST_MASK) | ST_EVEN;
 			} else {
-				via[SR] = req->data[data_index++];
-
-				if ( (via[B] & ST_MASK) == ST_CMD ) {
-					/* just sent the command byte, set to EVEN */
-					via[B] = (via[B] & ~ST_MASK) | ST_EVEN;
-				} else {
-					/* invert state bits, toggle ODD/EVEN */
-					via[B] ^= ST_MASK;
-				}
+				/* invert state bits, toggle ODD/EVEN */
+				via[B] ^= ST_MASK;
 			}
-			break;
-
-		case reading:
-			x = via[SR];
-			WARN_ON((status & ST_MASK) == ST_CMD ||
-				(status & ST_MASK) == ST_IDLE);
-
-			/* Bus timeout with SRQ sequence:
-			 *     data is "XX FF"      while CTLR_IRQ is "L L"
-			 * End of packet without SRQ sequence:
-			 *     data is "XX...YY 00" while CTLR_IRQ is "L...H L"
-			 * End of packet SRQ sequence:
-			 *     data is "XX...YY 00" while CTLR_IRQ is "L...L L"
-			 * (where XX is the first response byte and
-			 * YY is the last byte of valid response data.)
-			 */
+		}
+		break;
 
-			srq_asserted = 0;
-			if (!(status & CTLR_IRQ)) {
-				if (x == 0xFF) {
-					if (!(last_status & CTLR_IRQ)) {
-						macii_state = read_done;
-						reply_len = 0;
-						srq_asserted = 1;
-					}
-				} else if (x == 0x00) {
+	case reading:
+		x = via[SR];
+		WARN_ON((status & ST_MASK) == ST_CMD ||
+			(status & ST_MASK) == ST_IDLE);
+
+		/* Bus timeout with SRQ sequence:
+		 *     data is "XX FF"      while CTLR_IRQ is "L L"
+		 * End of packet without SRQ sequence:
+		 *     data is "XX...YY 00" while CTLR_IRQ is "L...H L"
+		 * End of packet SRQ sequence:
+		 *     data is "XX...YY 00" while CTLR_IRQ is "L...L L"
+		 * (where XX is the first response byte and
+		 * YY is the last byte of valid response data.)
+		 */
+
+		srq_asserted = 0;
+		if (!(status & CTLR_IRQ)) {
+			if (x == 0xFF) {
+				if (!(last_status & CTLR_IRQ)) {
 					macii_state = read_done;
-					if (!(last_status & CTLR_IRQ))
-						srq_asserted = 1;
+					reply_len = 0;
+					srq_asserted = 1;
 				}
+			} else if (x == 0x00) {
+				macii_state = read_done;
+				if (!(last_status & CTLR_IRQ))
+					srq_asserted = 1;
 			}
+		}
 
-			if (macii_state == reading &&
-			    reply_len < ARRAY_SIZE(reply_buf)) {
-				reply_ptr++;
-				*reply_ptr = x;
-				reply_len++;
-			}
-
-			/* invert state bits, toggle ODD/EVEN */
-			via[B] ^= ST_MASK;
-			break;
+		if (macii_state == reading &&
+		    reply_len < ARRAY_SIZE(reply_buf)) {
+			reply_ptr++;
+			*reply_ptr = x;
+			reply_len++;
+		}
 
-		case read_done:
-			x = via[SR];
-
-			if (reading_reply) {
-				reading_reply = 0;
-				req = current_req;
-				req->reply_len = reply_len;
-				req->complete = 1;
-				current_req = req->next;
-				if (req->done) (*req->done)(req);
-			} else if (reply_len && autopoll_devs)
-				adb_input(reply_buf, reply_len, 0);
-
-			macii_state = idle;
-
-			/* SRQ seen before, initiate poll now */
-			if (srq_asserted)
-				macii_queue_poll();
+		/* invert state bits, toggle ODD/EVEN */
+		via[B] ^= ST_MASK;
+		break;
 
-			if (current_req)
-				macii_start();
-			else
-				if (need_autopoll())
-					macii_autopoll(autopoll_devs);
+	case read_done:
+		x = via[SR];
 
-			if (macii_state == idle)
-				via[B] = (via[B] & ~ST_MASK) | ST_IDLE;
-			break;
+		if (reading_reply) {
+			reading_reply = 0;
+			req = current_req;
+			req->reply_len = reply_len;
+			req->complete = 1;
+			current_req = req->next;
+			if (req->done)
+				(*req->done)(req);
+		} else if (reply_len && autopoll_devs)
+			adb_input(reply_buf, reply_len, 0);
+
+		macii_state = idle;
+
+		/* SRQ seen before, initiate poll now */
+		if (srq_asserted)
+			macii_queue_poll();
+
+		if (current_req)
+			macii_start();
+		else if (need_autopoll())
+			macii_autopoll(autopoll_devs);
+
+		if (macii_state == idle)
+			via[B] = (via[B] & ~ST_MASK) | ST_IDLE;
+		break;
 
-		default:
+	default:
 		break;
 	}
 
-- 
2.43.0




