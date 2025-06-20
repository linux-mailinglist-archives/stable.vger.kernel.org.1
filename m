Return-Path: <stable+bounces-154879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD25AE1308
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FDD5A0CBA
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6D71FBEB9;
	Fri, 20 Jun 2025 05:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a0bCWbo5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574FF1EB5FE
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750397934; cv=none; b=rLbXgRfXzx+on5y5NsHZZ8qPVyUNqxKDs5ykAOnH+XCYi+fCR052K7eXmHVhjmt5pDuWtOPwNfWpRCmxteyIUzB1t2dgHyf6HrGo2we7luS0osZivIhjKwM7jQmjOAcYV7uV9iT2a0CJSBAv/4uTGr7dtpquQMON5pLZuWA7kNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750397934; c=relaxed/simple;
	bh=iTWFYXFIuxXJKKJvCQkFT7ni/3J0yCblY+dzuJv3fvc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tvr9z7ED15RAyN+sxZlW0M7N/OL9kwT6QqDi+wWl8oOMb2TZvBDdgfez/+5Qi0RYaTC7RqmDGn0wrUM+iLlc53ku49rtHMU9hsujSuIojKsUY1ibwzvlIXdFf9YkC+Mf1zWyfBLVHbviLYsxSrxNo2lrjz2wLIizztR5XiMf1QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a0bCWbo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66970C4CEE3;
	Fri, 20 Jun 2025 05:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750397933;
	bh=iTWFYXFIuxXJKKJvCQkFT7ni/3J0yCblY+dzuJv3fvc=;
	h=Subject:To:Cc:From:Date:From;
	b=a0bCWbo5f9KTu9rUXAOKEeUl7Y6XPBoM8LIAZMw8B6K9lxVVjTwJqaWpTMHmeI9ce
	 iQPwJjtpOjzimKd36dT0HLpKJkTIQuVe5AWA1y7hZpX8ScS/uCxRiS/QF7d1geFdwD
	 7KAIbK/CYn6vxHIpYQwan6rOEbUmch0a3c1hOURs=
Subject: FAILED: patch "[PATCH] crypto: qat - add shutdown handler to qat_c3xxx" failed to apply to 5.10-stable tree
To: giovanni.cabiddu@intel.com,ahsan.atta@intel.com,andriy.shevchenko@linux.intel.com,herbert@gondor.apana.org.au,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:38:40 +0200
Message-ID: <2025062040-setback-bulgur-2550@gregkh>
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
git cherry-pick -x 71e0cc1eab584d6f95526a5e8c69ec666ca33e1b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062040-setback-bulgur-2550@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 71e0cc1eab584d6f95526a5e8c69ec666ca33e1b Mon Sep 17 00:00:00 2001
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Date: Wed, 26 Mar 2025 15:59:53 +0000
Subject: [PATCH] crypto: qat - add shutdown handler to qat_c3xxx

During a warm reset via kexec, the system bypasses the driver removal
sequence, meaning that the remove() callback is not invoked.
If a QAT device is not shutdown properly, the device driver will fail to
load in a newly rebooted kernel.

This might result in output like the following after the kexec reboot:

    QAT: AE0 is inactive!!
    QAT: failed to get device out of reset
    c3xxx 0000:3f:00.0: qat_hal_clr_reset error
    c3xxx 0000:3f:00.0: Failed to init the AEs
    c3xxx 0000:3f:00.0: Failed to initialise Acceleration Engine
    c3xxx 0000:3f:00.0: Resetting device qat_dev0
    c3xxx 0000:3f:00.0: probe with driver c3xxx failed with error -14

Implement the shutdown() handler that hooks into the reboot notifier
list. This brings down the QAT device and ensures it is shut down
properly.

Cc: <stable@vger.kernel.org>
Fixes: 890c55f4dc0e ("crypto: qat - add support for c3xxx accel type")
Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c b/drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c
index 260f34d0d541..bceb5dd8b148 100644
--- a/drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c
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
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_QAT_C3XXX) },
 	{ }
@@ -220,6 +227,7 @@ static struct pci_driver adf_driver = {
 	.name = ADF_C3XXX_DEVICE_NAME,
 	.probe = adf_probe,
 	.remove = adf_remove,
+	.shutdown = adf_shutdown,
 	.sriov_configure = adf_sriov_configure,
 	.err_handler = &adf_err_handler,
 };


