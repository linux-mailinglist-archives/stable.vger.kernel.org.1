Return-Path: <stable+bounces-1218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B537F7E91
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DF02822DB
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FDF31759;
	Fri, 24 Nov 2023 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ASGZCxA1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F542E858;
	Fri, 24 Nov 2023 18:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37257C433C8;
	Fri, 24 Nov 2023 18:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850852;
	bh=43vR9cnHiLjjKb+bXXo7kl5gnUtFLHDPe/SAdI16qR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ASGZCxA1kZV8JxSlSWcoWW8p+GilaHkCqNu6l8hH3P2Y5ujp8sLJ7xJrUrGGA7fza
	 9DvI2+omhlY7M6IRm5SXyF0gNCKHt3dWTf/8qg+GWrw2H/l841Wh/HFgOHrmEJsr0w
	 76rKJbGXnkqXfhCr3aWYq/3OpI5ZbqLFOXeC02K8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 214/491] net/mlx5e: Check return value of snprintf writing to fw_version buffer
Date: Fri, 24 Nov 2023 17:47:30 +0000
Message-ID: <20231124172030.964032335@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

[ Upstream commit 41e63c2baa11dc2aa71df5dd27a5bd87d11b6bbb ]

Treat the operation as an error case when the return value is equivalent to
the size of the name buffer. Failed to write null terminator to the name
buffer, making the string malformed and should not be used. Provide a
string with only the firmware version when forming the string with the
board id fails.

Without check, will trigger -Wformat-truncation with W=1.

    drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c: In function 'mlx5e_ethtool_get_drvinfo':
    drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c:49:31: warning: '%.16s' directive output may be truncated writing up to 16 bytes into a region of size between 13 and 22 [-Wformat-truncation=]
      49 |                  "%d.%d.%04d (%.16s)",
         |                               ^~~~~
    drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c:48:9: note: 'snprintf' output between 12 and 37 bytes into a destination of size 32
      48 |         snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      49 |                  "%d.%d.%04d (%.16s)",
         |                  ~~~~~~~~~~~~~~~~~~~~~
      50 |                  fw_rev_maj(mdev), fw_rev_min(mdev), fw_rev_sub(mdev),
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      51 |                  mdev->board_id);
         |                  ~~~~~~~~~~~~~~~

Fixes: 84e11edb71de ("net/mlx5e: Show board id in ethtool driver information")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6d4ab2e97dcfbcd748ae71761a9d8e5e41cc732c
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c    | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 3d2d5d3b59f0b..bd3fabb007c94 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -43,12 +43,17 @@ void mlx5e_ethtool_get_drvinfo(struct mlx5e_priv *priv,
 			       struct ethtool_drvinfo *drvinfo)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
+	int count;
 
 	strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
-	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
-		 "%d.%d.%04d (%.16s)",
-		 fw_rev_maj(mdev), fw_rev_min(mdev), fw_rev_sub(mdev),
-		 mdev->board_id);
+	count = snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
+			 "%d.%d.%04d (%.16s)", fw_rev_maj(mdev),
+			 fw_rev_min(mdev), fw_rev_sub(mdev), mdev->board_id);
+	if (count == sizeof(drvinfo->fw_version))
+		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
+			 "%d.%d.%04d", fw_rev_maj(mdev),
+			 fw_rev_min(mdev), fw_rev_sub(mdev));
+
 	strscpy(drvinfo->bus_info, dev_name(mdev->device),
 		sizeof(drvinfo->bus_info));
 }
-- 
2.42.0




