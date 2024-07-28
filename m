Return-Path: <stable+bounces-62071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303F193E2A8
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 03:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B58281862
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 01:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0778A192B95;
	Sun, 28 Jul 2024 00:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNu6EcgK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E5D192B8B;
	Sun, 28 Jul 2024 00:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128063; cv=none; b=a7RT+mWd4RIOqsDTqR0AbCrqL+Anl1lNu7isLLtDO0TG2ANoroxk7Gk1ZUOW146OmstSSmsx9SVE34NzX/EZsd1l1kIaQRdlJBQz4XGHI0gNv8B/pNde2u5nnH5GFhspauW3h+yflVm6WGfQIzG5IKNIhsluZ2zF6mD4rCXcbM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128063; c=relaxed/simple;
	bh=4FIF7okYv/uUjF8tG+KxRZ13KnzZF5OxNpTQHjw7vWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ft846s2Hq69IKlcQiTBwkiDF6J8n50e8PzKXuxteILwEY7hzLXmoM2j4Kc33bq0L6KrXMCbkR01ErQw7mI0JLtAO860DJq3WFt+vd8FHLlOmZa2LF1M+v/V8Q7Mfqb7NJZcA+5VmvEFPeOphMY+Uk63iLPtXPx770arGwdzS7A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNu6EcgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7DFC32781;
	Sun, 28 Jul 2024 00:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128063;
	bh=4FIF7okYv/uUjF8tG+KxRZ13KnzZF5OxNpTQHjw7vWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YNu6EcgK2QEEY/B9sbKwJdVyA4hLOSdBhdLmOO85NlpVUVwAld9pF16TQtLC2Hmsd
	 MefM7COcjJl3fpss+W4lTKYOkYwdAU0zZiFmOZPTrEnv3g8RQupMIUIRLZ/3kijVM5
	 r/hQtBfOWEq4xeEqKKEEBKy2kk9Omucb20xNqtwJ6f2ZOla7r1ME2twgfCtac97ulB
	 4TsggofFlEA94VxrgHniz9p2JoX65JuK68B2dJFNVGz0oXCuAFAz7FwAXWRNplf/31
	 apGD8uTudRir5oj6B2o1yAkRCux9RBnMvOwVo0ur6HTF9AcKKUJDKiURbqndrI1yom
	 44OOQpLorVU2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 20/27] mlxsw: pci: Lock configuration space of upstream bridge during reset
Date: Sat, 27 Jul 2024 20:53:03 -0400
Message-ID: <20240728005329.1723272-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005329.1723272-1-sashal@kernel.org>
References: <20240728005329.1723272-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 0970836c348b6bc2ea77ce4348a136d6febfd440 ]

The driver triggers a "Secondary Bus Reset" (SBR) by calling
__pci_reset_function_locked() which asserts the SBR bit in the "Bridge
Control Register" in the configuration space of the upstream bridge for
2ms. This is done without locking the configuration space of the
upstream bridge port, allowing user space to access it concurrently.

Linux 6.11 will start warning about such unlocked resets [1][2]:

pcieport 0000:00:01.0: unlocked secondary bus reset via: pci_reset_bus_function+0x51c/0x6a0

Avoid the warning and the concurrent access by locking the configuration
space of the upstream bridge prior to the reset and unlocking it
afterwards.

[1] https://lore.kernel.org/all/171711746953.1628941.4692125082286867825.stgit@dwillia2-xfh.jf.intel.com/
[2] https://lore.kernel.org/all/20240531213150.GA610983@bhelgaas/

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Link: https://patch.msgid.link/9937b0afdb50f2f2825945393c94c093c04a5897.1720447210.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index c0ced4d315f3d..d92f640bae575 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1599,6 +1599,7 @@ static int mlxsw_pci_reset_at_pci_disable(struct mlxsw_pci *mlxsw_pci,
 {
 	struct pci_dev *pdev = mlxsw_pci->pdev;
 	char mrsr_pl[MLXSW_REG_MRSR_LEN];
+	struct pci_dev *bridge;
 	int err;
 
 	if (!pci_reset_sbr_supported) {
@@ -1615,6 +1616,9 @@ static int mlxsw_pci_reset_at_pci_disable(struct mlxsw_pci *mlxsw_pci,
 sbr:
 	device_lock_assert(&pdev->dev);
 
+	bridge = pci_upstream_bridge(pdev);
+	if (bridge)
+		pci_cfg_access_lock(bridge);
 	pci_cfg_access_lock(pdev);
 	pci_save_state(pdev);
 
@@ -1624,6 +1628,8 @@ static int mlxsw_pci_reset_at_pci_disable(struct mlxsw_pci *mlxsw_pci,
 
 	pci_restore_state(pdev);
 	pci_cfg_access_unlock(pdev);
+	if (bridge)
+		pci_cfg_access_unlock(bridge);
 
 	return err;
 }
-- 
2.43.0


