Return-Path: <stable+bounces-154886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72BAAE1316
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6EB4A24F6
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2E1212D8A;
	Fri, 20 Jun 2025 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MfdF0IMS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE631EFF92
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750397986; cv=none; b=bT72ongPDK3F6XBjDZjOlm64MnAURF6RfpThpcdkMJKcHUkDl8cZcHgYwAQV7q6Q8J2izZ9Ya5/Iv17xRk3z6M+8Gvr6QNpSXxk4HPDG07dVLMxwNuU+dNvSJFXVhlUc0RQqF6CnpZA5SkOVt9vCI4gitsg33ta0ZdzPGlL7HEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750397986; c=relaxed/simple;
	bh=bg9wdni+iP4ZZOtuuKSilgzpOHHDI0qBCYk5A81q7q8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H3lJC1S9sLLzMq5aqB9n4cQ3adWHVyO1y/B5jkykSf7wh6zj1X53f24zIW2ZMtbTOr4//A7YCEdtF567QvuzHrZXiPzhlJ3xMkw0d0+vkYEhDkwiUa184eKK4gnQAoBydWZnseCkYDMnNGfG8u2FTaL1f45OX88VXNvWvtgrHW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MfdF0IMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847F7C4CEE3;
	Fri, 20 Jun 2025 05:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750397986;
	bh=bg9wdni+iP4ZZOtuuKSilgzpOHHDI0qBCYk5A81q7q8=;
	h=Subject:To:Cc:From:Date:From;
	b=MfdF0IMSijdqEl752/WH2W8/61QfrFq/cHLYO8ZbQod3Ow1JYdcBJZzRy8dtZn2Hr
	 Mkm9Ulf/cLOUbiMAf/E2lKBzubtNaXn7LxGGh8OhnLfus6tu0zS7D0/GUCsHtcWtSS
	 wYEJr1AiTV/c7ZhtGyyoLS3ZQUUKovr+qZNTzfO0=
Subject: FAILED: patch "[PATCH] crypto: qat - add shutdown handler to qat_c62x" failed to apply to 5.4-stable tree
To: giovanni.cabiddu@intel.com,ahsan.atta@intel.com,andriy.shevchenko@linux.intel.com,herbert@gondor.apana.org.au,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:39:30 +0200
Message-ID: <2025062030-rely-movable-fb97@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x a9a6e9279b2998e2610c70b0dfc80a234f97c76c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062030-rely-movable-fb97@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


