Return-Path: <stable+bounces-8954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1C7820598
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B021F22980
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D448487;
	Sat, 30 Dec 2023 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qS57Jd/O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A1D28FE;
	Sat, 30 Dec 2023 12:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8DCC433C9;
	Sat, 30 Dec 2023 12:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703938193;
	bh=I5X8qo+5wLAxscClNxnlm1e4pSJ1o4eVz7jMVXYBv+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qS57Jd/ONb8TXPCX7NkK8oprM0GXc8b/NvEJvoK1o1RiVbwdjwF6kee7LG/t2qWK6
	 KAQJEBGCCWWM2xVtWLrYmcbdYJ8A6bcJW4CjfJCAjt9pLbotDxGsiIpmcLWVjtRwqS
	 DpSapKjVj4fc9vjViyZibxOT4wPNgguwZtla7+f0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Tasos Sahanidis <tasos@tasossah.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 063/112] usb-storage: Add quirk for incorrect WP on Kingston DT Ultimate 3.0 G3
Date: Sat, 30 Dec 2023 11:59:36 +0000
Message-ID: <20231230115808.717878159@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115806.714618407@linuxfoundation.org>
References: <20231230115806.714618407@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tasos Sahanidis <tasos@tasossah.com>

commit 772685c14743ad565bb271041ad3c262298cd6fc upstream.

This flash drive reports write protect during the first mode sense.

In the past this was not an issue as the kernel called revalidate twice,
thus asking the device for its write protect status twice, with write
protect being disabled in the second mode sense.

However, since commit 1e029397d12f ("scsi: sd: Reorganize DIF/DIX code to
avoid calling revalidate twice") that is no longer the case, thus the
device shows up read only.

[490891.289495] sd 12:0:0:0: [sdl] Write Protect is on
[490891.289497] sd 12:0:0:0: [sdl] Mode Sense: 2b 00 80 08

This does not appear to be a timing issue, as enabling the usbcore quirk
USB_QUIRK_DELAY_INIT has no effect on write protect.

Fixes: 1e029397d12f ("scsi: sd: Reorganize DIF/DIX code to avoid calling revalidate twice")
Cc: stable <stable@kernel.org>
Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Link: https://lore.kernel.org/r/20231207134441.298131-1-tasos@tasossah.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/unusual_devs.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -1306,6 +1306,17 @@ UNUSUAL_DEV(  0x090c, 0x6000, 0x0100, 0x
 		US_FL_INITIAL_READ10 ),
 
 /*
+ * Patch by Tasos Sahanidis <tasos@tasossah.com>
+ * This flash drive always shows up with write protect enabled
+ * during the first mode sense.
+ */
+UNUSUAL_DEV(0x0951, 0x1697, 0x0100, 0x0100,
+		"Kingston",
+		"DT Ultimate G3",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_NO_WP_DETECT),
+
+/*
  * This Pentax still camera is not conformant
  * to the USB storage specification: -
  * - It does not like the INQUIRY command. So we must handle this command



