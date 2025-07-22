Return-Path: <stable+bounces-164271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3D4B0E122
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 18:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B123AAE66
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0C5273806;
	Tue, 22 Jul 2025 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="ES+SjCP0"
X-Original-To: stable@vger.kernel.org
Received: from smtp112.iad3b.emailsrvr.com (smtp112.iad3b.emailsrvr.com [146.20.161.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03EDEEDE;
	Tue, 22 Jul 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200123; cv=none; b=fOvJG9D8y/61c/XZCn+h9bbKDH2ba3Dl6J7j+vhJDDoHl6kkYQG+dT0yB8Yxml3xHkNLWBRfZvtQy+yyukMYjzpVdUqTS24w9eGljnNgvfa7XtlvVkVu68Y2twQcvyDyVMbPJLU5JFE6J32OSDSuw8H/DCwMwiBspXor2Cor9mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200123; c=relaxed/simple;
	bh=6wyElbdRC6eiq4xjU1cm7n9DH4k2hM8Y8a4gNPO4qCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKe/NY7nFADTs4Ub+phrwpY5iK0LoXI/b/ioOkcHVYunhpC725UZrfhuOiVKYit7BiMogq2mS8PQAmoE8sCgXuXfDkNfT1BY++YVitpCPXpxbbDoj4uSQ4ep9XEnJEBLno3ObgQjWHZg1SLk3O3idKxI/3/id0BeX/O1Lv786Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=ES+SjCP0; arc=none smtp.client-ip=146.20.161.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753199639;
	bh=6wyElbdRC6eiq4xjU1cm7n9DH4k2hM8Y8a4gNPO4qCc=;
	h=From:To:Subject:Date:From;
	b=ES+SjCP0Msa1SlBOE70okAn5zhRKfBQvDyHvgOx0btBc2DZXuN8ltaN4d+DvpM3mw
	 uSN+PlaeVuxZo6CgLUZyNlcVeenMGyDSP7enjPij7P4zTqTKGr+FkN9ZM7IQ64+TLw
	 yIZv+Hk4eelHpVTXQT8LXcUwf1hzfwpthUAOz1x0=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp15.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 1E201C00D2;
	Tue, 22 Jul 2025 11:53:57 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org,
	syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com
Subject: [PATCH] comedi: fix race between polling and detaching
Date: Tue, 22 Jul 2025 16:53:16 +0100
Message-ID: <20250722155316.27432-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 3459e216-44bf-4ded-84cd-ecd8e49e474d-1-1

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

Cc: <stable@vger.kernel.org> # 5.13+
Fixes: 2f3fdcd7ce93 ("staging: comedi: add rw_semaphore to protect against device detachment")
Link: https://lore.kernel.org/all/687bd5fe.a70a0220.693ce.0091.GAE@google.com/
Reported-by: syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=01523a0ae5600aef5895
Co-developed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
Patch does not apply cleanly to longterm release series 5.10 and 5.4.
---
 drivers/comedi/comedi_fops.c     | 31 ++++++++++++++++++++++++-------
 drivers/comedi/comedi_internal.h |  1 +
 drivers/comedi/drivers.c         | 13 ++++++++++---
 3 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 3383a7ce27ff..3007fe946e42 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -787,6 +787,7 @@ static int is_device_busy(struct comedi_device *dev)
 	struct comedi_subdevice *s;
 	int i;
 
+	lockdep_assert_held_write(&dev->attach_lock);
 	lockdep_assert_held(&dev->mutex);
 	if (!dev->attached)
 		return 0;
@@ -795,7 +796,16 @@ static int is_device_busy(struct comedi_device *dev)
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
 
@@ -825,15 +835,22 @@ static int do_devconfig_ioctl(struct comedi_device *dev,
 		return -EPERM;
 
 	if (!arg) {
-		if (is_device_busy(dev))
-			return -EBUSY;
+		int rc = 0;
+
 		if (dev->attached) {
-			struct module *driver_module = dev->driver->module;
+			down_write(&dev->attach_lock);
+			if (is_device_busy(dev)) {
+				rc = -EBUSY;
+			} else {
+				struct module *driver_module =
+					dev->driver->module;
 
-			comedi_device_detach(dev);
-			module_put(driver_module);
+				comedi_device_detach_locked(dev);
+				module_put(driver_module);
+			}
+			up_write(&dev->attach_lock);
 		}
-		return 0;
+		return rc;
 	}
 
 	if (copy_from_user(&it, arg, sizeof(it)))
diff --git a/drivers/comedi/comedi_internal.h b/drivers/comedi/comedi_internal.h
index 9b3631a654c8..cf10ba016ebc 100644
--- a/drivers/comedi/comedi_internal.h
+++ b/drivers/comedi/comedi_internal.h
@@ -50,6 +50,7 @@ extern struct mutex comedi_drivers_list_lock;
 int insn_inval(struct comedi_device *dev, struct comedi_subdevice *s,
 	       struct comedi_insn *insn, unsigned int *data);
 
+void comedi_device_detach_locked(struct comedi_device *dev);
 void comedi_device_detach(struct comedi_device *dev);
 int comedi_device_attach(struct comedi_device *dev,
 			 struct comedi_devconfig *it);
diff --git a/drivers/comedi/drivers.c b/drivers/comedi/drivers.c
index 376130bfba8a..f5c2ee271d0e 100644
--- a/drivers/comedi/drivers.c
+++ b/drivers/comedi/drivers.c
@@ -158,7 +158,7 @@ static void comedi_device_detach_cleanup(struct comedi_device *dev)
 	int i;
 	struct comedi_subdevice *s;
 
-	lockdep_assert_held(&dev->attach_lock);
+	lockdep_assert_held_write(&dev->attach_lock);
 	lockdep_assert_held(&dev->mutex);
 	if (dev->subdevices) {
 		for (i = 0; i < dev->n_subdevices; i++) {
@@ -196,16 +196,23 @@ static void comedi_device_detach_cleanup(struct comedi_device *dev)
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
 
-- 
2.47.2


