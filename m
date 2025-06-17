Return-Path: <stable+bounces-154441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C92B8ADD962
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FD65A1420
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CC6285055;
	Tue, 17 Jun 2025 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JUqRfUaY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2672FA630;
	Tue, 17 Jun 2025 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179199; cv=none; b=Tyx897yIHcV7QoWyNluGpbD0xAdnIRuNi6Jo/qqYSoG/4eja9WHC1+murr2DFFCwhSM5ChvT326KRosEnLDcxj0lqp4gqEAY5ah4dYZdN1WP7ufPGneMepnV2f1lPX5fXg6iC3xSf7buYx/7cw6XrUH99WpAyd6AbHqaRMKE74w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179199; c=relaxed/simple;
	bh=PPqKOc8TKldgSgRFXWpMTFnwuPdHp/alZGbMN4Vn39M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jd2/fL22bUD8Kf79XUIZAtHopDG5Tv5JxBq+CVxq7RR5aCP0ck7w2yS3PTuLB2qd/xWfdDHW/zSJoZ9iM9SnjYd0+umcXjJdS7vC277ZjxHEeg5VuKn7zviAh9u4UPj0JZgM6BZ1XSU6EYn/YpClQPco6sI5QXNt18aQI/1dlf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JUqRfUaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B79C4CEE3;
	Tue, 17 Jun 2025 16:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750179199;
	bh=PPqKOc8TKldgSgRFXWpMTFnwuPdHp/alZGbMN4Vn39M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JUqRfUaYMep2IcAs5H34Fj7DmGaXu9u8C5FA2EAm0vuAkWpSSO0btgegN1SFz03wK
	 qr+R6abe6Aql0XF+o1UJeEbxeo5ky1gOW3RDXYhJXmL58Ufgmpj2W2/nhecnp6Vv8Y
	 1S4uo5D1u/AgPijJuSncMa8GlLgacK5I3hZ+Izo0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 679/780] wifi: ath12k: fix uaf in ath12k_core_init()
Date: Tue, 17 Jun 2025 17:26:27 +0200
Message-ID: <20250617152519.118285727@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>

[ Upstream commit f3fe49dbddd73f0155a8935af47cb63693069dbe ]

When the execution of ath12k_core_hw_group_assign() or
ath12k_core_hw_group_create() fails, the registered notifier chain is not
unregistered properly. Its memory is freed after rmmod, which may trigger
to a use-after-free (UAF) issue if there is a subsequent access to this
notifier chain.

Fixes the issue by calling ath12k_core_panic_notifier_unregister() in
failure cases.

Call trace:
 notifier_chain_register+0x4c/0x1f0 (P)
 atomic_notifier_chain_register+0x38/0x68
 ath12k_core_init+0x50/0x4e8 [ath12k]
 ath12k_pci_probe+0x5f8/0xc28 [ath12k]
 pci_device_probe+0xbc/0x1a8
 really_probe+0xc8/0x3a0
 __driver_probe_device+0x84/0x1b0
 driver_probe_device+0x44/0x130
 __driver_attach+0xcc/0x208
 bus_for_each_dev+0x84/0x100
 driver_attach+0x2c/0x40
 bus_add_driver+0x130/0x260
 driver_register+0x70/0x138
 __pci_register_driver+0x68/0x80
 ath12k_pci_init+0x30/0x68 [ath12k]
 ath12k_init+0x28/0x78 [ath12k]

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 6f245ea0ec6c ("wifi: ath12k: introduce device group abstraction")
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>
Link: https://patch.msgid.link/20250604055250.1228501-1-miaoqing.pan@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 770156347ffad..261f52b327e89 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1902,7 +1902,8 @@ int ath12k_core_init(struct ath12k_base *ab)
 	if (!ag) {
 		mutex_unlock(&ath12k_hw_group_mutex);
 		ath12k_warn(ab, "unable to get hw group\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_unregister_notifier;
 	}
 
 	mutex_unlock(&ath12k_hw_group_mutex);
@@ -1917,7 +1918,7 @@ int ath12k_core_init(struct ath12k_base *ab)
 		if (ret) {
 			mutex_unlock(&ag->mutex);
 			ath12k_warn(ab, "unable to create hw group\n");
-			goto err;
+			goto err_destroy_hw_group;
 		}
 	}
 
@@ -1925,9 +1926,12 @@ int ath12k_core_init(struct ath12k_base *ab)
 
 	return 0;
 
-err:
+err_destroy_hw_group:
 	ath12k_core_hw_group_destroy(ab->ag);
 	ath12k_core_hw_group_unassign(ab);
+err_unregister_notifier:
+	ath12k_core_panic_notifier_unregister(ab);
+
 	return ret;
 }
 
-- 
2.39.5




