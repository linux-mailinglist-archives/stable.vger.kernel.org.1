Return-Path: <stable+bounces-96125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70A59E08AD
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C2F280DB2
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC621B0F13;
	Mon,  2 Dec 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVC3Xqtf"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C811A76CE
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733157321; cv=none; b=k4Qh37Y0+AniB/tRnGIkKg4QEWMEaPZF6Lwnvj7Bf/z1yoiLO74wZ7YCUwAW675OIlP0gUjPpOBNMfb4IV8pByCITeJT8Lb8lBgus/tY61mVWaJnMWCgL05Uh600xeEuM+vF8gN8LrIpw8D9I5jdPxP3Esgzog/wDhwbGw2fQUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733157321; c=relaxed/simple;
	bh=2WJjzL+pv8PFUXma2u5w7rZ1vfalpOgBja+PmYhDx+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DudkeJJnimd4QSarns7LwmVAih4LAQ4+Hb9L+IUA173F5f2ecQhEchTok0w3UVSN27dfIJ8FLjKlefRu1Fa2z3inF1zyfVnk4uNh6WwI/emff0tyJ2ubTAoBWhcjKLHwQedw6ZlMi0sbIHeRxuoN8GlenOW3bDjXbS3m/UBVJSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVC3Xqtf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733157319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HyGIJzVjB5pGO8vz5bCSJn+OKkV4sWqeKPCojQqGMsI=;
	b=EVC3Xqtfx+h5tYa29sp2LPgM/w3YSXoRUhR2TaNPT6ukM66WZvb1n7EoyG3Otu0Wy83r7O
	sg7ucGHtDrP+euwnX/k26Z91IV3gdDbkQf206qfDk7FjbVMOWwBq0+fhjst+CH2bEbjItf
	iLSboTHfk1bQNVuEdkRrBjSG/ktDBvo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-mD4-SnjqMTOHeOCYYchrdw-1; Mon,
 02 Dec 2024 11:35:13 -0500
X-MC-Unique: mD4-SnjqMTOHeOCYYchrdw-1
X-Mimecast-MFC-AGG-ID: mD4-SnjqMTOHeOCYYchrdw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D4901964CDF;
	Mon,  2 Dec 2024 16:35:10 +0000 (UTC)
Received: from rhel-developer-toolbox-2.redhat.com (unknown [10.45.225.22])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 32FD0195608A;
	Mon,  2 Dec 2024 16:35:05 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Ma Ke <make24@iscas.ac.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	George Spelvin <linux@horizon.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/6] pps: fix cdev use-after-free
Date: Mon,  2 Dec 2024 17:34:46 +0100
Message-ID: <20241202163451.1442566-2-mschmidt@redhat.com>
In-Reply-To: <20241202163451.1442566-1-mschmidt@redhat.com>
References: <20241202163451.1442566-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The lifetime of a struct pps_device and the struct cdev embedded in it
is under control of the associated struct device.
The cdev's .open/.release methods (pps_cdev_{open,release}()) try to
keep the device alive while the cdev is open, but this is insufficient.

Consider this sequence:
1. Attach the PPS line discipline to a TTY.
2. Open the created /dev/pps* file.
3. Detach the PPS line discipline.
4. Close the file.

In this scenario, the last reference to the cdev is not released from
pps code, but in __fput(), *after* running the .release method, which
frees the pps_device (including struct cdev).

Fix this by using cdev_set_parent() to ensure that the pps_device
outlives the cdev.

cdev_set_parent() should be used before cdev_add(), but we can't do that
here, because at that point we don't have the dev yet. It's created
in the next step with device_create(). To compensate, bump the refcount
of the dev, which is what cdev_add() would have done if we followed the
usual order. This will be cleaned up in subsequent patches.

With the parent relationship in place, the .open/.release methods no
longer need to change the refcount. The cdev reference held by the core
filesystem code is enough to keep the pps device alive.
The .release method had nothing else to do, so remove it.

Move the cdev_del() from pps_device_destruct() to pps_unregister_cdev().
This is necessary. Otherwise, the pps_device would be holding a
reference to itself and never get released. It also brings symmetry
between pps_register_cdev() and pps_unregister_cdev().

KASAN detection of the bug:

 pps_core: deallocating pps0
 ==================================================================
 BUG: KASAN: slab-use-after-free in cdev_put+0x4e/0x50
 Read of size 8 at addr ff1100001c1c7360 by task sleep/1192

 CPU: 0 UID: 0 PID: 1192 Comm: sleep Not tainted 6.12.0-0.rc7.59.fc42.x86_64+debug #1
 Hardware name: Red Hat OpenStack Compute, BIOS 1.14.0-1.module+el8.4.0+8855+a9e237a9 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x84/0xd0
  print_report+0x174/0x505
  kasan_report+0xab/0x180
  cdev_put+0x4e/0x50
  __fput+0x725/0xaa0
  task_work_run+0x119/0x200
  do_exit+0x8ef/0x27a0
  do_group_exit+0xbc/0x250
  get_signal+0x1b78/0x1e00
  arch_do_signal_or_restart+0x8f/0x570
  syscall_exit_to_user_mode+0x1f4/0x290
  do_syscall_64+0xa3/0x190
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f6c598342d6
 Code: Unable to access opcode bytes at 0x7f6c598342ac.
 RSP: 002b:00007ffff3528160 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
 RAX: fffffffffffffdfc RBX: 00007f6c597c5740 RCX: 00007f6c598342d6
 RDX: 00007ffff35281f0 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: 00007ffff3528170 R08: 0000000000000000 R09: 0000000000000000
 R10: 00007ffff35281e0 R11: 0000000000000202 R12: 00007f6c597c56c8
 R13: 00007ffff35281e0 R14: 000000000000003c R15: 00007ffff35281e0
  </TASK>

 Allocated by task 1186:
  kasan_save_stack+0x30/0x50
  kasan_save_track+0x14/0x30
  __kasan_kmalloc+0x8f/0xa0
  pps_register_source+0xe4/0x360
  pps_tty_open+0x191/0x220 [pps_ldisc]
  tty_ldisc_open+0x75/0xc0
  tty_set_ldisc+0x29e/0x730
  tty_ioctl+0x866/0x11e0
  __x64_sys_ioctl+0x12e/0x1a0
  do_syscall_64+0x97/0x190
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

 Freed by task 1192:
  kasan_save_stack+0x30/0x50
  kasan_save_track+0x14/0x30
  kasan_save_free_info+0x3b/0x70
  __kasan_slab_free+0x37/0x50
  kfree+0x140/0x4d0
  device_release+0x9c/0x210
  kobject_put+0x17c/0x4b0
  pps_cdev_release+0x56/0x70
  __fput+0x368/0xaa0
  task_work_run+0x119/0x200
  do_exit+0x8ef/0x27a0
  do_group_exit+0xbc/0x250
  get_signal+0x1b78/0x1e00
  arch_do_signal_or_restart+0x8f/0x570
  syscall_exit_to_user_mode+0x1f4/0x290
  do_syscall_64+0xa3/0x190
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

 The buggy address belongs to the object at ff1100001c1c7200
                which belongs to the cache kmalloc-rnd-02-512 of size 512
 The buggy address is located 352 bytes inside of
                freed 512-byte region [ff1100001c1c7200, ff1100001c1c7400)
 [...]
 ==================================================================

Fixes: eae9d2ba0cfc ("LinuxPPS: core support")
Fixes: d953e0e837e6 ("pps: Fix a use-after free bug when unregistering a source.")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/pps/pps.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 25d47907db17..4f497353daa2 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -301,15 +301,6 @@ static int pps_cdev_open(struct inode *inode, struct file *file)
 	struct pps_device *pps = container_of(inode->i_cdev,
 						struct pps_device, cdev);
 	file->private_data = pps;
-	kobject_get(&pps->dev->kobj);
-	return 0;
-}
-
-static int pps_cdev_release(struct inode *inode, struct file *file)
-{
-	struct pps_device *pps = container_of(inode->i_cdev,
-						struct pps_device, cdev);
-	kobject_put(&pps->dev->kobj);
 	return 0;
 }
 
@@ -324,15 +315,12 @@ static const struct file_operations pps_cdev_fops = {
 	.compat_ioctl	= pps_cdev_compat_ioctl,
 	.unlocked_ioctl	= pps_cdev_ioctl,
 	.open		= pps_cdev_open,
-	.release	= pps_cdev_release,
 };
 
 static void pps_device_destruct(struct device *dev)
 {
 	struct pps_device *pps = dev_get_drvdata(dev);
 
-	cdev_del(&pps->cdev);
-
 	/* Now we can release the ID for re-use */
 	pr_debug("deallocating pps%d\n", pps->id);
 	mutex_lock(&pps_idr_lock);
@@ -383,6 +371,10 @@ int pps_register_cdev(struct pps_device *pps)
 		goto del_cdev;
 	}
 
+	cdev_set_parent(&pps->cdev, &pps->dev->kobj);
+	/* Compensate for setting the parent after cdev_add() */
+	get_device(pps->dev);
+
 	/* Override the release function with our own */
 	pps->dev->release = pps_device_destruct;
 
@@ -407,6 +399,7 @@ void pps_unregister_cdev(struct pps_device *pps)
 	pr_debug("unregistering pps%d\n", pps->id);
 	pps->lookup_cookie = NULL;
 	device_destroy(pps_class, pps->dev->devt);
+	cdev_del(&pps->cdev);
 }
 
 /*
-- 
2.47.0


