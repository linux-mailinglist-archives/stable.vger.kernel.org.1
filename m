Return-Path: <stable+bounces-86958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8919A5353
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 11:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BECD2821DC
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 09:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E52E3EA64;
	Sun, 20 Oct 2024 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0kHioe94"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257993A27E
	for <stable@vger.kernel.org>; Sun, 20 Oct 2024 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729416714; cv=none; b=RCu3cgBOcLE4yVC13odCCzGfEoAA3NQjlRewtpfAh62EDPdLzeaZHjkj/DlYJ66W0h3vPWEJnf3S1uERPsLeGqAme6YLYlbHEG2k+5LQd8vLncDGHBaCtQT+5+iTuwOU8OS0nld9b8HoIimpSF1hl6BM2KroEAvafVE6Er3Cij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729416714; c=relaxed/simple;
	bh=rcuXbXhofN4ySyTUaXlhSCWzjL42ximTgshFT91elHg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c2ANUQkiFUEoeiJjNF4EyDWMVAQUekByOPi4ZMK4HHrJuVPRjr+xluFxaUHFui1jQvSWVnUQPDo996XkizbwlVHoKbCx2YXYBpwKnQip0IyBy6Kwdd9uAHzFwbJmYal8Ate/pSYGzgEeZsUhZv96eIonsZ6n5YyAn3XWmBEdUbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0kHioe94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFC1C4CEC6;
	Sun, 20 Oct 2024 09:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729416713;
	bh=rcuXbXhofN4ySyTUaXlhSCWzjL42ximTgshFT91elHg=;
	h=Subject:To:Cc:From:Date:From;
	b=0kHioe94oL761JlbHtvG+4UgpsSFSkE9wRSzFp1y42Gg8+dyxIxYnba0QqYev7gxH
	 H2N6O1fGzZ1CuIKWE3nIgI7DSJv5KV01ZUnuwyCf+WF2XnaxjTtya8YbhINuACvgbL
	 nq0IDlNEWy1ovvfm86ML2CWcibvR2chS0V4SAnnc=
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Set SDEV_OFFLINE when UFS is shut down" failed to apply to 5.15-stable tree
To: sh8267.baek@samsung.com,bvanassche@acm.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Oct 2024 11:31:50 +0200
Message-ID: <2024102050-unequal-radiator-f679@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 19a198b67767d952c8f3d0cf24eb3100522a8223
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102050-unequal-radiator-f679@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 19a198b67767d952c8f3d0cf24eb3100522a8223 Mon Sep 17 00:00:00 2001
From: Seunghwan Baek <sh8267.baek@samsung.com>
Date: Thu, 29 Aug 2024 18:39:13 +0900
Subject: [PATCH] scsi: ufs: core: Set SDEV_OFFLINE when UFS is shut down

There is a history of deadlock if reboot is performed at the beginning
of booting. SDEV_QUIESCE was set for all LU's scsi_devices by UFS
shutdown, and at that time the audio driver was waiting on
blk_mq_submit_bio() holding a mutex_lock while reading the fw binary.
After that, a deadlock issue occurred while audio driver shutdown was
waiting for mutex_unlock of blk_mq_submit_bio(). To solve this, set
SDEV_OFFLINE for all LUs except WLUN, so that any I/O that comes down
after a UFS shutdown will return an error.

[   31.907781]I[0:      swapper/0:    0]        1        130705007       1651079834      11289729804                0 D(   2) 3 ffffff882e208000 *             init [device_shutdown]
[   31.907793]I[0:      swapper/0:    0] Mutex: 0xffffff8849a2b8b0: owner[0xffffff882e28cb00 kworker/6:0 :49]
[   31.907806]I[0:      swapper/0:    0] Call trace:
[   31.907810]I[0:      swapper/0:    0]  __switch_to+0x174/0x338
[   31.907819]I[0:      swapper/0:    0]  __schedule+0x5ec/0x9cc
[   31.907826]I[0:      swapper/0:    0]  schedule+0x7c/0xe8
[   31.907834]I[0:      swapper/0:    0]  schedule_preempt_disabled+0x24/0x40
[   31.907842]I[0:      swapper/0:    0]  __mutex_lock+0x408/0xdac
[   31.907849]I[0:      swapper/0:    0]  __mutex_lock_slowpath+0x14/0x24
[   31.907858]I[0:      swapper/0:    0]  mutex_lock+0x40/0xec
[   31.907866]I[0:      swapper/0:    0]  device_shutdown+0x108/0x280
[   31.907875]I[0:      swapper/0:    0]  kernel_restart+0x4c/0x11c
[   31.907883]I[0:      swapper/0:    0]  __arm64_sys_reboot+0x15c/0x280
[   31.907890]I[0:      swapper/0:    0]  invoke_syscall+0x70/0x158
[   31.907899]I[0:      swapper/0:    0]  el0_svc_common+0xb4/0xf4
[   31.907909]I[0:      swapper/0:    0]  do_el0_svc+0x2c/0xb0
[   31.907918]I[0:      swapper/0:    0]  el0_svc+0x34/0xe0
[   31.907928]I[0:      swapper/0:    0]  el0t_64_sync_handler+0x68/0xb4
[   31.907937]I[0:      swapper/0:    0]  el0t_64_sync+0x1a0/0x1a4

[   31.908774]I[0:      swapper/0:    0]       49                0         11960702      11236868007                0 D(   2) 6 ffffff882e28cb00 *      kworker/6:0 [__bio_queue_enter]
[   31.908783]I[0:      swapper/0:    0] Call trace:
[   31.908788]I[0:      swapper/0:    0]  __switch_to+0x174/0x338
[   31.908796]I[0:      swapper/0:    0]  __schedule+0x5ec/0x9cc
[   31.908803]I[0:      swapper/0:    0]  schedule+0x7c/0xe8
[   31.908811]I[0:      swapper/0:    0]  __bio_queue_enter+0xb8/0x178
[   31.908818]I[0:      swapper/0:    0]  blk_mq_submit_bio+0x194/0x67c
[   31.908827]I[0:      swapper/0:    0]  __submit_bio+0xb8/0x19c

Fixes: b294ff3e3449 ("scsi: ufs: core: Enable power management for wlun")
Cc: stable@vger.kernel.org
Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>
Link: https://lore.kernel.org/r/20240829093913.6282-2-sh8267.baek@samsung.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f845166dc0d7..706dc81eb924 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -10197,7 +10197,9 @@ static void ufshcd_wl_shutdown(struct device *dev)
 	shost_for_each_device(sdev, hba->host) {
 		if (sdev == hba->ufs_device_wlun)
 			continue;
-		scsi_device_quiesce(sdev);
+		mutex_lock(&sdev->state_mutex);
+		scsi_device_set_state(sdev, SDEV_OFFLINE);
+		mutex_unlock(&sdev->state_mutex);
 	}
 	__ufshcd_wl_suspend(hba, UFS_SHUTDOWN_PM);
 


