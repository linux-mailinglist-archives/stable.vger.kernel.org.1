Return-Path: <stable+bounces-143147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7086AB32AE
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 11:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474331884D9A
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 09:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E355113212A;
	Mon, 12 May 2025 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="itvyCEVN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FB724E4CE
	for <stable@vger.kernel.org>; Mon, 12 May 2025 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040635; cv=none; b=JU50AHa5k79BTjDRhAbImYBh8FfdslwR0I91Zl8b3sIW5TmpExw4ZRJfeVeLRxFXLipny9KCWQzEm1XyfMo0HYbnOpSCUqR/0XDK9T6yB3Bjob4hEbsFo0xf516xtZUnHGRS61l6AHQ3clkMDftuXQE7PjZlTkHzgZbPg1MJIsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040635; c=relaxed/simple;
	bh=WwffPRsCwbcRc/FjW7SQhH/9LgFZ71oV3n2HWm0OJPQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N7nGJPghlIXT0DLgHQ0M5Bde/G75pR2UlpdHTqtb4nLlgT8XmntfVbOdlkvBFBsibP0zUYGHv068r/PVi7oxNGGhLOmvX0eZa6PpgTph0CUdqjjKLf9TZDbp5kxX9Y1ol4zydaR+TxjumrpGKW21B9CG85QqEoe3H9/O4DQr+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=itvyCEVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78FAC4CEE7;
	Mon, 12 May 2025 09:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747040634;
	bh=WwffPRsCwbcRc/FjW7SQhH/9LgFZ71oV3n2HWm0OJPQ=;
	h=Subject:To:Cc:From:Date:From;
	b=itvyCEVNom/WJSHMcMaii5/jhz+iMDyvl2CoaTvoVJOCzeqLJ1KAz0u4IPD6dtgfJ
	 XrpUcXi1QuQR3oaEf1+hd7HIhIHURsGYklLBiLfYn1g0V63KH7rwS7CHaymdqkGN5b
	 VOk2xyOfdPqThPm6QYYIrPxntXX7pX3/cX3xNW7I=
Subject: FAILED: patch "[PATCH] staging: axis-fifo: Remove hardware resets for user errors" failed to apply to 5.4-stable tree
To: gshahrouzi@gmail.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 11:03:51 +0200
Message-ID: <2025051251-pardon-stellar-d13f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x c6e8d85fafa7193613db37da29c0e8d6e2515b13
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051251-pardon-stellar-d13f@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c6e8d85fafa7193613db37da29c0e8d6e2515b13 Mon Sep 17 00:00:00 2001
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Fri, 18 Apr 2025 20:43:06 -0400
Subject: [PATCH] staging: axis-fifo: Remove hardware resets for user errors

The axis-fifo driver performs a full hardware reset (via
reset_ip_core()) in several error paths within the read and write
functions. This reset flushes both TX and RX FIFOs and resets the
AXI-Stream links.

Allow the user to handle the error without causing hardware disruption
or data loss in other FIFO paths.

Fixes: 4a965c5f89de ("staging: add driver for Xilinx AXI-Stream FIFO v4.1 IP core")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Link: https://lore.kernel.org/r/20250419004306.669605-1-gshahrouzi@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 04b3dc3cfe7c..351f983ef914 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -393,16 +393,14 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 
 	bytes_available = ioread32(fifo->base_addr + XLLF_RLR_OFFSET);
 	if (!bytes_available) {
-		dev_err(fifo->dt_device, "received a packet of length 0 - fifo core will be reset\n");
-		reset_ip_core(fifo);
+		dev_err(fifo->dt_device, "received a packet of length 0\n");
 		ret = -EIO;
 		goto end_unlock;
 	}
 
 	if (bytes_available > len) {
-		dev_err(fifo->dt_device, "user read buffer too small (available bytes=%zu user buffer bytes=%zu) - fifo core will be reset\n",
+		dev_err(fifo->dt_device, "user read buffer too small (available bytes=%zu user buffer bytes=%zu)\n",
 			bytes_available, len);
-		reset_ip_core(fifo);
 		ret = -EINVAL;
 		goto end_unlock;
 	}
@@ -411,8 +409,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		/* this probably can't happen unless IP
 		 * registers were previously mishandled
 		 */
-		dev_err(fifo->dt_device, "received a packet that isn't word-aligned - fifo core will be reset\n");
-		reset_ip_core(fifo);
+		dev_err(fifo->dt_device, "received a packet that isn't word-aligned\n");
 		ret = -EIO;
 		goto end_unlock;
 	}
@@ -433,7 +430,6 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 
 		if (copy_to_user(buf + copied * sizeof(u32), tmp_buf,
 				 copy * sizeof(u32))) {
-			reset_ip_core(fifo);
 			ret = -EFAULT;
 			goto end_unlock;
 		}
@@ -542,7 +538,6 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 
 		if (copy_from_user(tmp_buf, buf + copied * sizeof(u32),
 				   copy * sizeof(u32))) {
-			reset_ip_core(fifo);
 			ret = -EFAULT;
 			goto end_unlock;
 		}


