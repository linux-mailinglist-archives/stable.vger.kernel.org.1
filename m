Return-Path: <stable+bounces-129809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFA4A80115
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EE877A8363
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CD8263C90;
	Tue,  8 Apr 2025 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P0utjXlT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DCE216E30;
	Tue,  8 Apr 2025 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112037; cv=none; b=EfRfrDx15FHIMrAcqGnDXePy+LF7U0+N5SdQL2Cof4pXOqJTQbzzg78Cc35+BuCpaeVTpuclLyquDzRUZAbtz5BG+BJnzujF9Xx2eKukuTcBa4Q+L1dMnc9SlBwAPaSvBHWAOkP30UZhBEbN1wcm6qg5LEuigsBT68zq4cpH6qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112037; c=relaxed/simple;
	bh=tNx45jDiqI8fxfe/+9w7Z4l13dWO65anq0Dd9nDD3/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZm5Z22wVJY7lbIe/E3pjOSdyuFh7K4ntuix6rXq3AcizOVfaG5iGwL0GVsdg+xSdfx7uRt895DUWXdkcEUWcIa51auzv/fUz18kYXmqYVc2BriwV6N/1KQ6ZJIkrEFGZpMSdd4KpnOLF27AVohsRr0OWvYS2yO5HJcf3PVoW/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P0utjXlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2329CC4CEE5;
	Tue,  8 Apr 2025 11:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112037;
	bh=tNx45jDiqI8fxfe/+9w7Z4l13dWO65anq0Dd9nDD3/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P0utjXlTqPW3V61XoiTutBV5pELjXADFiLjB1E28SEv+DjMLx8pJHrf3qi9jGY3H7
	 4bK0pqFIaUmFaEf1CBY0/2VB1U6ypgbtHN03J1PzhCcQjq9QjUkbQDKVac/yQLZ9M/
	 4c1w+i/tb0s6Ig+SQrLgAtzv65731x+XyDMcVD80=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Dave Penkler <dpenkler@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 653/731] staging: gpib: Fix Oops after disconnect in ni_usb
Date: Tue,  8 Apr 2025 12:49:10 +0200
Message-ID: <20250408104929.455248600@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Penkler <dpenkler@gmail.com>

[ Upstream commit a239c6e91b665f1837cf57b97fe638ef1baf2e78 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 93 ++++++++++++++++++-----
 1 file changed, 73 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 52c7530f07bb1..1b976a28a7fe4 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -592,7 +592,7 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 {
 	int retval, parse_retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x20;
 	int in_data_length;
@@ -605,8 +605,11 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
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
@@ -719,7 +722,7 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	int out_data_length;
 	static const int in_data_length = 0x10;
@@ -729,9 +732,11 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
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
@@ -820,7 +825,7 @@ static int ni_usb_command_chunk(gpib_board_t *board, uint8_t *buffer, size_t len
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	int out_data_length;
 	static const int in_data_length = 0x10;
@@ -832,8 +837,11 @@ static int ni_usb_command_chunk(gpib_board_t *board, uint8_t *buffer, size_t len
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
@@ -926,7 +934,7 @@ static int ni_usb_take_control(gpib_board_t *board, int synchronous)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x10;
@@ -934,6 +942,9 @@ static int ni_usb_take_control(gpib_board_t *board, int synchronous)
 	int i = 0;
 	struct ni_usb_status_block status;
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
 		return -ENOMEM;
@@ -984,7 +995,7 @@ static int ni_usb_go_to_standby(gpib_board_t *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x20;
@@ -992,6 +1003,9 @@ static int ni_usb_go_to_standby(gpib_board_t *board)
 	int i = 0;
 	struct ni_usb_status_block status;
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
 		return -ENOMEM;
@@ -1040,11 +1054,14 @@ static void ni_usb_request_system_control(gpib_board_t *board, int request_contr
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
@@ -1088,7 +1105,7 @@ static void ni_usb_interface_clear(gpib_board_t *board, int assert)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x10;
@@ -1096,7 +1113,10 @@ static void ni_usb_interface_clear(gpib_board_t *board, int assert)
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
@@ -1134,10 +1154,13 @@ static void ni_usb_remote_enable(gpib_board_t *board, int enable)
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
@@ -1181,11 +1204,14 @@ static unsigned int ni_usb_update_status(gpib_board_t *board, unsigned int clear
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
@@ -1233,11 +1259,14 @@ static int ni_usb_primary_address(gpib_board_t *board, unsigned int address)
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
@@ -1288,11 +1317,14 @@ static int ni_usb_secondary_address(gpib_board_t *board, unsigned int address, i
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
@@ -1307,7 +1339,7 @@ static int ni_usb_parallel_poll(gpib_board_t *board, uint8_t *result)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x20;
@@ -1316,6 +1348,9 @@ static int ni_usb_parallel_poll(gpib_board_t *board, uint8_t *result)
 	int j = 0;
 	struct ni_usb_status_block status;
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
 		return -ENOMEM;
@@ -1359,11 +1394,14 @@ static void ni_usb_parallel_poll_configure(gpib_board_t *board, uint8_t config)
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
@@ -1381,11 +1419,14 @@ static void ni_usb_parallel_poll_response(gpib_board_t *board, int ist)
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
@@ -1406,11 +1447,14 @@ static void ni_usb_serial_poll_response(gpib_board_t *board, u8 status)
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
@@ -1433,11 +1477,14 @@ static void ni_usb_return_to_local(gpib_board_t *board)
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
@@ -1455,7 +1502,7 @@ static int ni_usb_line_status(const gpib_board_t *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x20;
 	static const int  in_data_length = 0x20;
@@ -1465,6 +1512,9 @@ static int ni_usb_line_status(const gpib_board_t *board)
 	int line_status = ValidALL;
 	// NI windows driver reads 0xd(HSSEL), 0xc (ARD0), 0x1f (BSR)
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
 		return -ENOMEM;
@@ -1571,12 +1621,15 @@ static unsigned int ni_usb_t1_delay(gpib_board_t *board, unsigned int nano_sec)
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
-- 
2.39.5




