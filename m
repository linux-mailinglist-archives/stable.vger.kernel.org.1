Return-Path: <stable+bounces-154882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D586AAE130E
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893534A224F
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7586A1EFF92;
	Fri, 20 Jun 2025 05:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jRikAArF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D31DED53
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750397965; cv=none; b=hn5ZZtctNzsJ9Mbigd/XiOxgThWhwBSs8sX102min/xujffDAWCYw+wZ5GRSk/n6ge6SsK2nSJ5jIA8P2FAS69NthPBg3bQMdv+FFv/sfrn5nlOiX4n4+bIc4OMJYnwAbeCGY3jrkNg9SHPRImkbqkMdtm2MXsSLee/dCXGUYWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750397965; c=relaxed/simple;
	bh=YN6gPE7KceDLCnDelGgtijG29cH4pOMZJfjO1h5t8xQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bDcI1G5gILAm+OXiV8a78yIrDWFdw0aw0NJBcBCAzbiv0r5lFcjgkxUzJ+GLK7vS0B8EYnAjAOfGwRy5qWYoWUPH6UzOkGw36eF0CbYdL956Bd5oGfPhYuNjnGFUDfWGxvvl+B3QYdE6I0yt5k1nVYXtg8y83KVPh7su2f/fxbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jRikAArF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE20C4CEE3;
	Fri, 20 Jun 2025 05:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750397964;
	bh=YN6gPE7KceDLCnDelGgtijG29cH4pOMZJfjO1h5t8xQ=;
	h=Subject:To:Cc:From:Date:From;
	b=jRikAArFhsUCKx7tvsxC3bPZ20Y+WxsTZMqpzvrcK6V2KVaB20i85KOmfUrffZmMJ
	 X1LVRKGEU481Q59f2RFw7FIvlYmQyPiUN26HbiDdwCIpr0Ulb6uU3dQqZofhE0wPWp
	 goah5toE9n5kGZ+wsPXtimENYiVjblMrmKXaZMTc=
Subject: FAILED: patch "[PATCH] crypto: qat - add shutdown handler to qat_4xxx" failed to apply to 5.15-stable tree
To: giovanni.cabiddu@intel.com,ahsan.atta@intel.com,andriy.shevchenko@linux.intel.com,herbert@gondor.apana.org.au,rwright@hpe.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:39:13 +0200
Message-ID: <2025062013-ferris-purr-2823@gregkh>
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
git cherry-pick -x 845bc952024dbf482c7434daeac66f764642d52d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062013-ferris-purr-2823@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 845bc952024dbf482c7434daeac66f764642d52d Mon Sep 17 00:00:00 2001
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Date: Wed, 26 Mar 2025 15:59:46 +0000
Subject: [PATCH] crypto: qat - add shutdown handler to qat_4xxx

During a warm reset via kexec, the system bypasses the driver removal
sequence, meaning that the remove() callback is not invoked.
If a QAT device is not shutdown properly, the device driver will fail to
load in a newly rebooted kernel.

This might result in output like the following after the kexec reboot:

    4xxx 0000:01:00.0: Failed to power up the device
    4xxx 0000:01:00.0: Failed to initialize device
    4xxx 0000:01:00.0: Resetting device qat_dev0
    4xxx 0000:01:00.0: probe with driver 4xxx failed with error -14

Implement the shutdown() handler that hooks into the reboot notifier
list. This brings down the QAT device and ensures it is shut down
properly.

Cc: <stable@vger.kernel.org>
Fixes: 8c8268166e83 ("crypto: qat - add qat_4xxx driver")
Link: https://lore.kernel.org/all/Z-DGQrhRj9niR9iZ@gondor.apana.org.au/
Reported-by: Randy Wright <rwright@hpe.com>
Closes: https://issues.redhat.com/browse/RHEL-84366
Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
index 5537a9991e4e..1ac415ef3c31 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
@@ -188,11 +188,19 @@ static void adf_remove(struct pci_dev *pdev)
 	adf_cleanup_accel(accel_dev);
 }
 
+static void adf_shutdown(struct pci_dev *pdev)
+{
+	struct adf_accel_dev *accel_dev = adf_devmgr_pci_to_accel_dev(pdev);
+
+	adf_dev_down(accel_dev);
+}
+
 static struct pci_driver adf_driver = {
 	.id_table = adf_pci_tbl,
 	.name = ADF_4XXX_DEVICE_NAME,
 	.probe = adf_probe,
 	.remove = adf_remove,
+	.shutdown = adf_shutdown,
 	.sriov_configure = adf_sriov_configure,
 	.err_handler = &adf_err_handler,
 };


