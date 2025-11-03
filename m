Return-Path: <stable+bounces-192112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BA0C29BD2
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 01:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314FA188C241
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 00:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3FD1B424F;
	Mon,  3 Nov 2025 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oCa27Xjx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B162217C77
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 00:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130978; cv=none; b=ROF8ZjuP4fbSgCQ1SH3PbSsQtf2uZjTdFQ3pTHtfipAkfxzAUNtcHdnTccNopWVLHNr5erlfZwG3iy1BzHoPjszVCdgkOta5gC1UXDVn5BzU6h61I4vkxVYGEzR5ahCtWiW5DODMFIi9xacqhVC2mM5Ckm757W2jt6O6rDviGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130978; c=relaxed/simple;
	bh=X9MZRVAxdi2G2AieWsxxdw7QB+LkZgxLGlyhtMwJqvg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Iond23BE1hsHhpjGS75Zxj0rjmH4TtvIq2Q4+iwdBneLJYTqu9kap+7KlmGZO608QJZ7r6AvpIs7Mz6H+ZGXkUvGhPSeKvfZOUR4H0f/BI7hUuXCR1t6bEYqs8VXsFoj8YXD4aq5sw0RYgQalp+7USL5YDoWpuV+J82/I00MNvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oCa27Xjx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3582CC4CEF7;
	Mon,  3 Nov 2025 00:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762130978;
	bh=X9MZRVAxdi2G2AieWsxxdw7QB+LkZgxLGlyhtMwJqvg=;
	h=Subject:To:Cc:From:Date:From;
	b=oCa27XjxCsNgUdXA/thSv9DsM+5GhwWmkc/pE7nvDd8aW3eaEjoshoJ27cApggjzt
	 kh8xlznN3lXLxoOnNJmAnUZYXRN2W0JDqa4XO+DmOcl5A1M60GSnSE5WoHTbV3SAD/
	 MF/dJu/P7Ju8Ks1IHuql+v8dYWWgrmRTzWPM65O0=
Subject: FAILED: patch "[PATCH] s390/pci: Avoid deadlock between PCI error recovery and mlx5" failed to apply to 6.6-stable tree
To: gbayer@linux.ibm.com,hca@linux.ibm.com,schnelle@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 03 Nov 2025 09:49:27 +0900
Message-ID: <2025110327-capably-pond-f178@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0fd20f65df6aa430454a0deed8f43efa91c54835
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110327-capably-pond-f178@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0fd20f65df6aa430454a0deed8f43efa91c54835 Mon Sep 17 00:00:00 2001
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Thu, 16 Oct 2025 11:27:03 +0200
Subject: [PATCH] s390/pci: Avoid deadlock between PCI error recovery and mlx5
 crdump

Do not block PCI config accesses through pci_cfg_access_lock() when
executing the s390 variant of PCI error recovery: Acquire just
device_lock() instead of pci_dev_lock() as powerpc's EEH and
generig PCI AER processing do.

During error recovery testing a pair of tasks was reported to be hung:

mlx5_core 0000:00:00.1: mlx5_health_try_recover:338:(pid 5553): health recovery flow aborted, PCI reads still not working
INFO: task kmcheck:72 blocked for more than 122 seconds.
      Not tainted 5.14.0-570.12.1.bringup7.el9.s390x #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kmcheck         state:D stack:0     pid:72    tgid:72    ppid:2      flags:0x00000000
Call Trace:
 [<000000065256f030>] __schedule+0x2a0/0x590
 [<000000065256f356>] schedule+0x36/0xe0
 [<000000065256f572>] schedule_preempt_disabled+0x22/0x30
 [<0000000652570a94>] __mutex_lock.constprop.0+0x484/0x8a8
 [<000003ff800673a4>] mlx5_unload_one+0x34/0x58 [mlx5_core]
 [<000003ff8006745c>] mlx5_pci_err_detected+0x94/0x140 [mlx5_core]
 [<0000000652556c5a>] zpci_event_attempt_error_recovery+0xf2/0x398
 [<0000000651b9184a>] __zpci_event_error+0x23a/0x2c0
INFO: task kworker/u1664:6:1514 blocked for more than 122 seconds.
      Not tainted 5.14.0-570.12.1.bringup7.el9.s390x #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u1664:6 state:D stack:0     pid:1514  tgid:1514  ppid:2      flags:0x00000000
Workqueue: mlx5_health0000:00:00.0 mlx5_fw_fatal_reporter_err_work [mlx5_core]
Call Trace:
 [<000000065256f030>] __schedule+0x2a0/0x590
 [<000000065256f356>] schedule+0x36/0xe0
 [<0000000652172e28>] pci_wait_cfg+0x80/0xe8
 [<0000000652172f94>] pci_cfg_access_lock+0x74/0x88
 [<000003ff800916b6>] mlx5_vsc_gw_lock+0x36/0x178 [mlx5_core]
 [<000003ff80098824>] mlx5_crdump_collect+0x34/0x1c8 [mlx5_core]
 [<000003ff80074b62>] mlx5_fw_fatal_reporter_dump+0x6a/0xe8 [mlx5_core]
 [<0000000652512242>] devlink_health_do_dump.part.0+0x82/0x168
 [<0000000652513212>] devlink_health_report+0x19a/0x230
 [<000003ff80075a12>] mlx5_fw_fatal_reporter_err_work+0xba/0x1b0 [mlx5_core]

No kernel log of the exact same error with an upstream kernel is
available - but the very same deadlock situation can be constructed there,
too:

- task: kmcheck
  mlx5_unload_one() tries to acquire devlink lock while the PCI error
  recovery code has set pdev->block_cfg_access by way of
  pci_cfg_access_lock()
- task: kworker
  mlx5_crdump_collect() tries to set block_cfg_access through
  pci_cfg_access_lock() while devlink_health_report() had acquired
  the devlink lock.

A similar deadlock situation can be reproduced by requesting a
crdump with
  > devlink health dump show pci/<BDF> reporter fw_fatal

while PCI error recovery is executed on the same <BDF> physical function
by mlx5_core's pci_error_handlers. On s390 this can be injected with
  > zpcictl --reset-fw <BDF>

Tests with this patch failed to reproduce that second deadlock situation,
the devlink command is rejected with "kernel answers: Permission denied" -
and we get a kernel log message of:

mlx5_core 1ed0:00:00.1: mlx5_crdump_collect:50:(pid 254382): crdump: failed to lock vsc gw err -5

because the config read of VSC_SEMAPHORE is rejected by the underlying
hardware.

Two prior attempts to address this issue have been discussed and
ultimately rejected [see link], with the primary argument that s390's
implementation of PCI error recovery is imposing restrictions that
neither powerpc's EEH nor PCI AER handling need. Tests show that PCI
error recovery on s390 is running to completion even without blocking
access to PCI config space.

Link: https://lore.kernel.org/all/20251007144826.2825134-1-gbayer@linux.ibm.com/
Cc: stable@vger.kernel.org
Fixes: 4cdf2f4e24ff ("s390/pci: implement minimal PCI error recovery")
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index b95376041501..27db1e72c623 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -188,7 +188,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 	 * is unbound or probed and that userspace can't access its
 	 * configuration space while we perform recovery.
 	 */
-	pci_dev_lock(pdev);
+	device_lock(&pdev->dev);
 	if (pdev->error_state == pci_channel_io_perm_failure) {
 		ers_res = PCI_ERS_RESULT_DISCONNECT;
 		goto out_unlock;
@@ -257,7 +257,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 		driver->err_handler->resume(pdev);
 	pci_uevent_ers(pdev, PCI_ERS_RESULT_RECOVERED);
 out_unlock:
-	pci_dev_unlock(pdev);
+	device_unlock(&pdev->dev);
 	zpci_report_status(zdev, "recovery", status_str);
 
 	return ers_res;


