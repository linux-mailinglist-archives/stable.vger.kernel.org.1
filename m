Return-Path: <stable+bounces-186086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B2BBE389C
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC8B188174B
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632FA334388;
	Thu, 16 Oct 2025 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nKQl8vXz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2239E30648D
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619464; cv=none; b=qaVyhwtCp9HqqleXymaMX/4ABPIu9Xmwf5xRc5aF10+TfXdWlM2CNrLbKqDYB4Yl2tBmNFTFzlvlJRRqL9M5vaDeg2XnhmbzSWWaxNqOBmjCVLTapCLXHb/nni1/AoaoTHpovP1AOW7Z8yEiI0tPO5YPRU11vgdFoMCOpvUGKZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619464; c=relaxed/simple;
	bh=kiWmTBxdx7kRoY26HLFDM41dVL+iiViQefFJ3dWalsc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j6NV9iSlnKmo29P2TAEQUkRxMBM+jyqMYOi7yTQ3hqkRj7kMGNY8cqvzkDDeteNEQ4bOQAx1/s8jI2XUh1gpAIhLeeF++erXm15shMeXMT7fkK5hQvuUyvl2almNQKinkEdY3hIlR4ksBOAcenpQHmHM5tXCjhz2OYPfFiif+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nKQl8vXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9240BC4CEF1;
	Thu, 16 Oct 2025 12:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619464;
	bh=kiWmTBxdx7kRoY26HLFDM41dVL+iiViQefFJ3dWalsc=;
	h=Subject:To:Cc:From:Date:From;
	b=nKQl8vXz6/Rxa2y/nGrtT14Kqdq79SL+5ck+LFpDMAOpsf1304yeNbRVxBWcnjZ6H
	 uRG+luFmldUd+8r+d5gHhv1YY+kfiMrLhB0nyBnb28uFcjMsAS9I+5ZtVQDctICoZ/
	 B7K53xXz81zqWiLWE4qmc/AOCPiFsgnCS6b50TNA=
Subject: FAILED: patch "[PATCH] PCI/sysfs: Ensure devices are powered for config reads" failed to apply to 5.10-stable tree
To: briannorris@google.com,bhelgaas@google.com,briannorris@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:57:36 +0200
Message-ID: <2025101636-tartar-brethren-067c@gregkh>
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
git cherry-pick -x 48991e4935078b05f80616c75d1ee2ea3ae18e58
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101636-tartar-brethren-067c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 48991e4935078b05f80616c75d1ee2ea3ae18e58 Mon Sep 17 00:00:00 2001
From: Brian Norris <briannorris@google.com>
Date: Wed, 24 Sep 2025 09:57:11 -0700
Subject: [PATCH] PCI/sysfs: Ensure devices are powered for config reads

The "max_link_width", "current_link_speed", "current_link_width",
"secondary_bus_number", and "subordinate_bus_number" sysfs files all access
config registers, but they don't check the runtime PM state. If the device
is in D3cold or a parent bridge is suspended, we may see -EINVAL, bogus
values, or worse, depending on implementation details.

Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
rest of the similar sysfs attributes.

Notably, "max_link_speed" does not access config registers; it returns a
cached value since d2bd39c0456b ("PCI: Store all PCIe Supported Link
Speeds").

Fixes: 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_speed/width, etc")
Signed-off-by: Brian Norris <briannorris@google.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250924095711.v2.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5eea14c1f7f5..2b231ef1dac9 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -201,8 +201,14 @@ static ssize_t max_link_width_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t ret;
 
-	return sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
+	/* We read PCI_EXP_LNKCAP, so we need the device to be accessible. */
+	pci_config_pm_runtime_get(pdev);
+	ret = sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
+	pci_config_pm_runtime_put(pdev);
+
+	return ret;
 }
 static DEVICE_ATTR_RO(max_link_width);
 
@@ -214,7 +220,10 @@ static ssize_t current_link_speed_show(struct device *dev,
 	int err;
 	enum pci_bus_speed speed;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -231,7 +240,10 @@ static ssize_t current_link_width_show(struct device *dev,
 	u16 linkstat;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -247,7 +259,10 @@ static ssize_t secondary_bus_number_show(struct device *dev,
 	u8 sec_bus;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pci_read_config_byte(pci_dev, PCI_SECONDARY_BUS, &sec_bus);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -263,7 +278,10 @@ static ssize_t subordinate_bus_number_show(struct device *dev,
 	u8 sub_bus;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pci_read_config_byte(pci_dev, PCI_SUBORDINATE_BUS, &sub_bus);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 


