Return-Path: <stable+bounces-33915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB358939D6
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 11:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4551C2105C
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E289710A3E;
	Mon,  1 Apr 2024 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="OVDxb2V3"
X-Original-To: stable@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733A3101C5;
	Mon,  1 Apr 2024 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711965452; cv=none; b=eNIuOlvLvvCDb6DoAOHI7hqKadlUBdhj3DGo5boObNuwUuW7RgZOvn3Mr5IeVhIfZutsCgpwHdClx+9DBEPEvbpbXbdknZ5D2SU1xArjFPgzNn+I1Z3Vo/KvT1kYzt5xPrRU4dUEdX48elHzUeh2GM4RTgWVrugdKovmefswjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711965452; c=relaxed/simple;
	bh=VQZhdw09jrXTFrGwzX+rLaXVEw+XW/mOek8JIA6cGZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knJRyrbB0jtPJ1ZMtpR6QbdjmCM+ImQsuajU/iTHYsWetlD99QP8g7+BOq3clVE+5beg7dfICRwFHHRe30Y6383mWxwfSH3VZDDHfh8yH+F9p6GjMUp6E8jkXw6h3COmswhr6mAMq3Fli/K7+TfZIulFmoKJSRuMiqs8CsoL72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=OVDxb2V3; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1711965440;
	bh=VQZhdw09jrXTFrGwzX+rLaXVEw+XW/mOek8JIA6cGZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OVDxb2V3ZvrNNEUNEbfcoMuWiqa9QKUV+uMtT+2IHg1rw2OI9CbY47okrm8rOqDSY
	 cLk7eqXhB3ap6DsRA9Kf9mGu9957NQtiu4UkDxwx62342UPUtt1v51QRsG52DyMA6E
	 vKBPcM5TA3RUtjFGq6FxEPRsjabOReBmuT7iG27Y=
To: dgilbert@interlog.com
Cc: gregkh@linuxfoundation.org,
	sachinp@linux.ibm.com,
	Alexander@wetzel-home.de,
	bvanassche@acm.org,
	linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	martin.petersen@oracle.com,
	stable@vger.kernel.org
Subject: [PATCH] scsi: sg: Avoid race in error handling & drop bogus warn
Date: Mon,  1 Apr 2024 11:56:29 +0200
Message-ID: <20240401095629.5089-1-Alexander@wetzel-home.de>
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
sg_device_destroy() after scsi_device_put() when handling errors.

sg_device_destroy() is accessing the parent scsi_device request_queue which
will already be set to NULL when the preceding call to scsi_device_put()
removed the last reference to the parent scsi_device.

Drop the incorrect WARN_ON_ONCE() - allowing more than one concurrent
access to the sg device -  and make sure sg_device_destroy() is not used
after scsi_device_put() in the error handling.

Link: https://lore.kernel.org/all/5375B275-D137-4D5F-BE25-6AF8ACAE41EF@linux.ibm.com
Fixes: 27f58c04a8f4 ("scsi: sg: Avoid sg device teardown race")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---

The WARN_ON_ONCE() was kind of stupid to add:
We get add reference for each sg_open(). So opening a second session and
then closing either one will trigger the warning... Nothing to warn
about here.

Alexander
---
 drivers/scsi/sg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 386981c6976a..833c9277419b 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -372,8 +372,9 @@ sg_open(struct inode *inode, struct file *filp)
 error_out:
 	scsi_autopm_put_device(sdp->device);
 sdp_put:
+	kref_put(&sdp->d_ref, sg_device_destroy);
 	scsi_device_put(sdp->device);
-	goto sg_put;
+	return retval;
 }
 
 /* Release resources associated with a successful sg_open()
@@ -2233,7 +2234,6 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 			"sg_remove_sfp: sfp=0x%p\n", sfp));
 	kfree(sfp);
 
-	WARN_ON_ONCE(kref_read(&sdp->d_ref) != 1);
 	kref_put(&sdp->d_ref, sg_device_destroy);
 	scsi_device_put(device);
 	module_put(THIS_MODULE);
-- 
2.44.0


