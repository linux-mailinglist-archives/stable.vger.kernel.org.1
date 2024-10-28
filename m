Return-Path: <stable+bounces-88405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3289B25DA
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 791F4B20B14
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E3E18F2C5;
	Mon, 28 Oct 2024 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q5nuHllb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92499190685;
	Mon, 28 Oct 2024 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097256; cv=none; b=qVQI3f46Fwow8DXwZw27ClvFE7eP3OVRA2q39tniv1pG9HDJ8OpJl3a+qw8dmAEGYz/BLJ9oRwFJpKjSfPi9oonuQnc2retOgaG6SJuv6bVEdlaEFn3Bh75d3byECvFIRi0KUxiTE+MWZqWDSQhwkyrToQK73Z8AWPWU0ok0bSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097256; c=relaxed/simple;
	bh=ukxpretWohzrP+ZUhnz8ImkjyPU0LZtZHb8kfcvmIOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9TueUVQKzFafBQbFNkLFBdBQzV7/MFW3i5m26AG7l4zASxgoupVdjRpV4SndBPbMlVJCCgCj6P6tDJcPgl7oC13FCPneorIuKqgMldxbYaF+uGezud4t7SiVJRHn1ZLAWcWZabZEdHKVA7E6GOUFV/rZ+i+g/E5Owm6pdJVrdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q5nuHllb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E653C4CEE3;
	Mon, 28 Oct 2024 06:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097256;
	bh=ukxpretWohzrP+ZUhnz8ImkjyPU0LZtZHb8kfcvmIOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q5nuHllb+hjbi19DmGV2WA5n55GcXAm2fdGhY0svtUYJLxTjZ5TGaV23oAauzrkOk
	 S6S1xh3xFY9KJ4RWxADen61W+nCtbQrn26wRF/wZhzeJRILatxgYD/JO70zHNJAGcO
	 rdTgCPuKs+KTU52tSH5S55BEkltL4xQO4DJzQDD4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shay Drory <shayd@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 051/137] net/mlx5: Remove redundant cmdif revision check
Date: Mon, 28 Oct 2024 07:24:48 +0100
Message-ID: <20241028062300.153487433@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
References: <20241028062258.708872330@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shay Drory <shayd@nvidia.com>

[ Upstream commit 0714ec9ea1f291447a925657e0808f34b8fbce2b ]

mlx5 is checking the cmdif revision twice, for no reason.
Remove the latter check.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Stable-dep-of: d62b14045c65 ("net/mlx5: Fix command bitmask initialization")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 465d2adbf3c00..2269f5e0e3c75 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -2216,16 +2216,15 @@ int mlx5_cmd_init(struct mlx5_core_dev *dev)
 	int align = roundup_pow_of_two(size);
 	struct mlx5_cmd *cmd = &dev->cmd;
 	u32 cmd_h, cmd_l;
-	u16 cmd_if_rev;
 	int err;
 	int i;
 
 	memset(cmd, 0, sizeof(*cmd));
-	cmd_if_rev = cmdif_rev(dev);
-	if (cmd_if_rev != CMD_IF_REV) {
+	cmd->vars.cmdif_rev = cmdif_rev(dev);
+	if (cmd->vars.cmdif_rev != CMD_IF_REV) {
 		mlx5_core_err(dev,
 			      "Driver cmdif rev(%d) differs from firmware's(%d)\n",
-			      CMD_IF_REV, cmd_if_rev);
+			      CMD_IF_REV, cmd->vars.cmdif_rev);
 		return -EINVAL;
 	}
 
@@ -2258,14 +2257,6 @@ int mlx5_cmd_init(struct mlx5_core_dev *dev)
 	cmd->vars.max_reg_cmds = (1 << cmd->vars.log_sz) - 1;
 	cmd->vars.bitmask = (1UL << cmd->vars.max_reg_cmds) - 1;
 
-	cmd->vars.cmdif_rev = ioread32be(&dev->iseg->cmdif_rev_fw_sub) >> 16;
-	if (cmd->vars.cmdif_rev > CMD_IF_REV) {
-		mlx5_core_err(dev, "driver does not support command interface version. driver %d, firmware %d\n",
-			      CMD_IF_REV, cmd->vars.cmdif_rev);
-		err = -EOPNOTSUPP;
-		goto err_free_page;
-	}
-
 	spin_lock_init(&cmd->alloc_lock);
 	spin_lock_init(&cmd->token_lock);
 	for (i = 0; i < MLX5_CMD_OP_MAX; i++)
-- 
2.43.0




