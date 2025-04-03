Return-Path: <stable+bounces-127772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11472A7AB8C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E661416E45F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ABC25F79A;
	Thu,  3 Apr 2025 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYKSEM3J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C5F25F796;
	Thu,  3 Apr 2025 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707056; cv=none; b=KKlHUDVvV9/hMMt+vEXyrgFQqKYJtaLtyLGxlyplzwbqyGPv5CJNi6L/5PLwcRtAl4geaL3ybg+h8k5mewwfQZIJEno+q2598iTChn3kB76lTAhZfLCxzVHYGh6nyScOW7eURzkmRd3ckJIpG0qExK0wbzedf3iq2jDZz5D9tVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707056; c=relaxed/simple;
	bh=UYF8jU967ayurQp0ptIlcf8oWc7tyZ1m9jYVdGcC2i4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VwdiIpHdC5zEyEwQYOj0AvbGDvZ9/0pNgMwRTvPXhsgASwlsw/eL8enZ8AWGW/2v4a8kQ74L/NwoRmghciuEtkU1Qpnmjz/UOMA5meWy5Jql7tiifuNIyMqrj+S7yBp0xANRJNr+fsL0BPqvPy/TWvBlhPmQ9irngl3lNHAV6do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYKSEM3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79303C4CEE3;
	Thu,  3 Apr 2025 19:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707055;
	bh=UYF8jU967ayurQp0ptIlcf8oWc7tyZ1m9jYVdGcC2i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pYKSEM3Jg11aELufgkwCqe2F7aYRt/jjgM1N4HHz7nqFEfsPRRQx5ox61M937s6yQ
	 apLZub3rHa+QEqK7SyPKtln3HdgN2GpFnIwrHepRbGEy6qaqdP87gjANA8kbL8UXJD
	 aqB44B/msFg99atZkwegn4cUVtCCYXN62Va4xIAEY0BsrSdFHKZ/ONF34Q9qNL5wdd
	 e6sYmhuMn3q2L7qb8Xba8ZXzXkWkZKR6InRx4HEfgB9uBSzV5OXSTDjGhfY5nQbcg2
	 gVwRW/j9T0ueglEa9GRbXfv4vuIFdd8XM/Ad6Thea1XrDDsd6ILjt9EiiFNgdrb9tg
	 U2R/VAX7UbkDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 03/49] wifi: ath12k: fix memory leak in ath12k_pci_remove()
Date: Thu,  3 Apr 2025 15:03:22 -0400
Message-Id: <20250403190408.2676344-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index cf907550e6a4a..67cbf78ad9134 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1727,6 +1727,7 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
 	ath12k_core_deinit(ab);
 
 qmi_fail:
+	ath12k_fw_unmap(ab);
 	ath12k_mhi_unregister(ab_pci);
 
 	ath12k_pci_free_irq(ab);
-- 
2.39.5


