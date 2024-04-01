Return-Path: <stable+bounces-35486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC0189454F
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 21:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8EF282987
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B9751C4C;
	Mon,  1 Apr 2024 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="poi3KbXQ"
X-Original-To: stable@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712C251C44;
	Mon,  1 Apr 2024 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998664; cv=none; b=llL3LbC3+HnDpnnrxHrnXwybfutecIUdy+DQlZp1YVlCxHmnK+eq1S9v0tO0LeVSFb/KutQeeDNe7i+RRD87s8Yst+FSJ9N2rWzAAIvH6zFl6tOKrIU/ACRKfhWGYr6qUglxWG6DCGEFI3aFwwYrtR3+TJ6ODYcyO30go9Gnm84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998664; c=relaxed/simple;
	bh=l5AboQBubNlfjPSPGwV6zz3AoCLbpjWMoP+mef5uBv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUUM5A84KHYzFqD0HY3NX92V/TfMnYqgHmeVc73MSgey5mVziQZiBwztvygbT3E54au6di++3tNyP/DwmnND85loH8y+5+HJaSGAWkt6IfPJd7WmxZB3Nnsb0D41NBIFsUgvnNbf1IupzmeK/CTU91kpAn9/m91aaywKcCCsxH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=poi3KbXQ; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1711998656;
	bh=l5AboQBubNlfjPSPGwV6zz3AoCLbpjWMoP+mef5uBv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=poi3KbXQgsHiQr2KDJqeSIxNTyd2cnWiuPiPokZfcHRvP9X0w5IMvYt/TVH/S60+w
	 JgONKIR4R1k/3YQZFFdJTJ39c6VTa8kMQhXXPlnuB9kJnNa9Xw+vpwp5F2oJw7vIsM
	 Z4p/5WjknXHBR7Qxrn/LUdUlxtkknYum/aYm/MyU=
To: dgilbert@interlog.com
Cc: gregkh@linuxfoundation.org,
	sachinp@linux.ibm.com,
	Alexander@wetzel-home.de,
	bvanassche@acm.org,
	linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	martin.petersen@oracle.com,
	stable@vger.kernel.org
Subject: [PATCH v3] scsi: sg: Avoid race in error handling & drop bogus warn
Date: Mon,  1 Apr 2024 21:10:38 +0200
Message-ID: <20240401191038.18359-1-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <81266270-42F4-48F9-9139-8F0C3F0A6553@linux.ibm.com>
References: <81266270-42F4-48F9-9139-8F0C3F0A6553@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 27f58c04a8f4 ("scsi: sg: Avoid sg device teardown race")
introduced an incorrect WARN_ON_ONCE() and missed a sequence where
sg_device_destroy() was used after scsi_device_put().

sg_device_destroy() is accessing the parent scsi_device request_queue which
will already be set to NULL when the preceding call to scsi_device_put()
removed the last reference to the parent scsi_device.

Drop the incorrect WARN_ON_ONCE() - allowing more than one concurrent
access to the sg device - and make sure sg_device_destroy() is not used
after scsi_device_put() in the error handling.

Link: https://lore.kernel.org/all/5375B275-D137-4D5F-BE25-6AF8ACAE41EF@linux.ibm.com
Fixes: 27f58c04a8f4 ("scsi: sg: Avoid sg device teardown race")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---

Changes compared to V1: fixed commit message
Changes compared to V2: Fix use-after free
---
 drivers/scsi/sg.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 386981c6976a..baf870a03ecf 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -285,6 +285,7 @@ sg_open(struct inode *inode, struct file *filp)
 	int dev = iminor(inode);
 	int flags = filp->f_flags;
 	struct request_queue *q;
+	struct scsi_device *device;
 	Sg_device *sdp;
 	Sg_fd *sfp;
 	int retval;
@@ -301,11 +302,12 @@ sg_open(struct inode *inode, struct file *filp)
 
 	/* This driver's module count bumped by fops_get in <linux/fs.h> */
 	/* Prevent the device driver from vanishing while we sleep */
-	retval = scsi_device_get(sdp->device);
+	device = sdp->device;
+	retval = scsi_device_get(device);
 	if (retval)
 		goto sg_put;
 
-	retval = scsi_autopm_get_device(sdp->device);
+	retval = scsi_autopm_get_device(device);
 	if (retval)
 		goto sdp_put;
 
@@ -313,7 +315,7 @@ sg_open(struct inode *inode, struct file *filp)
 	 * check if O_NONBLOCK. Permits SCSI commands to be issued
 	 * during error recovery. Tread carefully. */
 	if (!((flags & O_NONBLOCK) ||
-	      scsi_block_when_processing_errors(sdp->device))) {
+	      scsi_block_when_processing_errors(device))) {
 		retval = -ENXIO;
 		/* we are in error recovery for this device */
 		goto error_out;
@@ -344,7 +346,7 @@ sg_open(struct inode *inode, struct file *filp)
 
 	if (sdp->open_cnt < 1) {  /* no existing opens */
 		sdp->sgdebug = 0;
-		q = sdp->device->request_queue;
+		q = device->request_queue;
 		sdp->sg_tablesize = queue_max_segments(q);
 	}
 	sfp = sg_add_sfp(sdp);
@@ -370,10 +372,11 @@ sg_open(struct inode *inode, struct file *filp)
 error_mutex_locked:
 	mutex_unlock(&sdp->open_rel_lock);
 error_out:
-	scsi_autopm_put_device(sdp->device);
+	scsi_autopm_put_device(device);
 sdp_put:
-	scsi_device_put(sdp->device);
-	goto sg_put;
+	kref_put(&sdp->d_ref, sg_device_destroy);
+	scsi_device_put(device);
+	return retval;
 }
 
 /* Release resources associated with a successful sg_open()
@@ -2233,7 +2236,6 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 			"sg_remove_sfp: sfp=0x%p\n", sfp));
 	kfree(sfp);
 
-	WARN_ON_ONCE(kref_read(&sdp->d_ref) != 1);
 	kref_put(&sdp->d_ref, sg_device_destroy);
 	scsi_device_put(device);
 	module_put(THIS_MODULE);
-- 
2.44.0


