Return-Path: <stable+bounces-91834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5601E9C0888
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 15:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA62B1F22173
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 14:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A64F20FAA9;
	Thu,  7 Nov 2024 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAz8AVST"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5822139CE
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988522; cv=none; b=A7t/xxQZtqU0oWLFpGydHrbMI9neTS56LKJiWHOTL6P+N6UZBIpbP/h75491hg3u6GF2lt2SSlty3gBytZSc6OfYi+Y191JgC+tdSjV6RUsmj+pcLXs6iThVkRM/66fGY4em+PE4QLEUZN7o6sddw7px/S9W1rWmSERxZpRW7jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988522; c=relaxed/simple;
	bh=D3ljhn7qjmseQFmuvPw1O27iVyerP7UaDkhnvF2efAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AEwXE6ygq6YjqrHs18FsO9R7IbXJBdwqsqbppNS7Y9zQenU5Q/vg2XUkZHvXm04XDuPi4gj0kfV0jgIeh6skkLlaf+LX5Ehs+RCo7DjcoGdKw78pFXzt1poeMfgW6lIlJ5g1ZoUpFZzc1bw4LKQ+y6Rks0USE/Bj5wWJ62Il9JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OAz8AVST; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730988518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0C+f/ubZjrbw/VEKlipKj/ninn9aeQ+N0DCISscUuno=;
	b=OAz8AVSTptvZoH6BYrs13dpuc//gk/zJKRhmVx7uIA+WBm4SMl4gFT2J9DB4RzRBN7Qna9
	aUHJLpZSMxPEVlX9VhboRU6ITwpGKFih99NPFCxe9iXROOs4NMrh9Kb7ROc8L1xxaYcjCX
	fxTw9/w0tHmNzMTUuESdRBcc+/Zu/tM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-XHXYR6GENs2rGSjTU_JH0Q-1; Thu,
 07 Nov 2024 09:08:37 -0500
X-MC-Unique: XHXYR6GENs2rGSjTU_JH0Q-1
X-Mimecast-MFC-AGG-ID: XHXYR6GENs2rGSjTU_JH0Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 333691955E87;
	Thu,  7 Nov 2024 14:08:36 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.177])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 600E31956054;
	Thu,  7 Nov 2024 14:08:34 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
Date: Thu,  7 Nov 2024 15:08:33 +0100
Message-ID: <20241107140833.274986-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The rtl8xxxu has all the rtl8192cu USB IDs from rtlwifi/rtl8192cu/sw.c
except for the following 10, add these to the untested section so they
can be used with the rtl8xxxu as the rtl8192cu are well supported.

This fixes these wifi modules not working on distributions which have
disabled CONFIG_RTL8192CU replacing it with CONFIG_RTL8XXXU_UNTESTED,
like Fedora.

Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2321540
Cc: stable@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 7891c988dd5f..bd8e0076baac 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -8145,6 +8145,8 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x817e, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x8186, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x818a, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x317f, 0xff, 0xff, 0xff),
@@ -8155,12 +8157,18 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x050d, 0x1102, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x050d, 0x11f2, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x06f8, 0xe033, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x07b8, 0x8188, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x07b8, 0x8189, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9041, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9043, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x17ba, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x1e1e, 0xff, 0xff, 0xff),
@@ -8177,6 +8185,10 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x13d3, 0x3357, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x13d3, 0x3358, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x13d3, 0x3359, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x330b, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x2019, 0x4902, 0xff, 0xff, 0xff),
@@ -8191,6 +8203,8 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x4856, 0x0091, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x9846, 0x9041, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0xcdab, 0x8010, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x04f2, 0xaff7, 0xff, 0xff, 0xff),
@@ -8216,6 +8230,8 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x0586, 0x341f, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x06f8, 0xe033, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x06f8, 0xe035, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x17ab, 0xff, 0xff, 0xff),
@@ -8224,6 +8240,8 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x0df6, 0x0070, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x0df6, 0x0077, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x0789, 0x016d, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x07aa, 0x0056, 0xff, 0xff, 0xff),
@@ -8246,6 +8264,8 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x330a, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x330d, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x2019, 0xab2b, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x20f4, 0x624d, 0xff, 0xff, 0xff),
-- 
2.47.0


