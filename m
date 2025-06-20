Return-Path: <stable+bounces-154924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5938AE1358
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FA016D13E
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B593D218591;
	Fri, 20 Jun 2025 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r7E1yJjV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EAF2192FB
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398488; cv=none; b=VTbNge1fkZFBqWf7JRp3yTkctUFnDInM3UDPsWSP2+yflH+iw2XfH9CmaoT0U4KPserCAMcxG6/Wo+TxyumWDjAdM8IEfwUhtTU6tN6U5iuMm17TiVOu6fekJBW5Yv/xpwEaXgXPjSD7PA0kT+q4TF9Ygr9eO2IA8u77Hk6sjIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398488; c=relaxed/simple;
	bh=r7gQ85JYsJuvUGuqFg9cO6TJC3ow1EmoPnb0WBS34+M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B+O8C4wsKEva9os/LA8RoUBR2sGtyC5Urh9dwRyvConsfATzALBinB7S465zEF04qgy39EWHBygHogyN30Chs2Jul9lje6LglFxa5HWgn5chrdz0VG2dW0CIHThcaODY5Qep9hDl90u0yk2mmwG/tdrKDDia8oH/wT8YAaaM6xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r7E1yJjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07305C4CEEE;
	Fri, 20 Jun 2025 05:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750398488;
	bh=r7gQ85JYsJuvUGuqFg9cO6TJC3ow1EmoPnb0WBS34+M=;
	h=Subject:To:Cc:From:Date:From;
	b=r7E1yJjVpVSt9EKuPSIP8du/kPVETT+CRtenxwRz+yB095aZ73ALauAThTc2AB3M9
	 gWwi1FtUfmxA+5oSYmSdiJU/sCTctBB5ViEEguO521LZFPXb81X+WyjqLQYEFqh+R+
	 wjg4sqDF3svd7zXxcLzVheiIZ3Rp76izPA++gYj8=
Subject: FAILED: patch "[PATCH] crypto: qat - add shutdown handler to qat_4xxx" failed to apply to 6.6-stable tree
To: giovanni.cabiddu@intel.com,ahsan.atta@intel.com,andriy.shevchenko@linux.intel.com,herbert@gondor.apana.org.au,rwright@hpe.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:46:41 +0200
Message-ID: <2025062041-tarnish-puma-e164@gregkh>
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
git cherry-pick -x 845bc952024dbf482c7434daeac66f764642d52d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062041-tarnish-puma-e164@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


