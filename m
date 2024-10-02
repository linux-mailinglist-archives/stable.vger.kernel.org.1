Return-Path: <stable+bounces-78622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB1098D0ED
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CD41F235C3
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 10:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332701E5018;
	Wed,  2 Oct 2024 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VrfhTbvy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F921E501B
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863948; cv=none; b=kcg/4vtIfqTEpb8ZRxHz5PfL6cR1O993wx6NjUqPOgvDxRwsiGmF4mMOKMwIIS5n/cf9u03WmpmnJfsO9Nm51TA+22RRR8z2aRrJ33x+DA/vBeXtWcSnF9m5+cMzceQJVDpL5gKj0LL/sOYFvAAYtGUWp/V/HB3ho/w7sryb4H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863948; c=relaxed/simple;
	bh=+sd9Lc0zTP07Kw7FhVssSUYAHVZO2d9Yr0vEsbDf3nU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qlyd3kL1HjHvlB0cVJU86u2cL3OdFX0E9yAHwmE0QeZKjfMnvsqFxoy+C+K73GKBiUYHLFaSmZGnGk9RiZEnmildkVpeaq1hGlFiGGItnSI/xBVnbxB4X6F7CstlsLEcMRQ+i5OVczWY/Goq7DBMaDELAL/l2gVtZ400JlWxELQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VrfhTbvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EB6C4CEC5;
	Wed,  2 Oct 2024 10:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727863947;
	bh=+sd9Lc0zTP07Kw7FhVssSUYAHVZO2d9Yr0vEsbDf3nU=;
	h=Subject:To:Cc:From:Date:From;
	b=VrfhTbvyFRMPiVdPN8PxeFDC6xfQJZQTyDrs8PUF/zSD9H0GdVDMB2v0JQ7V6Tc8+
	 PKxw/7F+Rdrrh3STYjOPql1BfN4uSy/c2c22PgAfWv6QdalI/Gj39SJjYHS2cqKPGn
	 BeLluPSOX/PCL62PcNUhz9hJ9K9W0AjTNfznPtmQ=
Subject: FAILED: patch "[PATCH] i2c: xiic: Try re-initialization on bus busy timeout" failed to apply to 5.15-stable tree
To: robert.hancock@calian.com,andi.shyti@kernel.org,manikanta.guntupalli@amd.com,michal.simek@amd.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 02 Oct 2024 12:12:18 +0200
Message-ID: <2024100217-schematic-oil-69e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1d4a1adbed2582444aaf97671858b7d12915bd05
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100217-schematic-oil-69e2@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

1d4a1adbed25 ("i2c: xiic: Try re-initialization on bus busy timeout")
ee1691d0ae10 ("i2c: xiic: improve error message when transfer fails to start")
d663d93bb47e ("i2c: xiic: xiic_xfer(): Fix runtime PM leak on error path")
294b29f15469 ("i2c: xiic: Fix RX IRQ busy check")
c119e7d00c91 ("i2c: xiic: Fix broken locking on tx_msg")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1d4a1adbed2582444aaf97671858b7d12915bd05 Mon Sep 17 00:00:00 2001
From: Robert Hancock <robert.hancock@calian.com>
Date: Wed, 11 Sep 2024 22:16:53 +0200
Subject: [PATCH] i2c: xiic: Try re-initialization on bus busy timeout

In the event that the I2C bus was powered down when the I2C controller
driver loads, or some spurious pulses occur on the I2C bus, it's
possible that the controller detects a spurious I2C "start" condition.
In this situation it may continue to report the bus is busy indefinitely
and block the controller from working.

The "single-master" DT flag can be specified to disable bus busy checks
entirely, but this may not be safe to use in situations where other I2C
masters may potentially exist.

In the event that the controller reports "bus busy" for too long when
starting a transaction, we can try reinitializing the controller to see
if the busy condition clears. This allows recovering from this scenario.

Fixes: e1d5b6598cdc ("i2c: Add support for Xilinx XPS IIC Bus Interface")
Signed-off-by: Robert Hancock <robert.hancock@calian.com>
Cc: <stable@vger.kernel.org> # v2.6.34+
Reviewed-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index bd6e107472b7..4c89aad02451 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -843,23 +843,11 @@ static int xiic_bus_busy(struct xiic_i2c *i2c)
 	return (sr & XIIC_SR_BUS_BUSY_MASK) ? -EBUSY : 0;
 }
 
-static int xiic_busy(struct xiic_i2c *i2c)
+static int xiic_wait_not_busy(struct xiic_i2c *i2c)
 {
 	int tries = 3;
 	int err;
 
-	if (i2c->tx_msg || i2c->rx_msg)
-		return -EBUSY;
-
-	/* In single master mode bus can only be busy, when in use by this
-	 * driver. If the register indicates bus being busy for some reason we
-	 * should ignore it, since bus will never be released and i2c will be
-	 * stuck forever.
-	 */
-	if (i2c->singlemaster) {
-		return 0;
-	}
-
 	/* for instance if previous transfer was terminated due to TX error
 	 * it might be that the bus is on it's way to become available
 	 * give it at most 3 ms to wake
@@ -1103,13 +1091,36 @@ static int xiic_start_xfer(struct xiic_i2c *i2c, struct i2c_msg *msgs, int num)
 
 	mutex_lock(&i2c->lock);
 
-	ret = xiic_busy(i2c);
-	if (ret) {
+	if (i2c->tx_msg || i2c->rx_msg) {
 		dev_err(i2c->adap.dev.parent,
 			"cannot start a transfer while busy\n");
+		ret = -EBUSY;
 		goto out;
 	}
 
+	/* In single master mode bus can only be busy, when in use by this
+	 * driver. If the register indicates bus being busy for some reason we
+	 * should ignore it, since bus will never be released and i2c will be
+	 * stuck forever.
+	 */
+	if (!i2c->singlemaster) {
+		ret = xiic_wait_not_busy(i2c);
+		if (ret) {
+			/* If the bus is stuck in a busy state, such as due to spurious low
+			 * pulses on the bus causing a false start condition to be detected,
+			 * then try to recover by re-initializing the controller and check
+			 * again if the bus is still busy.
+			 */
+			dev_warn(i2c->adap.dev.parent, "I2C bus busy timeout, reinitializing\n");
+			ret = xiic_reinit(i2c);
+			if (ret)
+				goto out;
+			ret = xiic_wait_not_busy(i2c);
+			if (ret)
+				goto out;
+		}
+	}
+
 	i2c->tx_msg = msgs;
 	i2c->rx_msg = NULL;
 	i2c->nmsgs = num;


