Return-Path: <stable+bounces-154926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05470AE135E
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5226F6A0935
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBD221C171;
	Fri, 20 Jun 2025 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YlHInhmt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FC921770B
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398496; cv=none; b=GAK23YbpuLvSX597PNoGgyz7JZqYZtDwNVnWQhVHl5Vjtu3FoSrkqrU0jHxW7blOmZvSoLgRJ0MJsHBae4sRjjJ4e8noDe1bhMwGDwwAnSOH7IGyT0p23ZzTtPMaTwgBr4lbKHfAhVi21QPZiRvV6br+PlsPE0/kAIa6KzBOBIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398496; c=relaxed/simple;
	bh=8DVwTjI8Jl89Yw4SgMayiHPEFD4+lwn2vai48bLbEqM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UTz7E5eCIEPzqGsESecGh8RO8UQ88ElpNbL3BKwu+GgH7hlT1T/ZYmKyWdohFu4/1m1VFY6dVefRNv2eMBTk4Dg60Y1pxWnhPwAaynljavciIzgQcROgO1YfCTqRmiT5OntUYibww9IrCNjDU6jpe6FzHlTsE79myEU3NWSxSgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YlHInhmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0543EC4CEE3;
	Fri, 20 Jun 2025 05:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750398496;
	bh=8DVwTjI8Jl89Yw4SgMayiHPEFD4+lwn2vai48bLbEqM=;
	h=Subject:To:Cc:From:Date:From;
	b=YlHInhmtpa8QdaZF7LFPYddYqNAHJV7bXvZiDfmkSe08ctl4cB57u1RdjqRKWsjfX
	 +NoD3yoC8z4XlFnTMb/CP+evhmd3HiBU3ZxVyftaTs2iIlVj2KHmH0zqBnRW427NbN
	 LNe0wyQyqOr2tq9UxEU7y146/WDWRUa9r481HOBU=
Subject: FAILED: patch "[PATCH] crypto: qat - add shutdown handler to qat_dh895xcc" failed to apply to 6.6-stable tree
To: giovanni.cabiddu@intel.com,ahsan.atta@intel.com,andriy.shevchenko@linux.intel.com,herbert@gondor.apana.org.au,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:47:05 +0200
Message-ID: <2025062004-setting-ruined-8212@gregkh>
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
git cherry-pick -x 2c4e8b228733bfbcaf49408fdf94d220f6eb78fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062004-setting-ruined-8212@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


