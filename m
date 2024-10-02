Return-Path: <stable+bounces-78625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4DD98D0F0
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFC81B23BFC
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 10:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0381E5031;
	Wed,  2 Oct 2024 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1/6pKajl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883B01E501B
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863958; cv=none; b=cfKA12p6ARoCvDbipBGobHNH4N/b2s99isOfFpyYDLZvaoJC45Gp7PhZjn3NQMH+VtWNpr7srzWqaMeMKHGXYBPapgt6+51vF1u39BCx32nrAg9dZTRRh+F3Ftp15Wvgqua5iXG21Q8c7OjHJcnMUcdWaMmkD9jJJYkWPtnUXLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863958; c=relaxed/simple;
	bh=9HYTwCriuihD2tvmInZszJ7EQuNRggE1kXjoEiqTMzU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Dxefat5VBLnInxHADf5g33yJjCRoGOAjHacj4/n+6/S5BvJ5YUJ7iT2zZASsQCYRv1VEyxP9qAk19JTBo80pWqaEtlTaTDQMdf5jFYBFMnp2CuTSqmGcYi/Rfv7JqxpaG9xFk1FgMvmB8PNg968X7zHuMLRDL0F7LCX+9KuumJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1/6pKajl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6CFC4CEC5;
	Wed,  2 Oct 2024 10:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727863958;
	bh=9HYTwCriuihD2tvmInZszJ7EQuNRggE1kXjoEiqTMzU=;
	h=Subject:To:Cc:From:Date:From;
	b=1/6pKajlAwqfYIqo9ez0jzNCFQ6q+1LOaSan5IHzfgWdnXw/LL4kYbr055hcDiQQr
	 lJ0Tq5w57BrLhkAlJndJ3M0xQn6vxAUwhUUcRJohFifs4mflCMJmyRYDzoRPVgCdqN
	 CZ9/gINu2wi0V2E4xQGn5hajabEwClN7g9y9bdT4=
Subject: FAILED: patch "[PATCH] i2c: xiic: Try re-initialization on bus busy timeout" failed to apply to 4.19-stable tree
To: robert.hancock@calian.com,andi.shyti@kernel.org,manikanta.guntupalli@amd.com,michal.simek@amd.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 02 Oct 2024 12:12:20 +0200
Message-ID: <2024100220-hazard-sharper-437c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 1d4a1adbed2582444aaf97671858b7d12915bd05
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100220-hazard-sharper-437c@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

1d4a1adbed25 ("i2c: xiic: Try re-initialization on bus busy timeout")
ee1691d0ae10 ("i2c: xiic: improve error message when transfer fails to start")
d663d93bb47e ("i2c: xiic: xiic_xfer(): Fix runtime PM leak on error path")
294b29f15469 ("i2c: xiic: Fix RX IRQ busy check")
c119e7d00c91 ("i2c: xiic: Fix broken locking on tx_msg")
9e3b184b3b4f ("i2c: xiic: Support forcing single-master in DT")
9106e45ceaaf ("i2c: xiic: Improve struct memory alignment")
0a9336ee133d ("i2c: xiic: Change code alignment to 1 space only")
b4c119dbc300 ("i2c: xiic: Add timeout to the rx fifo wait loop")
bcc156e2289d ("i2c: xiic: Fix kerneldoc warnings")

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


