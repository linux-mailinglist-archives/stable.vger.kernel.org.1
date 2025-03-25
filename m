Return-Path: <stable+bounces-126389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BEDA6FFF9
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCA1B7A1683
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0518126A088;
	Tue, 25 Mar 2025 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VrNUZvyo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73DE25BACB;
	Tue, 25 Mar 2025 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906133; cv=none; b=BYwyZd6ySe1HoViSThl9gM6lKFe8rCUVq7NOWB3qUx7WLVhye4p0ER/08+RxChnhmRzAqE3Q0JKCJEa+qLy9n4K0G9lCRaCOtKRz5bLAFNPrkSfL75rp6WrOOYWLg7VX3X53pmtp4poDRNhkt/sjQ4GZH4TXt8b5bZfxVWCNK8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906133; c=relaxed/simple;
	bh=wFmCcyG5bvfqVlyzieFeSlvUA3qe74VsrrOpTG5R2+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IoC0IbdWTK0JNE0LW1MGqOQq9Wt5C/ApAxOr53/Tm+eMnLZ8IvtOB6RwrgOv8Cvsj9MHtiShXkUaV5DJRzmQ+5iqR/7iDv97U6ymMFM/Ful4xW8GIqmmPpp/aJrLcGNtGKmjtu0s11FcnWFTFPAxQSfYj8ModxpYaSvzRqbkC4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VrNUZvyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F30AC4CEE9;
	Tue, 25 Mar 2025 12:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742906133;
	bh=wFmCcyG5bvfqVlyzieFeSlvUA3qe74VsrrOpTG5R2+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VrNUZvyopg4+0+fLe+C/nZquIpxkAzp0CP0Jvul+fr8Z8tC7naVwpvzpRhaD58wPH
	 ui1fw8eisaodtYVGG1LbDU3lRmdJ3JuJqCYGdHX8qHI9LFEdSYzsr9bJxpYLop4xcM
	 gg/ckRzlvjxXim29PIBvmI5JGYcoJKmEHJj5+oGU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.6 31/77] can: ucan: fix out of bound read in strscpy() source
Date: Tue, 25 Mar 2025 08:22:26 -0400
Message-ID: <20250325122145.168858849@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122144.259256924@linuxfoundation.org>
References: <20250325122144.259256924@linuxfoundation.org>
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

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

commit 1d22a122ffb116c3cf78053e812b8b21f8852ee9 upstream.

Commit 7fdaf8966aae ("can: ucan: use strscpy() to instead of strncpy()")
unintentionally introduced a one byte out of bound read on strscpy()'s
source argument (which is kind of ironic knowing that strscpy() is meant
to be a more secure alternative :)).

Let's consider below buffers:

  dest[len + 1]; /* will be NUL terminated */
  src[len]; /* may not be NUL terminated */

When doing:

  strncpy(dest, src, len);
  dest[len] = '\0';

strncpy() will read up to len bytes from src.

On the other hand:

  strscpy(dest, src, len + 1);

will read up to len + 1 bytes from src, that is to say, an out of bound
read of one byte will occur on src if it is not NUL terminated. Note
that the src[len] byte is never copied, but strscpy() still needs to
read it to check whether a truncation occurred or not.

This exact pattern happened in ucan.

The root cause is that the source is not NUL terminated. Instead of
doing a copy in a local buffer, directly NUL terminate it as soon as
usb_control_msg() returns. With this, the local firmware_str[] variable
can be removed.

On top of this do a couple refactors:

  - ucan_ctl_payload->raw is only used for the firmware string, so
    rename it to ucan_ctl_payload->fw_str and change its type from u8 to
    char.

  - ucan_device_request_in() is only used to retrieve the firmware
    string, so rename it to ucan_get_fw_str() and refactor it to make it
    directly handle all the string termination logic.

Reported-by: syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-can/67b323a4.050a0220.173698.002b.GAE@google.com/
Fixes: 7fdaf8966aae ("can: ucan: use strscpy() to instead of strncpy()")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20250218143515.627682-2-mailhol.vincent@wanadoo.fr
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/ucan.c |   43 ++++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -186,7 +186,7 @@ union ucan_ctl_payload {
 	 */
 	struct ucan_ctl_cmd_get_protocol_version cmd_get_protocol_version;
 
-	u8 raw[128];
+	u8 fw_str[128];
 } __packed;
 
 enum {
@@ -424,18 +424,20 @@ static int ucan_ctrl_command_out(struct
 			       UCAN_USB_CTL_PIPE_TIMEOUT);
 }
 
-static int ucan_device_request_in(struct ucan_priv *up,
-				  u8 cmd, u16 subcmd, u16 datalen)
+static void ucan_get_fw_str(struct ucan_priv *up, char *fw_str, size_t size)
 {
-	return usb_control_msg(up->udev,
-			       usb_rcvctrlpipe(up->udev, 0),
-			       cmd,
-			       USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			       subcmd,
-			       0,
-			       up->ctl_msg_buffer,
-			       datalen,
-			       UCAN_USB_CTL_PIPE_TIMEOUT);
+	int ret;
+
+	ret = usb_control_msg(up->udev, usb_rcvctrlpipe(up->udev, 0),
+			      UCAN_DEVICE_GET_FW_STRING,
+			      USB_DIR_IN | USB_TYPE_VENDOR |
+			      USB_RECIP_DEVICE,
+			      0, 0, fw_str, size - 1,
+			      UCAN_USB_CTL_PIPE_TIMEOUT);
+	if (ret > 0)
+		fw_str[ret] = '\0';
+	else
+		strscpy(fw_str, "unknown", size);
 }
 
 /* Parse the device information structure reported by the device and
@@ -1314,7 +1316,6 @@ static int ucan_probe(struct usb_interfa
 	u8 in_ep_addr;
 	u8 out_ep_addr;
 	union ucan_ctl_payload *ctl_msg_buffer;
-	char firmware_str[sizeof(union ucan_ctl_payload) + 1];
 
 	udev = interface_to_usbdev(intf);
 
@@ -1527,17 +1528,6 @@ static int ucan_probe(struct usb_interfa
 	 */
 	ucan_parse_device_info(up, &ctl_msg_buffer->cmd_get_device_info);
 
-	/* just print some device information - if available */
-	ret = ucan_device_request_in(up, UCAN_DEVICE_GET_FW_STRING, 0,
-				     sizeof(union ucan_ctl_payload));
-	if (ret > 0) {
-		/* copy string while ensuring zero termination */
-		strscpy(firmware_str, up->ctl_msg_buffer->raw,
-			sizeof(union ucan_ctl_payload) + 1);
-	} else {
-		strcpy(firmware_str, "unknown");
-	}
-
 	/* device is compatible, reset it */
 	ret = ucan_ctrl_command_out(up, UCAN_COMMAND_RESET, 0, 0);
 	if (ret < 0)
@@ -1555,7 +1545,10 @@ static int ucan_probe(struct usb_interfa
 
 	/* initialisation complete, log device info */
 	netdev_info(up->netdev, "registered device\n");
-	netdev_info(up->netdev, "firmware string: %s\n", firmware_str);
+	ucan_get_fw_str(up, up->ctl_msg_buffer->fw_str,
+			sizeof(up->ctl_msg_buffer->fw_str));
+	netdev_info(up->netdev, "firmware string: %s\n",
+		    up->ctl_msg_buffer->fw_str);
 
 	/* success */
 	return 0;



