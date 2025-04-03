Return-Path: <stable+bounces-127536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B86A7A560
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 16:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9167B3A5902
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C81D2505AA;
	Thu,  3 Apr 2025 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bcwN3cHu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C102A2500DE
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743690937; cv=none; b=AWA3N0m6DyjfzQzeyNReWlGTCAmTAfp/ZuQQwWDptVAwt6rJwDKZfOD2oZTeCjS/XfNj/gECfcYBmGcT/JxQufArLV/Gd54UYrUhZC9jc4kWYePVPKKhJWdsi8AJoP7EnkiSFph096WOBhNTs1q44hZjEAGcVLSpb6cRwnhApzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743690937; c=relaxed/simple;
	bh=a5e1bN3MQkK8K/R2+1YqCdZXFvtDIaPmDOknPm9Ltjo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BRfvKDtciEv7tkrAe9xM1zEFmI78VSpxUuZA1TlwN0gWWq/4N/Ymblpmyj0Ve7FqKnte4rdQA+vWhZGBo+/qfono67p89U4INCNdoqSM2A6hIatGMNX5OWCxdT/TBhj2i0W+q3np/98pT2t4Ig5RU1uWHEQzTLJP0QlN7JLgR3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bcwN3cHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB5EC4CEE5;
	Thu,  3 Apr 2025 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743690937;
	bh=a5e1bN3MQkK8K/R2+1YqCdZXFvtDIaPmDOknPm9Ltjo=;
	h=Subject:To:Cc:From:Date:From;
	b=bcwN3cHu9P5rseU+MdnS05oJ8hMhzbSu8P9Hz1QE4gcn0KZLFzWIb1uekYDf3XjD8
	 72K2zwbsOuoD1lKnIGPMTK1kZEl/zzCp71s+E9zEKcYI7orNFmybL/h5n1iOsfFaXd
	 Xx+cikkRCft4SwWxyMv9cRq8/11vqLdSUXSstPJw=
Subject: FAILED: patch "[PATCH] staging: gpib: Fix Oops after disconnect in ni_usb" failed to apply to 6.14-stable tree
To: dpenkler@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Apr 2025 15:34:09 +0100
Message-ID: <2025040309-kabob-graph-ed91@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x a239c6e91b665f1837cf57b97fe638ef1baf2e78
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040309-kabob-graph-ed91@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a239c6e91b665f1837cf57b97fe638ef1baf2e78 Mon Sep 17 00:00:00 2001
From: Dave Penkler <dpenkler@gmail.com>
Date: Sat, 22 Feb 2025 17:58:17 +0100
Subject: [PATCH] staging: gpib: Fix Oops after disconnect in ni_usb

If the usb dongle is disconnected subsequent calls to the
driver cause a NULL dereference Oops as the bus_interface
is set to NULL on disconnect.

This problem was introduced by setting usb_dev from the bus_interface
for dev_xxx messages.

Previously bus_interface was checked for NULL only in the the functions
directly calling usb_fill_bulk_urb or usb_control_msg.

Check for valid bus_interface on all interface entry points
and return -ENODEV if it is NULL.

Fixes: 4934b98bb243 ("staging: gpib: Update messaging and usb_device refs in ni_usb")
Cc: stable <stable@kernel.org>
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
Link: https://lore.kernel.org/r/20250222165817.12856-1-dpenkler@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 61b15b19e134..62fbc78204ce 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -591,7 +591,7 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 {
 	int retval, parse_retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x20;
 	int in_data_length;
@@ -604,8 +604,11 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 	struct ni_usb_register reg;
 
 	*bytes_read = 0;
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
 	if (length > max_read_length)
 		return -EINVAL;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
 		return -ENOMEM;
@@ -718,7 +721,7 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	int out_data_length;
 	static const int in_data_length = 0x10;
@@ -728,9 +731,11 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 	struct ni_usb_status_block status;
 	static const int max_write_length = 0xffff;
 
-	*bytes_written = 0;
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
 	if (length > max_write_length)
 		return -EINVAL;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_data_length = length + 0x10;
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
@@ -819,7 +824,7 @@ static int ni_usb_command_chunk(gpib_board_t *board, uint8_t *buffer, size_t len
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	int out_data_length;
 	static const int in_data_length = 0x10;
@@ -831,8 +836,11 @@ static int ni_usb_command_chunk(gpib_board_t *board, uint8_t *buffer, size_t len
 	static const int max_command_length = 0x10;
 
 	*command_bytes_written = 0;
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
 	if (length > max_command_length)
 		length = max_command_length;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_data_length = length + 0x10;
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
@@ -925,7 +933,7 @@ static int ni_usb_take_control(gpib_board_t *board, int synchronous)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x10;
@@ -933,6 +941,9 @@ static int ni_usb_take_control(gpib_board_t *board, int synchronous)
 	int i = 0;
 	struct ni_usb_status_block status;
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
 		return -ENOMEM;
@@ -983,7 +994,7 @@ static int ni_usb_go_to_standby(gpib_board_t *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x20;
@@ -991,6 +1002,9 @@ static int ni_usb_go_to_standby(gpib_board_t *board)
 	int i = 0;
 	struct ni_usb_status_block status;
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
 		return -ENOMEM;
@@ -1039,11 +1053,14 @@ static void ni_usb_request_system_control(gpib_board_t *board, int request_contr
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	int i = 0;
 	struct ni_usb_register writes[4];
 	unsigned int ibsta;
 
+	if (!ni_priv->bus_interface)
+		return; // -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	if (request_control) {
 		writes[i].device = NIUSB_SUBDEV_TNT4882;
 		writes[i].address = CMDR;
@@ -1087,7 +1104,7 @@ static void ni_usb_interface_clear(gpib_board_t *board, int assert)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x10;
@@ -1095,7 +1112,10 @@ static void ni_usb_interface_clear(gpib_board_t *board, int assert)
 	int i = 0;
 	struct ni_usb_status_block status;
 
-	// FIXME: we are going to pulse when assert is true, and ignore otherwise
+	if (!ni_priv->bus_interface)
+		return; // -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+// FIXME: we are going to pulse when assert is true, and ignore otherwise
 	if (assert == 0)
 		return;
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
@@ -1133,10 +1153,13 @@ static void ni_usb_remote_enable(gpib_board_t *board, int enable)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	struct ni_usb_register reg;
 	unsigned int ibsta;
 
+	if (!ni_priv->bus_interface)
+		return; // -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	reg.device = NIUSB_SUBDEV_TNT4882;
 	reg.address = nec7210_to_tnt4882_offset(AUXMR);
 	if (enable)
@@ -1180,11 +1203,14 @@ static unsigned int ni_usb_update_status(gpib_board_t *board, unsigned int clear
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	static const int buffer_length = 8;
 	u8 *buffer;
 	struct ni_usb_status_block status;
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	buffer = kmalloc(buffer_length, GFP_KERNEL);
 	if (!buffer)
 		return board->status;
@@ -1232,11 +1258,14 @@ static int ni_usb_primary_address(gpib_board_t *board, unsigned int address)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	int i = 0;
 	struct ni_usb_register writes[2];
 	unsigned int ibsta;
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	writes[i].device = NIUSB_SUBDEV_TNT4882;
 	writes[i].address = nec7210_to_tnt4882_offset(ADR);
 	writes[i].value = address;
@@ -1287,11 +1316,14 @@ static int ni_usb_secondary_address(gpib_board_t *board, unsigned int address, i
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	int i = 0;
 	struct ni_usb_register writes[3];
 	unsigned int ibsta;
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	i += ni_usb_write_sad(writes, address, enable);
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
@@ -1306,7 +1338,7 @@ static int ni_usb_parallel_poll(gpib_board_t *board, uint8_t *result)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x20;
@@ -1315,6 +1347,9 @@ static int ni_usb_parallel_poll(gpib_board_t *board, uint8_t *result)
 	int j = 0;
 	struct ni_usb_status_block status;
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
 		return -ENOMEM;
@@ -1358,11 +1393,14 @@ static void ni_usb_parallel_poll_configure(gpib_board_t *board, uint8_t config)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	int i = 0;
 	struct ni_usb_register writes[1];
 	unsigned int ibsta;
 
+	if (!ni_priv->bus_interface)
+		return; // -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	writes[i].device = NIUSB_SUBDEV_TNT4882;
 	writes[i].address = nec7210_to_tnt4882_offset(AUXMR);
 	writes[i].value = PPR | config;
@@ -1380,11 +1418,14 @@ static void ni_usb_parallel_poll_response(gpib_board_t *board, int ist)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	int i = 0;
 	struct ni_usb_register writes[1];
 	unsigned int ibsta;
 
+	if (!ni_priv->bus_interface)
+		return; // -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	writes[i].device = NIUSB_SUBDEV_TNT4882;
 	writes[i].address = nec7210_to_tnt4882_offset(AUXMR);
 	if (ist)
@@ -1405,11 +1446,14 @@ static void ni_usb_serial_poll_response(gpib_board_t *board, u8 status)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	int i = 0;
 	struct ni_usb_register writes[1];
 	unsigned int ibsta;
 
+	if (!ni_priv->bus_interface)
+		return; // -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	writes[i].device = NIUSB_SUBDEV_TNT4882;
 	writes[i].address = nec7210_to_tnt4882_offset(SPMR);
 	writes[i].value = status;
@@ -1432,11 +1476,14 @@ static void ni_usb_return_to_local(gpib_board_t *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	int i = 0;
 	struct ni_usb_register writes[1];
 	unsigned int ibsta;
 
+	if (!ni_priv->bus_interface)
+		return; // -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	writes[i].device = NIUSB_SUBDEV_TNT4882;
 	writes[i].address = nec7210_to_tnt4882_offset(AUXMR);
 	writes[i].value = AUX_RTL;
@@ -1454,7 +1501,7 @@ static int ni_usb_line_status(const gpib_board_t *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x20;
 	static const int  in_data_length = 0x20;
@@ -1464,6 +1511,9 @@ static int ni_usb_line_status(const gpib_board_t *board)
 	int line_status = ValidALL;
 	// NI windows driver reads 0xd(HSSEL), 0xc (ARD0), 0x1f (BSR)
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
 		return -ENOMEM;
@@ -1570,12 +1620,15 @@ static unsigned int ni_usb_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	struct ni_usb_register writes[3];
 	unsigned int ibsta;
 	unsigned int actual_ns;
 	int i;
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	i = ni_usb_setup_t1_delay(writes, nano_sec, &actual_ns);
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {


