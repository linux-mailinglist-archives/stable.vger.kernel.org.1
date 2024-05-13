Return-Path: <stable+bounces-43732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEC88C4459
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36E61F2158D
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A77D57CBD;
	Mon, 13 May 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ia0NMXud"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BACC63C1
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614532; cv=none; b=rgh8cyhTYB8NgrFjcnqh8hKb5/Y0s8fg7IhBXAfKM+AD817OC3rr/dfUh8R3xQa6G+hwUjDjsFPEs5g5nH+MjfPYmEWgH89DkPU/R/uRM2i8yB/s/JEc2EC359C36WH1HAIllepcFrZeuCDrAwbnH6O6vwIncWgUNa+cTs9MFGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614532; c=relaxed/simple;
	bh=9rR/T7tw1Am1sNPxMBieppqkD4LTESVqHFTwF5Uw4Y0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OWsot0v40Q++3dc37tn9V8vjHp+dfUNDEDo+RIFsJLjQwSsKcldRCnAOnUqRYTnxL8c003iEawWyECBys1bdGflVBHd7x7rpymqcwzdCay/9mlDaLHC+n5LBhOqtqU5Wrqq7U9ge2gwX88/Ka2mAOgOB19vFOv5YRpuvnQHjaas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ia0NMXud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E19C113CC;
	Mon, 13 May 2024 15:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715614532;
	bh=9rR/T7tw1Am1sNPxMBieppqkD4LTESVqHFTwF5Uw4Y0=;
	h=Subject:To:Cc:From:Date:From;
	b=Ia0NMXudB7bDrNqBjkYJdWR22SNntaiEvaFNHvvhS5rnI4kfFxWg+PkLW58FfuECs
	 KCK5C2KTt7Ol5NX/vzPV0250s//UYbK2MiUHt82IT0fiS0vmyvCefmmT6d12s3/VIx
	 q14RS84YBkGBHoXtoy7eS2Wj73NH5fSnEc4/1ApU=
Subject: FAILED: patch "[PATCH] Bluetooth: qca: fix firmware check error path" failed to apply to 5.4-stable tree
To: johan+linaro@kernel.org,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:35:21 +0200
Message-ID: <2024051321-festival-sprint-9288@gregkh>
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
git cherry-pick -x 40d442f969fb1e871da6fca73d3f8aef1f888558
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051321-festival-sprint-9288@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

40d442f969fb ("Bluetooth: qca: fix firmware check error path")
2e4edfa1e2bd ("Bluetooth: qca: add missing firmware sanity checks")
ecf6b2d95666 ("Bluetooth: btqca: Add support for firmware image with mbn type for WCN6750")
d8f97da1b92d ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6750")
b43ca511178e ("Bluetooth: btqca: Don't modify firmware contents in-place")
c1a74160eaf1 ("Bluetooth: hci_qca: Add device_may_wakeup support")
eaf19b0c47d1 ("Bluetooth: btqca: Enable MSFT extension for Qualcomm WCN399x")
c0187b0bd3e9 ("Bluetooth: btqca: Add support to read FW build version for WCN3991 BTSoC")
99719449a4a6 ("Bluetooth: hci_qca: resolve various warnings")
054ec5e94a46 ("Bluetooth: hci_qca: Remove duplicate power off in proto close")
590deccf4c06 ("Bluetooth: hci_qca: Disable SoC debug logging for WCN3991")
37aee136f8c4 ("Bluetooth: hci_qca: allow max-speed to be set for QCA9377 devices")
e5d6468fe9d8 ("Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA6390")
77131dfec6af ("Bluetooth: hci_qca: Replace devm_gpiod_get() with devm_gpiod_get_optional()")
8a208b24d770 ("Bluetooth: hci_qca: Make bt_en and susclk not mandatory for QCA Rome")
b63882549b2b ("Bluetooth: btqca: Fix the NVM baudrate tag offcet for wcn3991")
4f9ed5bd63dc ("Bluetooth: hci_qca: Not send vendor pre-shutdown command for QCA Rome")
66cb70513564 ("Bluetooth: hci_qca: Enable clocks required for BT SOC")
ae563183b647 ("Bluetooth: hci_qca: Enable power off/on support during hci down/up for QCA Rome")
5559904ccc08 ("Bluetooth: hci_qca: Add QCA Rome power off support to the qca_power_shutdown()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 40d442f969fb1e871da6fca73d3f8aef1f888558 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 1 May 2024 08:37:40 +0200
Subject: [PATCH] Bluetooth: qca: fix firmware check error path

A recent commit fixed the code that parses the firmware files before
downloading them to the controller but introduced a memory leak in case
the sanity checks ever fail.

Make sure to free the firmware buffer before returning on errors.

Fixes: f905ae0be4b7 ("Bluetooth: qca: add missing firmware sanity checks")
Cc: stable@vger.kernel.org      # 4.19
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 8d8a664620a3..638074992c82 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -605,7 +605,7 @@ static int qca_download_firmware(struct hci_dev *hdev,
 
 	ret = qca_tlv_check_data(hdev, config, data, size, soc_type);
 	if (ret)
-		return ret;
+		goto out;
 
 	segment = data;
 	remain = size;


