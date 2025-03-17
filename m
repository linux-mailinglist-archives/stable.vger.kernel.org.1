Return-Path: <stable+bounces-124690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27893A658C9
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F228D88256F
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C709920766A;
	Mon, 17 Mar 2025 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBTV4M/a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8547C1C8607;
	Mon, 17 Mar 2025 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229556; cv=none; b=D4xlgtr0z+PrPTl5EeUmRKuz0KrYhq8aQgK/56ond7MhV00Z4PjvLUUphE7ncL0Pk+StuOF/NXlWoTMPpbzFp9fjvb5Cx2dfHVF5RtVOMucf2/SbHTxKP0uRc+RBEgEvlZ0zYzMD7HT5N/4CqEdo2ltWTz4mAjzkNa1NJ95THFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229556; c=relaxed/simple;
	bh=/kpzgGcALURdACupa9CkgptBg02OzJ/kPFAr8jUIFgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UJkMI3v1y8V0RjiiFv9uP5aqR5qPi54TvTYKBYK1B4o9xfaJlBsH7BnLW+/S+JG9yDlGN2YXayCrmMDVceQ70cj2Qq46xKbehMwHkSV45x1oAFXpsnqcG9tdtPcfSXKwFCsZ2Jl2TWdEysgHQ2//pH1T5M7m09Qv94GH2s72pFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBTV4M/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F06C4CEEC;
	Mon, 17 Mar 2025 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229556;
	bh=/kpzgGcALURdACupa9CkgptBg02OzJ/kPFAr8jUIFgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hBTV4M/avd+ARpjnFIQjWQ7vcqVcwniZMvUuZLX9eGsRaQ8A1Jxr2KY0O6ymak6cC
	 +4irIGygN3CiLAmM3D7Igoa0XdaWG9HhRFj6tQZAX7mVcV+Sigx2x0dwriXCC2sVNv
	 H4hLZfFic9otYWpa+DltPtjd/Fqd4YybhIElp/GdFSSPoPbERDeaDX4PiKwWdOb64c
	 WvCRT2vZSFtaI8syi1KxSsaPHL+GthoWWZ6Ijh2yDHrgwR9DdCBdYet84gcK+FBPKX
	 R99RiBuwLxJsdF3AOaT9I4PyOFJo2Iwianl4x9V7oeBzSnvZih8uzeHrzRzXhbh06n
	 vXNyjfgr7pVfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 6/8] nvme-pci: fix stuck reset on concurrent DPC and HP
Date: Mon, 17 Mar 2025 12:39:00 -0400
Message-Id: <20250317163902.1893378-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163902.1893378-1-sashal@kernel.org>
References: <20250317163902.1893378-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.83
Content-Transfer-Encoding: 8bit

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 3f674e7b670b7b7d9261935820e4eba3c059f835 ]

The PCIe error handling has the nvme driver quiesce the device, attempt
to restart it, then wait for that restart to complete.

A PCIe DPC event also toggles the PCIe link. If the slot doesn't have
out-of-band presence detection, this will trigger a pciehp
re-enumeration.

The error handling that calls nvme_error_resume is holding the device
lock while this happens. This lock blocks pciehp's request to disconnect
the driver from proceeding.

Meanwhile the nvme's reset can't make forward progress because its
device isn't there anymore with outstanding IO, and the timeout handler
won't do anything to fix it because the device is undergoing error
handling.

End result: deadlocked.

Fix this by having the timeout handler short cut the disabling for a
disconnected PCIe device. The downside is that we're relying on an IO
timeout to clean up this mess, which could be a minute by default.

Tested-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b1310e69d07da..e74a22c452ce7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1282,8 +1282,19 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	struct nvme_dev *dev = nvmeq->dev;
 	struct request *abort_req;
 	struct nvme_command cmd = { };
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
+	/*
+	 * Shutdown the device immediately if we see it is disconnected. This
+	 * unblocks PCIe error handling if the nvme driver is waiting in
+	 * error_resume for a device that has been removed. We can't unbind the
+	 * driver while the driver's error callback is waiting to complete, so
+	 * we're relying on a timeout to break that deadlock if a removal
+	 * occurs while reset work is running.
+	 */
+	if (pci_dev_is_disconnected(pdev))
+		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	if (nvme_state_terminal(&dev->ctrl))
 		goto disable;
 
@@ -1291,7 +1302,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	 * the recovery mechanism will surely fail.
 	 */
 	mb();
-	if (pci_channel_offline(to_pci_dev(dev->dev)))
+	if (pci_channel_offline(pdev))
 		return BLK_EH_RESET_TIMER;
 
 	/*
-- 
2.39.5


