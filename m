Return-Path: <stable+bounces-8939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B428A820588
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A5D1F22624
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232C379E0;
	Sat, 30 Dec 2023 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cTxBB0mO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E109179CD;
	Sat, 30 Dec 2023 12:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653B5C433C7;
	Sat, 30 Dec 2023 12:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703938154;
	bh=xS6Ps9f3hsDO/HTRcOCOX3+D/7wM5iNuxgfyVHeCXd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cTxBB0mOhGbfaGJycqEFeusc+EHt4JMo3vRseMEeaKuGGU+BKQdqswOLpZblsPzFO
	 24zOXKu1BUMTMsBw219N2ZolIQHRWz5wlaQT0TozUJAPL1+WFVR19lXJrzKESSdawf
	 5WcDXIEVjMX695ABL49f4rUd8OfV4vg/uawW721U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 024/112] net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors
Date: Sat, 30 Dec 2023 11:58:57 +0000
Message-ID: <20231230115807.535997993@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115806.714618407@linuxfoundation.org>
References: <20231230115806.714618407@linuxfoundation.org>
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

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

[ Upstream commit b13559b76157de9d74f04d3ca0e49d69de3b5675 ]

snprintf returns the length of the formatted string, excluding the trailing
null, without accounting for truncation. This means that is the return
value is greater than or equal to the size parameter, the fw_version string
was truncated.

Link: https://docs.kernel.org/core-api/kernel-api.html#c.snprintf
Fixes: 1b2bd0c0264f ("net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 2653cb96c3105..5aeca9534f15a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -76,7 +76,7 @@ static void mlx5e_rep_get_drvinfo(struct net_device *dev,
 	count = snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
 			 "%d.%d.%04d (%.16s)", fw_rev_maj(mdev),
 			 fw_rev_min(mdev), fw_rev_sub(mdev), mdev->board_id);
-	if (count == sizeof(drvinfo->fw_version))
+	if (count >= sizeof(drvinfo->fw_version))
 		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
 			 "%d.%d.%04d", fw_rev_maj(mdev),
 			 fw_rev_min(mdev), fw_rev_sub(mdev));
-- 
2.43.0




