Return-Path: <stable+bounces-103699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC179EF92D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679CD1898484
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FFC2210EA;
	Thu, 12 Dec 2024 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ie3/HtOX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A613C918;
	Thu, 12 Dec 2024 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025340; cv=none; b=lYEb+XrjEtmJsdrV7frdUqakAO+uUB58vmNSpM7CaGhrkbaJBJjJmR5oc1fhq1Ly5BaVySrj0tpnCrFG1cKku/Pjfy6mM58VwsuHhV5iKrpvaG/0eQ1YOsY6Rva1VY0bGTfGZWri/hsNs/Vxzvm/HepZjEluuz1BqAD/BZv54Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025340; c=relaxed/simple;
	bh=HrMBizKxK9v6h6AOHl2MhxoXWZrs+BF7jzfCIdy6/U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHFZL+Xjzq3cv7ZIN+VUAdKif5KPUp9oS7ttDRb1zpMM+SkKyzWH5RCpzwF5tzhGC33xyuFHq3X2iHkHQRdDTOm3Ttfm5iHzjTZ2S6hnNvR9eqpv6+kOYXlp/IBF+BwZDNM0P6sZnPJ4r5igapqz2tO4YR2dMcdnG27DQjIKJ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ie3/HtOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A38C4CECE;
	Thu, 12 Dec 2024 17:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025340;
	bh=HrMBizKxK9v6h6AOHl2MhxoXWZrs+BF7jzfCIdy6/U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ie3/HtOXbcx9g+xFDYHy9Zhm5k7XC2WXukQphkBJsTrPkext1KN94FM9DkwQbTojj
	 YqpFSn7H6WVJm1uIHXYF8w0Qco3WZrMh0N54jjma1x1xVBRPES5VXaHpbEuB6d7lQI
	 kN/8bqQKTnnbn7s9WSPiUPKgoYdaSHcbc8m4Wdl4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Neukum <oneukum@suse.com>,
	syzbot+422188bce66e76020e55@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 136/321] USB: chaoskey: fail open after removal
Date: Thu, 12 Dec 2024 16:00:54 +0100
Message-ID: <20241212144235.352800585@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit 422dc0a4d12d0b80dd3aab3fe5943f665ba8f041 ]

chaoskey_open() takes the lock only to increase the
counter of openings. That means that the mutual exclusion
with chaoskey_disconnect() cannot prevent an increase
of the counter and chaoskey_open() returning a success.

If that race is hit, chaoskey_disconnect() will happily
free all resources associated with the device after
it has dropped the lock, as it has read the counter
as zero.

To prevent this race chaoskey_open() has to check
the presence of the device under the lock.
However, the current per device lock cannot be used,
because it is a part of the data structure to be
freed. Hence an additional global mutex is needed.
The issue is as old as the driver.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Reported-by: syzbot+422188bce66e76020e55@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=422188bce66e76020e55
Fixes: 66e3e591891da ("usb: Add driver for Altus Metrum ChaosKey device (v2)")
Rule: add
Link: https://lore.kernel.org/stable/20241002132201.552578-1-oneukum%40suse.com
Link: https://lore.kernel.org/r/20241002132201.552578-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/misc/chaoskey.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/misc/chaoskey.c b/drivers/usb/misc/chaoskey.c
index 87067c3d6109b..32fa7fd50c380 100644
--- a/drivers/usb/misc/chaoskey.c
+++ b/drivers/usb/misc/chaoskey.c
@@ -27,6 +27,8 @@ static struct usb_class_driver chaoskey_class;
 static int chaoskey_rng_read(struct hwrng *rng, void *data,
 			     size_t max, bool wait);
 
+static DEFINE_MUTEX(chaoskey_list_lock);
+
 #define usb_dbg(usb_if, format, arg...) \
 	dev_dbg(&(usb_if)->dev, format, ## arg)
 
@@ -231,6 +233,7 @@ static void chaoskey_disconnect(struct usb_interface *interface)
 	if (dev->hwrng_registered)
 		hwrng_unregister(&dev->hwrng);
 
+	mutex_lock(&chaoskey_list_lock);
 	usb_deregister_dev(interface, &chaoskey_class);
 
 	usb_set_intfdata(interface, NULL);
@@ -245,6 +248,7 @@ static void chaoskey_disconnect(struct usb_interface *interface)
 	} else
 		mutex_unlock(&dev->lock);
 
+	mutex_unlock(&chaoskey_list_lock);
 	usb_dbg(interface, "disconnect done");
 }
 
@@ -252,6 +256,7 @@ static int chaoskey_open(struct inode *inode, struct file *file)
 {
 	struct chaoskey *dev;
 	struct usb_interface *interface;
+	int rv = 0;
 
 	/* get the interface from minor number and driver information */
 	interface = usb_find_interface(&chaoskey_driver, iminor(inode));
@@ -267,18 +272,23 @@ static int chaoskey_open(struct inode *inode, struct file *file)
 	}
 
 	file->private_data = dev;
+	mutex_lock(&chaoskey_list_lock);
 	mutex_lock(&dev->lock);
-	++dev->open;
+	if (dev->present)
+		++dev->open;
+	else
+		rv = -ENODEV;
 	mutex_unlock(&dev->lock);
+	mutex_unlock(&chaoskey_list_lock);
 
-	usb_dbg(interface, "open success");
-	return 0;
+	return rv;
 }
 
 static int chaoskey_release(struct inode *inode, struct file *file)
 {
 	struct chaoskey *dev = file->private_data;
 	struct usb_interface *interface;
+	int rv = 0;
 
 	if (dev == NULL)
 		return -ENODEV;
@@ -287,14 +297,15 @@ static int chaoskey_release(struct inode *inode, struct file *file)
 
 	usb_dbg(interface, "release");
 
+	mutex_lock(&chaoskey_list_lock);
 	mutex_lock(&dev->lock);
 
 	usb_dbg(interface, "open count at release is %d", dev->open);
 
 	if (dev->open <= 0) {
 		usb_dbg(interface, "invalid open count (%d)", dev->open);
-		mutex_unlock(&dev->lock);
-		return -ENODEV;
+		rv = -ENODEV;
+		goto bail;
 	}
 
 	--dev->open;
@@ -303,13 +314,15 @@ static int chaoskey_release(struct inode *inode, struct file *file)
 		if (dev->open == 0) {
 			mutex_unlock(&dev->lock);
 			chaoskey_free(dev);
-		} else
-			mutex_unlock(&dev->lock);
-	} else
-		mutex_unlock(&dev->lock);
-
+			goto destruction;
+		}
+	}
+bail:
+	mutex_unlock(&dev->lock);
+destruction:
+	mutex_lock(&chaoskey_list_lock);
 	usb_dbg(interface, "release success");
-	return 0;
+	return rv;
 }
 
 static void chaos_read_callback(struct urb *urb)
-- 
2.43.0




