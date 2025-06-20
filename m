Return-Path: <stable+bounces-154925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36631AE1357
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D7819E1A83
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E195421FF24;
	Fri, 20 Jun 2025 05:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZAkhn3wP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AA821D5B4
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398491; cv=none; b=o4wHOPh2ZS/phpO4nibjqY7wyMTh+S/Gwuy5IQUoC65SwTsl2wHYBf8Nk5B79PkwViewHRnFRZi4HAJZoxqsFy9ui7hzL5JxbMxAdyBc1ANdzZy/zZ/5PeXjiemwvvAJVXjJ/QYlAkKWo+YmSrhs0lgGkbl9vdXg66ewcv2F/0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398491; c=relaxed/simple;
	bh=JfERYET/OpcPxYZMSuKnN+UcqSpQX3vrXFsQk56rYZM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FiekzO6kVx/WaUlk/SL79l4+zs9+w+Ldv3vSC0Dnd1YTCMuUKkANlVSgQY+ej6PZccJ9tjZJ7SqiwBpMT5wC758BDZ5XM79IzhTHm7k4mGDagK/aDzOpytnFy9y/bhlpLOk2O4ImwC8ThjDPPJWAVuTMCeX7YrFeZU91RjCxagw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZAkhn3wP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319A5C4CEE3;
	Fri, 20 Jun 2025 05:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750398491;
	bh=JfERYET/OpcPxYZMSuKnN+UcqSpQX3vrXFsQk56rYZM=;
	h=Subject:To:Cc:From:Date:From;
	b=ZAkhn3wPXRNUYvDWJsb11f86H2OR7rHzpd3FpftcpFmDKmZNiIL0AvXH6lhuh7j+E
	 nETyRe6jrklPUdIfJPrJPTSBFEsu+hSXHJ5+7pBvJa7v9K056hS1whzEb5/iTuSAhn
	 jVTZFC8dZcM1cupnvTVTdei0E12W1E4FlqM0ii6U=
Subject: FAILED: patch "[PATCH] crypto: qat - add shutdown handler to qat_c62x" failed to apply to 6.6-stable tree
To: giovanni.cabiddu@intel.com,ahsan.atta@intel.com,andriy.shevchenko@linux.intel.com,herbert@gondor.apana.org.au,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:46:54 +0200
Message-ID: <2025062054-antiques-mangy-118b@gregkh>
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
git cherry-pick -x a9a6e9279b2998e2610c70b0dfc80a234f97c76c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062054-antiques-mangy-118b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a9a6e9279b2998e2610c70b0dfc80a234f97c76c Mon Sep 17 00:00:00 2001
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Date: Wed, 26 Mar 2025 15:59:51 +0000
Subject: [PATCH] crypto: qat - add shutdown handler to qat_c62x

During a warm reset via kexec, the system bypasses the driver removal
sequence, meaning that the remove() callback is not invoked.
If a QAT device is not shutdown properly, the device driver will fail to
load in a newly rebooted kernel.

This might result in output like the following after the kexec reboot:

    QAT: AE0 is inactive!!
    QAT: failed to get device out of reset
    c6xx 0000:3f:00.0: qat_hal_clr_reset error
    c6xx 0000:3f:00.0: Failed to init the AEs
    c6xx 0000:3f:00.0: Failed to initialise Acceleration Engine
    c6xx 0000:3f:00.0: Resetting device qat_dev0
    c6xx 0000:3f:00.0: probe with driver c6xx failed with error -14

Implement the shutdown() handler that hooks into the reboot notifier
list. This brings down the QAT device and ensures it is shut down
properly.

Cc: <stable@vger.kernel.org>
Fixes: a6dabee6c8ba ("crypto: qat - add support for c62x accel type")
Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/intel/qat/qat_c62x/adf_drv.c b/drivers/crypto/intel/qat/qat_c62x/adf_drv.c
index 0bac717e88d9..23ccb72b6ea2 100644
--- a/drivers/crypto/intel/qat/qat_c62x/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_c62x/adf_drv.c
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
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_QAT_C62X) },
 	{ }
@@ -220,6 +227,7 @@ static struct pci_driver adf_driver = {
 	.name = ADF_C62X_DEVICE_NAME,
 	.probe = adf_probe,
 	.remove = adf_remove,
+	.shutdown = adf_shutdown,
 	.sriov_configure = adf_sriov_configure,
 	.err_handler = &adf_err_handler,
 };


