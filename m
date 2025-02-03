Return-Path: <stable+bounces-112004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7916A2579C
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 11:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4283A83F6
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 10:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB36202C5B;
	Mon,  3 Feb 2025 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB4lJjN8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5F4202C2E;
	Mon,  3 Feb 2025 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580332; cv=none; b=ZZk01VeH23mGnADeeO1frUjMfcoErdPnKoKSZijBKNdyTXTXKuP99FKCpMt4eTrozNfrh5PlcNp5AzqANxthRV3NVaGwxrszriD+mOr8c23vWA/78FW5f2dq4wz78qPF7XlzwXbrN1c7NOnLIVcVcqWcCTg6zp2orteT7FhAw9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580332; c=relaxed/simple;
	bh=GSEqv2VM3beR1KFDw1ZyypOdmCRst+DG5m5uYBLuPec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iO3WQfJ301BzwGTPOVJ8nFPZM+ZY9HPlB0zTuH50mqh+GaomP/fipujDA7mY+2ykMJGh7Mo1bFatWOjiomQUQuaVk3nXwTm7LZ1rP7Gx0lOd6QWxhpU80+TCnzppJwYYHX7saD0HHTsqmOknLsjZ2Js2Ij729gCyQin2OSEGpds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UB4lJjN8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2131246f8f.0;
        Mon, 03 Feb 2025 02:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738580329; x=1739185129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nt7pBd/IQYh6LuC7dRxy6T+qPjBb3Up7HQ9RyedmO0Q=;
        b=UB4lJjN8rW8xnG5Ue3LT/BF6LaIe0pNyKZX6kbPOv/Hv570jijt7aHeMO0EqRovStP
         Ci8Tpyg7AqoLOfTLUOzjom9m6ILRkWPVBv9DPq/VOOaV0zGRilggNpICz5BtJxoAxR9B
         umBwReW/CJ9WErGmw05dGi1ez9NsTr54yVa1XMI621GQKghMS6AK7igcJsc+K9NAGgqy
         pH1tLsefYvVinE28w1caWE/KdZtSzadCDgz9Xbur6NXP4GsmYLyUFoWZnaR9zqSV4MEk
         WWnOuYF91gfjmLDJqB9M9FRYdkHvxg9Z95IDVtgyD1liL+i2XGep7+aa84nz5PZn3wp8
         G36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738580329; x=1739185129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nt7pBd/IQYh6LuC7dRxy6T+qPjBb3Up7HQ9RyedmO0Q=;
        b=gf+CLmsALxpgrS6BF06dpPYgpVbEzcLCKDkYNhHhOC+h/O30ZQlwTlhVuByvPaKQqw
         t72CSH39oNvHNrK/2MbxthV6Z47+fBx2FMAmuC2oLW+S3rauD0m9TOucCae6UinbMnF4
         7pkrLw/58w5jItecSNZUSBxllbRzALM3FH5srdRX8j/Hv2E9ao1YK1uRfeSIZWxRxFUl
         CsNtu76/SLaImv8SKNxVbHXlpwVprfJ1KePtoovDdAEC0KrB9p5tkxwPqemWy2gkOtDD
         qyWg4noCEnu7sKwiLFyt+3i8QaleD8KDVdQlGWKBm4igQAx5YAWrxFKeIYMtpTusO5+n
         Eq4A==
X-Forwarded-Encrypted: i=1; AJvYcCX2G7OrasoXxEvr/x5omyexEGqTGp1sBei5o/khx57KcbLQX6JYxIKOVr/6UEPPlHtbspwmcEoV@vger.kernel.org, AJvYcCXGVpAahJrMposgOJ/v9JjDkMvNiVv6UvbbHhA6QQvY47dgNGzkcGe0vbswe4aI0jzrxMhg9WPYuTwzZ4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZlr4RU12sg/LsVRQfgKjrUNvPujcRhPcswxjzH9xfpw4LqNHO
	2QSBxJc93lLNzFGxBlKVaqJcpx20tQYU9aSQxyRu4hDbOhh6wGpt
X-Gm-Gg: ASbGncsimMWbefwUUtO4MYBX+s1ON9hmWNr0YYQ6o506OnBHXuRUYiPZCLqcpE+oYjQ
	Av8YgDrRnL6NceoiGXMrs4xr/MBC9qySxmm+ppWoCreM7PfxTOntfIRVlSnWSABK1eQBKDqrOT1
	UzilM/Ef9cInFTHzhZCnmCm5iN0gev4JCgLRvo7gLVdnjrmzweAXzByaASvL1GeoG1OXkqBQwos
	oljCk43DBU79clccTzyn9EXvDKWhcYeW1CYFqaNv7gPhIRHvnO8IvvXCMCYK7UR+GjKUnq3Bm5q
	kBljnBpcS5MvYKFEEg9xh0wzHlSTuw==
X-Google-Smtp-Source: AGHT+IFk08vrhipS4NZ4Hf3SF8z/wRFOBO+8+J3IjDCgenbINK4dMliqwM7oio3uJEYhAzuT3oYSyA==
X-Received: by 2002:a5d:6d02:0:b0:385:f092:e1a with SMTP id ffacd0b85a97d-38c5194c3b6mr16966733f8f.11.1738580328746;
        Mon, 03 Feb 2025 02:58:48 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:5eb2:36d4:b5a0:d5a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e23e6a4dsm149627595e9.21.2025.02.03.02.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 02:58:48 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu,
	francesco.dolcini@toradex.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] usb: core: fix pipe creation for get_bMaxPacketSize0
Date: Mon,  3 Feb 2025 11:58:24 +0100
Message-ID: <20250203105840.17539-1-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

When usb_control_msg is used in the get_bMaxPacketSize0 function, the
USB pipe does not include the endpoint device number. This can cause
failures when a usb hub port is reinitialized after encountering a bad
cable connection. As a result, the system logs the following error
messages:
usb usb2-port1: cannot reset (err = -32)
usb usb2-port1: Cannot enable. Maybe the USB cable is bad?
usb usb2-port1: attempt power cycle
usb 2-1: new high-speed USB device number 5 using ci_hdrc
usb 2-1: device descriptor read/8, error -71

The problem began after commit 85d07c556216 ("USB: core: Unite old
scheme and new scheme descriptor reads"). There
usb_get_device_descriptor was replaced with get_bMaxPacketSize0. Unlike
usb_get_device_descriptor, the get_bMaxPacketSize0 function uses the
macro usb_rcvaddr0pipe, which does not include the endpoint device
number. usb_get_device_descriptor, on the other hand, used the macro
usb_rcvctrlpipe, which includes the endpoint device number.

By modifying the get_bMaxPacketSize0 function to use usb_rcvctrlpipe
instead of usb_rcvaddr0pipe, the issue can be resolved. This change will
ensure that the endpoint device number is included in the USB pipe,
preventing reinitialization failures. If the endpoint has not set the
device number yet, it will still work because the device number is 0 in
udev.

Cc: stable@vger.kernel.org
Fixes: 85d07c556216 ("USB: core: Unite old scheme and new scheme descriptor reads")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
Before commit  85d07c556216 ("USB: core: Unite old scheme and new scheme
descriptor reads") usb_rcvaddr0pipe was used in hub_port_init. With this
proposed change, usb_rcvctrlpipe will be used which includes devnum for
the pipe. I'm not sure if this might have some side effects. However, my
understanding is that devnum is set to the right value (might also be 0
if not initialised) before get_bMaxPacketSize0 is called. Therefore,
this should work but please let me know if I'm wrong on this.
---
 drivers/usb/core/hub.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index c3f839637cb5..59e38780f76d 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -4698,7 +4698,6 @@ void usb_ep0_reinit(struct usb_device *udev)
 EXPORT_SYMBOL_GPL(usb_ep0_reinit);
 
 #define usb_sndaddr0pipe()	(PIPE_CONTROL << 30)
-#define usb_rcvaddr0pipe()	((PIPE_CONTROL << 30) | USB_DIR_IN)
 
 static int hub_set_address(struct usb_device *udev, int devnum)
 {
@@ -4804,7 +4803,7 @@ static int get_bMaxPacketSize0(struct usb_device *udev,
 	for (i = 0; i < GET_MAXPACKET0_TRIES; ++i) {
 		/* Start with invalid values in case the transfer fails */
 		buf->bDescriptorType = buf->bMaxPacketSize0 = 0;
-		rc = usb_control_msg(udev, usb_rcvaddr0pipe(),
+		rc = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 				USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
 				USB_DT_DEVICE << 8, 0,
 				buf, size,
-- 
2.45.2


