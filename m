Return-Path: <stable+bounces-183975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83701BCD3F2
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 15:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5826188857C
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 13:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B0F2F5A31;
	Fri, 10 Oct 2025 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NpmkIYKt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E792F290C;
	Fri, 10 Oct 2025 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102519; cv=none; b=TyZyfcfpAHw2GUw93CI4cWk8TIUXRxis/W5zL5cwX/yqmgBT2DocwCdLstMauRLyD0hmfDSflRE9TEgrMWCklxWkFC2Oefq2uuFR+U4ZyICnTRHN4V1QG5X2C/VJcYIQY4pJqj927t/T519nDohQDnP5lGYECVSGp1GAfatDONA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102519; c=relaxed/simple;
	bh=4umhmw5yt66Rb/9oJ4neMxf9NzixPcSDZjS6dZ0GwjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/kCmcMarbAmXqGZtD9MCrKo9xE7VJwj9nwCublrsiniBkRI0lnOM6M0WhvAYRBJP5+0ev4jlgt79ab8NlnXgNQfo4LF+gMCFiCch4Jk2EXHsVYuvIZ8n+zcwZ6Z3SOaprA1zt6mUOXmKECt6Av371J8OF3mb5vB5FuUj1yKj3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NpmkIYKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7695AC4CEF1;
	Fri, 10 Oct 2025 13:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760102518;
	bh=4umhmw5yt66Rb/9oJ4neMxf9NzixPcSDZjS6dZ0GwjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NpmkIYKtf8HlzEnMzTIFBPh34hyza/N2MHyBmuJqMKNs83F6OukLxjnAmKYurNqd9
	 aZD5+HThmelN9b22EJwTbkSFalQ+pv6n4Y2jqlychpwHyNezo/dneNnuSdJafaRIsy
	 6YpWXtN3ukAx6vUm0zYRY3XCC07fWg5amLZ3yDF0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Subject: [PATCH 6.12 30/35] staging: axis-fifo: fix TX handling on copy_from_user() failure
Date: Fri, 10 Oct 2025 15:16:32 +0200
Message-ID: <20251010131332.878440347@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010131331.785281312@linuxfoundation.org>
References: <20251010131331.785281312@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>

commit 6d07bee10e4bdd043ec7152cbbb9deb27033c9e2 upstream.

If copy_from_user() fails, write() currently returns -EFAULT, but any
partially written data leaves the TX FIFO in an inconsistent state.
Subsequent write() calls then fail with "transmit length mismatch"
errors.

Once partial data is written to the hardware FIFO, it cannot be removed
without a TX reset. Commit c6e8d85fafa7 ("staging: axis-fifo: Remove
hardware resets for user errors") removed a full FIFO reset for this case,
which fixed a potential RX data loss, but introduced this TX issue.

Fix this by introducing a bounce buffer: copy the full packet from
userspace first, and write to the hardware FIFO only if the copy
was successful.

Fixes: c6e8d85fafa7 ("staging: axis-fifo: Remove hardware resets for user errors")
Cc: stable@vger.kernel.org
Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Link: https://lore.kernel.org/r/20250912101322.1282507-1-ovidiu.panait.oss@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/axis-fifo/axis-fifo.c |   36 +++++++++-------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -42,7 +42,6 @@
 #define DRIVER_NAME "axis_fifo"
 
 #define READ_BUF_SIZE 128U /* read buffer length in words */
-#define WRITE_BUF_SIZE 128U /* write buffer length in words */
 
 /* ----------------------------
  *     IP register offsets
@@ -466,11 +465,8 @@ static ssize_t axis_fifo_write(struct fi
 {
 	struct axis_fifo *fifo = (struct axis_fifo *)f->private_data;
 	unsigned int words_to_write;
-	unsigned int copied;
-	unsigned int copy;
-	unsigned int i;
+	u32 *txbuf;
 	int ret;
-	u32 tmp_buf[WRITE_BUF_SIZE];
 
 	if (len % sizeof(u32)) {
 		dev_err(fifo->dt_device,
@@ -535,32 +531,20 @@ static ssize_t axis_fifo_write(struct fi
 		}
 	}
 
-	/* write data from an intermediate buffer into the fifo IP, refilling
-	 * the buffer with userspace data as needed
-	 */
-	copied = 0;
-	while (words_to_write > 0) {
-		copy = min(words_to_write, WRITE_BUF_SIZE);
-
-		if (copy_from_user(tmp_buf, buf + copied * sizeof(u32),
-				   copy * sizeof(u32))) {
-			ret = -EFAULT;
-			goto end_unlock;
-		}
-
-		for (i = 0; i < copy; i++)
-			iowrite32(tmp_buf[i], fifo->base_addr +
-				  XLLF_TDFD_OFFSET);
-
-		copied += copy;
-		words_to_write -= copy;
+	txbuf = vmemdup_user(buf, len);
+	if (IS_ERR(txbuf)) {
+		ret = PTR_ERR(txbuf);
+		goto end_unlock;
 	}
 
-	ret = copied * sizeof(u32);
+	for (int i = 0; i < words_to_write; ++i)
+		iowrite32(txbuf[i], fifo->base_addr + XLLF_TDFD_OFFSET);
 
 	/* write packet size to fifo */
-	iowrite32(ret, fifo->base_addr + XLLF_TLR_OFFSET);
+	iowrite32(len, fifo->base_addr + XLLF_TLR_OFFSET);
 
+	ret = len;
+	kvfree(txbuf);
 end_unlock:
 	mutex_unlock(&fifo->write_lock);
 



