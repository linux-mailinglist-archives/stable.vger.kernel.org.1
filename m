Return-Path: <stable+bounces-85840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3905799EA70
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0E11C22C9A
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920491E378F;
	Tue, 15 Oct 2024 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rtKTYtdb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD891C07F0;
	Tue, 15 Oct 2024 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996865; cv=none; b=KEyvQohV+nqW++jfy0t+lkIKTPlLsLv9HyVZ6C8GDhSeykfe1tnp2LUsBYea+291pxr3ci/STlMg2Uqzt1zhUlHcszCv3M0i6GoEWJ7pjPoWUKmtSuGYF/l2Tulw0W5/clHs+WwPrfLnYb78lqOZfGz2yq+1PGyOIROoioS67TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996865; c=relaxed/simple;
	bh=NuXCWjD+svSxOGb7MXNqa7ub96L6zvAqhjzb6TDMN8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=az8/WLisk3IxgynSvGaU6mMDvkaYns1LrV12KBMhRdCxASO2JDJEBOgnO0SKY+DZVwkazCbLTBNqeg4NLU2VxQD+hknR9Kt/iU/UxhmohF/wI729RN+3Z+214u/9Jelu6BbNtqwhh03m+JSTH8F1mGzzRISSrBpaIawXHyyegYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rtKTYtdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B7CC4CEC6;
	Tue, 15 Oct 2024 12:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728996865;
	bh=NuXCWjD+svSxOGb7MXNqa7ub96L6zvAqhjzb6TDMN8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rtKTYtdbfCZd34Cp4XWY7f9q3l0IuyP4G3KU/r96xa2yJQI/U929Jfqsh8jxj+snX
	 wSBOrCBYUnvT8XlfnIiL5DCgXGZthH/vFOWlqraglFBeVpJiHGQKNWVIUz5t7RGs7N
	 9O1RA+0ArSfI1coRpwmjo7wnY+WVBoL7Z5rmYZko=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shahar Shitrit <shshitrit@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 021/518] net/mlx5e: Add missing link modes to ptys2ethtool_map
Date: Tue, 15 Oct 2024 14:38:45 +0200
Message-ID: <20241015123917.815441318@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shahar Shitrit <shshitrit@nvidia.com>

[ Upstream commit 7617d62cba4a8a3ff3ed3fda0171c43f135c142e ]

Add MLX5E_1000BASE_T and MLX5E_100BASE_TX to the legacy
modes in ptys2legacy_ethtool_table, since they were missing.

Fixes: 665bc53969d7 ("net/mlx5e: Use new ethtool get/set link ksettings API")
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 1fdb42899a9f..1e61f31a689a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -127,6 +127,10 @@ void mlx5e_build_ptys2ethtool_map(void)
 				       ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT);
 	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_100GBASE_LR4, legacy,
 				       ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT);
+	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_100BASE_TX, legacy,
+				       ETHTOOL_LINK_MODE_100baseT_Full_BIT);
+	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_1000BASE_T, legacy,
+				       ETHTOOL_LINK_MODE_1000baseT_Full_BIT);
 	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_10GBASE_T, legacy,
 				       ETHTOOL_LINK_MODE_10000baseT_Full_BIT);
 	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_25GBASE_CR, legacy,
-- 
2.43.0




