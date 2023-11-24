Return-Path: <stable+bounces-2433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F397F8427
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DAF228A7F5
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A7A1A5A4;
	Fri, 24 Nov 2023 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aXSr1y5N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B327031748;
	Fri, 24 Nov 2023 19:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EF5C433C8;
	Fri, 24 Nov 2023 19:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853870;
	bh=4RPMb0zQAwtATBLdpowhXs60qfOn51X4D+oTl89reJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXSr1y5NXr4G6MqosJxR0XdJMETrr//YEzhBh6FXVrvPv2y1ppGNvrXVaRku8uRZ2
	 UjnIXfc/h6BcDPy6GNM9MACVN+f4YC/snsSv3adBTBfXzFkkNMMioZCSukIUt6kF4b
	 WzkxteF9TH/zSUuHw6I7d4W3gBhcKv+pEfn00ly0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 063/159] net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors
Date: Fri, 24 Nov 2023 17:54:40 +0000
Message-ID: <20231124171944.560921705@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171941.909624388@linuxfoundation.org>
References: <20231124171941.909624388@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

[ Upstream commit 1b2bd0c0264febcd8d47209079a6671c38e6558b ]

Treat the operation as an error case when the return value is equivalent to
the size of the name buffer. Failed to write null terminator to the name
buffer, making the string malformed and should not be used. Provide a
string with only the firmware version when forming the string with the
board id fails. This logic for representors is identical to normal flow
with ethtool.

Without check, will trigger -Wformat-truncation with W=1.

    drivers/net/ethernet/mellanox/mlx5/core/en_rep.c: In function 'mlx5e_rep_get_drvinfo':
    drivers/net/ethernet/mellanox/mlx5/core/en_rep.c:78:31: warning: '%.16s' directive output may be truncated writing up to 16 bytes into a region of size between 13 and 22 [-Wformat-truncation=]
      78 |                  "%d.%d.%04d (%.16s)",
         |                               ^~~~~
    drivers/net/ethernet/mellanox/mlx5/core/en_rep.c:77:9: note: 'snprintf' output between 12 and 37 bytes into a destination of size 32
      77 |         snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      78 |                  "%d.%d.%04d (%.16s)",
         |                  ~~~~~~~~~~~~~~~~~~~~~
      79 |                  fw_rev_maj(mdev), fw_rev_min(mdev),
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      80 |                  fw_rev_sub(mdev), mdev->board_id);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: cf83c8fdcd47 ("net/mlx5e: Add missing ethtool driver info for representors")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6d4ab2e97dcfbcd748ae71761a9d8e5e41cc732c
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Link: https://lore.kernel.org/r/20231114215846.5902-16-saeed@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index e150d9fbd2ce1..ed37cc7c9ae00 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -71,13 +71,17 @@ static void mlx5e_rep_get_drvinfo(struct net_device *dev,
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5_core_dev *mdev = priv->mdev;
+	int count;
 
 	strlcpy(drvinfo->driver, mlx5e_rep_driver_name,
 		sizeof(drvinfo->driver));
-	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
-		 "%d.%d.%04d (%.16s)",
-		 fw_rev_maj(mdev), fw_rev_min(mdev),
-		 fw_rev_sub(mdev), mdev->board_id);
+	count = snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
+			 "%d.%d.%04d (%.16s)", fw_rev_maj(mdev),
+			 fw_rev_min(mdev), fw_rev_sub(mdev), mdev->board_id);
+	if (count == sizeof(drvinfo->fw_version))
+		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
+			 "%d.%d.%04d", fw_rev_maj(mdev),
+			 fw_rev_min(mdev), fw_rev_sub(mdev));
 }
 
 static void mlx5e_uplink_rep_get_drvinfo(struct net_device *dev,
-- 
2.42.0




