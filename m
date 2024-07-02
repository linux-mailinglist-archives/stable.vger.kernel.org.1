Return-Path: <stable+bounces-56394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEB4924430
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0DC281A23
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8F71BD51C;
	Tue,  2 Jul 2024 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PAYAmcPt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5787F1BE24A;
	Tue,  2 Jul 2024 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940040; cv=none; b=ud1w3eQv7CvUh0FzsBAEd3Ar+USZoJxSYPVUYfBfp0S8OAToU5FGCkKVOn9gHAhR/ibsYGAihZA0tB4I9CqK8L/pFtSwaHUNLAfCzQ0s0LzkgmRjRlsSsgf/y5I5DQOqWbM32SnUlXk2ftWB4CEkkLaj3HZddHtujOUdB4zgH9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940040; c=relaxed/simple;
	bh=LPGd2yCDDTrZwBagybFhdmweOYYHNVh1EWFoFa18HnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlS97YBo458JG00dkH95uBKUbYziRKINeIzutFTcAX6qL3mlDsBb1qji0K2zU+rs3K/LxftEYGncP3yKV9d/sAxFBKiYh1iHcfrOmu84Ma6+5yQuX5u042l3fuKptblq7aOX1XbDktFg8FFOolU4+uj5bly7PIYvV71bVR3oDJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PAYAmcPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842F9C4AF0D;
	Tue,  2 Jul 2024 17:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940039;
	bh=LPGd2yCDDTrZwBagybFhdmweOYYHNVh1EWFoFa18HnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PAYAmcPtOLaG0cUPQsC89zMuhWYin3IjDTG1i2tqVvyvP9McSvqYBVZQS/2qD+hdz
	 oEU6PVw9f2mjPhoVjoSTyA4K8k1SlTYJYQQG7Ishi+WkF3O+262yLL0edQ8ZUEzUlg
	 zaYVA4H/1cRLZltpX939rHotGdeV/dNEjn26PYRg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maksym Yaremchuk <maksymy@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 034/222] mlxsw: pci: Fix driver initialization with Spectrum-4
Date: Tue,  2 Jul 2024 19:01:12 +0200
Message-ID: <20240702170245.280912940@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>
References: <20240702170243.963426416@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 0602697d6f4d72b0bc5edbc76afabf6aaa029a69 ]

Cited commit added support for a new reset flow ("all reset") which is
deeper than the existing reset flow ("software reset") and allows the
device's PCI firmware to be upgraded.

In the new flow the driver first tells the firmware that "all reset" is
required by issuing a new reset command (i.e., MRSR.command=6) and then
triggers the reset by having the PCI core issue a secondary bus reset
(SBR).

However, due to a race condition in the device's firmware the device is
not always able to recover from this reset, resulting in initialization
failures [1].

New firmware versions include a fix for the bug and advertise it using a
new capability bit in the Management Capabilities Mask (MCAM) register.

Avoid initialization failures by reading the new capability bit and
triggering the new reset flow only if the bit is set. If the bit is not
set, trigger a normal PCI hot reset by skipping the call to the
Management Reset and Shutdown Register (MRSR).

Normal PCI hot reset is weaker than "all reset", but it results in a
fully operational driver and allows users to flash a new firmware, if
they want to.

[1]
mlxsw_spectrum4 0000:01:00.0: not ready 1023ms after bus reset; waiting
mlxsw_spectrum4 0000:01:00.0: not ready 2047ms after bus reset; waiting
mlxsw_spectrum4 0000:01:00.0: not ready 4095ms after bus reset; waiting
mlxsw_spectrum4 0000:01:00.0: not ready 8191ms after bus reset; waiting
mlxsw_spectrum4 0000:01:00.0: not ready 16383ms after bus reset; waiting
mlxsw_spectrum4 0000:01:00.0: not ready 32767ms after bus reset; waiting
mlxsw_spectrum4 0000:01:00.0: not ready 65535ms after bus reset; giving up
mlxsw_spectrum4 0000:01:00.0: PCI function reset failed with -25
mlxsw_spectrum4 0000:01:00.0: cannot register bus device
mlxsw_spectrum4: probe of 0000:01:00.0 failed with error -25

Fixes: f257c73e5356 ("mlxsw: pci: Add support for new reset flow")
Reported-by: Maksym Yaremchuk <maksymy@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Maksym Yaremchuk <maksymy@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 18 +++++++++++++++---
 drivers/net/ethernet/mellanox/mlxsw/reg.h |  2 ++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index f42a1b1c93687..653a47dd43862 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1490,18 +1490,25 @@ static int mlxsw_pci_sys_ready_wait(struct mlxsw_pci *mlxsw_pci,
 	return -EBUSY;
 }
 
-static int mlxsw_pci_reset_at_pci_disable(struct mlxsw_pci *mlxsw_pci)
+static int mlxsw_pci_reset_at_pci_disable(struct mlxsw_pci *mlxsw_pci,
+					  bool pci_reset_sbr_supported)
 {
 	struct pci_dev *pdev = mlxsw_pci->pdev;
 	char mrsr_pl[MLXSW_REG_MRSR_LEN];
 	int err;
 
+	if (!pci_reset_sbr_supported) {
+		pci_dbg(pdev, "Performing PCI hot reset instead of \"all reset\"\n");
+		goto sbr;
+	}
+
 	mlxsw_reg_mrsr_pack(mrsr_pl,
 			    MLXSW_REG_MRSR_COMMAND_RESET_AT_PCI_DISABLE);
 	err = mlxsw_reg_write(mlxsw_pci->core, MLXSW_REG(mrsr), mrsr_pl);
 	if (err)
 		return err;
 
+sbr:
 	device_lock_assert(&pdev->dev);
 
 	pci_cfg_access_lock(pdev);
@@ -1529,6 +1536,7 @@ static int
 mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 {
 	struct pci_dev *pdev = mlxsw_pci->pdev;
+	bool pci_reset_sbr_supported = false;
 	char mcam_pl[MLXSW_REG_MCAM_LEN];
 	bool pci_reset_supported = false;
 	u32 sys_status;
@@ -1548,13 +1556,17 @@ mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 	mlxsw_reg_mcam_pack(mcam_pl,
 			    MLXSW_REG_MCAM_FEATURE_GROUP_ENHANCED_FEATURES);
 	err = mlxsw_reg_query(mlxsw_pci->core, MLXSW_REG(mcam), mcam_pl);
-	if (!err)
+	if (!err) {
 		mlxsw_reg_mcam_unpack(mcam_pl, MLXSW_REG_MCAM_PCI_RESET,
 				      &pci_reset_supported);
+		mlxsw_reg_mcam_unpack(mcam_pl, MLXSW_REG_MCAM_PCI_RESET_SBR,
+				      &pci_reset_sbr_supported);
+	}
 
 	if (pci_reset_supported) {
 		pci_dbg(pdev, "Starting PCI reset flow\n");
-		err = mlxsw_pci_reset_at_pci_disable(mlxsw_pci);
+		err = mlxsw_pci_reset_at_pci_disable(mlxsw_pci,
+						     pci_reset_sbr_supported);
 	} else {
 		pci_dbg(pdev, "Starting software reset flow\n");
 		err = mlxsw_pci_reset_sw(mlxsw_pci);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 8892654c685f3..010eecab5147a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -10668,6 +10668,8 @@ enum mlxsw_reg_mcam_mng_feature_cap_mask_bits {
 	MLXSW_REG_MCAM_MCIA_128B = 34,
 	/* If set, MRSR.command=6 is supported. */
 	MLXSW_REG_MCAM_PCI_RESET = 48,
+	/* If set, MRSR.command=6 is supported with Secondary Bus Reset. */
+	MLXSW_REG_MCAM_PCI_RESET_SBR = 67,
 };
 
 #define MLXSW_REG_BYTES_PER_DWORD 0x4
-- 
2.43.0




