Return-Path: <stable+bounces-135856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A640A99004
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A357AE87D
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B072428B4EA;
	Wed, 23 Apr 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VZoHmM+D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94928C5D1;
	Wed, 23 Apr 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421023; cv=none; b=TtgBofg83GSJklqRDyb9yGKuhrAC+sVyvOcRNqDIbFTgmZwr/RRZbN47YSvEqQ6xt3pnSMY3Jd4A0Y0cdC09iu+mtXwp/4xwg0jkK5w4vm/Atu4iyTuVA7NOG4oyPpLIS9q2OzgDOeImjxVnsWyQ04RylbxzheV2bDWL8n6sMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421023; c=relaxed/simple;
	bh=//zXE4idh9IjfkiJCS9lUFXs8QxUFhTbcxvsqnVY3Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADfz5g8eT5gQyjb8HnaVbcbR6pwNEObVN4pzcZtekamIXmYuHnrTP2TeqvhduTfa5cjREvu+FWKyQJialfvoeVvzLbE9IfkuDI9Zt+dT0h16qhQsf8Xc+E4NG4ECqhVuKTsXGEVey4fBteBQzBWsS3awpHrtOGHIj4pImZxGSCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VZoHmM+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C4DC4CEE2;
	Wed, 23 Apr 2025 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421022;
	bh=//zXE4idh9IjfkiJCS9lUFXs8QxUFhTbcxvsqnVY3Nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZoHmM+D4mA4JSNsyIOySBnnMWxqJCDi1BUIhOaEY8bANp7LCacqFmxUSuhlz7jfe
	 csXLWrk+DZnqRkqBv1yDJoLpPcwl9w8ZGAmo/AUfaBXhOw1cmLcOv9HK6fBTEl9etX
	 ZIKNJrDsZmddg84/HF3yCGbiJw1aPV2vasIbD+o8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Murad Masimov <m.masimov@mt-integration.ru>,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.6 136/393] media: streamzap: prevent processing IR data on URB failure
Date: Wed, 23 Apr 2025 16:40:32 +0200
Message-ID: <20250423142648.996896883@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Murad Masimov <m.masimov@mt-integration.ru>

commit 549f6d348167fb2f7800ed7c8d4bce9630c74498 upstream.

If streamzap_callback() receives an urb with any non-critical error
status, i.e. any error code other than -ECONNRESET, -ENOENT or -ESHUTDOWN,
it will try to process IR data, ignoring a possible transfer failure.

Make streamzap_callback() process IR data only when urb->status is 0.
Move processing logic to a separate function to make code cleaner and
more similar to the URB completion handlers in other RC drivers.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 19770693c354 ("V4L/DVB: staging/lirc: add lirc_streamzap driver")
Cc: stable@vger.kernel.org
Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/rc/streamzap.c |   68 ++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

--- a/drivers/media/rc/streamzap.c
+++ b/drivers/media/rc/streamzap.c
@@ -138,39 +138,10 @@ static void sz_push_half_space(struct st
 	sz_push_full_space(sz, value & SZ_SPACE_MASK);
 }
 
-/*
- * streamzap_callback - usb IRQ handler callback
- *
- * This procedure is invoked on reception of data from
- * the usb remote.
- */
-static void streamzap_callback(struct urb *urb)
+static void sz_process_ir_data(struct streamzap_ir *sz, int len)
 {
-	struct streamzap_ir *sz;
 	unsigned int i;
-	int len;
-
-	if (!urb)
-		return;
-
-	sz = urb->context;
-	len = urb->actual_length;
-
-	switch (urb->status) {
-	case -ECONNRESET:
-	case -ENOENT:
-	case -ESHUTDOWN:
-		/*
-		 * this urb is terminated, clean up.
-		 * sz might already be invalid at this point
-		 */
-		dev_err(sz->dev, "urb terminated, status: %d\n", urb->status);
-		return;
-	default:
-		break;
-	}
 
-	dev_dbg(sz->dev, "%s: received urb, len %d\n", __func__, len);
 	for (i = 0; i < len; i++) {
 		dev_dbg(sz->dev, "sz->buf_in[%d]: %x\n",
 			i, (unsigned char)sz->buf_in[i]);
@@ -219,6 +190,43 @@ static void streamzap_callback(struct ur
 	}
 
 	ir_raw_event_handle(sz->rdev);
+}
+
+/*
+ * streamzap_callback - usb IRQ handler callback
+ *
+ * This procedure is invoked on reception of data from
+ * the usb remote.
+ */
+static void streamzap_callback(struct urb *urb)
+{
+	struct streamzap_ir *sz;
+	int len;
+
+	if (!urb)
+		return;
+
+	sz = urb->context;
+	len = urb->actual_length;
+
+	switch (urb->status) {
+	case 0:
+		dev_dbg(sz->dev, "%s: received urb, len %d\n", __func__, len);
+		sz_process_ir_data(sz, len);
+		break;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		/*
+		 * this urb is terminated, clean up.
+		 * sz might already be invalid at this point
+		 */
+		dev_err(sz->dev, "urb terminated, status: %d\n", urb->status);
+		return;
+	default:
+		break;
+	}
+
 	usb_submit_urb(urb, GFP_ATOMIC);
 }
 



