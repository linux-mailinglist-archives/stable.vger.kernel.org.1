Return-Path: <stable+bounces-153155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCB0ADD2D2
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF283A934F
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1AC2ED142;
	Tue, 17 Jun 2025 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R6iyT2wI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4685C2DFF3C;
	Tue, 17 Jun 2025 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175055; cv=none; b=gOHkkpDdeWL2nLmpVbYWIvEVPEwYnSTzhZ6C8dDOK3T4TwQeeU4mWNkpkX0x0IWCxhpPMT1BYwdOukP0Zw6nAw/MRvLL+HhAUHv+Yh1zzmxjzGcADOecBVKkHsVfVUimsoQ9R5IWGoDcmNoWsEZFamq2wkgmfqwi3PkErkcyn8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175055; c=relaxed/simple;
	bh=3XtyoVRSxMDZQjqDsIya12LWu5yLrMs9cQk7fpEVH2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+jwGo1t2OdKmSPF95Dpfqlwrb+unXxv/69M4BOfND4+ik7rxiyMiGQOyeMOdpKUkN6WkfWBMYS8JVghm8Je6BFvf7MoBSEn1uK/jTh5vglbLVTAzelQnk0Q5v+bM/YnNkoPcCknxahIptWrOd2oiWB+mvInakeGQWf4h6tHw04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R6iyT2wI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73CFC4CEF1;
	Tue, 17 Jun 2025 15:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175055;
	bh=3XtyoVRSxMDZQjqDsIya12LWu5yLrMs9cQk7fpEVH2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6iyT2wIlSFMkXxg1N9lob8Lg/sKqK0FC0D4SaJ+DAnRARQHXh7dz9YQ1wPMEreHs
	 S0B2D/Uf1H7uYgsDpHZ5TJJe3apnwRibGa15/LBRq09nUSi8ypKf3kU0XXg3NjFmAu
	 PRECa6LrDTpyocGH0+JUwO4YqQEd25ejGOaOQtcw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rajat Soni <quic_rajson@quicinc.com>,
	Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 127/356] wifi: ath12k: fix memory leak in ath12k_service_ready_ext_event
Date: Tue, 17 Jun 2025 17:24:02 +0200
Message-ID: <20250617152343.347457824@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rajat Soni <quic_rajson@quicinc.com>

[ Upstream commit 89142d34d5602c7447827beb181fa06eb08b9d5c ]

Currently, in ath12k_service_ready_ext_event(), svc_rdy_ext.mac_phy_caps
is not freed in the failure case, causing a memory leak. The following
trace is observed in kmemleak:

unreferenced object 0xffff8b3eb5789c00 (size 1024):
 comm "softirq", pid 0, jiffies 4294942577
 hex dump (first 32 bytes):
   00 00 00 00 01 00 00 00 00 00 00 00 7b 00 00 10  ............{...
   01 00 00 00 00 00 00 00 01 00 00 00 1f 38 00 00  .............8..
 backtrace (crc 44e1c357):
   __kmalloc_noprof+0x30b/0x410
   ath12k_wmi_mac_phy_caps_parse+0x84/0x100 [ath12k]
   ath12k_wmi_tlv_iter+0x5e/0x140 [ath12k]
   ath12k_wmi_svc_rdy_ext_parse+0x308/0x4c0 [ath12k]
   ath12k_wmi_tlv_iter+0x5e/0x140 [ath12k]
   ath12k_service_ready_ext_event.isra.0+0x44/0xd0 [ath12k]
   ath12k_wmi_op_rx+0x2eb/0xd70 [ath12k]
   ath12k_htc_rx_completion_handler+0x1f4/0x330 [ath12k]
   ath12k_ce_recv_process_cb+0x218/0x300 [ath12k]
   ath12k_pci_ce_workqueue+0x1b/0x30 [ath12k]
   process_one_work+0x219/0x680
   bh_worker+0x198/0x1f0
   tasklet_action+0x13/0x30
   handle_softirqs+0xca/0x460
   __irq_exit_rcu+0xbe/0x110
   irq_exit_rcu+0x9/0x30

Free svc_rdy_ext.mac_phy_caps in the error case to fix this memory leak.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Link: https://patch.msgid.link/20250430-wmi-mem-leak-v1-1-fcc9b49c2ddc@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index a96bf261a3f75..a0ac2f350934f 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4128,6 +4128,7 @@ static int ath12k_service_ready_ext_event(struct ath12k_base *ab,
 	return 0;
 
 err:
+	kfree(svc_rdy_ext.mac_phy_caps);
 	ath12k_wmi_free_dbring_caps(ab);
 	return ret;
 }
-- 
2.39.5




