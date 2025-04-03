Return-Path: <stable+bounces-127821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69249A7AC00
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3310188F097
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB5526982D;
	Thu,  3 Apr 2025 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXSZ4W7T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9A4269826;
	Thu,  3 Apr 2025 19:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707164; cv=none; b=c8KSX7Hh8YUL3ozHRZh4PWnsbvld2r2OoUW0/1M273ynltffmD07y/v4Gi6Dw1FmJwrSX1+fXZMtFrhN/fiIGRcjzrx6r2NxM1YzNeWDcVSQc/qLLDnmwObgPqKk+8iJqRdg0tq5H6EV0pUA2DD/aV5fPXi16lZ7pf7v0h2gTuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707164; c=relaxed/simple;
	bh=SMlllzYQwGJbvdrjsKHPOm5V6l7sX1dn9xo1g0/b8Hw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=huU8U5SshsxC1wvh6eKFn3i2eU74xQr5amHrPklVbVaI/D7dPcTilVZFU5fKD76NHq5Kb8QOcgLhPbUIZZxLYNQO8ueFs1v7Xj+fMPyNcLKH5DYuj70yYcfbDIczpzVnoNJKbOF8qqha8RspDnrsDFLCB4CYLDNIzptdkCbqu+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXSZ4W7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8431C4CEE3;
	Thu,  3 Apr 2025 19:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707164;
	bh=SMlllzYQwGJbvdrjsKHPOm5V6l7sX1dn9xo1g0/b8Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXSZ4W7TBEAnZpo5mc1aX4hFSqjrQvblfP08v912UglFz6HTR8rdX47PQ2QacRskb
	 1NskGQOckPw51btRHigex1UQDTfDRVvWH3bXc12yU9RNswi/bOZtP1yuAxdS5F1sZx
	 sZXS6bQIeoPVClJ25jHltdTu2MNhut8fO66+59lQhSy+WHkSLFB6U7nFbTJHsKqPSu
	 e3PWj+oSLhk1+cDkSsE5iFWd4EMtblxZ6vWSB9wrz2V+ouDHO73ihBICUe3fgtynhE
	 TTjw+mld+RY5t+kg48xcn+TWVcdeuP9D5S6Cf/pSD1V+kJteDKAQEAMVxsm6fyRc+M
	 xjmvX7DFt/mRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 03/47] wifi: ath12k: fix memory leak in ath12k_pci_remove()
Date: Thu,  3 Apr 2025 15:05:11 -0400
Message-Id: <20250403190555.2677001-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Miaoqing Pan <quic_miaoqing@quicinc.com>

[ Upstream commit 1b24394ed5c8a8d8f7b9e3aa9044c31495d46f2e ]

Kmemleak reported this error:

  unreferenced object 0xffff1c165cec3060 (size 32):
    comm "insmod", pid 560, jiffies 4296964570 (age 235.596s)
    backtrace:
      [<000000005434db68>] __kmem_cache_alloc_node+0x1f4/0x2c0
      [<000000001203b155>] kmalloc_trace+0x40/0x88
      [<0000000028adc9c8>] _request_firmware+0xb8/0x608
      [<00000000cad1aef7>] firmware_request_nowarn+0x50/0x80
      [<000000005011a682>] local_pci_probe+0x48/0xd0
      [<00000000077cd295>] pci_device_probe+0xb4/0x200
      [<0000000087184c94>] really_probe+0x150/0x2c0

The firmware memory was allocated in ath12k_pci_probe(), but not
freed in ath12k_pci_remove() in case ATH12K_FLAG_QMI_FAIL bit is
set. So call ath12k_fw_unmap() to free the memory.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.2.0-02280-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Link: https://patch.msgid.link/20250123080226.1116479-1-quic_miaoqing@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index bd269aa1740bc..2ff866e1d7d5b 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1541,6 +1541,7 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
 	ath12k_core_deinit(ab);
 
 qmi_fail:
+	ath12k_fw_unmap(ab);
 	ath12k_mhi_unregister(ab_pci);
 
 	ath12k_pci_free_irq(ab);
-- 
2.39.5


