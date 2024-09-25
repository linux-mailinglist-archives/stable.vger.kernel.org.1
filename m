Return-Path: <stable+bounces-77564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E7D985E95
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEF4289817
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1911212EEE;
	Wed, 25 Sep 2024 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khv2x5hi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D7212EE7;
	Wed, 25 Sep 2024 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266340; cv=none; b=JlhpjX5Dvfpfod98X9CK9JOipcN1SwXmmt8XvFiVomq+46VrD2CqJb10lL+qAEuBAnrx7/CjcdjLh4HhjP4Tnd4TpOxZBfjWrbfp0CpaVMApCxP0eRNakZmEfE34mVRUAJzdEW+b91d8rQkcaFML7BQVLj4lDaivxNx2UpaxclQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266340; c=relaxed/simple;
	bh=efPEQVsn/u4JRC2jcGC/mNjRx6++mnw/8wnsLTZVvC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0zjQZWtr4yFxT8Z9mUTwyh/0FKzriC74hdve3xdAjm3H5g1GuJ7It9xknEe2LKnrQDa+jHlTFhcR//YgJxrWzcFOSixBxzKF/Iv0dxldlbBYbcDMRQOCb9SlMG3HiFVbySgHFm/jDY704NUmi+qMm9q9FQ9HAKX8Yoechp690E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khv2x5hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696F9C4CECD;
	Wed, 25 Sep 2024 12:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266340;
	bh=efPEQVsn/u4JRC2jcGC/mNjRx6++mnw/8wnsLTZVvC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=khv2x5hiX9rE+HNOfm6dowCh22nrIrpH4M58UzmkgEVFXItLFN/caxGCBZmaCjvRN
	 xJEDIRLLQngn17Vzi0ab0a1O06jBhzvkuGVsagrZtkQnDT/39oDzH92cqBBADO90zX
	 u/z0tvrIXhZmikT403VsjK1tlNZ4LgA9Wa6fWr+0A1XzKGtUput7e1Sm2Pz+NGfN3j
	 CqKhyCXC06RaRcz0Q3vlWyo5Wm8PZVOypbXQk9B1hZRp8EXZAYE4FKQQiY0pY5Rdai
	 0+9f1+4Iwpl+QXZGCXoh0xzltE/HvjF5S/vjKaIZUzi9b1NAajYRrpqU1qMxcf/Xd5
	 fS0cJJlt5pqGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	przemyslaw.kitszel@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 018/139] e1000e: avoid failing the system during pm_suspend
Date: Wed, 25 Sep 2024 08:07:18 -0400
Message-ID: <20240925121137.1307574-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

[ Upstream commit 0a6ad4d9e1690c7faa3a53f762c877e477093657 ]

Occasionally when the system goes into pm_suspend, the suspend might fail
due to a PHY access error on the network adapter. Previously, this would
have caused the whole system to fail to go to a low power state.
An example of this was reported in the following Bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=205015

[ 1663.694828] e1000e 0000:00:19.0 eth0: Failed to disable ULP
[ 1664.731040] asix 2-3:1.0 eth1: link up, 100Mbps, full-duplex, lpa 0xC1E1
[ 1665.093513] e1000e 0000:00:19.0 eth0: Hardware Error
[ 1665.596760] e1000e 0000:00:19.0: pci_pm_resume+0x0/0x80 returned 0 after 2975399 usecs

and then the system never recovers from it, and all the following suspend failed due to this
[22909.393854] PM: pci_pm_suspend(): e1000e_pm_suspend+0x0/0x760 [e1000e] returns -2
[22909.393858] PM: dpm_run_callback(): pci_pm_suspend+0x0/0x160 returns -2
[22909.393861] PM: Device 0000:00:1f.6 failed to suspend async: error -2

This can be avoided by changing the return values of __e1000_shutdown and
e1000e_pm_suspend functions so that they always return 0 (success). This
is consistent with what other drivers do.

If the e1000e driver encounters a hardware error during suspend, potential
side effects include slightly higher power draw or non-working wake on
LAN. This is preferred to a system-level suspend failure, and a warning
message is written to the system log, so that the user can be aware that
the LAN controller experienced a problem during suspend.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=205015
Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 334f652c60601..d377a286c0e1b 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6672,8 +6672,10 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 		if (adapter->flags2 & FLAG2_HAS_PHY_WAKEUP) {
 			/* enable wakeup by the PHY */
 			retval = e1000_init_phy_wakeup(adapter, wufc);
-			if (retval)
-				return retval;
+			if (retval) {
+				e_err("Failed to enable wakeup\n");
+				goto skip_phy_configurations;
+			}
 		} else {
 			/* enable wakeup by the MAC */
 			ew32(WUFC, wufc);
@@ -6694,8 +6696,10 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 			 * or broadcast.
 			 */
 			retval = e1000_enable_ulp_lpt_lp(hw, !runtime);
-			if (retval)
-				return retval;
+			if (retval) {
+				e_err("Failed to enable ULP\n");
+				goto skip_phy_configurations;
+			}
 		}
 
 		/* Force SMBUS to allow WOL */
@@ -6744,6 +6748,7 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 		hw->phy.ops.release(hw);
 	}
 
+skip_phy_configurations:
 	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
 	 * would have already happened in close and is redundant.
 	 */
@@ -6986,15 +6991,13 @@ static __maybe_unused int e1000e_pm_suspend(struct device *dev)
 	e1000e_pm_freeze(dev);
 
 	rc = __e1000_shutdown(pdev, false);
-	if (rc) {
-		e1000e_pm_thaw(dev);
-	} else {
+	if (!rc) {
 		/* Introduce S0ix implementation */
 		if (adapter->flags2 & FLAG2_ENABLE_S0IX_FLOWS)
 			e1000e_s0ix_entry_flow(adapter);
 	}
 
-	return rc;
+	return 0;
 }
 
 static __maybe_unused int e1000e_pm_resume(struct device *dev)
-- 
2.43.0


