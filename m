Return-Path: <stable+bounces-78719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15A198D49D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD001F2163D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6061D0416;
	Wed,  2 Oct 2024 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KC3mRczq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KC3mRczq"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D3B1CF28B;
	Wed,  2 Oct 2024 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875327; cv=none; b=biJJJw29FtpeyhjPxoQLdTT3wYITrrfh7pa5n4y4eaO+QrhG+1LSudEWl9TrRPnmMwVtBVx3StAgxVsjXF2VIiQrxjWvgOnmpjzsGqbt2DEtxRVlM+fQ9tm1insw6CIbN0UW8EmU/XFUpqVnJHf6Z9B8VRadf1oTtwp9NF8kWR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875327; c=relaxed/simple;
	bh=lvQtIkNhcOBFVU03ImrmL497/i4KYu1ckOuim9XxgVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jqUN18TWjj5LYODY4VP52UNBe/IGdCKXW9cWB7hpXwVsMD+vUGwNAg7bl7g4Gj/BdiG0n2qBuNWgszn/PQG1x7V4JoU2nW1Bhi5K64bagXa0Fek/i8/hHsuH/cfAXo/jIvYNQNHJ3a1AWdQP/dID1ors8O6TXa085pM1YJsmk2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KC3mRczq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KC3mRczq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE2731FD5F;
	Wed,  2 Oct 2024 13:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727875323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HGMmi+18cEyjZ0iT69AoFnPGR02WVVhK+v9hzQ2Rpbc=;
	b=KC3mRczqxnYFGeCFKg37+vseLzilg0AHhrDqlDaYsmzWl/ZzkRitHKc8XWlPYzkhO2WgB4
	z2mf7hITAq9TSLHAHVEzOwlK8jJkgM56Xdhzg0koRPl+hzNhtEuNxhN487LjNZ19654zMD
	v9lyp/ormLrzW8766IRgVHhoBvGDWwo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=KC3mRczq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727875323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HGMmi+18cEyjZ0iT69AoFnPGR02WVVhK+v9hzQ2Rpbc=;
	b=KC3mRczqxnYFGeCFKg37+vseLzilg0AHhrDqlDaYsmzWl/ZzkRitHKc8XWlPYzkhO2WgB4
	z2mf7hITAq9TSLHAHVEzOwlK8jJkgM56Xdhzg0koRPl+hzNhtEuNxhN487LjNZ19654zMD
	v9lyp/ormLrzW8766IRgVHhoBvGDWwo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91CE713A6E;
	Wed,  2 Oct 2024 13:22:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5a1lIvtI/WaxGwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Wed, 02 Oct 2024 13:22:03 +0000
From: Oliver Neukum <oneukum@suse.com>
To: keithp@keithp.com,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	syzbot+422188bce66e76020e55@syzkaller.appspotmail.com
Subject: [PATCH] USB: chaoskey: fail open after removal
Date: Wed,  2 Oct 2024 15:21:41 +0200
Message-ID: <20241002132201.552578-1-oneukum@suse.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BE2731FD5F
X-Spam-Score: -1.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[422188bce66e76020e55];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

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
---
 drivers/usb/misc/chaoskey.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/misc/chaoskey.c b/drivers/usb/misc/chaoskey.c
index 6fb5140e29b9..e8b63df5f975 100644
--- a/drivers/usb/misc/chaoskey.c
+++ b/drivers/usb/misc/chaoskey.c
@@ -27,6 +27,8 @@ static struct usb_class_driver chaoskey_class;
 static int chaoskey_rng_read(struct hwrng *rng, void *data,
 			     size_t max, bool wait);
 
+static DEFINE_MUTEX(chaoskey_list_lock);
+
 #define usb_dbg(usb_if, format, arg...) \
 	dev_dbg(&(usb_if)->dev, format, ## arg)
 
@@ -230,6 +232,7 @@ static void chaoskey_disconnect(struct usb_interface *interface)
 	if (dev->hwrng_registered)
 		hwrng_unregister(&dev->hwrng);
 
+	mutex_lock(&chaoskey_list_lock);
 	usb_deregister_dev(interface, &chaoskey_class);
 
 	usb_set_intfdata(interface, NULL);
@@ -244,6 +247,7 @@ static void chaoskey_disconnect(struct usb_interface *interface)
 	} else
 		mutex_unlock(&dev->lock);
 
+	mutex_unlock(&chaoskey_list_lock);
 	usb_dbg(interface, "disconnect done");
 }
 
@@ -251,6 +255,7 @@ static int chaoskey_open(struct inode *inode, struct file *file)
 {
 	struct chaoskey *dev;
 	struct usb_interface *interface;
+	int rv = 0;
 
 	/* get the interface from minor number and driver information */
 	interface = usb_find_interface(&chaoskey_driver, iminor(inode));
@@ -266,18 +271,23 @@ static int chaoskey_open(struct inode *inode, struct file *file)
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
@@ -286,14 +296,15 @@ static int chaoskey_release(struct inode *inode, struct file *file)
 
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
@@ -302,13 +313,15 @@ static int chaoskey_release(struct inode *inode, struct file *file)
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
2.46.1


