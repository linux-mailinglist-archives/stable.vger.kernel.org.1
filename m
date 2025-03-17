Return-Path: <stable+bounces-124666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5978DA6587D
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922D21887C6F
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253C31DE8A7;
	Mon, 17 Mar 2025 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQMADMIR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60221DE3C3;
	Mon, 17 Mar 2025 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229471; cv=none; b=K1j4PiOSvtjKnD+jAxZcWdaGfXPSp0jtAFOU1eQUhtUYycQMbEzqkXwsL0ogfHbmQvlTQC9umBfNwIiBvYDTzBedT8a5lkbdtRqHvcFwuCenuIS0w7yl5+J6NPmBrBPKNj7Rix3COGvrYa805S/3LCnpNrowUZ2Vx7atP1eLyuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229471; c=relaxed/simple;
	bh=BkW0SLrAWLKbSYBIq6N8mJlIN9WKXlbffIL1rr/w8Q8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YC8hCZp1sl67ouTpyD8RgPlgFrTKd/AQp38+7li049+RxDC0ILjLShXsdo+TPdKInzPEdheNt9G0HLMp7/Kq6gDOqd93WuqKWLtuJ4QmxiJGW2bH7XcIStqBArF4y5b79mB/0DzhI9WpLR8j18wQANA0KbpgxC6YZU6s4IZhmHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQMADMIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A0DC4CEE3;
	Mon, 17 Mar 2025 16:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229471;
	bh=BkW0SLrAWLKbSYBIq6N8mJlIN9WKXlbffIL1rr/w8Q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQMADMIRKDRnGL8q96SqVf+4eaUqlZa2z8KPfOebvgLWFlvzKuRE6L5EuCDixiIZb
	 EbAAheTF8eFUShv720RVCdQ3GdhMuJehEHeOLd5Y3ojD0saaWT9MCipyye/I3K2QO8
	 tVCK0wPoHtudYCKKXiHo12wq2lKPIuihOOqjnQeNmJDV0UGPTExhnUsXSieTP/EAZc
	 p6K+TiSBzA2wMD/M07QBDhWSPapD5E/TwBkSlYBaaSNDBakQJ1IQlodM4o4fSjNHMJ
	 q3q0sRxiH4Mh3qAQ5mAzGuHRu9VtFHg5YiIp9clWTpfL9KEmdltpC4CfGJEb2uI6pa
	 5HDTXi7hpGLOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 11/16] nvme-pci: fix stuck reset on concurrent DPC and HP
Date: Mon, 17 Mar 2025 12:37:20 -0400
Message-Id: <20250317163725.1892824-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163725.1892824-1-sashal@kernel.org>
References: <20250317163725.1892824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.7
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
index 99c2983dbe6c8..ed62932be633f 100644
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


