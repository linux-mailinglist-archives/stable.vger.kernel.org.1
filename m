Return-Path: <stable+bounces-80469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8362A98DD90
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD3F1F2653A
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FFC1D0E25;
	Wed,  2 Oct 2024 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rOET6YE1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D011EB21;
	Wed,  2 Oct 2024 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880463; cv=none; b=kuYh9/kqZdFmQdfMHZFzfV5p3pZ2yD7EBlcus6ThI2h8rmaxuUqKUxoSfgLWROGu1qFAiLgM4b8QX0DYe4zpPlPskgtNcfboZlRoDbb4Gt935mxi6n7XgnoHZSKq42rU6N+5c7zUNzDSutnw80AIRXBpEWxXpd+RepdszBa+7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880463; c=relaxed/simple;
	bh=s3SpCu1KNH0V8VyTFrvtgzjI1BVTQR7pjPdLfyCTQig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKz0+GcuJeNh5cijPott4LPR/ssJUmAs5ilNfqAWJNGHQeL8nPox+0d78fcmIdNM8vOGCuUaoYzP8zRAX1pTBphCr8Tvx6FIizC1kEA9tuMWNU4wlvHvpJC518YE5othBWN6HAT4v1Ueu/YVnI2vMX+L3s5Ew0TayMlGuIsrj5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rOET6YE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEBBC4CEC2;
	Wed,  2 Oct 2024 14:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880463;
	bh=s3SpCu1KNH0V8VyTFrvtgzjI1BVTQR7pjPdLfyCTQig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOET6YE1kZ/dUeU8aXKqNRchmRvDTAVbmqOndf/h1Odytqdci5riZSu3D5e660kry
	 flZbpj8CQT/6xrEooDfZVIEgsX+fASTes5i+PLXqFLKa7AhwFlY75WY9Gjnvn0dEQX
	 HwW9AV5eZUBnR9ZzQnJZw03emNf0zpWuMJ0A1PqI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 6.6 435/538] USB: misc: cypress_cy7c63: check for short transfer
Date: Wed,  2 Oct 2024 15:01:14 +0200
Message-ID: <20241002125809.610663120@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 49cd2f4d747eeb3050b76245a7f72aa99dbd3310 upstream.

As we process the second byte of a control transfer, transfers
of less than 2 bytes must be discarded.

This bug is as old as the driver.

SIgned-off-by: Oliver Neukum <oneukum@suse.com>
CC: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240912125449.1030536-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/misc/cypress_cy7c63.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/misc/cypress_cy7c63.c
+++ b/drivers/usb/misc/cypress_cy7c63.c
@@ -88,6 +88,9 @@ static int vendor_command(struct cypress
 				 USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
 				 address, data, iobuf, CYPRESS_MAX_REQSIZE,
 				 USB_CTRL_GET_TIMEOUT);
+	/* we must not process garbage */
+	if (retval < 2)
+		goto err_buf;
 
 	/* store returned data (more READs to be added) */
 	switch (request) {
@@ -107,6 +110,7 @@ static int vendor_command(struct cypress
 			break;
 	}
 
+err_buf:
 	kfree(iobuf);
 error:
 	return retval;



