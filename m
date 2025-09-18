Return-Path: <stable+bounces-177338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2692B404BB
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C636C5E5C77
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE0D311C1E;
	Tue,  2 Sep 2025 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lyGCB+sz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED864311970;
	Tue,  2 Sep 2025 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820329; cv=none; b=U335/QXtkFoim2g0prEwQ+a2JBz+HWG0mIXsgQyO+pLgAhwP61mIxRo5P6mjQvTizlePI7sOG+6cZ/BcDtzRKSW+FH505uS4+8+7lodR8jaxN4gjvUGJs2r51dehs+nmxylBdwXy3iROiEzFrOvhecAy5Z16RE9bA5AsygD7Iew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820329; c=relaxed/simple;
	bh=S+oC7duJFnJXzaSRer4mtYqj7xVLvu2hJgFC8Zd+jO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJsKQzyVXO1AeopTsrJGNz1GJvQnXen/sXZCuyhNenZUZ7HY8I+JdFYAo1HS4kpxW5hfp5Mtu4scgk31xxK8lFhb4Rvr3HL2r70VGQhCQXGDLf40sgyGu5q1/YU03+6TJh1GBLuO1QQ6LTcJR6bZo+MoOd6DjWf3TctWmUkUnbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lyGCB+sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59762C4CEED;
	Tue,  2 Sep 2025 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756820328;
	bh=S+oC7duJFnJXzaSRer4mtYqj7xVLvu2hJgFC8Zd+jO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lyGCB+sz7DA851Jzvh1pKKRQ3IbrvBXcSTXrHUl6cipti1+FiLkq9/CFeWDRfQO1V
	 EWft+qVRwq1btu00LpOt7flPrr0OGL7WWbeuo+IaP7yNUkGg6T/HByf7UzLstvPnN3
	 Hvw2fdMZor8Qhivgk/Un7eKhVdtRiVpooi/Id2yM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 38/75] net/mlx5: Add support for sync reset using hot reset
Date: Tue,  2 Sep 2025 15:20:50 +0200
Message-ID: <20250902131936.615991393@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131935.107897242@linuxfoundation.org>
References: <20250902131935.107897242@linuxfoundation.org>
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

From: Moshe Shemesh <moshe@nvidia.com>

[ Upstream commit 57502f62678ced0149d415324931bde37b42885a ]

On device that supports sync reset for firmware activate using hot
reset, the driver queries the required reset method while handling the
sync reset request. If the required reset method is hot reset, the
driver will use pci_reset_bus() to reset the PCI link instead of the
link toggle.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20240911201757.1505453-11-saeed@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 902a8bc23a24 ("net/mlx5: Fix lockdep assertion on sync reset unload event")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 82 +++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/main.c    |  3 +
 2 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 6b17346aa4cef..a1c2dd7f5c2c0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -26,6 +26,7 @@ struct mlx5_fw_reset {
 	struct work_struct reset_now_work;
 	struct work_struct reset_abort_work;
 	unsigned long reset_flags;
+	u8 reset_method;
 	struct timer_list timer;
 	struct completion done;
 	int ret;
@@ -94,7 +95,7 @@ static int mlx5_reg_mfrl_set(struct mlx5_core_dev *dev, u8 reset_level,
 }
 
 static int mlx5_reg_mfrl_query(struct mlx5_core_dev *dev, u8 *reset_level,
-			       u8 *reset_type, u8 *reset_state)
+			       u8 *reset_type, u8 *reset_state, u8 *reset_method)
 {
 	u32 out[MLX5_ST_SZ_DW(mfrl_reg)] = {};
 	u32 in[MLX5_ST_SZ_DW(mfrl_reg)] = {};
@@ -110,13 +111,26 @@ static int mlx5_reg_mfrl_query(struct mlx5_core_dev *dev, u8 *reset_level,
 		*reset_type = MLX5_GET(mfrl_reg, out, reset_type);
 	if (reset_state)
 		*reset_state = MLX5_GET(mfrl_reg, out, reset_state);
+	if (reset_method)
+		*reset_method = MLX5_GET(mfrl_reg, out, pci_reset_req_method);
 
 	return 0;
 }
 
 int mlx5_fw_reset_query(struct mlx5_core_dev *dev, u8 *reset_level, u8 *reset_type)
 {
-	return mlx5_reg_mfrl_query(dev, reset_level, reset_type, NULL);
+	return mlx5_reg_mfrl_query(dev, reset_level, reset_type, NULL, NULL);
+}
+
+static int mlx5_fw_reset_get_reset_method(struct mlx5_core_dev *dev,
+					  u8 *reset_method)
+{
+	if (!MLX5_CAP_GEN(dev, pcie_reset_using_hotreset_method)) {
+		*reset_method = MLX5_MFRL_REG_PCI_RESET_METHOD_LINK_TOGGLE;
+		return 0;
+	}
+
+	return mlx5_reg_mfrl_query(dev, NULL, NULL, NULL, reset_method);
 }
 
 static int mlx5_fw_reset_get_reset_state_err(struct mlx5_core_dev *dev,
@@ -124,7 +138,7 @@ static int mlx5_fw_reset_get_reset_state_err(struct mlx5_core_dev *dev,
 {
 	u8 reset_state;
 
-	if (mlx5_reg_mfrl_query(dev, NULL, NULL, &reset_state))
+	if (mlx5_reg_mfrl_query(dev, NULL, NULL, &reset_state, NULL))
 		goto out;
 
 	if (!reset_state)
@@ -402,7 +416,11 @@ static void mlx5_sync_reset_request_event(struct work_struct *work)
 	struct mlx5_core_dev *dev = fw_reset->dev;
 	int err;
 
-	if (test_bit(MLX5_FW_RESET_FLAGS_NACK_RESET_REQUEST, &fw_reset->reset_flags) ||
+	err = mlx5_fw_reset_get_reset_method(dev, &fw_reset->reset_method);
+	if (err)
+		mlx5_core_warn(dev, "Failed reading MFRL, err %d\n", err);
+
+	if (err || test_bit(MLX5_FW_RESET_FLAGS_NACK_RESET_REQUEST, &fw_reset->reset_flags) ||
 	    !mlx5_is_reset_now_capable(dev)) {
 		err = mlx5_fw_reset_set_reset_sync_nack(dev);
 		mlx5_core_warn(dev, "PCI Sync FW Update Reset Nack %s",
@@ -419,21 +437,15 @@ static void mlx5_sync_reset_request_event(struct work_struct *work)
 		mlx5_core_warn(dev, "PCI Sync FW Update Reset Ack. Device reset is expected.\n");
 }
 
-static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
+static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev, u16 dev_id)
 {
 	struct pci_bus *bridge_bus = dev->pdev->bus;
 	struct pci_dev *bridge = bridge_bus->self;
 	unsigned long timeout;
 	struct pci_dev *sdev;
-	u16 reg16, dev_id;
 	int cap, err;
+	u16 reg16;
 
-	err = pci_read_config_word(dev->pdev, PCI_DEVICE_ID, &dev_id);
-	if (err)
-		return pcibios_err_to_errno(err);
-	err = mlx5_check_dev_ids(dev, dev_id);
-	if (err)
-		return err;
 	cap = pci_find_capability(bridge, PCI_CAP_ID_EXP);
 	if (!cap)
 		return -EOPNOTSUPP;
@@ -503,6 +515,44 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
 	return err;
 }
 
+static int mlx5_pci_reset_bus(struct mlx5_core_dev *dev)
+{
+	if (!MLX5_CAP_GEN(dev, pcie_reset_using_hotreset_method))
+		return -EOPNOTSUPP;
+
+	return pci_reset_bus(dev->pdev);
+}
+
+static int mlx5_sync_pci_reset(struct mlx5_core_dev *dev, u8 reset_method)
+{
+	u16 dev_id;
+	int err;
+
+	err = pci_read_config_word(dev->pdev, PCI_DEVICE_ID, &dev_id);
+	if (err)
+		return pcibios_err_to_errno(err);
+	err = mlx5_check_dev_ids(dev, dev_id);
+	if (err)
+		return err;
+
+	switch (reset_method) {
+	case MLX5_MFRL_REG_PCI_RESET_METHOD_LINK_TOGGLE:
+		err = mlx5_pci_link_toggle(dev, dev_id);
+		if (err)
+			mlx5_core_warn(dev, "mlx5_pci_link_toggle failed\n");
+		break;
+	case MLX5_MFRL_REG_PCI_RESET_METHOD_HOT_RESET:
+		err = mlx5_pci_reset_bus(dev);
+		if (err)
+			mlx5_core_warn(dev, "mlx5_pci_reset_bus failed\n");
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
 static void mlx5_sync_reset_now_event(struct work_struct *work)
 {
 	struct mlx5_fw_reset *fw_reset = container_of(work, struct mlx5_fw_reset,
@@ -521,9 +571,9 @@ static void mlx5_sync_reset_now_event(struct work_struct *work)
 		goto done;
 	}
 
-	err = mlx5_pci_link_toggle(dev);
+	err = mlx5_sync_pci_reset(dev, fw_reset->reset_method);
 	if (err) {
-		mlx5_core_warn(dev, "mlx5_pci_link_toggle failed, no reset done, err %d\n", err);
+		mlx5_core_warn(dev, "mlx5_sync_pci_reset failed, no reset done, err %d\n", err);
 		set_bit(MLX5_FW_RESET_FLAGS_RELOAD_REQUIRED, &fw_reset->reset_flags);
 	}
 
@@ -585,9 +635,9 @@ static void mlx5_sync_reset_unload_event(struct work_struct *work)
 
 	mlx5_core_warn(dev, "Sync Reset, got reset action. rst_state = %u\n", rst_state);
 	if (rst_state == MLX5_FW_RST_STATE_TOGGLE_REQ) {
-		err = mlx5_pci_link_toggle(dev);
+		err = mlx5_sync_pci_reset(dev, fw_reset->reset_method);
 		if (err) {
-			mlx5_core_warn(dev, "mlx5_pci_link_toggle failed, err %d\n", err);
+			mlx5_core_warn(dev, "mlx5_sync_pci_reset failed, err %d\n", err);
 			fw_reset->ret = err;
 		}
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 62a85f09b52fd..8a11e410f7c13 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -627,6 +627,9 @@ static int handle_hca_cap(struct mlx5_core_dev *dev, void *set_ctx)
 	if (MLX5_CAP_GEN_MAX(dev, pci_sync_for_fw_update_with_driver_unload))
 		MLX5_SET(cmd_hca_cap, set_hca_cap,
 			 pci_sync_for_fw_update_with_driver_unload, 1);
+	if (MLX5_CAP_GEN_MAX(dev, pcie_reset_using_hotreset_method))
+		MLX5_SET(cmd_hca_cap, set_hca_cap,
+			 pcie_reset_using_hotreset_method, 1);
 
 	if (MLX5_CAP_GEN_MAX(dev, num_vhca_ports))
 		MLX5_SET(cmd_hca_cap,
-- 
2.50.1




