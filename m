Return-Path: <stable+bounces-237482-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KynNCUk3WkzaQkAu9opvQ
	(envelope-from <stable+bounces-237482-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:13:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 695173F1026
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF28F308DD5E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F843290A1;
	Mon, 13 Apr 2026 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jxEstr9G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08BE31F9BC;
	Mon, 13 Apr 2026 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099568; cv=none; b=psUMChG8JYB7EM6jZaSR4dmYOyGcxTFwAszHv9mfnKyuYboUNaWHQLBMJauRBwab/pMY1ahdkTw+G3xTWIyUbfa1DrkE1WHVr3E7KM/mV8GBhTF115+3DnRGUlScq3rJ1mGYkVrVeXyC951JQQwi7kCU4G00t7uFigMwO6jnDbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099568; c=relaxed/simple;
	bh=jdSO8re+/bxrObr9KTwKpphBvrQztQvQQ6S59MMalLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WC0uED0V9Vc8OjTssKYsr9QDW/JsL1RIbxy73rGDU9hCeQfDhs53/0GnQuj+Jq67hbQx2/jdjQ6k7wWTQ4HjG//4knNxl2UPKMarVNrtkkeC3oD5kfQQZ1RLwGMDAV9WCjnZynbr0Pv1fvteuhnqzuGCVHms3jYt+84NX2xgWn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jxEstr9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29129C2BCB0;
	Mon, 13 Apr 2026 16:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099568;
	bh=jdSO8re+/bxrObr9KTwKpphBvrQztQvQQ6S59MMalLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jxEstr9G4rLQWBjWw8ns2wmweROX2pGNKye1zW08pEJ12IKsSooKRY2GP0PewZQV3
	 uHwklcOwRLoZXgFC+tuvWLxFvClNb+adJT6KtSi/eabyZiUdrAt/kBFSNW1QceBi3a
	 vkNnfJdqIA+xoc1MPxGWKMoQ74ORh4hI95+EQg2E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Saeed Mahameed <saeedm@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 348/491] net/mlx5: Avoid "No data available" when FW version queries fail
Date: Mon, 13 Apr 2026 17:59:53 +0200
Message-ID: <20260413155832.067529507@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237482-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 695173F1026
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Saeed Mahameed <saeedm@nvidia.com>

[ Upstream commit 10dc35f6a443d488f219d1a1e3fb8f8dac422070 ]

Avoid printing the misleading "kernel answers: No data available" devlink
output when querying firmware or pending firmware version fails
(e.g. MLX5 fw state errors / flash failures).

FW can fail on loading the pending flash image and get its version due
to various reasons, examples:

mlxfw: Firmware flash failed: key not applicable, err (7)
mlx5_fw_image_pending: can't read pending fw version while fw state is 1

and the resulting:
$ devlink dev info
kernel answers: No data available

Instead, just report 0 or 0xfff.. versions in case of failure to indicate
a problem, and let other information be shown.

after the fix:
$ devlink dev info
pci/0000:00:06.0:
  driver mlx5_core
  serial_number xxx...
  board.serial_number MT2225300179
  versions:
      fixed:
        fw.psid MT_0000000436
      running:
        fw.version 22.41.0188
        fw 22.41.0188
      stored:
        fw.version 255.255.65535
        fw 255.255.65535

Fixes: 9c86b07e3069 ("net/mlx5: Added fw version query command")
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20260330194015.53585-3-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  | 53 ++++++++++++-------
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  4 +-
 3 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 060561f633114..62ac22d82e1a9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -60,9 +60,7 @@ mlx5_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 	if (err)
 		return err;
 
-	err = mlx5_fw_version_query(dev, &running_fw, &stored_fw);
-	if (err)
-		return err;
+	mlx5_fw_version_query(dev, &running_fw, &stored_fw);
 
 	snprintf(version_str, sizeof(version_str), "%d.%d.%04d",
 		 mlx5_fw_ver_major(running_fw), mlx5_fw_ver_minor(running_fw),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index 02558ac2ace69..eb414452dbd0f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -770,48 +770,63 @@ mlx5_fw_image_pending(struct mlx5_core_dev *dev,
 	return 0;
 }
 
-int mlx5_fw_version_query(struct mlx5_core_dev *dev,
-			  u32 *running_ver, u32 *pending_ver)
+void mlx5_fw_version_query(struct mlx5_core_dev *dev,
+			   u32 *running_ver, u32 *pending_ver)
 {
 	u32 reg_mcqi_version[MLX5_ST_SZ_DW(mcqi_version)] = {};
 	bool pending_version_exists;
 	int component_index;
 	int err;
 
+	*running_ver = 0;
+	*pending_ver = 0;
+
 	if (!MLX5_CAP_GEN(dev, mcam_reg) || !MLX5_CAP_MCAM_REG(dev, mcqi) ||
 	    !MLX5_CAP_MCAM_REG(dev, mcqs)) {
 		mlx5_core_warn(dev, "fw query isn't supported by the FW\n");
-		return -EOPNOTSUPP;
+		return;
 	}
 
 	component_index = mlx5_get_boot_img_component_index(dev);
-	if (component_index < 0)
-		return component_index;
+	if (component_index < 0) {
+		mlx5_core_warn(dev, "fw query failed to find boot img component index, err %d\n",
+			       component_index);
+		return;
+	}
 
+	*running_ver = U32_MAX; /* indicate failure */
 	err = mlx5_reg_mcqi_version_query(dev, component_index,
 					  MCQI_FW_RUNNING_VERSION,
 					  reg_mcqi_version);
-	if (err)
-		return err;
-
-	*running_ver = MLX5_GET(mcqi_version, reg_mcqi_version, version);
-
+	if (!err)
+		*running_ver = MLX5_GET(mcqi_version, reg_mcqi_version,
+					version);
+	else
+		mlx5_core_warn(dev, "failed to query running version, err %d\n",
+			       err);
+
+	*pending_ver = U32_MAX; /* indicate failure */
 	err = mlx5_fw_image_pending(dev, component_index, &pending_version_exists);
-	if (err)
-		return err;
+	if (err) {
+		mlx5_core_warn(dev, "failed to query pending image, err %d\n",
+			       err);
+		return;
+	}
 
 	if (!pending_version_exists) {
 		*pending_ver = 0;
-		return 0;
+		return;
 	}
 
 	err = mlx5_reg_mcqi_version_query(dev, component_index,
 					  MCQI_FW_STORED_VERSION,
 					  reg_mcqi_version);
-	if (err)
-		return err;
-
-	*pending_ver = MLX5_GET(mcqi_version, reg_mcqi_version, version);
-
-	return 0;
+	if (!err)
+		*pending_ver = MLX5_GET(mcqi_version, reg_mcqi_version,
+					version);
+	else
+		mlx5_core_warn(dev, "failed to query pending version, err %d\n",
+			       err);
+
+	return;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index b285f1515e4e8..d3279536c902c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -209,8 +209,8 @@ void mlx5_dm_cleanup(struct mlx5_core_dev *dev);
 
 int mlx5_firmware_flash(struct mlx5_core_dev *dev, const struct firmware *fw,
 			struct netlink_ext_ack *extack);
-int mlx5_fw_version_query(struct mlx5_core_dev *dev,
-			  u32 *running_ver, u32 *stored_ver);
+void mlx5_fw_version_query(struct mlx5_core_dev *dev, u32 *running_ver,
+			   u32 *stored_ver);
 
 void mlx5e_init(void);
 void mlx5e_cleanup(void);
-- 
2.53.0




