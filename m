Return-Path: <stable+bounces-124680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3C8A658AC
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74AC53B3798
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D39204F9B;
	Mon, 17 Mar 2025 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aALjvT7x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF9C204F8B;
	Mon, 17 Mar 2025 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229521; cv=none; b=Zwo7fLzSDHycrKSdfxWDX1Ljvo8V2JFfk8JFdViKdn1xRGCDoDdQOHhhDSDtr3Zh0qcQLoTUacauTZqCicnnyhMFVSuOjV2XC1ILWfU2CZbiJ8WoEcjCEvHivuk/O2meL1NTa2aNnzIZ/a1BFE7OfRTFEwcGJHal/TKNFHIDzaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229521; c=relaxed/simple;
	bh=tnhdK0xYIocAbOtECMDELU7SthnXQZnPfJRb5X472nQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EmMBi9Bjut60OclyBpZJ8Xrqi0RvW4cacZvyYXKzP07uJ93F3oWDZGtXRrykKUtRhKYgTg8Xo7r6G0GjR7TXJX2IDfNAlZO1CBlvyNC2lH8N4LaYF/cPpYgMsmLDoXVoesfCIjKOrl+T1DGYXxjyJIF+CfGjkmxJkO08w/Rg3l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aALjvT7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AB1C4CEF0;
	Mon, 17 Mar 2025 16:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229521;
	bh=tnhdK0xYIocAbOtECMDELU7SthnXQZnPfJRb5X472nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aALjvT7xYsHeOldOoLMYmBaX06zO09JaNV9HXUCAD5PE5KF0vKDy5RCRpuuLWPg1M
	 q5VV9bIn7F/GHE7hcM8M3jS4HfCgVavPOdkVhyuoqKhVl1xP8J9xkoZC+r+DdDv0gj
	 NIPwIEw++HBF0TmqMV5j5YxIUbA5H5HGvNTl60Ddvw9xMlYQ7Q7tlZbuSD2QjX7yoF
	 w+MiJPVh+45AuFNoNQtymhXEE9Kzgec0vAa5rjDnTHAC4IARSVGSnTv2DVgm8IjmXI
	 hKz7d8BNnKVXB/JK1RW6hE7L6cHGwzw3I55BqCWWzO4EOT/oBXGvEdSQHGeynPiIfN
	 GBgcBBnb0zrNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 09/13] nvme-pci: fix stuck reset on concurrent DPC and HP
Date: Mon, 17 Mar 2025 12:38:14 -0400
Message-Id: <20250317163818.1893102-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163818.1893102-1-sashal@kernel.org>
References: <20250317163818.1893102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.19
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
index e1329d4974fd6..6b37ef1eaa893 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1412,9 +1412,20 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	struct nvme_dev *dev = nvmeq->dev;
 	struct request *abort_req;
 	struct nvme_command cmd = { };
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
 	u8 opcode;
 
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
 
@@ -1422,7 +1433,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	 * the recovery mechanism will surely fail.
 	 */
 	mb();
-	if (pci_channel_offline(to_pci_dev(dev->dev)))
+	if (pci_channel_offline(pdev))
 		return BLK_EH_RESET_TIMER;
 
 	/*
-- 
2.39.5


