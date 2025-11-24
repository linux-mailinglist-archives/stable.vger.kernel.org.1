Return-Path: <stable+bounces-196785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C74C8C82369
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 20:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8829334A9A2
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 19:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0142D5957;
	Mon, 24 Nov 2025 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKBJX7J2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4DC31A54C
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764010642; cv=none; b=BAxLwVhiTgK0NzQKeoQnZlUT5HXvp6ZxkkiDhysR2YwvXojWPLixSox2SsV8B9WV4HUFCRuH9HarUVGCmAauo5gBnHFs//7PlM2/O9cETCAW2mPIddGvnXUEtjronEf6J9Ig4HcwmuA9AJZtjMKAqY5uRkXyAVBXM7D0hgcnXyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764010642; c=relaxed/simple;
	bh=4szzftfNVajYa8yjXj5A2aucsirmbAT0lUgcthDm568=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnS6q+JrXkfEWn8JMSrFe0FmCruL5yUlb6OwuZe3VEl+MM+X1JFYeSO9p9CqO9F6JAJkO5buFxWGB7wV8qrOy6PbYNAFu2uVQIIfujGYeP8wgLLpEvdVqpOkbs8kqBMSkO2QGTp4CSasU4VJiNMFtZ1HLF9y94K5ttbQ0Zq+UBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKBJX7J2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A0EC116C6;
	Mon, 24 Nov 2025 18:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764010642;
	bh=4szzftfNVajYa8yjXj5A2aucsirmbAT0lUgcthDm568=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bKBJX7J2T876oMlEB4c5jDhiBn9zQJ1wOyj0WgyQV7FsDxqgI7gxIf5A86XgcbE48
	 K7hCKW9eFKOnQ1dOyw0LGkBFwpcZ+rrjx+nWZHuk5dagCKgiTfqVyGq5im39CGff/V
	 sHWsA8vBGF58gDrKakWiqwbm6rGkcZSjLnW5INz+HmJWHkA7/Po/rTOH++FZP3lojy
	 Pm7EdirBFbc9TOImSq1Syk4Ej4ssTrP47GHagjnsczF75k9U6dYYtX0a2AzOAiEeXV
	 6q4HsvlmshUp0HCVbjt52TDr11SuZAmMEhSc8BI8go0qf2kQTde5OZZp/S7U7OIlR+
	 T0MuGgk2mpmLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Ville Syrjala <syrjala@sci.fi>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] Input: remove third argument of usb_maxpacket()
Date: Mon, 24 Nov 2025 13:57:17 -0500
Message-ID: <20251124185718.4192041-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124185718.4192041-1-sashal@kernel.org>
References: <2025112420-cleaver-backlight-0d73@gregkh>
 <20251124185718.4192041-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

[ Upstream commit 948bf187694fc1f4c20cf972fa18b1a6fb3d7603 ]

The third argument of usb_maxpacket(): in_out has been deprecated
because it could be derived from the second argument (e.g. using
usb_pipeout(pipe)).

N.B. function usb_maxpacket() was made variadic to accommodate the
transition from the old prototype with three arguments to the new one
with only two arguments (so that no renaming is needed). The variadic
argument is to be removed once all users of usb_maxpacket() get
migrated.

CC: Ville Syrjala <syrjala@sci.fi>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Henk Vergonet <Henk.Vergonet@gmail.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/r/20220317035514.6378-4-mailhol.vincent@wanadoo.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 69aeb5073123 ("Input: pegasus-notetaker - fix potential out-of-bounds access")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/ati_remote2.c         | 2 +-
 drivers/input/misc/cm109.c               | 2 +-
 drivers/input/misc/powermate.c           | 2 +-
 drivers/input/misc/yealink.c             | 2 +-
 drivers/input/tablet/acecad.c            | 2 +-
 drivers/input/tablet/pegasus_notetaker.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index 8a36d78fed63a..946bf75aa1061 100644
--- a/drivers/input/misc/ati_remote2.c
+++ b/drivers/input/misc/ati_remote2.c
@@ -639,7 +639,7 @@ static int ati_remote2_urb_init(struct ati_remote2 *ar2)
 			return -ENOMEM;
 
 		pipe = usb_rcvintpipe(udev, ar2->ep[i]->bEndpointAddress);
-		maxp = usb_maxpacket(udev, pipe, usb_pipeout(pipe));
+		maxp = usb_maxpacket(udev, pipe);
 		maxp = maxp > 4 ? 4 : maxp;
 
 		usb_fill_int_urb(ar2->urb[i], udev, pipe, ar2->buf[i], maxp,
diff --git a/drivers/input/misc/cm109.c b/drivers/input/misc/cm109.c
index f515fae465c35..728325a2d574a 100644
--- a/drivers/input/misc/cm109.c
+++ b/drivers/input/misc/cm109.c
@@ -745,7 +745,7 @@ static int cm109_usb_probe(struct usb_interface *intf,
 
 	/* get a handle to the interrupt data pipe */
 	pipe = usb_rcvintpipe(udev, endpoint->bEndpointAddress);
-	ret = usb_maxpacket(udev, pipe, usb_pipeout(pipe));
+	ret = usb_maxpacket(udev, pipe);
 	if (ret != USB_PKT_LEN)
 		dev_err(&intf->dev, "invalid payload size %d, expected %d\n",
 			ret, USB_PKT_LEN);
diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
index 6b1b95d58e6b5..db2ba89adaefa 100644
--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -374,7 +374,7 @@ static int powermate_probe(struct usb_interface *intf, const struct usb_device_i
 
 	/* get a handle to the interrupt data pipe */
 	pipe = usb_rcvintpipe(udev, endpoint->bEndpointAddress);
-	maxp = usb_maxpacket(udev, pipe, usb_pipeout(pipe));
+	maxp = usb_maxpacket(udev, pipe);
 
 	if (maxp < POWERMATE_PAYLOAD_SIZE_MIN || maxp > POWERMATE_PAYLOAD_SIZE_MAX) {
 		printk(KERN_WARNING "powermate: Expected payload of %d--%d bytes, found %d bytes!\n",
diff --git a/drivers/input/misc/yealink.c b/drivers/input/misc/yealink.c
index 8ab01c7601b12..69420781db300 100644
--- a/drivers/input/misc/yealink.c
+++ b/drivers/input/misc/yealink.c
@@ -905,7 +905,7 @@ static int usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 
 	/* get a handle to the interrupt data pipe */
 	pipe = usb_rcvintpipe(udev, endpoint->bEndpointAddress);
-	ret = usb_maxpacket(udev, pipe, usb_pipeout(pipe));
+	ret = usb_maxpacket(udev, pipe);
 	if (ret != USB_PKT_LEN)
 		dev_err(&intf->dev, "invalid payload size %d, expected %zd\n",
 			ret, USB_PKT_LEN);
diff --git a/drivers/input/tablet/acecad.c b/drivers/input/tablet/acecad.c
index a38d1fe973340..56c7e471ac32e 100644
--- a/drivers/input/tablet/acecad.c
+++ b/drivers/input/tablet/acecad.c
@@ -130,7 +130,7 @@ static int usb_acecad_probe(struct usb_interface *intf, const struct usb_device_
 		return -ENODEV;
 
 	pipe = usb_rcvintpipe(dev, endpoint->bEndpointAddress);
-	maxp = usb_maxpacket(dev, pipe, usb_pipeout(pipe));
+	maxp = usb_maxpacket(dev, pipe);
 
 	acecad = kzalloc(sizeof(struct usb_acecad), GFP_KERNEL);
 	input_dev = input_allocate_device();
diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index 749edbdb7ffa4..c608ac505d1ba 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -296,7 +296,7 @@ static int pegasus_probe(struct usb_interface *intf,
 	pegasus->intf = intf;
 
 	pipe = usb_rcvintpipe(dev, endpoint->bEndpointAddress);
-	pegasus->data_len = usb_maxpacket(dev, pipe, usb_pipeout(pipe));
+	pegasus->data_len = usb_maxpacket(dev, pipe);
 
 	pegasus->data = usb_alloc_coherent(dev, pegasus->data_len, GFP_KERNEL,
 					   &pegasus->data_dma);
-- 
2.51.0


