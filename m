Return-Path: <stable+bounces-154888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34D6AE1318
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE154A253A
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C23C207A20;
	Fri, 20 Jun 2025 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ua/cViB5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395C81EFF92
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750397994; cv=none; b=mwXJnby493gGNlUEA8Nl0CY5ZPqqlC8vjNUpVW/PMsG2bavgioHzeREC3tHT3u0ic/x06xPtxpeYYXY/y83fDAGcQNRoYFYIwvwnZmYVgRnoXRtEKgotL+Y/7eTUZ7Z2Ui4O5k/7l8ZHaCwh6qFpK7akdz1nwgYV9Nd3DdRXtCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750397994; c=relaxed/simple;
	bh=ZkoRassFLgrp06JOS4hqsQAMkQsK6X1Lhp4gu00nFqY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mFdZXkHT5fQr7RKa/yvgGAVgnAwxtkctXpBK6iNK3W+0narqLe5qB8c9WBGXq6MakDj3tTDbPlXSfZ0jSgVDAALs33goUD5d3PJPn8OGFlYASNEwTob2vctVn+qO5GaPqBYqc1nsn9doFB8DvHpKFn/yjtxepw/yaX4ER/69Sik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ua/cViB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC9AC4CEE3;
	Fri, 20 Jun 2025 05:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750397994;
	bh=ZkoRassFLgrp06JOS4hqsQAMkQsK6X1Lhp4gu00nFqY=;
	h=Subject:To:Cc:From:Date:From;
	b=Ua/cViB54745vKn6hPkxM8oz3CJjdetyLB+jU1E6Kuf3a5NDYylp4dskY/sfZ18WK
	 UmSSs5m6n+kOlNtQeasFBZy7qnKHxjff1BFtwKWZWwqpWGBeTzpsFN86owZSuxEfvu
	 ooNHI9T4kN+YSVKeupG6UZx0Xv4rrGa8Ltt63rAk=
Subject: FAILED: patch "[PATCH] crypto: qat - add shutdown handler to qat_dh895xcc" failed to apply to 5.10-stable tree
To: giovanni.cabiddu@intel.com,ahsan.atta@intel.com,andriy.shevchenko@linux.intel.com,herbert@gondor.apana.org.au,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:39:40 +0200
Message-ID: <2025062040-preaching-lance-8408@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2c4e8b228733bfbcaf49408fdf94d220f6eb78fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062040-preaching-lance-8408@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2c4e8b228733bfbcaf49408fdf94d220f6eb78fc Mon Sep 17 00:00:00 2001
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Date: Wed, 26 Mar 2025 15:59:49 +0000
Subject: [PATCH] crypto: qat - add shutdown handler to qat_dh895xcc

During a warm reset via kexec, the system bypasses the driver removal
sequence, meaning that the remove() callback is not invoked.
If a QAT device is not shutdown properly, the device driver will fail to
load in a newly rebooted kernel.

This might result in output like the following after the kexec reboot:

    QAT: AE0 is inactive!!
    QAT: failed to get device out of reset
    dh895xcc 0000:3f:00.0: qat_hal_clr_reset error
    dh895xcc 0000:3f:00.0: Failed to init the AEs
    dh895xcc 0000:3f:00.0: Failed to initialise Acceleration Engine
    dh895xcc 0000:3f:00.0: Resetting device qat_dev0
    dh895xcc 0000:3f:00.0: probe with driver dh895xcc failed with error -14

Implement the shutdown() handler that hooks into the reboot notifier
list. This brings down the QAT device and ensures it is shut down
properly.

Cc: <stable@vger.kernel.org>
Fixes: 7afa232e76ce ("crypto: qat - Intel(R) QAT DH895xcc accelerator")
Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c b/drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c
index 730147404ceb..b59e0cc49e52 100644
--- a/drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c
@@ -209,6 +209,13 @@ static void adf_remove(struct pci_dev *pdev)
 	kfree(accel_dev);
 }
 
+static void adf_shutdown(struct pci_dev *pdev)
+{
+	struct adf_accel_dev *accel_dev = adf_devmgr_pci_to_accel_dev(pdev);
+
+	adf_dev_down(accel_dev);
+}
+
 static const struct pci_device_id adf_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_QAT_DH895XCC) },
 	{ }
@@ -220,6 +227,7 @@ static struct pci_driver adf_driver = {
 	.name = ADF_DH895XCC_DEVICE_NAME,
 	.probe = adf_probe,
 	.remove = adf_remove,
+	.shutdown = adf_shutdown,
 	.sriov_configure = adf_sriov_configure,
 	.err_handler = &adf_err_handler,
 };


