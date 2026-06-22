Return-Path: <stable+bounces-267747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FXy5MYtVOWoIqwcAu9opvQ
	(envelope-from <stable+bounces-267747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 17:32:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 239756B0C10
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 17:32:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=n5Xw5jax;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267747-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267747-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3999C3057D5F
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 15:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350113988F8;
	Mon, 22 Jun 2026 15:27:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD97C37A4BC;
	Mon, 22 Jun 2026 15:27:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142053; cv=none; b=YPN81SKhocKhmskC3ExSVdy0jt4f1e+mvxbbTQmsI5zjUkav/WPLp/xrhUKf5eWa//2Mp5oZ4KOAhllVICT7OrzUceg34E3JBTZikjRJVVXeGfxF0DebzI1jXGnAdfC7W4GiBanSF6mAgJ7UNcSsGI0oB5YxZw3wG6ErEqPMz8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142053; c=relaxed/simple;
	bh=XpSGDIpRCRBAE29hwz+4orc/NRgr22LCWxO8o578Ytc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGuKzH2AViej98GVYfxj1TeQ5J6smy0MDU/y7bJzVtBomnNqjMHAp/P7whCXa/NQe5v924aXFMYxg+0yvPbwnw9IcSli9mtw5HVH9qYsMLNfZ+OnjqSICBXMtZHxGsuny85zWWrTSiE893Wjy8xVC7TPbva3qb2Dn7VlzD1M5U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5Xw5jax; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C5C1F00A3F;
	Mon, 22 Jun 2026 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782142051;
	bh=E7gkdZlqTSQVDTaW6A9yoz151Q1XtNekP8BRqWYpAJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n5Xw5jaxp5pm2PHA4STJDXsnKR4vBaF+s8bEICdWBCVmEMN+k3bMzEHqT/5Ap6Z8/
	 7Srx2npQtG+YcVFCrHCj1d0PrjhxNbvULRDvAucYtImFVXJN7LhaUjvRY7aHNWHMI/
	 VsYoORAeDbAZUUgiucDRNmERwSywXGb+3C6N45VtYzhhWWVGT3qOD82pnTDhgLGkDa
	 O21WIt3xYyocJGlMwlWzBh4uq6Wm53PMFfuzbtB7DyymmUPBQ8IX9grJMVqJayNx70
	 +I2r27cXFT0I5pUT/Vwbd0CNyWkrHzfenzuYjCfJBfmHG+VwoiuPDZFjn3n6aMWf7B
	 ikabF8pIDjE3g==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wbgYb-00000000UIz-19bP;
	Mon, 22 Jun 2026 17:27:29 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Juergen Stuber <starblue@users.sourceforge.net>,
	Yue Sun <samsun1006219@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Oliver Neukum <oliver@neukum.org>
Subject: [PATCH 2/4] USB: idmouse: fix use-after-free on disconnect race
Date: Mon, 22 Jun 2026 17:26:10 +0200
Message-ID: <20260622152612.116422-3-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622152612.116422-1-johan@kernel.org>
References: <20260622152612.116422-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[users.sourceforge.net,gmail.com,vger.kernel.org,kernel.org,neukum.org];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:starblue@users.sourceforge.net,m:samsun1006219@gmail.com,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johan@kernel.org,m:stable@vger.kernel.org,m:oliver@neukum.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267747-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[johan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,neukum.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 239756B0C10

mutex_unlock() may access the mutex structure after releasing the lock
and therefore cannot be used to manage lifetime of objects directly
(unlike spinlocks and refcounts). [1][2]

Use a kref to release the driver data to avoid use-after-free in
mutex_unlock() when release() races with disconnect().

[1] a51749ab34d9 ("locking/mutex: Document that mutex_unlock() is
                   non-atomic")
[2] 2b9d9e0a9ba0 ("locking/mutex: Clarify that mutex_unlock(), and most
                   other sleeping locks, can still use the lock object
                   after it's unlocked")

Fixes: 54d2bc068fd2 ("USB: fix locking in idmouse")
Cc: stable@vger.kernel.org	# 2.6.24
Cc: Oliver Neukum <oliver@neukum.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/misc/idmouse.c | 45 +++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/misc/idmouse.c b/drivers/usb/misc/idmouse.c
index 0f6b3464c2d6..3e37adf2bb57 100644
--- a/drivers/usb/misc/idmouse.c
+++ b/drivers/usb/misc/idmouse.c
@@ -63,6 +63,7 @@ MODULE_DEVICE_TABLE(usb, idmouse_table);
 
 /* structure to hold all of our device specific stuff */
 struct usb_idmouse {
+	struct kref kref;
 
 	struct usb_device *udev; /* save off the usb device pointer */
 	struct usb_interface *interface; /* the interface for this device */
@@ -209,8 +210,10 @@ static int idmouse_resume(struct usb_interface *intf)
 	return 0;
 }
 
-static inline void idmouse_delete(struct usb_idmouse *dev)
+static inline void idmouse_delete(struct kref *kref)
 {
+	struct usb_idmouse *dev = container_of(kref, struct usb_idmouse, kref);
+
 	kfree(dev->bulk_in_buffer);
 	kfree(dev);
 }
@@ -254,6 +257,8 @@ static int idmouse_open(struct inode *inode, struct file *file)
 		/* increment our usage count for the driver */
 		++dev->open;
 
+		kref_get(&dev->kref);
+
 		/* save our object in the file's private structure */
 		file->private_data = dev;
 
@@ -277,16 +282,11 @@ static int idmouse_release(struct inode *inode, struct file *file)
 
 	/* lock our device */
 	mutex_lock(&dev->lock);
-
 	--dev->open;
+	mutex_unlock(&dev->lock);
+
+	kref_put(&dev->kref, idmouse_delete);
 
-	if (!dev->present) {
-		/* the device was unplugged before the file was released */
-		mutex_unlock(&dev->lock);
-		idmouse_delete(dev);
-	} else {
-		mutex_unlock(&dev->lock);
-	}
 	return 0;
 }
 
@@ -334,6 +334,7 @@ static int idmouse_probe(struct usb_interface *interface,
 	if (dev == NULL)
 		return -ENOMEM;
 
+	kref_init(&dev->kref);
 	mutex_init(&dev->lock);
 	dev->udev = udev;
 	dev->interface = interface;
@@ -342,8 +343,7 @@ static int idmouse_probe(struct usb_interface *interface,
 	result = usb_find_bulk_in_endpoint(iface_desc, &endpoint);
 	if (result) {
 		dev_err(&interface->dev, "Unable to find bulk-in endpoint.\n");
-		idmouse_delete(dev);
-		return result;
+		goto err_put_kref;
 	}
 
 	dev->orig_bi_size = usb_endpoint_maxp(endpoint);
@@ -351,8 +351,8 @@ static int idmouse_probe(struct usb_interface *interface,
 	dev->bulk_in_endpointAddr = endpoint->bEndpointAddress;
 	dev->bulk_in_buffer = kmalloc(IMGSIZE + dev->bulk_in_size, GFP_KERNEL);
 	if (!dev->bulk_in_buffer) {
-		idmouse_delete(dev);
-		return -ENOMEM;
+		result = -ENOMEM;
+		goto err_put_kref;
 	}
 
 	/* allow device read, write and ioctl */
@@ -364,14 +364,18 @@ static int idmouse_probe(struct usb_interface *interface,
 	if (result) {
 		/* something prevented us from registering this device */
 		dev_err(&interface->dev, "Unable to allocate minor number.\n");
-		idmouse_delete(dev);
-		return result;
+		goto err_put_kref;
 	}
 
 	/* be noisy */
 	dev_info(&interface->dev,"%s now attached\n",DRIVER_DESC);
 
 	return 0;
+
+err_put_kref:
+	kref_put(&dev->kref, idmouse_delete);
+
+	return result;
 }
 
 static void idmouse_disconnect(struct usb_interface *interface)
@@ -387,14 +391,9 @@ static void idmouse_disconnect(struct usb_interface *interface)
 	/* prevent device read, write and ioctl */
 	dev->present = 0;
 
-	/* if the device is opened, idmouse_release will clean this up */
-	if (!dev->open) {
-		mutex_unlock(&dev->lock);
-		idmouse_delete(dev);
-	} else {
-		/* unlock */
-		mutex_unlock(&dev->lock);
-	}
+	mutex_unlock(&dev->lock);
+
+	kref_put(&dev->kref, idmouse_delete);
 
 	dev_info(&interface->dev, "disconnected\n");
 }
-- 
2.53.0


