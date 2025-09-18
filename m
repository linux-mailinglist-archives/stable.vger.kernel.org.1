Return-Path: <stable+bounces-176247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC51FB36C39
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30A18E67E3
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283A735206F;
	Tue, 26 Aug 2025 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vyJjqaHV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9723338F51;
	Tue, 26 Aug 2025 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219159; cv=none; b=gJ/PyPWUxTWJWjyR7v/GtUOd8DgHUwq4RhwPar2WZcTGf5FNu4USH/6YMKAl5oPNznh7PFKHMrKorNJF1Vas3idNfYvxHTzqbMT+h2pKDfXZgnUOhNp0GjBbkHB5Y6Iabk4pSoPLSehax8fNlKp1El8avorFFcDpJzNVQl8d3wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219159; c=relaxed/simple;
	bh=ZIWu3OLcnzOdsD3MoNhjphCpfC6rTpOHWUudKAGm/VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrackB4cQf0D6PC2E3dxaEjaTaoACpMlrt+TIU6vLvmK24uDmRsvwXFs1IcZtS6HuoaRV1iGIJ4vz7pafL050Ga9K8cWiOLK0mp39cx63JhBrw36a4tztgMDyhe+43NDLHQSSox9ZPf1TpeV5duMoA48ZKLIhK+CRNF7/Na/RO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vyJjqaHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28515C4CEF1;
	Tue, 26 Aug 2025 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219159;
	bh=ZIWu3OLcnzOdsD3MoNhjphCpfC6rTpOHWUudKAGm/VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vyJjqaHVs13g9j8XUfU44OV22TbU7+qOIhnHjtfuKbyCWngFnsCrTYFgrWuIL7jWd
	 QotUmP5Wtgjz9zlfJdk1Ef/iuoyEWPRNYSr7gOoTnBc3oxJMtPMFAE+udfznrI8urD
	 Y5bZioHZbtAb1YWxt7FWoHYRK9K0bu1gahKW2Gds=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com,
	Jens Axboe <axboe@kernel.dk>,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 5.4 275/403] comedi: fix race between polling and detaching
Date: Tue, 26 Aug 2025 13:10:01 +0200
Message-ID: <20250826110914.396984361@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Abbott <abbotti@mev.co.uk>

commit 35b6fc51c666fc96355be5cd633ed0fe4ccf68b2 upstream.

syzbot reports a use-after-free in comedi in the below link, which is
due to comedi gladly removing the allocated async area even though poll
requests are still active on the wait_queue_head inside of it. This can
cause a use-after-free when the poll entries are later triggered or
removed, as the memory for the wait_queue_head has been freed.  We need
to check there are no tasks queued on any of the subdevices' wait queues
before allowing the device to be detached by the `COMEDI_DEVCONFIG`
ioctl.

Tasks will read-lock `dev->attach_lock` before adding themselves to the
subdevice wait queue, so fix the problem in the `COMEDI_DEVCONFIG` ioctl
handler by write-locking `dev->attach_lock` before checking that all of
the subdevices are safe to be deleted.  This includes testing for any
sleepers on the subdevices' wait queues.  It remains locked until the
device has been detached.  This requires the `comedi_device_detach()`
function to be refactored slightly, moving the bulk of it into new
function `comedi_device_detach_locked()`.

Note that the refactor of `comedi_device_detach()` results in
`comedi_device_cancel_all()` now being called while `dev->attach_lock`
is write-locked, which wasn't the case previously, but that does not
matter.

Thanks to Jens Axboe for diagnosing the problem and co-developing this
patch.

Cc: stable <stable@kernel.org>
Fixes: 2f3fdcd7ce93 ("staging: comedi: add rw_semaphore to protect against device detachment")
Link: https://lore.kernel.org/all/687bd5fe.a70a0220.693ce.0091.GAE@google.com/
Reported-by: syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=01523a0ae5600aef5895
Co-developed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Tested-by: Jens Axboe <axboe@kernel.dk>
Link: https://lore.kernel.org/r/20250722155316.27432-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/comedi/comedi_fops.c     |   33 +++++++++++++++++++++++--------
 drivers/staging/comedi/comedi_internal.h |    1 
 drivers/staging/comedi/drivers.c         |   13 +++++++++---
 3 files changed, 36 insertions(+), 11 deletions(-)

--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -781,6 +781,7 @@ static int is_device_busy(struct comedi_
 	struct comedi_subdevice *s;
 	int i;
 
+	lockdep_assert_held_write(&dev->attach_lock);
 	lockdep_assert_held(&dev->mutex);
 	if (!dev->attached)
 		return 0;
@@ -789,7 +790,16 @@ static int is_device_busy(struct comedi_
 		s = &dev->subdevices[i];
 		if (s->busy)
 			return 1;
-		if (s->async && comedi_buf_is_mmapped(s))
+		if (!s->async)
+			continue;
+		if (comedi_buf_is_mmapped(s))
+			return 1;
+		/*
+		 * There may be tasks still waiting on the subdevice's wait
+		 * queue, although they should already be about to be removed
+		 * from it since the subdevice has no active async command.
+		 */
+		if (wq_has_sleeper(&s->async->wait_head))
 			return 1;
 	}
 
@@ -819,15 +829,22 @@ static int do_devconfig_ioctl(struct com
 		return -EPERM;
 
 	if (!arg) {
-		if (is_device_busy(dev))
-			return -EBUSY;
-		if (dev->attached) {
-			struct module *driver_module = dev->driver->module;
+		int rc = 0;
 
-			comedi_device_detach(dev);
-			module_put(driver_module);
+		if (dev->attached) {
+			down_write(&dev->attach_lock);
+			if (is_device_busy(dev)) {
+				rc = -EBUSY;
+			} else {
+				struct module *driver_module =
+					dev->driver->module;
+
+				comedi_device_detach_locked(dev);
+				module_put(driver_module);
+			}
+			up_write(&dev->attach_lock);
 		}
-		return 0;
+		return rc;
 	}
 
 	if (copy_from_user(&it, arg, sizeof(it)))
--- a/drivers/staging/comedi/comedi_internal.h
+++ b/drivers/staging/comedi/comedi_internal.h
@@ -50,6 +50,7 @@ extern struct mutex comedi_drivers_list_
 int insn_inval(struct comedi_device *dev, struct comedi_subdevice *s,
 	       struct comedi_insn *insn, unsigned int *data);
 
+void comedi_device_detach_locked(struct comedi_device *dev);
 void comedi_device_detach(struct comedi_device *dev);
 int comedi_device_attach(struct comedi_device *dev,
 			 struct comedi_devconfig *it);
--- a/drivers/staging/comedi/drivers.c
+++ b/drivers/staging/comedi/drivers.c
@@ -159,7 +159,7 @@ static void comedi_device_detach_cleanup
 	int i;
 	struct comedi_subdevice *s;
 
-	lockdep_assert_held(&dev->attach_lock);
+	lockdep_assert_held_write(&dev->attach_lock);
 	lockdep_assert_held(&dev->mutex);
 	if (dev->subdevices) {
 		for (i = 0; i < dev->n_subdevices; i++) {
@@ -196,16 +196,23 @@ static void comedi_device_detach_cleanup
 	comedi_clear_hw_dev(dev);
 }
 
-void comedi_device_detach(struct comedi_device *dev)
+void comedi_device_detach_locked(struct comedi_device *dev)
 {
+	lockdep_assert_held_write(&dev->attach_lock);
 	lockdep_assert_held(&dev->mutex);
 	comedi_device_cancel_all(dev);
-	down_write(&dev->attach_lock);
 	dev->attached = false;
 	dev->detach_count++;
 	if (dev->driver)
 		dev->driver->detach(dev);
 	comedi_device_detach_cleanup(dev);
+}
+
+void comedi_device_detach(struct comedi_device *dev)
+{
+	lockdep_assert_held(&dev->mutex);
+	down_write(&dev->attach_lock);
+	comedi_device_detach_locked(dev);
 	up_write(&dev->attach_lock);
 }
 



